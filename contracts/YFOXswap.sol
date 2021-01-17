// SPDX-License-Identifier: MIT;                                
                
pragma solidity ^0.6.6;

// abstracts contracts and interfaces
import "./interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract YFOXswap is ReentrancyGuard {
   
   // UNISWAP V2 Rinkeby Address
   address internal constant UNISWAP_ROUTER_ADDRESS = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D; 
   
   
   // state var for router instance 
   IUniswapV2Router02 internal router; 

   // constructor set the contract router address 
   
   constructor() public { 
    // uniswap router instance
    router =  IUniswapV2Router02(UNISWAP_ROUTER_ADDRESS);  
   }
   
   // important to receive ETH fallback function
   receive() payable external {}

   // *** swap implementation ****

   /**
   *  first case When YFOX as Input and ERC20 as Output.
   **/

    function getWETHAddress() public view returns(address) {
        return router.WETH();
    }
   function swapYFOXWithAnyERC20(
       uint _amountIn,
       uint _amountOutMin,
       address[] memory _tokenAddresses,
       address _swapCaller,
       uint _timeline
       ) public returns( uint[] memory amounts) {
           require(_amountIn > 0, "ERROR: Invalid Input!");
           
           //  give access approve input token erc20 for router contract.
           require(IERC20(_tokenAddresses[0]).transferFrom(msg.sender,address(this),_amountIn), "ERROR: Can't Transact!");
           require(IERC20(_tokenAddresses[0]).approve(address(UNISWAP_ROUTER_ADDRESS),_amountIn),"ERROR: Approve Failed!");
           
           amounts = router.swapExactTokensForTokens(
               _amountIn,
               _amountOutMin,
               _tokenAddresses,
               _swapCaller,
               _timeline
           );
   }

   /**
   * second case When YFOX as Output and ERC20 as Input.
   **/ 

   function swapAnyERC20WithYFOX(
       uint _amountOut,
       uint _amountInMax,
       address[] memory _tokenAddresses,
       address _swapCaller,
       uint _timeline
       ) public returns( uint[] memory amounts) {
           require(_amountOut > 0, "ERORR: Invalid Output!");
           require(IERC20(_tokenAddresses[0]).transferFrom(msg.sender,address(this),_amountInMax), "ERROR: Can't Transact!");
           require(IERC20(_tokenAddresses[0]).approve(address(UNISWAP_ROUTER_ADDRESS),_amountInMax),"ERROR: Approve Failed!");

        amounts = router.swapTokensForExactTokens(
               _amountOut,
               _amountInMax,
               _tokenAddresses,
               _swapCaller,
               _timeline
           );
   }

   // All Possible cases to Swap Eth and Reverse Also

   //  case 1 swap ether when user entered input ether amount on Input Param call this func on frontend.
   function swapInputETHForYFOX(
       address[] calldata  _tokenAddresses,
       uint _amountOutMin,
       uint _timeline
   )
   external 
   payable
   nonReentrant() 
   returns( uint[] memory amounts) {
       require(msg.value > 0, "ERROR : Invalid ETH");
       require(_tokenAddresses[0] == router.WETH(),"ERROR: Invalid Input Address");
       
        amounts = router.swapExactETHForTokens{value: msg.value}(
            _amountOutMin,
            _tokenAddresses,
            msg.sender,
            _timeline            
       );

       // return left over eth to the user
       msg.sender.transfer(address(this).balance);    
   }

   //  case2 swap ether when user entered yfox as input amount and getAmountsIn
   function swapOutputETHForYFOX(
       uint _amountOut,
       uint _amountInMax,
       address[] calldata  _tokenAddresses,
       uint _timeline
   ) 
   external 
   payable
   nonReentrant() 
   returns( uint[] memory amounts) {
       require(msg.value > 0, "ERROR : Invalid ETH");
       require(_tokenAddresses[0] == router.WETH(),"ERROR: Invalid Input Address");
      
        amounts  = router.swapETHForExactTokens{value: _amountInMax}(
            _amountOut,
            _tokenAddresses,
            msg.sender,
            _timeline            
       );
       msg.sender.transfer(address(this).balance);    
   }

   //  case3 swap yfox when user entered yfox as input amount and getAmountsOut
   function swapInputYFOXForETH(
       uint _amountIn,
       uint _amountOutMin,
       address[] calldata  _tokenAddresses,
       uint _timeline
   ) 
   external
   returns( uint[] memory amounts) {
       require(_tokenAddresses[1] == router.WETH(),"ERROR: Invalid Input Address");

    amounts = router.swapExactTokensForETH(
            _amountIn,
            _amountOutMin,
            _tokenAddresses,
            msg.sender,
            _timeline            
       );    
   }

   //  case 4 swap yfox when user entered yfox as output amount and getAmountsIn
   function swapOutputYFOXForETH(
       uint _amountOut,
       uint _amountInMax,
       address[] calldata  _tokenAddresses,
       uint _timeline
   ) 
   external 
   returns( uint[] memory amounts) {
       require(_tokenAddresses[1] == router.WETH(),"YFOXswap: Invalid Input Address");
       require(IERC20(_tokenAddresses[0]).transferFrom(msg.sender,address(this),_amountInMax), "ERROR: Can't Transact!");
        require(IERC20(_tokenAddresses[0]).approve(address(UNISWAP_ROUTER_ADDRESS),_amountInMax),"ERROR: Approve Failed!"); 
     amounts = router.swapTokensForExactETH(
            _amountOut,
            _amountInMax,
            _tokenAddresses,
            msg.sender,
            _timeline            
       );    
   } 

   // add liquidity with anyerc20 it will automatically create a pair when its not exist.
   function addLiquidityPoolWithAnyERC20(
       address _token0,
       address _token1,
       uint _amountADesired,
       uint _amountBDesired,
       address _creator,
       uint _timeline
   ) public returns (uint amountA, uint amountB, uint liquidity) {
       require(_token0 != address(0), "ERROR: wut?");
       require(_token1 != address(0), "ERROR: wut?");
       
       require(IERC20(_token0).transferFrom(msg.sender,address(this),_amountADesired), "ERROR: Can't Transact!");
       require(IERC20(_token1).transferFrom(msg.sender,address(this),_amountBDesired), "ERROR: Can't Transact!");
       
        require(IERC20(_token0).approve(address(UNISWAP_ROUTER_ADDRESS),_amountADesired),"ERROR: Approve Failed!"); 
        require(IERC20(_token1).approve(address(UNISWAP_ROUTER_ADDRESS),_amountADesired),"ERROR: Approve Failed!"); 
       (amountA,amountB,liquidity) = router.addLiquidity(
           _token0,
           _token1,
           _amountADesired,
           _amountBDesired,
           1,
           1,
           _creator,
           _timeline
       );

   }

   // add liquidity with ETH it will automatically create a pair when its not exist. 
   function addLiquidityPoolWithETH(
       address _poolToken,
       uint _amountTokenDesired,
       uint _timeline
   ) public payable nonReentrant() returns (uint amountToken, uint amountETH, uint liquidity) {
       require(_poolToken != address(0), "YFOXswap: wut?");
       require(IERC20(_poolToken).transferFrom(msg.sender,address(this),_amountTokenDesired), "ERROR: Can't Transact!");
        require(IERC20(_poolToken).approve(address(UNISWAP_ROUTER_ADDRESS),_amountTokenDesired),"ERROR: Approve Failed!");
       (amountToken,amountETH,liquidity) = router.addLiquidityETH{value: msg.value}(
           _poolToken,
           _amountTokenDesired,
           1,
           1,
           msg.sender,
           _timeline
       );

       // return leftover ethers 
       msg.sender.transfer(address(this).balance);

   }

   // removeLiquidity of any erc20 by giving liquidity amount and tokenDetails

   function removeLiquidityFromPoolsWithPermit(
   address _token0,
   address _token1,
    uint _liquidity,
   address _caller,
   uint _timeline,
   bool _approveMax, uint8 v, bytes32 r, bytes32 s
   ) public returns (uint amountA, uint amountB) {
        require(_token0 != address(0), "ERROR: wut token0 ?");
       require(_token1 != address(0), "ERROR: wut token1 ?");
       (amountA, amountB) = router.removeLiquidityWithPermit(
           _token0,
           _token1,
           _liquidity,
           1,
           1,
           _caller,
           _timeline,
           _approveMax,
           v,
           r,
           s
       );   
   }

   // removeLiquidity of ETH by giving liquidity amount and tokenDetails

   function removeLiquidityFromETHPoolsWithPermit(
  address _poolToken,
  uint _liquidity,
  address _caller,
  uint _timeline,
  bool _approveMax, uint8 v, bytes32 r, bytes32 s
   ) public returns (uint amountToken, uint amountETH) {
        require(_poolToken != address(0), "YFOXswap: wut token0 ?");
       (amountToken, amountETH) = router.removeLiquidityETHWithPermit(
           _poolToken,
           _liquidity,
           1,
           1,
           _caller,
           _timeline,
           _approveMax,
           v,
           r,
           s
       );   
   }

}