Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9DC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 12:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846C02081C
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 12:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="i6nbfMfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846C02081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeK2XQB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:16:01 -0500
Received: from mail-eopbgr690071.outbound.protection.outlook.com ([40.107.69.71]:16664
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbeK2XQB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 18:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaquZJi7cQIn3hoSyyXYYg7vGQNEc5LNVyJxxowiJWg=;
 b=i6nbfMfRjYuEXw2W5AnpHqrZvlqxQVABJMo7K+V2xqAF+a0vSe8rMEmZDm618HY/t6gGAG1K0oucbpz5qHxLcAP8UDzKQ6EGzcDjJM+2n+uwD9F87uuRjzHwga6t2xNTA0QrozZ2EzE5xkZgLz1+qayl2GXff9R1EoEwxAYlC6Q=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB4220.namprd06.prod.outlook.com (20.176.105.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 12:10:46 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7%4]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 12:10:44 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v4 5/5] lightnvm: pblk: Support for packed metadata
Thread-Topic: [PATCH v4 5/5] lightnvm: pblk: Support for packed metadata
Thread-Index: AQHUh7Q2bkSkZ6QWDkSc9WsfW5tbSKVmqbGA
Date:   Thu, 29 Nov 2018 12:10:44 +0000
Message-ID: <1EB93D92-8F18-42CC-8B64-8CFB0AD97156@cnexlabs.com>
References: <20181129071606.56942-1-igor.j.konopko@intel.com>
 <20181129071606.56942-6-igor.j.konopko@intel.com>
