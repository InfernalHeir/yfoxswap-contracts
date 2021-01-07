// File: @uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol

 /** 
      ___           ___           ___           ___           ___           ___           ___           ___     
     |\__\         /\  \         /\  \         |\__\         /\  \         /\__\         /\  \         /\  \    
     |:|  |       /::\  \       /::\  \        |:|  |       /::\  \       /:/ _/_       /::\  \       /::\  \   
     |:|  |      /:/\:\  \     /:/\:\  \       |:|  |      /:/\ \  \     /:/ /\__\     /:/\:\  \     /:/\:\  \  
     |:|__|__   /::\~\:\  \   /:/  \:\  \      |:|__|__   _\:\~\ \  \   /:/ /:/ _/_   /::\~\:\  \   /::\~\:\  \ 
     /::::\__\ /:/\:\ \:\__\ /:/__/ \:\__\ ____/::::\__\ /\ \:\ \ \__\ /:/_/:/ /\__\ /:/\:\ \:\__\ /:/\:\ \:\__\
    /:/~~/~    \/__\:\ \/__/ \:\  \ /:/  / \::::/~~/~    \:\ \:\ \/__/ \:\/:/ /:/  / \/__\:\/:/  / \/__\:\/:/  /
   /:/  /           \:\__\    \:\  /:/  /   ~~|:|~~|      \:\ \:\__\    \::/_/:/  /       \::/  /       \::/  / 
   \/__/             \/__/     \:\/:/  /      |:|  |       \:\/:/  /     \:\/:/  /        /:/  /         \/__/  
                                \::/  /       |:|  |        \::/  /       \::/  /        /:/  /                 
                                 \/__/         \|__|         \/__/         \/__/         \/__/                     
 
 * @author Bhupendra Bisht
 * telegram: https://t.me/InfernalHeir800
 */

pragma solidity >=0.6.2;

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

// File: @uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol

pragma solidity >=0.6.2;


interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

// File: @uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol

pragma solidity >=0.5.0;

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

// File: @uniswap/v2-periphery/contracts/libraries/SafeMath.sol

pragma solidity =0.6.6;

// a library for performing overflow-safe math, courtesy of DappHub (https://github.com/dapphub/ds-math)

library SafeMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}

// File: @uniswap/v2-periphery/contracts/libraries/UniswapV2Library.sol

pragma solidity >=0.5.0;



library UniswapV2Library {
    using SafeMath for uint;

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'UniswapV2Library: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UniswapV2Library: ZERO_ADDRESS');
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(uint(keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f' // init code hash
            ))));
    }

    // fetches and sorts the reserves for a pair
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
        (address token0,) = sortTokens(tokenA, tokenB);
        (uint reserve0, uint reserve1,) = IUniswapV2Pair(pairFor(factory, tokenA, tokenB)).getReserves();
        (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, 'UniswapV2Library: INSUFFICIENT_AMOUNT');
        require(reserveA > 0 && reserveB > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) internal pure returns (uint amountOut) {
        require(amountIn > 0, 'UniswapV2Library: INSUFFICIENT_INPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint amountInWithFee = amountIn.mul(997);
        uint numerator = amountInWithFee.mul(reserveOut);
        uint denominator = reserveIn.mul(1000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) internal pure returns (uint amountIn) {
        require(amountOut > 0, 'UniswapV2Library: INSUFFICIENT_OUTPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint numerator = reserveIn.mul(amountOut).mul(1000);
        uint denominator = reserveOut.sub(amountOut).mul(997);
        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    function getAmountsOut(address factory, uint amountIn, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[0] = amountIn;
        for (uint i; i < path.length - 1; i++) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i], path[i + 1]);
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    function getAmountsIn(address factory, uint amountOut, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint i = path.length - 1; i > 0; i--) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i - 1], path[i]);
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts/utils/ReentrancyGuard.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor () internal {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}

// File: contracts/YFOXswap.sol

// SPDX-License-Identifier: MIT;                                
                
pragma solidity ^0.6.6;

// abstracts contracts and interfaces





contract YFOXswap is ReentrancyGuard {
   
   // router rinkeby address
   address internal constant UNISWAP_ROUTER_ADDRESS = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D; 
   
   // factory on rinkeby
   address internal constant factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
   
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
   returns( uint[] memory amounts) {
       require(msg.value > 0, "ERROR : Invalid ETH");
       require(_tokenAddresses[0] == router.WETH(),"ERROR: Invalid Input Address");
       
        amounts = router.swapExactETHForTokens{value: msg.value}(
            _amountOutMin,
            _tokenAddresses,
            msg.sender,
            _timeline            
       );    
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
   returns( uint[] memory amounts) {
       require(msg.value > 0, "ERROR : Invalid ETH");
       require(_tokenAddresses[0] == router.WETH(),"ERROR: Invalid Input Address");
      
        amounts  = router.swapETHForExactTokens{value: _amountInMax}(
            _amountOut,
            _tokenAddresses,
            msg.sender,
            _timeline            
       );    
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
   ) public payable returns (uint amountToken, uint amountETH, uint liquidity) {
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

   // get some Utility Func of @Uniswap
    
  function getReservedPoolValue(
      address _tokenA,
       address _tokenB
       ) external view returns( uint reserveA, uint reserveB) {
          (reserveA,reserveB) = UniswapV2Library.getReserves(factory,_tokenA,_tokenB); 
  }

 // get value of another token when adding Liquidity on frontend.   
  function liquidtyQuotes(
      uint _amount, 
      address[] calldata _pairs
      ) external 
         view 
         returns(uint amountB) {
      (uint reserveA,uint reserveB) = UniswapV2Library.getReserves(factory,_pairs[0],_pairs[1]);
      amountB = UniswapV2Library.quote(_amount,reserveA,reserveB);
  }  


}
