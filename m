Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28600C433E3
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16D820709
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c+IUOEMV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sa2gUwQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGTIJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:09:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44217 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTIJ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 04:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595232595; x=1626768595;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=E7hWGzWr24LRmDiFDkjFsVGbCB+DaT866mRGZ7QRYZw=;
  b=c+IUOEMVF5/KO+CN/LCgRI7ngpMb8BnuZ75Rb3Y07eJzRgt3No02vpbG
   y8ODjiQ+xZ3nBa+B7S3JmQPx2y8ku/8Cym9iR0yQe7ijdAFUC9nKfS7P9
   kQyKTw+bSvEmglgskrXUWIbDcgO3w1ubUj7mtcoOxhBp17S+ZKrjSLO44
   /cI/pYa/lba+gIz5cxW1FgJOTbRHTYZbtHuvEy319g5UxumQFOnelLLlY
   odL/drZxYw1WxKPIDLE79B88Q2avfbp7y7XyCdmlaTpu4dzhPtqtecxhu
   q7zRddgGaQ80yc3dpu0IJDYMsJ4OitPS5MG1yWjZUps6JnaSHiH7LJ1ib
   g==;
IronPort-SDR: ye/+FbEi7lgpi2fe1X65Oy/gA8iMgEi27TtChDOnm6C9raCyWN+EoEsh4ktJSOK+6gHQ0rPLIw
 93AY5fMUaPSNFuN+xcGqIGE+xHwXRnf1lSU1CPKI0S8uIQ/amau4Z6y9CYMkxUqCtUyBCIbDh4
 dMb/scIR3gzuecpnd53yLRsmZY03inwQsdv0pmI8oTkFx0R6HKT4dITl4bFdMIU6+wDKM+frf/
 ijsZhHPd44sF+nHi4Pjd4i5bQwL3ny4edZZu8bar4SWI9oi8/b38FTHHUYubTW9N4BS4VEFm7B
 wb4=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="142898114"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 16:09:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1SD5yUdOpaPw0UU56qmeZqPLTX/Zbgs/vCtXaww9VlR6IoZcUoByib+rquqeNWMycu1WGbPDbj6R1I4wBI2+NEwb1i4HbaYVHMVrJRbi84G9nOCevuXWUs6pAPVbpbvs7a9MZvrAlxue8+iREBvb6Nimy1OmIz1Ag5nojdqLEpo0pYHosx5siBRJromoJe43ZjN9KJNOXvJdLjuYiB5++XbCXsqD81W4NScWR9VEXdR2l/j0akvMnYEExUWn7bPzSi9UvEJ/PZbBynofrc+umJRijQ+Z7w5951SfuE3mrzTrABJQToDPQXqwHnwe5TWf3vsmhnMUmjr19oIaCmL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx3yHy/oVo0Dhqfemiv2ltHWkBIBXc6FE8G25/MU2qo=;
 b=PRmyQZInmV4Y4Jyxv+3Wdnv+x1+LGnIQLYvpdJQGhvp3e+i13onETZ4zC4eJop5+9bTbo7OX2hq7GcfrR56qFy0cWtUBkwh9FcmVD6yyxqrjSntkA1A/HPNa46yO3ILJPcoGJTszjbRtowi891HEhj1pGmgGO4ff5ks/DhtCZ3UyrlllpSrTz0uO/EXREjaoYcfR9Hg13O6tUgo5cRLzwRiFns29FetHYDIFIClhiJWfsPFjuqHVFDMkGPwN2VXRb9jw9GBZQoPv3Fc/75ydebE9G1Vmk7ZPsPI/cUU9QhI2hCVTgPA8T/q5125AY3RAu6GcSdkI8usq0aGWLjwZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx3yHy/oVo0Dhqfemiv2ltHWkBIBXc6FE8G25/MU2qo=;
 b=sa2gUwQhnKg8k/yHUKiXgvXZRgtoj1FUlsblGcAZFnjfviZwOVmpAFjjG2+ZJOsB/bNTKFsBoKSs6QB70K7iqZnjEv3c7k9jlyQM1bh57+F1blotG/bVvB4ZTgLUGnRARZPVWyAxxnpZlLbgVYeB0E2FgAKV5cIU13cn6jdyzEY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2220.namprd04.prod.outlook.com (2a01:111:e400:c60e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 08:09:53 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:09:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH 1/3] block: inherit the zoned characteristics in
 blk_stack_limits
