Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE44C4361B
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 23:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53FFC207C9
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 23:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395543AbgLMXmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 18:42:18 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23053 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395476AbgLMXmS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 18:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607902937; x=1639438937;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zGCbjUo/rtqC2B7+DaoFPb7AFG+OQPydMKy7ZR8aTaI=;
  b=nkV1JqameIT+agchy3cUOf9UMtE+YMBNaBAjikvrM5cp0c75QUXV9Q6m
   U2RBmqCCgvUk/WZXX9Qs3Qd3gl/GPijCfzwD7h4bvqwUXWFiHYdhohwRY
   xANyQ53dA04M+S4X0XGUiYjgTquoyIC8gURbkb7Ov0bd+fjaN8cSQ9a/p
   vFk08TwLCpLFCUM7NYb83N/lRilwn9wFJ2lVi2pQ35/fkqbzz1Gx3Qqq4
   eyaGQaikPew7DxduTteqRMUfXVX6jVC2OM4p9BtC2jG9u/O+82VEgU2lg
   iJmkhrV1nMxCow5vJR+x+rxxWjH8xv7Udoa3nh0KrzMWelEkwGvDt/S2D
   g==;
IronPort-SDR: m6ArrXcApdhc2XoRbWaXNZXxST5GioSpGc8fX/AzAxfA3CRn5a/YomE7wEnZZbzUEN+vI5TyAf
 uUSoT1Mf7Gv+8nBC6sY+aPPHoOOr1dy9SQPHQROeGUCmyuN4b7HF2EMJm1r39274Ju5Pm0iB7H
 MbnY1qUXpUKcy94HF5t7U7cUI9Szk9NIJlygrIUlLDR0RRBRrXTVIi756Nq+dAxDKr/KPLyBFB
 T732YZiMtc0Nkp/SXrY45e197GNK8dyHHFurHJuvUjxV8qNtF+8jO1lxJrGBExhlcLGAfCf/uL
 4NY=
