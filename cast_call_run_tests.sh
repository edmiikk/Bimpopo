export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
export CONTRACT=0x5FbDB2315678afecb367f032d93F642f64180aa3
cast call --private-key $PRIVATE_KEY  $CONTRACT "run_tests()"


