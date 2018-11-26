Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAD4C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 11:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C9620672
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 11:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="ax2HkJ7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C9620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbeKZV4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:04 -0500
Received: from mail-eopbgr710053.outbound.protection.outlook.com ([40.107.71.53]:40384
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729354AbeKZV4D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpqPM6i1sab4keCssmVjd7bQllmCRh2ZpeHy/czxA/w=;
 b=ax2HkJ7JgdrZ8V0e1U93nKGSb4+1hM0hsciNwOOo9K7spLeyFJ2jE7V9SqD1YnfOaj/BJpsylD9kMCPUl2l7IdyjTDyP4HWMbJAp2/i84OPBqfYfax2HtCwLyKbGNc4rXHxGlAaiHSuVBldv87QMcwDMRqGNLUhBZDImC9tHAP4=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB4410.namprd06.prod.outlook.com (20.176.108.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Mon, 26 Nov 2018 11:02:14 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7%4]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 11:02:10 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v3 2/5] lightnvm: pblk: Helpers for OOB metadata
Thread-Topic: [PATCH v3 2/5] lightnvm: pblk: Helpers for OOB metadata
Thread-Index: AQHUg0RRptxKgQ2vd0OmN7dHpDMZF6Vh6GqA
Date:   Mon, 26 Nov 2018 11:02:10 +0000
Message-ID: <6AB987DE-7DE6-4996-A6ED-F6DAFD827F74@cnexlabs.com>
References: <20181123154538.59748-1-igor.j.konopko@intel.com>
 <20181123154538.59748-3-igor.j.konopko@intel.com>
In-Reply-To: <20181123154538.59748-3-igor.j.konopko@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB4410;6:TvNpdfpZZOyElXC7lDbYwtrp55nm2yh3aixg7kcAfsrsUWj2pW4J2eCLdxL0+W1lrUs8nEph5QCDkS9NgbuZLZGpX6GGK1WvwRZo7rtXDjZ0rdZiuQBEmxwHGyMmceLlT/iU5Qfr7q/GQdtgYEV7AkDT+gHEwArOYKDzUYWTAIYIF0UKs/DwalDFjuGMhrHzZ0RWvgJRDDohcAqIIE+31VajJhjkOAudp9ueHWNLhx0vILOZ6zNLsdOv+utLPegwZQHQBnVh6P+bmFyJe4Q5B9d5J7oWukdssCSm+h9LrLEdb0IqBx/ZmwhV30xF38jh1nmaOK1tXSy4npTNdm+l/JAE2AKOgph9+c8wChE3A1ILF8KR5tDhx/CgeOYd3X6/GKGjO8HxDs9TfhHCXlAyqmcjNUDJboCkErwhJFvKr6KXOJHvpKfcVufc0vbQvQ7Q9DDVdwcMFBYiW0lgU5FqdA==;5:4Xf7NHc6KpP6YcyDgeMcHetAg/CcUbZmmguMgTTgIM3VQ2E9fhQAR1bCgBzLk4E05xk9CQTSHxpri5Jk5aSg5yobnWu8JvT9jT2yqeRFuwFdflvxgfJcCZ3XyGFIzilDnkOsh7XlZ3QC1C1lfRvavQF5aFu6i44WWuWYMyDlDL4=;7:feTYt1rf2PxuOeRPvLJiJhUZYN/yCesgSTyE3J5K1BMu9ssQAZmdwMDn121j8khvOC0H10u+L9ydVJN4CSMx3KLtxqvmOIRXpKEHV5TqwBfOGm3jSZHwNIijKmfjILceiJmidkKCa28Pv70zW0RcmQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39830400003)(396003)(136003)(199004)(189003)(66066001)(6116002)(26005)(446003)(3846002)(316002)(186003)(6246003)(7736002)(71190400001)(6486002)(97736004)(71200400001)(83716004)(8676002)(2906002)(4744004)(229853002)(68736007)(6436002)(14454004)(11346002)(6506007)(102836004)(575784001)(86362001)(5660300001)(8936002)(256004)(4326008)(106356001)(105586002)(76176011)(478600001)(99936001)(36756003)(82746002)(54906003)(305945005)(107886003)(6916009)(486006)(2616005)(53936002)(81156014)(25786009)(99286004)(33656002)(476003)(6512007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB4410;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 3001a439-31d1-45df-f36a-08d6538e9d2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM6PR06MB4410;
x-ms-traffictypediagnostic: DM6PR06MB4410:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-microsoft-antispam-prvs: <DM6PR06MB4410DE685D9D4C09DD7B9D69BAD70@DM6PR06MB4410.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231443)(944501410)(4983020)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB4410;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB4410;
x-forefront-prvs: 086831DFB4
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 57gz3QYUkFUNwccG2sjEpJsR5gkQUOYdrkAi9+PQiLo2VB2WxnkzOn+8JIWR+LBunYfjIeylCGJtKzKc2QAIZssw2lRwPzd1SdD7CizFJNHdvG2Ze0VsYVAkijaY2mzi1EGdcYWCTLLR4sZ615K2JIfHPcta7ENoDAhhaZZ0DyxMUeR0rI/zCi30u/4h9PfpyopN/455FaV+vd8c2H7mgrKuKa5Ij0paolNcFj8yiN1PP+JAjDqWf1h3jMWk4U3Ch25x9S61dL3xasrwBCAKubxEQnIZwTn9ITBgXl7p/fkgpskISRapVgOqPx0Xq1pvb9BC3EMpoaVgqE+rDtSWW6K4YM3Edv3qnfFrcli768s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2C43CD2D-B877-486E-AE6F-2DF2E8DEBE52";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3001a439-31d1-45df-f36a-08d6538e9d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 11:02:10.5437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4410
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Apple-Mail=_2C43CD2D-B877-486E-AE6F-2DF2E8DEBE52
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 23 Nov 2018, at 16.45, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently pblk assumes that size of OOB metadata on drive is always
> equal to size of pblk_sec_meta struct. This commit add helpers which =
will
> allow to handle different sizes of OOB metadata on drive in the =
future.
> Still, after this patch only OOB metadata equal to 16b is supported.

