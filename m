Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C453C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398B820811
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfC1PoO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:44:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:45118 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfC1PoO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 11:44:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 08:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="p7s'?scan'208";a="126671971"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 08:44:13 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.133]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.134]) with mapi id 14.03.0415.000;
 Thu, 28 Mar 2019 08:44:12 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 13/16] block: sed-opal: use named Opal tokens instead of
 integer literals
Thread-Topic: [PATCH 13/16] block: sed-opal: use named Opal tokens instead
 of integer literals
Thread-Index: AQHUw/qvhbFwZr4Ko0aSPTcF/IFUx6Yh532A
Date:   Thu, 28 Mar 2019 15:44:12 +0000
Message-ID: <1549586bdaaa8b72d08aa0d79b921208ad798fd4.camel@intel.com>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1550103368-4605-14-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1550103368-4605-14-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.25]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-xD0pyXETmhvMkl35AcO0"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-xD0pyXETmhvMkl35AcO0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Jon Derrick <jonathan.derrick@intel.com>

On Thu, 2019-02-14 at 01:16 +0100, David Kozub wrote:
> Replace integer literals by Opal tokens defined in opal_proto.h where
> possible.
>=20
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> ---
>  block/sed-opal.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 5395ab1c5248..be0d633783c8 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -1180,12 +1180,12 @@ static int generic_lr_enable_disable(struct
> opal_dev *dev,
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> =20
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 5); /* ReadLockEnabled */
> +	add_token_u8(&err, dev, OPAL_READLOCKENABLED);
>  	add_token_u8(&err, dev, rle);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> =20
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 6); /* WriteLockEnabled */
> +	add_token_u8(&err, dev, OPAL_WRITELOCKENABLED);
>  	add_token_u8(&err, dev, wle);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> =20
> @@ -1238,22 +1238,22 @@ static int setup_locking_range(struct
> opal_dev *dev, void *data)
>  		add_token_u8(&err, dev, OPAL_STARTLIST);
> =20
>  		add_token_u8(&err, dev, OPAL_STARTNAME);
> -		add_token_u8(&err, dev, 3); /* Ranges Start */
> +		add_token_u8(&err, dev, OPAL_RANGESTART);
>  		add_token_u64(&err, dev, setup->range_start);
>  		add_token_u8(&err, dev, OPAL_ENDNAME);
> =20
>  		add_token_u8(&err, dev, OPAL_STARTNAME);
> -		add_token_u8(&err, dev, 4); /* Ranges length */
> +		add_token_u8(&err, dev, OPAL_RANGELENGTH);
>  		add_token_u64(&err, dev, setup->range_length);
>  		add_token_u8(&err, dev, OPAL_ENDNAME);
> =20
>  		add_token_u8(&err, dev, OPAL_STARTNAME);
> -		add_token_u8(&err, dev, 5); /*ReadLockEnabled */
> +		add_token_u8(&err, dev, OPAL_READLOCKENABLED);
>  		add_token_u64(&err, dev, !!setup->RLE);
>  		add_token_u8(&err, dev, OPAL_ENDNAME);
> =20
>  		add_token_u8(&err, dev, OPAL_STARTNAME);
> -		add_token_u8(&err, dev, 6); /*WriteLockEnabled*/
> +		add_token_u8(&err, dev, OPAL_WRITELOCKENABLED);
>  		add_token_u64(&err, dev, !!setup->WLE);
>  		add_token_u8(&err, dev, OPAL_ENDNAME);
> =20
> @@ -1472,7 +1472,7 @@ static int set_mbr_done(struct opal_dev *dev,
> void *data)
>  	add_token_u8(&err, dev, OPAL_VALUES);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 2); /* Done */
> +	add_token_u8(&err, dev, OPAL_MBRDONE);
>  	add_token_u8(&err, dev, *mbr_done_tf); /* Done T or F */
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
> @@ -1498,7 +1498,7 @@ static int set_mbr_enable_disable(struct
> opal_dev *dev, void *data)
>  	add_token_u8(&err, dev, OPAL_VALUES);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 1);
> +	add_token_u8(&err, dev, OPAL_MBRENABLE);
>  	add_token_u8(&err, dev, *mbr_en_dis);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
> @@ -1523,7 +1523,7 @@ static int generic_pw_cmd(u8 *key, size_t
> key_len, u8 *cpin_uid,
>  	add_token_u8(&err, dev, OPAL_VALUES);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 3); /* PIN */
> +	add_token_u8(&err, dev, OPAL_PIN);
>  	add_token_bytestring(&err, dev, key, key_len);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);

--=-xD0pyXETmhvMkl35AcO0
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDMyODE1NDM1NVowIwYJ
KoZIhvcNAQkEMRYEFH15g0iBXpcokPTQoxtYWYqhy9GSMA0GCSqGSIb3DQEBAQUABIIBABT9E3GQ
0jWF8Ol+CHzTxotVHZcpS64W0A3mvWXEHBvVtwug12kjeDMTtUUXPXWmqit/G2NyhNZl9AjZ20YI
Gjj0XoI752WyuFnPByGJCwg0SurlGArFlUKo1P+wJ+BwerR71NpJ5E3r8lSP3lNjix0g+n3L5asc
pU2p0kKrAhOXWI9XCG03oS8rcgA2Q1dDVKpi898Dk5dJj8ZbiRWbT80J+acUZvndp0bg3iRJWh3G
gR2SNWSwOwjk30x3i3Kqstou/WFWsIzTsBKGUPbClfitGDQXcDBbSLCeXsKw2lPGKyvynl+LD9Xk
QZAljv2n9YgF/S0581SHp8EJMILjHucAAAAAAAA=


--=-xD0pyXETmhvMkl35AcO0--
