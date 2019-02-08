Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39131C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A6D21908
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBHW44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:56:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:54490 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfBHW4z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 17:56:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 14:56:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="p7s'?scan'208";a="137038841"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga001.jf.intel.com with ESMTP; 08 Feb 2019 14:56:55 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 8 Feb 2019 14:56:54 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.136]) with mapi id 14.03.0415.000;
 Fri, 8 Feb 2019 14:56:54 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 02/16] block: sed-opal: use correct macro for method
 length
Thread-Topic: [PATCH v4 02/16] block: sed-opal: use correct macro for method
 length
Thread-Index: AQHUum/jtclvHJfJpEa6tuuGvcT13KXXFGUA
Date:   Fri, 8 Feb 2019 22:56:53 +0000
Message-ID: <1549666612.10972.50.camel@intel.com>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1549054223-12220-3-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1549054223-12220-3-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.141]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-+91WqnxDE4nDbGyx6sTm"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-+91WqnxDE4nDbGyx6sTm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

On Fri, 2019-02-01 at 21:50 +0100, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>=20
> Also the values of OPAL_UID_LENGTH and OPAL_METHOD_LENGTH are the same,
> it is weird to use OPAL_UID_LENGTH for the definition of the methods.
>=20
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de=
>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> ---
>  block/sed-opal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index c882a193e162..5c123a5b4ab1 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -181,7 +181,7 @@ static const u8 opaluid[][OPAL_UID_LENGTH] =3D {
>   * Derived from: TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
>   * Section: 6.3 Assigned UIDs
>   */
> -static const u8 opalmethod[][OPAL_UID_LENGTH] =3D {
> +static const u8 opalmethod[][OPAL_METHOD_LENGTH] =3D {
>  	[OPAL_PROPERTIES] =3D
>  		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x01 },
>  	[OPAL_STARTSESSION] =3D
--=-+91WqnxDE4nDbGyx6sTm
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
PNauajAtxgRKfqfSMb+IcL/VXiPtVZOxVq+CTZeDJkaEmn/79vg8OYxpR+YhFF+tGlKf/Zc4id1P
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQU4oawcWXM1cPGdwGcIszDfjORVZAwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQBxGkHe05DNpYel4b9WbbyQqD1G6y6YA6C93TjKULZi
p8+gO1LL096ixD44+frVm3jtXMikoadRHQJmBJdzsCywNE1KgtrYF0k4zRWr7a28nyfGgQe4UHHD
7ARyZFeGd7AKSQ1y4/LU57I2Aw2HKx9/PXavv1JXjjO2/bqTfnZDJTQmOQ0nvlO3/gvbbABxZHqz
NtfHZsQWS7s+Elk2xGUQ0Po2pMCQoaPo9R96mm+84UP9q3OvSqMoaZwfzoUeAx2wGJYl0h3S+ABr
CPVfCgq9qnmVCn5DyHWE3V/BRjJCoILLBLxAxnmSdH4pF6wJ6pYRLEw9qoyNhpzGUIJU/Lk1MYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAMamAkocC+WQNPgAAAAAxqYwCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIwODIyNTY1MlowIwYJ
KoZIhvcNAQkEMRYEFGMXmc1u2qCCNpLW+O4qfYdtnlKGMA0GCSqGSIb3DQEBAQUABIIBAFdVmen0
hI0R8L7kMJNXZtyc6RKHzGBY1971YqbB6YAhbW8eyqvthwtu+9If5CUCpJZ24qHIKAFujl5PGMwM
FAR8FU8A1BXy22oSv0baEvvzoQ0uzzjIj3jCx+/wT6KCodYFOg84iD1GRqpNkIeDKOeRzKSnB6tR
oJKpaQlFElUWyKRJwS/9dlLmXax0CuFJhfPjZ89I/+8BzDP5FsX140xWFCQLbbit1zXBqMWeoAFQ
ns3yoxdM2uGgJMjXCLl4ADSlBszZ8KgXfDM5Hd8dZIp4S9o/bIJzFdghjobx74EC9u3xrINnhORb
uSqjtol/nb7sKn5yyMC28pqsJCA1AeoAAAAAAAA=


--=-+91WqnxDE4nDbGyx6sTm--