16B (or write bytes directly)

>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     |  5 +++--
> drivers/lightnvm/pblk-init.c     |  6 ++++++
> drivers/lightnvm/pblk-map.c      | 21 +++++++++++++-------
> drivers/lightnvm/pblk-read.c     | 42 =
+++++++++++++++++++++++++---------------
> drivers/lightnvm/pblk-recovery.c | 13 +++++++------
> drivers/lightnvm/pblk.h          |  6 ++++++
> 6 files changed, 62 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 6581c35f51ee..9509d6dbed53 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -796,10 +796,11 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line,
> 	rqd.is_seq =3D 1;
>=20
> 	for (i =3D 0; i < lm->smeta_sec; i++, paddr++) {
> -		struct pblk_sec_meta *meta_list =3D rqd.meta_list;
> +		void *meta_list =3D rqd.meta_list;
>=20
> 		rqd.ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, =
line->id);
> -		meta_list[i].lba =3D lba_list[paddr] =3D addr_empty;
> +		pblk_get_meta(pblk, meta_list, i)->lba =3D =
lba_list[paddr] =3D
> +								=
addr_empty;
> 	}
>=20
> 	ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 0e37104de596..6e7a0c6c6655 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -409,6 +409,12 @@ static int pblk_core_init(struct pblk *pblk)
> 		queue_max_hw_sectors(dev->q) / (geo->csecs >> =
SECTOR_SHIFT));
> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>=20
> +	pblk->oob_meta_size =3D geo->sos;
> +	if (pblk->oob_meta_size !=3D sizeof(struct pblk_sec_meta)) {
> +		pblk_err(pblk, "Unsupported metadata size\n");
> +		return -EINVAL;
> +	}

