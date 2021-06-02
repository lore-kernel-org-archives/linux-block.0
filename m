Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0323CC4708F
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC46613D6
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFBMxI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 08:53:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26138 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFBMxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 08:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622638283; x=1654174283;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZKRRaRmVC8owObL3TWuqgDBBLTh8d35Z5j3dh8vyEIk=;
  b=kXjgvtCNt7XIdarRASetgZmm26TwRx056hKlbFmglNuf+cOA89iGisw2
   VfGT2UQfP1cuGsFnRsG6t93pKdGb7g+y7b2QsNIlddFX9SBzKrkztwVfp
   HWYQ948X4EckT9yL5+kxAGcS+yrqqP2pN9RzQUImrVK4rk2BAA/TorAME
   uDaIxdn6nBR/vk2ZQ2SWnm0cbSdPkQJparElg3lYmupMU51XFEXcez5su
   xDdVxQR/iFagQyhVlpfdS8tu2qHBPvyZlRfwdDx/Ev3FO8Nbau/K7v1Hk
   WTayEoJZyejZxkwqrTE+7j49/dV+TfMX9wd4HMaUMcXXa3/cV89e2JsM2
   Q==;
IronPort-SDR: SPOc5ZhZ/+rilHOFMgB7LQv7i5/UcYbwWQ7TN8072KkuAAdsHWfK8LaqAvz3MEjhnvwFZijXLS
 QzYI+g7A/O7qmFAKyLWlCNhQWZ0GTTmNU9uetTb/VJeqJbQmIWATAcFlCUr9ryWkj1+MPvEAkL
 OvGaG+iTrvfVBUawqzsU6eecrHHleh87K7+bl/jz/hPvGPS1+oG60XPrfIalGY17vFUz/Y4i58
 xyGoAn+8ZqQYGkxG7fsoHID/rm/GK3c980jm1hXP/wrh68SQis2p4WMw7uIbDTx/9BAlMa7k9L
 4yE=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="274293637"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 20:51:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHbvPXJzB0LBZBCBlirl3CwN+n5Yz3H1wnkobOsG/DDsymkvLt6HBeLNGr4SB5zOyjJirWumydLQblmmrYCGCRwIU26DUuK769hUAJGb94MimuUBwtFGb9gBM9VNxOTcYLnZqifFA8mFE7GXBc61mmoo6XAGy3cL101Jr9chN2tFR4TktcEUk8NQeuGbKPb+C4PDVngVIK96H0WgQn/ebxIdO4Tll9dW4B9saRu4TXtc7AwjJzJplEybC8ye0ZhO6NODrpON0ZJIBW8Iupftjh/4NsyL825c8uCI3cQ/3FkjZYLrxsYIWU7pDHxoBOBIPyYFUDtYxm5hSJCFUeE8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I4CKafoiqYPHH3bIuxVpPtWGJ6RTV7gWeh8xfogMcE=;
 b=ZCBZXzdm8yBBLp4sWcNcFypvph6t4JUDDZSm2QetABLok2l2/TnbO16T/jxCyV2RnHUIHRlbGIiBmjHjJJqUm2Zmj/GYS24vpleBjUiQOugVxZHwi29vsWAMKqzlCm8p6i2hmUofTmgCJD/+A5ol4N4CHKDTlElUwvIZNVhfCNsY9LIqlXbUtxfINT13G8ic5icUxCezf1zmf2HclhvjOkPp9FXf/Z0olDn2oyDrvGA9uoYtE+9ACUPreN0KcM8zkVd4Wmw4MVwZuvGodiviZoG03pWWKjYoLQBTfblZR6MK63J4VeR37QvGXn4Nwo9qrnu1KaHJc2YuxYhaYUH9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I4CKafoiqYPHH3bIuxVpPtWGJ6RTV7gWeh8xfogMcE=;
 b=A5Q/rw83kAQWSZMOatvvGyk/swHID8OW/A5KXhhiBF+YcEFFegCiEXBgjHKHIXG0+vg1sfR4fbkPnty4ZxcJYjyPT5XRwVeDEXUGQTlNvuBlAcvcSoIwF1DrHdhZKKIdDitXYDEegRzEiediHRcLv9M+iDFiOIpqazO94qpVo3U=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5882.namprd04.prod.outlook.com (2603:10b6:5:16a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 12:51:17 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 12:51:17 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Changheun Lee <nanich.lee@samsung.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "alex_y_xu@yahoo.ca" <alex_y_xu@yahoo.ca>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bgoncalv@redhat.com" <bgoncalv@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
CC:     "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [PATCH v11 1/3] bio: control bio max size
Thread-Topic: [PATCH v11 1/3] bio: control bio max size
Thread-Index: AQHXV6rsD3TU7ripHkSbAptiY/rq5A==
Date:   Wed, 2 Jun 2021 12:51:17 +0000
Message-ID: <DM6PR04MB70819D1D9C6301E399FC1A67E73D9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210602121037.11083-1-nanich.lee@samsung.com>
 <CGME20210602122910epcas1p17ab868175c38cf3f143b64f4ec59f75c@epcas1p1.samsung.com>
 <20210602121037.11083-2-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d7b:9386:76d5:60d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4325f35d-5898-459c-cf00-08d925c51d42
x-ms-traffictypediagnostic: DM6PR04MB5882:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB5882F37B40562F07895C9025E73D9@DM6PR04MB5882.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pu0ms2cZ+mjBi3jzW6rv6lAOusIESDNycQzbiq1DC1sHoGUQK7HzU8RwtZ5H37VXxngEvUn14JQo9KrVyNyuE36O0CfxPINwCeotgy3fiX7TsZ66/nby8LyUmUCfdst8bIy8n7K1TYbSa22hDXIQgCdouAQf1POOyd1lyt9Km1fmtszQN0zXpS1OsbOLZR/A/v2Re5pK/73TEgVNyzKdq3lrgizIANmBHW971dh4tKaXxQli2FrZxRNEOcH8yDq+i3C2osy6RJ2d1fZYDv+7OkjLe6WO9L4HiYGqf/l0dWJeCZIIUuBV6IFthdKmxfXYdgrguQHFlUF/Sjb6K/CPsoI8Xc9N2HLOVr9FlOqM27LH8KXA02vdRK0Q3OTUsi49GFFcA+GL3YGkUCXNddvSrqvCYQ7iL6QXYkDHBKI1q6difKpRssHzSp2liAI5zt0XIh3TOBwG0aqKdS07gAgMFIaTelc0g1aeD4cRdsJWmzbJeM5T6++/NUKSsJiXcuFsPbw5L+YpbH81KhcCN884Zil9w2n4+FWKiHxI1Y3GxwHEBDw5UqHkPa3gjd4pywZlieaxI0q2IKr4y6e8UoM4ohjrcmDHI9IxAS7xIW6Ka0sMK4jBwLX8bFjMpDmDmGUWhFiyG0c2R6G9H8gCg9/Lpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(52536014)(83380400001)(186003)(4326008)(7416002)(8676002)(66476007)(71200400001)(33656002)(110136005)(478600001)(2906002)(55016002)(38100700002)(64756008)(66556008)(316002)(5660300002)(9686003)(66946007)(921005)(66446008)(76116006)(86362001)(6506007)(54906003)(91956017)(7696005)(53546011)(8936002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3bMBxam1JnlFsRe6M2r1rs8YthBURb0w20IlMvmbykS0OJIafZs9hFhrwHX1?=
 =?us-ascii?Q?PYBJkGezPMosbEYBLmEIZ+4ql8cFG/KWabTEG4Wugfa6j89Ip/a07s5eSVno?=
 =?us-ascii?Q?c2fO7K/VXUC/xwccw2U1xTjNBbgtZ9b56WMmFKw1CwduUcUc8o0IausTUs2/?=
 =?us-ascii?Q?BTe/f1zQLwMUxFK24Mp72S6pgKABQo1J5q7B06r6axBirkCXt3ACInYqzvDo?=
 =?us-ascii?Q?Zl1LW5YwfGn32IZ5cWv3lMaGfT0Su5N8U1rv4gnmRhAELL+OWYxXmd0fct7f?=
 =?us-ascii?Q?xTgatkBWZwc6VoayhfCCw+aLSftHn71YPtzWSr2jJuJ8tqydpOY6rQ6FFw8Y?=
 =?us-ascii?Q?qJHSHMykNTOCeEii5w/gSaZbDimeO/49EZih/d4cb6UzWMJrzx/XElUuwVDQ?=
 =?us-ascii?Q?FvNezNtbcP2i5fg+jFs0apBVPKrHXmQvECDDXK627BqPWIL2dci8ju8CN/mr?=
 =?us-ascii?Q?6CUSCxRkrbhmeZClOQnClGzmEsyOZOh6MK3Zgs9ALlOQkmVUdpVHseqg9WqF?=
 =?us-ascii?Q?xPT6AyKgkPnFrip/tP8Bk7zXyjWUG5n9GKYSERi9b/Yxyglja3xxM7vLxrlm?=
 =?us-ascii?Q?GyYOghl78eN/VGpJF2HWWhMeqnSnWvd30Y3J8rKyIevK1m5t+DC8g4bEGvLC?=
 =?us-ascii?Q?bEpI2p9R4EgB1IBu/ACDLKk+arabd0VAnaSzeSqvrMXXie71/9Dk/ZOytKmB?=
 =?us-ascii?Q?cyXDDT9xZUmcgXRwuxEd+S/gZTRcYHJ2qMoCOForcaXcVjpgpLFH9X9Lt31k?=
 =?us-ascii?Q?JASG5s3ZSM+52V3Fn64Eu/18qsV4K2FGhZYRirBA9EoAXSuec4rLv6p8S/CR?=
 =?us-ascii?Q?G8vxyBulVvmNasSdD6nk6eqDlsiaMGHPjyZF3t8QgFTI/O0SswR/I4Qriy43?=
 =?us-ascii?Q?KbJxxtAScoNizjUdif7v2M5TrapvDod651Lmaf5nHqgTOUX1CrjOrLWBW3LW?=
 =?us-ascii?Q?ZI0qGrNYsZV9Ix35BuO4//Z8+JHbcLrigF6+mo7F19t/lnhm7X4rInEkhlmN?=
 =?us-ascii?Q?5apb7cFxxHXtt/GXQ2HGh3k+MzzrK5c/NsoB+vZBE/lqey5bWukXiSeOWyu4?=
 =?us-ascii?Q?oPuYBOvIZIyPAjDBpLi4MyX73KhS8x0+wJPF3Q4Ypc6hngfi9wbeYSUabjUX?=
 =?us-ascii?Q?TmDX7TEi+zR4SepDKHQGtB2e85tU4hx7PCuhaQUMvNwWvKBDixH/B0WKiuDB?=
 =?us-ascii?Q?4NkKgKTFtj1nD5F7ek1Q/0RwXRJcwDqvcdUN1Hc1jsFbpduYgaUuVVn7HaTL?=
 =?us-ascii?Q?LK9HuiPi7eZv5uckcblqkKkOU5GonjX4yHKh0YpKM31MtcbUDq18/uiDS4YV?=
 =?us-ascii?Q?GU6Av6Ghpf/RSiGNyVt53cZG593DLJER+7fsNzQPJvTRS1m769h0hjl5x16x?=
 =?us-ascii?Q?eyO/TS01Jne/VuwreafZyQhXCzkrnuSlZoRgFr5LlMZrLt+LIw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4325f35d-5898-459c-cf00-08d925c51d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 12:51:17.8223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7wCIZgSVCh9qhw4rwZceJjKofS+OkJ+8Y7wYiWcCzHH6gMpsCmZ/w8l4hgtHfdnMji6a6CYo1TbQj1GCv+3og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5882
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/02 21:29, Changheun Lee wrote:=0A=
> bio size can grow up to 4GB after muli-page bvec has been enabled.=0A=
> But sometimes large size of bio would lead to inefficient behaviors.=0A=
> Control of bio max size will be helpful to improve inefficiency.=0A=
> =0A=
> Below is a example for inefficient behaviours.=0A=
> In case of large chunk direct I/O, - 32MB chunk read in user space -=0A=
> all pages for 32MB would be merged to a bio structure if the pages=0A=
> physical addresses are contiguous. It makes some delay to submit=0A=
> until merge complete. bio max size should be limited to a proper size.=0A=
> =0A=
> When 32MB chunk read with direct I/O option is coming from userspace,=0A=
> kernel behavior is below now in do_direct_IO() loop. It's timeline.=0A=
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
> ---=0A=
>  block/bio.c            | 17 ++++++++++++++---=0A=
>  block/blk-settings.c   | 19 +++++++++++++++++++=0A=
>  include/linux/bio.h    |  4 +++-=0A=
>  include/linux/blkdev.h |  3 +++=0A=
>  4 files changed, 39 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 44205dfb6b60..c52639bb80cd 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -255,6 +255,13 @@ void bio_init(struct bio *bio, struct bio_vec *table=
,=0A=
>  }=0A=
>  EXPORT_SYMBOL(bio_init);=0A=
>  =0A=
> +unsigned int bio_max_size(struct bio *bio)=0A=
=0A=
It would be nice to call this function the same as the limit name: bio_max_=
bytes().=0A=
=0A=
> +{=0A=
> +	struct block_device *bdev =3D bio->bi_bdev;=0A=
> +=0A=
> +	return bdev ? bdev->bd_disk->queue->limits.max_bio_bytes : UINT_MAX;=0A=
=0A=
My personal preference goes to a plain if() instead of this.=0A=
=0A=
> +}=0A=
> +=0A=
>  /**=0A=
>   * bio_reset - reinitialize a bio=0A=
>   * @bio:	bio to reset=0A=
> @@ -866,7 +873,7 @@ bool __bio_try_merge_page(struct bio *bio, struct pag=
e *page,=0A=
>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>  =0A=
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {=0A=
>  				*same_page =3D false;=0A=
>  				return false;=0A=
>  			}=0A=
> @@ -995,6 +1002,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio,=
 struct iov_iter *iter)=0A=
>  {=0A=
>  	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;=0A=
>  	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;=0A=
> +	unsigned int bytes_left =3D bio_max_size(bio) - bio->bi_iter.bi_size;=
=0A=
>  	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;=0A=
>  	struct page **pages =3D (struct page **)bv;=0A=
>  	bool same_page =3D false;=0A=
> @@ -1010,7 +1018,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)=0A=
>  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);=0A=
>  	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);=0A=
>  =0A=
> -	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);=
=0A=
> +	size =3D iov_iter_get_pages(iter, pages, bytes_left, nr_pages,=0A=
> +				  &offset);=0A=
>  	if (unlikely(size <=3D 0))=0A=
>  		return size ? size : -EFAULT;=0A=
>  =0A=
> @@ -1038,6 +1047,7 @@ static int __bio_iov_append_get_pages(struct bio *b=
io, struct iov_iter *iter)=0A=
>  {=0A=
>  	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;=0A=
>  	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;=0A=
> +	unsigned int bytes_left =3D bio_max_size(bio) - bio->bi_iter.bi_size;=
=0A=
>  	struct request_queue *q =3D bio->bi_bdev->bd_disk->queue;=0A=
>  	unsigned int max_append_sectors =3D queue_max_zone_append_sectors(q);=
=0A=
>  	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;=0A=
> @@ -1058,7 +1068,8 @@ static int __bio_iov_append_get_pages(struct bio *b=
io, struct iov_iter *iter)=0A=
>  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);=0A=
>  	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);=0A=
>  =0A=
> -	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);=
=0A=
> +	size =3D iov_iter_get_pages(iter, pages, bytes_left, nr_pages,=0A=
> +				  &offset);=0A=
>  	if (unlikely(size <=3D 0))=0A=
>  		return size ? size : -EFAULT;=0A=
>  =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 902c40d67120..e270e31519a1 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -32,6 +32,7 @@ EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);=0A=
>   */=0A=
>  void blk_set_default_limits(struct queue_limits *lim)=0A=
>  {=0A=
> +	lim->max_bio_bytes =3D UINT_MAX;=0A=
>  	lim->max_segments =3D BLK_MAX_SEGMENTS;=0A=
>  	lim->max_discard_segments =3D 1;=0A=
>  	lim->max_integrity_segments =3D 0;=0A=
=0A=
What about the limit setup for stacked devices ? Leaving it to UINT_MAX is =
OK ?=0A=
If for your use case you add dm-linear on top of the device and rerun your =
test,=0A=
don't you get again slow performance ?=0A=
=0A=
> @@ -100,6 +101,24 @@ void blk_queue_bounce_limit(struct request_queue *q,=
 enum blk_bounce bounce)=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_queue_bounce_limit);=0A=
>  =0A=
> +/**=0A=
> + * blk_queue_max_bio_bytes - set bio max size for queue=0A=
> + * @q: the request queue for the device=0A=
> + * @bytes : bio max bytes to be set=0A=
> + *=0A=
> + * Description:=0A=
> + *    Set proper bio max size to optimize queue operating.=0A=
> + **/=0A=
> +void blk_queue_max_bio_bytes(struct request_queue *q, unsigned int bytes=
)=0A=
> +{=0A=
> +	struct queue_limits *limits =3D &q->limits;=0A=
> +	unsigned int max_bio_bytes =3D round_up(bytes, PAGE_SIZE);=0A=
> +=0A=
> +	limits->max_bio_bytes =3D max_t(unsigned int, max_bio_bytes,=0A=
> +				      BIO_MAX_VECS * PAGE_SIZE);=0A=
> +}=0A=
> +EXPORT_SYMBOL(blk_queue_max_bio_bytes);=0A=
=0A=
Why does this need to be exported ?=0A=
=0A=
> +=0A=
>  /**=0A=
>   * blk_queue_max_hw_sectors - set max sectors for a request for this que=
ue=0A=
>   * @q:  the request queue for the device=0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index a0b4cfdf62a4..f1a99f0a240c 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)=0A=
>  	return NULL;=0A=
>  }=0A=
>  =0A=
> +extern unsigned int bio_max_size(struct bio *bio);=0A=
=0A=
No need for extern.=0A=
=0A=
> +=0A=
>  /**=0A=
>   * bio_full - check if the bio is full=0A=
>   * @bio:	bio to check=0A=
> @@ -119,7 +121,7 @@ static inline bool bio_full(struct bio *bio, unsigned=
 len)=0A=
>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>  		return true;=0A=
>  =0A=
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
> +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)=0A=
>  		return true;=0A=
>  =0A=
>  	return false;=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 1255823b2bc0..861888501fc0 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -326,6 +326,8 @@ enum blk_bounce {=0A=
>  };=0A=
>  =0A=
>  struct queue_limits {=0A=
> +	unsigned int		max_bio_bytes;=0A=
> +=0A=
>  	enum blk_bounce		bounce;=0A=
>  	unsigned long		seg_boundary_mask;=0A=
>  	unsigned long		virt_boundary_mask;=0A=
> @@ -1132,6 +1134,7 @@ extern void blk_abort_request(struct request *);=0A=
>   * Access functions for manipulating queue properties=0A=
>   */=0A=
>  extern void blk_cleanup_queue(struct request_queue *);=0A=
> +extern void blk_queue_max_bio_bytes(struct request_queue *, unsigned int=
);=0A=
=0A=
No need for extern.=0A=
=0A=
>  void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce lim=
it);=0A=
>  extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned in=
t);=0A=
>  extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int=
);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
