Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0075.outbound.protection.outlook.com ([104.47.41.75]:7296
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbeHTP2k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 11:28:40 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: move bad block and chunk state logic to core
Date: Mon, 20 Aug 2018 12:13:11 +0000
Message-ID: <7189DEC2-B080-4ADB-85B6-0FCED1796FAE@cnexlabs.com>
References: <20180817111442.15827-1-mb@lightnvm.io>
In-Reply-To: <20180817111442.15827-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C34A3629-1772-4BB7-93AB-B8FEC1A5F9F7";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_C34A3629-1772-4BB7-93AB-B8FEC1A5F9F7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Aug 2018, at 13.14, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> pblk implements two data paths for recovery line state. One for 1.2
> and another for 2.0, instead of having pblk implement these, combine
> them in the core to reduce complexity and make available to other
> targets.
>=20
> The new interface will adhere to the 2.0 chunk definition,
> including managing open chunks with an active write pointer. To =
provide
> this interface, a 1.2 device recovers the state of the chunks by
> manually detecting if a chunk is either free/open/close/offline, and =
if
> open, scanning the flash pages sequentially to find the next writeable
> page. This process takes on average ~10 seconds on a device with 64 =
dies,
> 1024 blocks and 60us read access time. The process can be parallelized
> but is left out for maintenance simplicity, as the 1.2 specification =
is
> deprecated. For 2.0 devices, the logic is maintained internally in the
> drive and retrieved through the 2.0 interface.

A couple of things from closer review.

>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/core.c      | 310 =
+++++++++++++++++++++++++++++++++++--------
> drivers/lightnvm/pblk-core.c |   6 +-
> drivers/lightnvm/pblk-init.c | 116 +---------------
> drivers/lightnvm/pblk.h      |   2 +-
> drivers/nvme/host/lightnvm.c |   4 +-
> include/linux/lightnvm.h     |  15 +--
> 6 files changed, 266 insertions(+), 187 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 964352720a03..003fc073f496 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -717,46 +717,6 @@ static void nvm_free_rqd_ppalist(struct =
nvm_tgt_dev *tgt_dev,
> 	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, =
rqd->dma_ppa_list);
> }
>=20
> -int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct =
nvm_chk_meta *meta,
> -		struct ppa_addr ppa, int nchks)
> -{
> -	struct nvm_dev *dev =3D tgt_dev->parent;
> -
> -	nvm_ppa_tgt_to_dev(tgt_dev, &ppa, 1);
> -
> -	return dev->ops->get_chk_meta(tgt_dev->parent, meta,
> -						(sector_t)ppa.ppa, =
nchks);
> -}
> -EXPORT_SYMBOL(nvm_get_chunk_meta);
> -
> -int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr =
*ppas,
> -		       int nr_ppas, int type)
> -{
> -	struct nvm_dev *dev =3D tgt_dev->parent;
> -	struct nvm_rq rqd;
> -	int ret;
> -
> -	if (nr_ppas > NVM_MAX_VLBA) {
> -		pr_err("nvm: unable to update all blocks atomically\n");
> -		return -EINVAL;
> -	}
> -
> -	memset(&rqd, 0, sizeof(struct nvm_rq));
> -
> -	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
> -	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
> -
> -	ret =3D dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, =
type);
> -	nvm_free_rqd_ppalist(tgt_dev, &rqd);
> -	if (ret) {
> -		pr_err("nvm: failed bb mark\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(nvm_set_tgt_bb_tbl);
> -
> static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
> {
> 	int flags =3D 0;
> @@ -830,27 +790,159 @@ void nvm_end_io(struct nvm_rq *rqd)
> }
> EXPORT_SYMBOL(nvm_end_io);
>=20
> +static int nvm_submit_io_sync_raw(struct nvm_dev *dev, struct nvm_rq =
*rqd)
> +{
> +	if (!dev->ops->submit_io_sync)
> +		return -ENODEV;
> +
> +	rqd->flags =3D nvm_set_flags(&dev->geo, rqd);
> +
> +	return dev->ops->submit_io_sync(dev, rqd);
> +}
> +
> +static int nvm_bb_chunk_sense(struct nvm_dev *dev, struct ppa_addr =
ppa)
> +{
> +	struct nvm_rq rqd =3D { NULL };
> +	struct bio bio;
> +	struct bio_vec bio_vec;
> +	struct page *page;
> +	int ret;
> +
> +	page =3D alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	bio_init(&bio, &bio_vec, 1);
> +	bio_add_page(&bio, page, PAGE_SIZE, 0);
> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> +
> +	rqd.bio =3D &bio;
> +	rqd.opcode =3D NVM_OP_PREAD;
> +	rqd.is_seq =3D 1;
> +	rqd.nr_ppas =3D 1;
> +	rqd.ppa_addr =3D generic_to_dev_addr(dev, ppa);
> +
> +	ret =3D nvm_submit_io_sync_raw(dev, &rqd);
> +	if (ret)
> +		return ret;
> +
> +	__free_page(page);
> +
> +	return rqd.error;
> +}
> +
> /*
> - * folds a bad block list from its plane representation to its =
virtual
> - * block representation. The fold is done in place and reduced size =
is
> - * returned.
> + * Scans a 1.2 chunk first and last page to determine if its state.
> + * If the chunk is found to be open, also scan it to update the write
> + * pointer.
> + */
> +static int nvm_bb_scan_chunk(struct nvm_dev *dev, struct ppa_addr =
ppa,
> +			     struct nvm_chk_meta *meta)

Keeping some name consistency would help nvm_bb_chunk_*

> [...]

> +
> +static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
> +			   int nchks, struct nvm_chk_meta *meta)
> +{
> +	struct nvm_geo *geo =3D &dev->geo;
> +	struct ppa_addr ppa;
> +	u8 *blks;
> +	int ch, lun, nr_blks;
> +	int ret;
> +
> +	ppa.ppa =3D slba;
> +	ppa =3D dev_to_generic_addr(dev, ppa);
> +
> +	if (ppa.g.blk !=3D 0)
> +		return -EINVAL;
> +
> +	if ((nchks % geo->num_chk) !=3D 0)
> +		return -EINVAL;
> +
> +	nr_blks =3D geo->num_chk * geo->pln_mode;
> +
> +	blks =3D kmalloc(nr_blks, GFP_KERNEL);
> +	if (!blks)
> +		return -ENOMEM;
> +
> +	for (ch =3D ppa.g.ch; ch < geo->num_ch; ch++) {
> +		for (lun =3D ppa.g.lun; lun < geo->num_lun; lun++) {
> +			struct ppa_addr ppa_gen, ppa_dev;
> +
> +			if (!nchks)
> +				goto out;

You should free blks here too.

> +
> +			ppa_gen.ppa =3D 0;
> +			ppa_gen.a.ch =3D ch;
> +			ppa_gen.a.lun =3D lun;
> +			ppa_dev =3D generic_to_dev_addr(dev, ppa_gen);
> +
> +			ret =3D dev->ops->get_bb_tbl(dev, ppa_dev, =
blks);
> +			if (ret)
> +				goto err;
> +
> +			ret =3D nvm_bb_to_chunk(dev, ppa_gen, blks, =
nr_blks,
> +									=
meta);
> +			if (ret)
> +				goto err;
> +
> +			meta +=3D geo->num_chk;
> +			nchks -=3D geo->num_chk;
> +		}
> +	}
> +out:
> +	return 0;
> +err:
> +	kfree(blks);
> +	return ret;
> }
> -EXPORT_SYMBOL(nvm_bb_tbl_fold);
>=20
> -int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr =
ppa,
> -		       u8 *blks)
> [...]



