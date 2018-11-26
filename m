Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6A0C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 13:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F7E20862
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 13:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="UWHPmHpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F7E20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeK0AgA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:36:00 -0500
Received: from mail-eopbgr690044.outbound.protection.outlook.com ([40.107.69.44]:56030
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbeK0AgA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 19:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7HKIZZl3sovvZQ4Rx/D3SawBFsRuNrHE06dEd0+tJQ=;
 b=UWHPmHpnTI62I82KY/iWaShLlX0B4oeQm8ypwP83HjF1YWCl/CJk2+Jr3XkxHkYTXwYUqsdJppDt2Di0PHvkKWJ5eml5KF55uLGz/n0q4juX6QSnO+g2zwdKj+9SM+54eXyWJQto/bZoiGenwXpaW6lnzPPPU/G6A9RNfqNd+PM=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB5115.namprd06.prod.outlook.com (20.176.123.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Mon, 26 Nov 2018 13:41:46 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7%4]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 13:41:44 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v3 5/5] lightnvm: pblk: Support for packed metadata
Thread-Topic: [PATCH v3 5/5] lightnvm: pblk: Support for packed metadata
Thread-Index: AQHUg0RY4TzZ4CzqNkqURwPV3/hKHqViFP+A
Date:   Mon, 26 Nov 2018 13:41:44 +0000
Message-ID: <E7275328-5689-4B59-858F-83008B6B21DE@cnexlabs.com>
References: <20181123154538.59748-1-igor.j.konopko@intel.com>
 <20181123154538.59748-6-igor.j.konopko@intel.com>
