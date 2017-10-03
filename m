Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:56847 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdJCKg3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:36:29 -0400
Received: by mail-wm0-f46.google.com with SMTP id l68so2033572wmd.5
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:36:29 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <71629B0C-633A-410F-843B-A07C863676A1@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FF39B534-222D-44D0-9F59-F354C33EEA75";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/9] lightnvm: pblk: free full lines during recovery
Date: Tue, 3 Oct 2017 12:36:25 +0200
In-Reply-To: <1507025113-13351-4-git-send-email-hans.ml.holmberg@owltronix.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1507025113-13351-4-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_FF39B534-222D-44D0-9F59-F354C33EEA75
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 12.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> When rebuilding the L2P table, any full lines(lines without any
> valid sectors) will be identified. If these lines are not freed,
> we risk not being able to allocate the first data line.
>=20
> This patch refactors the part of GC that frees empty lines
> into a separate function and adds a call to this after the
> L2P table has been rebuilt.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-gc.c   | 32 ++++++++++++++++++++------------
> drivers/lightnvm/pblk-init.c |  3 +++
> drivers/lightnvm/pblk.h      |  1 +
> 3 files changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 81efac1..374089f 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -330,26 +330,16 @@ static bool pblk_gc_should_run(struct pblk_gc =
*gc, struct pblk_rl *rl)
> 	return ((gc->gc_active) && (nr_blocks_need > nr_blocks_free));
> }
>=20
> -/*
> - * Lines with no valid sectors will be returned to the free list =
immediately. If
> - * GC is activated - either because the free block count is under the =
determined
> - * threshold, or because it is being forced from user space - only =
lines with a
> - * high count of invalid sectors will be recycled.
> - */
> -static void pblk_gc_run(struct pblk *pblk)
> +void pblk_gc_free_full_lines(struct pblk *pblk)
> {
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> -	struct pblk_gc *gc =3D &pblk->gc;
> 	struct pblk_line *line;
> -	struct list_head *group_list;
> -	bool run_gc;
> -	int inflight_gc, gc_group =3D 0, prev_group =3D 0;
>=20
> 	do {
> 		spin_lock(&l_mg->gc_lock);
> 		if (list_empty(&l_mg->gc_full_list)) {
> 			spin_unlock(&l_mg->gc_lock);
> -			break;
> +			return;
> 		}
>=20
> 		line =3D list_first_entry(&l_mg->gc_full_list,
> @@ -365,6 +355,24 @@ static void pblk_gc_run(struct pblk *pblk)
>=20
> 		kref_put(&line->ref, pblk_line_put);
> 	} while (1);
> +}
> +
> +/*
> + * Lines with no valid sectors will be returned to the free list =
immediately. If
> + * GC is activated - either because the free block count is under the =
determined
> + * threshold, or because it is being forced from user space - only =
lines with a
> + * high count of invalid sectors will be recycled.
> + */
> +static void pblk_gc_run(struct pblk *pblk)
> +{
> +	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> +	struct pblk_gc *gc =3D &pblk->gc;
> +	struct pblk_line *line;
> +	struct list_head *group_list;
> +	bool run_gc;
> +	int inflight_gc, gc_group =3D 0, prev_group =3D 0;
> +
> +	pblk_gc_free_full_lines(pblk);
>=20
> 	run_gc =3D pblk_gc_should_run(&pblk->gc, &pblk->rl);
> 	if (!run_gc || (atomic_read(&gc->inflight_gc) >=3D =
PBLK_GC_L_QD))
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index ec7974b..1cc3de4 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -508,6 +508,9 @@ static int pblk_lines_configure(struct pblk *pblk, =
int flags)
> 		}
> 	}
>=20
> +	/* Free full lines directly as GC has not been started yet */
> +	pblk_gc_free_full_lines(pblk);
> +
> 	if (!line) {
> 		/* Configure next line for user data */
> 		line =3D pblk_line_get_first_data(pblk);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index eaf5397..f76583b 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -831,6 +831,7 @@ void pblk_gc_should_start(struct pblk *pblk);
> void pblk_gc_should_stop(struct pblk *pblk);
> void pblk_gc_should_kick(struct pblk *pblk);
> void pblk_gc_kick(struct pblk *pblk);
> +void pblk_gc_free_full_lines(struct pblk *pblk);
> void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
> 			      int *gc_active);
> int pblk_gc_sysfs_force(struct pblk *pblk, int force);
> --
> 2.7.4

LGTM.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_FF39B534-222D-44D0-9F59-F354C33EEA75
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTaCkACgkQYx8FO3WZ
GMp/Og//Qu5+oOPqLrLePkiIDam981YJtj5NJNTuARSxq3OsPINVhh/LlXhWJKxG
fTdEVVqVm36NJYvO496AK/Jb5mbXk+k+1xY6Co9G06qBojptm9U+Oz4D56z3qHJ0
3zGORtzkmDyAZ8+6wyK+6EGMfRvDjEJZ6DxSYVr/p5WumJUyuoYwxwcpkrj0msW6
WelGXTEWk0y2KkZTpCNalFVNC046Au2Sp3c9W0f+akglmitMQHHppguLNbuU6jnQ
NUOwQjsKi7uxiOvQy0k8V5/GX39hg2kb8AjUReJ+PilefmNUXKgci57HTSukpEHX
KurU/rX5V5grAwsT9I1YHI1RwmuExwOxv9UuQz+zHDI82AkHJil5MPflPjTEAoHa
Kdggv3FZoDr04EjN9P8/cbsJyhDlpS5yG1jY43xA3wphfYLDEMK7DjED9qeh48Pq
q7CjQyBLlcuFNsrtB8vin1iQnPFxe6EfjkGgNll/ekrqOtKJ52d7XNqG09i3jnXz
mRqdb7770VsJCGgmPnrVC0MrflbskaRVUVJdjjYPxGwI4/pXokV/e/VFEglkwvw/
0WEy2XEwG1kZYu2AnueYqe2TzmQfVqxosK/ELH56kSXzMIzuelaYlCV6oTUzBM7e
McWg1Cd77e5dX0ZhrA3KnwTPnKezsrn6ZuizpGtMmKhtIzssRk8=
=jgjA
-----END PGP SIGNATURE-----

--Apple-Mail=_FF39B534-222D-44D0-9F59-F354C33EEA75--
