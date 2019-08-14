Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1262C433FF
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 20:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFB02133F
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 20:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfHNU0T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:26:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:60648 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfHNU0T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 16:26:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 13:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="p7s'?scan'208";a="167538189"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga007.jf.intel.com with ESMTP; 14 Aug 2019 13:26:15 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 14 Aug 2019 13:26:15 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.73]) with mapi id 14.03.0439.000;
 Wed, 14 Aug 2019 13:26:15 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] block: sed-opal: Add/remove spaces
Thread-Topic: [PATCH 1/3] block: sed-opal: Add/remove spaces
Thread-Index: AQHVUh/3DmSoo48A7kSj1pVZCPwLq6b7jiGA
Date:   Wed, 14 Aug 2019 20:26:13 +0000
Message-ID: <d9bbe0828812794ee4f916db1843002f194f7c75.camel@intel.com>
References: <20190813214340.15533-1-revanth.rajashekar@intel.com>
         <20190813214340.15533-2-revanth.rajashekar@intel.com>
In-Reply-To: <20190813214340.15533-2-revanth.rajashekar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.165]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-Ffwn30Q8mTLlbnpb2amG"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-Ffwn30Q8mTLlbnpb2amG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

lgtm

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

On Tue, 2019-08-13 at 15:43 -0600, Rajashekar, Revanth wrote:
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
> ---
>  block/opal_proto.h |  3 +--
>  block/sed-opal.c   | 45 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 42 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index 466ec7be16ef..562b78f40824 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -167,7 +167,6 @@ enum opal_token {
>  	OPAL_TABLE_LASTID =3D 0x0A,
>  	OPAL_TABLE_MIN =3D 0x0B,
>  	OPAL_TABLE_MAX =3D 0x0C,
> -
>  	/* authority table */
>  	OPAL_PIN =3D 0x03,
>  	/* locking tokens */
> @@ -182,7 +181,7 @@ enum opal_token {
>  	OPAL_LIFECYCLE =3D 0x06,
>  	/* locking info table */
>  	OPAL_MAXRANGES =3D 0x04,
> -	 /* mbr control */
> +	/* mbr control */
>  	OPAL_MBRENABLE =3D 0x01,
>  	OPAL_MBRDONE =3D 0x02,
>  	/* properties */
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 7e1a444a25b2..d442f29e84f1 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -129,7 +129,6 @@ static const u8 opaluid[][OPAL_UID_LENGTH] =3D {
>  		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x84, 0x01 },
>=20
>  	/* tables */
> -
>  	[OPAL_TABLE_TABLE]
>  		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01 },
>  	[OPAL_LOCKINGRANGE_GLOBAL] =3D
> @@ -152,7 +151,6 @@ static const u8 opaluid[][OPAL_UID_LENGTH] =3D {
>  		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 },
>=20
>  	/* C_PIN_TABLE object ID's */
> -
>  	[OPAL_C_PIN_MSID] =3D
>  		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02},
>  	[OPAL_C_PIN_SID] =3D
> @@ -161,7 +159,6 @@ static const u8 opaluid[][OPAL_UID_LENGTH] =3D {
>  		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x01, 0x00, 0x01},
>=20
>  	/* half UID's (only first 4 bytes used) */
> -
>  	[OPAL_HALF_UID_AUTHORITY_OBJ_REF] =3D
>  		{ 0x00, 0x00, 0x0C, 0x05, 0xff, 0xff, 0xff, 0xff },
>  	[OPAL_HALF_UID_BOOLEAN_ACE] =3D
> @@ -517,6 +514,7 @@ static int opal_discovery0(struct opal_dev *dev, void=
 *data)
