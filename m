Return-Path: <linux-block-owner@vger.kernel.org>
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:33132 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752266AbdAHNj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Jan 2017 08:39:58 -0500
To: linux-block@vger.kernel.org
From: Martin Raiber <martin@urbackup.org>
Subject: Minimum nr_requests for blk-mq
Message-ID: <010201597e4e8c6c-4de05bba-6ea9-49dd-b572-b2ffb343437a-000000@eu-west-1.amazonses.com>
Date: Sun, 8 Jan 2017 13:39:54 +0000
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070105080902090703020001"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070105080902090703020001
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

in an effort to avoid OOMs on virtual machines with not much memory
(e.g. 1GB) I set the IO scheduler queue nr_requests to 2 (the device is
a loop device on fuse). This causes the system to deadlock (with 4.4 -
4.10). E.g. following stack trace

[ 1692.647562] Call Trace:
[ 1692.647568]  [<ffffffff8169d922>] ? __schedule+0x192/0x670
[ 1692.647571]  [<ffffffff810a489a>] ? try_to_wake_up+0x4a/0x390
[ 1692.647572]  [<ffffffff8169de36>] schedule+0x36/0x80
[ 1692.647574]  [<ffffffff816a0f85>] schedule_timeout+0x235/0x3f0
[ 1692.647576]  [<ffffffff810a4bf5>] ? wake_up_process+0x15/0x20
[ 1692.647579]  [<ffffffff810235f5>] ? xen_clocksource_get_cycles+0x15/0x=
20
[ 1692.647581]  [<ffffffff810ebf2c>] ? ktime_get+0x3c/0xb0
[ 1692.647583]  [<ffffffff8169d724>] io_schedule_timeout+0xa4/0x110
[ 1692.647587]  [<ffffffff813a9fdc>] bt_get.isra.6+0x10c/0x1a0
[ 1692.647589]  [<ffffffff810bc210>] ? wake_atomic_t_function+0x70/0x70
[ 1692.647590]  [<ffffffff813aa307>] blk_mq_get_tag+0x27/0x90
[ 1692.647592]  [<ffffffff813a5b70>] __blk_mq_alloc_request+0x20/0x230
[ 1692.647594]  [<ffffffff813a69fe>] blk_mq_map_request+0xbe/0x140
[ 1692.647595]  [<ffffffff813a8c68>] blk_sq_make_request+0xb8/0x4a0
[ 1692.647598]  [<ffffffff8139a727>] ?
generic_make_request_checks+0x217/0x540
[ 1692.647600]  [<ffffffff8139ceb0>] generic_make_request+0xd0/0x1a0
[ 1692.647601]  [<ffffffff8139cffd>] submit_bio+0x7d/0x150
[ 1692.647604]  [<ffffffff81235078>] mpage_bio_submit+0x58/0xb0
[ 1692.647606]  [<ffffffff8123622c>] mpage_readpages+0x12c/0x150
[ 1692.647607]  [<ffffffff8122ebd0>] ? I_BDEV+0x20/0x20
[ 1692.647609]  [<ffffffff8122ebd0>] ? I_BDEV+0x20/0x20
[ 1692.647610]  [<ffffffff8122f4ad>] blkdev_readpages+0x1d/0x20
[ 1692.647613]  [<ffffffff811803a0>] __do_page_cache_readahead+0x160/0x1f=
0
[ 1692.647615]  [<ffffffff8118079a>] force_page_cache_readahead+0xaa/0x10=
0
[ 1692.647617]  [<ffffffff811808b0>] SyS_readahead+0x70/0xa0
[ 1692.647619]  [<ffffffff81003a8b>] do_syscall_64+0x5b/0xc0
[ 1692.647620]  [<ffffffff816a262f>] entry_SYSCALL64_slow_path+0x25/0x25

Could this be made more user friendly, by not allowing values below a
minimum (what is the minimum such that it does not deadlock?)?

Regards,

Martin Raiber




