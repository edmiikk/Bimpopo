<h1>Fe-lang developer diary</h1>

<h2>January 23rd</h2>

Surfed [ethereum.org](https://blog.ethereum.org/2022/12/29/supported-teams-roundup-22) while waiting for the interminable KZG ceremony to stop rotating (washing machines at least have changes of direction).
Fe-lang warranted a closer look. Laudable aims given that contracts wear no clothes.

<h2>January 27th</h2>

The guest_book.fe compiles. A journey of a thousand lines begins with but a single ~class~ contract.
Deployment roadblock. Could not get nix to install dapp-tools. Suffer modest drop in self-esteem. Side quests can be hard.

<h2>February 1st</h2>

It works. Flakes were the key: 

<shell>
$ cat /etc/nix/nix.conf<br>
	experimental-features = nix-command flakes</code><br>
	build-users-group = nix-users<br> 
$ sudo apt-get install jq<br>
$ nix-env -iA dapp -f $(curl -sS https://api.github.com/repos/dapphub/dapptools/releases/latest | jq -r .tarball_url) <br>
</shell>

Import the Metamask private key with ethsign. Puzzle at an apparent error, it was only kidding the UTC--2023-02-01T08-14-18.380291756Zxxx file is there in .ethereum/keystore all along. No time to dwell, back onto familiar ground some progress. Use an old Infura project for the EL, and contract created.
 
Try to call the contract for that sweet "Hello World" moment but only emptiness. I have done something WRONG.

Yes - did not heed the warning on using an account with mainnet funds. This time only a five dime poorer cut and paste victim.

Solution: <code>https://mainnet.infura.io/v3/###### -> https://goerli.infura.io/v3/######</code> (görli ist verboten) <br>
Result confirms that I ,sorry, we <3 Fe. Self esteem increments. 

Time for the fledgling Fe apprentice to exit the nest. I shall think globally and act locally. So start project Blimpopo. Aim 1) convert OZ library to Fe and consider security, 2) get familiar with Fe syntax at the same time. Ignore disadvantages of approach. Project name is Blimp (from Zeppelin) + popo (favourate tea room in Japan; their strawberry parfait a delicious challenge after a big bowl of black ramen). Let's hope as much thought goes into the actual code.

<shell>
$ ../fe new blimpopo <br>
error: unresolved path item<br>
error: `get_42` is not defined
</shell>
I have done something WRONG. I shall quit while I'm behind. 

<h2>February 4th</h2>