In-Reply-To: <20181129071606.56942-6-igor.j.konopko@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB4220;6:akPNhQ4ZC4GMuqySljiBjQ0hcjD8inrIciFI2h23jnZLqQ1G0rlBHCfcuVlKnTjrSd+dcw+SlUqNwuL04r+rdh8qRJ1mv1U+XZxFVuzllZGFujhwxwVimo9LrI+LZqW1Wd8ibBlaFhhFNjZX9wUbNHclBsDUWrbGEe03HAYX8u7EbIfUkZCpPxHKkBdKNIfaOPe2hS8R5cRqlj4RHYWOXaqKGX+g1R4j9yVO4wPEjHICF1Kz0L/zEz3TlvNUWlxfz4ohlHhRwea/BNCogm4853SH6WIJn9nsPHRIlAAn+r91JfCi9Msng/OcM7m0JKVe36sEaf3+VAkXnlePpUxrBwSihunzIsE3mzvKGnm8KWs8L06cJ0j0UqPKx/R42+ung102oB8YA2+re0kodqLDL14ogKGYbncwaYUa4yQeBwk+kgXdoQdHFywLiTJ41SkRN/Qzpj/UDV3HqyoGJvCs9Q==;5:akNUCwmOwj/zcm7EnvwMYDu3cgVQF3suvSrvpqdMKWRpTQsK2+u/s0bSWvillUdBSW4WAFiqdxmeSUcqdsxFlXS4hJ55g61Bu5xCfO3hzZEE8k39zmj1hh2mnhp6ypR61pb7yg+9Cly65cuVV7wS7PAbL1B07T0x0LbbvLSo8d8=;7:FJr1awpQf6L2fHYq/G440RmTdT+O2g6jGSPKfs5XDWC1so0jRFKVpJhmjAuQebK1DHIwWmFGBnKWI9rL53WPnpBTS/hbY2K9QaUXn2MolBsMVAQVWY+htwmNT1FzKdFti0ALWPezRWalJ/UWCThDRQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39830400003)(396003)(136003)(52084003)(199004)(189003)(105586002)(81166006)(106356001)(8676002)(107886003)(97736004)(53936002)(53946003)(82746002)(6436002)(6486002)(14444005)(76176011)(6506007)(99286004)(14454004)(6512007)(2616005)(446003)(486006)(68736007)(11346002)(4744004)(476003)(8936002)(256004)(6116002)(3846002)(99936001)(71200400001)(71190400001)(2906002)(66574009)(83716004)(66066001)(81156014)(6246003)(5660300001)(25786009)(478600001)(186003)(316002)(36756003)(229853002)(26005)(33656002)(102836004)(7736002)(54906003)(305945005)(4326008)(6916009)(86362001)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB4220;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 89f0ad90-8742-4188-955b-08d655f3b04e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM6PR06MB4220;
x-ms-traffictypediagnostic: DM6PR06MB4220:
x-microsoft-antispam-prvs: <DM6PR06MB422096704EE6CD92ED0F72F4BAD20@DM6PR06MB4220.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501410)(4983020)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB4220;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB4220;
x-forefront-prvs: 0871917CDA
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YFFpDJrCO0B8C4c/2vuItNiilHOydQa1EY7y/s0Mu7ZJ31zRmnD9TsAkDHGMypUhRYxgnXbYICWXb+GD++lutrOyWJWHx6Lr4uK5uMijbhGJNwvREiQuXS9d761TLyJxmGAoNRnJpD8feONyCZ53M+pqYkSdSmE97u/+BrapGnCxMYeLqfnkqbgLwKsJQUoMv0w5xPGI6Pc84pN9hZzcdaWh/yVVkoLHc3jWIEZV39OgSBXc6O89jaur4ytx1lNMixKR/stxE15iX9lBq8bH8uAm8l3fl8MUJkUSmrdQpMQwE53xB7KQn5Ro4vh9eqXV4AArdS1Dto6+ponrOmzVNZy/0pWlKA+qgx3I3igYTm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_12F830AE-A916-409D-AB07-505780BC38E7";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f0ad90-8742-4188-955b-08d655f3b04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 12:10:44.1246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4220
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Apple-Mail=_12F830AE-A916-409D-AB07-505780BC38E7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Nov 2018, at 08.16, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In current pblk implementation, l2p mapping for not closed lines
> is always stored only in OOB metadata and recovered from it.
>=20
> Such a solution does not provide data integrity when drives does
> not have such a OOB metadata space.
>=20
> The goal of this patch is to add support for so called packed
> metadata, which store l2p mapping for open lines in last sector
> of every write unit.
>=20
> After this set of changes, drives with OOB size <16B will use
> packed metadata, when >=3D16B will continue to use OOB metadata.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     | 48 =
++++++++++++++++++++++++++++++++++++----
> drivers/lightnvm/pblk-init.c     | 38 ++++++++++++++++++++++++++-----
> drivers/lightnvm/pblk-map.c      |  4 ++--
> drivers/lightnvm/pblk-rb.c       |  3 +++
> drivers/lightnvm/pblk-read.c     |  6 +++++
> drivers/lightnvm/pblk-recovery.c |  5 +++--
> drivers/lightnvm/pblk-sysfs.c    |  7 ++++++
> drivers/lightnvm/pblk-write.c    |  9 ++++----
> drivers/lightnvm/pblk.h          | 10 ++++++++-
> 9 files changed, 112 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 1347d1a93dd0..a95e18de5beb 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -376,7 +376,7 @@ void pblk_write_should_kick(struct pblk *pblk)
> {
> 	unsigned int secs_avail =3D pblk_rb_read_count(&pblk->rwb);
>=20
> -	if (secs_avail >=3D pblk->min_write_pgs)
> +	if (secs_avail >=3D pblk->min_write_pgs_data)
> 		pblk_write_kick(pblk);
> }
>=20
> @@ -407,7 +407,9 @@ struct list_head *pblk_line_gc_list(struct pblk =
*pblk, struct pblk_line *line)
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct list_head *move_list =3D NULL;
> -	int vsc =3D le32_to_cpu(*line->vsc);
> +	int packed_meta =3D (le32_to_cpu(*line->vsc) / =
pblk->min_write_pgs_data)
> +			* (pblk->min_write_pgs - =
pblk->min_write_pgs_data);
> +	int vsc =3D le32_to_cpu(*line->vsc) + packed_meta;
>=20
> 	lockdep_assert_held(&line->lock);
>=20
> @@ -620,12 +622,15 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, =
void *data,
> }
>=20
> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
> -		   unsigned long secs_to_flush)
> +		   unsigned long secs_to_flush, bool skip_meta)
> {
> 	int max =3D pblk->sec_per_write;
> 	int min =3D pblk->min_write_pgs;
> 	int secs_to_sync =3D 0;
>=20
> +	if (skip_meta && pblk->min_write_pgs_data !=3D =
pblk->min_write_pgs)
> +		min =3D max =3D pblk->min_write_pgs_data;
> +
> 	if (secs_avail >=3D max)
> 		secs_to_sync =3D max;
> 	else if (secs_avail >=3D min)
> @@ -852,7 +857,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct =
pblk_line *line,
> next_rq:
> 	memset(&rqd, 0, sizeof(struct nvm_rq));
>=20
> -	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
> +	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> 	rq_len =3D rq_ppas * geo->csecs;
>=20
> 	bio =3D pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len,
> @@ -2161,3 +2166,38 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, =
struct ppa_addr *ppas,
> 	}
> 	spin_unlock(&pblk->trans_lock);
> }
> +
> +void *pblk_get_meta_for_writes(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	void *buffer;
> +
> +	if (pblk_is_oob_meta_supported(pblk)) {
> +		/* Just use OOB metadata buffer as always */
> +		buffer =3D rqd->meta_list;
> +	} else {
> +		/* We need to reuse last page of request (packed =
metadata)
> +		 * in similar way as traditional oob metadata
> +		 */
> +		buffer =3D page_to_virt(
> +			rqd->bio->bi_io_vec[rqd->bio->bi_vcnt - =
1].bv_page);
> +	}
> +
> +	return buffer;
> +}
> +
> +void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	void *meta_list =3D rqd->meta_list;
> +	void *page;
> +	int i =3D 0;
> +
> +	if (pblk_is_oob_meta_supported(pblk))
> +		return;
> +
> +	page =3D page_to_virt(rqd->bio->bi_io_vec[rqd->bio->bi_vcnt - =
1].bv_page);
> +	/* We need to fill oob meta buffer with data from packed =
metadata */
> +	for (; i < rqd->nr_ppas; i++)
> +		memcpy(pblk_get_meta(pblk, meta_list, i),
> +			page + (i * sizeof(struct pblk_sec_meta)),
> +			sizeof(struct pblk_sec_meta));
> +}
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index a728f861edd6..830ebe3d098a 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -403,6 +403,7 @@ static int pblk_core_init(struct pblk *pblk)
> 	pblk->nr_flush_rst =3D 0;
>=20
> 	pblk->min_write_pgs =3D geo->ws_opt;
> +	pblk->min_write_pgs_data =3D pblk->min_write_pgs;
> 	max_write_ppas =3D pblk->min_write_pgs * geo->all_luns;
> 	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
> 	pblk->max_write_pgs =3D min_t(int, pblk->max_write_pgs,
> @@ -410,9 +411,35 @@ static int pblk_core_init(struct pblk *pblk)
> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>=20
> 	pblk->oob_meta_size =3D geo->sos;
> -	if (pblk->oob_meta_size < sizeof(struct pblk_sec_meta)) {
> -		pblk_err(pblk, "Unsupported metadata size\n");
> -		return -EINVAL;
> +	if (!pblk_is_oob_meta_supported(pblk)) {
> +		/* For drives which does not have OOB metadata feature
> +		 * in order to support recovery feature we need to use
> +		 * so called packed metadata. Packed metada will store
> +		 * the same information as OOB metadata (l2p table =
mapping,
> +		 * but in the form of the single page at the end of
> +		 * every write request.
> +		 */
> +		if (pblk->min_write_pgs
> +			* sizeof(struct pblk_sec_meta) > PAGE_SIZE) {
> +			/* We want to keep all the packed metadata on =
single
> +			 * page per write requests. So we need to ensure =
that
> +			 * it will fit.
> +			 *
> +			 * This is more like sanity check, since there =
is
> +			 * no device with such a big minimal write size
> +			 * (above 1 metabytes).
> +			 */
> +			pblk_err(pblk, "Not supported min write =
size\n");
> +			return -EINVAL;
> +		}
> +		/* For packed meta approach we do some simplification.
> +		 * On read path we always issue requests which size
> +		 * equal to max_write_pgs, with all pages filled with
> +		 * user payload except of last one page which will be
> +		 * filled with packed metadata.
> +		 */
> +		pblk->max_write_pgs =3D pblk->min_write_pgs;
> +		pblk->min_write_pgs_data =3D pblk->min_write_pgs - 1;
> 	}
>=20
> 	pblk->pad_dist =3D kcalloc(pblk->min_write_pgs - 1, =
sizeof(atomic64_t),
> @@ -645,7 +672,7 @@ static int pblk_set_provision(struct pblk *pblk, =
int nr_free_chks)
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	sector_t provisioned;
> -	int sec_meta, blk_meta;
> +	int sec_meta, blk_meta, clba;
> 	int minimum;
>=20
> 	if (geo->op =3D=3D NVM_TARGET_DEFAULT_OP)
> @@ -686,7 +713,8 @@ static int pblk_set_provision(struct pblk *pblk, =
int nr_free_chks)
> 	sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * =
l_mg->nr_free_lines;
> 	blk_meta =3D DIV_ROUND_UP(sec_meta, geo->clba);
>=20
> -	pblk->capacity =3D (provisioned - blk_meta) * geo->clba;
> +	clba =3D (geo->clba / pblk->min_write_pgs) * =
pblk->min_write_pgs_data;
> +	pblk->capacity =3D (provisioned - blk_meta) * clba;
>=20
> 	atomic_set(&pblk->rl.free_blocks, nr_free_chks);
> 	atomic_set(&pblk->rl.free_user_blocks, nr_free_chks);
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 81e503ec384e..79df583ea709 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -96,7 +96,7 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
> 		 unsigned long *lun_bitmap, unsigned int valid_secs,
> 		 unsigned int off)
> {
> -	void *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D pblk_get_meta_for_writes(pblk, rqd);
> 	void *meta_buffer;
> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	unsigned int map_secs;
> @@ -125,7 +125,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> -	void *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D pblk_get_meta_for_writes(pblk, rqd);
> 	void *meta_buffer;
> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	struct pblk_line *e_line, *d_line;
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index 9f7fa0fe9c77..d4ca8c64ee0f 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -552,6 +552,9 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb =
*rb, struct nvm_rq *rqd,
> 		to_read =3D count;
> 	}
>=20
> +	/* Add space for packed metadata if in use*/
> +	pad +=3D (pblk->min_write_pgs - pblk->min_write_pgs_data);
> +
> 	c_ctx->sentry =3D pos;
> 	c_ctx->nr_valid =3D to_read;
> 	c_ctx->nr_padded =3D pad;
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 6becd85ca4c6..3789185144da 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -112,6 +112,9 @@ static void pblk_read_check_seq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 	int nr_lbas =3D rqd->nr_ppas;
> 	int i;
>=20
> +	if (!pblk_is_oob_meta_supported(pblk))
> +		return;
> +
> 	for (i =3D 0; i < nr_lbas; i++) {
> 		struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, =
meta_list, i);
> 		u64 lba =3D le64_to_cpu(meta->lba);
> @@ -141,6 +144,9 @@ static void pblk_read_check_rand(struct pblk =
*pblk, struct nvm_rq *rqd,
> 	void *meta_lba_list =3D rqd->meta_list;
> 	int i, j;
>=20
> +	if (!pblk_is_oob_meta_supported(pblk))
> +		return;
> +
> 	for (i =3D 0, j =3D 0; i < nr_lbas; i++) {
> 		struct pblk_sec_meta *meta =3D pblk_get_meta(pblk,
> 							   =
meta_lba_list, j);
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 52cbe06e3ebc..d1960aa640d2 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -188,7 +188,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> 	kref_init(&pad_rq->ref);
>=20
> next_pad_rq:
> -	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
> +	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> 	if (rq_ppas < pblk->min_write_pgs) {
> 		pblk_err(pblk, "corrupted pad line %d\n", line->id);
> 		goto fail_free_pad;
> @@ -368,7 +368,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> next_rq:
> 	memset(rqd, 0, pblk_g_rq_size);
>=20
> -	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
> +	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> 	if (!rq_ppas)
> 		rq_ppas =3D pblk->min_write_pgs;
> 	rq_len =3D rq_ppas * geo->csecs;
> @@ -437,6 +437,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 		goto retry_rq;
> 	}
>=20
> +	pblk_get_packed_meta(pblk, rqd);
> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
> 		struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, =
meta_list, i);
> 		u64 lba =3D le64_to_cpu(meta->lba);
> diff --git a/drivers/lightnvm/pblk-sysfs.c =
b/drivers/lightnvm/pblk-sysfs.c
> index 2d2818155aa8..7d8958df9472 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -479,6 +479,13 @@ static ssize_t =
pblk_sysfs_set_sec_per_write(struct pblk *pblk,
> 	if (kstrtouint(page, 0, &sec_per_write))
> 		return -EINVAL;
>=20
> +	if (!pblk_is_oob_meta_supported(pblk)) {
> +		/* For packed metadata case it is
> +		 * not allowed to change sec_per_write.
> +		 */
> +		return -EINVAL;
> +	}
> +
> 	if (sec_per_write < pblk->min_write_pgs
> 				|| sec_per_write > pblk->max_write_pgs
> 				|| sec_per_write % pblk->min_write_pgs =
!=3D 0)
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index 2bf78f81862d..06d56deb645d 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -348,7 +348,7 @@ static int pblk_calc_secs_to_sync(struct pblk =
*pblk, unsigned int secs_avail,
> {
> 	int secs_to_sync;
>=20
> -	secs_to_sync =3D pblk_calc_secs(pblk, secs_avail, =
secs_to_flush);
> +	secs_to_sync =3D pblk_calc_secs(pblk, secs_avail, secs_to_flush, =
true);
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 	if ((!secs_to_sync && secs_to_flush)
> @@ -569,7 +569,7 @@ static int pblk_submit_write(struct pblk *pblk, =
int *secs_left)
> 	struct bio *bio;
> 	struct nvm_rq *rqd;
> 	unsigned int secs_avail, secs_to_sync, secs_to_com;
> -	unsigned int secs_to_flush;
> +	unsigned int secs_to_flush, packed_meta_pgs;
> 	unsigned long pos;
> 	unsigned int resubmit;
>=20
> @@ -607,7 +607,7 @@ static int pblk_submit_write(struct pblk *pblk, =
int *secs_left)
> 			return 0;
>=20
> 		secs_to_flush =3D pblk_rb_flush_point_count(&pblk->rwb);
> -		if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
> +		if (!secs_to_flush && secs_avail < =
pblk->min_write_pgs_data)
> 			return 0;
>=20
> 		secs_to_sync =3D pblk_calc_secs_to_sync(pblk, =
secs_avail,
> @@ -622,7 +622,8 @@ static int pblk_submit_write(struct pblk *pblk, =
int *secs_left)
> 		pos =3D pblk_rb_read_commit(&pblk->rwb, secs_to_com);
> 	}
>=20
> -	bio =3D bio_alloc(GFP_KERNEL, secs_to_sync);
> +	packed_meta_pgs =3D (pblk->min_write_pgs - =
pblk->min_write_pgs_data);
> +	bio =3D bio_alloc(GFP_KERNEL, secs_to_sync + packed_meta_pgs);
>=20
> 	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 9087d53d5c25..bc40b1381ff6 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -632,6 +632,7 @@ struct pblk {
> 	int state;			/* pblk line state */
>=20
> 	int min_write_pgs; /* Minimum amount of pages required by =
controller */
> +	int min_write_pgs_data; /* Minimum amount of payload pages */
> 	int max_write_pgs; /* Maximum amount of pages supported by =
controller */
> 	int oob_meta_size; /* Size of OOB sector metadata */
>=20
> @@ -838,7 +839,7 @@ void pblk_dealloc_page(struct pblk *pblk, struct =
pblk_line *line, int nr_secs);
> u64 pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int =
nr_secs);
> u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int =
nr_secs);
> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
> -		   unsigned long secs_to_flush);
> +		   unsigned long secs_to_flush, bool skip_meta);
> void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
> 		  unsigned long *lun_bitmap);
> void pblk_down_chunk(struct pblk *pblk, struct ppa_addr ppa);
> @@ -862,6 +863,8 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, =
struct ppa_addr *ppas,
> 			  u64 *lba_list, int nr_secs);
> void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
> 			 sector_t blba, int nr_secs);
> +void *pblk_get_meta_for_writes(struct pblk *pblk, struct nvm_rq =
*rqd);
> +void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd);
>=20
> /*
>  * pblk user I/O write path
> @@ -1392,4 +1395,9 @@ static inline int pblk_dma_meta_size(struct pblk =
*pblk)
> {
> 	return pblk->oob_meta_size * NVM_MAX_VLBA;
> }
> +
> +static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
> +{
> +	return pblk->oob_meta_size >=3D sizeof(struct pblk_sec_meta);
> +}
> #endif /* PBLK_H_ */
> --
> 2.14.5


Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_12F830AE-A916-409D-AB07-505780BC38E7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlv/10MACgkQIX4xUKFR
nnSxWw/9GCu9pWnOOrfzsM+mTYAfAzMVI5E6sBnK3QIKXdP0/c07F3DlaHPtTXKz
EQbuNZYvHxbHiB/r3fGQCdS6V4l03w7nEDiPaXZ8MPecgsdSOU8364RMcZZwzU5D
OS/qQ7ZAejOo+jIscVasfQe6DgJNAn5cifbwC3d0mThJ2mW/7hzHDldi43KwCA0G
MvkTT3E6et9m7/q/sKjmVCZzOiHswCcMvlIu9GfKulyDR/wGMrcSye3gtsvCrphO
nhOTfA1JjcpGokHfXjNzynJe2rk7imT6JUqxW73Aqcxod96Sv9dR/jneBRN39HFE
0zcgOqsf2ge8hakxYTyRA9emlCVFTlAfnrc+P6VWbOmGzD0YNrmHtMiCsj0RCupr
Xk5E5wZtzgXn/06xqL9wZd4SgQopN4WJ8CrmUocFtoZMet9aPTuGf7OhaGkm0rBP
dlZUGQW8SgHHj/N7xvM34U46GxeUabr0qq4l0XMKMjc/0EzH0SpeNv3Ekw0EYQRQ
2XgiWPLKt6ByxXRwvqXpy2+jKHzZ3O2nNWNKKuDBbcqIz2IOimqKzw9KR9LuZmk8
QOMWdFOX9E6ShQkXgltfxxxK1Vb68gIEYzmL0LSWrTwABtjP6pP818fkHQlMsAUX
U9GIJX6gNoGxgiiJoehKtypdWhAKsXpcIxey6JuoGo8sfukA6kI=
=70Hf
-----END PGP SIGNATURE-----

--Apple-Mail=_12F830AE-A916-409D-AB07-505780BC38E7--