You can move this check to the beginning of pblk_init(), where we
already do a check on geo->version. No seed to start initializing things
if we already know that we will fail the instance creation.

> +
> 	pblk->pad_dist =3D kcalloc(pblk->min_write_pgs - 1, =
sizeof(atomic64_t),
> 								=
GFP_KERNEL);
> 	if (!pblk->pad_dist)
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 5a3c28cce8ab..0c6d962bad78 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -22,7 +22,7 @@
> static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
> 			      struct ppa_addr *ppa_list,
> 			      unsigned long *lun_bitmap,
> -			      struct pblk_sec_meta *meta_list,
> +			      void *meta_list,
> 			      unsigned int valid_secs)
> {
> 	struct pblk_line *line =3D pblk_line_get_data(pblk);
> @@ -74,14 +74,17 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> 			kref_get(&line->ref);
> 			w_ctx =3D pblk_rb_w_ctx(&pblk->rwb, sentry + i);
> 			w_ctx->ppa =3D ppa_list[i];
> -			meta_list[i].lba =3D cpu_to_le64(w_ctx->lba);
> +			pblk_get_meta(pblk, meta_list, i)->lba =3D
> +						cpu_to_le64(w_ctx->lba);
> 			lba_list[paddr] =3D cpu_to_le64(w_ctx->lba);
> 			if (lba_list[paddr] !=3D addr_empty)
> 				line->nr_valid_lbas++;
> 			else
> 				atomic64_inc(&pblk->pad_wa);
> 		} else {
> -			lba_list[paddr] =3D meta_list[i].lba =3D =
addr_empty;
> +			lba_list[paddr] =3D addr_empty;
> +			pblk_get_meta(pblk, meta_list, i)->lba =3D
> +								=
addr_empty;
> 			__pblk_map_invalidate(pblk, line, paddr);
> 		}
> 	}
> @@ -94,7 +97,8 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
> 		 unsigned long *lun_bitmap, unsigned int valid_secs,
> 		 unsigned int off)
> {
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> +	void *meta_buffer;
> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	unsigned int map_secs;
> 	int min =3D pblk->min_write_pgs;
> @@ -103,9 +107,10 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
>=20
> 	for (i =3D off; i < rqd->nr_ppas; i +=3D min) {
> 		map_secs =3D (i + min > valid_secs) ? (valid_secs % min) =
: min;
> +		meta_buffer =3D pblk_get_meta(pblk, meta_list, i);
>=20
> 		ret =3D pblk_map_page_data(pblk, sentry + i, =
&ppa_list[i],
> -					lun_bitmap, &meta_list[i], =
map_secs);
> +					lun_bitmap, meta_buffer, =
map_secs);
> 		if (ret)
> 			return ret;
> 	}
> @@ -121,7 +126,8 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> +	void *meta_buffer;
> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	struct pblk_line *e_line, *d_line;
> 	unsigned int map_secs;
> @@ -132,9 +138,10 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>=20
> 	for (i =3D 0; i < rqd->nr_ppas; i +=3D min) {
> 		map_secs =3D (i + min > valid_secs) ? (valid_secs % min) =
: min;
> +		meta_buffer =3D pblk_get_meta(pblk, meta_list, i);
>=20
> 		ret =3D pblk_map_page_data(pblk, sentry + i, =
&ppa_list[i],
> -					lun_bitmap, &meta_list[i], =
map_secs);
> +					lun_bitmap, meta_buffer, =
map_secs);
> 		if (ret)
> 			return ret;
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 19917d3c19b3..f13a7afd815f 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -43,7 +43,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 				 struct bio *bio, sector_t blba,
> 				 unsigned long *read_bitmap)
> {
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	struct ppa_addr ppas[NVM_MAX_VLBA];
> 	int nr_secs =3D rqd->nr_ppas;
> 	bool advanced_bio =3D false;
> @@ -57,8 +57,10 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
>=20
> retry:
> 		if (pblk_ppa_empty(p)) {
> +			__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
> +
> 			WARN_ON(test_and_set_bit(i, read_bitmap));
> -			meta_list[i].lba =3D cpu_to_le64(ADDR_EMPTY);
> +			pblk_get_meta(pblk, meta_list, i)->lba =3D =
addr_empty;
>=20
> 			if (unlikely(!advanced_bio)) {
> 				bio_advance(bio, (i) * =
PBLK_EXPOSED_PAGE_SIZE);
> @@ -78,7 +80,8 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 				goto retry;
> 			}
> 			WARN_ON(test_and_set_bit(i, read_bitmap));
> -			meta_list[i].lba =3D cpu_to_le64(lba);
> +			pblk_get_meta(pblk, meta_list, i)->lba =3D
> +							=
cpu_to_le64(lba);
> 			advanced_bio =3D true;
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 			atomic_long_inc(&pblk->cache_reads);
> @@ -105,12 +108,12 @@ static void pblk_read_ppalist_rq(struct pblk =
*pblk, struct nvm_rq *rqd,
> static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
> 				sector_t blba)
> {
> -	struct pblk_sec_meta *meta_lba_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	int nr_lbas =3D rqd->nr_ppas;
> 	int i;
>=20
> 	for (i =3D 0; i < nr_lbas; i++) {
> -		u64 lba =3D le64_to_cpu(meta_lba_list[i].lba);
> +		u64 lba =3D le64_to_cpu(pblk_get_meta(pblk, meta_list, =
i)->lba);
>=20
> 		if (lba =3D=3D ADDR_EMPTY)
> 			continue;
> @@ -134,7 +137,7 @@ static void pblk_read_check_seq(struct pblk *pblk, =
struct nvm_rq *rqd,
> static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq =
*rqd,
> 				 u64 *lba_list, int nr_lbas)
> {
> -	struct pblk_sec_meta *meta_lba_list =3D rqd->meta_list;
> +	void *meta_lba_list =3D rqd->meta_list;
> 	int i, j;
>=20
> 	for (i =3D 0, j =3D 0; i < nr_lbas; i++) {
> @@ -144,7 +147,8 @@ static void pblk_read_check_rand(struct pblk =
*pblk, struct nvm_rq *rqd,
> 		if (lba =3D=3D ADDR_EMPTY)
> 			continue;
>=20
> -		meta_lba =3D le64_to_cpu(meta_lba_list[j].lba);
> +		meta_lba =3D le64_to_cpu(pblk_get_meta(pblk,
> +						     meta_lba_list, =
j)->lba);
>=20
> 		if (lba !=3D meta_lba) {
> #ifdef CONFIG_NVM_PBLK_DEBUG
> @@ -219,7 +223,7 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 	struct bio *new_bio =3D rqd->bio;
> 	struct bio *bio =3D pr_ctx->orig_bio;
> 	struct bio_vec src_bv, dst_bv;
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	int bio_init_idx =3D pr_ctx->bio_init_idx;
> 	unsigned long *read_bitmap =3D pr_ctx->bitmap;
> 	int nr_secs =3D pr_ctx->orig_nr_secs;
> @@ -237,8 +241,10 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 	}
>=20
> 	for (i =3D 0; i < nr_secs; i++) {
> -		pr_ctx->lba_list_media[i] =3D meta_list[i].lba;
> -		meta_list[i].lba =3D pr_ctx->lba_list_mem[i];
> +		pr_ctx->lba_list_media[i] =3D =
le64_to_cpu(pblk_get_meta(pblk,
> +							meta_list, =
i)->lba);
> +		pblk_get_meta(pblk, meta_list, i)->lba =3D
> +					=
cpu_to_le64(pr_ctx->lba_list_mem[i]);
> 	}
>=20
> 	/* Fill the holes in the original bio */
> @@ -250,7 +256,8 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 		line =3D pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
> 		kref_put(&line->ref, pblk_line_put);
>=20
> -		meta_list[hole].lba =3D pr_ctx->lba_list_media[i];
> +		pblk_get_meta(pblk, meta_list, hole)->lba =3D
> +					=
cpu_to_le64(pr_ctx->lba_list_media[i]);
>=20
> 		src_bv =3D new_bio->bi_io_vec[i++];
> 		dst_bv =3D bio->bi_io_vec[bio_init_idx + hole];
> @@ -286,7 +293,7 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
> 			    unsigned long *read_bitmap,
> 			    int nr_holes)
> {
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> 	struct pblk_pr_ctx *pr_ctx;
> 	struct bio *new_bio, *bio =3D r_ctx->private;
> @@ -308,7 +315,8 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
> 		goto fail_free_pages;
>=20
> 	for (i =3D 0; i < nr_secs; i++)
> -		pr_ctx->lba_list_mem[i] =3D meta_list[i].lba;
> +		pr_ctx->lba_list_mem[i] =3D =
le64_to_cpu(pblk_get_meta(pblk,
> +							meta_list, =
i)->lba);
>=20
> 	new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
> 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
> @@ -373,7 +381,7 @@ static int pblk_partial_read_bio(struct pblk =
*pblk, struct nvm_rq *rqd,
> static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct =
bio *bio,
> 			 sector_t lba, unsigned long *read_bitmap)
> {
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	struct ppa_addr ppa;
>=20
> 	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
> @@ -384,8 +392,10 @@ static void pblk_read_rq(struct pblk *pblk, =
struct nvm_rq *rqd, struct bio *bio,
>=20
> retry:
> 	if (pblk_ppa_empty(ppa)) {
> +		__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
> +
> 		WARN_ON(test_and_set_bit(0, read_bitmap));
> -		meta_list[0].lba =3D cpu_to_le64(ADDR_EMPTY);
> +		pblk_get_meta(pblk, meta_list, 0)->lba =3D addr_empty;
> 		return;
> 	}
>=20
> @@ -399,7 +409,7 @@ static void pblk_read_rq(struct pblk *pblk, struct =
nvm_rq *rqd, struct bio *bio,
> 		}
>=20
> 		WARN_ON(test_and_set_bit(0, read_bitmap));
> -		meta_list[0].lba =3D cpu_to_le64(lba);
> +		pblk_get_meta(pblk, meta_list, 0)->lba =3D =
cpu_to_le64(lba);
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 		atomic_long_inc(&pblk->cache_reads);
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 416d9840544b..902c54ab1318 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -124,7 +124,7 @@ static u64 pblk_sec_in_open_line(struct pblk =
*pblk, struct pblk_line *line)
>=20
> struct pblk_recov_alloc {
> 	struct ppa_addr *ppa_list;
> -	struct pblk_sec_meta *meta_list;
> +	void *meta_list;
> 	struct nvm_rq *rqd;
> 	void *data;
> 	dma_addr_t dma_ppa_list;
> @@ -158,7 +158,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> -	struct pblk_sec_meta *meta_list;
> +	void *meta_list;
> 	struct pblk_pad_rq *pad_rq;
> 	struct nvm_rq *rqd;
> 	struct bio *bio;
> @@ -242,7 +242,8 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> 			dev_ppa =3D addr_to_gen_ppa(pblk, w_ptr, =
line->id);
>=20
> 			pblk_map_invalidate(pblk, dev_ppa);
> -			lba_list[w_ptr] =3D meta_list[i].lba =3D =
addr_empty;
> +			lba_list[w_ptr] =3D addr_empty;
> +			pblk_get_meta(pblk, meta_list, i)->lba =3D =
addr_empty;

You have this construction in several places. What about doing something
like the following, (mainly for readability purposes):

	struct pblk_sec_meta *meta_list;

	[...]

	meta_list =3D pblk_get_meta(pblk, rqd->meta_list, i);
	meta_list->lba =3D addr_empty;


> 			rqd->ppa_list[i] =3D dev_ppa;
> 		}
> 	}
> @@ -337,7 +338,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct ppa_addr *ppa_list;
> -	struct pblk_sec_meta *meta_list;
> +	void *meta_list;
> 	struct nvm_rq *rqd;
> 	struct bio *bio;
> 	void *data;
> @@ -435,7 +436,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	}
>=20
> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
> -		u64 lba =3D le64_to_cpu(meta_list[i].lba);
> +		u64 lba =3D le64_to_cpu(pblk_get_meta(pblk, meta_list, =
i)->lba);
>=20
> 		lba_list[paddr++] =3D cpu_to_le64(lba);
>=20
> @@ -464,7 +465,7 @@ static int pblk_recov_l2p_from_oob(struct pblk =
*pblk, struct pblk_line *line)
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct nvm_rq *rqd;
> 	struct ppa_addr *ppa_list;
> -	struct pblk_sec_meta *meta_list;
> +	void *meta_list;
> 	struct pblk_recov_alloc p;
> 	void *data;
> 	dma_addr_t dma_ppa_list, dma_meta_list;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 0e9d3960ac4c..80f356688803 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -634,6 +634,7 @@ struct pblk {
>=20
> 	int min_write_pgs; /* Minimum amount of pages required by =
controller */
> 	int max_write_pgs; /* Maximum amount of pages supported by =
controller */
> +	int oob_meta_size; /* Size of OOB sector metadata */
>=20
> 	sector_t capacity; /* Device capacity when bad blocks are =
subtracted */
>=20
> @@ -1380,6 +1381,11 @@ static inline unsigned int =
pblk_get_min_chks(struct pblk *pblk)
> 	 */
>=20
> 	return DIV_ROUND_UP(100, pblk->op) * lm->blk_per_line;
> +}
>=20
> +static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
> +							 void *meta, int =
index)
> +{
> +	return meta + pblk->oob_meta_size * index;
> }
> #endif /* PBLK_H_ */
> --
> 2.14.4

Otherwise, you can add my review.


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_2C43CD2D-B877-486E-AE6F-2DF2E8DEBE52
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlv70rEACgkQIX4xUKFR
nnRlEQ/7BgzBsUBjJWuT9mbaQgUWcHFXLkfDH97Csy1dD3V7MTSv9OrznAyd3LTx
bb6RlxcJIrOcnw7SuFdLQQSP4Sfeaqogo2ZnKrHj8/EMiREV1/uhCgxzfAhjYhNd
XV3/ndB89zrW1NayqAh6OEnkNDzJov/NL0KhbRPz/Oex3g0rPQfLB9mMUmyKpf7b
eU2jp/JV9LVNZk2RsS3+R7eMMW/eAhCy7wH2pNFvoJMBHy+Pj6HZVCK677q815Et
1Kqd+nnHd3/d0oRgbRS0RfpdatWPDLRfV28Pjq634kZcMMcUK9JswLoPbLEI/j8I
IqVPKgHUcQ+0oyXKk1KOaW6lf9S5PCJModJNRqV1n776wCrnFZtG/E+OZwuk1BTt
Hlpo7LWg1wveDozzchb02By9V+rSu6ocWOk7aVa/IRCHzU+fuY8i5F1tIqFyt4Wt
uzLvrEZxYQz9xzhYAASgVrYpzxOkxo5DGNrqlQGqUKEuBPVdKepbLtql0pmuHdn7
cfBMfWZNKJzM3efr3Gs6x8HQejfkdTtfVoa7oQSwDsRIZzuCMbZ8nHKzX0ccTElb
ZXgPHYWTm+rEGYuW8zhU6/NN6ZfSJOSRv2SU7HktULa4rf1CjYd6L5/KFXex+dXj
yVqR5S8f50+7a5h+D+R4fMmVLx3wBf7JuzfhXS1gcP7dfgBw8qM=
=Prei
-----END PGP SIGNATURE-----

--Apple-Mail=_2C43CD2D-B877-486E-AE6F-2DF2E8DEBE52--
