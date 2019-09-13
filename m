Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EBBC49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355BB206A5
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="IaOgUfyR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p5qXi7Mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404215AbfIMW5o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:57:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4066 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404136AbfIMW5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568416083; x=1599952083;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+w0PGZGpy+NNZMIqi5s87OVN+cZ6CV7mjdVMNiiLwyk=;
  b=IaOgUfyRM/ffU5hA5MlUZEpzVmub5NRUwdUVAQeB3meNOd7L+k4Z++p5
   TaMY0sJDikGIkvL+N3TWbAyhLz8dEItL6uqsF9f9NTZ79nv2Q7s/qFzs4
   8GvTdpvtmraLdSwJWNKLmEjV3ZHAV3m9uZoc6NM0Xqx/sTCSqx5qZPVw/
   tl4giOavIFqRuZJKff4SxeBJqDBVZQsphyfWdZeQ9lU0oRIXtAZDBslxO
   yulkKPRU59N2rLWphiCj94ydDD/TIHUWLUjtmIMdit5JHGiVaPmTYcY56
   ep1CypOzgRAt9OfuMrZ3efmuxQlADcY9znyRud1wmiNXp4UoMMCThUHh4
   g==;
IronPort-SDR: lr9inESkcP0GRgdSd6hNz27B6e1m2YTj0aqvuIoBeJb+SKWiR1nYi7q9ZLcj2u+SqVKJTYypea
 feC3Zypg1IDzQAzeZhdAhqrCltliAoys4J2oLcg0P0LF7rub2LSoyw8XEXsvUxvLqqvFe4F+Ex
 aPk3/g0kW+5aRBLqfq4x7UYnTSLvNsW3X0IN4KHQY1SO4iJNPV77Kc2EssZLQ1iFI5bXrlOm52
 e+9dnHDbqxKZZishnQk7G3Em4bA3ZfVEMU2HmK7/he40/cxlSB/5WqKqKupZ9TblSs/450P4/R
 FqA=
X-IronPort-AV: E=Sophos;i="5.64,501,1559491200"; 
   d="scan'208";a="218953551"
Received: from mail-by2nam01lp2059.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.59])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 07:08:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIARzopiEBMdd1TEGyCR5106Wtx4FuPs+/fuvw1G/cFJR6qWOreP+VtuCf1jyCItCDuoHXHxyy06i1dRtnKhYa1wrjFZGH2yMCY5ewgzUvrtFhxOMM1wMi1AXUqXjxXB2wuU1If/OQr45SRZDYbZv+txgLcviqddoeb6lKQ8P9+LjlHHs09ydVy4eANCE/WITSuvjAx1sIK3bylS3YKz0KaNF44AnRYlKSLCVPEADKZVOZnyHVpq3OU0jVIUfybNvHni7MgP0jZoDxF5Yyuuh9Q4adpRBa4pgttgaICtS5wzb+PeIm7aA8Vaf+Og6rviwqijh5VVp2r8L9DxQln8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80x/i3upd7Ct8y/7ILcyZRCuue6M3a7N4FGUBdRK/Qc=;
 b=OViLPpvRREoCzlxrXumbUVLhI1ANGCOaA7p998qbjiYL6yZVDH9ivnVoRt/vpJJ0ux/5m56WTSAgJrxI9ejTvCIzQPo4BPvGX7qv+msvl6DL9a8VKlWY9GnagOOkQqAlvXlUYC5VENfsTQMlO7m+WAkZF6u4LAmqW6AVcs8/Z4UE9JZS7rM7SoCimFR1CLcE34uDqehyuz73WtaEBP9FOghqJeCWI1cHJZhdKga2CsjoVPAri+io/UjGDfBDrQQkMYywJmxFvxoyYOWGYXtWhEI6SEBb7rXwnssF6aB9CTwTyz62Kaq4aqU9vnhjclF7zZhpl1MC17MvhwH7av203Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80x/i3upd7Ct8y/7ILcyZRCuue6M3a7N4FGUBdRK/Qc=;
 b=p5qXi7MgCOIxNnPZyYS5OTwidkR1+LTEPc8AJm2J1OHMgrgOWatKxOWHzOWT7fUal0kXCMpdesul1C3SgTBJZu0iY6F8dP62yX8PkWI2WDLsVesM6Qoscwk4V3LND3fCusCQCLB6oaTOzxkPQR8TEJWnUkhN+4zDv82aLE/5XBs=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4245.namprd04.prod.outlook.com (20.176.250.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 13 Sep 2019 22:57:42 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 22:57:42 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 1/5] block: Declare several function pointer arguments
 'const'
