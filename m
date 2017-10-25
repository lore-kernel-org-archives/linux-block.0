Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <05041A94-19A4-42DC-9DA7-5CB0730F4B01@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CDC66E08-B119-426C-949B-A8581730F54D";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: Convert timers to use timer_setup()
Date: Wed, 25 Oct 2017 10:53:04 +0200
In-Reply-To: <20171024153004.GA112705@beast>
Cc: Jens Axboe <axboe@kernel.dk>,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
References: <20171024153004.GA112705@beast>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_CDC66E08-B119-426C-949B-A8581730F54D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 24 Oct 2017, at 17.30, Kees Cook <keescook@chromium.org> wrote:
>=20
> In preparation for unconditionally passing the struct timer_list =
pointer to
> all timer callbacks, switch to using the new timer_setup() and =
from_timer()
> to pass the timer pointer explicitly.
>=20
> Cc: Matias Bjorling <mb@lightnvm.io>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> drivers/lightnvm/pblk-core.c | 4 ++--
> drivers/lightnvm/pblk-gc.c   | 6 +++---
> drivers/lightnvm/pblk-init.c | 2 +-
> drivers/lightnvm/pblk-rl.c   | 6 +++---
> drivers/lightnvm/pblk.h      | 2 +-
> drivers/lightnvm/rrpc.c      | 6 +++---
> 6 files changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 81501644fb15..8841eb66c902 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -229,9 +229,9 @@ static void pblk_write_kick(struct pblk *pblk)
> 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(1000));
> }
>=20
> -void pblk_write_timer_fn(unsigned long data)
> +void pblk_write_timer_fn(struct timer_list *t)
> {
> -	struct pblk *pblk =3D (struct pblk *)data;
> +	struct pblk *pblk =3D from_timer(pblk, t, wtimer);
>=20
> 	/* kick the write thread every tick to flush outstanding data */
> 	pblk_write_kick(pblk);
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 6090d28f7995..85ff64fe5ba2 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -428,9 +428,9 @@ void pblk_gc_kick(struct pblk *pblk)
> 	mod_timer(&gc->gc_timer, jiffies + =
msecs_to_jiffies(GC_TIME_MSECS));
> }
>=20
> -static void pblk_gc_timer(unsigned long data)
> +static void pblk_gc_timer(struct timer_list *t)
> {
> -	struct pblk *pblk =3D (struct pblk *)data;
> +	struct pblk *pblk =3D from_timer(pblk, t, gc.gc_timer);
>=20
> 	pblk_gc_kick(pblk);
> }
> @@ -569,7 +569,7 @@ int pblk_gc_init(struct pblk *pblk)
> 		goto fail_free_writer_kthread;
> 	}
>=20
> -	setup_timer(&gc->gc_timer, pblk_gc_timer, (unsigned long)pblk);
> +	timer_setup(&gc->gc_timer, pblk_gc_timer, 0);
> 	mod_timer(&gc->gc_timer, jiffies + =
msecs_to_jiffies(GC_TIME_MSECS));
>=20
> 	gc->gc_active =3D 0;
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 1b0f61233c21..c0ae85b514f5 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -833,7 +833,7 @@ static int pblk_lines_init(struct pblk *pblk)
>=20
> static int pblk_writer_init(struct pblk *pblk)
> {
> -	setup_timer(&pblk->wtimer, pblk_write_timer_fn, (unsigned =
long)pblk);
> +	timer_setup(&pblk->wtimer, pblk_write_timer_fn, 0);
> 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
>=20
> 	pblk->writer_ts =3D kthread_create(pblk_write_ts, pblk, =
"pblk-writer-t");
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index 2e6a5361baf0..1210deeb6f43 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -178,9 +178,9 @@ int pblk_rl_sysfs_rate_show(struct pblk_rl *rl)
> 	return rl->rb_user_max;
> }
>=20
> -static void pblk_rl_u_timer(unsigned long data)
> +static void pblk_rl_u_timer(struct timer_list *t)
> {
> -	struct pblk_rl *rl =3D (struct pblk_rl *)data;
> +	struct pblk_rl *rl =3D from_timer(rl, t, u_timer);
>=20
> 	/* Release user I/O state. Protect from GC */
> 	smp_store_release(&rl->rb_user_active, 0);
> @@ -221,7 +221,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
> 	atomic_set(&rl->rb_gc_cnt, 0);
> 	atomic_set(&rl->rb_space, -1);
>=20
> -	setup_timer(&rl->u_timer, pblk_rl_u_timer, (unsigned long)rl);
> +	timer_setup(&rl->u_timer, pblk_rl_u_timer, 0);
>=20
> 	rl->rb_user_active =3D 0;
> 	rl->rb_gc_active =3D 0;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 67e623bd5c2d..e097dea4a1ea 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -789,7 +789,7 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
>  * pblk write thread
>  */
> int pblk_write_ts(void *data);
> -void pblk_write_timer_fn(unsigned long data);
> +void pblk_write_timer_fn(struct timer_list *t);
> void pblk_write_should_kick(struct pblk *pblk);
>=20
> /*
> diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
> index 267f01ae87e4..0993c14be860 100644
> --- a/drivers/lightnvm/rrpc.c
> +++ b/drivers/lightnvm/rrpc.c
> @@ -267,9 +267,9 @@ static void rrpc_gc_kick(struct rrpc *rrpc)
> /*
>  * timed GC every interval.
>  */
> -static void rrpc_gc_timer(unsigned long data)
> +static void rrpc_gc_timer(struct timer_list *t)
> {
> -	struct rrpc *rrpc =3D (struct rrpc *)data;
> +	struct rrpc *rrpc =3D from_timer(rrpc, t, gc_timer);
>=20
> 	rrpc_gc_kick(rrpc);
> 	mod_timer(&rrpc->gc_timer, jiffies + msecs_to_jiffies(10));
> @@ -1063,7 +1063,7 @@ static int rrpc_gc_init(struct rrpc *rrpc)
> 	if (!rrpc->kgc_wq)
> 		return -ENOMEM;
>=20
> -	setup_timer(&rrpc->gc_timer, rrpc_gc_timer, (unsigned =
long)rrpc);
> +	timer_setup(&rrpc->gc_timer, rrpc_gc_timer, 0);
>=20
> 	return 0;
> }
> --
> 2.7.4
>=20

Looks good. I put it through our daily internal testing (on topof Linus'
v4.14-rc6) and it does not seem to introduce any regressions.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
Tested-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

One thing though: The patch does not apply on top of Jen's for-15/block.
It is trivial, but here you have a version that applies.

---
 drivers/lightnvm/pblk-core.c | 4 ++--
 drivers/lightnvm/pblk-gc.c   | 6 +++---
 drivers/lightnvm/pblk-init.c | 2 +-
 drivers/lightnvm/pblk-rl.c   | 6 +++---
 drivers/lightnvm/pblk.h      | 2 +-
 drivers/lightnvm/rrpc.c      | 6 +++---
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ce90213a42fa..76516ee84e9a 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -270,9 +270,9 @@ static void pblk_write_kick(struct pblk *pblk)
 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(1000));
 }

