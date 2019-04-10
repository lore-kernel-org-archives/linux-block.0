Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585DDC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 07:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CA7206B7
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 07:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oNA+Fee3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QsqvfJ+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfDJH4U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:56:20 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26634 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJH4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 03:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554883010; x=1586419010;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Cu9UBTwZF+TetNxevCXwz8dgvIWIHyeAXKdfB95x8AI=;
  b=oNA+Fee3bUfTqeyULcpG1Fpx6EWRhis4TsUY+wDPLr12nsKe61kzjtpw
   aUOvCsfJv3o6I/8MRVS3H41QQ2cb2qqKL1dEKzVRSoJ7k1Mj84dRMuba9
   P4tvlVCw0snbBrJwSH1x5rs9DJSKkgMu9MyrWioOspoewFUlSBz1n9VQ7
   WRYK9NP65KIcFkLAFdovk9nDyMZqsxZ9ZMWqcZfYfpX2YZvzle4PrQdr+
   7h/ATJADQia+PshoWRS7oQzmh440RYs+7JRuijJwn3Hrxi86n/izFOpP7
   XCbDIq3SsYEDAuZWabql8RQRL6l3dOORZ6qtbCH+Cze2tagP8HIwSTEGg
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,332,1549900800"; 
   d="scan'208";a="204329106"
Received: from mail-dm3nam05lp2054.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.54])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2019 15:56:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w803UfPQmwSbKv+MCYL7plTSN+or2VKcx/MGQ5n6Ol0=;
 b=QsqvfJ+IKb3rxWkxxCfsIHfstKu7gO/TXzDEQeAta5MmTI7aou8mGjsZ/tLCrpY8VYxMN/M9q3f8P8sFGzMlgDwWX2KCggqpqhUHByBettaziEjjx6CiQdWW9ETXDaPI+cy4vjhyoVaFHgQ087oykVX2Xuw4pwd2UFlLnefO7Po=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5911.namprd04.prod.outlook.com (20.179.59.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Wed, 10 Apr 2019 07:56:14 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::ec3e:1844:ecb1:6637]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::ec3e:1844:ecb1:6637%5]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 07:56:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alasdair Kergon <agk@redhat.com>
CC:     Mike Snitzer <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Edwards <gedwards@ddn.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] dm zoned: Silence a static checker warning
Thread-Topic: [PATCH v2] dm zoned: Silence a static checker warning
Thread-Index: AQHU73HNUX+W4p/PyEWznhtFujpE0g==
Date:   Wed, 10 Apr 2019 07:56:14 +0000
Message-ID: <BYAPR04MB58160DF520B305A4328FC438E72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190410074735.GA28842@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ca2be4c-b4b0-47b1-2bcb-08d6bd8a016e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5911;
x-ms-traffictypediagnostic: BYAPR04MB5911:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5911380C1928288DFE14B9B1E72E0@BYAPR04MB5911.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(26005)(102836004)(316002)(53546011)(256004)(97736004)(476003)(8676002)(14444005)(486006)(8936002)(7696005)(106356001)(81166006)(81156014)(478600001)(446003)(6506007)(66066001)(99286004)(76176011)(5660300002)(25786009)(52536014)(54906003)(229853002)(6436002)(110136005)(2906002)(14454004)(7416002)(68736007)(4326008)(72206003)(71190400001)(305945005)(74316002)(966005)(6116002)(7736002)(3846002)(9686003)(6306002)(33656002)(55016002)(105586002)(86362001)(186003)(53936002)(71200400001)(6246003)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5911;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w1D9zOQFwv/wVkv8+iTAZaz08fh81IOaTH1K6tJJ3XOSO52+JR0Kuxxje4Fo0Alp0mRQiPXGobbJMU9bR14j9Pa4Xtq3/zxq15/B1UoZKMZgtCyqqgAVIvXSubpQJpIu5Zt4rjh/egJRlWPWkWImxO1J4ACjI+0tp4inlJJRFSOZx+7cBRbG/abq8bYs9rYfBEMl7ZoGpZh3U+gifcWHAPOvpSS/RzKoviLnrelggZWWOoCw+D3UeIsk3Jc6Vdldp923sGLqhX2pHlc2Ntzrz+mpMbomTNBbs/Xc5LgMjIx9IO8GGj03O0TW9a2GqC+bHk0IbhgxdwEhp0y7EUH5rO9yA+EJeN2DDsns8wZgZruxQKY1rTijWJO2Y/Lx9IZ28Bl6XSsD2FVM+sFMP6N6oY+w609cQHW/uQTX6P/B9U4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca2be4c-b4b0-47b1-2bcb-08d6bd8a016e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 07:56:14.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5911
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/04/10 16:48, Dan Carpenter wrote:=0A=
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
> higher 32 bits in "aligned_capacity" are always cleared to zero.  This=0A=
> patch adds a cast to u64 to address this issue.=0A=
> =0A=
> Fixes: 114e025968b5 ("dm zoned: ignore last smaller runt zone")=0A=
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>=0A=
> ---=0A=
> v2: In v1 I changed blk_queue_zone_sectors() to return a sector_t type,=
=0A=
> but in v2 I just add a cast.  The v2 fix would end up going through=0A=
> different maintainers and reviewers so the CC list has grown...=0A=
> =0A=
> Original discussion: https://marc.info/?l=3Dkernel-janitors&m=3D155487663=
405737&w=3D2=0A=
> =0A=
>  drivers/md/dm-zoned-target.c | 3 ++-=0A=
>  1 file changed, 2 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c=
=0A=
> index 8865c1709e16..b6cb44fa946d 100644=0A=
> --- a/drivers/md/dm-zoned-target.c=0A=
> +++ b/drivers/md/dm-zoned-target.c=0A=
> @@ -643,7 +643,8 @@ static int dmz_get_zoned_device(struct dm_target *ti,=
 char *path)=0A=
>  =0A=
>  	q =3D bdev_get_queue(dev->bdev);=0A=
>  	dev->capacity =3D i_size_read(dev->bdev->bd_inode) >> SECTOR_SHIFT;=0A=
> -	aligned_capacity =3D dev->capacity & ~(blk_queue_zone_sectors(q) - 1);=
=0A=
> +	aligned_capacity =3D dev->capacity &=0A=
> +				~((u64)blk_queue_zone_sectors(q) - 1);=0A=
=0A=
sector_t is an u64 only if CONFIG_LBDAF is defined (I think this option is =
going=0A=
away though). Otherwise it is an unsigned long which would be u32 on 32 bit=
s=0A=
arch. Not a problem in terms of arithmetic, but why not cast to sector_t di=
rectly ?=0A=
=0A=
>  	if (ti->begin ||=0A=
>  	    ((ti->len !=3D dev->capacity) && (ti->len !=3D aligned_capacity))) =
{=0A=
>  		ti->error =3D "Partial mapping not supported";=0A=
> =0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
