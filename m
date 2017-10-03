Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:45712 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdJCKkc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:40:32 -0400
Received: by mail-wm0-f50.google.com with SMTP id q124so15783207wmb.0
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:40:31 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <EC46C086-33F6-44AD-8CA9-4320410E8664@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_87C3F9C6-B4ED-4BB3-8235-9CFB5294CA40";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 8/9] lightnvm: pblk: gc all lines in the pipeline before
 exit
Date: Tue, 3 Oct 2017 12:40:29 +0200
In-Reply-To: <1507025113-13351-9-git-send-email-hans.ml.holmberg@owltronix.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1507025113-13351-9-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_87C3F9C6-B4ED-4BB3-8235-9CFB5294CA40
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 12.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> Finish garbage collect of the lines that are in the gc pipeline
> before exiting. Ensure that all lines already in in the pipeline
> goes through, from read to write.
>=20
> Do this by keeping track of how many lines are in the pipeline
> and waiting for that number to reach zero before exiting the gc
> reader task.
>=20
> Since we're adding a new gc line counter, change the name of
> inflight_gc to read_inflight_gc to make the distinction clear.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-core.c  |  3 +++
> drivers/lightnvm/pblk-gc.c    | 31 ++++++++++++++++++++++++-------
> drivers/lightnvm/pblk-sysfs.c |  2 +-
> drivers/lightnvm/pblk.h       |  5 ++++-
> 4 files changed, 32 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 15e1e28..e62e6eb 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1463,6 +1463,7 @@ void pblk_line_free(struct pblk *pblk, struct =
pblk_line *line)
> static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
> {
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> +	struct pblk_gc *gc =3D &pblk->gc;
>=20
> 	spin_lock(&line->lock);
> 	WARN_ON(line->state !=3D PBLK_LINESTATE_GC);
> @@ -1471,6 +1472,8 @@ static void __pblk_line_put(struct pblk *pblk, =
struct pblk_line *line)
> 	pblk_line_free(pblk, line);
> 	spin_unlock(&line->lock);
>=20
> +	atomic_dec(&gc->pipeline_gc);
> +
> 	spin_lock(&l_mg->free_lock);
> 	list_add_tail(&line->list, &l_mg->free_list);
> 	l_mg->nr_free_lines++;
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index f343f90..475a13e 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -234,7 +234,7 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
> 	kfree(invalid_bitmap);
>=20
> 	kref_put(&line->ref, pblk_line_put);
> -	atomic_dec(&gc->inflight_gc);
> +	atomic_dec(&gc->read_inflight_gc);
>=20
> 	return;
>=20
> @@ -249,7 +249,7 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
>=20
> 	pblk_put_line_back(pblk, line);
> 	kref_put(&line->ref, pblk_line_put);
> -	atomic_dec(&gc->inflight_gc);
> +	atomic_dec(&gc->read_inflight_gc);
>=20
> 	pr_err("pblk: Failed to GC line %d\n", line->id);
> }
> @@ -268,6 +268,7 @@ static int pblk_gc_line(struct pblk *pblk, struct =
pblk_line *line)
> 	line_ws->pblk =3D pblk;
> 	line_ws->line =3D line;
>=20
> +	atomic_inc(&gc->pipeline_gc);
> 	INIT_WORK(&line_ws->ws, pblk_gc_line_prepare_ws);
> 	queue_work(gc->gc_reader_wq, &line_ws->ws);
>=20
> @@ -333,6 +334,7 @@ static bool pblk_gc_should_run(struct pblk_gc *gc, =
struct pblk_rl *rl)
> void pblk_gc_free_full_lines(struct pblk *pblk)
> {
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> +	struct pblk_gc *gc =3D &pblk->gc;
> 	struct pblk_line *line;
>=20
> 	do {
> @@ -353,6 +355,7 @@ void pblk_gc_free_full_lines(struct pblk *pblk)
> 		list_del(&line->list);
> 		spin_unlock(&l_mg->gc_lock);
>=20
> +		atomic_inc(&gc->pipeline_gc);
> 		kref_put(&line->ref, pblk_line_put);
> 	} while (1);
> }
> @@ -370,12 +373,12 @@ static void pblk_gc_run(struct pblk *pblk)
> 	struct pblk_line *line;
> 	struct list_head *group_list;
> 	bool run_gc;
> -	int inflight_gc, gc_group =3D 0, prev_group =3D 0;
> +	int read_inflight_gc, gc_group =3D 0, prev_group =3D 0;
>=20
> 	pblk_gc_free_full_lines(pblk);
>=20
> 	run_gc =3D pblk_gc_should_run(&pblk->gc, &pblk->rl);
> -	if (!run_gc || (atomic_read(&gc->inflight_gc) >=3D =
PBLK_GC_L_QD))
> +	if (!run_gc || (atomic_read(&gc->read_inflight_gc) >=3D =
PBLK_GC_L_QD))
> 		return;
>=20
> next_gc_group:
> @@ -402,14 +405,14 @@ static void pblk_gc_run(struct pblk *pblk)
> 		list_add_tail(&line->list, &gc->r_list);
> 		spin_unlock(&gc->r_lock);
>=20
> -		inflight_gc =3D atomic_inc_return(&gc->inflight_gc);
> +		read_inflight_gc =3D =
atomic_inc_return(&gc->read_inflight_gc);
> 		pblk_gc_reader_kick(gc);
>=20
> 		prev_group =3D 1;
>=20
> 		/* No need to queue up more GC lines than we can handle =
*/
> 		run_gc =3D pblk_gc_should_run(&pblk->gc, &pblk->rl);
> -		if (!run_gc || inflight_gc >=3D PBLK_GC_L_QD)
> +		if (!run_gc || read_inflight_gc >=3D PBLK_GC_L_QD)
> 			break;
> 	} while (1);
>=20
> @@ -470,6 +473,7 @@ static int pblk_gc_writer_ts(void *data)
> static int pblk_gc_reader_ts(void *data)
> {
> 	struct pblk *pblk =3D data;
> +	struct pblk_gc *gc =3D &pblk->gc;
>=20
> 	while (!kthread_should_stop()) {
> 		if (!pblk_gc_read(pblk))
> @@ -478,6 +482,18 @@ static int pblk_gc_reader_ts(void *data)
> 		io_schedule();
> 	}
>=20
> +#ifdef CONFIG_NVM_DEBUG
> +	pr_info("pblk: flushing gc pipeline, %d lines left\n",
> +		atomic_read(&gc->pipeline_gc));
> +#endif
> +
> +	do {
> +		if (!atomic_read(&gc->pipeline_gc))
> +			break;
> +
> +		schedule();
> +	} while (1);
> +
> 	return 0;
> }
>=20
> @@ -581,7 +597,8 @@ int pblk_gc_init(struct pblk *pblk)
> 	gc->gc_forced =3D 0;
> 	gc->gc_enabled =3D 1;
> 	gc->w_entries =3D 0;
> -	atomic_set(&gc->inflight_gc, 0);
> +	atomic_set(&gc->read_inflight_gc, 0);
> +	atomic_set(&gc->pipeline_gc, 0);
>=20
> 	/* Workqueue that reads valid sectors from a line and submit =
them to the
> 	 * GC writer to be recycled.
> diff --git a/drivers/lightnvm/pblk-sysfs.c =
b/drivers/lightnvm/pblk-sysfs.c
> index 95fb434..cd49e88 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -253,7 +253,7 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, =
char *page)
> 	sz +=3D snprintf(page + sz, PAGE_SIZE - sz,
> 		"GC: full:%d, high:%d, mid:%d, low:%d, empty:%d, =
queue:%d\n",
> 			gc_full, gc_high, gc_mid, gc_low, gc_empty,
> -			atomic_read(&pblk->gc.inflight_gc));
> +			atomic_read(&pblk->gc.read_inflight_gc));
>=20
> 	sz +=3D snprintf(page + sz, PAGE_SIZE - sz,
> 		"data (%d) cur:%d, left:%d, vsc:%d, s:%d, map:%d/%d =
(%d)\n",
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index f76583b..03965da 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -238,7 +238,10 @@ struct pblk_gc {
> 	struct timer_list gc_timer;
>=20
> 	struct semaphore gc_sem;
> -	atomic_t inflight_gc;
> +	atomic_t read_inflight_gc; /* Number of lines with inflight GC =
reads */
> +	atomic_t pipeline_gc;	   /* Number of lines in the GC pipeline =
-
> +				    * started reads to finished writes
> +				    */
> 	int w_entries;
>=20
> 	struct list_head w_list;
> --
> 2.7.4

