Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr700064.outbound.protection.outlook.com ([40.107.70.64]:30816
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728946AbeJ2U4K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Oct 2018 16:56:10 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Konopko, Igor J" <igor.j.konopko@intel.com>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "hans.ml.holmberg@owltronix.com" <hans.ml.holmberg@owltronix.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] lightnvm: Flexible DMA pool entry size
Date: Mon, 29 Oct 2018 12:07:40 +0000
Message-ID: <D23E4876-CA28-4C59-9D13-DA50CC0F09C9@cnexlabs.com>
References: <20181022103611.39271-1-igor.j.konopko@intel.com>
 <20181022103611.39271-4-igor.j.konopko@intel.com>
In-Reply-To: <20181022103611.39271-4-igor.j.konopko@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_20378AFC-4AA6-464A-B135-599724C66659";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_20378AFC-4AA6-464A-B135-599724C66659
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 22 Oct 2018, at 12.36, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently whole lightnvm and pblk uses single DMA pool,
> for which entry size is always equal to PAGE_SIZE.
> PPA list always needs 8b*64, so there is only 56b*64
> space for OOB meta. Since NVMe OOB meta can be bigger,
> such as 128b, this solution is not robustness.
>=20
> This patch add the possiblity to support OOB meta above
> 56b by changing DMA pool size based on OOB meta size.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/core.c          | 45 =
++++++++++++++++++++++++++++++++++------
> drivers/lightnvm/pblk-core.c     |  8 +++----
> drivers/lightnvm/pblk-recovery.c |  4 ++--
> drivers/lightnvm/pblk.h          | 10 ++++++++-
> drivers/nvme/host/lightnvm.c     |  8 +++++--
> include/linux/lightnvm.h         |  4 +++-
> 6 files changed, 63 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index efb976a863d2..68f0812077d5 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1145,11 +1145,9 @@ int nvm_register(struct nvm_dev *dev)
> 	if (!dev->q || !dev->ops)
> 		return -EINVAL;
>=20
> -	dev->dma_pool =3D dev->ops->create_dma_pool(dev, "ppalist");
> -	if (!dev->dma_pool) {
> -		pr_err("nvm: could not create dma pool\n");
> -		return -ENOMEM;
> -	}
> +	ret =3D nvm_realloc_dma_pool(dev);
> +	if (ret)
> +		return ret;
>=20
> 	ret =3D nvm_init(dev);
> 	if (ret)
> @@ -1162,7 +1160,12 @@ int nvm_register(struct nvm_dev *dev)
>=20
> 	return 0;
> err_init:
> -	dev->ops->destroy_dma_pool(dev->dma_pool);
> +	if (dev->dma_pool) {
> +		dev->ops->destroy_dma_pool(dev->dma_pool);
> +		dev->dma_pool =3D NULL;
> +		dev->dma_pool_size =3D 0;
> +	}
> +
> 	return ret;
> }
> EXPORT_SYMBOL(nvm_register);
> @@ -1187,6 +1190,36 @@ void nvm_unregister(struct nvm_dev *dev)
> }
> EXPORT_SYMBOL(nvm_unregister);
>=20
> +int nvm_realloc_dma_pool(struct nvm_dev *dev)
> +{
> +	int exp_pool_size;
> +
> +	exp_pool_size =3D max_t(int, PAGE_SIZE,
> +			      (NVM_MAX_VLBA * (sizeof(u64) + =
dev->geo.sos)));
> +	exp_pool_size =3D round_up(exp_pool_size, PAGE_SIZE);
> +
> +	if (dev->dma_pool_size >=3D exp_pool_size)
> +		return 0;
> +
> +	if (dev->dma_pool) {
> +		dev->ops->destroy_dma_pool(dev->dma_pool);
> +		dev->dma_pool =3D NULL;
> +		dev->dma_pool_size =3D 0;
> +	}
> +
> +	dev->dma_pool =3D dev->ops->create_dma_pool(dev, "ppalist",
> +						  exp_pool_size);
> +	if (!dev->dma_pool) {
> +		dev->dma_pool_size =3D 0;
> +		pr_err("nvm: could not create dma pool\n");
> +		return -ENOMEM;
> +	}
> +	dev->dma_pool_size =3D exp_pool_size;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(nvm_realloc_dma_pool);
> +
> static int __nvm_configure_create(struct nvm_ioctl_create *create)
> {
> 	struct nvm_dev *dev;
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 0f33055f40eb..b1e104765868 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -250,8 +250,8 @@ int pblk_alloc_rqd_meta(struct pblk *pblk, struct =
nvm_rq *rqd)
> 	if (rqd->nr_ppas =3D=3D 1)
> 		return 0;
>=20
> -	rqd->ppa_list =3D rqd->meta_list + pblk_dma_meta_size;
> -	rqd->dma_ppa_list =3D rqd->dma_meta_list + pblk_dma_meta_size;
> +	rqd->ppa_list =3D rqd->meta_list + pblk_dma_meta_size(pblk);
> +	rqd->dma_ppa_list =3D rqd->dma_meta_list + =
pblk_dma_meta_size(pblk);
>=20
> 	return 0;
> }
> @@ -846,8 +846,8 @@ int pblk_line_emeta_read(struct pblk *pblk, struct =
pblk_line *line,
> 	if (!meta_list)
> 		return -ENOMEM;
>=20
> -	ppa_list =3D meta_list + pblk_dma_meta_size;
> -	dma_ppa_list =3D dma_meta_list + pblk_dma_meta_size;
> +	ppa_list =3D meta_list + pblk_dma_meta_size(pblk);
> +	dma_ppa_list =3D dma_meta_list + pblk_dma_meta_size(pblk);
>=20
> next_rq:
> 	memset(&rqd, 0, sizeof(struct nvm_rq));
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 977b2ca5d849..b5c8a0ed9bb1 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -474,8 +474,8 @@ static int pblk_recov_l2p_from_oob(struct pblk =
*pblk, struct pblk_line *line)
> 	if (!meta_list)
> 		return -ENOMEM;
>=20
> -	ppa_list =3D (void *)(meta_list) + pblk_dma_meta_size;
> -	dma_ppa_list =3D dma_meta_list + pblk_dma_meta_size;
> +	ppa_list =3D (void *)(meta_list) + pblk_dma_meta_size(pblk);
> +	dma_ppa_list =3D dma_meta_list + pblk_dma_meta_size(pblk);
>=20
> 	data =3D kcalloc(pblk->max_write_pgs, geo->csecs, GFP_KERNEL);
> 	if (!data) {
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index d09c1b341e07..c03fa037d037 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -104,7 +104,6 @@ enum {
> 	PBLK_RL_LOW =3D 4
> };
>=20
> -#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * =
NVM_MAX_VLBA)
> #define pblk_dma_ppa_size (sizeof(u64) * NVM_MAX_VLBA)
>=20
> /* write buffer completion context */
> @@ -1394,4 +1393,13 @@ static inline __le64 pblk_get_meta_lba(struct =
pblk *pblk, void *meta,
> {
> 	return pblk_get_meta(pblk, meta, index)->lba;
> }
> +
> +static inline int pblk_dma_meta_size(struct pblk *pblk)
> +{
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> +
> +	return max_t(int, sizeof(struct pblk_sec_meta), geo->sos)
> +				* NVM_MAX_VLBA;

Before supporting packed metadata, if geo->sos < sizeof(struct
pblk_sec_meta) then the initialization should fail (needs to be added to
this patch), so the return here can directly be geo->sos

> +}
> #endif /* PBLK_H_ */
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index a4f3b263cd6c..d1e47a93bcfd 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -731,11 +731,12 @@ static int nvme_nvm_submit_io_sync(struct =
nvm_dev *dev, struct nvm_rq *rqd)
> 	return ret;
> }
>=20
> -static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char =
*name)
> +static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char =
*name,
> +					int size)

