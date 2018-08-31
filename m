Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0066.outbound.protection.outlook.com ([104.47.41.66]:21670
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727750AbeHaP5U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 11:57:20 -0400
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
Date: Fri, 31 Aug 2018 11:50:05 +0000
Message-ID: <EED79EDF-8391-4414-8DB6-79BF20B06F51@cnexlabs.com>
References: <20180817111442.15827-1-mb@lightnvm.io>
In-Reply-To: <20180817111442.15827-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_862ED8AF-D4F5-463F-AF41-90E8D023C59C";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_862ED8AF-D4F5-463F-AF41-90E8D023C59C
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
> +{
> +	struct nvm_geo *geo =3D &dev->geo;
> +	int ret, pg, pl;
> +
> +	/* sense first page */
> +	ret =3D nvm_bb_chunk_sense(dev, ppa);
> +	if (ret < 0) /* io error */
> +		return ret;
> +	else if (ret =3D=3D 0) /* valid data */
> +		meta->state =3D NVM_CHK_ST_OPEN;
> +	else if (ret > 0) {
> +		/*
> +		 * If empty page, the chunk is free, else it is an
> +		 * actual io error. In that case, mark it offline.
> +		 */
> +		switch (ret) {
> +		case NVM_RSP_ERR_EMPTYPAGE:
> +			meta->state =3D NVM_CHK_ST_FREE;
> +			return 0;
> +		case NVM_RSP_ERR_FAILCRC:
> +		case NVM_RSP_ERR_FAILECC:
> +		case NVM_RSP_WARN_HIGHECC:
> +			meta->state =3D NVM_CHK_ST_OPEN;
> +			goto scan;
> +		default:
> +			return -ret; /* other io error */
> +		}
> +	}
> +
> +	/* sense last page */
> +	ppa.g.pg =3D geo->num_pg - 1;
> +	ppa.g.pl =3D geo->num_pln - 1;
> +
> +	ret =3D nvm_bb_chunk_sense(dev, ppa);
> +	if (ret < 0) /* io error */
> +		return ret;
> +	else if (ret =3D=3D 0) { /* Chunk fully written */
> +		meta->state =3D NVM_CHK_ST_CLOSED;
> +		meta->wp =3D geo->clba;
> +		return 0;
> +	} else if (ret > 0) {
> +		switch (ret) {
> +		case NVM_RSP_ERR_EMPTYPAGE:
> +		case NVM_RSP_ERR_FAILCRC:
> +		case NVM_RSP_ERR_FAILECC:
> +		case NVM_RSP_WARN_HIGHECC:
> +			meta->state =3D NVM_CHK_ST_OPEN;
> +			break;
> +		default:
> +			return -ret; /* other io error */
> +		}
> +	}
> +
> +scan:
> +	/*
> +	 * chunk is open, we scan sequentially to update the write =
pointer.
> +	 * We make the assumption that targets write data across all =
planes
> +	 * before moving to the next page.
> +	 */
> +	for (pg =3D 0; pg < geo->num_pg; pg++) {
> +		for (pl =3D 0; pl < geo->num_pln; pl++) {
> +			ppa.g.pg =3D pg;
> +			ppa.g.pl =3D pl;
> +
> +			ret =3D nvm_bb_chunk_sense(dev, ppa);
> +			if (ret < 0) /* io error */
> +				return ret;
> +			else if (ret =3D=3D 0) {
> +				meta->wp +=3D geo->ws_min;
> +			} else if (ret > 0) {
> +				switch (ret) {
> +				case NVM_RSP_ERR_EMPTYPAGE:
> +					return 0;
> +				case NVM_RSP_ERR_FAILCRC:
> +				case NVM_RSP_ERR_FAILECC:
> +				case NVM_RSP_WARN_HIGHECC:
> +					meta->wp +=3D geo->ws_min;
> +					break;
> +				default:
> +					return -ret; /* other io error =
*/
> +				}
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * folds a bad block list from its plane representation to its
> + * chunk representation.
>  *
> - * If any of the planes status are bad or grown bad block, the =
virtual block
> - * is marked bad. If not bad, the first plane state acts as the block =
state.
> + * If any of the planes status are bad or grown bad, the chunk is =
marked
> + * offline. If not bad, the first plane state acts as the chunk =
state.
>  */
> -int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 *blks, int nr_blks)
> +static int nvm_bb_to_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
> +			   u8 *blks, int nr_blks, struct nvm_chk_meta =
*meta)
> {
> 	struct nvm_geo *geo =3D &dev->geo;
> -	int blk, offset, pl, blktype;
> -
> -	if (nr_blks !=3D geo->num_chk * geo->pln_mode)
> -		return -EINVAL;
> +	int ret, blk, pl, offset, blktype;
>=20
> 	for (blk =3D 0; blk < geo->num_chk; blk++) {
> 		offset =3D blk * geo->pln_mode;
> 		blktype =3D blks[offset];
>=20
> -		/* Bad blocks on any planes take precedence over other =
types */
> 		for (pl =3D 0; pl < geo->pln_mode; pl++) {
> 			if (blks[offset + pl] &
> 					=
(NVM_BLK_T_BAD|NVM_BLK_T_GRWN_BAD)) {
> @@ -859,23 +951,125 @@ int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 =
*blks, int nr_blks)
> 			}
> 		}
>=20
> -		blks[blk] =3D blktype;
> +		meta->wp =3D 0;
> +		meta->type =3D NVM_CHK_TP_W_SEQ;
> +		meta->wi =3D 0;
> +		meta->slba =3D generic_to_dev_addr(dev, ppa).ppa;
> +		meta->cnlb =3D dev->geo.clba;
> +
> +		if (blktype =3D=3D NVM_BLK_T_FREE) {
> +			ppa.a.blk =3D blk;

This line should be moved above meta->slba assignment. Otherwise, the
slba address does not consider the block.

Also, since this is 1.2 specific, can you use g, instead of a?

I'll send a patch later today implementing chunk metadata retrieval on
erase which relies on this. I'll put it in a small commit in the series
fixing this; feel free to merge it into your patch.

Javier

--Apple-Mail=_862ED8AF-D4F5-463F-AF41-90E8D023C59C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluJK2oACgkQIX4xUKFR
nnT5GQ/+Pa6dGkyLd3DBCaFHVRwAWDZD/cfYBK9590jeTpuKM1HLtIex2bmwhjLM
wA+gn8OooQN9Ltexx7MCM4d+Do1AamkW08U68S9vb4UMYawvVFNk2aJziWkESoaQ
IdWWw9UZwEeDcmbNgazoOsssTsQcM2PPxcAoxP4loOwQcueHENiqW4nmebsauI/1
6MpUOnl45ba/oe/jk3eQIfRvoSsceOPtnoAeqQ06sulGvVFDJhaPcw6Ta7q+RtGQ
U4lSwv1332k8tHWj5BTQSN4DVtHL6KLGudGuKIM03SwXeMSzth+5BQWVyugdP/Z0
Cb6UiRNopBCrzLMNoxsRDmOGoHxLyr8PZ9Z1HEBWWsLZMrDXPJJ1PLbtJNMoC5na
NxmsSY3H2an3ECxQQaSNUNpQHXO+CL7m1zcjlEAowK26xiUVKQu/+Dv1WLKIkicW
IeUjaT8okDV5+fE94MY5CdR/6kiSJbPlYaeMN8xWXnazzO9qukg5IH5UrB1Sjm49
CvmpjE3KCpoa+TTHFpQuhFyZtQIvICo3yM7+r7TmIblY5lPdRUf5RfnWfPOaiN2m
RldrTjdjyIaht9MESay9iqT3AwOVM7p1ZWvxmLLK9dO3PbHXhJoxV3GKHUPt2FUN
nc/fWLzVmrISm2R72r9OH953vVKktFm8+5TxQGPN/CRqbyxkWfA=
=LXC5
-----END PGP SIGNATURE-----

--Apple-Mail=_862ED8AF-D4F5-463F-AF41-90E8D023C59C--