Thread-Topic: [PATCH 1/3] block: inherit the zoned characteristics in
 blk_stack_limits
Thread-Index: AQHWXlzT/5z8bylnBUWWeTTqHXLFAg==
Date:   Mon, 20 Jul 2020 08:09:53 +0000
Message-ID: <CY4PR04MB37515CAD1C2FBE1F85574CAAE77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200720061251.652457-1-hch@lst.de>
 <20200720061251.652457-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08963483-03ac-4365-69eb-08d82c844853
x-ms-traffictypediagnostic: CY1PR04MB2220:
x-microsoft-antispam-prvs: <CY1PR04MB222053FAEE7AF2207BA538F6E77B0@CY1PR04MB2220.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z2W0Ogqe2SvztDFgmkyS5b0VOXZdcuD1GqpFvTmzSniTUgh6UF8Xhoq3qjxx39Xr78Y+pOeQaCyTUIdqr8MiwPeIombSJ87Hai1rwnqeLdNWIc2qaxa2IFZXOML/Ozk/FyB1lpmKRtbXVdx8pVExIGmnzD7Hy3hkCT/Ay6MqSORuJluPqWFONPYOT7hkOWEwfutE33aFW58LXRp807es/x/Zjo0/hOc7HLqgbxwkwa/TlvWKVNF2TlE0Tps2D3BTBntIvPd5U2nYcu9Mh6/kmjVAcjftmKv/GL5dAfEafOPWpAV87DhZhaoPqFcFHoqxXtoI8wbL7vcBYdMc6iPkmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(83380400001)(8676002)(7696005)(71200400001)(66946007)(316002)(55016002)(66476007)(2906002)(8936002)(478600001)(53546011)(6506007)(186003)(33656002)(86362001)(5660300002)(110136005)(52536014)(66446008)(64756008)(66556008)(4326008)(26005)(9686003)(76116006)(91956017)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SpyzHKoaKQKUt0ntFjbpjzovdlo57EsrN8iT9i9H0wiPe8fNkxPbSK2NQDsnT5pJics0+YkWki/KK3of/uFUe7jYo3Nbf18b2lv31gZNPQL6BO6KiU8+X81G8qDWhgRW9Keui5feKz1YTy5RPJGSMZT+3/82Gm2iGgoOhKwk0Oa2LaZxtuHBdjwWD95VVG/wIHN/Ae7mAtlk3nabvNrUERSar2YwlFnoyJJqE54q2LCV37mJymsl6hQ0aLMC+qzH24QxYlchrCgOcNZNSzBCLM6CP6CjFjpcFsTbQMKWcS1wRJWZXpU229E9gph1ppwP3L9c7IJ+aEUDyVJgXNCCm5RB5RF/53s29OVlJfvcQ0x6AhOJUDg6ojHE/XzDf1wOOcd4irIQSYzU0nrKj9zRjG08ARSowr+/NrD9rYzTSALicbiQ6XYI6Pw2vlrEbMPKKBd/Y40V0w8jTvfyvT7dHjI2VZSbRV2mFX9qwi9dzdjSRlO0ZtiowAXQqVtX2Imv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08963483-03ac-4365-69eb-08d82c844853
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:09:53.3256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VNG9wH6scBqFLWV8bCxf9/xoaqEUKNnqsYPf1ao9gEFuLmN1CrTdgiSLKspDhSA0vzIEQD8YxwFzYGaIU5Hvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2220
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/20 15:13, Christoph Hellwig wrote:=0A=
> Lift the code from device mapper into blk_stack_limits to inherity=0A=
> the stacking limitations.  This ensures we do the right thing for=0A=
> all stacked zoned block devices.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  block/blk-settings.c   |  1 +=0A=
>  drivers/md/dm-table.c  | 19 -------------------=0A=
>  include/linux/blkdev.h |  9 ++++++---=0A=
>  3 files changed, 7 insertions(+), 22 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 9a2c23cd970073..9cddbd73647405 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -609,6 +609,7 @@ int blk_stack_limits(struct queue_limits *t, struct q=
ueue_limits *b,=0A=
>  		t->chunk_sectors =3D min_not_zero(t->chunk_sectors,=0A=
>  						b->chunk_sectors);=0A=
>  =0A=
> +	t->zoned =3D max(t->zoned, b->zoned);=0A=
>  	return ret;=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_stack_limits);=0A=
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c=0A=
> index 0ea5b7367179ff..ec5364133cef7f 100644=0A=
> --- a/drivers/md/dm-table.c=0A=
> +++ b/drivers/md/dm-table.c=0A=
> @@ -467,9 +467,6 @@ static int dm_set_device_limits(struct dm_target *ti,=
 struct dm_dev *dev,=0A=
>  		       q->limits.logical_block_size,=0A=
>  		       q->limits.alignment_offset,=0A=
>  		       (unsigned long long) start << SECTOR_SHIFT);=0A=
> -=0A=
> -	limits->zoned =3D blk_queue_zoned_model(q);=0A=
> -=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> @@ -1528,22 +1525,6 @@ int dm_calculate_queue_limits(struct dm_table *tab=
le,=0A=
>  			       dm_device_name(table->md),=0A=
>  			       (unsigned long long) ti->begin,=0A=
>  			       (unsigned long long) ti->len);=0A=
> -=0A=
> -		/*=0A=
> -		 * FIXME: this should likely be moved to blk_stack_limits(), would=0A=
> -		 * also eliminate limits->zoned stacking hack in dm_set_device_limits(=
)=0A=
> -		 */=0A=
> -		if (limits->zoned =3D=3D BLK_ZONED_NONE && ti_limits.zoned !=3D BLK_ZO=
NED_NONE) {=0A=
> -			/*=0A=
> -			 * By default, the stacked limits zoned model is set to=0A=
> -			 * BLK_ZONED_NONE in blk_set_stacking_limits(). Update=0A=
> -			 * this model using the first target model reported=0A=
> -			 * that is not BLK_ZONED_NONE. This will be either the=0A=
> -			 * first target device zoned model or the model reported=0A=
> -			 * by the target .io_hints.=0A=
> -			 */=0A=
> -			limits->zoned =3D ti_limits.zoned;=0A=
> -		}=0A=
>  	}=0A=
>  =0A=
>  	/*=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 06995b96e94679..67b9ccc1da3560 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -306,11 +306,14 @@ enum blk_queue_state {=0A=
>  =0A=
>  /*=0A=
>   * Zoned block device models (zoned limit).=0A=
> + *=0A=
> + * Note: This needs to be ordered from the least to the most severe=0A=
> + * restrictions for the inheritance in blk_stack_limits() to work.=0A=
>   */=0A=
>  enum blk_zoned_model {=0A=
> -	BLK_ZONED_NONE,	/* Regular block device */=0A=
> -	BLK_ZONED_HA,	/* Host-aware zoned block device */=0A=
> -	BLK_ZONED_HM,	/* Host-managed zoned block device */=0A=
> +	BLK_ZONED_NONE =3D 0,	/* Regular block device */=0A=
> +	BLK_ZONED_HA,		/* Host-aware zoned block device */=0A=
> +	BLK_ZONED_HM,		/* Host-managed zoned block device */=0A=
>  };=0A=
>  =0A=
>  struct queue_limits {=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
