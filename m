Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B83C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 13:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A6C20855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 13:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="fmOf8UWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A6C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeK0ASn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:18:43 -0500
Received: from mail-eopbgr730052.outbound.protection.outlook.com ([40.107.73.52]:35424
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbeK0ASm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 19:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peAgrRurkk44ERirmvLM3G0s9TXnuuaxTBUZcNsB18s=;
 b=fmOf8UWdZQ9gHr4ST2Vf6QdIr/5wPKOS+ib5NJVBDD9XNvGfwb3TDbsIbSs1XXvSxE82HEysWb+5ZcjXSajk+bYjjoVMp7dyB78by9GnHLGCwjYL9KMRX5Cda0Kpg1Mx/4sUMuicziitzDYES1wz9aL7oah/hpfsbUM+CUDIlrI=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB3851.namprd06.prod.outlook.com (20.176.66.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Mon, 26 Nov 2018 13:24:30 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7%4]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 13:24:28 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v3 3/5] lightnvm: Flexible DMA pool entry size
Thread-Topic: [PATCH v3 3/5] lightnvm: Flexible DMA pool entry size
Thread-Index: AQHUg0RTKzaFBWSFo0iZr4paDPNoBqViECsA
Date:   Mon, 26 Nov 2018 13:24:28 +0000
Message-ID: <BD6DC1EE-2FDF-4313-8115-117B5E43FFA9@cnexlabs.com>
References: <20181123154538.59748-1-igor.j.konopko@intel.com>
 <20181123154538.59748-4-igor.j.konopko@intel.com>
