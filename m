Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C748C433E6
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 03:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E642389B
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 03:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbhAUDk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:40:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43022 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392993AbhAUBy7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 20:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611194098; x=1642730098;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Tqlrdl+3BEUkpT4AobgxUw08khMJecfKCl/LzkRE7Ms=;
  b=SKB662b7q3f8ST1XLxzk/AtQdDUWqWZSq5p9aOwofxabgE2t8tXOY6D5
   V8u2Wk84+2KhivuF8WikGCZpwbC0tGIo1hgOppcqs4Ll13n9rplmxRslC
   VdKD8J88hW/JrvgNs/6OSspCZ8xKJH5PxOAk6LXiwXqWQJeh6l/5rsPiI
   82UHB0OTGvzO7c6l4F9FIOdj7JFy9X6JJJlNtroAAR5+2Misl4CHeyYZf
   7WCfTha+lz0u/haUxC1cqBw7TloLCRWN+2EfosXFsMtVwIldSE22z9k0U
   3EoPrV+d5YCwr8o9EjwX8YWBYW9aue/p5gb0thnvvfw2utxO3m7A6Fpk0
   A==;
IronPort-SDR: g1M4uMLJ/4z6ufSOX1djAI9UVBDcydYZcaFXI/tgIRbob+22O9yB8ORSUu0/xmlvD+Vj5rmiNT
 wiK8dTa/z7/YJuw441m8/+wjnEKYk2J2RgqQRGcUYUlMSTY7tNQb+AEqUT9sDZBDPWNhVj59hG
 VYl3ImiygiBC0fl/WBU9HjP6qoY3cnTuZNeaLNwiv+VrMYad6g5haVwt9Vngwu08aTnm9lFXCm
 Xv6Gs/BpAXVqWAXCkfl1pKbSSaEUois4wjHoHcmhksViW+Qn6c0bf7GOWNGgqm1fhA7aA+9Ded
 Njo=
X-IronPort-AV: E=Sophos;i="5.79,362,1602518400"; 
   d="scan'208";a="159127224"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2021 09:53:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNvU5Le7aY7PUoUJU/gluiQ9gKKNn4Rq/OgzJJenUPb6ktZRU+KAln1bPuTESxkSmtr0dnA0sbr0pS4m+zVVUMEqeNSm/yGpbQ2ZlmlBef+vOXCweQBIwh49+t75NYJlSW1153GhOhNghKMAIzTR+UGtXH4JEMgP4Ts2uvj5hsLYGZMZ1Th7DCXc/hcfnQAOc0/8Ha5UrM68Vs3wJ9nBPdMZn4ONQ70zi/1spyolShDTVJnJ8GGg5L9JLxlClgzwEWbKHSYndF+byxP8odoMMvuMppo2LfdwV+3yCg/VRnsB1XEHUGq2zNAVktK4sKX6IWDjvdzYxLQtUnEgOQN1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLUDvgLddBnMynY8dupeP06cNoHzbZnN58w4rA9+l0Q=;
 b=UmCUMRRq9VAdv7RnigzLAIGPnmpdAR62U9OnJplYuS+ULExytPtpq2rc3foTIFlDeP1A+B4SfgxF8syQ04mGn84hN8ueBhkgOsC7aQCUh2ijTZsRD0DqaQ1RdaXAKjAkZZrx2UvVKBow/IMDKFDT0y5plOgVxRILvy+CDe6rEAyMz/8exo5uygwKifyBen1rJJMT+Te5J3ttiOWOL34fM80XDGhgGp4sSqKjljGxwZIw5Ns1bRXISFkyt8hm5E4deRgLQyi9x3wAVr37ml+c5FIzPVHfrSwTJl8wPXUWYRQghEOLbqp3gurSwXnOAjvIg5kJS87togL4XYDsdiULJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLUDvgLddBnMynY8dupeP06cNoHzbZnN58w4rA9+l0Q=;
 b=xT2OfN2+xZroed9i6ypcQsoVmCcYt8UQt7mU2EHy1WCWxxdub1/jCvGdTbAl+zmWFrAWFmVpsnzjke5CE3B2oxoIOJBZ1eUKxSKR34Gw16SgAirkXIwFCipIr8QoLsHy89ctGQWy9OZWypqFgaSI+Wpjg39UUXJe3lLnrMOafdM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6445.namprd04.prod.outlook.com (2603:10b6:208:1a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 01:53:49 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 01:53:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Changheun Lee <nanich.lee@samsung.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC:     "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [PATCH v2] bio: limit bio max size.
Thread-Topic: [PATCH v2] bio: limit bio max size.
Thread-Index: AQHW75Kkwf1I7JNiO0yFOv+8rG0XjA==
Date:   Thu, 21 Jan 2021 01:53:49 +0000
Message-ID: <BL0PR04MB6514CF1FBBF498CB84BCA565E7A10@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <CGME20210121011324epcas1p3a213069e873fd324a7ce3188558f0782@epcas1p3.samsung.com>
 <20210121005803.26052-1-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b0d5:1d20:2559:58ed]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8f3d820-3895-4d0c-4a00-08d8bdaf65a0