In-Reply-To: <20181123154538.59748-6-igor.j.konopko@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB5115;6:gbJhwR4/Wha7+23mAqMR9BMafNgBQA7BM62ZhQ3Nk3gCAmvTs1Ud/qwLA4TWcwX2bC+crxJBbpDKcKSNkT2csOGMPLPDrDm9y+YDw0O2V+VaPbLFIIhfdRi7pp5DG61ZdOrvMr8GrQgD19H+xryO50awwpcG1t/F5hRHjGuwCcGoZaquFTqll9+mMCgRU7BZtqxc9X4bHTXAvXbgTuvQaBAK66N0n992VpR6mpyn0XfwAFOgLPoC6ZdNKYnMlbOlvjn++KEMMSARIz30nqxWc3xERIarsckSZgDxPp505TSSrVit8C7IXoh1GugepK2CeBf/NfzOEEhBbbFEtDQGpsma3KkUCrSKXWN9+1kEcXKg/IRzrYXyeMAnU+HfYu5Z1z1PeJPXatcxCGhZhYFjeD9HetmSFwdkQf2kZBh7QiT+SyCheo1XcmS+Zsa3BHEnpM63gzGntIUN7Gw4ByqU0g==;5:EP1ZQ0jAUztXziJCLCSLGzA6+G3fl206e62hy6w95ibH0BtEHPq1geJWHxWA3Kd8W7P5chJoZNs4BCINDPFjdeERPOtn8qDMrotEgp1a34Dp3obFVuZGreJc1eN77mii7kkRRCV8UAll+N3lD1nZo6XcGqcLwyo07UTJPyvv+rY=;7:M8pJHXA4GgCH5gvUlepKecaLI7/YxHLqdBE4ebeoQLhUEKQG3H7ncBVp0If0IUcJuGz5Vq5pnc/fie+o79LGymlHQAhFX8MjCbfIV9PuTBqUEGdlI3O4XjiFBw2+flYjXYKYEmjrH+L6KHyISNIaqg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(396003)(39830400003)(346002)(199004)(189003)(14454004)(106356001)(82746002)(229853002)(478600001)(105586002)(25786009)(6436002)(68736007)(6486002)(6916009)(14444005)(256004)(76176011)(305945005)(5660300001)(102836004)(6506007)(26005)(99286004)(186003)(36756003)(71190400001)(71200400001)(83716004)(99936001)(86362001)(33656002)(446003)(2616005)(476003)(11346002)(54906003)(4326008)(6246003)(97736004)(107886003)(7736002)(486006)(81166006)(6116002)(3846002)(8676002)(81156014)(8936002)(2906002)(316002)(66066001)(6512007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB5115;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: ed40b2f4-8855-461f-138a-08d653a4e7b3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM6PR06MB5115;
x-ms-traffictypediagnostic: DM6PR06MB5115:
x-microsoft-antispam-prvs: <DM6PR06MB5115E5A4DF8E440EE839C5F8BAD70@DM6PR06MB5115.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231443)(944501410)(4983020)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB5115;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB5115;
x-forefront-prvs: 086831DFB4
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: scBo1tBAAiEzgXcoXxOGHbUGK2JGulxfW5DbPpDCJH3Fx7o5TIG12pGUfk6egUkDSm5e711th+AOvhKVCeRIqymOI/8Bq3UjizDiV7YyNXQSFeQQ5x1PZ0+y0fwWV7z48q6CxgnaCuGcGKYdTpHBqCKhO9sfhiKf0oHwsn4XhrGGDT0FCr+vxrsdblK7KhU0X1z+YlwXjdrvhZCu/iqJvzJFwGqspExyJ3ZH8Xz/4IcxhIOic3Wgy8yjvakHuqfdCroSr0dv9ChrksIkgwu4EMKP6NtNoIZUXeSpDoGXjIB3bIxdC8xDksY8H+ehMFCzOVlQEqZlR/6vtddlR7jHzAi4US0VUJIwJ8k6HPt2LWk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D534E214-5241-416D-A506-0E73F9B3FE72";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed40b2f4-8855-461f-138a-08d653a4e7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 13:41:44.5507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5115
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Apple-Mail=_D534E214-5241-416D-A506-0E73F9B3FE72
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 23 Nov 2018, at 16.45, Igor Konopko <igor.j.konopko@intel.com> =
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
> After this set of changes, drives with OOB >0 and <16b are still
> not supported.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     | 53 =
+++++++++++++++++++++++++++++++++++++---
> drivers/lightnvm/pblk-init.c     | 37 +++++++++++++++++++++++++---
> drivers/lightnvm/pblk-rb.c       |  3 +++
> drivers/lightnvm/pblk-read.c     |  6 +++++
> drivers/lightnvm/pblk-recovery.c |  5 ++--
> drivers/lightnvm/pblk-sysfs.c    |  7 ++++++
> drivers/lightnvm/pblk-write.c    | 14 ++++++++---
> drivers/lightnvm/pblk.h          | 10 +++++++-
> 8 files changed, 121 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 2ebd3b079a96..615817bf97e3 100644
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
> @@ -2161,3 +2166,43 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, =
struct ppa_addr *ppas,
> 	}
> 	spin_unlock(&pblk->trans_lock);
> }
> +
> +void pblk_set_packed_meta(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	void *meta_list =3D rqd->meta_list;
> +	void *page;
> +	int i =3D 0;
> +
> +	if (pblk_is_oob_meta_supported(pblk))
> +		return;
> +
> +	/* We need to zero out metadata corresponding to packed meta =
page */
> +	pblk_get_meta(pblk, meta_list, rqd->nr_ppas - 1)->lba =3D
> +						cpu_to_le64(ADDR_EMPTY);
> +
> +	page =3D page_to_virt(rqd->bio->bi_io_vec[rqd->bio->bi_vcnt - =
1].bv_page);
> +	/* We need to fill last page of request (packed metadata)
> +	 * with data from oob meta buffer.
> +	 */
> +	for (; i < rqd->nr_ppas; i++)
> +		memcpy(page + (i * sizeof(struct pblk_sec_meta)),
> +			pblk_get_meta(pblk, meta_list, i),
> +			sizeof(struct pblk_sec_meta));

You are doing an unnecessary memory copy here, using the metadata buffer
as a bouncing buffer on the packed metadata path. Why not do this
directly on pblk_map_page_data()? At this point you have already created
the bio and have all the necessary structures in place and can simply
write to the last page instead of writing to the metadata buffer.



--Apple-Mail=_D534E214-5241-416D-A506-0E73F9B3FE72
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlv7+BcACgkQIX4xUKFR
nnRkrRAAnvl1AYtfdwFrpaDrLuX68NKr4mCivxR+0H5+JKXNLfLOpKYD3XG9M8ie
vJEqTE1pHBdPW2jZNNQ775Vwh35wZJC4qcx+HsKISqxr8O3SNgai1UXTbkyj8sqp
c6dhZocTEiEeIQGqib+H0BIZ1fIfMajEG0u9sWxoueFsP8FQX27PQzcSO6wizmH/
w0ZRuM6d2i4mC/nKxic+XsFPm9Q1iUl7SX/cu21L5Lk2Kh89yO+HujqqMCyCFA56
i9nPw01R7R82a44W7Pcx/I+MEr2mIJvWINZGK1K71+Q+K5WSYOpup8dVg5iF9uNS
vJkbNyJOvd6EdvyDlxSJ8FXxA80QoYyf26xdzBAROHBOr8pt/7PGefQATEuSKKVh
uEx2xrxm6e+37t0pdViMQ5DUxPSiVe+6n1Iqt2gdlFjlW+L4/QNXxxdO+dS/DHJp
NxiUtyS2JjheYLgq3Dj/U28UVRUofNlLP7iuHliBcx/NFt9fNSRvUWC/qZ5L9jMn
YnDMuk/x/I0UX8IOuEWuf2M0PqqYEFsRL2C1tFm0SjjIaUNgrkI2ujwxlVzj5+Pl
yDUg2CZ53RyYeVD2/XLR5E2mtX7k0pdIQTrCW7BhsZMDBacu0Vbg4CM2sP6vIrSH
ojkmiruSzRG+KPNWm7IgL1VLGIcVa4AvK70c7N6VxsJN3MxxkdE=
=XprC
-----END PGP SIGNATURE-----

--Apple-Mail=_D534E214-5241-416D-A506-0E73F9B3FE72--