LGTM.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

--Apple-Mail=_87C3F9C6-B4ED-4BB3-8235-9CFB5294CA40
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTaR0ACgkQYx8FO3WZ
GMpw0A//ZdzjpIPuC+b912/6ZErV7tsQTQWa/vnHU7JyrzVmavzDvlHGumZVViiv
cIzp0jFhjzMY+Oa8YQ+o2UAI9LUNdUnE7PKADRh2xaUZR1p8X7RdmEj7d4+5EmvU
XVqr3Fuub8z/LxgxuhXULO13X5Ec0KSRkrQ3cTPIueCslRXa6PfpLlAZIigWg6rg
nnp1122rQZ+C0oRcaKhwDvIGd07JQEgprSo00d2O4DUPgnrhXeZYF/abQ839UzGb
UQxlpWI0ZFsuFLm+iziy5ytIeZaAhqBdFKXlEoHSOBHQ1LrjEbqK+92tkCUQJezf
8Zfja+BxVC7boticBny4X85F2V59ZJmSkXGtfLrECeBc+T4H0vMeLKpbls859JDg
XyKdU70PD5SbMxwDjA3BiXuGOGrahzVakFY5aCjxP/8A3yKVlEIjttAL398X+mFD
V/m/FCRYmKMTwdyjyYCYkdUccwD5xjohJRqBC9XDQgCw33YSNb+Nw6kSObvhGQUc
EAtV7xk7WndqRkFBmAt4BzD+nrcnnmbcPINItKAEYeB8s+so+7QeYtX8GLGwx6tu
BT8wpadAQ7tOm/VzrpqVFBg35r1Lh4HF1hTd78/T83wAKsUqtCPRat5wRp81brcW
1Gtmp166iLYTlO17lU0TgJg3a36YlkWO470D/xQ5jjzkG4CwGHE=
=kksi
-----END PGP SIGNATURE-----

--Apple-Mail=_87C3F9C6-B4ED-4BB3-8235-9CFB5294CA40--
