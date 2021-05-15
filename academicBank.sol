pragma solidity ^0.6.0;

contract academicBank {
    
    // struct Student {
    //     uint studentId;
    //     string studentName;
    //     mapping(studentId => Certificate) studentCertificates;
    // }
    
    struct Certificate {
        uint certificateId;
        string issuer;
        string beneficiary;
        string issuedDate;
        string validity;
        string courseName;
        uint year;
        string specialization;
        string creditScore;  // this can be percentage, cgpa or sgpa
    }
    
    mapping(uint => Certificate) public certificateDetails;
    uint public certificateNo = 0;
    
    function issueCertificate(string memory _issuer, string memory _beneficiary, string memory _issuedDate, string memory 
    _validity, string memory _courseName, uint _year, string memory _specialization, string memory _creditScore) public returns(string memory, string memory, string memory) {
        
        certificateNo += 1;
        
        certificateDetails[certificateNo].certificateId = certificateNo;
        certificateDetails[certificateNo].issuer = _issuer;
        certificateDetails[certificateNo].beneficiary = _beneficiary;
        certificateDetails[certificateNo].issuedDate = _issuedDate;
        certificateDetails[certificateNo].validity = _validity;
        certificateDetails[certificateNo].courseName = _courseName;
        certificateDetails[certificateNo].year = _year;
        certificateDetails[certificateNo].specialization = _specialization;
        certificateDetails[certificateNo].creditScore = _creditScore;
        
        return (certificateDetails[certificateNo].beneficiary,
        certificateDetails[certificateNo].courseName,
        certificateDetails[certificateNo].creditScore);
    }
    
    function getCertificateDetails(uint _certificateNo, string memory _issuer, string memory _beneficiary, string memory _courseName)
    public returns(uint, string memory, string memory, string memory, string memory, string memory, uint, string memory, string memory) {
        
        if(keccak256(abi.encodePacked(certificateDetails[_certificateNo].issuer)) == keccak256(abi.encodePacked(_issuer)) && 
        keccak256(abi.encodePacked(certificateDetails[_certificateNo].beneficiary)) == keccak256(abi.encodePacked(_beneficiary)) &&
        keccak256(abi.encodePacked(certificateDetails[_certificateNo].courseName)) == keccak256(abi.encodePacked(_courseName)) {
            
            return (certificateDetails[_certificateNo].certificateId,  
            certificateDetails[_certificateNo].issuer,
            certificateDetails[_certificateNo].beneficiary,
            certificateDetails[_certificateNo].issuedDate,
            certificateDetails[_certificateNo].validity,
            certificateDetails[_certificateNo].courseName,
            certificateDetails[_certificateNo].year,
            certificateDetails[_certificateNo].specialization,
            certificateDetails[_certificateNo].creditScore
            );
        }
        
        
    }
    
    function certificateHash(string memory issuer, string memory beneficiary, string memory issuedDate,
    string memory validity, string memory courseName, uint year, string memory creditScore) public returns(bytes32 resultHash) {
        return keccak256(abi.encodePacked(block.difficulty, block.timestamp, issuer, beneficiary, issuedDate, validity, courseName, year,creditScore));
    }
}

// firstname + lastname + issuer + benfiary ( addhar_card) +university username 
// + issued date + valid till(date) + course name + year + university name + specialization +cgpa/credits/sgpa/precentage
