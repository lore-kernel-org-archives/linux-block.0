Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92541C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565C920811
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfC1Po7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:44:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:33604 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfC1Po7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 11:44:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 08:44:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="p7s'?scan'208";a="146042693"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga002.jf.intel.com with ESMTP; 28 Mar 2019 08:44:58 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 28 Mar 2019 08:44:57 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.133]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.82]) with mapi id 14.03.0415.000;
 Thu, 28 Mar 2019 08:44:57 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 15/16] block: sed-opal: don't repeat opal_discovery0 in
 each steps array
Thread-Topic: [PATCH 15/16] block: sed-opal: don't repeat opal_discovery0 in
 each steps array
Thread-Index: AQHUw/qsborgKU2nxkC58fi5TMC1SaYh58SA
Date:   Thu, 28 Mar 2019 15:44:57 +0000
Message-ID: <4419d15d7931a5c52315305fd95f3a740efd1273.camel@intel.com>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1550103368-4605-16-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1550103368-4605-16-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.25]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-dd5CgGn1zKGHUzWPZwU0"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-dd5CgGn1zKGHUzWPZwU0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Jon Derrick <jonathan.derrick@intel.com>

On Thu, 2019-02-14 at 01:16 +0100, David Kozub wrote:
> Originally each of the opal functions that call next include
> opal_discovery0 in the array of steps. This is superfluous and
> can be done always inside next.
>=20
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> ---
>  block/sed-opal.c | 75 +++++++++++++++++++++++++++-------------------
> --
>  1 file changed, 42 insertions(+), 33 deletions(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index f027c0cb682e..b947efd6d4d9 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -216,6 +216,7 @@ static const u8 opalmethod[][OPAL_METHOD_LENGTH]
> =3D {
>  };
> =20
>  static int end_opal_session_error(struct opal_dev *dev);
> +static int opal_discovery0_step(struct opal_dev *dev);
> =20
>  struct opal_suspend_data {
>  	struct opal_lock_unlock unlk;
> @@ -381,17 +382,33 @@ static void check_geometry(struct opal_dev
> *dev, const void *data)
>  	dev->lowest_lba =3D geo->lowest_aligned_lba;
>  }
> =20
> +static int execute_step(struct opal_dev *dev,
> +			const struct opal_step *step, size_t stepIndex)
> +{
> +	int error =3D step->fn(dev, step->data);
> +
> +	if (error) {
> +		pr_debug("Step %zu (%pS) failed with error %d: %s\n",
> +			 stepIndex, step->fn, error,
> +			 opal_error_to_human(error));
> +	}
> +
> +	return error;
> +}
> +
>  static int next(struct opal_dev *dev, const struct opal_step *steps,
>  		size_t n_steps)
>  {
> -	const struct opal_step *step;
> -	size_t state;
> -	int error =3D 0;
> +	size_t state =3D 0;
> +	int error;
> =20
> -	for (state =3D 0; state < n_steps; state++) {
> -		step =3D &steps[state];
> +	/* first do a discovery0 */
> +	error =3D opal_discovery0_step(dev);
> +	if (error)
> +		return error;
> =20
> -		error =3D step->fn(dev, step->data);
> +	for (state =3D 0; state < n_steps; state++) {
> +		error =3D execute_step(dev, &steps[state], state);
>  		if (error)
>  			goto out_error;
>  	}
> @@ -400,14 +417,14 @@ static int next(struct opal_dev *dev, const
> struct opal_step *steps,
> =20
>  out_error:
>  	/*
> -	 * For each OPAL command the first step in steps does a
> discovery0
> -	 * and the second step starts some sort of session. If an error
> occurred
> -	 * in the first two steps (and thus stopping the loop with
> state <=3D 1)
> -	 * then there was an error before or during the attempt to
> start a
> -	 * session. Therefore we shouldn't attempt to terminate a
> session, as
> -	 * one has not yet been created.
> +	 * For each OPAL command the first step in steps starts some
> sort of
> +	 * session. If an error occurred in the initial discovery0 or
> if an
> +	 * error occurred in the first step (and thus stopping the loop
> with
> +	 * state =3D=3D 0) then there was an error before or during the
> attempt to
> +	 * start a session. Therefore we shouldn't attempt to terminate
> a
> +	 * session, as one has not yet been created.
>  	 */
> -	if (state > 1)
> +	if (state > 0)
>  		end_opal_session_error(dev);
> =20
>  	return error;
> @@ -506,6 +523,14 @@ static int opal_discovery0(struct opal_dev *dev,
> void *data)
>  	return opal_discovery0_end(dev);
>  }
> =20
> +static int opal_discovery0_step(struct opal_dev *dev)
> +{
> +	const struct opal_step discovery0_step =3D {
> +		opal_discovery0,
> +	};
> +	return execute_step(dev, &discovery0_step, 0);
> +}
> +
>  static bool can_add(int *err, struct opal_dev *cmd, size_t len)
>  {
>  	if (*err)
> @@ -1831,10 +1856,10 @@ static int end_opal_session(struct opal_dev
> *dev, void *data)
> =20
>  static int end_opal_session_error(struct opal_dev *dev)
>  {
> -	const struct opal_step error_end_session[] =3D {
> -		{ end_opal_session, }
> +	const struct opal_step error_end_session =3D {
> +		end_opal_session,
>  	};
> -	return next(dev, error_end_session,
> ARRAY_SIZE(error_end_session));
> +	return execute_step(dev, &error_end_session, 0);
>  }
> =20
>  static inline void setup_opal_dev(struct opal_dev *dev)
> @@ -1846,14 +1871,11 @@ static inline void setup_opal_dev(struct
> opal_dev *dev)
> =20
>  static int check_opal_support(struct opal_dev *dev)
>  {
> -	const struct opal_step steps[] =3D {
> -		{ opal_discovery0, }
> -	};
>  	int ret;
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, steps, ARRAY_SIZE(steps));
> +	ret =3D opal_discovery0_step(dev);
>  	dev->supported =3D !ret;
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
> @@ -1906,7 +1928,6 @@ static int
> opal_secure_erase_locking_range(struct opal_dev *dev,
>  					   struct opal_session_info
> *opal_session)
>  {
>  	const struct opal_step erase_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_auth_opal_session, opal_session },
>  		{ get_active_key, &opal_session->opal_key.lr },
>  		{ gen_key, },
> @@ -1925,7 +1946,6 @@ static int opal_erase_locking_range(struct
> opal_dev *dev,
>  				    struct opal_session_info
> *opal_session)
>  {
>  	const struct opal_step erase_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_auth_opal_session, opal_session },
>  		{ erase_locking_range, opal_session },
>  		{ end_opal_session, }
> @@ -1946,7 +1966,6 @@ static int
> opal_enable_disable_shadow_mbr(struct opal_dev *dev,
>  		OPAL_TRUE : OPAL_FALSE;
> =20
>  	const struct opal_step mbr_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_admin1LSP_opal_session, &opal_mbr->key },
>  		{ set_mbr_done, &enable_disable },
>  		{ end_opal_session, },
> @@ -1989,7 +2008,6 @@ static int opal_add_user_to_lr(struct opal_dev
> *dev,
>  			       struct opal_lock_unlock *lk_unlk)
>  {
>  	const struct opal_step steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_admin1LSP_opal_session, &lk_unlk-
> >session.opal_key },
>  		{ add_user_to_lr, lk_unlk },
>  		{ end_opal_session, }
> @@ -2023,7 +2041,6 @@ static int opal_add_user_to_lr(struct opal_dev
> *dev,
>  static int opal_reverttper(struct opal_dev *dev, struct opal_key
> *opal)
>  {
>  	const struct opal_step revert_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_SIDASP_opal_session, opal },
>  		{ revert_tper, } /* controller will terminate session
> */
>  	};
> @@ -2048,13 +2065,11 @@ static int __opal_lock_unlock(struct opal_dev
> *dev,
>  			      struct opal_lock_unlock *lk_unlk)
>  {
>  	const struct opal_step unlock_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_auth_opal_session, &lk_unlk->session },
>  		{ lock_unlock_locking_range, lk_unlk },
>  		{ end_opal_session, }
>  	};
>  	const struct opal_step unlock_sum_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_auth_opal_session, &lk_unlk->session },
>  		{ lock_unlock_locking_range_sum, lk_unlk },
>  		{ end_opal_session, }
> @@ -2071,7 +2086,6 @@ static int __opal_set_mbr_done(struct opal_dev
> *dev, struct opal_key *key)
>  {
>  	u8 mbr_done_tf =3D OPAL_TRUE;
>  	const struct opal_step mbrdone_step[] =3D {
> -		{ opal_discovery0, },
>  		{ start_admin1LSP_opal_session, key },
>  		{ set_mbr_done, &mbr_done_tf },
>  		{ end_opal_session, }
> @@ -2098,7 +2112,6 @@ static int opal_lock_unlock(struct opal_dev
> *dev,
>  static int opal_take_ownership(struct opal_dev *dev, struct opal_key
> *opal)
>  {
>  	const struct opal_step owner_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_anybodyASP_opal_session, },
>  		{ get_msid_cpin_pin, },
>  		{ end_opal_session, },
> @@ -2122,7 +2135,6 @@ static int opal_activate_lsp(struct opal_dev
> *dev,
>  			     struct opal_lr_act *opal_lr_act)
>  {
>  	const struct opal_step active_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_SIDASP_opal_session, &opal_lr_act->key },
>  		{ get_lsp_lifecycle, },
>  		{ activate_lsp, opal_lr_act },
> @@ -2144,7 +2156,6 @@ static int opal_setup_locking_range(struct
> opal_dev *dev,
>  				    struct opal_user_lr_setup
> *opal_lrs)
>  {
>  	const struct opal_step lr_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_auth_opal_session, &opal_lrs->session },
>  		{ setup_locking_range, opal_lrs },
>  		{ end_opal_session, }
> @@ -2161,7 +2172,6 @@ static int opal_setup_locking_range(struct
> opal_dev *dev,
>  static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw
> *opal_pw)
>  {
>  	const struct opal_step pw_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_auth_opal_session, &opal_pw->session },
>  		{ set_new_pw, &opal_pw->new_user_pw },
>  		{ end_opal_session, }
> @@ -2185,7 +2195,6 @@ static int opal_activate_user(struct opal_dev
> *dev,
>  			      struct opal_session_info *opal_session)
>  {
>  	const struct opal_step act_steps[] =3D {
> -		{ opal_discovery0, },
>  		{ start_admin1LSP_opal_session, &opal_session->opal_key=20
> },
>  		{ internal_activate_user, opal_session },
>  		{ end_opal_session, }
> --=20
> 2.20.1
>=20

--=-dd5CgGn1zKGHUzWPZwU0
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDMyODE1NDQ1NVowIwYJ
KoZIhvcNAQkEMRYEFA/ZV0L6kOn/AtM+1e5bZ4NmXbSOMA0GCSqGSIb3DQEBAQUABIIBAA3Cju+D
w1UcbpGuXrJz7eAbV4JOFopX9TDpCw3roKFA8BePn4yVcdDJ8YE2/MPQzhBEtGkzGiqsDhcK3zx1
E6P8E50W7r5LzjrM+8ijMHPd4T6X0XlMUC87Kzupbih9HDEOy1l9kU/m7iF3QIQz5H5jqKm8HvtC
tgr04y15pzyEk5M/9gSlBnovxKiuqSlaQyLjVPVhqfUzZYbvPouFYhBgVtYXdQXNPu/llxzkspzl
SpTsO5a+g6LGvFxUxSwDrjoV6/P7o3/sWXqluRD6fxVAFC0uCQCul1AnLM9B/S62DgaOtj/6Lkfh
xyflaD9XEV5zWWIXuIxC32Lfgxcv7CoAAAAAAAA=


--=-dd5CgGn1zKGHUzWPZwU0--