>  	ret =3D opal_recv_cmd(dev);
>  	if (ret)
>  		return ret;
> +
>  	return opal_discovery0_end(dev);
>  }
>=20
> @@ -525,6 +523,7 @@ static int opal_discovery0_step(struct opal_dev *dev)
>  	const struct opal_step discovery0_step =3D {
>  		opal_discovery0,
>  	};
> +
>  	return execute_step(dev, &discovery0_step, 0);
>  }
>=20
> @@ -551,6 +550,7 @@ static void add_token_u8(int *err, struct opal_dev *c=
md, u8 tok)
>  {
>  	if (!can_add(err, cmd, 1))
>  		return;
> +
>  	cmd->cmd[cmd->pos++] =3D tok;
>  }
>=20
> @@ -577,6 +577,7 @@ static void add_medium_atom_header(struct opal_dev *c=
md, bool bytestring,
>  	header0 |=3D bytestring ? MEDIUM_ATOM_BYTESTRING : 0;
>  	header0 |=3D has_sign ? MEDIUM_ATOM_SIGNED : 0;
>  	header0 |=3D (len >> 8) & MEDIUM_ATOM_LEN_MASK;
> +
>  	cmd->cmd[cmd->pos++] =3D header0;
>  	cmd->cmd[cmd->pos++] =3D len;
>  }
> @@ -649,6 +650,7 @@ static int build_locking_range(u8 *buffer, size_t len=
gth, u8 lr)
>=20
>  	if (lr =3D=3D 0)
>  		return 0;
> +
>  	buffer[5] =3D LOCKING_RANGE_NON_GLOBAL;
>  	buffer[7] =3D lr;
>=20
> @@ -945,6 +947,7 @@ static size_t response_get_string(const struct parsed=
_resp *resp, int n,
>  	}
>=20
>  	*store =3D tok->pos + skip;
> +
>  	return tok->len - skip;
>  }
>=20
> @@ -1062,6 +1065,7 @@ static int start_opal_session_cont(struct opal_dev =
*dev)
>=20
>  	dev->hsn =3D hsn;
>  	dev->tsn =3D tsn;
> +
>  	return 0;
>  }
>=20
> @@ -1084,6 +1088,7 @@ static int end_session_cont(struct opal_dev *dev)
>  {
>  	dev->hsn =3D 0;
>  	dev->tsn =3D 0;
> +
>  	return parse_and_check_status(dev);
>  }
>=20
> @@ -1172,6 +1177,7 @@ static int gen_key(struct opal_dev *dev, void *data=
)
>  		return err;
>=20
>  	}
> +
>  	return finalize_and_send(dev, parse_and_check_status);
>  }
>=20
> @@ -1184,12 +1190,14 @@ static int get_active_key_cont(struct opal_dev *d=
ev)
>  	error =3D parse_and_check_status(dev);
>  	if (error)
>  		return error;
> +
>  	keylen =3D response_get_string(&dev->parsed, 4, &activekey);
>  	if (!activekey) {
>  		pr_debug("%s: Couldn't extract the Activekey from the response\n",
>  			 __func__);
>  		return OPAL_INVAL_PARAM;
>  	}
> +
>  	dev->prev_data =3D kmemdup(activekey, keylen, GFP_KERNEL);
>=20
>  	if (!dev->prev_data)
> @@ -1251,6 +1259,7 @@ static int generic_lr_enable_disable(struct opal_de=
v *dev,
>=20
>  	add_token_u8(&err, dev, OPAL_ENDLIST);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
> +
>  	return err;
>  }
>=20
> @@ -1263,6 +1272,7 @@ static inline int enable_global_lr(struct opal_dev =
*dev, u8 *uid,
>  					0, 0);
>  	if (err)
>  		pr_debug("Failed to create enable global lr command\n");
> +
>  	return err;
>  }
>=20
> @@ -1313,7 +1323,6 @@ static int setup_locking_range(struct opal_dev *dev=
, void *data)
>  	if (err) {
>  		pr_debug("Error building Setup Locking range command.\n");
>  		return err;
> -
>  	}
>=20
>  	return finalize_and_send(dev, parse_and_check_status);
> @@ -1393,6 +1402,7 @@ static int start_SIDASP_opal_session(struct opal_de=
v *dev, void *data)
>  		kfree(key);
>  		dev->prev_data =3D NULL;
>  	}
> +
>  	return ret;
>  }
>=20
> @@ -1518,6 +1528,7 @@ static int erase_locking_range(struct opal_dev *dev=
, void *data)
>  		pr_debug("Error building Erase Locking Range Command.\n");
>  		return err;
>  	}
> +
>  	return finalize_and_send(dev, parse_and_check_status);
>  }
>=20
> @@ -1636,6 +1647,7 @@ static int write_shadow_mbr(struct opal_dev *dev, v=
oid *data)
>=20
>  		off +=3D len;
>  	}
> +
>  	return err;
>  }
>=20
> @@ -1816,6 +1828,7 @@ static int lock_unlock_locking_range(struct opal_de=
v *dev, void *data)
>  		pr_debug("Error building SET command.\n");
>  		return err;
>  	}
> +
>  	return finalize_and_send(dev, parse_and_check_status);
>  }
>=20
> @@ -1857,6 +1870,7 @@ static int lock_unlock_locking_range_sum(struct opa=
l_dev *dev, void *data)
>  		pr_debug("Error building SET command.\n");
>  		return ret;
>  	}
> +
>  	return finalize_and_send(dev, parse_and_check_status);
>  }
>=20
> @@ -1957,6 +1971,7 @@ static int end_opal_session(struct opal_dev *dev, v=
oid *data)
>=20
>  	if (err < 0)
>  		return err;
> +
>  	return finalize_and_send(dev, end_session_cont);
>  }
>=20
> @@ -1965,6 +1980,7 @@ static int end_opal_session_error(struct opal_dev *=
dev)
>  	const struct opal_step error_end_session =3D {
>  		end_opal_session,
>  	};
> +
>  	return execute_step(dev, &error_end_session, 0);
>  }
>=20
> @@ -1984,6 +2000,7 @@ static int check_opal_support(struct opal_dev *dev)
>  	ret =3D opal_discovery0_step(dev);
>  	dev->supported =3D !ret;
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2004,6 +2021,7 @@ void free_opal_dev(struct opal_dev *dev)
>  {
>  	if (!dev)
>  		return;
> +
>  	clean_opal_dev(dev);
>  	kfree(dev);
>  }
> @@ -2026,6 +2044,7 @@ struct opal_dev *init_opal_dev(void *data, sec_send=
_recv *send_recv)
>  		kfree(dev);
>  		return NULL;
>  	}
> +
>  	return dev;
>  }
>  EXPORT_SYMBOL(init_opal_dev);
> @@ -2045,6 +2064,7 @@ static int opal_secure_erase_locking_range(struct o=
pal_dev *dev,
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2062,6 +2082,7 @@ static int opal_erase_locking_range(struct opal_dev=
 *dev,
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2089,6 +2110,7 @@ static int opal_enable_disable_shadow_mbr(struct op=
al_dev *dev,
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2113,6 +2135,7 @@ static int opal_set_mbr_done(struct opal_dev *dev,
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2133,6 +2156,7 @@ static int opal_write_shadow_mbr(struct opal_dev *d=
ev,
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2151,6 +2175,7 @@ static int opal_save(struct opal_dev *dev, struct o=
pal_lock_unlock *lk_unlk)
>  	setup_opal_dev(dev);
>  	add_suspend_info(dev, suspend);
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return 0;
>  }
>=20
> @@ -2169,12 +2194,14 @@ static int opal_add_user_to_lr(struct opal_dev *d=
ev,
>  		pr_debug("Locking state was not RO or RW\n");
>  		return -EINVAL;
>  	}
> +
>  	if (lk_unlk->session.who < OPAL_USER1 ||
>  	    lk_unlk->session.who > OPAL_USER9) {
>  		pr_debug("Authority was not within the range of users: %d\n",
>  			 lk_unlk->session.who);
>  		return -EINVAL;
>  	}
> +
>  	if (lk_unlk->session.sum) {
>  		pr_debug("%s not supported in sum. Use setup locking range\n",
>  			 __func__);
> @@ -2185,6 +2212,7 @@ static int opal_add_user_to_lr(struct opal_dev *dev=
,
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, steps, ARRAY_SIZE(steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2267,6 +2295,7 @@ static int opal_lock_unlock(struct opal_dev *dev,
>  	mutex_lock(&dev->dev_lock);
>  	ret =3D __opal_lock_unlock(dev, lk_unlk);
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2289,6 +2318,7 @@ static int opal_take_ownership(struct opal_dev *dev=
, struct opal_key *opal)
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, owner_steps, ARRAY_SIZE(owner_steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2310,6 +2340,7 @@ static int opal_activate_lsp(struct opal_dev *dev,
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, active_steps, ARRAY_SIZE(active_steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2327,6 +2358,7 @@ static int opal_setup_locking_range(struct opal_dev=
 *dev,
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2347,6 +2379,7 @@ static int opal_set_new_pw(struct opal_dev *dev, st=
ruct opal_new_pw *opal_pw)
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2371,6 +2404,7 @@ static int opal_activate_user(struct opal_dev *dev,
>  	setup_opal_dev(dev);
>  	ret =3D execute_steps(dev, act_steps, ARRAY_SIZE(act_steps));
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return ret;
>  }
>=20
> @@ -2382,6 +2416,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>=20
>  	if (!dev)
>  		return false;
> +
>  	if (!dev->supported)
>  		return false;
>=20
> @@ -2399,6 +2434,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>  				 suspend->unlk.session.sum);
>  			was_failure =3D true;
>  		}
> +
>  		if (dev->mbr_enabled) {
>  			ret =3D __opal_set_mbr_done(dev, &suspend->unlk.session.opal_key);
>  			if (ret)
> @@ -2406,6 +2442,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>  		}
>  	}
>  	mutex_unlock(&dev->dev_lock);
> +
>  	return was_failure;
>  }
>  EXPORT_SYMBOL(opal_unlock_from_suspend);
> --
> 2.17.1
>=20

--=-Ffwn30Q8mTLlbnpb2amG
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKeTCCBOsw
ggPToAMCAQICEFLpAsoR6ESdlGU4L6MaMLswDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UEBhMCU0Ux
FDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0
d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0xMzAzMTkwMDAwMDBa
Fw0yMDA1MzAxMDQ4MzhaMHkxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEUMBIGA1UEBxMLU2Fu
dGEgQ2xhcmExGjAYBgNVBAoTEUludGVsIENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBFeHRl
cm5hbCBCYXNpYyBJc3N1aW5nIENBIDRBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
4LDMgJ3YSVX6A9sE+jjH3b+F3Xa86z3LLKu/6WvjIdvUbxnoz2qnvl9UKQI3sE1zURQxrfgvtP0b
Pgt1uDwAfLc6H5eqnyi+7FrPsTGCR4gwDmq1WkTQgNDNXUgb71e9/6sfq+WfCDpi8ScaglyLCRp7
ph/V60cbitBvnZFelKCDBh332S6KG3bAdnNGB/vk86bwDlY6omDs6/RsfNwzQVwo/M3oPrux6y6z
yIoRulfkVENbM0/9RrzQOlyK4W5Vk4EEsfW2jlCV4W83QKqRccAKIUxw2q/HoHVPbbETrrLmE6RR
Z/+eWlkGWl+mtx42HOgOmX0BRdTRo9vH7yeBowIDAQABo4IBdzCCAXMwHwYDVR0jBBgwFoAUrb2Y
ejS0Jvf6xCZU7wO94CTLVBowHQYDVR0OBBYEFB5pKrTcKP5HGE4hCz+8rBEv8Jj1MA4GA1UdDwEB
/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMDYGA1UdJQQvMC0GCCsGAQUFBwMEBgorBgEEAYI3
CgMEBgorBgEEAYI3CgMMBgkrBgEEAYI3FQUwFwYDVR0gBBAwDjAMBgoqhkiG+E0BBQFpMEkGA1Ud
HwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwudHJ1c3QtcHJvdmlkZXIuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDoGCCsGAQUFBwEBBC4wLDAqBggrBgEFBQcwAYYeaHR0cDovL29jc3AudHJ1
c3QtcHJvdmlkZXIuY29tMDUGA1UdHgQuMCygKjALgQlpbnRlbC5jb20wG6AZBgorBgEEAYI3FAID
oAsMCWludGVsLmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAKcLNo/2So1Jnoi8G7W5Q6FSPq1fmyKW3
sSDf1amvyHkjEgd25n7MKRHGEmRxxoziPKpcmbfXYU+J0g560nCo5gPF78Wd7ZmzcmCcm1UFFfIx
fw6QA19bRpTC8bMMaSSEl8y39Pgwa+HENmoPZsM63DdZ6ziDnPqcSbcfYs8qd/m5d22rpXq5IGVU
tX6LX7R/hSSw/3sfATnBLgiJtilVyY7OGGmYKCAS2I04itvSS1WtecXTt9OZDyNbl7LtObBrgMLh
ZkpJW+pOR9f3h5VG2S5uKkA7Th9NC9EoScdwQCAIw+UWKbSQ0Isj2UFL7fHKvmqWKVTL98sRzvI3
seNC4DCCBYYwggRuoAMCAQICEzMAAMamAkocC+WQNPgAAAAAxqYwDQYJKoZIhvcNAQEFBQAweTEL
MAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMR
SW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3Vpbmcg
Q0EgNEEwHhcNMTgxMDE3MTgxODQzWhcNMTkxMDEyMTgxODQzWjBHMRowGAYDVQQDExFEZXJyaWNr
LCBKb25hdGhhbjEpMCcGCSqGSIb3DQEJARYaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20wggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCjUTRFAcK/fny1Eh3T7Q0iD+MSCPo7ZnIoW/hI
/jifxPTtccOjZgp1NsXP5uPvpZERSz/VK5pyHJ5H0YZhkP17F4Ccdap2yL3cmfBwBNUeyNUsQ9AL
1kBq1JfsUb+VDAEYwXLAY7Yuame4VsqAU24ZqQ1FOee+a1sPRPnJwfdtbJDP6qtS2sLMlahOlMrz
s64sbhqEEXyCKujbQdpMupaSkBIqBsOXpqKgFZJrD1A/ZC5jE4SF27Y98C6FOfrA7VGDdX5lxwH0
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDgxNDIwMjYxM1owIwYJ
KoZIhvcNAQkEMRYEFAmNGjIAhS2xVQYDGka7ZiPIqYvuMA0GCSqGSIb3DQEBAQUABIIBAAYDPFsK
T9ycLZj3rFJxNvNaJYmFP6kjLnahl1Rs+osU4egjz4UEOKzCblachLAALaGWw+LkFTUimDiEfpW0
Y59tcdo/LffhfxcAlqjJyCfenXGsoyshFvzS4hfIG2MAhnkCIwTl7fFORYLLVGhuXe+oMFVRop4E
iSB/DfEj2VX2cSgSjG0X11EziZqt+VDx7h2fWpPInzhZEx1UqqWeqqMBmPGmLA8m4sS1WGM0EaUW
yVGIZRFGjamlQ4OW8BM0UPGqeDbYzYnaxwTkqYZF+c3FES7LPNgRcG9x/8Z4w9SEXAD2F2dpRAaB
mve5joz4uAtNYFiyL9+KmMJSv7ncfvAAAAAAAAA=


--=-Ffwn30Q8mTLlbnpb2amG--
