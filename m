Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194C0C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA28B204FD
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R8JOlQuZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c5tajRur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfDJIOh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:14:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24036 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfDJIOg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 04:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554884077; x=1586420077;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G2jElJOZfyFLvKNco3d0kYTjmqiC54i1dFEbi6nG2pY=;
  b=R8JOlQuZcdkuCIKP27VkWZzVtEpwRxVHR4g+wWAXNoI7ExNsceAr3+/L
   +U2hJJNbJ+2kriKOTmgpVGZ0Kgmta2xwlDM5eEHyfLaf0Bd4xDc7tCMET
   pmk4IoM4yBSI8qo4+TwjfqonizWFdZNDlndX9dLv5JFhBeivhQ7kjkSEV
   X/KoXRxvhTPY1ixoXwPuUocaYdEApzr8FOx1kHZjohV7u/2Wc7Io1WJl9
   zSfV1ATQxO5Q4U+m5lbzvQxdBqMhXpoBTD+rD9aLppavKHKHV6lrGni0y
   AehlpfzAxA54400SdtoskRYP7S2DcyTy632H+Hy7c+XNXl/+zdYM4wCZi
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,332,1549900800"; 
   d="scan'208";a="110465852"
Received: from mail-dm3nam05lp2053.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.53])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2019 16:14:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lIqLI/DVitg1S5kqbJ248Cy3u2sA757cKd8OqZR6rQ=;
 b=c5tajRurR0btbva+49+Lj3A7qh+wd8QSUokLJoGUPXQJYdaNFx1Ysoq25iBRnHLl0bKCi3f6K5AQ8bmCwQO/qmqGZawgvA+K5O8+Hc4mQV1d9BJPDG5Zld56RRaL6tUhFMYrFPT1YikDCnhkkm97PRGVFvs/rxBII1u5kx49MEs=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4424.namprd04.prod.outlook.com (20.176.252.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 08:14:32 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::ec3e:1844:ecb1:6637]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::ec3e:1844:ecb1:6637%5]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 08:14:32 +0000
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
Subject: Re: [PATCH v3] dm zoned: Silence a static checker warning
Thread-Topic: [PATCH v3] dm zoned: Silence a static checker warning
Thread-Index: AQHU73U2dRjJHQuw8UiU6PKHQBhQFQ==
Date:   Wed, 10 Apr 2019 08:14:32 +0000
Message-ID: <BYAPR04MB581696AA3EF70BE5328A9C95E72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190410081231.GA31089@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb5877b0-7f67-4a25-f914-08d6bd8c8fba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4424;
x-ms-traffictypediagnostic: BYAPR04MB4424:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4424F6D5B97B84BAB412219DE72E0@BYAPR04MB4424.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(366004)(136003)(346002)(189003)(199004)(486006)(102836004)(110136005)(68736007)(74316002)(86362001)(6506007)(72206003)(53546011)(97736004)(14454004)(478600001)(6436002)(186003)(105586002)(76176011)(476003)(26005)(446003)(55016002)(9686003)(2906002)(7696005)(256004)(106356001)(52536014)(66066001)(99286004)(229853002)(4326008)(8936002)(25786009)(3846002)(14444005)(54906003)(5660300002)(53936002)(7736002)(305945005)(81156014)(81166006)(316002)(8676002)(71200400001)(6116002)(71190400001)(33656002)(7416002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4424;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1NA3YnNAQOGJPheFCvcLznXiL8akZ3o7xWWD+oemQIVP6YHlYQlPJRh7HU63RHMHScoKeLVwFK8KZUitN97r07poTOt0/FGsLB5b4m9SYsHJyHOrF5Zu0YL9qWNyElIEl0WU9rLIdiJ7BL/QjSrt1vkK2wSr9O2omddNMGGEzwua+kA6AOjomUFsKv5yskUsfIabsA442g/d78Uc9g3saH7gFkZJ1/VHHMcagYTURWW1GMOEkXakc8fSnXGg1GxY+phHt8VPgO37SftbuI8YRiBE63F81m41wOaaycz5/D+/rB9vKzr4knxG22ebnuQ0hJnEpKJep/V724E9/JWzCp4G8WU+AEuYCRpGrojNH4viY/d9k0KvXBmjFmdJgX++0qSM6zPj3h95xxkE0ojKipKQQUCIgvxn0UiXUkbjspE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5877b0-7f67-4a25-f914-08d6bd8c8fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 08:14:32.2039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/04/10 17:13, Dan Carpenter wrote:=0A=
> My static checker complains about this line from dmz_get_zoned_device()=
=0A=
> =0A=
> 	aligned_capacity =3D dev->capacity & ~(blk_queue_zone_sectors(q) - 1);=
=0A=
> =0A=
> The problem is that "aligned_capacity" and "dev->capacity" are sector_t=
=0A=
> type (which is a u64 under most configs) but blk_queue_zone_sectors(q)=0A=
> returns a u32 so the higher 32 bits in aligned_capacity are cleared to=0A=
> zero.  This patch adds a cast to address the issue.=0A=
> =0A=
> Fixes: 114e025968b5 ("dm zoned: ignore last smaller runt zone")=0A=
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>=0A=
> ---=0A=
> v2: The v1 patch declared blk_queue_zone_sectors() as sector_t but the=0A=
>     v2 cast added a cast to u64.=0A=
> v3: Cast it to sector_t instead=0A=
> =0A=
>  drivers/md/dm-zoned-target.c | 3 ++-=0A=
>  1 file changed, 2 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c=
=0A=
> index 8865c1709e16..51d029bbb740 100644=0A=
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
> +				~((sector_t)blk_queue_zone_sectors(q) - 1);=0A=
>  	if (ti->begin ||=0A=
>  	    ((ti->len !=3D dev->capacity) && (ti->len !=3D aligned_capacity))) =
{=0A=
>  		ti->error =3D "Partial mapping not supported";=0A=
> =0A=
=0A=
Thanks for fixing this !=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
