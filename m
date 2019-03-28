Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589EAC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196ED20811
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfC1PoQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:44:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:55631 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbfC1PoP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 11:44:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 08:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="p7s'?scan'208";a="218441990"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2019 08:44:14 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 28 Mar 2019 08:44:14 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.133]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.222]) with mapi id 14.03.0415.000;
 Thu, 28 Mar 2019 08:44:13 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 14/16] block: sed-opal: pass steps via argument rather
 than via opal_dev
Thread-Topic: [PATCH 14/16] block: sed-opal: pass steps via argument rather
 than via opal_dev
Thread-Index: AQHUw/qw/TPNq5pzdk6pWri7Y9nPGaYh54oA
Date:   Thu, 28 Mar 2019 15:44:13 +0000
Message-ID: <759b865987073bd0746c3e9e38b437515b1f249d.camel@intel.com>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1550103368-4605-15-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1550103368-4605-15-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.25]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-RtzD3xnTJDoUOBSqCtTo"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-RtzD3xnTJDoUOBSqCtTo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Jon Derrick <jonathan.derrick@intel.com>

On Thu, 2019-02-14 at 01:16 +0100, David Kozub wrote:
> The steps argument is only read by the next function, so it can
> be passed directly as an argument rather than via opal_dev.
>=20
> Normally, the steps is an array on the stack, so the pointer stops
> being valid then the function that set opal_dev.steps returns.
> If opal_dev.steps was not set to NULL before return it would become
> a dangling pointer. When the steps are passed as argument this
> becomes easier to see and more difficult to misuse.
>=20
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> ---
>  block/sed-opal.c | 158 +++++++++++++++++++++----------------------
> ----
>  1 file changed, 69 insertions(+), 89 deletions(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index be0d633783c8..f027c0cb682e 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -85,7 +85,6 @@ struct opal_dev {
>  	void *data;
>  	sec_send_recv *send_recv;
> =20
> -	const struct opal_step *steps;
>  	struct mutex dev_lock;
>  	u16 comid;
>  	u32 hsn;
> @@ -382,37 +381,34 @@ static void check_geometry(struct opal_dev
> *dev, const void *data)
>  	dev->lowest_lba =3D geo->lowest_aligned_lba;
>  }
> =20
> -static int next(struct opal_dev *dev)
> +static int next(struct opal_dev *dev, const struct opal_step *steps,
> +		size_t n_steps)
>  {
>  	const struct opal_step *step;
> -	int state =3D 0, error =3D 0;
> +	size_t state;
> +	int error =3D 0;
> =20
> -	do {
> -		step =3D &dev->steps[state];
> -		if (!step->fn)
> -			break;
> +	for (state =3D 0; state < n_steps; state++) {
> +		step =3D &steps[state];
> =20
>  		error =3D step->fn(dev, step->data);
> -		if (error) {
> -			pr_debug("Step %d (%pS) failed with error %d:
> %s\n",
> -				 state, step->fn, error,
> -				 opal_error_to_human(error));
> -
> -			/* For each OPAL command we do a discovery0
> then we
> -			 * start some sort of session.
> -			 * If we haven't passed state 1 then there was
> an error
> -			 * on discovery0 or during the attempt to start
> a
> -			 * session. Therefore we shouldn't attempt to
> terminate
> -			 * a session, as one has not yet been created.
> -			 */
> -			if (state > 1) {
> -				end_opal_session_error(dev);
> -				return error;
> -			}
> +		if (error)
> +			goto out_error;
> +	}
> =20
> -		}
> -		state++;
> -	} while (!error);
> +	return 0;
> +
> +out_error:
> +	/*
> +	 * For each OPAL command the first step in steps does a
> discovery0
> +	 * and the second step starts some sort of session. If an error
> occurred
> +	 * in the first two steps (and thus stopping the loop with
> state <=3D 1)
> +	 * then there was an error before or during the attempt to
> start a
> +	 * session. Therefore we shouldn't attempt to terminate a
> session, as
> +	 * one has not yet been created.
> +	 */
> +	if (state > 1)
> +		end_opal_session_error(dev);
> =20
>  	return error;
>  }
> @@ -1836,17 +1832,13 @@ static int end_opal_session(struct opal_dev
> *dev, void *data)
>  static int end_opal_session_error(struct opal_dev *dev)
>  {
>  	const struct opal_step error_end_session[] =3D {
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
> -	dev->steps =3D error_end_session;
> -	return next(dev);
> +	return next(dev, error_end_session,
> ARRAY_SIZE(error_end_session));
>  }
> =20
> -static inline void setup_opal_dev(struct opal_dev *dev,
> -				  const struct opal_step *steps)
> +static inline void setup_opal_dev(struct opal_dev *dev)
>  {
> -	dev->steps =3D steps;
>  	dev->tsn =3D 0;
>  	dev->hsn =3D 0;
>  	dev->prev_data =3D NULL;
> @@ -1855,14 +1847,13 @@ static inline void setup_opal_dev(struct
> opal_dev *dev,
>  static int check_opal_support(struct opal_dev *dev)
>  {
>  	const struct opal_step steps[] =3D {
> -		{ opal_discovery0, },
> -		{ NULL, }
> +		{ opal_discovery0, }
>  	};
>  	int ret;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, steps, ARRAY_SIZE(steps));
>  	dev->supported =3D !ret;
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
> @@ -1919,14 +1910,13 @@ static int
> opal_secure_erase_locking_range(struct opal_dev *dev,
>  		{ start_auth_opal_session, opal_session },
>  		{ get_active_key, &opal_session->opal_key.lr },
>  		{ gen_key, },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
>  	int ret;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, erase_steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, erase_steps, ARRAY_SIZE(erase_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -1938,14 +1928,13 @@ static int opal_erase_locking_range(struct
> opal_dev *dev,
>  		{ opal_discovery0, },
>  		{ start_auth_opal_session, opal_session },
>  		{ erase_locking_range, opal_session },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
>  	int ret;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, erase_steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, erase_steps, ARRAY_SIZE(erase_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -1963,8 +1952,7 @@ static int
> opal_enable_disable_shadow_mbr(struct opal_dev *dev,
>  		{ end_opal_session, },
>  		{ start_admin1LSP_opal_session, &opal_mbr->key },
>  		{ set_mbr_enable_disable, &enable_disable },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
>  	int ret;
> =20
> @@ -1973,8 +1961,8 @@ static int
> opal_enable_disable_shadow_mbr(struct opal_dev *dev,
>  		return -EINVAL;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, mbr_steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -1991,7 +1979,7 @@ static int opal_save(struct opal_dev *dev,
> struct opal_lock_unlock *lk_unlk)
>  	suspend->lr =3D lk_unlk->session.opal_key.lr;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, NULL);
> +	setup_opal_dev(dev);
>  	add_suspend_info(dev, suspend);
>  	mutex_unlock(&dev->dev_lock);
>  	return 0;
> @@ -2004,8 +1992,7 @@ static int opal_add_user_to_lr(struct opal_dev
> *dev,
>  		{ opal_discovery0, },
>  		{ start_admin1LSP_opal_session, &lk_unlk-
> >session.opal_key },
>  		{ add_user_to_lr, lk_unlk },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
>  	int ret;
> =20
> @@ -2027,8 +2014,8 @@ static int opal_add_user_to_lr(struct opal_dev
> *dev,
>  	}
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, steps, ARRAY_SIZE(steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2038,14 +2025,13 @@ static int opal_reverttper(struct opal_dev
> *dev, struct opal_key *opal)
>  	const struct opal_step revert_steps[] =3D {
>  		{ opal_discovery0, },
>  		{ start_SIDASP_opal_session, opal },
> -		{ revert_tper, }, /* controller will terminate session
> */
> -		{ NULL, }
> +		{ revert_tper, } /* controller will terminate session
> */
>  	};
>  	int ret;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, revert_steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, revert_steps, ARRAY_SIZE(revert_steps));
>  	mutex_unlock(&dev->dev_lock);
> =20
>  	/*
> @@ -2065,19 +2051,20 @@ static int __opal_lock_unlock(struct opal_dev
> *dev,
>  		{ opal_discovery0, },
>  		{ start_auth_opal_session, &lk_unlk->session },
>  		{ lock_unlock_locking_range, lk_unlk },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
>  	const struct opal_step unlock_sum_steps[] =3D {
>  		{ opal_discovery0, },
>  		{ start_auth_opal_session, &lk_unlk->session },
>  		{ lock_unlock_locking_range_sum, lk_unlk },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
> =20
> -	dev->steps =3D lk_unlk->session.sum ? unlock_sum_steps :
> unlock_steps;
> -	return next(dev);
> +	if (lk_unlk->session.sum)
> +		return next(dev, unlock_sum_steps,
> +			    ARRAY_SIZE(unlock_sum_steps));
> +	else
> +		return next(dev, unlock_steps,
> ARRAY_SIZE(unlock_steps));
>  }
> =20
>  static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key
> *key)
> @@ -2087,12 +2074,10 @@ static int __opal_set_mbr_done(struct
> opal_dev *dev, struct opal_key *key)
>  		{ opal_discovery0, },
>  		{ start_admin1LSP_opal_session, key },
>  		{ set_mbr_done, &mbr_done_tf },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
> =20
> -	dev->steps =3D mbrdone_step;
> -	return next(dev);
> +	return next(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
>  }
> =20
>  static int opal_lock_unlock(struct opal_dev *dev,
> @@ -2119,8 +2104,7 @@ static int opal_take_ownership(struct opal_dev
> *dev, struct opal_key *opal)
>  		{ end_opal_session, },
>  		{ start_SIDASP_opal_session, opal },
>  		{ set_sid_cpin_pin, opal },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
>  	int ret;
> =20
> @@ -2128,8 +2112,8 @@ static int opal_take_ownership(struct opal_dev
> *dev, struct opal_key *opal)
>  		return -ENODEV;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, owner_steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, owner_steps, ARRAY_SIZE(owner_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2142,8 +2126,7 @@ static int opal_activate_lsp(struct opal_dev
> *dev,
>  		{ start_SIDASP_opal_session, &opal_lr_act->key },
>  		{ get_lsp_lifecycle, },
>  		{ activate_lsp, opal_lr_act },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
>  	int ret;
> =20
> @@ -2151,8 +2134,8 @@ static int opal_activate_lsp(struct opal_dev
> *dev,
>  		return -EINVAL;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, active_steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, active_steps, ARRAY_SIZE(active_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2164,14 +2147,13 @@ static int opal_setup_locking_range(struct
> opal_dev *dev,
>  		{ opal_discovery0, },
>  		{ start_auth_opal_session, &opal_lrs->session },
>  		{ setup_locking_range, opal_lrs },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
>  	int ret;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, lr_steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, lr_steps, ARRAY_SIZE(lr_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2182,8 +2164,7 @@ static int opal_set_new_pw(struct opal_dev
> *dev, struct opal_new_pw *opal_pw)
>  		{ opal_discovery0, },
>  		{ start_auth_opal_session, &opal_pw->session },
>  		{ set_new_pw, &opal_pw->new_user_pw },
> -		{ end_opal_session, },
> -		{ NULL }
> +		{ end_opal_session, }
>  	};
>  	int ret;
> =20
> @@ -2194,8 +2175,8 @@ static int opal_set_new_pw(struct opal_dev
> *dev, struct opal_new_pw *opal_pw)
>  		return -EINVAL;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, pw_steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, pw_steps, ARRAY_SIZE(pw_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2207,8 +2188,7 @@ static int opal_activate_user(struct opal_dev
> *dev,
>  		{ opal_discovery0, },
>  		{ start_admin1LSP_opal_session, &opal_session->opal_key=20
> },
>  		{ internal_activate_user, opal_session },
> -		{ end_opal_session, },
> -		{ NULL, }
> +		{ end_opal_session, }
>  	};
>  	int ret;
> =20
> @@ -2220,8 +2200,8 @@ static int opal_activate_user(struct opal_dev
> *dev,
>  	}
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, act_steps);
> -	ret =3D next(dev);
> +	setup_opal_dev(dev);
> +	ret =3D next(dev, act_steps, ARRAY_SIZE(act_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2238,7 +2218,7 @@ bool opal_unlock_from_suspend(struct opal_dev
> *dev)
>  		return false;
> =20
>  	mutex_lock(&dev->dev_lock);
> -	setup_opal_dev(dev, NULL);
> +	setup_opal_dev(dev);
> =20
>  	list_for_each_entry(suspend, &dev->unlk_lst, node) {
>  		dev->tsn =3D 0;

--=-RtzD3xnTJDoUOBSqCtTo
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDMyODE1NDQwNlowIwYJ
KoZIhvcNAQkEMRYEFJvm1INvEFBFRf07XHHPMGQ4xmZdMA0GCSqGSIb3DQEBAQUABIIBADMzwSZN
OgE4SLvnbCC3Eo9pXU+TEF4SztozknuEdzXmKAYIxhzl5Vu7GjOWnexPdoCUGMXvK0gpwW3uIJQ8
Ahx+2nsF7zbSaA1ItxcEYtNzcTacL69gPSwp8vWhWIMjcPVxCzEM7v5oRxyvI0Acj5wneFTDrkFG
ZrJD+fea26hO3qOE4aAkiGj75qYhx00EIgf4WEJQZ0hCITVtyPg5o0yHgtfwnrx/GEMoLw8ZP0ps
39ZrwUzXe7TElM+/JCmIV/FAPDZV9wVAAmKqO5QS7UbhepfYDITgL+4oOuFgjH2kS8YI5Wkpjar4
3rGrfVNzefHe7bCmgTGx8ePj6vz3vcoAAAAAAAA=


--=-RtzD3xnTJDoUOBSqCtTo--
