Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A98C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D1D20854
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="drNF3RVj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HkfluqC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfD3Vom (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:44:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61932 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfD3Vom (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 17:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556660682; x=1588196682;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bMojwqWd7RreyPHRmv61lPhjy3g5m1zouimL4ygfbl8=;
  b=drNF3RVjxlla0PZc6aZH5/jDS8UU6VEqFu571aMw4vQg3Z3lwABZrG6q
   9ky6339zbtICHrazjbbGPch83e2TAj2mwvJ3t7g4Vd5Py/DClcKMJsJm/
   b43qAO7pyrDRsbL7KvIE24wx0D5dpNnEzpMAdp9AQoP2l9nmy90hXkZxB
   QxISf0Kl4KEqAxk4CKPupGeNXPv9afY29W1ISlHEmVLzETb0pAQWTrz47
   WZnYJOeEHkDlTqr2e7RGX+/CTjoc/sBv1mIlSADtnEY86EO0dYmTVLkeG
   MyUX8itp1g/NKwgsZEzddMcyTgndY+qZ2eK8LTkvt9A1DB9lcRi4y+tba
   A==;
X-IronPort-AV: E=Sophos;i="5.60,415,1549900800"; 
   d="scan'208";a="112163496"
Received: from mail-dm3nam05lp2053.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.53])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 05:44:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkqbjm/G43U1yPEqpwZBrIrCPkYWfoIR5MCELLm8Edg=;
 b=HkfluqC0T2baXg2B4a6y3l51sZknOCynfRxWs/7wfJ018GnJPftImGYUZ1LcS03/BKJTHxUpMNTTTltXdmvlDAUvxg05h4436LwQkd3lP3/U7R8xywYOXU8EufoHDjvJGJWorKUhm4rGkqH2PImC3Dzk+rCRVMBn9e3Q5n3eLJk=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4208.namprd04.prod.outlook.com (52.135.71.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Tue, 30 Apr 2019 21:44:39 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.015; Tue, 30 Apr 2019
 21:44:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove the unused blk_queue_dma_pad function
Thread-Topic: [PATCH] block: remove the unused blk_queue_dma_pad function
Thread-Index: AQHU/34bghJSWHrnx0eaK1fDVcyLdg==
Date:   Tue, 30 Apr 2019 21:44:39 +0000
Message-ID: <SN6PR04MB4527B58C274286BD7C0767BA863A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190430175616.26639-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4693494d-c849-46f8-9cde-08d6cdb50c40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4208;
x-ms-traffictypediagnostic: SN6PR04MB4208:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4208F86BBA33B4E8C8E90E69863A0@SN6PR04MB4208.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(136003)(346002)(199004)(189003)(102836004)(68736007)(25786009)(316002)(33656002)(6116002)(7696005)(3846002)(26005)(14454004)(8936002)(99286004)(2906002)(81156014)(14444005)(305945005)(74316002)(256004)(7736002)(5660300002)(110136005)(71190400001)(186003)(446003)(486006)(71200400001)(76116006)(64756008)(91956017)(476003)(66556008)(66446008)(52536014)(81166006)(76176011)(66066001)(86362001)(2501003)(8676002)(478600001)(4326008)(66946007)(6246003)(72206003)(53546011)(55016002)(6506007)(66476007)(229853002)(6436002)(9686003)(53936002)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4208;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hXLnldGWZYNQFWQZFlI9T2y+clU6G6hk/+BQ3+j60CpCNCOklauhWRTS45W5tGUwn3Y9dDrw9wuDezSo+EHz2/EwHa52/j3+6CVdxikEwoW3u1745hbdL0sk6V0P4KNuULhHIdKPD4U8PcrXDBgbvXHw1yYImE1LhpzfRA9VBmo7bO/dlD6eOp7KDus4T1iTnV1qvEBPS3TVaz2lIAAlxb35P6y9vs7x9xQCccgvTGLaYjw7NqcJDKwDA/EjpZwMv/dymSXwUXfNvKm4T8+zNpTwxs55W9CS395ARFY0IHoRhXDtNH6rwEEI0C+FuHhEbdKONJ5xX2BP0nk30eU/gDSS8JnpdDzFyPXKdPjwKpqY2U3M495Gr0nT83J6C9wUv0n5TkYO54lMWCRmjxDHBqUlC1i6yG2/bk9TmR64um0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4693494d-c849-46f8-9cde-08d6cdb50c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 21:44:39.6808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4208
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 4/30/19 10:56 AM, Christoph Hellwig wrote:=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/blk-settings.c   | 16 ----------------=0A=
>   include/linux/blkdev.h |  1 -=0A=
>   2 files changed, 17 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 6375afaedcec..e8889e48b032 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -662,22 +662,6 @@ void disk_stack_limits(struct gendisk *disk, struct =
block_device *bdev,=0A=
>   }=0A=
>   EXPORT_SYMBOL(disk_stack_limits);=0A=
>   =0A=
> -/**=0A=
> - * blk_queue_dma_pad - set pad mask=0A=
> - * @q:     the request queue for the device=0A=
> - * @mask:  pad mask=0A=
> - *=0A=
> - * Set dma pad mask.=0A=
> - *=0A=
> - * Appending pad buffer to a request modifies the last entry of a=0A=
> - * scatter list such that it includes the pad buffer.=0A=
> - **/=0A=
> -void blk_queue_dma_pad(struct request_queue *q, unsigned int mask)=0A=
> -{=0A=
> -	q->dma_pad_mask =3D mask;=0A=
> -}=0A=
> -EXPORT_SYMBOL(blk_queue_dma_pad);=0A=
> -=0A=
>   /**=0A=
>    * blk_queue_update_dma_pad - update pad mask=0A=
>    * @q:     the request queue for the device=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 99aa98f60b9e..bd3e3f09bfa0 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -1069,7 +1069,6 @@ extern int bdev_stack_limits(struct queue_limits *t=
, struct block_device *bdev,=0A=
>   extern void disk_stack_limits(struct gendisk *disk, struct block_device=
 *bdev,=0A=
>   			      sector_t offset);=0A=
>   extern void blk_queue_stack_limits(struct request_queue *t, struct requ=
est_queue *b);=0A=
> -extern void blk_queue_dma_pad(struct request_queue *, unsigned int);=0A=
>   extern void blk_queue_update_dma_pad(struct request_queue *, unsigned i=
nt);=0A=
>   extern int blk_queue_dma_drain(struct request_queue *q,=0A=
>   			       dma_drain_needed_fn *dma_drain_needed,=0A=
> =0A=
=0A=
