Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.b-c-s.net ([5.9.129.203]:51614 "EHLO mail.b-c-s.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbeCZPXw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Mar 2018 11:23:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.b-c-s.net (Postfix) with ESMTP id 9FAFB54D
        for <linux-block@vger.kernel.org>; Mon, 26 Mar 2018 17:17:06 +0200 (CEST)
Received: from mail.b-c-s.net ([127.0.0.1])
        by localhost (mail.b-c-s.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2ahwUAL6X-QE for <linux-block@vger.kernel.org>;
        Mon, 26 Mar 2018 17:17:06 +0200 (CEST)
Received: from [10.110.40.82] (xd527a15c.dyn.telefonica.de [213.39.161.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: carsten@b-c-s.de)
        by mail.b-c-s.net (Postfix) with ESMTPSA id 0BAFB53B
        for <linux-block@vger.kernel.org>; Mon, 26 Mar 2018 17:17:05 +0200 (CEST)
To: Linux Block <linux-block@vger.kernel.org>
From: Carsten Burkhardt <c.burkhardt@b-c-s.de>
Subject: DRBD inconsistent - out of sync issue
Message-ID: <0b56b719-b722-8fd3-e417-16493a4ec908@b-c-s.de>
Date: Mon, 26 Mar 2018 17:17:05 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000802090303090505000805"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000802090303090505000805
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello,

DRBD get out of sync if the buffer is been modified during write operatio=
ns.

The testcase, the problem and a proposed solution can be found here:

https://bugzilla.kernel.org/show_bug.cgi?id=3D99171

Mit freundlichen Gr=C3=BC=C3=9Fen

Carsten Burkhardt


--------------ms000802090303090505000805
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CucwggT9MIID5aADAgECAhA/R0w3w0egddJnJZJr/kuVMA0GCSqGSIb3DQEBCwUAMHUxCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBD
ZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGll
bnQgQ0EwHhcNMTYwNjI5MTkxOTE0WhcNMTkwOTI5MTkxOTE0WjBEMR0wGwYDVQQDDBRjLmJ1
cmtoYXJkdEBiLWMtcy5kZTEjMCEGCSqGSIb3DQEJARYUYy5idXJraGFyZHRAYi1jLXMuZGUw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC45FBOtcNY+I1XW5nILALaWpMxccvF
1d8saFrOteMNJjcZnBkSt3NhcTrFYQerBVq6Rnj9Zzm8noMe2yyYuPJ4Tn3ooAjvQ08HVh+P
ulih1Z8D1nKY+bH1jEXm8BfkROqBN1LUdEik+muCOpTCRUFNtn04sm2+bzIsuYnxVDa3e0/o
77Nw9TGiTOCtuKgk4Q4d8itxCUx6PMYPkwn7F8JuFtUBajPl5dY2GXhrmsYxB1iZDwenmuSR
Znml+WlUuHWYUeoG5TNfphTGkm5RmKbUygAfsqxhN/B6XQHSFEZj1n/AU1+FjABc3SMTNmWT
CqjMOu6VF0M6zoWVxi9xWrqZAgMBAAGjggG4MIIBtDAOBgNVHQ8BAf8EBAMCBLAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYEFMFCk6E312bP
iLlbUSnrqIt3hXngMB8GA1UdIwQYMBaAFCSBbDlhvkkPj7cbRivJKLUnSG1oMG8GCCsGAQUF
BwEBBGMwYTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsGAQUF
BzAChi1odHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50MS5jcnQwOAYD
VR0fBDEwLzAtoCugKYYnaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDEuY3Js
MB8GA1UdEQQYMBaBFGMuYnVya2hhcmR0QGItYy1zLmRlMCMGA1UdEgQcMBqGGGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tLzBHBgNVHSAEQDA+MDwGCysGAQQBgbU3AQIFMC0wKwYIKwYBBQUH
AgEWH2h0dHBzOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kwDQYJKoZIhvcNAQELBQADggEB
AKbdUleO7BkRCJzrWQLoHSWF3ogqCC7p8StCE1rtGRpuszqMF3WggelpLsQIS7/Lz7ukgxea
aqTRhDX5h7oTdvHfdYZsOdKOI6HLL6D0OP92tlUPMVXCiF2/Sqi20nE4xXqbARaFUxST1Sgc
WzbT2YtOp7us+//UnHku8i7IRUjPPYr8H8i4pzNH2DbHNRYJVtzxsJCgdt7gZh4h97gG4DjQ
lnmcbt7xSw8FWEO0uTmHSfBTysemYEzY/dSN+0BNNyrrwmGvkPa63/YoS+9k3OGYUTByGiGM
qbSKNCenth4+cw84Ke9MqVi7BCSIP9Wqb421riW9vO8M75nwG7vY/fIwggXiMIIDyqADAgEC
AhBrp4p9CteI1lEK+Vnk57ThMA0GCSqGSIb3DQEBCwUAMH0xCzAJBgNVBAYTAklMMRYwFAYD
VQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0
ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAe
Fw0xNTEyMTYwMTAwMDVaFw0zMDEyMTYwMTAwMDVaMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQK
Ew1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhv
cml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQC9fdr3w6J9g/Zbgv3bW1+uHht1wLUZr5gkrLtXedg17Ake
fMyUGwrQdvwObhajcVmnKVxhrUwkZPXRAwZZosRHfEIi5FH7x6SV/8Sp5lZEuiMnvMFG2MzL
A84J6Ws5T4NfXZ0qn4TPgnr3X2vPVS51M7Ua9nIJgn8jvTra4eyyQzxvuA/GZwKg7VQfDCmC
S+kICslYYWgXOMt2xlsSslxLce0CGWRsT8EpMyt1iDflSjXZIsE7m1uTyHaKZspMLyIyz6my
Su8j8BWWHpChNNeTrFuhVfrOAyDPFJVUvKZCLKBhibTLloyy+LatoWELrjdI4a8StZY8+dIR
9t4APXGzAgMBAAGjggFkMIIBYDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0lBBYwFAYIKwYBBQUH
AwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwMgYDVR0fBCswKTAnoCWgI4YhaHR0
cDovL2NybC5zdGFydHNzbC5jb20vc2ZzY2EuY3JsMGYGCCsGAQUFBwEBBFowWDAkBggrBgEF
BQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDAGCCsGAQUFBzAChiRodHRwOi8vYWlh
LnN0YXJ0c3NsLmNvbS9jZXJ0cy9jYS5jcnQwHQYDVR0OBBYEFCSBbDlhvkkPj7cbRivJKLUn
SG1oMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mHMMo0aEPQQa7yMD8GA1UdIAQ4MDYwNAYEVR0g
ADAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kwDQYJKoZI
hvcNAQELBQADggIBAIvj94fsAYuErQ8BAluc4SMnIwS9NPBwAm5SH9uh2NCXTq7im61g7F1L
IiNI/+wq37fUuaMbz4g7VarKQTgf8ubs0p7NZWcIe7Bvem2AWaXBsxsaRTYw5kG3DN8pd1hS
EUuFoTa7DmNeFe8tiK1BrL3rbA/m48jp4AiFXgvxprJrW7izsyetOrRHPbkW4Y07v29MdhaP
v3u1JELyszXqOzjIYo4sWlC8iDQXwgSW/ntvWy2n4LuiaozlCfXl149tKeqvwlvrla2Yklue
/quWp9j9ou4T/OY0CXMuY+B8wNK0ohd2D4ShgFlMSjzAFRoHGKF81snTr2d1A7Ew02oF6UQy
CkC2aNNsK5cWOojBar5c7HplX9aHYUCZouxIeU28SONJAxnATgR4cJ2jrpmYSz/kliUJ46S6
UpVDo/ebn9c6PaM/XtDYCCaM/7XX6wc3s++sbQ7CtCn1Ax7df6ufQbwyO0V+oFa9H0KAsjHM
zcwk3EV2B2NLatidKE/m7G+rB9m+FlVgIiSp0mGlg43QO9Kh1+JqvTCIzv2bJJkmPMLQJNuK
KwHNL8F4GGp6jbAV+WL+LDeGfVcq8DHS3LrD+xyYEXQBiqZEdiPVOMxLDSUCXsDO0uCWpaNQ
8j6y6S9p0xE/Ga0peVLadVHhqf9nXqKaxnr358VgfrxzUIrvOaOjMYIDzDCCA8gCAQEwgYkw
dTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0
Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAx
IENsaWVudCBDQQIQP0dMN8NHoHXSZyWSa/5LlTANBglghkgBZQMEAgEFAKCCAhMwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwMzI2MTUxNzA1WjAvBgkq
hkiG9w0BCQQxIgQgvPRbuy37+CviGr1jkgE9GuttqVRvJYoeTGtu6/jj+LwwbAYJKoZIhvcN
AQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBmgYJKwYB
BAGCNxAEMYGMMIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkw
JwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3Rh
cnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECED9HTDfDR6B10mclkmv+S5UwgZwGCyqGSIb3DQEJ
EAILMYGMoIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYD
VQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRD
b20gQ2xhc3MgMSBDbGllbnQgQ0ECED9HTDfDR6B10mclkmv+S5UwDQYJKoZIhvcNAQEBBQAE
ggEAdB90q7l2XQZtNce9iskcAAHn8YDHqDNVtjHSiySVi4lMAUEO4D/OxItEXIozRiVqo/iN
19XaeuTqQFDyZOxpgBN8ONhLxHg8p8kunooDjkYAvd2gLhFsqgD2vpS6bN/S3qidvQVvqnic
WNo04Vs1U2rXwVlOJ3aBu0ItWknD3v4z5P7dlDeSQuPhq80KSnQkWV+VlAfYmV0F3WvdRt3a
Sf1Yth8/DWPcBV8WBgBhRzpXsFMjbbz3gCtxkom1TxiUEMwN5ebKRrO7r9zvaXgpDTYFsxJH
NR89X3LStgxIHPfvi9amVrlKsMYs1wy8I7rvoshS0fIUdB13T5N92SZg6AAAAAAAAA==
--------------ms000802090303090505000805--
