Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0B1C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2C521841
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBHW6A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:58:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:7258 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfBHW6A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 17:58:00 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 14:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="p7s'?scan'208";a="145355733"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2019 14:57:58 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.90]) with mapi id 14.03.0415.000;
 Fri, 8 Feb 2019 14:57:58 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 07/16] block: sed-opal: reuse response_get_token to
 decrease code duplication
Thread-Topic: [PATCH v4 07/16] block: sed-opal: reuse response_get_token to
 decrease code duplication
Thread-Index: AQHUum/vGMfD2wW7nEmBBU+crwjx5aXXFLCA
Date:   Fri, 8 Feb 2019 22:57:57 +0000
Message-ID: <1549666675.10972.55.camel@intel.com>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1549054223-12220-8-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1549054223-12220-8-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.141]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-X9UNYfHkVOK6yvPEbbdw"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-X9UNYfHkVOK6yvPEbbdw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

On Fri, 2019-02-01 at 21:50 +0100, David Kozub wrote:
> response_get_token had already been in place, its functionality had
> been duplicated within response_get_{u64,bytestring} with the same error
> handling. Unify the handling by reusing response_get_token within the
> other functions.
>=20
> Co-authored-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.d=
e>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de=
>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> ---
>  block/sed-opal.c | 46 +++++++++++++++-------------------------------
>  1 file changed, 15 insertions(+), 31 deletions(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 537cd73ea88a..1332547e5a99 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -889,27 +889,19 @@ static size_t response_get_string(const struct pars=
ed_resp *resp, int n,
>  				  const char **store)
>  {
>  	u8 skip;
> -	const struct opal_resp_tok *token;
> +	const struct opal_resp_tok *tok;
> =20
>  	*store =3D NULL;
> -	if (!resp) {
> -		pr_debug("Response is NULL\n");
> -		return 0;
> -	}
> -
> -	if (n >=3D resp->num) {
> -		pr_debug("Response has %d tokens. Can't access %d\n",
> -			 resp->num, n);
> +	tok =3D response_get_token(resp, n);
> +	if (IS_ERR(tok))
>  		return 0;
> -	}
> =20
> -	token =3D &resp->toks[n];
> -	if (token->type !=3D OPAL_DTA_TOKENID_BYTESTRING) {
> +	if (tok->type !=3D OPAL_DTA_TOKENID_BYTESTRING) {
>  		pr_debug("Token is not a byte string!\n");
>  		return 0;
>  	}
> =20
> -	switch (token->width) {
> +	switch (tok->width) {
>  	case OPAL_WIDTH_TINY:
>  	case OPAL_WIDTH_SHORT:
>  		skip =3D 1;
> @@ -925,37 +917,29 @@ static size_t response_get_string(const struct pars=
ed_resp *resp, int n,
>  		return 0;
>  	}
> =20
> -	*store =3D token->pos + skip;
> -	return token->len - skip;
> +	*store =3D tok->pos + skip;
> +	return tok->len - skip;
>  }
> =20
>  static u64 response_get_u64(const struct parsed_resp *resp, int n)
>  {
> -	if (!resp) {
> -		pr_debug("Response is NULL\n");
> -		return 0;
> -	}
> +	const struct opal_resp_tok *tok;
> =20
> -	if (n >=3D resp->num) {
> -		pr_debug("Response has %d tokens. Can't access %d\n",
> -			 resp->num, n);
> +	tok =3D response_get_token(resp, n);
> +	if (IS_ERR(tok))
>  		return 0;
> -	}
> =20
> -	if (resp->toks[n].type !=3D OPAL_DTA_TOKENID_UINT) {
> -		pr_debug("Token is not unsigned it: %d\n",
> -			 resp->toks[n].type);
> +	if (tok->type !=3D OPAL_DTA_TOKENID_UINT) {
> +		pr_debug("Token is not unsigned int: %d\n", tok->type);
>  		return 0;
>  	}
> =20
> -	if (!(resp->toks[n].width =3D=3D OPAL_WIDTH_TINY ||
> -	      resp->toks[n].width =3D=3D OPAL_WIDTH_SHORT)) {
> -		pr_debug("Atom is not short or tiny: %d\n",
> -			 resp->toks[n].width);
> +	if (tok->width !=3D OPAL_WIDTH_TINY && tok->width !=3D OPAL_WIDTH_SHORT=
) {
> +		pr_debug("Atom is not short or tiny: %d\n", tok->width);
>  		return 0;
>  	}
> =20
> -	return resp->toks[n].stored.u;
> +	return tok->stored.u;
>  }
> =20
>  static bool response_token_matches(const struct opal_resp_tok *token, u8=
 match)
--=-X9UNYfHkVOK6yvPEbbdw
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIwODIyNTc1NVowIwYJ
KoZIhvcNAQkEMRYEFElrU1CAmj7yc8f3Xes13EBw08c/MA0GCSqGSIb3DQEBAQUABIIBAHNLnqU6
GEo6/ow70W/hfOXh4lFfTYWWU2Y6bjPHAdg8ckx/fi7smCTAwmnE8aT9pXzctY+TKyDn0jQowZJ9
k+cH1NE7litSilEa/OuEgnNcwrT4vGJl4a1Z/tqfKa535WsGT5X9LVA+dc4AEMZ2KBKsePivtQ6y
UKTSZB29SsZZH/X0sjaMJpWBgTlsu2I5yrOXeejQ7ZwRFaUkhqcX18plJd8kwMzQ4HQ9qNFPhhLy
jKpICr0qRs/ChUBdyLKP7YcT6JzDkRjDmLw1oYYRvNnpAit1uwaGU7tRndvUEUCauokVusxdwNgO
reWNm+fHuJ2/uqSSVO6VWaC8Q6MkRNwAAAAAAAA=


--=-X9UNYfHkVOK6yvPEbbdw--