X-IronPort-AV: E=Sophos;i="5.78,417,1599494400"; 
   d="scan'208";a="155091429"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2020 07:41:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E121o/ygONw1MznySWlJXFAtkZagvksziXlr0J7ID3INGP/nSD4WZphYf0sI69LSoWP70QumkIUDtRR5uqvux4nV1tC7jOYOSHhWuJzG8s4BLfPJ5reD99R8VMu2AHc92s3Lm5J81vweHtDV7J1QBV2r4ZXXx8W+Ojtt9LVgx12QCyCv3zWJPbWYhweWcRRhfHXoLMS6OprTvT4gRz9wfkgksA0xQt4he8DgpvUk+iswcOPbQeZpo/mSZGcNxT7e1vFp4ZjDfTIN2SgbtHY//P5hEvvPPDFrjjH8Swkszf9QgmftsJR8P+0UJn6b94NXgDb52qKDEBXpxf2i15L4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n8XjT23O2w62Om6APwnKDdeuYIPauKQoRLnUEraUXY=;
 b=N5zhBGgjtAkimR55yeimPATQQy+3pVIVD9Qdm+5G9/gKqZH64UyinA1UOy3G+PtKGVyMzukSSLtqG/7yX1yltaeFa7WJ8Gryj0H1s4LLJWf/IVLeJj4Jiru2T36hb82Y7abhcZ1zohBYN1vvRnxGW3h2bP2xdQRfg/zZrk0A8FKNqHBLIs6IgBdZQXOn9q5Fw9Myhgwgf7Na0oWULFqWpBbf+QWBTjpBgZUoXlF2ksys38JveraoRAZSw/Uv+kUQ3W4raWytnkX+Oy46QXJeWjA2M/8cCdZ/VeuGy4n2522bhvXerfVIDGLM1Rb9LRlTRx3rjv44hh7lOgl1QtB6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n8XjT23O2w62Om6APwnKDdeuYIPauKQoRLnUEraUXY=;
 b=gaZABZspjgMX9Uzw0IpNZku9CKMRq69bXcCZTAwbBFtKDb2E/nAL+cntO4mUWzP8o5yj8ClZUg8qQZK5NGYuqi5VQXRYliTDBf749VZCG0Ca4SfiXvZTrO80KalYQXSD5qGqv0it9WjyLgmCYf1k96rVOgfswnAPYXzr/ewoULQ=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6965.namprd04.prod.outlook.com (2603:10b6:610:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sun, 13 Dec
 2020 23:41:09 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Sun, 13 Dec 2020
 23:41:09 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V6 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V6 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW0RPvmJIFNb+IOkaBuk4iq3d6ew==
Date:   Sun, 13 Dec 2020 23:41:09 +0000
Message-ID: <CH2PR04MB6522C565F3EC80FBBDD7CEB6E7C80@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
 <20201213055017.7141-5-chaitanya.kulkarni@wdc.com>
 <3fa59aa6a579b58ffff9fc0f95a34f93c9354618.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a7714a0-37a1-41e8-b354-08d89fc09172
x-ms-traffictypediagnostic: CH2PR04MB6965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6965B012C51478450651442BE7C80@CH2PR04MB6965.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NthkR8UKpvbbx0JbtXaJfJLnJKV8xJvC0sULKG5LLddq35iag8vXny7TJBIq7ZCtnScm4RlzolH6epmSsS7GdB5eYbxYNyxxffmH58o4wIk88XNt4k3/M8io/bwyrBRhEVswLwHDcLn5vV0PjTgtn38x2vIXSRoflB5mcQ++Guupmdf1S8hSXnqZHnXuMEcc/2/FKltFEpr81yQuOmPFrvu0MzXm6YgoKc18B9MYw2LYyxb2/wCkrRvl3O+LzU20l9h9QbeoUTX33kCQ9Op8NRyChTVpujouPT1/WmfV5Zpa8nptT2RKRdVfnBUP9G6qVzmJhA1YLI0AngXZlN3duA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(52536014)(76116006)(91956017)(4001150100001)(66946007)(5660300002)(186003)(6506007)(7696005)(53546011)(83380400001)(8936002)(26005)(2906002)(86362001)(508600001)(55016002)(66556008)(64756008)(66476007)(8676002)(66446008)(71200400001)(4326008)(9686003)(54906003)(110136005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Y16veIlVurXOpqh0lo3JZnFoK1fTx4CoeTj7POXwBqtZe8y7L9fsUhZlgcRP?=
 =?us-ascii?Q?11+DjgnO9qIi8BaG4JdAyx86/zKxRZr1eCOJ1VgZUft3NUI5S2QeLxpNYBzS?=
 =?us-ascii?Q?cXFqfE+Lsta8PzwQEHQACvY1MmJ4jXeJCyNmGSzIZNKoqkoUcR97hJVnp26I?=
 =?us-ascii?Q?8tfF3yiUJmefDj3JPfiKBOS0PhYC4dNQs1x3qdnlhWodb4nTghqWYz3f7+VH?=
 =?us-ascii?Q?JncXDuDqxkp3JyTh5INvPf+Uld0gUUGWWUkdqbu2meqFnwvEqVt707uEGC0b?=
 =?us-ascii?Q?rsX2wMxmFETC7owmp3dYDRHu0BWWZQPOGZjBaAqKM1H0l4V9aR+qhSXcTgzr?=
 =?us-ascii?Q?jXlnKAdN9SmfT3i+TuRM29W/ZIrbFnkEzHwd0jaDMsnhbbzZvP1gVwTmmv2B?=
 =?us-ascii?Q?NINvaFG+zOud75lDSmgEJWQenGhMTTTEirzv6RURxk0Kb66seCfJWKLuJMuR?=
 =?us-ascii?Q?Uj1thl4yXEn5lqYCZHdRFKW1wZXVQ83ZWLU7Bv4K0Oy11U20IZhlmH06tFTU?=
 =?us-ascii?Q?wtQiPCpvi5NT7ieG2aFLaHiLBFYMPcKV6n0umTrYOVRMvbJhpWrKf7G5mBnE?=
 =?us-ascii?Q?Pn/YaETRX+MhZPuOY5/VuVFvV/dA9lPQfrdk57Zx6opqc5ViwBBWWdf0ZJA4?=
 =?us-ascii?Q?E6JoVEpn2hYgiRGIJQysfS61FYZ8fsgtMLw72Oz5p+lEU4+ZHXRP1KHioASG?=
 =?us-ascii?Q?ylqzYD4AFygIBMXVH/xMmk1QpCtql/VOpJP8r/WI0QWBLXa0Lr8gsv57868Y?=
 =?us-ascii?Q?d2mELsb6QLBtoK0bMg38et2d58OCjBg/oBgE2bRQQbyK1s+9UUWjW6RF08Rw?=
 =?us-ascii?Q?saC5QMWpD1bxdwkyV14QmNH1rclPy1d5ERoyOZBnJp4BeqDFbjVCGjebjFX6?=
 =?us-ascii?Q?TU7jAokWsaXzs87yG4WqWtxBWYaz77tdaKqCz02Si6b7PBF9nDndniPlUimn?=
 =?us-ascii?Q?yMnRE+Xj8Aoqh8PEIbKQrcYRkb3JIvNv1ZTNFSGuJF97Me8ZejsgYFPdSNuj?=
 =?us-ascii?Q?FhXY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7714a0-37a1-41e8-b354-08d89fc09172
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2020 23:41:09.4839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YUBoIn7rKQWR6+f029TF2V6Vp5Xppx/8vvFASBeafW468QXcXkeX4zERAvrA059TgQuuygbg47tLZ5bw/6M+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6965
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/13 19:31, Damien Le Moal wrote:=0A=
> On Sat, 2020-12-12 at 21:50 -0800, Chaitanya Kulkarni wrote:=0A=
> [...]=0A=
>> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,=0A=
>> +		unsigned int idx, void *data)=0A=
>> +{=0A=
>> +	struct blk_zone *zone =3D data;=0A=
>> +=0A=
>> +	memcpy(zone, z, sizeof(struct blk_zone));=0A=
> =0A=
> See below. This is not necessary.=0A=
> =0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)=0A=
>> +{=0A=
>> +	struct blk_zone zone;=0A=
>> +	int reported_zones;=0A=
>> +	unsigned int zno;=0A=
>> +=0A=
>> +	if (bdev->bd_disk->queue->conv_zones_bitmap)=0A=
>> +		return false;=0A=
> =0A=
> Bug.=0A=
> =0A=
>> +=0A=
>> +	for (zno =3D 0; zno < blk_queue_nr_zones(bdev->bd_disk->queue); zno++)=
 {=0A=
> =0A=
> Large capacity SMR drives have over 75,000 zones these days. Doing a repo=
rt=0A=
> zones one zone at a time will take forever. This needs to be optimized: s=
ee=0A=
> below.=0A=
> =0A=
>> +		reported_zones =3D blkdev_report_zones(bdev,=0A=
>> +				zno * bdev_zone_sectors(bdev), 1,=0A=
>> +				nvmet_bdev_validate_zns_zones_cb,=0A=
>> +				&zone);=0A=
>> +=0A=
>> +		if (reported_zones !=3D 1)=0A=
>> +			return true;=0A=
>> +=0A=
>> +		if (zone.type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> +			return true;=0A=
> =0A=
> This test should be in the nvmet_bdev_validate_zns_zones_cb() callback. T=
hat=0A=
> callback can return an error if it finds a conventional zone. That will s=
top=0A=
> blkdev_report_zones().=0A=
> =0A=
> =0A=
>> +	}=0A=
>> +=0A=
>> +	return false;=0A=
>> +}=0A=
> =0A=
> What about this:=0A=
> =0A=
> static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,=0A=
> 					    unsigned int idx, void *data)=0A=
> {=0A=
> 	if (z->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> 		return -ENOTSUPP;=0A=
> 	return 0;=0A=
> }=0A=
> =0A=
> static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)=0A=
> {=0A=
> 	int ret;=0A=
> =0A=
> 	if (bdev->bd_disk->queue->conv_zones_bitmap)=0A=
> 		return true;=0A=
> =0A=
> 	ret =3D blkdev_report_zones(bdev,=0A=
> 			get_capacity(bdev->bd_disk), blkdev_nr_zones(bdev),=0A=
> 			nvmet_bdev_validate_zns_zones_cb, NULL);=0A=
=0A=
Oops. This is wrong. This should be:=0A=
=0A=
	ret =3D blkdev_report_zones(bdev, 0, blkdev_nr_zones(bdev->bd_disk),=0A=
				  nvmet_bdev_validate_zns_zones_cb, NULL);=0A=
=0A=
> 	if (ret < 1)=0A=
> 		return true;=0A=
> =0A=
> 	return false;=0A=
> }=0A=
> =0A=
> All zones are checked using the callback with the loop in=0A=
> blkdev_report_zones().=0A=
> =0A=
> [...]=0A=
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);=0A=
>> +	struct request_queue *q =3D req->ns->bdev->bd_disk->queue;=0A=
>> +	unsigned int max_sects =3D queue_max_zone_append_sectors(q);=0A=
>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>> +	unsigned int total_len =3D 0;=0A=
>> +	struct scatterlist *sg;=0A=
>> +	int ret =3D 0, sg_cnt;=0A=
>> +	struct bio *bio;=0A=
>> +=0A=
>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))=0A=
>> +		return;=0A=
>> +=0A=
>> +	if (!req->sg_cnt) {=0A=
>> +		nvmet_req_complete(req, 0);=0A=
>> +		return;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {=0A=
>> +		bio =3D &req->b.inline_bio;=0A=
>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));=0A=
>> +	} else {=0A=
>> +		bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);=0A=
>> +	}=0A=
>> +=0A=
>> +	bio_set_dev(bio, req->ns->bdev);=0A=
>> +	bio->bi_iter.bi_sector =3D sect;=0A=
>> +	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
>> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))=0A=
>> +		bio->bi_opf |=3D REQ_FUA;=0A=
>> +=0A=
>> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {=0A=
>> +		struct page *p =3D sg_page(sg);=0A=
>> +		unsigned int l =3D sg->length;=0A=
>> +		unsigned int o =3D sg->offset;=0A=
>> +		bool same_page =3D false;=0A=
>> +=0A=
>> +		ret =3D bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);=0A=
>> +		if (ret !=3D sg->length) {=0A=
>> +			status =3D NVME_SC_INTERNAL;=0A=
>> +			goto out_bio_put;=0A=
>> +		}=0A=
>> +		if (same_page)=0A=
>> +			put_page(p);=0A=
>> +=0A=
>> +		total_len +=3D sg->length;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (total_len !=3D nvmet_rw_data_len(req)) {=0A=
>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>> +		goto out_bio_put;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D submit_bio_wait(bio);=0A=
>> +	status =3D ret < 0 ? NVME_SC_INTERNAL : status;=0A=
>> +=0A=
>> +	req->cqe->result.u64 =3D nvmet_sect_to_lba(req->ns,=0A=
>> +						 bio->bi_iter.bi_sector);=0A=
> =0A=
> Why set this if the BIO failed ? There may be no problems doing so, but I=
 do=0A=
> not see the point either.=0A=
> =0A=
>> +=0A=
>> +out_bio_put:=0A=
>> +	if (bio !=3D &req->b.inline_bio)=0A=
>> +		bio_put(bio);=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
