Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:44905 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdJCK1m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:27:42 -0400
Received: by mail-wm0-f53.google.com with SMTP id 196so5514176wma.1
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:27:42 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <4A687BD0-20E5-40F7-BEE7-802F722565C7@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_04D755AA-4BBA-410D-BEF5-13198DE7B4AB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/9] lightnvm: pblk: prevent gc kicks when gc is not
 operational
Date: Tue, 3 Oct 2017 12:27:17 +0200
In-Reply-To: <1507025113-13351-2-git-send-email-hans.ml.holmberg@owltronix.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1507025113-13351-2-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_04D755AA-4BBA-410D-BEF5-13198DE7B4AB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 12.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> GC can be kicked after it has been shut down when closing the last
> line during exit, resulting in accesses to freed structures.
>=20
> Make sure that GC is not triggered while it is not operational.
> Also make sure that GC won't be re-activated during exit when
> running on another processor by using timer_del_sync.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-gc.c   | 9 +++++----
> drivers/lightnvm/pblk-init.c | 1 +
> 2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 7b103bc..81efac1 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -478,10 +478,10 @@ void pblk_gc_should_start(struct pblk *pblk)
> {
> 	struct pblk_gc *gc =3D &pblk->gc;
>=20
> -	if (gc->gc_enabled && !gc->gc_active)
> +	if (gc->gc_enabled && !gc->gc_active) {
> 		pblk_gc_start(pblk);
> -
> -	pblk_gc_kick(pblk);
> +		pblk_gc_kick(pblk);
> +	}
> }
>=20
> /*
> @@ -620,7 +620,8 @@ void pblk_gc_exit(struct pblk *pblk)
> 	flush_workqueue(gc->gc_reader_wq);
> 	flush_workqueue(gc->gc_line_reader_wq);
>=20
> -	del_timer(&gc->gc_timer);
> +	gc->gc_enabled =3D 0;
> +	del_timer_sync(&gc->gc_timer);
> 	pblk_gc_stop(pblk, 1);
>=20
> 	if (gc->gc_ts)
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 0163914..ec7974b 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -928,6 +928,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 	pblk->dev =3D dev;
> 	pblk->disk =3D tdisk;
> 	pblk->state =3D PBLK_STATE_RUNNING;
> +	pblk->gc.gc_enabled =3D 0;
>=20
> 	spin_lock_init(&pblk->trans_lock);
> 	spin_lock_init(&pblk->lock);
> --
> 2.7.4

LGTM.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_04D755AA-4BBA-410D-BEF5-13198DE7B4AB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTZgUACgkQYx8FO3WZ
GMrEuQ/+MpabIEUCWh7Ih9IxJnLTRkKfAi5VBGNZ9QOJbnlxPt9/iZuMRHhxqVUP
TOpj6rFHzgi7x7sRgF07HyIGTlx06FAWHvBiIvT1LzXUt/Daq7S0yzr63bdruY5E
G3n8ytn9nBww3FJMjnwh4HsCK74ME9RCl+BSQveWOc9jzcE/M1UateEGixhGR0AW
fVtc8XcBpyDQ0p9pgrKWr/5v00gZ3ZabFuVrojeyGhwP5kmavl/C+XPbmIG7FEro
YMr46huJA6zQiSqz7kXlFrqiMndPMVnTHrkf2n3kYC4vHbzoEZIjAKJvJpU/QHvN
47tMbUixpIrsB/r8UyH2S/3yL8LThvKhnQXzt1FJk6vXdHRQ3Yegq8zR3vR23kEM
lEGYBQN7/y6COu3x/vuhQ38bJC57wHyEJT0YC9ZZKFGYCPZtxTdvoTcIQMBMCMEz
ngRjfxcuRFsnMwIVKkr7YNCZj/w8R3rPnPMdOiYljhThZgpuQTU8jWv3wFFcJRuL
mT/ml0GaccwdAEcvHNu9JLkEI4lbj+lg+7guJpegn6aeKF1kSuUL6v847iwIzaIh
zmFvfZsc9hf3qrStz7kw/yq/6GVvaZqZRmfle2biizz4mXn3j3eb+I+u8DrIa0c9
tw3bTZr51Eln7W0KEURutEQ3TWhFGG78DZoVeg628gli7XME3lE=
=/7ob
-----END PGP SIGNATURE-----

--Apple-Mail=_04D755AA-4BBA-410D-BEF5-13198DE7B4AB--