Since you are making the size configurable, you can make the alignment
too. You can adapt it based on the OOB size since you know that the
ppa_list is of a max fixed size of 64. This should spare the wasted
extra buffer per I/O.

Also, as I recall Matias had some feedback on making direct calls to
dma_pool_alloc instead of going through the helper path. It could be
integrated on this patch.

> {
> 	struct nvme_ns *ns =3D nvmdev->q->queuedata;
>=20
> -	return dma_pool_create(name, ns->ctrl->dev, PAGE_SIZE, =
PAGE_SIZE, 0);
> +	return dma_pool_create(name, ns->ctrl->dev, size, PAGE_SIZE, 0);
> }
>=20
> static void nvme_nvm_destroy_dma_pool(void *pool)
> @@ -982,6 +983,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>=20
> 	geo->csecs =3D 1 << ns->lba_shift;
> 	geo->sos =3D ns->ms;
> +
> +	if (nvm_realloc_dma_pool(ndev))
> +		nvm_unregister(ndev);

Since you create the dma pool here, you can remove the original creation
in nvm_register(). This will allow you to simply call create_dma_pool()
without having to do the manual reallocation destroying and allocating
again.

> }
>=20
> int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 2fdeac1a420d..9d3b7c627cac 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -90,7 +90,7 @@ typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, =
sector_t, int,
> 							struct =
nvm_chk_meta *);
> typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
> typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq =
*);
> -typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
> +typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, =
int);
> typedef void (nvm_destroy_dma_pool_fn)(void *);
> typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
> 								=
dma_addr_t *);
> @@ -420,6 +420,7 @@ struct nvm_dev {
>=20
> 	unsigned long *lun_map;
> 	void *dma_pool;
> +	uint32_t dma_pool_size;

When applying the above, you can remove this too.

>=20
> 	/* Backend device */
> 	struct request_queue *q;
> @@ -672,6 +673,7 @@ extern void *nvm_dev_dma_alloc(struct nvm_dev *, =
gfp_t, dma_addr_t *);
> extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
>=20
> extern struct nvm_dev *nvm_alloc_dev(int);
> +extern int nvm_realloc_dma_pool(struct nvm_dev *);
> extern int nvm_register(struct nvm_dev *);
> extern void nvm_unregister(struct nvm_dev *);
>=20
> --
> 2.14.4

Javier

--Apple-Mail=_20378AFC-4AA6-464A-B135-599724C66659
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlvW+AwACgkQIX4xUKFR
nnRq7g/7BSvCrunM9Jbv8YNOoAWkbKgibyDiqzUrhi6fM15D+siT3V6cfwxKjo8l
lI+MZkPeXuYrrCHSwSD0V483Xv3v6jiPkANydmsfpTuDEOdsDB+9fVkeGRzUuKd7
aTpIjXdGKRvmwrzdNKK2oMuLzqHzTeHpvS+tChAxFcd+58RiSwJMunuccN9s2Yjw
+oC2svmGIgnJWLl03X77t7kLUxcvHcTQ+YXrgb4pbOJutgFnY37s4pWBzEmn+326
egpEvM2igCxdvJ7PAhDe0/FS+odLagvM1sBXVLABIVO3z2UyOfEA0LFC7GBqXpXb
xzhAIpsODtSdztNkOCAIaf9RF/VPbUZPIUWdUFlxJ6rWPBf4T5Cr2uLt0K5h4kpj
jHT/zgugRh6zgdg4jL/5HXxVsCNT/YO2n655IEoRIsWOx5lBab+dv/ZQN9fJ9cPV
KTeYu6IlwtARAfU2s/n6nfAqdFR28wn0J3C5uN1SUgzT2hd4B4INiWJJyY10zCJ/
dLHCWPmIvqfCx3PjZdXwGur3jDaRmAibYkbjuX753Slo1SIm0Jn2bug04MuJtUj1
H8TOiD8wICPoEty7o8ByVZknv9x5gaeiWaEHXhD8+C2F+yYQJCqggOF7Y+KCShos
W14gw2GQNjRP2Ghc3680KxGg05FCQHO24TavOviHEfIk1fWerns=
=mZd7
-----END PGP SIGNATURE-----

--Apple-Mail=_20378AFC-4AA6-464A-B135-599724C66659--
