Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA629C433DF
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 22:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682102075F
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 22:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TEh3qM15";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fFrqyNXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHYWwr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:52:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1897 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHYWwq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 18:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598395972; x=1629931972;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BQ6wV4WxG12kX1hZO4lrjBcp58Fx8G+xzcu2ap7mos4=;
  b=TEh3qM15eJFv871oFXJYnLG8r1Fvog/e5OJ+9njAx/ezsAAIquqpeg+g
   m4EKaCgs/thhPYi5ANlPOyGkXGUVtTEmBrE4/QciGOnAYuhh0ztAl3cS7
   gkiKpCKuJlDOmfobU2d4yn1zFTe3kmO1y3z3fG35pZDfyZ2TsBfe9yoL9
   i9KBK/6mrcPe/CrtmYrrWwW128J4KATSCNdC+5ORnstMnKXzMkZnQvMLZ
   nO4XKY/2VI0xgQ00FemhwRfxIXYIoYAsO1C16Naxe/AiPSpJfCZpEvV2Q
   21aBOFLFTSh/tulJ8sTjQLoWywX4TLcmaDXOfZlS2339OPs7Til3/zOKT
   g==;
IronPort-SDR: H+0R6/f/wBxRlbUoqFvOWxKhN8VKwfF2Ji1mr1Ci68RXINQE9OdGW7PfTSF4+EFPn4LgM7d4Cp
 ACUBwevZljzeFh2/O6kedO3U55lVQelDnVqmYeZwyWFULTFmUTr/0vVqJ3aL/3fwDhMmPSwznL
 /rhmitpY9MtjbmzkIxLeCmbZt515hFJ72hNixyrD2yuqYkmSjOaDc88lH7OJRNGa7e8kR3oHiI
 yy3WtXH6znFSz/U4N2G/oxvyt6Pn2S4I42oTSdbWOURRu0bktGbAXVf2oAqp8+FbZLYu4v+x7k
 PHo=
X-IronPort-AV: E=Sophos;i="5.76,354,1592841600"; 
   d="scan'208";a="249055056"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 06:52:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvoOLJV5vZdBgwRLYZ3X3wcV0d/28PVZmwwB/+I6/QRuL3saW6OMhMe+8vblK/AETROoJsURSHQo0FDLNMZoPG3XbTygrLfuO9UVJkYIliqWF9LcTLfLXOFjH2u0xorJFO51p0PFW0ZFljfapATQrsz4wrTarT2N3rqHH/6tbwvy1eAsjQRGbmSNryaptF/dXSU3SA3pn9Jywa5XZqNBNR45y5suequAzMxplFIyNnhFyDzTfklQ/Zrp8FJ6NFR/1ldQJ8DaKIesx/oJrD8QjfzcYvUS7wZ6N0s1DL+FdfGuWFGB96LUAvqjMridVbOBR7RvCoVJmeENY2Ps4OCN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5M6aQ9jtKsdX3K02PMjQpMBaHzWZ3ikTpS8vee8AlI=;
 b=Y4SfoxMAJMdydUGpTVgIpxZ5JvRXZJPoPODdjpPaZKZArxxpmtFmUP2ex0Wx30N32stiIamV4XdWdq1dc2wdNTzyHekQtmneuqgXvempU/UCbvmcbpIZOJptbDsArX53ErVZeiWUpIHngF0tiQDrQMJuf7u6MwkLEv05YO35ooN++yhIZiHWjLUr9i3GcLDTbH9uvfR0qZLzkoU6bY7Eh7BvnZ4PCueqHxdEYoSCrVqHtwFsZrbbdscrDHTV9Bg37F40fugl5ta+Ja1SKxXpo+LBhMzGmQ/1RBBwsKmzijWchgy9ZmzUv3oSU0T8YieVhN9mvT736ZKiFY9mWDxuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5M6aQ9jtKsdX3K02PMjQpMBaHzWZ3ikTpS8vee8AlI=;
 b=fFrqyNXej5QLPtFvCucrjjpjkIu1mRwjVdGLHaR/Ys6/FuzeRjT6+yXawaVi38w/XgMd/SF7GT5UORhVUAKNOoPfCuPGP5yLMmRi0W2OOyTGvXjAALU2QRYlBzTNRvtIchtI5+2y91kxZVuhX4Fn5utuHXi7bXpRKSH8zt/KfHE=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0425.namprd04.prod.outlook.com (2603:10b6:903:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 22:52:42 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3305.026; Tue, 25 Aug
 2020 22:52:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>, Jens Axboe <axboe@kernel.dk>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] null_blk: add support for max open/active zone limit for
 zoned devices
