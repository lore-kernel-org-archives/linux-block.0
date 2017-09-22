Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:47955 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbdIVIlB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 04:41:01 -0400
Received: by mail-wm0-f51.google.com with SMTP id r136so1788415wmf.2
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 01:41:00 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <BBF0A7B6-682D-45C7-A087-4072F5B101CE@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A07E921F-FAD5-4AA0-BA5C-2D9D2961403F";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/6] lightnvm: pblk: reuse pblk_gc_should_kick
Date: Fri, 22 Sep 2017 10:40:57 +0200
In-Reply-To: <20170921112539.GA28510@dhcp-216.srv.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170921112539.GA28510@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_A07E921F-FAD5-4AA0-BA5C-2D9D2961403F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 21 Sep 2017, at 13.25, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> This is a trivial change which reuses pblk_gc_should_kick instead of
> repeating it again in pblk_rl_free_lines_inc.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-core.c | 1 +
> drivers/lightnvm/pblk-rl.c   | 9 ---------
> 2 files changed, 1 insertion(+), 9 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 64a6a25..a230125 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1478,6 +1478,7 @@ static void __pblk_line_put(struct pblk *pblk, =
struct pblk_line *line)
> 	spin_unlock(&l_mg->free_lock);
>=20
> 	pblk_rl_free_lines_inc(&pblk->rl, line);
> +	pblk_gc_should_kick(pblk);
> }
>=20
> static void pblk_line_put_ws(struct work_struct *work)
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index 596bdec..e7c162a 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -129,18 +129,9 @@ static int pblk_rl_update_rates(struct pblk_rl =
*rl, unsigned long max)
>=20
> void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line =
*line)
> {
> -	struct pblk *pblk =3D container_of(rl, struct pblk, rl);
> 	int blk_in_line =3D atomic_read(&line->blk_in_line);
> -	int ret;
>=20
> 	atomic_add(blk_in_line, &rl->free_blocks);
> -	/* Rates will not change that often - no need to lock update */
> -	ret =3D pblk_rl_update_rates(rl, rl->rb_budget);
> -
> -	if (ret =3D=3D (PBLK_RL_MID | PBLK_RL_LOW))
> -		pblk_gc_should_start(pblk);
> -	else
> -		pblk_gc_should_stop(pblk);
> }
>=20
> void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line =
*line)
> --
> 2.5.0

Looking at the patch, I can see that a more general cleanup can be done.
What do you think about this? We can merge it in this patch if you are =
OK
with it.

=46rom 944936663c7eef7bc32243b89cc554e40ec436c5 Mon Sep 17 00:00:00 2001
From: Rakesh Pandit <rakesh@tuxera.com>
Date: Thu, 21 Sep 2017 14:25:40 +0300
Subject: [PATCH] lightnvm: pblk: reuse pblk_gc_should_kick

This is a trivial change which reuses pblk_gc_should_kick instead of
repeating it again in pblk_rl_free_lines_inc.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-core.c |  2 --
 drivers/lightnvm/pblk-rl.c   | 33 +++++++++------------------------
 drivers/lightnvm/pblk.h      |  1 -
 3 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 64a6a255514e..c92113b0a2e7 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1633,8 +1633,6 @@ void pblk_line_close(struct pblk *pblk, struct =
pblk_line *line)

 	spin_unlock(&line->lock);
 	spin_unlock(&l_mg->gc_lock);
-
-	pblk_gc_should_kick(pblk);
 }

 void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 596bdec433c3..0896439a91b0 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -96,9 +96,11 @@ unsigned long pblk_rl_nr_free_blks(struct pblk_rl =
*rl)
  *
  * Only the total number of free blocks is used to configure the rate =
limiter.
  */
