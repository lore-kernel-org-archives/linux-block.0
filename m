Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5D9C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DEC21773
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfC1PnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:43:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:55504 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfC1PnL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 11:43:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 08:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="p7s'?scan'208";a="126671779"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 08:43:10 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.133]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.134]) with mapi id 14.03.0415.000;
 Thu, 28 Mar 2019 08:43:10 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 04/16] block: sed-opal: unify space check in add_token_*
Thread-Topic: [PATCH 04/16] block: sed-opal: unify space check in add_token_*
Thread-Index: AQHUw/qb5kq+x19s2UaFiwg5ylQWJKYh5y8A
Date:   Thu, 28 Mar 2019 15:43:08 +0000
Message-ID: <be50dc915987e880eaefbd52d7b324464c4dea07.camel@intel.com>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1550103368-4605-5-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1550103368-4605-5-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.25]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-cQj3br6aN+FDWlTdeT09"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-cQj3br6aN+FDWlTdeT09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good

Acked-by: Jon Derrick <jonathan.derrick@intel.com>

On Thu, 2019-02-14 at 01:15 +0100, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>=20
> All add_token_* functions have a common set of conditions that have
> to
> be checked. Use a common function for those checks in order to avoid
> different behaviour as well as code duplication.
>=20
> Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Signed-off-by: Jonas Rabenstein <
> jonas.rabenstein@studium.uni-erlangen.de>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> ---
>  block/sed-opal.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index e59ae364f1ef..d285bd4b2b9b 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -510,15 +510,24 @@ static int opal_discovery0(struct opal_dev
> *dev, void *data)
>  	return opal_discovery0_end(dev);
>  }
> =20
> -static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
> +static bool can_add(int *err, struct opal_dev *cmd, size_t len)
>  {
>  	if (*err)
> -		return;
> -	if (cmd->pos >=3D IO_BUFFER_LENGTH - 1) {
> -		pr_debug("Error adding u8: end of buffer.\n");
> +		return false;
> +
> +	if (len > IO_BUFFER_LENGTH || cmd->pos > IO_BUFFER_LENGTH -
> len) {
> +		pr_debug("Error adding %zu bytes: end of buffer.\n",
> len);
>  		*err =3D -ERANGE;
> -		return;
> +		return false;
>  	}
> +
> +	return true;
> +}
> +
> +static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
> +{
> +	if (!can_add(err, cmd, 1))
> +		return;
>  	cmd->cmd[cmd->pos++] =3D tok;
>  }
> =20
> @@ -562,9 +571,8 @@ static void add_token_u64(int *err, struct
> opal_dev *cmd, u64 number)
>  	msb =3D fls64(number);
>  	len =3D DIV_ROUND_UP(msb, 8);
> =20
> -	if (cmd->pos >=3D IO_BUFFER_LENGTH - len - 1) {
> +	if (!can_add(err, cmd, len + 1)) {
>  		pr_debug("Error adding u64: end of buffer.\n");
> -		*err =3D -ERANGE;
>  		return;
>  	}
>  	add_short_atom_header(cmd, false, false, len);
> @@ -586,9 +594,8 @@ static void add_token_bytestring(int *err, struct
> opal_dev *cmd,
>  		is_short_atom =3D false;
>  	}
> =20
> -	if (len >=3D IO_BUFFER_LENGTH - cmd->pos - header_len) {
> +	if (!can_add(err, cmd, header_len + len)) {
>  		pr_debug("Error adding bytestring: end of buffer.\n");
> -		*err =3D -ERANGE;
>  		return;
>  	}
> =20

--=-cQj3br6aN+FDWlTdeT09
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDMyODE1NDI1MFowIwYJ
KoZIhvcNAQkEMRYEFFR021jJeug6gawg/B0CMY6qCfZxMA0GCSqGSIb3DQEBAQUABIIBAA1XDiNj
vWA007L6C6k99MsC3zwBXCYhjHpZO23rTHyCBvXOhENK8oVPm7dVHzBXGaZ2WsV2GSUq50gQHfO9
G56eOMEB25L0yDLSpAHKHSet8eYzzTG2S4XZJDH3JP7nso3CDBdJYXaDGDkxWw9b6WK8f+MmursF
59t4KHYNMyv5PxVIs9PXXoxZBDHjWrbHACV9VZLADDaXFqfGCL+ubqKkb67YuFYSj4dGhvM1+l2h
wlk0ZvxrK35N4p2+JC5V0ALVs+gf9mtdAvqY5t8K1zZJdiUruFtdlgke+v5kFCtTJ89AGSYaWXs7
BBb0VxQf2jdOHb2cY6fSpwObArs9GvMAAAAAAAA=


--=-cQj3br6aN+FDWlTdeT09--