Thread-Topic: [PATCH v2 1/5] block: Declare several function pointer arguments
 'const'
Thread-Index: AQHVSLuYg1EddwxuFUK3uRG+Pn1AQg==
Date:   Fri, 13 Sep 2019 22:57:42 +0000
Message-ID: <BYAPR04MB5749D3139D6B7FFB5179952486B30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190801225044.143478-1-bvanassche@acm.org>
 <20190801225044.143478-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfc9396c-b0a9-4737-c986-08d7389dc893
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4245;
x-ms-traffictypediagnostic: BYAPR04MB4245:
x-microsoft-antispam-prvs: <BYAPR04MB42450CC222DA9ABEB986435586B30@BYAPR04MB4245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(6116002)(71190400001)(76176011)(478600001)(71200400001)(316002)(14454004)(52536014)(110136005)(3846002)(2906002)(14444005)(7696005)(256004)(9686003)(6246003)(74316002)(102836004)(26005)(8676002)(53936002)(66066001)(7736002)(229853002)(54906003)(5660300002)(55016002)(99286004)(305945005)(186003)(8936002)(81156014)(66946007)(81166006)(53546011)(76116006)(6506007)(86362001)(66476007)(476003)(66556008)(64756008)(66446008)(446003)(4326008)(6436002)(33656002)(25786009)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4245;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l+ZNNwM+E5Y1TTxTmt20Ll91Sahh4O47zoKgFc5/z/LGu0RcA1lYmbJVyrHis0jRFdDJ+761zn9KHSnnjbMbLdRgq7LS93PWE3pBl9ayV4RPAkrE6dYmQ06jpSU8TAK+P5akFjq6B5zjNyEMNGOcfHqaBNLF+AAjVGuCoXSXtJeZ6NG+VtR2sAr93BvRsKCeb+D5ugegcxMWnHvHmDomlsp48jHoz3P8FxYxKylJiw8KDBJBjsp6DYbPF/rojBb/CtYj2VdiRTyUTeckBVjBCgl2O1MOjc2yBB+lB/RT1kXcGppj64hrhLr4wLMciYb1G8eSeGLvJDLNxN88kjtbb3dCOyLYButWSDUZ4ot3akHXODPe/aVH3er1F6CsXzKoKXg6HEFQgxNtbSQLIr426ex0bEhKg0qYj4l/RY/auY0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc9396c-b0a9-4737-c986-08d7389dc893
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 22:57:42.1394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kQFXdKZJPi1ZWn2ao3Xjt9HGTa3dov5x0ilh4XVSGJGSdzIza999BriisHJJvfoHsSxu3r/8V1DZ/6UcrsIHmwBi7fPeMeRWP3N0yTEstw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4245
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 08/01/2019 03:51 PM, Bart Van Assche wrote:=0A=
> Make it clear to the compiler and also to humans that the functions=0A=
> that query request queue properties do not modify any member of the=0A=
> request_queue data structure.=0A=
>=0A=
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>=0A=
> Cc: Christoph Hellwig <hch@infradead.org>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Cc: Hannes Reinecke <hare@suse.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   block/blk-merge.c      |  7 ++++---=0A=
>   include/linux/blkdev.h | 32 ++++++++++++++++----------------=0A=
>   2 files changed, 20 insertions(+), 19 deletions(-)=0A=
>=0A=
> diff --git a/block/blk-merge.c b/block/blk-merge.c=0A=
> index 57f7990b342d..8344d94f13e0 100644=0A=
> --- a/block/blk-merge.c=0A=
> +++ b/block/blk-merge.c=0A=
> @@ -144,7 +144,7 @@ static inline unsigned get_max_io_size(struct request=
_queue *q,=0A=
>   	return sectors;=0A=
>   }=0A=
>=0A=
> -static unsigned get_max_segment_size(struct request_queue *q,=0A=
> +static unsigned get_max_segment_size(const struct request_queue *q,=0A=
>   				     unsigned offset)=0A=
>   {=0A=
>   	unsigned long mask =3D queue_segment_boundary(q);=0A=
> @@ -161,8 +161,9 @@ static unsigned get_max_segment_size(struct request_q=
ueue *q,=0A=
>    * Split the bvec @bv into segments, and update all kinds of=0A=
>    * variables.=0A=
>    */=0A=
> -static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,=
=0A=
> -		unsigned *nsegs, unsigned *sectors, unsigned max_segs)=0A=
> +static bool bvec_split_segs(const struct request_queue *q,=0A=
> +			    const struct bio_vec *bv, unsigned *nsegs,=0A=
> +			    unsigned *sectors, unsigned max_segs)=0A=
>   {=0A=
>   	unsigned len =3D bv->bv_len;=0A=
>   	unsigned total_len =3D 0;=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 1ef375dafb1c..96a29a72fd4a 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -1232,42 +1232,42 @@ enum blk_default_limits {=0A=
>   	BLK_SEG_BOUNDARY_MASK	=3D 0xFFFFFFFFUL,=0A=
>   };=0A=
>=0A=
> -static inline unsigned long queue_segment_boundary(struct request_queue =
*q)=0A=
> +static inline unsigned long queue_segment_boundary(const struct request_=
queue *q)=0A=
>   {=0A=
>   	return q->limits.seg_boundary_mask;=0A=
>   }=0A=
>=0A=
> -static inline unsigned long queue_virt_boundary(struct request_queue *q)=
=0A=
> +static inline unsigned long queue_virt_boundary(const struct request_que=
ue *q)=0A=
>   {=0A=
>   	return q->limits.virt_boundary_mask;=0A=
>   }=0A=
>=0A=
> -static inline unsigned int queue_max_sectors(struct request_queue *q)=0A=
> +static inline unsigned int queue_max_sectors(const struct request_queue =
*q)=0A=
>   {=0A=
>   	return q->limits.max_sectors;=0A=
>   }=0A=
>=0A=
> -static inline unsigned int queue_max_hw_sectors(struct request_queue *q)=
=0A=
> +static inline unsigned int queue_max_hw_sectors(const struct request_que=
ue *q)=0A=
>   {=0A=
>   	return q->limits.max_hw_sectors;=0A=
>   }=0A=
>=0A=
> -static inline unsigned short queue_max_segments(struct request_queue *q)=
=0A=
> +static inline unsigned short queue_max_segments(const struct request_que=
ue *q)=0A=
>   {=0A=
>   	return q->limits.max_segments;=0A=
>   }=0A=
>=0A=
> -static inline unsigned short queue_max_discard_segments(struct request_q=
ueue *q)=0A=
> +static inline unsigned short queue_max_discard_segments(const struct req=
uest_queue *q)=0A=
>   {=0A=
>   	return q->limits.max_discard_segments;=0A=
>   }=0A=
>=0A=
> -static inline unsigned int queue_max_segment_size(struct request_queue *=
q)=0A=
> +static inline unsigned int queue_max_segment_size(const struct request_q=
ueue *q)=0A=
>   {=0A=
>   	return q->limits.max_segment_size;=0A=
>   }=0A=
>=0A=
> -static inline unsigned short queue_logical_block_size(struct request_que=
ue *q)=0A=
> +static inline unsigned short queue_logical_block_size(const struct reque=
st_queue *q)=0A=
>   {=0A=
>   	int retval =3D 512;=0A=
>=0A=
> @@ -1282,7 +1282,7 @@ static inline unsigned short bdev_logical_block_siz=
e(struct block_device *bdev)=0A=
>   	return queue_logical_block_size(bdev_get_queue(bdev));=0A=
>   }=0A=
>=0A=
> -static inline unsigned int queue_physical_block_size(struct request_queu=
e *q)=0A=
> +static inline unsigned int queue_physical_block_size(const struct reques=
t_queue *q)=0A=
>   {=0A=
>   	return q->limits.physical_block_size;=0A=
>   }=0A=
> @@ -1292,7 +1292,7 @@ static inline unsigned int bdev_physical_block_size=
(struct block_device *bdev)=0A=
>   	return queue_physical_block_size(bdev_get_queue(bdev));=0A=
>   }=0A=
>=0A=
> -static inline unsigned int queue_io_min(struct request_queue *q)=0A=
> +static inline unsigned int queue_io_min(const struct request_queue *q)=
=0A=
>   {=0A=
>   	return q->limits.io_min;=0A=
>   }=0A=
> @@ -1302,7 +1302,7 @@ static inline int bdev_io_min(struct block_device *=
bdev)=0A=
>   	return queue_io_min(bdev_get_queue(bdev));=0A=
>   }=0A=
>=0A=
> -static inline unsigned int queue_io_opt(struct request_queue *q)=0A=
> +static inline unsigned int queue_io_opt(const struct request_queue *q)=
=0A=
>   {=0A=
>   	return q->limits.io_opt;=0A=
>   }=0A=
> @@ -1312,7 +1312,7 @@ static inline int bdev_io_opt(struct block_device *=
bdev)=0A=
>   	return queue_io_opt(bdev_get_queue(bdev));=0A=
>   }=0A=
>=0A=
> -static inline int queue_alignment_offset(struct request_queue *q)=0A=
> +static inline int queue_alignment_offset(const struct request_queue *q)=
=0A=
>   {=0A=
>   	if (q->limits.misaligned)=0A=
>   		return -1;=0A=
> @@ -1342,7 +1342,7 @@ static inline int bdev_alignment_offset(struct bloc=
k_device *bdev)=0A=
>   	return q->limits.alignment_offset;=0A=
>   }=0A=
>=0A=
> -static inline int queue_discard_alignment(struct request_queue *q)=0A=
> +static inline int queue_discard_alignment(const struct request_queue *q)=
=0A=
>   {=0A=
>   	if (q->limits.discard_misaligned)=0A=
>   		return -1;=0A=
> @@ -1432,7 +1432,7 @@ static inline sector_t bdev_zone_sectors(struct blo=
ck_device *bdev)=0A=
>   	return 0;=0A=
>   }=0A=
>=0A=
> -static inline int queue_dma_alignment(struct request_queue *q)=0A=
> +static inline int queue_dma_alignment(const struct request_queue *q)=0A=
>   {=0A=
>   	return q ? q->dma_alignment : 511;=0A=
>   }=0A=
> @@ -1543,7 +1543,7 @@ static inline void blk_queue_max_integrity_segments=
(struct request_queue *q,=0A=
>   }=0A=
>=0A=
>   static inline unsigned short=0A=
> -queue_max_integrity_segments(struct request_queue *q)=0A=
> +queue_max_integrity_segments(const struct request_queue *q)=0A=
>   {=0A=
>   	return q->limits.max_integrity_segments;=0A=
>   }=0A=
> @@ -1626,7 +1626,7 @@ static inline void blk_queue_max_integrity_segments=
(struct request_queue *q,=0A=
>   						    unsigned int segs)=0A=
>   {=0A=
>   }=0A=
> -static inline unsigned short queue_max_integrity_segments(struct request=
_queue *q)=0A=
> +static inline unsigned short queue_max_integrity_segments(const struct r=
equest_queue *q)=0A=
>   {=0A=
>   	return 0;=0A=
>   }=0A=
>=0A=
=0A=
