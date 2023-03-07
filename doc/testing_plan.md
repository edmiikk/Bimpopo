<h1>Blimpopo Testing Plan</h1>


<h2> Setup Using Forge </h2>

Use Anvil for the chain. Use Cast for creating contract and test calls.
Prequisite; port ds-test.sol to ds-test.fe. 

Deploy BlimpopoTest contract with 
<code>

$ export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

$ cast send  --private-key 	$PRIVATE_KEY --create binary_code

	blockHash               0xe6a164d5cc8c0855ddd996da87820227b3a876e19598b155ee942fd58d3bbe83
	blockNumber             2
	contractAddress         0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
	cumulativeGasUsed       1403684
	effectiveGasPrice       3885308033
	gasUsed                 1403684
	logs                    [{"address":"0x8babd6d4a43edbc06163f1f2ca2f9a62b3fada26","topics":["0x7f26b83ff96e1f2b6a682f133852f6798a09c465da95921460cefb3847402498"],"data":"0x00000000000000000000000000000000000000000000000000000000000000ff","blockHash":"0xe6a164d5cc8c0855ddd996da87820227b3a876e19598b155ee942fd58d3bbe83","blockNumber":"0x2","transactionHash":"0x58656b593bba2e7c7e0e8f0ec3144b662ca4499c79601557a2fea867afd6aed5","transactionIndex":"0x0","logIndex":"0x0","transactionLogIndex":"0x0","removed":false}]
	logsBloom               0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000004000000000000000000800000000000000400000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	root                    
	status                  1
	transactionHash         0x58656b593bba2e7c7e0e8f0ec3144b662ca4499c79601557a2fea867afd6aed5
	transactionIndex        0
	type 
</code>
  
 Anvil has the output:
 
<code>
 
	eth_sendRawTransaction
	eth_getTransactionReceipt
    Transaction: 0x58656b593bba2e7c7e0e8f0ec3144b662ca4499c79601557a2fea867afd6aed5
    Contract created: 0xe7f1725e7734ce288f8367e1bb143e90bb3f0512
    Gas used: 1403684
    Block Number: 2
    Block Hash: 0xe6a164d5cc8c0855ddd996da87820227b3a876e19598b155ee942fd58d3bbe83
    Block Time: "Fri, 24 Feb 2023 18:22:14 +0000"
	eth_getTransactionByHash
	eth_getTransactionReceipt
 
</code> 
  

<h2> Tests </h2>

 

<ul>
<li> Initializer 

</ul>

<h3> Initializer </h3>

<code>

	pub fn test_initialize(mut self, mut ctx: Context) {
		// before initialize no tokens
		let total_supply: u256 = self.bmp_token.totalSupply();
		ctx.emit(log_named_u256 (text:"Total Supply = ", a256: total_supply));
		self.t.assert_false(ctx, untruth: total_supply > 0) ;
	}
</code> 

Shell script to run test:

<code>

$ export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

$ export CONTRACT=0xe7f1725e7734ce288f8367e1bb143e90bb3f0512

$ cast call --private-key $PRIVATE_KEY  $CONTRACT "test_initialize()"

	0x

</code> 

 Anvil has the output:
 
<code>

	eth_call
	Error: Assertion Failed
 
</code> 
