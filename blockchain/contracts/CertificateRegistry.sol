// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract CertificateRegistry {

    struct Certificate {
        string studentName;
        string course;
        string issuer;
        string certificateHash;
        uint256 issuedAt;
        address issuerWallet;
    }

    mapping(string => Certificate) private certificates;

    event CertificateIssued(
        string certificateHash,
        string studentName,
        string issuer
    );

    function issueCertificate(
        string memory _studentName,
        string memory _course,
        string memory _issuer,
        string memory _certificateHash
    ) public {

        require(
            certificates[_certificateHash].issuedAt == 0,
            "Certificate already exists"
        );

        certificates[_certificateHash] = Certificate(
            _studentName,
            _course,
            _issuer,
            _certificateHash,
            block.timestamp,
            msg.sender
        );

        emit CertificateIssued(
            _certificateHash,
            _studentName,
            _issuer
        );
    }

    function verifyCertificate(
        string memory _certificateHash
    ) public view returns (bool) {
        return certificates[_certificateHash].issuedAt != 0;
    }

    function getCertificate(
        string memory _certificateHash
    )
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            uint256,
            address
        )
    {
        Certificate memory cert = certificates[_certificateHash];

        return (
            cert.studentName,
            cert.course,
            cert.issuer,
            cert.certificateHash,
            cert.issuedAt,
            cert.issuerWallet
        );
    }
}