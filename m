Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692253;
	b=vRLwF2WJnM82wryQ+bt9CP5JQeh4DOyZMP3fELen0YGcgW20TimW4rZBRju0+SCKke8w
	 X27ubM9jdHYSvceesa9UVNYTDSTeiAYxbBjakEzpH7p8F4hPYmjDCfvJ917pXtlAgPHEC
	 RD7RwwNBVzHUkNo9LG08vsYr4yliKz9wxBFNuWvAgOlrptRjIssC+rfbKtGj57+98EbEC
	 8+w+E3aK2ADFiIyKg9I7EoCO9XFGvIUE01ZBfaYiVnsiimv+3a5y+n3RPldtImfkKzj7f
	 O2PmF36taQskJVOGH/z8q0xbttXNtbqDRSWyjnaU9r58oF4gVNGi9nRA9wcAUIeYEXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692253;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4PQzyrJId5iFWaXv2F4psoT+ZCMTu5VTBd79sMj6dkA=;
	b=Yo+JkZZtlgmQcNPx6HYx2AJwxE67bzJOSO4WEh6+eOwG9mDtK112j07abMjYkE417OqV
	 VsjyHHLYdEzCFXp2fJLWXokP6RF++nYkqEhSPQUUFsDCpz2MRcfs26IqsIn8Ji+wS3V8j
	 YeC7nIK43HDq++C2laYfR3TFcF1NqXSt6Z5FPo+sZ/opjn2djntzTFu1FWJ6fhLap3t5x
	 sMKMg20uLLhQn9HJ8E1ZgX+Nlep1bEpFe8eJyudOt13qJ9z83gNYZJLPVktY51UFN7639
	 JZXxbwTwvLaeAmtecDnObBzEj8V9WOdp1/brnjFtOKc70PoaBqhakTrtgDgaqy9XTEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ajVI3Ww/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151B606A334;
	Thu, 26 Nov 2026 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajVI3Ww/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739E01F000EF;
	Thu, 26 Nov 2026 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692252;
	bh=4PQzyrJId5iFWaXv2F4psoT+ZCMTu5VTBd79sMj6dkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ajVI3Ww/N7PAJe7092To6cY8rWgzFqrcrs6UXSAuTJNH1HZJQnIOpj+FrFFHIqzFF
	 OsPMXZb4DtkvzY5DRK/o8hLmPC6ix/7525XrdynXpw4N1d/gIyj2/vrcItCMloczHb
	 /mw9oGdx77u4Uxfn+Q1rTm/EV51uV6CXfySfBpV995msTiufAwssHI4QKlQctfGBMm
	 r2/uGUXMCu5aklbrYAMeUlBvM9iuNm5UZ7nBfOKP77AeY3Krvn0US5muR16rMAARC9
	 Yz9ql3slzAuZHgncHWOeq9glUjBjg48mkBHmQUU8f7Ds4LUC3ocTshwKkUe1lnoIgr
	 Pta62UY9BZ18g==
Date: Thu, 26 Nov 2026 12:24:08 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] zram: do not modify cont sysfs store buffers
Message-ID: <awgV_Ngg8HLMUcsS@devuan>
References: <20261126014518.1318583-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dgsjs2ke7evooars"
Content-Disposition: inline
In-Reply-To: <20261126014518.1318583-1-senozhatsky@chromium.org>


--dgsjs2ke7evooars
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] zram: do not modify cont sysfs store buffers
Message-ID: <awgV_Ngg8HLMUcsS@devuan>
References: <20261126014518.1318583-1-senozhatsky@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20261126014518.1318583-1-senozhatsky@chromium.org>

Hi Sergey,

