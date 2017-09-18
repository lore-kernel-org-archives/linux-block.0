Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:44223 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdIRHxs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2017 03:53:48 -0400
Received: by mail-wm0-f47.google.com with SMTP id 189so11855161wmh.1
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2017 00:53:47 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <3891AF6A-D87D-4727-BF9C-E6689C232BC9@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4DB70E02-A842-429A-9B1C-91CDFFFB496F";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2] lightnvm: protect target type list with correct locks
Date: Mon, 18 Sep 2017 09:53:43 +0200
In-Reply-To: <20170916183931.GA2824@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170916183931.GA2824@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_4DB70E02-A842-429A-9B1C-91CDFFFB496F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 16 Sep 2017, at 20.39, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> nvm_tgt_types list was protected by wrong lock for NVM_INFO ioctl call
> and can race with addition or removal of target types.  Also
> unregistering target type was not protected correctly.
>=20
> Fixes: 5cd907853 ("lightnvm: remove nested lock conflict with mm")
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
>=20
> V2: also add correct lock while unregistering and fix "Fixes" tag at
> end.  Note I found these while investigating another issue and
> skimming the core code but worth fixing.
>=20
> drivers/lightnvm/core.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 9f9a137..1b8338d 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -589,9 +589,9 @@ void nvm_unregister_tgt_type(struct nvm_tgt_type =
*tt)
> 	if (!tt)
> 		return;
>=20
> -	down_write(&nvm_lock);
> +	down_write(&nvm_tgtt_lock);
> 	list_del(&tt->list);
> -	up_write(&nvm_lock);
> +	up_write(&nvm_tgtt_lock);
> }
> EXPORT_SYMBOL(nvm_unregister_tgt_type);
>=20
> @@ -1190,7 +1190,7 @@ static long nvm_ioctl_info(struct file *file, =
void __user *arg)
> 	info->version[1] =3D NVM_VERSION_MINOR;
> 	info->version[2] =3D NVM_VERSION_PATCH;
>=20
> -	down_write(&nvm_lock);
> +	down_write(&nvm_tgtt_lock);
> 	list_for_each_entry(tt, &nvm_tgt_types, list) {
> 		struct nvm_ioctl_info_tgt *tgt =3D =
&info->tgts[tgt_iter];
>=20
> @@ -1203,7 +1203,7 @@ static long nvm_ioctl_info(struct file *file, =
void __user *arg)
> 	}
>=20
> 	info->tgtsize =3D tgt_iter;
> -	up_write(&nvm_lock);
> +	up_write(&nvm_tgtt_lock);
>=20
> 	if (copy_to_user(arg, info, sizeof(struct nvm_ioctl_info))) {
> 		kfree(info);
> --
> 2.7.4

LGTM.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_4DB70E02-A842-429A-9B1C-91CDFFFB496F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZv3uIAAoJEGMfBTt1mRjK4gUP/i4ShpYqWf8scpuWAbW+R5Ki
hh0TW4Gl9Ij24h+b4jgQl8C13oJv6Fqf8gGWfJsneEAKLirFMJIv0VO4COFCfubN
cFL/iS/KA/pWuJyHLg7c8Q3GBLmXN+CvqamrA6JWxUcFrrqBU7cUqqdMOHfnR65U
FQZTo0cjvNDK9beTPCg4OPJn+R0DqrZRVy4K3hf/JCtEdmnp6fbcaNqaxb9LcTRv
QrlZy9JhE1MaLW/wnM8OpZF7RI8CDk2s6t58RSWrE04aKHDO6H2ORvhNV8elximS
HHEzmgxjs0uVOJbUi4U9E68mADPJ9mYOy9sGFWTJ1RcTT5wCNe/i2AzTuTMIsX0B
Xqa+AYIUbmhIoe+lrRrb6GFRT/7NSjYEPAm2f6+hOg89u5j/HMW1RrOgVYkZo/zW
uog7WnUK3moGGaRi7BdIYZzwpEld4/o95Kly9pIMje38s/zSKC23Sh80bJbFBLbD
OpQGRRUFjDOGhzMjnEWBsvrT410FTOSG+oEUcgoS2PD7xzUNK+szl3qNk5INvJ9r
n74lXOqig64PrYCL3SOGBv5lEEi50YbCU2mpEowrqtKXMwR3hOALuj7ZM/BPwv2B
Mjt7joW/gC6BFNPvR/sUh9nCaY/GWvipnhqKRI0LTldZsS0wgZroE+slYOWVErW+
3OHZpW7uCslWr6OPWDJg
=jd7t
-----END PGP SIGNATURE-----

--Apple-Mail=_4DB70E02-A842-429A-9B1C-91CDFFFB496F--