-void pblk_write_timer_fn(unsigned long data)
+void pblk_write_timer_fn(struct timer_list *t)
 {
-	struct pblk *pblk =3D (struct pblk *)data;
+	struct pblk *pblk =3D from_timer(pblk, t, wtimer);

 	/* kick the write thread every tick to flush outstanding data */
 	pblk_write_kick(pblk);
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 00d5698d64a9..9c8e114c8a54 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -442,9 +442,9 @@ static void pblk_gc_run(struct pblk *pblk)
 		goto next_gc_group;
 }

-static void pblk_gc_timer(unsigned long data)
+static void pblk_gc_timer(struct timer_list *t)
 {
-	struct pblk *pblk =3D (struct pblk *)data;
+	struct pblk *pblk =3D from_timer(pblk, t, gc.gc_timer);

 	pblk_gc_kick(pblk);
 }
@@ -601,7 +601,7 @@ int pblk_gc_init(struct pblk *pblk)
 		goto fail_free_writer_kthread;
 	}

-	setup_timer(&gc->gc_timer, pblk_gc_timer, (unsigned long)pblk);
+	timer_setup(&gc->gc_timer, pblk_gc_timer, 0);
 	mod_timer(&gc->gc_timer, jiffies + =
msecs_to_jiffies(GC_TIME_MSECS));

 	gc->gc_active =3D 0;
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index f62112ba5482..695826a06b5d 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -866,7 +866,7 @@ static int pblk_lines_init(struct pblk *pblk)

 static int pblk_writer_init(struct pblk *pblk)
 {
-	setup_timer(&pblk->wtimer, pblk_write_timer_fn, (unsigned =
long)pblk);
+	timer_setup(&pblk->wtimer, pblk_write_timer_fn, 0);
 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));

 	pblk->writer_ts =3D kthread_create(pblk_write_ts, pblk, =
"pblk-writer-t");
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index abae31fd434e..dacc71922260 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -158,9 +158,9 @@ int pblk_rl_max_io(struct pblk_rl *rl)
 	return rl->rb_max_io;
 }