--Apple-Mail=_C34A3629-1772-4BB7-93AB-B8FEC1A5F9F7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6sFIACgkQIX4xUKFR
nnQgWQ/7Bz+ogN7IUZQfo6nVTiiznWd9w3Jc/8LMjduCOBHTg1GQYL/2EKjSKhWx
nNSkuZDdZvo9kw7GJCIgMTn49t6HfEQ+9MN9LNYkzUwoN+p3YS5NnfUOMVGwiLKX
Viuzyq0Ld8mIMn9OM6ym9SBAlmBvjsdV5J5bVJp8baLLCYca6kgwu2jwH0QSDEni
e4qpcvn7RmekWlz8eUdjnjg38KxvZJ3uXlFxS+pGHhQIio6l/gUMTFzGcjfTc8sk
Y5AqqsAhDYEJpJbhMMlPHPtpURWlJevuYpNNwRSd0pl+tFZRH0ojL7EBwZWa0M5/
/V3dsYK+TQQDUb7oTzZGkxK8ysSryrvJYLN5HMDStBX7st6R7yTuZ3D+alxHGoPf
HlO6roU7TX7VJlOlB8BY0/65EYDU3x0Yox5Ykc3TrBv/dpBDDC+enlO379imxLRX
oSpWy2EWhb0QCSKKvuSkPZ8I4gWo2UZQzTJmKklEiBSLjnfF1u+i+wytxokAORiu
6RHKlCTcanPHKtutVWeOLnNwdrrVzibuebBXG3LbOIkJsDUFFtnWvoM1QL3fPHFf
g5OwxJYqxJ2V70yjALTXcHQuQpIvjaPy+ch6jqRWHIuRv0BPCQnFeWMAKpxotfn0
3PIYqooyUIB1dfp26Pznrt1uGPxxPuOuTIHAa+45n+KpBScuDA8=
=GhgV
-----END PGP SIGNATURE-----

--Apple-Mail=_C34A3629-1772-4BB7-93AB-B8FEC1A5F9F7--
