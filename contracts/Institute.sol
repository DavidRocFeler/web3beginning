// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract Institute {
    mapping(address => uint8[]) studentMarks;
    address markAdmin;
    event MarkAdded (address indexed student, uint8 mark);

    constructor(address newMarkAdmin) {
        markAdmin = newMarkAdmin;
    }

    modifier isMarkAdmin() {
        require(msg.sender == markAdmin, "not the mark admin");
        _;
    }

    function addMark (address student, uint8 mark) external isMarkAdmin {
        studentMarks[student].push(mark);
    }

    function isStudent(address student) public view returns (bool) {
        return (studentMarks[student].length > 0);
    }

    function markAvg(address student) external view returns (uint8) {
        require(isStudent(student), "Not is a student");
        uint8[] memory marks = studentMarks[student];
        uint8 sum;
        for(uint256 i = 0; i < marks.length; i++) {
            sum += marks[i];
        }
        return uint8(sum/marks.length);
    }
}