--------------ms070105080902090703020001
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CuQwggT6MIID4qADAgECAhBuZlYKQ9u25a8FBnl/zd+MMA0GCSqGSIb3DQEBCwUAMHUxCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBD
ZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGll
bnQgQ0EwHhcNMTYwOTE5MTMxNzAyWhcNMTcwOTE5MTMxNzAyWjBCMRwwGgYDVQQDDBNtYXJ0
aW5AdXJiYWNrdXAub3JnMSIwIAYJKoZIhvcNAQkBFhNtYXJ0aW5AdXJiYWNrdXAub3JnMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw/FqcYQTj3z2wO8ASP8j0Jvb4AbMNgB9
iv2PLMtAMzYmuW7w2VfUcXwWgM4Fkg6Nm33VhOK+Vryd2bj+jGNhm+DmbMZCfki/NrhdcHKH
AT7i1NL1lps8X3xJ7N0eJpghht9Wx5OAUfGv18HDD3yBUzqW4x7OaGoKqM0DwyUm9O/rUU6D
ugxVONmgprREB1JyJBAV8lgYbY0EEUFS1JECuxNcJQEY+G8EpUNCsZxc8nvROyRD72Aztuy2
qQj4Rs+FzQNCplzmvXot7W0T2KAH9gKb25Q5Lv0sFQEux1stcJc6KKNea21UufblNMLApQ2Z
cSNWwDF5R+YpUFW8HiBOmwIDAQABo4IBtzCCAbMwDgYDVR0PAQH/BAQDAgSwMB0GA1UdJQQW
MBQGCCsGAQUFBwMCBggrBgEFBQcDBDAJBgNVHRMEAjAAMB0GA1UdDgQWBBTKwa9D/4YV1XsZ
6affm7Wv4ykzdTAfBgNVHSMEGDAWgBQkgWw5Yb5JD4+3G0YrySi1J0htaDBvBggrBgEFBQcB
AQRjMGEwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbTA5BggrBgEFBQcw
AoYtaHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc2NhLmNsaWVudDEuY3J0MDgGA1Ud
HwQxMC8wLaAroCmGJ2h0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL3NjYS1jbGllbnQxLmNybDAe
BgNVHREEFzAVgRNtYXJ0aW5AdXJiYWNrdXAub3JnMCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tLzBHBgNVHSAEQDA+MDwGCysGAQQBgbU3AQIFMC0wKwYIKwYBBQUHAgEW
H2h0dHBzOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kwDQYJKoZIhvcNAQELBQADggEBADMT
EdZtz2a7sT3FDGszfzlAfmwVamtLbG5+O6NC5xc1n9AtWa7LdRPsQzgIROT/e84D+uTPAo1c
F6rEJ7oSqhgxJcAWgGN1G0KyEzSaFs+nLvfFN1LeaYQjElnmw87z6LGLvjOnfu01M0Atj+DR
DB3NyRoAn2/5yXHJKP7/mlUSXV/fiplcvP+TJbYJwrL7QDETySua89BU0oH3vtidOm8rlWzl
cZ4ug+kXzMMwjcwSIFb/P6LDZm3FMCNbg8sBt59+V5+Duk8y6aOcQ0GdGrIXMNs+oIKL5iQW
sP9+c55K9mJVl4+3J4sTcyT/L2EOXxEZY+zEhnJAds9dQJXkKfswggXiMIIDyqADAgECAhBr
p4p9CteI1lEK+Vnk57ThMA0GCSqGSIb3DQEBCwUAMH0xCzAJBgNVBAYTAklMMRYwFAYDVQQK
Ew1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBT
aWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0x
NTEyMTYwMTAwMDVaFw0zMDEyMTYwMTAwMDVaMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQC9fdr3w6J9g/Zbgv3bW1+uHht1wLUZr5gkrLtXedg17AkefMyU
GwrQdvwObhajcVmnKVxhrUwkZPXRAwZZosRHfEIi5FH7x6SV/8Sp5lZEuiMnvMFG2MzLA84J
6Ws5T4NfXZ0qn4TPgnr3X2vPVS51M7Ua9nIJgn8jvTra4eyyQzxvuA/GZwKg7VQfDCmCS+kI
CslYYWgXOMt2xlsSslxLce0CGWRsT8EpMyt1iDflSjXZIsE7m1uTyHaKZspMLyIyz6mySu8j
8BWWHpChNNeTrFuhVfrOAyDPFJVUvKZCLKBhibTLloyy+LatoWELrjdI4a8StZY8+dIR9t4A
PXGzAgMBAAGjggFkMIIBYDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
CCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwMgYDVR0fBCswKTAnoCWgI4YhaHR0cDov
L2NybC5zdGFydHNzbC5jb20vc2ZzY2EuY3JsMGYGCCsGAQUFBwEBBFowWDAkBggrBgEFBQcw
AYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDAGCCsGAQUFBzAChiRodHRwOi8vYWlhLnN0
YXJ0c3NsLmNvbS9jZXJ0cy9jYS5jcnQwHQYDVR0OBBYEFCSBbDlhvkkPj7cbRivJKLUnSG1o
MB8GA1UdIwQYMBaAFE4L7xqkQFulF2mHMMo0aEPQQa7yMD8GA1UdIAQ4MDYwNAYEVR0gADAs
MCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kwDQYJKoZIhvcN
AQELBQADggIBAIvj94fsAYuErQ8BAluc4SMnIwS9NPBwAm5SH9uh2NCXTq7im61g7F1LIiNI
/+wq37fUuaMbz4g7VarKQTgf8ubs0p7NZWcIe7Bvem2AWaXBsxsaRTYw5kG3DN8pd1hSEUuF
oTa7DmNeFe8tiK1BrL3rbA/m48jp4AiFXgvxprJrW7izsyetOrRHPbkW4Y07v29MdhaPv3u1
JELyszXqOzjIYo4sWlC8iDQXwgSW/ntvWy2n4LuiaozlCfXl149tKeqvwlvrla2Yklue/quW
p9j9ou4T/OY0CXMuY+B8wNK0ohd2D4ShgFlMSjzAFRoHGKF81snTr2d1A7Ew02oF6UQyCkC2
aNNsK5cWOojBar5c7HplX9aHYUCZouxIeU28SONJAxnATgR4cJ2jrpmYSz/kliUJ46S6UpVD
o/ebn9c6PaM/XtDYCCaM/7XX6wc3s++sbQ7CtCn1Ax7df6ufQbwyO0V+oFa9H0KAsjHMzcwk
3EV2B2NLatidKE/m7G+rB9m+FlVgIiSp0mGlg43QO9Kh1+JqvTCIzv2bJJkmPMLQJNuKKwHN
L8F4GGp6jbAV+WL+LDeGfVcq8DHS3LrD+xyYEXQBiqZEdiPVOMxLDSUCXsDO0uCWpaNQ8j6y
6S9p0xE/Ga0peVLadVHhqf9nXqKaxnr358VgfrxzUIrvOaOjMYIDzDCCA8gCAQEwgYkwdTEL
MAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29t
IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAxIENs
aWVudCBDQQIQbmZWCkPbtuWvBQZ5f83fjDANBglghkgBZQMEAgEFAKCCAhMwGAYJKoZIhvcN
AQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwMTA4MTMzOTUxWjAvBgkqhkiG
9w0BCQQxIgQg2AWnM0TzogsKLdjtKJ5tOeafoeluCX+Oufum6+JmGWwwbAYJKoZIhvcNAQkP
MV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMC
AgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBmgYJKwYBBAGC
NxAEMYGMMIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYD
VQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRD
b20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5mVgpD27blrwUGeX/N34wwgZwGCyqGSIb3DQEJEAIL
MYGMoIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQL
EyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20g
Q2xhc3MgMSBDbGllbnQgQ0ECEG5mVgpD27blrwUGeX/N34wwDQYJKoZIhvcNAQEBBQAEggEA
WqmbBcYrOCyHS/7e0TEZJfBSM6ErGqn5k8GYYaHPck3d7HaDRF3piYLMLiyfOQGl1KKIDy2x
TCD/Z/pTrKgeYFm9fQYr+LWOp/Cna3SHpjK1wcZK471457ocnFuBiM02HY/ozxWWnD5t00Zb
vdnjoqxK85+FgyLjTFrxmL/X6eNilwuCYJfGed9CBMeP1x9qSl2eJgIkeG/n59un/+ckCr3X
Ab3LQKdIMic58JqjyVQeC6K7Xy+96fqZq2Iqdg57znUk+yiNvWvUNzyUnj97XODbbk8x70Kr
QiqO1i069ouGXePBjztGw/qNwmcgBTTNlX5o65SDrq955zbe/rktjwAAAAAAAA==
--------------ms070105080902090703020001--
