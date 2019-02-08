Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CA4C282CB
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A2621841
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfBHW67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:58:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:10789 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbfBHW66 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 17:58:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 14:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="p7s'?scan'208";a="123088643"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga008.fm.intel.com with ESMTP; 08 Feb 2019 14:58:56 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.180]) with mapi id 14.03.0415.000;
 Fri, 8 Feb 2019 14:58:39 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 12/16] block: sed-opal: unify retrieval of table
 columns
Thread-Topic: [PATCH v4 12/16] block: sed-opal: unify retrieval of table
 columns
Thread-Index: AQHUum/0EASfSLRonkCgkZ9K8gOgDqXXFOEA
Date:   Fri, 8 Feb 2019 22:58:38 +0000
Message-ID: <1549666716.10972.59.camel@intel.com>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1549054223-12220-13-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1549054223-12220-13-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.141]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-Wk6BLPrLGB82gMPS2pzU"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-Wk6BLPrLGB82gMPS2pzU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

On Fri, 2019-02-01 at 21:50 +0100, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>=20
> Instead of having multiple places defining the same argument list to get
> a specific column of a sed-opal table, provide a generic version and
> call it from those functions.
>=20
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de=
>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> ---
>  block/opal_proto.h |   2 +
>  block/sed-opal.c   | 132 +++++++++++++++++----------------------------
>  2 files changed, 50 insertions(+), 84 deletions(-)
>=20
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index e20be8258854..b6e352cfe982 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -170,6 +170,8 @@ enum opal_token {
>  	OPAL_READLOCKED =3D 0x07,
>  	OPAL_WRITELOCKED =3D 0x08,
>  	OPAL_ACTIVEKEY =3D 0x0A,
> +	/* lockingsp table */
> +	OPAL_LIFECYCLE =3D 0x06,
>  	/* locking info table */
>  	OPAL_MAXRANGES =3D 0x04,
>  	 /* mbr control */
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 88c84906ce98..2459ac4d523b 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -1089,6 +1089,37 @@ static int finalize_and_send(struct opal_dev *dev,=
 cont_fn cont)
>  	return opal_send_recv(dev, cont);
>  }
> =20
> +/*
> + * request @column from table @table on device @dev. On success, the col=
umn
> + * data will be available in dev->resp->tok[4]
> + */
> +static int generic_get_column(struct opal_dev *dev, const u8 *table,
> +			      u64 column)
> +{
> +	int err;
> +
> +	err =3D cmd_start(dev, table, opalmethod[OPAL_GET]);
> +
> +	add_token_u8(&err, dev, OPAL_STARTLIST);
> +
> +	add_token_u8(&err, dev, OPAL_STARTNAME);
> +	add_token_u8(&err, dev, OPAL_STARTCOLUMN);
> +	add_token_u64(&err, dev, column);
> +	add_token_u8(&err, dev, OPAL_ENDNAME);
> +
> +	add_token_u8(&err, dev, OPAL_STARTNAME);
> +	add_token_u8(&err, dev, OPAL_ENDCOLUMN);
> +	add_token_u64(&err, dev, column);
> +	add_token_u8(&err, dev, OPAL_ENDNAME);
> +
> +	add_token_u8(&err, dev, OPAL_ENDLIST);
> +
> +	if (err)
> +		return err;
> +
> +	return finalize_and_send(dev, parse_and_check_status);
> +}
> +
>  static int gen_key(struct opal_dev *dev, void *data)
>  {
>  	u8 uid[OPAL_UID_LENGTH];
> @@ -1143,23 +1174,11 @@ static int get_active_key(struct opal_dev *dev, v=
oid *data)
>  	if (err)
>  		return err;
> =20
> -	err =3D cmd_start(dev, uid, opalmethod[OPAL_GET]);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
> -	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 3); /* startCloumn */
> -	add_token_u8(&err, dev, 10); /* ActiveKey */
> -	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 4); /* endColumn */
> -	add_token_u8(&err, dev, 10); /* ActiveKey */
> -	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> -	if (err) {
> -		pr_debug("Error building get active key command\n");
> +	err =3D generic_get_column(dev, uid, OPAL_ACTIVEKEY);
> +	if (err)
>  		return err;
> -	}
> =20
> -	return finalize_and_send(dev, get_active_key_cont);
> +	return get_active_key_cont(dev);
>  }
> =20
>  static int generic_lr_enable_disable(struct opal_dev *dev,
> @@ -1820,17 +1839,19 @@ static int activate_lsp(struct opal_dev *dev, voi=
d *data)
>  	return finalize_and_send(dev, parse_and_check_status);
>  }
> =20
> -static int get_lsp_lifecycle_cont(struct opal_dev *dev)
> +/* Determine if we're in the Manufactured Inactive or Active state */
> +static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
>  {
>  	u8 lc_status;
> -	int error =3D 0;
> +	int err;
> =20
> -	error =3D parse_and_check_status(dev);
> -	if (error)
> -		return error;
> +	err =3D generic_get_column(dev, opaluid[OPAL_LOCKINGSP_UID],
> +				 OPAL_LIFECYCLE);
> +	if (err)
> +		return err;
> =20
>  	lc_status =3D response_get_u64(&dev->parsed, 4);
> -	/* 0x08 is Manufacured Inactive */
> +	/* 0x08 is Manufactured Inactive */
>  	/* 0x09 is Manufactured */
>  	if (lc_status !=3D OPAL_MANUFACTURED_INACTIVE) {
>  		pr_debug("Couldn't determine the status of the Lifecycle state\n");
> @@ -1840,49 +1861,19 @@ static int get_lsp_lifecycle_cont(struct opal_dev=
 *dev)
>  	return 0;
>  }
> =20
> -/* Determine if we're in the Manufactured Inactive or Active state */
> -static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
> -{
> -	int err;
> -
> -	err =3D cmd_start(dev, opaluid[OPAL_LOCKINGSP_UID],
> -			opalmethod[OPAL_GET]);
> -
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
> -
> -	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 3); /* Start Column */
> -	add_token_u8(&err, dev, 6); /* Lifecycle Column */
> -	add_token_u8(&err, dev, OPAL_ENDNAME);
> -
> -	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 4); /* End Column */
> -	add_token_u8(&err, dev, 6); /* Lifecycle Column */
> -	add_token_u8(&err, dev, OPAL_ENDNAME);
> -
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> -
> -	if (err) {
> -		pr_debug("Error Building GET Lifecycle Status command\n");
> -		return err;
> -	}
> -
> -	return finalize_and_send(dev, get_lsp_lifecycle_cont);
> -}
> -
> -static int get_msid_cpin_pin_cont(struct opal_dev *dev)
> +static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
>  {
>  	const char *msid_pin;
>  	size_t strlen;
> -	int error =3D 0;
> +	int err;
> =20
> -	error =3D parse_and_check_status(dev);
> -	if (error)
> -		return error;
> +	err =3D generic_get_column(dev, opaluid[OPAL_C_PIN_MSID], OPAL_PIN);
> +	if (err)
> +		return err;
> =20
>  	strlen =3D response_get_string(&dev->parsed, 4, &msid_pin);
>  	if (!msid_pin) {
> -		pr_debug("%s: Couldn't extract PIN from response\n", __func__);
> +		pr_debug("Couldn't extract MSID_CPIN from response\n");
>  		return OPAL_INVAL_PARAM;
>  	}
> =20
> @@ -1895,33 +1886,6 @@ static int get_msid_cpin_pin_cont(struct opal_dev =
*dev)
>  	return 0;
>  }
> =20
> -static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
> -{
> -	int err;
> -
> -	err =3D cmd_start(dev, opaluid[OPAL_C_PIN_MSID],
> -			opalmethod[OPAL_GET]);
> -
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
> -	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 3); /* Start Column */
> -	add_token_u8(&err, dev, 3); /* PIN */
> -	add_token_u8(&err, dev, OPAL_ENDNAME);
> -
> -	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_u8(&err, dev, 4); /* End Column */
> -	add_token_u8(&err, dev, 3); /* Lifecycle Column */
> -	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> -
> -	if (err) {
> -		pr_debug("Error building Get MSID CPIN PIN command.\n");
> -		return err;
> -	}
> -
> -	return finalize_and_send(dev, get_msid_cpin_pin_cont);
> -}
> -
>  static int end_opal_session(struct opal_dev *dev, void *data)
>  {
>  	int err =3D 0;
--=-Wk6BLPrLGB82gMPS2pzU
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIwODIyNTgzNlowIwYJ
KoZIhvcNAQkEMRYEFEG8B0ZZ2ireBnV4LSu2Bt0D9YldMA0GCSqGSIb3DQEBAQUABIIBAKBgCljn
HCuOFersxC847WOD2eIBLu48Eww5dDTJcPgQC3CbxTfleXMAk0DZgbSrfI8m20PCmWJhXrsg0uVs
WtlAtpaEiy5SmVZbhOxXG42CfKf0ihGI41sFB/UtBb/lBdXM1Q40KbTm80VnKQ1BUCAoQViogTKr
c1S+AhIltRo3mr0+bMWJAR8a6rs7Cv/nBZYTobxqmSbBI97wY00oKrvSFJ4RTc5cqK5t/WfIqbpB
eJmtCLJNeXmgp+0y3Lv/IIRe9sCbk903f7vAzV9Vdm3EKdhruiB8L8HtfBkDqqCsCH/zXaJPTw+y
gUALMXq78BdkSB/tceMCagKZplHTaqoAAAAAAAA=


--=-Wk6BLPrLGB82gMPS2pzU--
