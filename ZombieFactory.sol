pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // declare our event here
    event NewZombie(uint zombieId, string name, uint dna);

    // Step 1: Declare variables
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // Step 2: Create a Zombie struct with 2 properties
    struct Zombie {
        string name;
        uint dna;
    }

    // Step 3: Create an Array of zombies using the Zombie struct
    Zombie[] public zombies;

    // Step 4: Create a private function that creates zombies and populates the zombies array
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // and fire it here
        emit NewZombie(id, _name, _dna);
    }

    // Step 5: generate a random zombie dna
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // Step 6: use the random dna to create a random zombie
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