Decide to use an IDE, after all this is the second decade of the new millenium. There is LSP stuff [here](https://github.com/fe-lang/fls).   
<shell>
$ rustup update<br>
$ cargo install --git https://github.com/fe-lang/fls.git<br>
$ fls --version<br>
fls 0.0.1<br>
</shell>
Am I going to cut myself on this bleeding edge release? It doesn't even have a Greek suffix.

Plugin search for IntelliJ yields two open source offerings. Look these gift horses in their mouths and move on to LSP4E [Eclipse](https://projects.eclipse.org/projects/technology.lsp4e) , [github](https://github.com/eclipse/lsp4e/). 

Watch the [video](https://www.screencast.com/t/Xs3TtaQM), well some of it anyway.

Install [Eclipse LSP4E](http://download.eclipse.org/lsp4e/releases/latest/) and follow the video. Alas a busy eclipse error log. Undeterred install [Eclipse TM4E](http://download.eclipse.org/tm4e/snapshots/). Not sure why I bother except installing new stuff is mild fun. Cup of tea and a Rich Tea biscuit whilst pouring over dense error logs that smack of IMCOMPATIBILITY. 

Download latest Eclipse. Have trouble getting sha512 to work. Hashalot is no joke. Install anyway and move on. Open main.fe. The felang LSP console shows activity. Mostly lots of symbolicating. The net effect is no effect. Same plain monochrome text. Side quest over. 

<h2>February 5th</h2>

Examine the "*error: unresolved path item*" build error from  before. Place the logic.fe file in various places in the project folder. Too easy. Look at the [Fe guide](https://fe-lang.org/docs/index.html). Searching for 'use'. Too many uses. 

Clone [Bountiful](https://github.com/fe-lang/bountiful). The zero byte main.fe looked like an interrupted cloning. More fool me - it is supposed to be empty. It builds without error oink oink. 

Must be something to do with packaging or paths. Further insight eludes. 

Must be something to do with packaging or paths. Further insight eludes. Decide not to post newbie bleat in Discord. Wait until something worth contributing.

<h2>February 6th</h2>
Clone [HardHatFe](https://github.com/fe-lang/hardhat-fe/). Inside is [comiple.js](https://github.com/fe-lang/hardhat-fe/blob/main/src/compile.ts) :
<code>
&nbsp;&nbsp;function isIngotProject(files: string[]): [boolean, string] {<br>
&nbsp;&nbsp;&nbsp;&nbsp;for (const file of files) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (file.endsWith("main.fe")) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return [true, file.replace("/main.fe", "")];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>
&nbsp;&nbsp;&nbsp;&nbsp;}<br>
&nbsp;&nbsp;&nbsp;&nbsp;return [false, ""];<br>
&nbsp;&nbsp;&nbsp;&nbsp;}
</code>

Ingots and project structure clue. Tried ingot:: prefix but to no avail. Perhaps looking a Rust packaging might help. Install Rust plugin. Tomorrow is another day.

<h2>February 7th</h2>

Project review. Six days, zero lines of code, some lessons. Performance rating below par.

Eclipse crashes on pasting link into markdown. Lose edit. Happens again. Report bug. Bugzilla report vectors to Github issue. Eclipse problems are disappointing. Eclipse maintainers response is fast. Looks like duplicate of [#158](https://github.com/eclipse-platform/eclipse.platform.swt/issues/158). 'Unstable on Ubuntu' does not install confidence. Revert to 2019 Eclipse without LSP4E and fls running.
 
Work on main.fe monolith until packaging mastered. Create sol contract with [OZ Bootstrap](https://www.openzeppelin.com/contracts). Include bells and whistles. Only nine imports to mainline. CLone OZ repository. Hmmmm there is a lot there. Must work harder.


<h2>February 8th</h2>

Add OZ code includes and ERC20 API to main.fe. No block comments so humbly request feature in Discord. Start adding code. Not sure where to start probably just bumble around for a bit. Add some transfer code. No event keyword so just emit the Transfer struct. Start reading through Initializable. Does felang have modifiers or not. Find out in the next exciting episode.


<h2>February 9th</h2>

Rust has traits that look suspiciously like modifiers. Felang has trait as a reserved keyword. Patience is a virtue. Answer for now to inline the initializer trait/modifier. 

EIP1967. A good year. Sgt. Pepper's released. No assembly feature. Choices. Well YUL might be possible. Float idea to look at unoptimised YUL from a Solidity compile. Weave YUL into Felang output. Yeah really. A mite complicated. Leave the proxy for now and Move On. 

Going through Initializer.sol code see a constructor. Felang has no "constructor". Find Pythonesque <code>fn `_`_init`_`_() </code> They snaked in  Python. Fe wants it pub. Not sure 'bout that.

Inspired by Leon hot chocolate with oat milk. Find keccak256() exists. Why ever doubt it. Compiler says: <code>error: feature not yet implemented: contract field initial value assignment</code>. I am touching the envelope. Move role inits to constructor, beg your pardon, <code>`_`_init`_`_() </code>.

Twenty eight lines of Fe code. Not all of 'em are a solitary curly brackets. Good day. 

<h2>February 10th</h2>

Submit first issue. #845. Use RUST_BACKTRACE=full for the first time. 
Response to humble block quote feature is a request to provide a use case. Hmmmm. Notice that comments are sparse to non-existent in the example sources. Perhaps it's a Rust thing. 

<h2>February 13th</h2>

Start implementing roles. Compiler kindly informs that variable and struct are akin to oil and water. On the bright side discover type aliasing. Define bytes32 as a u256. "This will have consequences" says a barely audible voice.

Look for extcodesize() for the initializer caller check. Hard to discern supported functions like keccak256 from unsupported ones. Clone fe compiler. Cannot find the answer there.  TODO it and Move On.

<h2>February 14th</h2>

About to submit second issue. Check if it is manifestly a morph of the first. The full backtrace is practically identical. That is not saying much. Only two sparse lines of code paths. Cancel submit.

Solution to the struct and <code> struct {mapping(address => bool) members }</code> porting problem. Degeneralise the role abstract contract. First match ~switch~ statement - yeah!. 

Match statement refactored into iffiness. No dynamic comparators. Unfair expectations again.

Nearly complete role port. Role playing time. Too late for an Aluadidid to compose test cases. First role - sleeper. 

<h2>February 15th</h2>

Project review. main.fe is now 536 lines. Lexical analysis would reveal magority start with //, next come blank lines. The raked white gravel surrounding the compiler significant stones. 

Add dummy ERC20 fns. Look for a test env. Dislike of js leads to [Foundry](https://github.com/foundry-rs).  Side quest. Enhance Foundry with fe capability.

<shell>
$ cd ~/tools
$ mkdir foundry<br>
$ cd !$<br>
$ curl -L https://foundry.paradigm.xyz | bash<br>
$ source ~/.bashrc<br>

$ foundryup



.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx
 
 ╔═╗ ╔═╗ ╦ ╦ ╔╗╔ ╔╦╗ ╦═╗ ╦ ╦         Portable and modular toolkit\
 ╠╣  ║ ║ ║ ║ ║║║  ║║ ╠╦╝ ╚╦╝    for Ethereum Application Development\
 ╚   ╚═╝ ╚═╝ ╝╚╝ ═╩╝ ╩╚═  ╩                 written in Rust.\

.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx

Repo       : https://github.com/foundry-rs/<br>
Book       : https://book.getfoundry.sh/<br>
Chat       : https://t.me/foundry_rs/ <br> 
Support    : https://t.me/foundry_support/<br>
Contribute : https://github.com/orgs/foundry-rs/projects/2/<br>


.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx

foundryup: installing foundry (version nightly, tag nightly-1a56901636de10523cd49494ede5b545954bfdcf)<br>
foundryup: downloading latest forge, cast, anvil, and chisel<br>
################################################################################################################# 100.0%<br>
foundryup: downloading manpages<br>
################################################################################################################# 100.0%<br>
foundryup: installed - forge 0.2.0 (1a56901 2023-02-15T00:03:56.44915148Z)<br>
foundryup: installed - cast 0.2.0 (1a56901 2023-02-15T00:03:56.44915148Z)<br>
foundryup: installed - anvil 0.1.0 (1a56901 2023-02-15T00:04:36.717767498Z)<br>
foundryup: installed - chisel 0.1.1 (1a56901 2023-02-15T00:04:36.642948552Z)<br>

foundryup: done

$ forge init Blimpopo

Initializing /home/fredagarb/tools/foundry/Blimpopo...

Installing forge-std in "/home/fredagarb/tools/foundry/Blimpopo/lib/forge-std" (url: Some("https://github.com/foundry-rs/forge-std"), tag: None)

    Installed forge-std v1.4.0
    
    Initialized forge project.
</shell>

Learn with [foundry-play](https://github.com/PatrickAlphaC/foundry-play). $ make. Get <shell>fatal: Needed a single revision</shell> Delete <code>branch = v4.8.1</code> from .gitmodules. Result: <shell>$ forge update</shell> no fatal error. Remove solc task. We has a solc already. Ha ha. <shell> $ forge build </shell> installs another one anyway. Note <shell>--optimize-runs</shell> is now <shell>--optimizer-runs</shell> 

Anvil does the account creation. Forge creates StakeCreate. Anvil deploys it. Think I am going to like this Foundry thing.

Cloned foundry. An eight minute build first time. Pulls in alot of stuff. Side quest piffle, it's a gear-gated multi-boss end game dungeon.

<h2>February 16th</h2>

Join the Foundry channel. Mispell handle. Oh well - in good company. Serious dialogue going on. Arbitrum gas fee calculations and the like. 

<h2>February 17th</h2>

Until Foundry dungeon conquered start testing with Anvil, Dapptools, shell scripts. Write test document v0.0.1. 
Look to replicate ds-test.sol. Composition way vs inheritance way. Yet to meet my Gilberte either way. Finally solve ingots path puzzle.  Bountiful example plus fe compiler source clues. Self esteem elevation.  

<h2>February 18th</h2>

Contribution time. Update new.rs for ingots. Uphill struggle on nested file copy hill. Flaky Rust diagnosis. Memo to self - learn Rust properly.

<h2>February 19th</h2>

Self improvement day. [Rust the book!](https://doc.rust-lang.org/book/). Miss the pleasure in opening an O'Reilly tome for the first time. 

Lesson #1. No tabs please. Thumbs up to thumbs down, down, down, down. Learn about "The Great Bikeshed of 2008". No styling complete without a bikeshed or two.

Lesson #2. Cargo.toml: edition = "2021". That is so last last year. 

Lesson #3: Shadows. A rose is not a rose by the same name.

Lesson #4. Scope. Outside a loop a let mut is fixed after first use. Statement order gotchas. 

Long time no lets. Memories of Dartmouth Basic on a teletype.   

<h2>February 20th</h2>

To create() or create2(). The essence of mockery.  

Project review. More crates, dstest.fe ongoing. Rust buff. All in all not bad. 

<h2>February 21st</h2>

Snakify functions. No guessing which house rustaceans would sort into. 
ethsign does not like Anvil private keys. Puzzle over this. Foundry support post about create a contract with felang binary. Answer is to send as a transaction payload with a to address of 0. Thanks to cosdy for a rapid reply. 

<h2>February 22nd</h2>

Rust on the train. Heap and stack and copy and move. Could be a exercise sequence.

<h2>February 23rd</h2>

Ready to cast off. First need some binary. Cargo build solc-backend feature. Wow that takes a long time, C++ Boost loads o' work. 

<h2>February 24th</h2>

Writing test grind. Tests in <code>/_/_init/_/_</code> not good. Initiate tests with calls.

<h2>February 27th</h2>

Nothing like finding a compiler bug to blow away Monday blues. 

On the other hand error text in blood red letters = cause for concern:

<shell>

export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

export CONTRACT=0x5FbDB2315678afecb367f032d93F642f64180aa3

cast call --private-key $PRIVATE_KEY  $CONTRACT "run_tests()"


<span style="color: #880808;">
(code: 3, message: execution reverted: Initializable: contract is already initialized, data: Some(String("0x08c379a00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000002e496e697469616c697a61626c653a20636f6e747261637420697320616c726561647920696e697469616c697a6564000000000000000000000000000000000000")))
</span>

</shell>

Admire the lonely two amongst a lot of nothing. What the heck does this Some String mean? Side quest alert. 


<h2>February 28th</h2>

Every bug submitted was already fixed. Clone upcoming version. Use this v2 from now on. Now contract bin has gone down from 18,458 bytes to 18,060 bytes. That is more than 2% less. Progress of sorts.  

Bizarre incident. Create test runner contract fails.
<shell>

$ ./cast_send_create_test_runner.sh 

Error: 
<span style="color: #880808;">
(code: -32003, message: Out of gas: required gas exceeds allowance: 2000000000000, data: None)
</span>
</shell>

Anvil:

<code>

Gas Limit

==================

 <span style="color: green;"> 30000000000 </span>

Genesis Timestamp

==================

<span style="color: green;">1677582871</span>

Listening on 127.0.0.1:8545
eth_chainId<br/>
eth_getTransactionCount<br/>
eth_getBlockByNumber<br/>
eth_feeHistory<br/>
eth_estimateGas<br/>

</code>


Anvil says too much gas, a whole parliament's worth. Increased anvil limit to max - still not enough. Only added one ctx.emit statement, honestly gov. Have I done something WRONG? Repeated edits while deciding where the issue is -> problem gone away. Miffed. That looked interesting. 

Less interesting is the ctx.emit that silently fails. Something to do with Emittable trait on a struct me thinks. Toss up whether to report issue or not. 

Meanwhile decide to implement a Strings.sol library equivalent. Reason -> you shall emit Strings and nothing but Strings. Run into fixed length String declaration. Scratch head. No light bulb sensation. 

<h2>March 1st</h2>

Metereological Spring. They must have a sense of humour these ologists.
 
Read release notes. Buried treasure. Discover std::evm::* unlocks unsafe goodies. 

Progress review: test_runner.bin is 19,790 bytes. Gas to deploy it: 2150670 Gwei. 

Troubles: tribbles==false && emits==true. Anvil does not show them. Why oh why. Try all sorts. Match kick-off saves further wall banging. 

<h2>March 2nd</h2>

Chasing emit problem. Found this anvil output:

<shell>

eth_chainId<br/>
eth_call<br/>
************************** Start Tests **************************<br/>
Error: Assertion Failed condition is false

</shell>

Confirms that event logs did work. Am not going ga-ga. Relief.

First look into Anvil. Need way to interact. Create ethers Rust project.  
