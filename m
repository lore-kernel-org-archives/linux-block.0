Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C7EC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA6321841
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfBHW5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:57:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:44781 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfBHW5n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 17:57:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 14:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="p7s'?scan'208";a="123088457"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga008.fm.intel.com with ESMTP; 08 Feb 2019 14:57:42 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 8 Feb 2019 14:57:41 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.135]) with mapi id 14.03.0415.000;
 Fri, 8 Feb 2019 14:57:41 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 05/16] block: sed-opal: unify cmd start
Thread-Topic: [PATCH v4 05/16] block: sed-opal: unify cmd start
Thread-Index: AQHUum/otCNcPEgwT02NsUIityk1/KXXFJwA
Date:   Fri, 8 Feb 2019 22:57:40 +0000
Message-ID: <1549666658.10972.53.camel@intel.com>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1549054223-12220-6-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1549054223-12220-6-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.141]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-mgH4rMqACoiuVFToGEeB"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-mgH4rMqACoiuVFToGEeB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks fine with 4/16

Acked-by: Jon Derrick <jonathan.derrick@intel.com>

On Fri, 2019-02-01 at 21:50 +0100, David Kozub wrote:
> Every step starts with resetting the cmd buffer as well as the comid and
> constructs the appropriate OPAL_CALL command. Consequently, those
> actions may be combined into one generic function. On should take care
> that the opening and closing tokens for the argument list are already
> emitted by cmd_start and cmd_finalize respectively and thus must not be
> additionally added.
>=20
> Co-authored-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.d=
e>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de=
>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> ---
>  block/sed-opal.c | 228 ++++++++++++++---------------------------------
>  1 file changed, 69 insertions(+), 159 deletions(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 35b1747b650f..e29cb2f445ff 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -661,7 +661,7 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn=
, u32 tsn)
>  	struct opal_header *hdr;
>  	int err =3D 0;
> =20
> -	/* close parameter list */
> +	/* close the parameter list opened from cmd_start */
>  	add_token_u8(&err, cmd, OPAL_ENDLIST);
> =20
>  	add_token_u8(&err, cmd, OPAL_ENDOFDATA);
> @@ -1006,6 +1006,27 @@ static void clear_opal_cmd(struct opal_dev *dev)
>  	memset(dev->cmd, 0, IO_BUFFER_LENGTH);
>  }
> =20
> +static int cmd_start(struct opal_dev *dev, const u8 *uid, const u8 *meth=
od)
> +{
> +	int err =3D 0;
> +
> +	clear_opal_cmd(dev);
> +	set_comid(dev, dev->comid);
> +
> +	add_token_u8(&err, dev, OPAL_CALL);
> +	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
> +	add_token_bytestring(&err, dev, method, OPAL_METHOD_LENGTH);
> +
> +	/*
> +	 * Every method call is followed by its parameters enclosed within
> +	 * OPAL_STARTLIST and OPAL_ENDLIST tokens. We automatically open the
> +	 * parameter list here and close it later in cmd_finalize.
> +	 */
> +	add_token_u8(&err, dev, OPAL_STARTLIST);
> +
> +	return err;
> +}
> +
>  static int start_opal_session_cont(struct opal_dev *dev)
>  {
>  	u32 hsn, tsn;
> @@ -1068,20 +1089,13 @@ static int finalize_and_send(struct opal_dev *dev=
, cont_fn cont)
>  static int gen_key(struct opal_dev *dev, void *data)
>  {
>  	u8 uid[OPAL_UID_LENGTH];
> -	int err =3D 0;
> -
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	int err;
> =20
>  	memcpy(uid, dev->prev_data, min(sizeof(uid), dev->prev_d_len));
>  	kfree(dev->prev_data);
>  	dev->prev_data =3D NULL;
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_GENKEY],
> -			     OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
> +	err =3D cmd_start(dev, uid, opalmethod[OPAL_GENKEY]);
> =20
>  	if (err) {
>  		pr_debug("Error building gen key command\n");
> @@ -1119,21 +1133,14 @@ static int get_active_key_cont(struct opal_dev *d=
ev)
>  static int get_active_key(struct opal_dev *dev, void *data)
>  {
>  	u8 uid[OPAL_UID_LENGTH];
> -	int err =3D 0;
> +	int err;
>  	u8 *lr =3D data;
> =20
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> -
>  	err =3D build_locking_range(uid, sizeof(uid), *lr);
>  	if (err)
>  		return err;
> =20
> -	err =3D 0;
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
> +	err =3D cmd_start(dev, uid, opalmethod[OPAL_GET]);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
>  	add_token_u8(&err, dev, 3); /* startCloumn */
> @@ -1156,13 +1163,10 @@ static int generic_lr_enable_disable(struct opal_=
dev *dev,
>  				     u8 *uid, bool rle, bool wle,
>  				     bool rl, bool wl)
>  {
> -	int err =3D 0;
> +	int err;
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
> +	err =3D cmd_start(dev, uid, opalmethod[OPAL_SET]);
> =20
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
>  	add_token_u8(&err, dev, OPAL_VALUES);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> @@ -1209,10 +1213,7 @@ static int setup_locking_range(struct opal_dev *de=
v, void *data)
>  	u8 uid[OPAL_UID_LENGTH];
>  	struct opal_user_lr_setup *setup =3D data;
>  	u8 lr;
> -	int err =3D 0;
> -
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	int err;
> =20
>  	lr =3D setup->session.opal_key.lr;
>  	err =3D build_locking_range(uid, sizeof(uid), lr);
> @@ -1222,12 +1223,8 @@ static int setup_locking_range(struct opal_dev *de=
v, void *data)
>  	if (lr =3D=3D 0)
>  		err =3D enable_global_lr(dev, uid, setup);
>  	else {
> -		add_token_u8(&err, dev, OPAL_CALL);
> -		add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
> -		add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
> -				     OPAL_UID_LENGTH);
> +		err =3D cmd_start(dev, uid, opalmethod[OPAL_SET]);
> =20
> -		add_token_u8(&err, dev, OPAL_STARTLIST);
>  		add_token_u8(&err, dev, OPAL_STARTNAME);
>  		add_token_u8(&err, dev, OPAL_VALUES);
>  		add_token_u8(&err, dev, OPAL_STARTLIST);
> @@ -1271,22 +1268,15 @@ static int start_generic_opal_session(struct opal=
_dev *dev,
>  				      u8 key_len)
>  {
>  	u32 hsn;
> -	int err =3D 0;
> +	int err;
> =20
>  	if (key =3D=3D NULL && auth !=3D OPAL_ANYBODY_UID)
>  		return OPAL_INVAL_PARAM;
> =20
> -	clear_opal_cmd(dev);
> -
> -	set_comid(dev, dev->comid);
>  	hsn =3D GENERIC_HOST_SESSION_NUM;
> +	err =3D cmd_start(dev, opaluid[OPAL_SMUID_UID],
> +			opalmethod[OPAL_STARTSESSION]);
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, opaluid[OPAL_SMUID_UID],
> -			     OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_STARTSESSION],
> -			     OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u64(&err, dev, hsn);
>  	add_token_bytestring(&err, dev, opaluid[sp_type], OPAL_UID_LENGTH);
>  	add_token_u8(&err, dev, 1);
> @@ -1366,30 +1356,21 @@ static int start_auth_opal_session(struct opal_de=
v *dev, void *data)
>  	u8 *key =3D session->opal_key.key;
>  	u32 hsn =3D GENERIC_HOST_SESSION_NUM;
> =20
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> -
> -	if (session->sum) {
> +	if (session->sum)
>  		err =3D build_locking_user(lk_ul_user, sizeof(lk_ul_user),
>  					 session->opal_key.lr);
> -		if (err)
> -			return err;
> -
> -	} else if (session->who !=3D OPAL_ADMIN1 && !session->sum) {
> +	else if (session->who !=3D OPAL_ADMIN1 && !session->sum)
>  		err =3D build_locking_user(lk_ul_user, sizeof(lk_ul_user),
>  					 session->who - 1);
> -		if (err)
> -			return err;
> -	} else
> +	else
>  		memcpy(lk_ul_user, opaluid[OPAL_ADMIN1_UID], OPAL_UID_LENGTH);
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, opaluid[OPAL_SMUID_UID],
> -			     OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_STARTSESSION],
> -			     OPAL_UID_LENGTH);
> +	if (err)
> +		return err;
> +
> +	err =3D cmd_start(dev, opaluid[OPAL_SMUID_UID],
> +			opalmethod[OPAL_STARTSESSION]);
> =20
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u64(&err, dev, hsn);
>  	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
>  			     OPAL_UID_LENGTH);
> @@ -1413,17 +1394,10 @@ static int start_auth_opal_session(struct opal_de=
v *dev, void *data)
> =20
>  static int revert_tper(struct opal_dev *dev, void *data)
>  {
> -	int err =3D 0;
> -
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	int err;
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, opaluid[OPAL_ADMINSP_UID],
> -			     OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_REVERT],
> -			     OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
> +	err =3D cmd_start(dev, opaluid[OPAL_ADMINSP_UID],
> +			opalmethod[OPAL_REVERT]);
>  	if (err) {
>  		pr_debug("Error building REVERT TPER command.\n");
>  		return err;
> @@ -1436,18 +1410,12 @@ static int internal_activate_user(struct opal_dev=
 *dev, void *data)
>  {
>  	struct opal_session_info *session =3D data;
>  	u8 uid[OPAL_UID_LENGTH];
> -	int err =3D 0;
> -
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	int err;
> =20
>  	memcpy(uid, opaluid[OPAL_USER1_UID], OPAL_UID_LENGTH);
>  	uid[7] =3D session->who;
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
> +	err =3D cmd_start(dev, uid, opalmethod[OPAL_SET]);
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
>  	add_token_u8(&err, dev, OPAL_VALUES);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> @@ -1470,19 +1438,12 @@ static int erase_locking_range(struct opal_dev *d=
ev, void *data)
>  {
>  	struct opal_session_info *session =3D data;
>  	u8 uid[OPAL_UID_LENGTH];
> -	int err =3D 0;
> -
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	int err;
> =20
>  	if (build_locking_range(uid, sizeof(uid), session->opal_key.lr) < 0)
>  		return -ERANGE;
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_ERASE],
> -			     OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
> +	err =3D cmd_start(dev, uid, opalmethod[OPAL_ERASE]);
> =20
>  	if (err) {
>  		pr_debug("Error building Erase Locking Range Command.\n");
> @@ -1494,16 +1455,11 @@ static int erase_locking_range(struct opal_dev *d=
ev, void *data)
>  static int set_mbr_done(struct opal_dev *dev, void *data)
>  {
>  	u8 *mbr_done_tf =3D data;
> -	int err =3D 0;
> +	int err;
> =20
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	err =3D cmd_start(dev, opaluid[OPAL_MBRCONTROL],
> +			opalmethod[OPAL_SET]);
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, opaluid[OPAL_MBRCONTROL],
> -			     OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
>  	add_token_u8(&err, dev, OPAL_VALUES);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> @@ -1525,16 +1481,11 @@ static int set_mbr_done(struct opal_dev *dev, voi=
d *data)
>  static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
>  {
>  	u8 *mbr_en_dis =3D data;
> -	int err =3D 0;
> +	int err;
> =20
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	err =3D cmd_start(dev, opaluid[OPAL_MBRCONTROL],
> +			opalmethod[OPAL_SET]);
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, opaluid[OPAL_MBRCONTROL],
> -			     OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
>  	add_token_u8(&err, dev, OPAL_VALUES);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> @@ -1556,16 +1507,10 @@ static int set_mbr_enable_disable(struct opal_dev=
 *dev, void *data)
>  static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
>  			  struct opal_dev *dev)
>  {
> -	int err =3D 0;
> +	int err;
> =20
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	err =3D cmd_start(dev, cpin_uid, opalmethod[OPAL_SET]);
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, cpin_uid, OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
> -			     OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
>  	add_token_u8(&err, dev, OPAL_VALUES);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> @@ -1622,10 +1567,7 @@ static int add_user_to_lr(struct opal_dev *dev, vo=
id *data)
>  	u8 lr_buffer[OPAL_UID_LENGTH];
>  	u8 user_uid[OPAL_UID_LENGTH];
>  	struct opal_lock_unlock *lkul =3D data;
> -	int err =3D 0;
> -
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	int err;
> =20
>  	memcpy(lr_buffer, opaluid[OPAL_LOCKINGRANGE_ACE_RDLOCKED],
>  	       OPAL_UID_LENGTH);
> @@ -1640,12 +1582,8 @@ static int add_user_to_lr(struct opal_dev *dev, vo=
id *data)
> =20
>  	user_uid[7] =3D lkul->session.who;
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, lr_buffer, OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
> -			     OPAL_UID_LENGTH);
> +	err =3D cmd_start(dev, lr_buffer, opalmethod[OPAL_SET]);
> =20
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
>  	add_token_u8(&err, dev, OPAL_VALUES);
> =20
> @@ -1699,9 +1637,6 @@ static int lock_unlock_locking_range(struct opal_de=
v *dev, void *data)
>  	u8 read_locked =3D 1, write_locked =3D 1;
>  	int err =3D 0;
> =20
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> -
>  	if (build_locking_range(lr_buffer, sizeof(lr_buffer),
>  				lkul->session.opal_key.lr) < 0)
>  		return -ERANGE;
> @@ -1723,10 +1658,8 @@ static int lock_unlock_locking_range(struct opal_d=
ev *dev, void *data)
>  		return OPAL_INVAL_PARAM;
>  	}
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, lr_buffer, OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
> +	err =3D cmd_start(dev, lr_buffer, opalmethod[OPAL_SET]);
> +
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
>  	add_token_u8(&err, dev, OPAL_VALUES);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> @@ -1797,17 +1730,10 @@ static int activate_lsp(struct opal_dev *dev, voi=
d *data)
>  	struct opal_lr_act *opal_act =3D data;
>  	u8 user_lr[OPAL_UID_LENGTH];
>  	u8 uint_3 =3D 0x83;
> -	int err =3D 0, i;
> -
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> -
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
> -			     OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_ACTIVATE],
> -			     OPAL_UID_LENGTH);
> +	int err, i;
> =20
> +	err =3D cmd_start(dev, opaluid[OPAL_LOCKINGSP_UID],
> +			opalmethod[OPAL_ACTIVATE]);
> =20
>  	if (opal_act->sum) {
>  		err =3D build_locking_range(user_lr, sizeof(user_lr),
> @@ -1815,7 +1741,6 @@ static int activate_lsp(struct opal_dev *dev, void =
*data)
>  		if (err)
>  			return err;
> =20
> -		add_token_u8(&err, dev, OPAL_STARTLIST);
>  		add_token_u8(&err, dev, OPAL_STARTNAME);
>  		add_token_u8(&err, dev, uint_3);
>  		add_token_u8(&err, dev, 6);
> @@ -1830,8 +1755,6 @@ static int activate_lsp(struct opal_dev *dev, void =
*data)
>  		}
>  		add_token_u8(&err, dev, OPAL_ENDLIST);
>  		add_token_u8(&err, dev, OPAL_ENDNAME);
> -	} else {
> -		add_token_u8(&err, dev, OPAL_STARTLIST);
>  	}
> =20
>  	if (err) {
> @@ -1865,17 +1788,11 @@ static int get_lsp_lifecycle_cont(struct opal_dev=
 *dev)
>  /* Determine if we're in the Manufactured Inactive or Active state */
>  static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
>  {
> -	int err =3D 0;
> -
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	int err;
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
> -			     OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
> +	err =3D cmd_start(dev, opaluid[OPAL_LOCKINGSP_UID],
> +			opalmethod[OPAL_GET]);
> =20
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> =20
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
> @@ -1925,19 +1842,12 @@ static int get_msid_cpin_pin_cont(struct opal_dev=
 *dev)
> =20
>  static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
>  {
> -	int err =3D 0;
> -
> -	clear_opal_cmd(dev);
> -	set_comid(dev, dev->comid);
> +	int err;
> =20
> -	add_token_u8(&err, dev, OPAL_CALL);
> -	add_token_bytestring(&err, dev, opaluid[OPAL_C_PIN_MSID],
> -			     OPAL_UID_LENGTH);
> -	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
> +	err =3D cmd_start(dev, opaluid[OPAL_C_PIN_MSID],
> +			opalmethod[OPAL_GET]);
> =20
>  	add_token_u8(&err, dev, OPAL_STARTLIST);
> -	add_token_u8(&err, dev, OPAL_STARTLIST);
> -
>  	add_token_u8(&err, dev, OPAL_STARTNAME);
>  	add_token_u8(&err, dev, 3); /* Start Column */
>  	add_token_u8(&err, dev, 3); /* PIN */
--=-mgH4rMqACoiuVFToGEeB
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIwODIyNTczOFowIwYJ
KoZIhvcNAQkEMRYEFJWV2H8b25QQZfD9y8LJkwIeGsV/MA0GCSqGSIb3DQEBAQUABIIBAF3RW//u
GFUpOLnehryfc735IxcfMf3yTFNEWSiUuytJI5gKdS3QE1w7SbPJRRUj+b1ZnuutSPFs5hOeyGQu
mp/KArxInG4saDpI062h1qR9eaKVo4sbd73rQ69J2plsS0JLHZvpHZQxAeozjaKDMITJI+ZGu1hF
w0hjeiKae8LpOGghASZ3OXCZjCSh+35x0YZAVWdJ1beh9jEHQ/gx6sqgMQdMfnh1AzRHoXI0z1VY
aiOIMDIvVh7v72fusOKInqx88uoguA84Ml1zoxTxEHdGcDOaPK9h3ppm3HmKaKoSdn+M3IJvQupR
HGJeF/Vp+wqR3qS/2khhCmFiIBgbOiMAAAAAAAA=


--=-mgH4rMqACoiuVFToGEeB--