> Date: 2026-11-26 10:45:07+0900
> From: Sergey Senozhatsky <senozhatsky@chromium.org>
>
> zram sysfs handlers that accept key=3Dvalue arguments (e.g.
> algorithm_params_store(), etc.) pass their const char *buf
> parameter through skip_spaces(), discarding const, and then
> mutate it in-place via next_arg().  This is not dangerous
> per se because kernfs_fop_write_iter() passes a temp copy
> of user string to zram, however it is still probably worth
> fixing, just for the sake of correctness.
>=20
> Allocate a temp non-const buffer for args tokenisation.
>=20
> Link: https://lore.kernel.org/all/awcpkJD6K1xtx_Pe@devuan/
> Reported-by: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 96b135e3f727..ca12c1918aec 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1279,10 +1279,15 @@ static ssize_t writeback_store(struct device *dev,
>  	unsigned long lo =3D 0, hi;
>  	struct zram_pp_ctl *pp_ctl =3D NULL;
>  	struct zram_wb_ctl *wb_ctl =3D NULL;
> +	char *kbuf __free(kfree) =3D NULL;
>  	char *args, *param, *val;
>  	ssize_t ret =3D len;
>  	int err, mode =3D 0;
> =20
> +	kbuf =3D kstrndup(buf, len, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +

Thanks!  The fix sounds good to me.  While this could be a breaking,
since we're changing (or rather, not changing anymore) the string held
by the caller, I assume the caller didn't want it changed (since it was
const-qualified).  Thus,

Reviewed-by: Alejandro Colomar <alx@kernel.org>


Have a lovely day!
Alex

>  	guard(rwsem_write)(&zram->dev_lock);
>  	if (!init_done(zram))
>  		return -EINVAL;
> @@ -1303,7 +1308,7 @@ static ssize_t writeback_store(struct device *dev,
>  		goto out;
>  	}
> =20
> -	args =3D skip_spaces(buf);
> +	args =3D skip_spaces(kbuf);
>  	while (*args) {
>  		args =3D next_arg(args, &param, &val);
> =20
> @@ -1779,12 +1784,17 @@ static ssize_t algorithm_params_store(struct devi=
ce *dev,
>  	char *args, *param, *val, *algo =3D NULL, *dict_path =3D NULL;
>  	struct deflate_params deflate_params;
>  	struct zram *zram =3D dev_to_zram(dev);
> +	char *kbuf __free(kfree) =3D NULL;
>  	bool prio_param =3D false;
>  	int ret;
> =20
>  	deflate_params.winbits =3D ZCOMP_PARAM_NOT_SET;
> =20
> -	args =3D skip_spaces(buf);
> +	kbuf =3D kstrndup(buf, len, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	args =3D skip_spaces(kbuf);
>  	while (*args) {
>  		args =3D next_arg(args, &param, &val);
> =20
> @@ -1899,12 +1909,17 @@ static ssize_t recomp_algorithm_store(struct devi=
ce *dev,
>  				      size_t len)
>  {
>  	struct zram *zram =3D dev_to_zram(dev);
> +	char *kbuf __free(kfree) =3D NULL;
>  	int prio =3D ZRAM_SECONDARY_COMP;
>  	char *args, *param, *val;
>  	char *alg =3D NULL;
>  	int ret;
> =20
> -	args =3D skip_spaces(buf);
> +	kbuf =3D kstrndup(buf, len, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	args =3D skip_spaces(kbuf);
>  	while (*args) {
>  		args =3D next_arg(args, &param, &val);
> =20
> @@ -2578,6 +2593,7 @@ static ssize_t recompress_store(struct device *dev,
>  	struct zram *zram =3D dev_to_zram(dev);
>  	char *args, *param, *val, *algo =3D NULL;
>  	u64 num_recomp_pages =3D ULLONG_MAX;
> +	char *kbuf __free(kfree) =3D NULL;
>  	struct zram_pp_ctl *ctl =3D NULL;
>  	s32 prio =3D ZRAM_SECONDARY_COMP;
>  	u32 mode =3D 0, threshold =3D 0;
> @@ -2586,7 +2602,11 @@ static ssize_t recompress_store(struct device *dev,
>  	bool prio_param =3D false;
>  	ssize_t ret;
> =20
> -	args =3D skip_spaces(buf);
> +	kbuf =3D kstrndup(buf, len, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	args =3D skip_spaces(kbuf);
>  	while (*args) {
>  		args =3D next_arg(args, &param, &val);
> =20
> --=20
> 2.56.1.839.g22a8290db9-goog
>=20

--=20
<https://www.alejandro-colomar.es>

--dgsjs2ke7evooars
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsIFtIACgkQ64mZXMKQ
wqmnnw/+IhueUt4H5bq+DHR3fv4lOq4IBzTRkEugCwDpfAR3Ckp7cjPP4SnHl3ty
PzPlpWL2ljrwnILODZ51c+1MT6cazfEzFSTzYPLwHxT94wRz+RbD0hSwsNEYrRnJ
YJJ1Lh6V86Gj5qv9hwwYhelbzRrESW8GNVvVh0XJ/GEoSjkhoXCP2VZ45iNk3f9K
qzseQFCcni91uW5szgY+SpeJVBxQCEFvVNsOKmcfnemeGJIVRwHTOLrng2zy8J8q
h4o0XjhGG2olNbK3GuuhfDgHq7XPop0WPflv1Q+rcNIKEXQS95OMwqW8u0Mqh3ow
2MnAAM20bAHRgZ1i8utJ6IOwJbD59Hi+9bSh3+NluYdDyLYKTFxAE/BcXhG1eCDC
kLsdGzy4VvlQjpyqiCItPHkZ7l81gDePUoq4Aoxe87272AZDTYdVmRX3tA0wF6KH
8hX4aLrP6i/NE/pJ3xk2JfctH0XS903LZc0E9B5X7rw9zbb3j4f0f3BO/L5DBroJ
ev51US0NJHz5sWsS6S5qLTvf8QP5168cD8OPUJkx7R3OWFecwSZyZeZ/8IJqjjFT
VrKG3eFbgEtMmoizFmDa221jtl2qfyDRezW5eUHmKYuN07fBfA8hyGKX1ut4LtKs
X1fK5yrOO5wOZMmfu/HFO9NFNCx1WHg5ILnXIbx2wM9nwCDUICA=
=q8RM
-----END PGP SIGNATURE-----

--dgsjs2ke7evooars--