-static void pblk_rl_u_timer(unsigned long data)
+static void pblk_rl_u_timer(struct timer_list *t)
 {
-	struct pblk_rl *rl =3D (struct pblk_rl *)data;
+	struct pblk_rl *rl =3D from_timer(rl, t, u_timer);

 	/* Release user I/O state. Protect from GC */
 	smp_store_release(&rl->rb_user_active, 0);
@@ -202,7 +202,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	atomic_set(&rl->rb_gc_cnt, 0);
 	atomic_set(&rl->rb_space, -1);

-	setup_timer(&rl->u_timer, pblk_rl_u_timer, (unsigned long)rl);
+	timer_setup(&rl->u_timer, pblk_rl_u_timer, 0);

 	rl->rb_user_active =3D 0;
 	rl->rb_gc_active =3D 0;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 90961033a79f..59a64d461a5d 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -797,7 +797,7 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
  * pblk write thread
  */
 int pblk_write_ts(void *data);
-void pblk_write_timer_fn(unsigned long data);
+void pblk_write_timer_fn(struct timer_list *t);
 void pblk_write_should_kick(struct pblk *pblk);

 /*
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 267f01ae87e4..0993c14be860 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -267,9 +267,9 @@ static void rrpc_gc_kick(struct rrpc *rrpc)
 /*
  * timed GC every interval.
  */
-static void rrpc_gc_timer(unsigned long data)
+static void rrpc_gc_timer(struct timer_list *t)
 {
-	struct rrpc *rrpc =3D (struct rrpc *)data;
+	struct rrpc *rrpc =3D from_timer(rrpc, t, gc_timer);

 	rrpc_gc_kick(rrpc);
 	mod_timer(&rrpc->gc_timer, jiffies + msecs_to_jiffies(10));
@@ -1063,7 +1063,7 @@ static int rrpc_gc_init(struct rrpc *rrpc)
 	if (!rrpc->kgc_wq)
 		return -ENOMEM;

-	setup_timer(&rrpc->gc_timer, rrpc_gc_timer, (unsigned =
long)rrpc);
+	timer_setup(&rrpc->gc_timer, rrpc_gc_timer, 0);

 	return 0;
 }
--
2.7.4


--Apple-Mail=_CDC66E08-B119-426C-949B-A8581730F54D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnwUPAACgkQYx8FO3WZ
GMo50BAAqCF5jCmz5R+LapMuYR6/sfCrW4IDNTYgupgltR6MZ6JZw3AiHFyeTGuA
O9Owyz4/MFeYa8D/oRYGmLUplbez7GitAsjmxHDBFLwIRRwe39kwTEBdd9zozj8h
4m0sRQDb7R/24hQjgBsqfJk5b3fhonshQ55q/awCB/wHlFcQm6716KvS+yGAm3F5
FCMVPIBX0CviD6N/B+8x5+6ICmWKZ6fNA7FNpTMvZjNBMfbefUE3EVebPYB9Ebjk
vpYAG5e2qjDhBnDP8tcgl0Qc4ZfWdPMyySb8o55qH8mX/9M0c8fxsvePHFPXW8sl
jJ/nFduC8SjAj6vlinFhENQt78NKZB1TjY7tSdbSJ7FfoYhkB1NZOxDqAq4iDUYQ
SdA7RZ1YjCm6Glq1PtR2XWFJuuoOjvdjUu08P2NKCOFXqxG7oKp3QIvwVbiX8vZ8
iZZSe5eMRyCG6AMirqQ3WB9fq2O9PUfhza8VlKGVapTBGEY1OMLelGMNCE3P9Vd2
UToknolHGb3zSXs/BJOetgSP16RHsp0Gc6ba8ouiigxrJJokhIaV/7kMGQvfyK+8
0kEBste16z5mvkS1m/dbeo+5OoFE4NZDtS6+PjSH/j6GT0ney3lLcvYeKTvnCL3a
mQVY+qDE8s6IUxQiVdpOMocTHPo6VEas0O6CFe3EJMsaIegYzVM=
=tQTa
-----END PGP SIGNATURE-----

--Apple-Mail=_CDC66E08-B119-426C-949B-A8581730F54D--