Thread-Topic: [PATCH] null_blk: add support for max open/active zone limit for
 zoned devices
Thread-Index: AQHWetp3ECXvSpsXkEe3PPbQhU57tw==
Date:   Tue, 25 Aug 2020 22:52:41 +0000
Message-ID: <CY4PR04MB37518DF84867B6E8573A13B0E7570@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200825122244.126129-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:95f6:21b7:9982:4fac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e31590e8-5d8c-431c-bc13-08d8494992f4
x-ms-traffictypediagnostic: CY4PR04MB0425:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0425569D8FFE4A1CAB09DC8FE7570@CY4PR04MB0425.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1jjnFiCoWe6hH05CGI/HTLlraoX8FyW28QXR4beQ58WxFCyFwhhWQKeooYyfAS7HV+2p2ozKc0cHGJ75h3Ts4JlAfcY1cAmdkeGLrnuAuWHzvBiX/khHo46KzAGlb1Vqg73WD0FBKaQFJLY+DTQ+rlfo0mNpE96sTjlni7Gv4lvpv8UUiT+gLCa1vwksBoaN5JWTWtQbcnAW+Hx9P0q2H2jLcHLhXAKTyr2y8kv9oLkN0f38yBLg0Rse6xBABFQgao3b+wyuIimpO4ntL67Uyf3xPwEkO8LFLvXjGKD6XrcqE2oRTrg01An2k/KiHorDY47+x47WmH6XV4LIYHiW4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(66446008)(91956017)(9686003)(55016002)(66476007)(66556008)(64756008)(66946007)(76116006)(53546011)(2906002)(4326008)(83380400001)(54906003)(6506007)(110136005)(316002)(7696005)(8936002)(71200400001)(33656002)(478600001)(86362001)(52536014)(30864003)(5660300002)(8676002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: S6AV8GlcIyN8vi4FGiqISq1k9byFvWuGRVAm+ujdJhJQzZfziQAfUSa+FGb4ZXeW2ZlujNHmoUu+TYmXNcaSmSMmADY5EMBzaw6ASe0ly5vJ8mrvEiAA2uD3ilenj8Lx/3BPj6jmRGb295zEZwtjsuVHPMJTesm2u74cuLx9wWeN7oq7Yce+N7IehcselosYXCBIKek17pOycgSvKrqrASCj3pxc0b8VeCbHESWOXBofdbF5UA2kFHHDZVa9jb0MOtnGt2l43LbscrCvBy2GOQU8sGHLbStPzZEyh7YRWv1aaKZPpU84BoUeDwenTFqkOpNWZBYxIOIPNueGOeba10UDCSwWvtRsjmKdbm/Qa1QUyBNGs+GeruPZBOO22+IZF8WnZ65E7NnPJvOKLE6LkJcpZqV6CyXKEhsSFVBm8VHdzib7frJ9xDaJLIq3kc/uvDXqi3A5VEkoJQybYBF8iKWcP1Q1UcFoWuuT8r+ykxpXElMsidN53Wr8w8Oe/6mxWql8ME8Gbmqv4QzqZsoyvN8uTrlKs8l8FLSrawEkUTIdJpCMpG6EwrcnONmytcat/2uM548B0wr1IuZwbCO4eX/CVER6+n4RuGvWsPygsNLxta440aguxJUZgS+IYACmSXakNrOwDtgpvEIbeurmRAePpEZBVWyKIvJV8SumgkhQCIIYeqV/QfkOQR5yu+UVk4gEs3ithYYyPRF7lUI4mg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31590e8-5d8c-431c-bc13-08d8494992f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 22:52:41.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxTyO8OpnciB/x6MekCj8xljqZL+7LQJiVB7bIbN3EINKF//sVHNn+rF96ju4HXsJOiNMDJR5VPkKOyI4/3dpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0425
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/08/25 21:22, Niklas Cassel wrote:=0A=
> Add support for user space to set a max open zone and a max active zone=
=0A=
> limit via configfs. By default, the default value is 0 =3D=3D no limit.=
=0A=
=0A=
s/value is/values are/=0A=
=0A=
> =0A=
> Call the block layer API functions used for exposing the configured=0A=
> limits to sysfs.=0A=
> =0A=
> Add accounting in null_blk_zoned so that these new limits are respected.=
=0A=
> Performing an operating that would exceed these limits results is a=0A=
=0A=
s/is a/in a/=0A=
=0A=
> standard I/O error.=0A=
> =0A=
> A max open zone limit exists in the ZBC standard.=0A=
> While null_blk_zoned is used to test the Zoned Block Device model in=0A=
> Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned=
=0A=
> mostly follows ZBC.=0A=
> =0A=
> Therefore, implement the manage open zone resources function from ZBC,=0A=
> but additionally add support for max active zones.=0A=
> This enables user space not only to test against a device with an open=0A=
> zone limit, but also to test against a device with an active zone limit.=
=0A=
> =0A=
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>=0A=
> ---=0A=
>  drivers/block/null_blk.h       |   5 +=0A=
>  drivers/block/null_blk_main.c  |  16 +-=0A=
>  drivers/block/null_blk_zoned.c | 316 +++++++++++++++++++++++++++------=
=0A=
>  3 files changed, 283 insertions(+), 54 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h=0A=
> index daed4a9c34367..d2e7db43a52a7 100644=0A=
> --- a/drivers/block/null_blk.h=0A=
> +++ b/drivers/block/null_blk.h=0A=
> @@ -42,6 +42,9 @@ struct nullb_device {=0A=
>  	struct badblocks badblocks;=0A=
>  =0A=
>  	unsigned int nr_zones;=0A=
> +	unsigned int nr_zones_imp_open;=0A=
> +	unsigned int nr_zones_exp_open;=0A=
> +	unsigned int nr_zones_closed;=0A=
>  	struct blk_zone *zones;=0A=
>  	sector_t zone_size_sects;=0A=
>  =0A=
> @@ -51,6 +54,8 @@ struct nullb_device {=0A=
>  	unsigned long zone_size; /* zone size in MB if device is zoned */=0A=
>  	unsigned long zone_capacity; /* zone capacity in MB if device is zoned =
*/=0A=
>  	unsigned int zone_nr_conv; /* number of conventional zones */=0A=
> +	unsigned int zone_max_open; /* max number of open zones */=0A=
> +	unsigned int zone_max_active; /* max number of active zones */=0A=
>  	unsigned int submit_queues; /* number of submission queues */=0A=
>  	unsigned int home_node; /* home node for the device */=0A=
>  	unsigned int queue_mode; /* block interface */=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index d74443a9c8fa2..53161a418611b 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -208,6 +208,14 @@ static unsigned int g_zone_nr_conv;=0A=
>  module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);=0A=
>  MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block =
device is zoned. Default: 0");=0A=
>  =0A=
> +static unsigned int g_zone_max_open;=0A=
> +module_param_named(zone_max_open, g_zone_max_open, uint, 0444);=0A=
> +MODULE_PARM_DESC(zone_max_open, "Maximum number of open zones when block=
 device is zoned. Default: 0 (no limit)");=0A=
> +=0A=
> +static unsigned int g_zone_max_active;=0A=
> +module_param_named(zone_max_active, g_zone_max_active, uint, 0444);=0A=
> +MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when b=
lock device is zoned. Default: 0 (no limit)");=0A=
> +=0A=
>  static struct nullb_device *null_alloc_dev(void);=0A=
>  static void null_free_dev(struct nullb_device *dev);=0A=
>  static void null_del_dev(struct nullb *nullb);=0A=
> @@ -347,6 +355,8 @@ NULLB_DEVICE_ATTR(zoned, bool, NULL);=0A=
>  NULLB_DEVICE_ATTR(zone_size, ulong, NULL);=0A=
>  NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);=0A=
>  NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);=0A=
> +NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);=0A=
> +NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);=0A=
>  =0A=
>  static ssize_t nullb_device_power_show(struct config_item *item, char *p=
age)=0A=
>  {=0A=
> @@ -464,6 +474,8 @@ static struct configfs_attribute *nullb_device_attrs[=
] =3D {=0A=
>  	&nullb_device_attr_zone_size,=0A=
>  	&nullb_device_attr_zone_capacity,=0A=
>  	&nullb_device_attr_zone_nr_conv,=0A=
> +	&nullb_device_attr_zone_max_open,=0A=
> +	&nullb_device_attr_zone_max_active,=0A=
>  	NULL,=0A=
>  };=0A=
>  =0A=
> @@ -517,7 +529,7 @@ nullb_group_drop_item(struct config_group *group, str=
uct config_item *item)=0A=
>  static ssize_t memb_group_features_show(struct config_item *item, char *=
page)=0A=
>  {=0A=
>  	return snprintf(page, PAGE_SIZE,=0A=
> -			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone=
_capacity,zone_nr_conv\n");=0A=
> +			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone=
_capacity,zone_nr_conv,zone_max_open,zone_max_active\n");=0A=
>  }=0A=
>  =0A=
>  CONFIGFS_ATTR_RO(memb_group_, features);=0A=
> @@ -580,6 +592,8 @@ static struct nullb_device *null_alloc_dev(void)=0A=
>  	dev->zone_size =3D g_zone_size;=0A=
>  	dev->zone_capacity =3D g_zone_capacity;=0A=
>  	dev->zone_nr_conv =3D g_zone_nr_conv;=0A=
> +	dev->zone_max_open =3D g_zone_max_open;=0A=
> +	dev->zone_max_active =3D g_zone_max_active;=0A=
>  	return dev;=0A=
>  }=0A=
>  =0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index 3d25c9ad23831..5fb38c9bdd4ae 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -51,6 +51,24 @@ int null_init_zoned_dev(struct nullb_device *dev, stru=
ct request_queue *q)=0A=
>  			dev->zone_nr_conv);=0A=
>  	}=0A=
>  =0A=
> +	/* Max active zones has to be <=3D number of sequential zones */=0A=
> +	if (dev->zone_max_active > dev->nr_zones - dev->zone_nr_conv) {=0A=
> +		dev->zone_max_active =3D dev->nr_zones - dev->zone_nr_conv;=0A=
> +		pr_info("changed the maximum number of active zones to %u\n",=0A=
> +			dev->nr_zones);=0A=
> +	}=0A=
=0A=
if dev->zone_max_active =3D=3D dev->nr_zones - dev->zone_nr_conv, you could=
 also=0A=
