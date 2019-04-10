Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA5FC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 07:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEB52070D
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 07:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kX6I5diC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fLKspAvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfDJHUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:20:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6961 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfDJHUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 03:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554880830; x=1586416830;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1hfpmorFFar/AusJGtsR2n3pM3hca21OzaI9Rpf+2ZI=;
  b=kX6I5diCcFKhk/m4dZNSPfpTAzDgJx9U6CqcppOhR1AKaaxotUgwvdKk
   yEbwXmWwKamFjJwEJ+qppmVABAlDEJIFCRnb6b54mA/EYuP01KKSXIjPQ
   Y0vMJAE3aDHtc+i9afPaBq2o4DqVoWhuMdVJz7emuvoxy4e+rBxwrzeTT
   fJoyzn+v+Xs4w2NZfb77hWYmzIjWIBBaIv6592m9CLSluqIn88JXyEF1L
   4tO/oQH1sh1lRMXQHBQn0NAUy8UWvlD7DPVFXrOpqOEWJwLOwRFgKZNXs
   TZM8Ivvst2u/xK8d+RZh9ddXerXYXHYGN9UKDEeJbJZ9UghXIOMNGDSD/
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,332,1549900800"; 
   d="scan'208";a="211199991"
Received: from mail-co1nam05lp2056.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.56])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2019 15:20:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfrpcYNJ02My8z29M2wjVmi4B0/uuufb1UNiY8eoLX4=;
 b=fLKspAvP/FLW4/C0kRHHMpIyHCq283LDw3b0oWyTJzpmPkVyG/4iqpjjIrkuEm0W//R82r01GGD07GhDiKMkuHfuVoCEI6dHGWwpWTcgglOieLva9zUZcYpAxJuRK8SttkO2aSlVcZo0n3qcHJZQw5kkk9BTXqogRQ1jvv/uOMo=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4070.namprd04.prod.outlook.com (52.135.215.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 10 Apr 2019 07:20:27 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::ec3e:1844:ecb1:6637]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::ec3e:1844:ecb1:6637%5]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 07:20:27 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Edwards <gedwards@ddn.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] block: make blk_queue_zone_sectors() return sector_t type
Thread-Topic: [PATCH] block: make blk_queue_zone_sectors() return sector_t
 type
Thread-Index: AQHU72Qd8A1LM4TQzkyycron5fQEHQ==
Date:   Wed, 10 Apr 2019 07:20:27 +0000
Message-ID: <BYAPR04MB5816CFE5C37FABB137D496DEE72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190410061006.GA18813@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a52fb3a-94ec-4bf2-abd2-08d6bd8501b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4070;
x-ms-traffictypediagnostic: BYAPR04MB4070:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4070D99FD151ADAC9747B6F9E72E0@BYAPR04MB4070.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(2906002)(7696005)(9686003)(229853002)(71190400001)(71200400001)(256004)(8936002)(33656002)(6436002)(53936002)(305945005)(74316002)(446003)(8676002)(476003)(7416002)(55016002)(14444005)(7736002)(478600001)(186003)(486006)(81166006)(110136005)(102836004)(6116002)(105586002)(68736007)(6246003)(76176011)(26005)(86362001)(72206003)(97736004)(6506007)(5660300002)(81156014)(53546011)(316002)(52536014)(66066001)(14454004)(106356001)(3846002)(4326008)(25786009)(54906003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4070;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OzDX2rx3UNskIu8FNLaZ6nwLPeBkdroMTTCH3UgyCskO3TjdVLKpGRAv/aRfngsxqokzscJBMBcyR7Z+npYdVyLyjlr1HnbmzXEjB9eYbSx+y1zm/n2MTFNUGOc88yAZ2582UmK+guchTpPu6IYR9t7JCZ4L08lLhoCplNUxjGTSpXqRVgx6g0VBngYLQhScpnHngsWsI5Vpa7xvIFOW6DbNDhm01dTzX8vUYK3Boz+Oo6V28WUNLGAdZ5g7rkPyyJLr/ZEORaoF+ABauV4BBROtdWvAN/yIq00G5RsEz9j7EA8y8AB9FBJJdaxfcIoaKH81IGct/0HwrYJiJ52GaKZrZmnw2VwYp4e6SLmeWEb76fvSA2HVR4OKj3m0+fcQCutRn+BNyPQO/oFLE1kli1TwWaggSAsm/DvX6iOkTd0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a52fb3a-94ec-4bf2-abd2-08d6bd8501b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 07:20:27.4996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4070
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/04/10 15:10, Dan Carpenter wrote:=0A=
> My static checker complains about this line from dmz_get_zoned_device()=
=0A=
> =0A=
> 	aligned_capacity =3D dev->capacity & ~(blk_queue_zone_sectors(q) - 1);=
=0A=
> =0A=
> The problem is that "aligned_capacity" and "dev->capacity" are sector_t=
=0A=
> type (which is a u64) but blk_queue_zone_sectors(q) returns a u32 so the=
=0A=
> higher 32 bits in aligned_capacity are always cleared to zero.=0A=
> =0A=
> Declaring blk_queue_zone_sectors() as a sector_t addresses this warning=
=0A=
> and it feels intuitive based on the function name.  I updated=0A=
> bdev_zone_sectors() as well just to be consistent.=0A=
> =0A=
> Fixes: 114e025968b5 ("dm zoned: ignore last smaller runt zone")=0A=
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>=0A=
> ---=0A=
> Please review this one extra carefully.  I'm not positive it's correct.=
=0A=
> =0A=
>  include/linux/blkdev.h | 4 ++--=0A=
>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 4b85dc066264..1785a7f506be 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -670,7 +670,7 @@ static inline bool blk_queue_is_zoned(struct request_=
queue *q)=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> -static inline unsigned int blk_queue_zone_sectors(struct request_queue *=
q)=0A=
> +static inline sector_t blk_queue_zone_sectors(struct request_queue *q)=
=0A=
>  {=0A=
>  	return blk_queue_is_zoned(q) ? q->limits.chunk_sectors : 0;=0A=
>  }=0A=
> @@ -1419,7 +1419,7 @@ static inline bool bdev_is_zoned(struct block_devic=
e *bdev)=0A=
>  	return false;=0A=
>  }=0A=
>  =0A=
> -static inline unsigned int bdev_zone_sectors(struct block_device *bdev)=
=0A=
> +static inline sector_t bdev_zone_sectors(struct block_device *bdev)=0A=
>  {=0A=
>  	struct request_queue *q =3D bdev_get_queue(bdev);=0A=
=0A=
Indeed, using sector_t instead of unsigned int is more intuitive and changi=
ng to=0A=
sector_t matches the 64bits zone length in struct blk_zone too, so no probl=
em on=0A=
this front.=0A=
=0A=
However, q->limits.chunk_sectors is an unsigned int, which is why I used th=
at=0A=
type, to reflect the fact that even though the API allows values larger tha=
n 4G=0A=
sectors, the handling through the queue limits truncates that to at most 4G=
-1=0A=
sectors. Furthermore, the unsigned int type is used wherever=0A=
blk_queue_zone_sectors() and bdev_zone_sectors() are called (block/ioctl.c,=
=0A=
block/blk-zoned.c, f2fs, etc). That needs in depth checking.=0A=
=0A=
I would rather keep the unsigned int since the queue limits will give only =
32=0A=
bit values anyway. What about a cast for the aligned capacity line ? Someth=
ing like:=0A=
=0A=
aligned_capacity =3D dev->capacity & ~((u64)blk_queue_zone_sectors(q) - 1);=
=0A=
=0A=
Would that make your checker happy ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