-static int pblk_rl_update_rates(struct pblk_rl *rl, unsigned long max)
+static void pblk_rl_update_rates(struct pblk_rl *rl)
 {
+	struct pblk *pblk =3D container_of(rl, struct pblk, rl);
 	unsigned long free_blocks =3D pblk_rl_nr_free_blks(rl);
+	int max =3D rl->rb_budget;

 	if (free_blocks >=3D rl->high) {
 		rl->rb_user_max =3D max;
@@ -124,23 +126,18 @@ static int pblk_rl_update_rates(struct pblk_rl =
*rl, unsigned long max)
 		rl->rb_state =3D PBLK_RL_LOW;
 	}

-	return rl->rb_state;
+	if (rl->rb_state =3D=3D (PBLK_RL_MID | PBLK_RL_LOW))
+		pblk_gc_should_start(pblk);
+	else
+		pblk_gc_should_stop(pblk);
 }

 void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line *line)
 {
-	struct pblk *pblk =3D container_of(rl, struct pblk, rl);
 	int blk_in_line =3D atomic_read(&line->blk_in_line);
-	int ret;

 	atomic_add(blk_in_line, &rl->free_blocks);
-	/* Rates will not change that often - no need to lock update */
-	ret =3D pblk_rl_update_rates(rl, rl->rb_budget);
-
-	if (ret =3D=3D (PBLK_RL_MID | PBLK_RL_LOW))
-		pblk_gc_should_start(pblk);
-	else
-		pblk_gc_should_stop(pblk);
+	pblk_rl_update_rates(rl);
 }

 void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line)
@@ -148,19 +145,7 @@ void pblk_rl_free_lines_dec(struct pblk_rl *rl, =
struct pblk_line *line)
 	int blk_in_line =3D atomic_read(&line->blk_in_line);

 	atomic_sub(blk_in_line, &rl->free_blocks);
-}
-
-void pblk_gc_should_kick(struct pblk *pblk)
-{
-	struct pblk_rl *rl =3D &pblk->rl;
-	int ret;
-
-	/* Rates will not change that often - no need to lock update */
-	ret =3D pblk_rl_update_rates(rl, rl->rb_budget);
-	if (ret =3D=3D (PBLK_RL_MID | PBLK_RL_LOW))
-		pblk_gc_should_start(pblk);
-	else
-		pblk_gc_should_stop(pblk);
+	pblk_rl_update_rates(rl);
 }

 int pblk_rl_high_thrs(struct pblk_rl *rl)
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index eaf539715d71..d4b7dee0ef50 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -829,7 +829,6 @@ int pblk_gc_init(struct pblk *pblk);
 void pblk_gc_exit(struct pblk *pblk);
 void pblk_gc_should_start(struct pblk *pblk);
 void pblk_gc_should_stop(struct pblk *pblk);
-void pblk_gc_should_kick(struct pblk *pblk);
 void pblk_gc_kick(struct pblk *pblk);
 void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
 			      int *gc_active);
--
2.7.4


--Apple-Mail=_A07E921F-FAD5-4AA0-BA5C-2D9D2961403F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZxMyaAAoJEGMfBTt1mRjKdeAQAIvs1SYpwtzclMvorrXqoXu1
7/AIU1mV1Ud1hPsJI5utVt1+UstbJk1X8rGqHf35rbsNboqA+xw+M756CyorPlO6
eOtts++I8/Z7qYvwfHgkGHCT/xETER6llj5dHdYzwLmL/Xw+kkDPwUbfluUgmy0z
xK6zZpwn0PSuCZBpiizrAb4UXftu3no/ncqvyZ9roiZHYnl+Pwev3JFuQPjNJhtc
xWTHzlTL0CRF+A/l3kMhRkoqMklu8JVx0AuHNsu1sXl0qF0kaaYcJdt9N7F+zrh6
xj87drCUjQsEHvPIqWNXtrO4L4o9vt13HBM9nUzVV5VCH+j0ollCokctBvGpXkz4
c1W8hu11MhGhSxrEpVzzxXz5h6dT2kJKxLhbKEq7wqQh1lOKc6s9twSSS+msMSZ+
BXf83tTpe+4Hqy/m1bH7LZSSrwOCpcz3T3Iz9rwj8/6WfZ2CHc5go/wZjTRMIwrq
/zdbXUxV7MyjXVrnawjiHtqDLtYe7Mnd2fdB3+ksGBVm645rsIn3eyLTQLD5jEWc
kmRPwBRkYEnutVrMhmA/9iXK+Rqd+Al3ButoAKnJaWWamC3m5x4lNl1YzPoM5gJr
fMBymW+DC1tvOTF95vWugRBRm4JrjgfRo9TbYxSLFUqeLvLslKwOIVjD5e+iKL44
adTfH1qR5IT5NweC64ni
=2XmO
-----END PGP SIGNATURE-----

--Apple-Mail=_A07E921F-FAD5-4AA0-BA5C-2D9D2961403F--