change dev->zone_max_active to 0, since that is equivalent. Not a blocker=
=0A=
though, I think.=0A=
=0A=
> +=0A=
> +	/* Max open zones has to be <=3D max active zones */=0A=
> +	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active) =
{=0A=
> +		dev->zone_max_open =3D dev->zone_max_active;=0A=
> +		pr_info("changed the maximum number of open zones to %u\n",=0A=
> +			dev->nr_zones);=0A=
> +	} else if (dev->zone_max_open > dev->nr_zones - dev->zone_nr_conv) {=0A=
> +		dev->zone_max_open =3D dev->nr_zones - dev->zone_nr_conv;=0A=
> +		pr_info("changed the maximum number of open zones to %u\n",=0A=
> +			dev->nr_zones);=0A=
> +	}=0A=
=0A=
And same here for zone_max_open.=0A=
=0A=
> +=0A=
>  	for (i =3D 0; i <  dev->zone_nr_conv; i++) {=0A=
>  		struct blk_zone *zone =3D &dev->zones[i];=0A=
>  =0A=
> @@ -99,6 +117,8 @@ int null_register_zoned_dev(struct nullb *nullb)=0A=
>  	}=0A=
>  =0A=
>  	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);=0A=
> +	blk_queue_max_open_zones(q, dev->zone_max_open);=0A=
> +	blk_queue_max_active_zones(q, dev->zone_max_active);=0A=
>  =0A=
>  	return 0;=0A=
>  }=0A=
> @@ -159,6 +179,99 @@ size_t null_zone_valid_read_len(struct nullb *nullb,=
=0A=
>  	return (zone->wp - sector) << SECTOR_SHIFT;=0A=
>  }=0A=
>  =0A=
> +static blk_status_t null_close_zone(struct nullb_device *dev, struct blk=
_zone *zone)=0A=
> +{=0A=
> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> +		return BLK_STS_IOERR;=0A=
> +=0A=
> +	switch (zone->cond) {=0A=
> +	case BLK_ZONE_COND_CLOSED:=0A=
> +		/* close operation on closed is not an error */=0A=
> +		return BLK_STS_OK;=0A=
> +	case BLK_ZONE_COND_IMP_OPEN:=0A=
> +		dev->nr_zones_imp_open--;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
> +		dev->nr_zones_exp_open--;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_EMPTY:=0A=
> +	case BLK_ZONE_COND_FULL:=0A=
> +	default:=0A=
> +		return BLK_STS_IOERR;=0A=
> +	}=0A=
> +=0A=
> +	if (zone->wp =3D=3D zone->start) {=0A=
> +		zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
> +	} else {=0A=
> +		zone->cond =3D BLK_ZONE_COND_CLOSED;=0A=
> +		dev->nr_zones_closed++;=0A=
> +	}=0A=
> +=0A=
> +	return BLK_STS_OK;=0A=
> +}=0A=
> +=0A=
> +static void null_close_first_imp_zone(struct nullb_device *dev)=0A=
> +{=0A=
> +	unsigned int i;=0A=
> +=0A=
> +	for (i =3D 0; i < dev->nr_zones; i++) {=0A=
=0A=
You can start the loop from dev->nr_conv_zones, that will avoid the first i=
f below.=0A=
=0A=
> +		if (dev->zones[i].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> +			continue;=0A=
> +		if (dev->zones[i].cond =3D=3D BLK_ZONE_COND_IMP_OPEN) {=0A=
> +			null_close_zone(dev, &dev->zones[i]);=0A=
> +			return;=0A=
> +		}=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static bool null_room_in_active(struct nullb_device *dev)=0A=
=0A=
The name is a little strange. What about null_can_set_active() ?=0A=
=0A=
> +{=0A=
> +	if (!dev->zone_max_active)=0A=
> +		return true;=0A=
> +=0A=
> +	return dev->nr_zones_exp_open + dev->nr_zones_imp_open +=0A=
> +	       dev->nr_zones_closed < dev->zone_max_active;=0A=
> +}=0A=
> +=0A=
> +static bool null_room_in_open(struct nullb_device *dev)=0A=
=0A=
Same here: null_can_open() ?=0A=
=0A=
> +{=0A=
> +	if (!dev->zone_max_open)=0A=
> +		return true;=0A=
> +=0A=
> +	return dev->nr_zones_exp_open + dev->nr_zones_imp_open < dev->zone_max_=
open;=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * This function matches the manage open zone resources function in the =
ZBC standard,=0A=
> + * with the addition of max active zones support (added in the ZNS stand=
ard).=0A=
> + *=0A=
> + * ZBC states that an implicitly open zone shall be closed only if there=
 is not=0A=
> + * room within the open limit. However, if an active limit is set, it is=
 not certain=0A=
> + * that an implicitly opened zone can be closed without exceeding the ac=
tive limit.=0A=
=0A=
Hu... imp open and close both being an active state, closing an imp open zo=
ne=0A=
will never result in exceeding the max active limit. Did you mean something=
 like=0A=
"closing an imp open zone to open another one" ? or something else ? This n=
eeds=0A=
clarification as the function name does not really tell us what this is try=
ing=0A=
to do. It looks like this is checking if a zone can be open... So why not m=
erge=0A=
that into null_room_in_open(), renamed null_can_open() ?=0A=
=0A=
> + */=0A=
> +static bool null_manage_zone_resources(struct nullb_device *dev, struct =
blk_zone *zone)=0A=
> +{=0A=
> +	switch (zone->cond) {=0A=
> +	case BLK_ZONE_COND_EMPTY:=0A=
> +		if (!null_room_in_active(dev))=0A=
> +			return false;=0A=
> +		fallthrough;=0A=
> +	case BLK_ZONE_COND_CLOSED:=0A=
> +		if (null_room_in_open(dev)) {=0A=
> +			return true;=0A=
> +		} else if (dev->nr_zones_imp_open && null_room_in_active(dev)) {=0A=
> +			null_close_first_imp_zone(dev);=0A=
> +			return true;=0A=
> +		} else {=0A=
=0A=
else is not needed here.=0A=
=0A=
> +			return false;=0A=
> +		}=0A=
> +	default:=0A=
> +		/* Should never be called for other states */=0A=
> +		WARN_ON(1);=0A=
> +		return false;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
>  static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sect=
or,=0A=
>  				    unsigned int nr_sectors, bool append)=0A=
>  {=0A=
> @@ -177,43 +290,155 @@ static blk_status_t null_zone_write(struct nullb_c=
md *cmd, sector_t sector,=0A=
>  		/* Cannot write to a full zone */=0A=
>  		return BLK_STS_IOERR;=0A=
>  	case BLK_ZONE_COND_EMPTY:=0A=
> +	case BLK_ZONE_COND_CLOSED:=0A=
> +		if (!null_manage_zone_resources(dev, zone))=0A=
> +			return BLK_STS_IOERR;=0A=
> +		break;=0A=
>  	case BLK_ZONE_COND_IMP_OPEN:=0A=
>  	case BLK_ZONE_COND_EXP_OPEN:=0A=
> +		break;=0A=
> +	default:=0A=
> +		/* Invalid zone condition */=0A=
> +		return BLK_STS_IOERR;=0A=
> +	}=0A=
> +=0A=
> +	/*=0A=
> +	 * Regular writes must be at the write pointer position.=0A=
> +	 * Zone append writes are automatically issued at the write=0A=
> +	 * pointer and the position returned using the request or BIO=0A=
> +	 * sector.=0A=
> +	 */=0A=
> +	if (append) {=0A=
> +		sector =3D zone->wp;=0A=
> +		if (cmd->bio)=0A=
> +			cmd->bio->bi_iter.bi_sector =3D sector;=0A=
> +		else=0A=
> +			cmd->rq->__sector =3D sector;=0A=
> +	} else if (sector !=3D zone->wp) {=0A=
> +		return BLK_STS_IOERR;=0A=
> +	}=0A=
> +=0A=
> +	if (zone->wp + nr_sectors > zone->start + zone->capacity)=0A=
> +		return BLK_STS_IOERR;=0A=
> +=0A=
> +	if (zone->cond =3D=3D BLK_ZONE_COND_CLOSED) {=0A=
> +		dev->nr_zones_closed--;=0A=
> +		dev->nr_zones_imp_open++;=0A=
> +	} else if (zone->cond =3D=3D BLK_ZONE_COND_EMPTY) {=0A=
> +		dev->nr_zones_imp_open++;=0A=
> +	}=0A=
> +	if (zone->cond !=3D BLK_ZONE_COND_EXP_OPEN)=0A=
> +		zone->cond =3D BLK_ZONE_COND_IMP_OPEN;=0A=
> +=0A=
> +	ret =3D null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);=0A=
> +	if (ret !=3D BLK_STS_OK)=0A=
> +		return ret;=0A=
> +=0A=
> +	zone->wp +=3D nr_sectors;=0A=
> +	if (zone->wp =3D=3D zone->start + zone->capacity) {=0A=
> +		if (zone->cond =3D=3D BLK_ZONE_COND_EXP_OPEN)=0A=
> +			dev->nr_zones_exp_open--;=0A=
> +		else if (zone->cond =3D=3D BLK_ZONE_COND_IMP_OPEN)=0A=
> +			dev->nr_zones_imp_open--;=0A=
> +		zone->cond =3D BLK_ZONE_COND_FULL;=0A=
> +	}=0A=
> +	return BLK_STS_OK;=0A=
> +}=0A=
> +=0A=
> +static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_=
zone *zone)=0A=
> +{=0A=
> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> +		return BLK_STS_IOERR;=0A=
> +=0A=
> +	switch (zone->cond) {=0A=
> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
> +		/* open operation on exp open is not an error */=0A=
> +		return BLK_STS_OK;=0A=
> +	case BLK_ZONE_COND_EMPTY:=0A=
> +		if (!null_manage_zone_resources(dev, zone))=0A=
> +			return BLK_STS_IOERR;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_IMP_OPEN:=0A=
> +		dev->nr_zones_imp_open--;=0A=
> +		break;=0A=
>  	case BLK_ZONE_COND_CLOSED:=0A=
> -		/*=0A=
> -		 * Regular writes must be at the write pointer position.=0A=
> -		 * Zone append writes are automatically issued at the write=0A=
> -		 * pointer and the position returned using the request or BIO=0A=
> -		 * sector.=0A=
> -		 */=0A=
> -		if (append) {=0A=
> -			sector =3D zone->wp;=0A=
> -			if (cmd->bio)=0A=
> -				cmd->bio->bi_iter.bi_sector =3D sector;=0A=
> -			else=0A=
> -				cmd->rq->__sector =3D sector;=0A=
> -		} else if (sector !=3D zone->wp) {=0A=
> +		if (!null_manage_zone_resources(dev, zone))=0A=
>  			return BLK_STS_IOERR;=0A=
> -		}=0A=
> +		dev->nr_zones_closed--;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_FULL:=0A=
> +	default:=0A=
> +		return BLK_STS_IOERR;=0A=
> +	}=0A=
> +=0A=
> +	zone->cond =3D BLK_ZONE_COND_EXP_OPEN;=0A=
> +	dev->nr_zones_exp_open++;=0A=
> +=0A=
> +	return BLK_STS_OK;=0A=
> +}=0A=
> +=0A=
> +static blk_status_t null_finish_zone(struct nullb_device *dev, struct bl=
k_zone *zone)=0A=
> +{=0A=
> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> +		return BLK_STS_IOERR;=0A=
>  =0A=
> -		if (zone->wp + nr_sectors > zone->start + zone->capacity)=0A=
> +	switch (zone->cond) {=0A=
> +	case BLK_ZONE_COND_FULL:=0A=
> +		/* finish operation on full is not an error */=0A=
> +		return BLK_STS_OK;=0A=
> +	case BLK_ZONE_COND_EMPTY:=0A=
> +		if (!null_manage_zone_resources(dev, zone))=0A=
> +			return BLK_STS_IOERR;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_IMP_OPEN:=0A=
> +		dev->nr_zones_imp_open--;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
> +		dev->nr_zones_exp_open--;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_CLOSED:=0A=
> +		if (!null_manage_zone_resources(dev, zone))=0A=
>  			return BLK_STS_IOERR;=0A=
> +		dev->nr_zones_closed--;=0A=
> +		break;=0A=
> +	default:=0A=
> +		return BLK_STS_IOERR;=0A=
> +	}=0A=
>  =0A=
> -		if (zone->cond !=3D BLK_ZONE_COND_EXP_OPEN)=0A=
> -			zone->cond =3D BLK_ZONE_COND_IMP_OPEN;=0A=
> +	zone->cond =3D BLK_ZONE_COND_FULL;=0A=
> +	zone->wp =3D zone->len;=0A=
=0A=
zone->wp =3D zone=3D>start + zone->len;=0A=
=0A=
>  =0A=
> -		ret =3D null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);=0A=
> -		if (ret !=3D BLK_STS_OK)=0A=
> -			return ret;=0A=
> +	return BLK_STS_OK;=0A=
> +}=0A=
> +=0A=
> +static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk=
_zone *zone)=0A=
> +{=0A=
> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> +		return BLK_STS_IOERR;=0A=
>  =0A=
> -		zone->wp +=3D nr_sectors;=0A=
> -		if (zone->wp =3D=3D zone->start + zone->capacity)=0A=
> -			zone->cond =3D BLK_ZONE_COND_FULL;=0A=
> +	switch (zone->cond) {=0A=
> +	case BLK_ZONE_COND_EMPTY:=0A=
> +		/* reset operation on empty is not an error */=0A=
>  		return BLK_STS_OK;=0A=
> +	case BLK_ZONE_COND_IMP_OPEN:=0A=
> +		dev->nr_zones_imp_open--;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
> +		dev->nr_zones_exp_open--;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_CLOSED:=0A=
> +		dev->nr_zones_closed--;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_FULL:=0A=
> +		break;=0A=
>  	default:=0A=
> -		/* Invalid zone condition */=0A=
>  		return BLK_STS_IOERR;=0A=
>  	}=0A=
> +=0A=
> +	zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
> +	zone->wp =3D zone->start;=0A=
> +=0A=
> +	return BLK_STS_OK;=0A=
>  }=0A=
>  =0A=
>  static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf o=
p,=0A=
> @@ -222,49 +447,34 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd=
 *cmd, enum req_opf op,=0A=
>  	struct nullb_device *dev =3D cmd->nq->dev;=0A=
>  	unsigned int zone_no =3D null_zone_no(dev, sector);=0A=
>  	struct blk_zone *zone =3D &dev->zones[zone_no];=0A=
> +	blk_status_t ret;=0A=
>  	size_t i;=0A=
>  =0A=
>  	switch (op) {=0A=
>  	case REQ_OP_ZONE_RESET_ALL:=0A=
>  		for (i =3D 0; i < dev->nr_zones; i++) {=0A=
> -			if (zone[i].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -				continue;=0A=
> -			zone[i].cond =3D BLK_ZONE_COND_EMPTY;=0A=
> -			zone[i].wp =3D zone[i].start;=0A=
> +			null_reset_zone(dev, &dev->zones[i]);=0A=
>  		}=0A=
=0A=
You can drop the curly brackets too, and start the loop from nr_conv_zones =
too.=0A=
=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -=0A=
> -		zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
> -		zone->wp =3D zone->start;=0A=
> +		ret =3D null_reset_zone(dev, zone);=0A=
> +		if (ret !=3D BLK_STS_OK)=0A=
> +			return ret;=0A=
=0A=
You can return directly here:=0A=
=0A=
return null_reset_zone(dev, zone);=0A=
=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_OPEN:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -		if (zone->cond =3D=3D BLK_ZONE_COND_FULL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -=0A=
> -		zone->cond =3D BLK_ZONE_COND_EXP_OPEN;=0A=
> +		ret =3D null_open_zone(dev, zone);=0A=
> +		if (ret !=3D BLK_STS_OK)=0A=
> +			return ret;=0A=
=0A=
same here.=0A=
=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_CLOSE:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -		if (zone->cond =3D=3D BLK_ZONE_COND_FULL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -=0A=
> -		if (zone->wp =3D=3D zone->start)=0A=
> -			zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
> -		else=0A=
> -			zone->cond =3D BLK_ZONE_COND_CLOSED;=0A=
> +		ret =3D null_close_zone(dev, zone);=0A=
> +		if (ret !=3D BLK_STS_OK)=0A=
> +			return ret;=0A=
=0A=
And here.=0A=
=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_FINISH:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -=0A=
> -		zone->cond =3D BLK_ZONE_COND_FULL;=0A=
> -		zone->wp =3D zone->start + zone->len;=0A=
> +		ret =3D null_finish_zone(dev, zone);=0A=
> +		if (ret !=3D BLK_STS_OK)=0A=
> +			return ret;=0A=
=0A=
And here too.=0A=
=0A=
>  		break;=0A=
>  	default:=0A=
>  		return BLK_STS_NOTSUPP;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
