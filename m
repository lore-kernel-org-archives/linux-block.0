Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0060.outbound.protection.outlook.com ([104.47.32.60]:23569
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbeHTK72 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 06:59:28 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: unify vector max req constants
Date: Mon, 20 Aug 2018 07:44:46 +0000
Message-ID: <FA7F0865-55BB-4710-9B43-4368E66E7F55@cnexlabs.com>
References: <20180817143055.26032-1-mb@lightnvm.io>
In-Reply-To: <20180817143055.26032-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_23CAA2AB-45A0-4D77-999D-58AE5C13884C";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_23CAA2AB-45A0-4D77-999D-58AE5C13884C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Aug 2018, at 16.30, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> Both NVM_MAX_VLBA and PBLK_MAX_REQ_ADDRS define how many LBAs that
> are available in a vector command. pblk uses them interchangeably
> in its implementation. Use NVM_MAX_VLBA as the main one and remove
> usages of PBLK_MAX_REQ_ADDRS.
>=20
> Also remove the power representation that only has one user, and
> instead calculate it at runtime.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-init.c |  6 ------
> drivers/lightnvm/pblk-read.c |  6 +++---
> drivers/lightnvm/pblk-rl.c   |  4 ++--
> drivers/lightnvm/pblk.h      | 10 ++++------
> 4 files changed, 9 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 53bd52114aee..9119c64d6f62 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -376,12 +376,6 @@ static int pblk_core_init(struct pblk *pblk)
> 	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>=20
> -	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
> -		pblk_err(pblk, "vector list too big(%u > %u)\n",
> -				pblk->max_write_pgs, =
PBLK_MAX_REQ_ADDRS);
> -		return -EINVAL;
> -	}
> -
> 	pblk->pad_dist =3D kcalloc(pblk->min_write_pgs - 1, =
sizeof(atomic64_t),
> 								=
GFP_KERNEL);
> 	if (!pblk->pad_dist)
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 48739f6c0417..cd2f61eed6a0 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -43,7 +43,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 				 unsigned long *read_bitmap)
> {
> 	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> -	struct ppa_addr ppas[PBLK_MAX_REQ_ADDRS];
> +	struct ppa_addr ppas[NVM_MAX_VLBA];
> 	int nr_secs =3D rqd->nr_ppas;
> 	bool advanced_bio =3D false;
> 	int i, j =3D 0;
> @@ -450,7 +450,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio =
*bio)
> 	int ret =3D NVM_IO_ERR;
>=20
> 	/* logic error: lba out-of-bounds. Ignore read request */
> -	if (blba >=3D pblk->rl.nr_secs || nr_secs > PBLK_MAX_REQ_ADDRS) =
{
> +	if (blba >=3D pblk->rl.nr_secs || nr_secs > NVM_MAX_VLBA) {
> 		WARN(1, "pblk: read lba out of bounds (lba:%llu, =
nr:%d)\n",
> 					(unsigned long long)blba, =
nr_secs);
> 		return NVM_IO_ERR;
> @@ -546,7 +546,7 @@ static int read_ppalist_rq_gc(struct pblk *pblk, =
struct nvm_rq *rqd,
> 			      struct pblk_line *line, u64 *lba_list,
> 			      u64 *paddr_list_gc, unsigned int nr_secs)
> {
> -	struct ppa_addr ppa_list_l2p[PBLK_MAX_REQ_ADDRS];
> +	struct ppa_addr ppa_list_l2p[NVM_MAX_VLBA];
> 	struct ppa_addr ppa_gc;
> 	int valid_secs =3D 0;
> 	int i;
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index 6a0616a6fcaf..a32790f7b7fc 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -127,7 +127,7 @@ static void __pblk_rl_update_rates(struct pblk_rl =
*rl,
> 	} else if (free_blocks < rl->high) {
> 		int shift =3D rl->high_pw - rl->rb_windows_pw;
> 		int user_windows =3D free_blocks >> shift;
> -		int user_max =3D user_windows << PBLK_MAX_REQ_ADDRS_PW;
> +		int user_max =3D user_windows << ilog2(NVM_MAX_VLBA);
>=20
> 		rl->rb_user_max =3D user_max;
> 		rl->rb_gc_max =3D max - user_max;
> @@ -228,7 +228,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
> 	rl->rsv_blocks =3D min_blocks;
>=20
> 	/* This will always be a power-of-2 */
> -	rb_windows =3D budget / PBLK_MAX_REQ_ADDRS;
> +	rb_windows =3D budget / NVM_MAX_VLBA;
> 	rl->rb_windows_pw =3D get_count_order(rb_windows);
>=20
> 	/* To start with, all buffer is available to user I/O writers */
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 579b4ea9716c..64ae0c7ed3bb 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -37,8 +37,6 @@
>=20
> #define PBLK_SECTOR (512)
> #define PBLK_EXPOSED_PAGE_SIZE (4096)
> -#define PBLK_MAX_REQ_ADDRS (64)
> -#define PBLK_MAX_REQ_ADDRS_PW (6)
>=20
> #define PBLK_NR_CLOSE_JOBS (4)
>=20
> @@ -99,8 +97,8 @@ enum {
> 	PBLK_RL_LOW =3D 4
> };
>=20
> -#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * =
PBLK_MAX_REQ_ADDRS)
> -#define pblk_dma_ppa_size (sizeof(u64) * PBLK_MAX_REQ_ADDRS)
> +#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * =
NVM_MAX_VLBA)
> +#define pblk_dma_ppa_size (sizeof(u64) * NVM_MAX_VLBA)
>=20
> /* write buffer completion context */
> struct pblk_c_ctx {
> @@ -218,8 +216,8 @@ struct pblk_lun {
> struct pblk_gc_rq {
> 	struct pblk_line *line;
> 	void *data;
> -	u64 paddr_list[PBLK_MAX_REQ_ADDRS];
> -	u64 lba_list[PBLK_MAX_REQ_ADDRS];
> +	u64 paddr_list[NVM_MAX_VLBA];
> +	u64 lba_list[NVM_MAX_VLBA];
> 	int nr_secs;
> 	int secs_to_gc;
> 	struct list_head list;
> --
> 2.11.0

Looks good to me.


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_23CAA2AB-45A0-4D77-999D-58AE5C13884C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6cWsACgkQIX4xUKFR
nnRIhA/+L8AJGWPhvsTfwvDb6XWZn8qzGsR+Pehm0gifjav8B1WClqTZpxfr0q+A
geOWIgfYyEld1kd7sFYf3WCVwtIRSNrCPn7w4B3MJyNNyXur1Nd3NR5uIBIsWeAy
nFtbflZX29FDeI3F3xOA6yXYQv5OZVGBM3IifEr8QOM2FAfXpSFyt0b2goVz8Yow
qlMtZoZJVHnS17DhcdFf1uVpL3/blDnCti9bcHYskZFkFQ3YQVzS7GIe/phFnOxo
DCLfEdNfrZ403y+MXSgZzdyDoH2QjmNAvJmBQ2PYa/P3ytKMQk4KNYtdAY2s5kVe
DZrWKsz7N9ZWd6yycX21ujOjmawmH8b2s0vKajb5/OdTvzzQLqRjkoMdMDo4Xeez
CiEyBLxgS/pPac3fI/myJY2jqwPgH2Y01kar9+RsDqM2Rtig+rHTjgMpp7l4iTZ8
3ZS3C/2Y/gjymOXVUI3Uc4IAm5LxznaBBs5vEvTzSaGpgG1qU/mQRryp8vdRsDJ9
fae3/OC0M25rkQTc3bll2nsL9uy68btl40aoYO+JqlkWFylxQxhbINUgJnw69aHp
xWLj6Jvs2l9Y4D58tIat23jFIMqAfN3d74mGzm5lGfWqH217uFi2Fc8TM66n7Qdx
/KIiv2JNvl07daNyqYaBdfshjd5vfDgkMXc9FA++KydIvzekLas=
=dHgz
-----END PGP SIGNATURE-----

--Apple-Mail=_23CAA2AB-45A0-4D77-999D-58AE5C13884C--