x-ms-traffictypediagnostic: MN2PR04MB6445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB644519322C5361F74BD03900E7A10@MN2PR04MB6445.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qp0xO0GAFje9shvtzPRtwBCvqt4yPhnkCNzMSMkBlbjipaGPO3jU19H/RNkwTbQ3cd2gGhzCUjofiYiqECRfn5FJ9pdlelBaUIzVUTxfWVJhRboebR01ZLG/07/XFhL3psLh86SWYQjV9aBCdv4Vi/FMDi9XuOaxlh7XuEsfGFakQMmifGXqTQmR/6yCZvuq8goknBZTWyjq3f32LoDQfnwe9KvPZS5VqpPAfIN5Ew+GuxM4VM170JTEgPxKf96f02+amX7RFDYWKrSgg4I3GrDxB4aKZMpzdUyo8KjSCNZ5wyO2e68cXnz54nOECC97xzx84BxeBcQI6xCC/NLG67OiKZzA48zrE5HOJR/zR6jucFMrlC/MDfYnOaXSj06D3rAHGs0w+yLhKyuS02SbF3V8RDmPq3KnFkH/B+ImWpOqYT0OKlMbGfeR2Lo2WKet
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(186003)(64756008)(66476007)(66946007)(6506007)(86362001)(66446008)(316002)(33656002)(76116006)(66556008)(53546011)(91956017)(8936002)(9686003)(71200400001)(54906003)(921005)(4326008)(7416002)(7696005)(2906002)(478600001)(5660300002)(110136005)(8676002)(55016002)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CGleEWL56S4f/7S7f+EBNKvaVE7MJHdbY/7g41y5IdJ3kTYLiN18cnQ8OJaK?=
 =?us-ascii?Q?mAGdb51EFwZ45HMLyfWxsZeJuCP6bsUFzziWWoJF42ewtpdtLYlZZK+8i51z?=
 =?us-ascii?Q?TlfhPQgronc0j7yZcNTpXux+GMRMy+e1Yw7stbYh3nbl/cU7x7jccFSlPlBP?=
 =?us-ascii?Q?BS7aRTpSk+BuDiKEOBCmfBEbgPQ9extfw10Uhmf2EEGYI0l9qkvapzNnAVXu?=
 =?us-ascii?Q?Em0rf/zpMhiFgAZ+nBw8lp4H61wzdpUUT93IzTSD+NKZSsNGlsenHVILlbWq?=
 =?us-ascii?Q?FTTIBbYznIS4wD44sSF0BLx5BGVTSaGXkVnF7LJEOYZgLr6pSXynmgRbhQpp?=
 =?us-ascii?Q?JdDrDJ/IuuiEkh2VuIQQrNLJxA3xbkFcaaN8gFZ85rfP+3GZtXXCcbSCCtyJ?=
 =?us-ascii?Q?sGaq4o3QrC3ywLUzJhhc78K+A1CpudUtdabLLF1oW3hI8PVtYSqBw+JzLGSI?=
 =?us-ascii?Q?mwXukClCj7yjkRtUi+Jx1D4RQM1hpd00uVEuUq+McDj5DWwbbQ89B/IgWkL4?=
 =?us-ascii?Q?oBHWlDy378nXVZDy5x74hUw+u/nFc+UP44P3sstvwpbKQ6Ne1KGqH7bn1Krt?=
 =?us-ascii?Q?CSWcYajdP7XscK66em9lrQnaQbKBXXKkAFCsWqA2UeRK5WSq7CM6V8VWizmf?=
 =?us-ascii?Q?F0zkalUZQrMgWMDqIfmcwZ80wJpwsNq141HaKfms5t9UVPGxaSmiPTUfeqln?=
 =?us-ascii?Q?E89zWwM/KCRYdnnSGXylF+tC1YwYbV496VQYID5NkGoSTOEzodn2sC4LgEGG?=
 =?us-ascii?Q?So8TeGAyuiSG0c8AFq8I+4krWOC/l1oV94UXGn8AplTJiOrmsb8XSnYl6nRZ?=
 =?us-ascii?Q?qdBUfcWE2lirD6C1zs6472wpEfPYwgiSKCsQ3Vf50gsvwkjgnA/WNznPasaV?=
 =?us-ascii?Q?0vwX53AQf2UgpnFRzu0sdJpyL1e9p8glWsG6xYgY5rb0JA4tIlrzgqA9zIZC?=
 =?us-ascii?Q?3a7jfU0RxKQ8lK5YnDpKtcet4MX+/ZoFBHUPcEicW6vIqVhbguEjZHezeYDK?=
 =?us-ascii?Q?hc0b2y1Bf61zFIxCYqp7n+Y0vPZIexwh9xPc+Fyw2f5fImd9EHWmpjhp6Vu2?=
 =?us-ascii?Q?5mPDSbdowfvSCswGaaystrSs1F8XOdfBFcHopzeK2yhEcdZziURPML1vUnwq?=
 =?us-ascii?Q?GYW25nrt6qizl9obk5HTMMes8fh+3AOfaA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f3d820-3895-4d0c-4a00-08d8bdaf65a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 01:53:49.3580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIfksaFJhzepd0fKvBLE3sizHmJ430Ybftx0e50c911P3PfbuqMDlelrq3TEhjeBP8hXvFjxtEKN+YXeR60EYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6445
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/21 10:13, Changheun Lee wrote:=0A=
=0A=
Please drop the "." at the end of the patch title.=0A=
=0A=
> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
> but sometimes it would lead to inefficient behaviors.=0A=
> in case of large chunk direct I/O, - 32MB chunk read in user space -=0A=
> all pages for 32MB would be merged to a bio structure if memory address i=
s=0A=
> continued phsycally. it makes some delay to submit until merge complete.=
=0A=
=0A=
s/if memory address is continued phsycally/if the pages physical addresses =
are=0A=
contiguous/=0A=
=0A=
> bio max size should be limited as a proper size.=0A=
=0A=
s/as/to/=0A=
=0A=
> =0A=
> When 32MB chunk read with direct I/O option is coming from userspace,=0A=
> kernel behavior is below now. it's timeline.=0A=
> =0A=
>  | bio merge for 32MB. total 8,192 pages are merged.=0A=
>  | total elapsed time is over 2ms.=0A=
>  |------------------ ... ----------------------->|=0A=
>                                                  | 8,192 pages merged a b=
io.=0A=
>                                                  | at this time, first bi=
o submit is done.=0A=
>                                                  | 1 bio is split to 32 r=
ead request and issue.=0A=
>                                                  |--------------->=0A=
>                                                   |--------------->=0A=
>                                                    |--------------->=0A=
>                                                               ......=0A=
>                                                                    |-----=
---------->=0A=
>                                                                     |----=
----------->|=0A=
>                           total 19ms elapsed to complete 32MB read done f=
rom device. |=0A=
> =0A=
> If bio max size is limited with 1MB, behavior is changed below.=0A=
> =0A=
>  | bio merge for 1MB. 256 pages are merged for each bio.=0A=
>  | total 32 bio will be made.=0A=
>  | total elapsed time is over 2ms. it's same.=0A=
>  | but, first bio submit timing is fast. about 100us.=0A=
>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|=0A=
>       | 256 pages merged a bio.=0A=
>       | at this time, first bio submit is done.=0A=
>       | and 1 read request is issued for 1 bio.=0A=
>       |--------------->=0A=
>            |--------------->=0A=
>                 |--------------->=0A=
>                                       ......=0A=
>                                                  |--------------->=0A=
>                                                   |--------------->|=0A=
>         total 17ms elapsed to complete 32MB read done from device. |=0A=
> =0A=
> As a result, read request issue timing is faster if bio max size is limit=
ed.=0A=
> Current kernel behavior with multipage bvec, super large bio can be creat=
ed.=0A=
> And it lead to delay first I/O request issue.=0A=
> =0A=
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
> =0A=
> ---=0A=
>  block/bio.c               | 17 ++++++++++++++++-=0A=
>  include/linux/bio.h       | 13 +++----------=0A=
>  include/linux/blk_types.h |  1 +=0A=
>  3 files changed, 20 insertions(+), 11 deletions(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 1f2cc1fbe283..027503c2e2e7 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -284,9 +284,24 @@ void bio_init(struct bio *bio, struct bio_vec *table=
,=0A=
>  =0A=
>  	bio->bi_io_vec =3D table;=0A=
>  	bio->bi_max_vecs =3D max_vecs;=0A=
> +	bio->bi_max_size =3D UINT_MAX;=0A=
>  }=0A=
>  EXPORT_SYMBOL(bio_init);=0A=
>  =0A=
> +void bio_set_dev(struct bio *bio, struct block_device *bdev)=0A=
> +{=0A=
> +	if (bio->bi_disk !=3D bdev->bd_disk)=0A=
> +		bio_clear_flag(bio, BIO_THROTTLED);=0A=
> +=0A=
> +	bio->bi_disk =3D bdev->bd_disk;=0A=
> +	bio->bi_partno =3D bdev->bd_partno;=0A=
> +	bio->bi_max_size =3D blk_queue_get_max_sectors(bio->bi_disk->queue,=0A=
> +			bio_op(bio)) << SECTOR_SHIFT;=0A=
> +=0A=
> +	bio_associate_blkg(bio);=0A=
> +}=0A=
> +EXPORT_SYMBOL(bio_set_dev);=0A=
> +=0A=
>  /**=0A=
>   * bio_reset - reinitialize a bio=0A=
>   * @bio:	bio to reset=0A=
> @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct pag=
e *page,=0A=
>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>  =0A=
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
> +			if (bio->bi_iter.bi_size > bio->bi_max_size - len)=0A=
>  				*same_page =3D false;=0A=
>  				return false;=0A=
>  			}=0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index 1edda614f7ce..b9803e80c259 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned=
 len)=0A=
>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>  		return true;=0A=
>  =0A=
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
> +	if (bio->bi_iter.bi_size > bio->bi_max_size - len)=0A=
>  		return true;=0A=
>  =0A=
>  	return false;=0A=
> @@ -482,20 +482,13 @@ extern struct bio_vec *bvec_alloc(gfp_t, int, unsig=
ned long *, mempool_t *);=0A=
>  extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);=0A=
>  extern unsigned int bvec_nr_vecs(unsigned short idx);=0A=
>  extern const char *bio_devname(struct bio *bio, char *buffer);=0A=
> -=0A=
> -#define bio_set_dev(bio, bdev) 			\=0A=
> -do {						\=0A=
> -	if ((bio)->bi_disk !=3D (bdev)->bd_disk)	\=0A=
> -		bio_clear_flag(bio, BIO_THROTTLED);\=0A=
> -	(bio)->bi_disk =3D (bdev)->bd_disk;	\=0A=
> -	(bio)->bi_partno =3D (bdev)->bd_partno;	\=0A=
> -	bio_associate_blkg(bio);		\=0A=
> -} while (0)=0A=
> +extern void bio_set_dev(struct bio *bio, struct block_device *bdev);=0A=
>  =0A=
>  #define bio_copy_dev(dst, src)			\=0A=
>  do {						\=0A=
>  	(dst)->bi_disk =3D (src)->bi_disk;	\=0A=
>  	(dst)->bi_partno =3D (src)->bi_partno;	\=0A=
> +	(dst)->bi_max_size =3D (src)->bi_max_size;\=0A=
>  	bio_clone_blkg_association(dst, src);	\=0A=
>  } while (0)=0A=
>  =0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index 866f74261b3b..e5dd5b7d8fc1 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -270,6 +270,7 @@ struct bio {=0A=
>  	 */=0A=
>  =0A=
>  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */=0A=
> +	unsigned int		bi_max_size;	/* max data size we can hold */=0A=
>  =0A=
>  	atomic_t		__bi_cnt;	/* pin count */=0A=
=0A=
This modification comes at the cost of increasing the bio structure size to=
=0A=
simply tell the block layer "do not delay BIO splitting"...=0A=
=0A=
I think there is a much simpler approach. What about:=0A=
=0A=
1) Use a request queue flag to indicate "limit BIO size"=0A=
2) modify __bio_try_merge_page() to look at that flag to disallow page merg=
ing=0A=
if the bio size exceeds blk_queue_get_max_sectors(), or more ideally a vers=
ion=0A=
of it that takes into account the bio start sector.=0A=
3) Set the "limit bio size" queue flag in the driver of the device that ben=
efit=0A=
from this change. Eventually, that could also be controlled through sysfs.=
=0A=
=0A=
With such change, you will get the same result without having to increase t=
he=0A=
BIO structure size.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