In-Reply-To: <20181123154538.59748-4-igor.j.konopko@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB3851;6:eG7FOcyhJHlFzc9/6eG417Bw12rDRG/w971DglvmmUaBf26rAmSnAHZumwYiDTGDYk/lVkjs3KnophvJFrxR4UtPBc7w45030fVqHwxmDehHPt+TST1/fSD8IBQp3hwgaXTKBGB6FjZdK3CK0fXCe6XW745VP2yMyzF2Gg7lmc8nuvLEFshZLnpAQMyV9irJZNv7D/NbZh3BNUDjfyOlqigPbevRV000JHpJZqQTSoUZe7Yjk+ESyQd/O6cRpHKcZvNYFjbx+ABLa6N3O44pGlIKSvuSrF5ghQUWH2rquGYyc96Hx+99VYhIdknw/iRpQUHSgVKnMpFdr13EYcGtkMc8SDsnjgWY3qMLwLkziGhUIIywIKStTSYzpT/IriTyLoOBrGXxHz6cadi9jEko2tg1ba2kdzF7FSBUaJib+9vCkaTDrZhDUuP0v5n7Zr12EHuwRk0b6SmgwlRaotWV9A==;5:AHUVK2KBato/WOzV1Zbx6SxzGZA7QTZsRXoI9akJQxbtDL9i+WVDcJJN/oqZP0+IfETVgr6Vc41jqjsahTPEGsLoqwgW958/itLAvWtr/lE9kYGbhvZye9p3BSA5yb6ua1w6+N9u5cSowumroNUf2MzKurOSI5d7UzXqhNsk62I=;7:BC35GzVrT/tD2TI1ISrn0XMUSfpWVcPhpnfo1k6RVxDozLF8IPv2dPZ5+0lx2PDyYGkMwQl32U8bG8QNvsDiNzT4LBwj6M3cuAoRTsqPNhIrke1K5t0BFeuwnzv9IWH1pnPHHQpYVf/mQQ9eBUAsrw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(346002)(39830400003)(396003)(376002)(136003)(199004)(189003)(6436002)(478600001)(106356001)(316002)(105586002)(102836004)(6506007)(8676002)(6486002)(54906003)(25786009)(33656002)(81166006)(186003)(229853002)(486006)(86362001)(575784001)(446003)(11346002)(476003)(2616005)(6116002)(3846002)(8936002)(71190400001)(71200400001)(82746002)(26005)(99936001)(76176011)(99286004)(81156014)(14454004)(66574009)(6246003)(83716004)(97736004)(4326008)(107886003)(5660300001)(66066001)(256004)(14444005)(305945005)(6916009)(68736007)(6512007)(53936002)(36756003)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB3851;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 4b2e74e8-b27a-4b28-2d8a-08d653a27e19
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM6PR06MB3851;
x-ms-traffictypediagnostic: DM6PR06MB3851:
x-microsoft-antispam-prvs: <DM6PR06MB3851B597BF85CA455D842269BAD70@DM6PR06MB3851.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(4983020)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB3851;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB3851;
x-forefront-prvs: 086831DFB4
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Jy/Z6BhTv1Q470Pq92sSERQGkkD3Y7OtgIgVGhO1YGA5X6Os7oCMzXyTsfddK2f0O5j9/LnN12e/ieJr4gdklZan2dw+nR7ZRylmCD5ynOW/Xf4tFg5IqtXd5GLani9miviCfpjgMjwzIXC9DrY3dLs6ZUzF1j0ZAGsYZ5YYEphy2CsBfdpcJ7/joLoDP9EstGYYoCFEvwVHzGHUJkdnXxMk1vyzWmt49B2AOWGVHdN5Xb1fQ3op6WUVZODDFtalWPnQkkCFIjKvvoHR8DBxSibHmiIXYOHcN/fH0C2vyX4ZWgEH63OoAXkTSsPmkhFeyx08KDUgexq4HISdWa40UZ/lwBXQF3m894hUcJaepQc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_442A62FC-3C3A-4805-A606-503AD72281A1";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2e74e8-b27a-4b28-2d8a-08d653a27e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 13:24:28.3229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB3851
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Apple-Mail=_442A62FC-3C3A-4805-A606-503AD72281A1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 23 Nov 2018, at 16.45, Igor Konopko <igor.j.konopko@intel.com> =
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
> It also allows pblk to use OOB metadata >=3D16b.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/core.c          | 30 ++++++++++++++++++++----------
> drivers/lightnvm/pblk-core.c     |  8 ++++----
> drivers/lightnvm/pblk-init.c     |  2 +-
> drivers/lightnvm/pblk-recovery.c |  4 ++--
> drivers/lightnvm/pblk.h          |  6 +++++-
> drivers/nvme/host/lightnvm.c     | 15 +++++++++------
> include/linux/lightnvm.h         |  3 ++-
> 7 files changed, 43 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 73ab3cf26868..c3650b141a30 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1145,15 +1145,9 @@ int nvm_register(struct nvm_dev *dev)
> 	if (!dev->q || !dev->ops)
> 		return -EINVAL;
>=20
> -	dev->dma_pool =3D dev->ops->create_dma_pool(dev, "ppalist");
> -	if (!dev->dma_pool) {
> -		pr_err("nvm: could not create dma pool\n");
> -		return -ENOMEM;
> -	}
> -
> 	ret =3D nvm_init(dev);
> 	if (ret)
> -		goto err_init;
> +		return ret;
>=20
> 	/* register device with a supported media manager */
> 	down_write(&nvm_lock);
> @@ -1161,9 +1155,6 @@ int nvm_register(struct nvm_dev *dev)
> 	up_write(&nvm_lock);
>=20
> 	return 0;
> -err_init:
> -	dev->ops->destroy_dma_pool(dev->dma_pool);
> -	return ret;
> }
> EXPORT_SYMBOL(nvm_register);
>=20
> @@ -1187,6 +1178,25 @@ void nvm_unregister(struct nvm_dev *dev)
> }
> EXPORT_SYMBOL(nvm_unregister);
>=20
> +int nvm_alloc_dma_pool(struct nvm_dev *dev)
> +{
> +	int exp_pool_size;
> +
> +	exp_pool_size =3D max_t(int, PAGE_SIZE,
> +			      (NVM_MAX_VLBA * (sizeof(u64) + =
dev->geo.sos)));
> +	exp_pool_size =3D round_up(exp_pool_size, PAGE_SIZE);
> +
> +	dev->dma_pool =3D dev->ops->create_dma_pool(dev, "ppalist",
> +						  exp_pool_size);
> +	if (!dev->dma_pool) {
> +		pr_err("nvm: could not create dma pool\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(nvm_alloc_dma_pool);
> +
> static int __nvm_configure_create(struct nvm_ioctl_create *create)
> {
> 	struct nvm_dev *dev;
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 9509d6dbed53..2ebd3b079a96 100644
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
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 6e7a0c6c6655..b67bca810eb7 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -410,7 +410,7 @@ static int pblk_core_init(struct pblk *pblk)
> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>=20
> 	pblk->oob_meta_size =3D geo->sos;
> -	if (pblk->oob_meta_size !=3D sizeof(struct pblk_sec_meta)) {
> +	if (pblk->oob_meta_size < sizeof(struct pblk_sec_meta)) {
> 		pblk_err(pblk, "Unsupported metadata size\n");
> 		return -EINVAL;
> 	}
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 902c54ab1318..5bb8a2a4f87b 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -475,8 +475,8 @@ static int pblk_recov_l2p_from_oob(struct pblk =
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
> index 80f356688803..9087d53d5c25 100644
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
> @@ -1388,4 +1387,9 @@ static inline struct pblk_sec_meta =
*pblk_get_meta(struct pblk *pblk,
> {
> 	return meta + pblk->oob_meta_size * index;
> }
> +
> +static inline int pblk_dma_meta_size(struct pblk *pblk)
> +{
> +	return pblk->oob_meta_size * NVM_MAX_VLBA;
> +}
> #endif /* PBLK_H_ */
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index d64805dc8efb..55076912a673 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -732,11 +732,12 @@ static int nvme_nvm_submit_io_sync(struct =
nvm_dev *dev, struct nvm_rq *rqd)
> 	return ret;
> }
>=20
> -static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char =
*name)
> +static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char =
*name,
> +					int size)
> {
> 	struct nvme_ns *ns =3D nvmdev->q->queuedata;
>=20
> -	return dma_pool_create(name, ns->ctrl->dev, PAGE_SIZE, =
PAGE_SIZE, 0);
> +	return dma_pool_create(name, ns->ctrl->dev, size, PAGE_SIZE, 0);
> }
>=20
> static void nvme_nvm_destroy_dma_pool(void *pool)
> @@ -978,11 +979,13 @@ void nvme_nvm_update_nvm_info(struct nvme_ns =
*ns)
> 	struct nvm_dev *ndev =3D ns->ndev;
> 	struct nvm_geo *geo =3D &ndev->geo;
>=20
> -	if (geo->version =3D=3D NVM_OCSSD_SPEC_12)
> -		return;
> +	if (geo->version !=3D NVM_OCSSD_SPEC_12) {
> +		geo->csecs =3D 1 << ns->lba_shift;
> +		geo->sos =3D ns->ms;
> +	}
>=20
> -	geo->csecs =3D 1 << ns->lba_shift;
> -	geo->sos =3D ns->ms;
> +	if (nvm_alloc_dma_pool(ndev))
> +		nvm_unregister(ndev);
> }
>=20
> int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 2fdeac1a420d..8b4564c17656 100644
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
> @@ -672,6 +672,7 @@ extern void *nvm_dev_dma_alloc(struct nvm_dev *, =
gfp_t, dma_addr_t *);
> extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
>=20
> extern struct nvm_dev *nvm_alloc_dev(int);
> +extern int nvm_alloc_dma_pool(struct nvm_dev *);
> extern int nvm_register(struct nvm_dev *);
> extern void nvm_unregister(struct nvm_dev *);
>=20
> --
> 2.14.4

Looks good.

We had talked about removing the dma allocation helpers too; I'll send a
patch to do this later today

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_442A62FC-3C3A-4805-A606-503AD72281A1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlv79AoACgkQIX4xUKFR
nnSgzg/8Dh/LMy9AdOZAek8sAOlI/HykiG6K7nb6KB2pdQi4Hic3vBp23zzraRU5
nh7EppPggA8kLfgCvSaQyNT3LPYuko6o7eJd9GMjfJivYDlTl1WaI+MgHVDroz13
bYq7YOB1xVJ8cSr9/BdhqskVM/Si2W0PXCqt5TDz1IqeQLsEsWi8g8K5Wwk2JHzL
fnxdwF4uV0sqk2NjEJcx8UJ5D1hhNL1g+TAF4voDbLVVAecYsynGPQawwKZFgwRT
wJR7E17OYfiQkvtLUtF5tRxGWVI6Xh8ulhSAz+Rn+0cKQi0N5NqwyY5IKWJW0795
X/3Gajn5QySQEr9VtLAVG51pZ1kKIx38Gy3J5c17fFJszGBNaGYUi7plmLLqoych
ilF53CYfWi2w7msuajutYUtQ4ghw0+MDkzUVIjEMRyeDkfsSKfbNotzjakikn4a9
IhQIH6wTuk4ki/olCpsSKONrxik86kZhXgigA8iNq6T5QuVUryPsiZ0gDp66GHj3
nDW7sXxRK97F1sCMSEzvi+hqbPY6AAzQrkX+6XxNvi52Q/ptBoPEvDjH8bSWygL+
2En3MZlY8wXc7SuRK5ezBsS09Psbptf6kcq0L7zAci62ycixN3hpQR3ZEguY5Lu/
UPpINERnsBt039xKGic5gXMfohtZOYDLa/hxl4d6CkS+Sckzw60=
=dtmR
-----END PGP SIGNATURE-----

--Apple-Mail=_442A62FC-3C3A-4805-A606-503AD72281A1--
