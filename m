Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572CCC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B93621841
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBHW5d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:57:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:3994 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfBHW5d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 17:57:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 14:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="p7s'?scan'208";a="142776840"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2019 14:57:31 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.11]) with mapi id 14.03.0415.000;
 Fri, 8 Feb 2019 14:57:31 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 04/16] block: sed-opal: close parameter list in
 cmd_finalize
Thread-Topic: [PATCH v4 04/16] block: sed-opal: close parameter list in
 cmd_finalize
Thread-Index: AQHUum/jCOrJ80gFkUyJXYLhQjwYaKXXFJGA
Date:   Fri, 8 Feb 2019 22:57:31 +0000
Message-ID: <1549666649.10972.52.camel@intel.com>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1549054223-12220-5-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1549054223-12220-5-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.141]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-dEtyq3TXA9LzJm/VDePm"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-dEtyq3TXA9LzJm/VDePm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Normally I wouldn't like decreasing the readability (having a STARTLIST
without an ENDLIST in the same function), but this makes a lot of sense
with 5/16

Acked-by: Jon Derrick <jonathan.derrick@intel.com>

On Fri, 2019-02-01 at 21:50 +0100, David Kozub wrote:
> Every step ends by calling cmd_finalize (via finalize_and_send)
> yet every step adds the token OPAL_ENDLIST on its own. Moving
> this into cmd_finalize decreases code duplication.
>=20
> Co-authored-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.d=
e>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de=
>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> ---
>  block/sed-opal.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 980705681806..35b1747b650f 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -661,6 +661,9 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn=
, u32 tsn)
>  	struct opal_header *hdr;
>  	int err =3D 0;
> =20
> +	/* close parameter list */
> +	add_token_u8(&err, cmd, OPAL_ENDLIST);
> +
>  	add_token_u8(&err, cmd, OPAL_ENDOFDATA);
>  	add_token_u8(&err, cmd, OPAL_STARTLIST);
>  	add_token_u8(&err, cmd, 0);
> @@ -1079,7 +1082,6 @@ static int gen_key(struct opal_dev *dev, void *data=
)
>  	add_token_bytestring(&err, dev, opalmethod[OPAL_GENKEY],
>  			     OPAL_UID_LENGTH);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	if (err) {
>  		pr_debug("Error building gen key command\n");
> @@ -1142,7 +1144,6 @@ static int get_active_key(struct opal_dev *dev, voi=
d *data)
>  	add_token_u8(&err, dev, 10); /* ActiveKey */
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	if (err) {
>  		pr_debug("Error building get active key command\n");
>  		return err;
> @@ -1188,7 +1189,6 @@ static int generic_lr_enable_disable(struct opal_de=
v *dev,
> =20
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	return err;
>  }
> =20
> @@ -1254,8 +1254,6 @@ static int setup_locking_range(struct opal_dev *dev=
, void *data)
> =20
>  		add_token_u8(&err, dev, OPAL_ENDLIST);
>  		add_token_u8(&err, dev, OPAL_ENDNAME);
> -		add_token_u8(&err, dev, OPAL_ENDLIST);
> -
>  	}
>  	if (err) {
>  		pr_debug("Error building Setup Locking range command.\n");
> @@ -1295,7 +1293,6 @@ static int start_generic_opal_session(struct opal_d=
ev *dev,
> =20
>  	switch (auth) {
>  	case OPAL_ANYBODY_UID:
> -		add_token_u8(&err, dev, OPAL_ENDLIST);
>  		break;
>  	case OPAL_ADMIN1_UID:
>  	case OPAL_SID_UID:
> @@ -1308,7 +1305,6 @@ static int start_generic_opal_session(struct opal_d=
ev *dev,
>  		add_token_bytestring(&err, dev, opaluid[auth],
>  				     OPAL_UID_LENGTH);
>  		add_token_u8(&err, dev, OPAL_ENDNAME);
> -		add_token_u8(&err, dev, OPAL_ENDLIST);
>  		break;
>  	default:
>  		pr_debug("Cannot start Admin SP session with auth %d\n", auth);
> @@ -1406,7 +1402,6 @@ static int start_auth_opal_session(struct opal_dev =
*dev, void *data)
>  	add_token_u8(&err, dev, 3);
>  	add_token_bytestring(&err, dev, lk_ul_user, OPAL_UID_LENGTH);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	if (err) {
>  		pr_debug("Error building STARTSESSION command.\n");
> @@ -1429,7 +1424,6 @@ static int revert_tper(struct opal_dev *dev, void *=
data)
>  	add_token_bytestring(&err, dev, opalmethod[OPAL_REVERT],
>  			     OPAL_UID_LENGTH);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	if (err) {
>  		pr_debug("Error building REVERT TPER command.\n");
>  		return err;
> @@ -1463,7 +1457,6 @@ static int internal_activate_user(struct opal_dev *=
dev, void *data)
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	if (err) {
>  		pr_debug("Error building Activate UserN command.\n");
> @@ -1490,7 +1483,6 @@ static int erase_locking_range(struct opal_dev *dev=
, void *data)
>  	add_token_bytestring(&err, dev, opalmethod[OPAL_ERASE],
>  			     OPAL_UID_LENGTH);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	if (err) {
>  		pr_debug("Error building Erase Locking Range Command.\n");
> @@ -1521,7 +1513,6 @@ static int set_mbr_done(struct opal_dev *dev, void =
*data)
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	if (err) {
>  		pr_debug("Error Building set MBR Done command\n");
> @@ -1553,7 +1544,6 @@ static int set_mbr_enable_disable(struct opal_dev *=
dev, void *data)
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	if (err) {
>  		pr_debug("Error Building set MBR done command\n");
> @@ -1585,7 +1575,6 @@ static int generic_pw_cmd(u8 *key, size_t key_len, =
u8 *cpin_uid,
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	return err;
>  }
> @@ -1694,7 +1683,6 @@ static int add_user_to_lr(struct opal_dev *dev, voi=
d *data)
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	if (err) {
>  		pr_debug("Error building add user to locking range command.\n");
> @@ -1755,7 +1743,6 @@ static int lock_unlock_locking_range(struct opal_de=
v *dev, void *data)
> =20
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	if (err) {
>  		pr_debug("Error building SET command.\n");
> @@ -1843,11 +1830,8 @@ static int activate_lsp(struct opal_dev *dev, void=
 *data)
>  		}
>  		add_token_u8(&err, dev, OPAL_ENDLIST);
>  		add_token_u8(&err, dev, OPAL_ENDNAME);
> -		add_token_u8(&err, dev, OPAL_ENDLIST);
> -
>  	} else {
>  		add_token_u8(&err, dev, OPAL_STARTLIST);
> -		add_token_u8(&err, dev, OPAL_ENDLIST);
>  	}
> =20
>  	if (err) {
> @@ -1904,7 +1888,6 @@ static int get_lsp_lifecycle(struct opal_dev *dev, =
void *data)
>  	add_token_u8(&err, dev, 6); /* Lifecycle Column */
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> =20
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	if (err) {
> @@ -1964,8 +1947,6 @@ static int get_msid_cpin_pin(struct opal_dev *dev, =
void *data)
>  	add_token_u8(&err, dev, 4); /* End Column */
>  	add_token_u8(&err, dev, 3); /* Lifecycle Column */
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> -
> -	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
> =20
>  	if (err) {
--=-dEtyq3TXA9LzJm/VDePm
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIwODIyNTcyOVowIwYJ
KoZIhvcNAQkEMRYEFFlGtlNGIOetqgke/RqGOkG7l2kbMA0GCSqGSIb3DQEBAQUABIIBAGXzOiKI
xHT7lmBRm2Xmmc1wZ2+kAI0krxLlwT8XCMlpiTUGtSgShZyulkrAvLCm8GrJ0HRDT33uV0sp5X+2
YugSjYEg1hOVwSEA35lCxSf6imrcmacCjb/Zro87VP0sAhEZ8K5jobSYeD+oP5t8R26tsaga56AW
Jt9gsr9kcaXIBSU9HjUXqvBFVEWlipr3+H8erxGKO9NvflzqLoNUd6CKJEvLbN6BoVXupF4YnvIh
NnWLkEmRDeWyoGOX1YbkvzYlFEjM6V39ralUHrk8RsDSMGlgMeB9PpNMTs8hnwZ+OmRqInhVxNnM
XsAuodGdjv7Ze+eaThVLlO51ttJnwz8AAAAAAAA=


--=-dEtyq3TXA9LzJm/VDePm--
