// SPDX-License-Identifier: MIT;

pragma solidity ^0.6.6;

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import  "@uniswap/v2-periphery/contracts/libraries/UniswapV2Library.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract YFOXswap {
   
   address internal constant UNISWAP_ROUTER_ADDRESS = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D; 
   address internal constant factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
  

   // constructor set the contract router address
   IUniswapV2Router02 internal router; 
   constructor() public {       
    // uniswap router instance
    router =  IUniswapV2Router02(UNISWAP_ROUTER_ADDRESS);  
   }
   
   // important to receive ETH fallback function
   receive() payable external {}

   // *** swap implementation ****

   // first case When YFOX as Input and ERC20 as Output

   function swapYFOXWithAnyERC20(
       uint _amountIn,
       address[] memory _tokenAddresses,
       address _swapCaller,
       uint _timeline
       ) public returns( uint[] memory amounts) {
           require(_amountIn > 0, "YFOXswap : invalid input amount");
           (uint reserveIn, uint reserveOut) = UniswapV2Library.getReserves(factory, _tokenAddresses[0],_tokenAddresses[1]);
           // calculate getAmountsOut
            amounts = UniswapV2Library.getAmountsOut(_amountIn,_tokenAddresses);
           // now call the UniswapV2Router02::swapExactTokensForTokens
           router.swapExactTokensForTokens(
               _amountIn,
               amounts[amounts.length - 1],
               _tokenAddresses,
               _swapCaller,
               _timeline
           );



   }

   // second case When YFOX as Output and ERC20 as Input

   function swapAnyERC20WithYFOX(
       uint _amountOut,
       address[] memory _tokenAddresses,
       address _swapCaller,
       uint _timeline
       ) public returns( uint[] memory amounts) {
           require(_amountOut > 0, "YFOXswap : invalid output amount");
           (uint reserveIn, uint reserveOut) = UniswapV2Library.getReserves(factory, _tokenAddresses[0],_tokenAddresses[1]);
           // calculate getAmountsOut
           amounts = UniswapV2Library.getAmountsIn(_amountOut,_tokenAddresses);
           // now call the UniswapV2Router02::swapExactTokensForTokens
           router.swapTokensForExactTokens(
               _amountOut,
               amounts[0],
               _tokenAddresses,
               _swapCaller,
               _timeline
           );
   }

   // All Possible cases to Swap Eth and Reverse Also

   //  case 1 swap ether when user entered input ether amount on Input Param call this func on frontend.
   function swapInputETHForYFOX(
       address[] calldata  _tokenAddresses,
       uint _timeline
   ) 
   external 
   payable 
   returns( uint[] memory amounts) {
       require(msg.value > 0, "YFOXswap : Invalid ETH");
       require(_tokenAddresses[0] != router.WETH(),"YFOXswap: Invalid Input Address");
       (uint reserveIn, uint reserveOut) = UniswapV2Library.getReserves(factory, _tokenAddresses[0],_tokenAddresses[1]);
       
        amounts = UniswapV2Library.getAmountsOut(msg.value,_tokenAddresses);
        router.swapExactETHForTokens{value: msg.value}(
            amounts[_amounts.length - 1],
            _tokenAddresses,
            msg.sender,
            _timeline            
       );    
   }

   //  case2 swap ether when user entered yfox as input amount and getAmountsIn
   function swapOutputETHForYFOX(
       uint _yfoxAmount,
       address[] calldata  _tokenAddresses,
       uint _timeline
   ) 
   external 
   payable 
   returns( uint[] memory amounts) {
       require(msg.value > 0, "YFOXswap : Invalid ETH");
       require(_tokenAddresses[0] != router.WETH(),"YFOXswap: Invalid Input Address");
       (uint reserveIn, uint reserveOut) = UniswapV2Library.getReserves(factory, _tokenAddresses[0],_tokenAddresses[1]);
       
         amounts = UniswapV2Library.getAmountsIn(msg.value,_tokenAddresses);
         amounts  = router.swapETHForExactTokens{value: amounts[0]}(
            _yfoxAmount,
            _tokenAddresses,
            msg.sender,
            _timeline            
       );    
   }

   //  case3 swap yfox when user entered yfox as input amount and getAmountsOut
   function swapInputYFOXForETH(
       uint _yfoxAmountIn,
       address[] calldata  _tokenAddresses,
       uint _timeline
   ) 
   external
   returns( uint[] memory amounts) {
       require(msg.value > 0, "YFOXswap : Invalid ETH");
       require(_tokenAddresses[1] != router.WETH(),"YFOXswap: Invalid Input Address");
       (uint reserveIn, uint reserveOut) = UniswapV2Library.getReserves(factory, _tokenAddresses[0],_tokenAddresses[1]);
       
         amounts = UniswapV2Library.getAmountsOut(_yfoxAmountIn,_tokenAddresses);
         router.swapExactTokensForETH(
            _yfoxAmountIn,
            amounts[1],
            _tokenAddresses,
            msg.sender,
            _timeline            
       );    
   }

   //  case 4 swap yfox when user entered yfox as output amount and getAmountsIn
   function swapOutputYFOXForETH(
       uint _yfoxAmountOut,
       address[] calldata  _tokenAddresses,
       uint _timeline
   ) 
   external 
   returns( uint[] memory amounts) {
       require(msg.value > 0, "YFOXswap : Invalid ETH");
       require(_tokenAddresses[1] != router.WETH(),"YFOXswap: Invalid Input Address");
       (uint reserveIn, uint reserveOut) = UniswapV2Library.getReserves(factory, _tokenAddresses[0],_tokenAddresses[1]);
       
        amounts = UniswapV2Library.getAmountsIn(_yfoxAmountOut,_tokenAddresses);
        router.swapExactTokensForETH(
            _yfoxAmountOut,
            amounts[0],
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
       require(_token0 != address(0), "YFOXswap: wut?");
       require(_token1 != address(0), "YFOXswap: wut?");
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
   ) public payable returns (uint amountToken, uint amountETH, uint liquidity) {
       require(_poolToken != address(0), "YFOXswap: wut?");
       (amountToken,amountETH,liquidity) = router.addLiquidityETH{value: msg.value}(
           _poolToken,
           _amountTokenDesired,
           1,
           1,
           msg.sender,
           _timeline
       );

   }

   // removeLiquidity of any erc20 by giving liquidity amount and tokenDetails

   function removeLiquidityFromPoolsWithPermit(
  address _token0,
  address _token1,
  uint _liquidity,
  address _caller,
  uint _timeline,
  bool approveMax, uint8 v, bytes32 r, bytes32 s
   ) public returns (uint amountA, uint amountB) {
        require(_token0 != address(0), "YFOXswap: wut token0 ?");
       require(_token1 != address(0), "YFOXswap: wut token1 ?");
       (amountA, amountB) = router.removeLiquidityWithPermit(
           _token0,
           _token1,
           _liquidity,
           1,
           1,
           _caller,
           _timeline,
           false,
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
  bool approveMax, uint8 v, bytes32 r, bytes32 s
   ) public returns (uint amountA, uint amountB) {
        require(_token0 != address(0), "YFOXswap: wut token0 ?");
       require(_token1 != address(0), "YFOXswap: wut token1 ?");
       (amountA, amountB) = router.removeLiquidityWithPermit(
           _token0,
           _token1,
           _liquidity,
           1,
           1,
           _caller,
           _timeline,
           false,
           v,
           r,
           s
       );   
   }

}