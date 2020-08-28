Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EC9C433E2
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 07:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1EDE20CC7
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 07:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ckDaGik+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uS99tK3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgH1HGs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:06:48 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64800 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgH1HGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 03:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598598422; x=1630134422;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vLtpfg37IB73zMhSyZkCcAdunz4TmZhhJPuS0+FbGNU=;
  b=ckDaGik+ZpVn4CE5xA3SMBIi6BzoJ8eoHi9FhNUTIY9uD5CWzAFmlKEs
   VAHDXWHw34vqdmK9YoyYHnQeyvwWUA8wD7FvNX2Rhv4xWsXW0Ipf7EgMx
   3nZJFNQazJFIIbz8ToabEDn8YgsMzpEwwxelieVMx9Z4XZG+EiET6WMdB
   DEnAAOFXw3HP0VGT+8gIaLWfT3vwx8XE7xnx/gambYF3Pd6C08V7zNCx2
   WimtKmKvcrLgF8hmfP254yXyFHxKjUy4WTUUWNlTCHMhwFpzyPKH7GRE7
   PdJykNrzm2vB0JkmBbbCVl1kQ8zNc4dK+l3cecuNMsusA2sk8JNrNz/GA
   w==;
IronPort-SDR: /8Bi1G8wH26+WEDPn9VFaEAg7INlduHl2AmSOq3Zv287f0MkbIKXF/ZqMyi6F1z4mVQH4WY0E1
 L4hnYvJqGHz9JDK617x2UyJMzQXwVxaRz6OwgymMWAWjFkEh1rola24F82LrqjpQO0YTnUpkX9
 dQ1sE8aUFGf7KdOcHOLDtVZUhR6glSRd55kQcT9q1icpdsMNNnDn33GekznsQAc+8kgYqxfo6+
 flroO7G9v0wWdFS616uhxwsJrQnugENbMOCJcxIMvlCNaLI7tD7b+CIVOyV0/UqrZ4zmoCWUXv
 cgY=
X-IronPort-AV: E=Sophos;i="5.76,362,1592841600"; 
   d="scan'208";a="249282078"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2020 15:07:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+29ln9VZxxiFDliusnuoGTvmdUcOYZYpodcSoC6FBNJKJQ6UCTNl/07z1CM1lSLo2IA387chDzPk40+uKyai+nufnQ/45k3kGB/x5V3q0L+NEFhFSIkAgP57Nd0R3ad84RhdtZFUJbx7Xd/2QeyNC2Cph1AEQlo6tB7zfWqOHzfG3mj5pMwsHcpLL4XYn0Kq3oMGICGdDj5HWwfmshTNdBUR3f4Jj8Cs92recTEvnSMVXV3cbHwQgAG51jfdZ32zV8DNbUWXPiCwrZ+AcOuTcpJIBEcAID61nv3zIqwVgfpqMwjyhe3Mm11iRammN2TV8GcUubzSt3vcib/adtveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2N9DmlW4ccOwVLnHU593QT5N8HDqeqzU+PFD/lQoSo=;
 b=ekgWUkniokyMEtdB1sVS3a8PXkGrQ4uGt0lsSP9pVrshP1wcm8H+K2tNzyul1Qr/UkD+BzqubK5QAT35gNsuMJ12ddxVnTPNpg00ehILgq0KZjFMb1CErd1hQQx+5MxcKJpAKGbPiv0wVZm9FGMYGLwJ9o0J1QeTkuGmhlPCO076qrWjdv+Wu4R0Npx+FFNuoSyB/zF8hYyE3Ev5xGufaF39jQqNU0uO/AKsrwRcQV7kexwWTHSt55HV8KOWSphA1yzzk1d5vsOBXTUu4TC90YjgeKJMsDm+iUNwhPUDU2Y0i+87QzmwHoGfA6KDyR5NTFONcCCN+GLv496qiyF7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2N9DmlW4ccOwVLnHU593QT5N8HDqeqzU+PFD/lQoSo=;
 b=uS99tK3VCJDLrBtLi6Bf+siBHWE2zdwxtrtE/1grUXEYGqZILCh5aXrPcr1YvW2tsaKvA/SdXQJbVf4p7HCNblVGcH6Sm6iFK1AiaWyhbJDNmvO8hc5H1NtqI/AinMUo4SnzyblC0F0fQu3nnBwG73vdMK5OUQ7QztLwCrdsT/8=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1030.namprd04.prod.outlook.com (2603:10b6:910:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 07:06:26 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3305.032; Fri, 28 Aug
 2020 07:06:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>, Jens Axboe <axboe@kernel.dk>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Topic: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Index: AQHWfHkH+20N/yg19E+BQ9ptEBewKg==
Date:   Fri, 28 Aug 2020 07:06:26 +0000
Message-ID: <CY4PR04MB3751526DC5833902749EBE48E7520@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200827135018.63644-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf:fa0c:32f2:7362]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6372e05-0f45-4455-2cfd-08d84b20e145
x-ms-traffictypediagnostic: CY4PR04MB1030:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB10306584B7935F9C94CEB030E7520@CY4PR04MB1030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jQy7ylKh67gIKFWWBb87iadQGc2xlaWai7GEiAzRkI3t9GT9j3X5AIlXh6/pvYmkNU0J2A4KGDyRlwX3pAZlpo3WbSWN6kdoJKH5+vDANm8jbPomJf1CNA64yci1jDj/Y5kDyaDbmJ1bWszq+2HCSJaAQeVoKk0pWdleNdyLBdRxjPHfELTvb+OBC4Cnr3voYZkfIwIcgnPmZQZICePD83JqSC83LWHv8WwVzVoPjL5GjRmmuff8l3Q0ZK3MuCG6NQdr2ClHEBJj8GVmJGz/HLcCIdXC5KAAVsOCpniW8m52QZ+G065x+JwFYQceTs3FQGj9J/DXRZaRYeIBqxgC4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(6506007)(86362001)(33656002)(83380400001)(91956017)(76116006)(4326008)(8676002)(8936002)(66946007)(53546011)(66476007)(66556008)(66446008)(186003)(52536014)(64756008)(9686003)(5660300002)(7696005)(71200400001)(55016002)(2906002)(30864003)(316002)(110136005)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XBgIh3PKaHZ9Uw42l9WYuxW84XzpVsbPKr+FTgJZ1InVHhzS3mC2OyjGAwQYf7adSqwMG8+zZhDMoXX/NSG8q4ACwW15CrgsDj/9A+Vzna9Zpc5KdiX+++1QN3NnKcHnLfuxI7hLa+EnXe2/jQ2flOi/EFWbNLza7M2uvKJlcBtZqLxYCpe8UP6L3TLdrIaobCWtQrLoc4fd/2PmP9a64hbpI3QSXSK7vm5fA70Mcp/hgqtTYVsqreKYH/TWMTN9OCAXMty0A7vbi+iLOxpDWekcAK4hrCysP6m3AG8QNoc0ZkJjfwB0HfjhrIF7MJt2Z/4lLBAg3+Lc0mBDRfi35gFTbDey133oKQOYk3XwhCeLK2IsYHNf1EmHIvYn8KG+aCiokXLp4ykRmmAMKffS29u7xLETs8ZK7fIwA4T7gAdFg1pdPuBYESRyWSHiMzJn3P3D3QYtlqi+GlMf+AF2EjyFOkX8c7NVgVYrDn2SKmFmco1s8vlTjypmgOqvgdvRzasqjgPGS8AA5AvxoJaxDop4itZ9eW1hcP/z1dr59I84FyzIr5QlIHRFDfsCrR96wPOk6EJkdX12DTZvMk/8rVWQ5IB6BbXXDyA1cJRd1ox9K+0F+gWxPMbce8nBIN8e63T6oryKsMJT4fL8PYFiLyUbimxUy5egd9tbTazB0n0c3EsTuuRqNCiHKoCY4xlvaRZNSslmvN8RR8zUkNcwbQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6372e05-0f45-4455-2cfd-08d84b20e145
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 07:06:26.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FaTqLn70O2fGYBG/W8A/ZQHOqHdh2zI5qqvg1huShYxpMRZ2/CUZuJBb4hn9HNByRIEnjjMB9TDIcylH8VoUSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1030
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/08/27 22:50, Niklas Cassel wrote:=0A=
> Add support for user space to set a max open zone and a max active zone=
=0A=
> limit via configfs. By default, the default values are 0 =3D=3D no limit.=
=0A=
> =0A=
> Call the block layer API functions used for exposing the configured=0A=
> limits to sysfs.=0A=
> =0A=
> Add accounting in null_blk_zoned so that these new limits are respected.=
=0A=
> Performing an operating that would exceed these limits results in a=0A=
=0A=
Performing a write operation that would result in exceeding these...=0A=
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
> Changes since v1:=0A=
> -Fixed review comments by Damien Le Moal.=0A=
> =0A=
>  drivers/block/null_blk.h       |   5 +=0A=
>  drivers/block/null_blk_main.c  |  16 +-=0A=
>  drivers/block/null_blk_zoned.c | 319 +++++++++++++++++++++++++++------=
=0A=
>  3 files changed, 282 insertions(+), 58 deletions(-)=0A=
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
> index 3d25c9ad23831..e7e341e811fbf 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -51,6 +51,22 @@ int null_init_zoned_dev(struct nullb_device *dev, stru=
ct request_queue *q)=0A=
>  			dev->zone_nr_conv);=0A=
>  	}=0A=
>  =0A=
> +	/* Max active zones has to be < nbr of seq zones in order to be enforce=
able */=0A=
> +	if (dev->zone_max_active >=3D dev->nr_zones - dev->zone_nr_conv) {=0A=
> +		dev->zone_max_active =3D 0;=0A=
> +		pr_info("zone_max_active limit disabled, limit >=3D zone count\n");=0A=
> +	}=0A=
> +=0A=
> +	/* Max open zones has to be <=3D max active zones */=0A=
> +	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active) =
{=0A=
> +		dev->zone_max_open =3D dev->zone_max_active;=0A=
> +		pr_info("changed the maximum number of open zones to %u\n",=0A=
> +			dev->nr_zones);=0A=
> +	} else if (dev->zone_max_open >=3D dev->nr_zones - dev->zone_nr_conv) {=
=0A=
> +		dev->zone_max_open =3D 0;=0A=
> +		pr_info("zone_max_open limit disabled, limit >=3D zone count\n");=0A=
> +	}=0A=
> +=0A=
>  	for (i =3D 0; i <  dev->zone_nr_conv; i++) {=0A=
>  		struct blk_zone *zone =3D &dev->zones[i];=0A=
>  =0A=
> @@ -99,6 +115,8 @@ int null_register_zoned_dev(struct nullb *nullb)=0A=
>  	}=0A=
>  =0A=
>  	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);=0A=
> +	blk_queue_max_open_zones(q, dev->zone_max_open);=0A=
> +	blk_queue_max_active_zones(q, dev->zone_max_active);=0A=
>  =0A=
>  	return 0;=0A=
>  }=0A=
> @@ -159,6 +177,103 @@ size_t null_zone_valid_read_len(struct nullb *nullb=
,=0A=
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
> +	for (i =3D dev->zone_nr_conv; i < dev->nr_zones; i++) {=0A=
> +		if (dev->zones[i].cond =3D=3D BLK_ZONE_COND_IMP_OPEN) {=0A=
> +			null_close_zone(dev, &dev->zones[i]);=0A=
> +			return;=0A=
> +		}=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static bool null_can_set_active(struct nullb_device *dev)=0A=
> +{=0A=
> +	if (!dev->zone_max_active)=0A=
> +		return true;=0A=
> +=0A=
> +	return dev->nr_zones_exp_open + dev->nr_zones_imp_open +=0A=
> +	       dev->nr_zones_closed < dev->zone_max_active;=0A=
> +}=0A=
> +=0A=
> +static bool null_can_open(struct nullb_device *dev)=0A=
> +{=0A=
> +	if (!dev->zone_max_open)=0A=
> +		return true;=0A=
> +=0A=
> +	if (dev->nr_zones_exp_open + dev->nr_zones_imp_open < dev->zone_max_ope=
n)=0A=
> +		return true;=0A=
> +=0A=
> +	if (dev->nr_zones_imp_open && null_can_set_active(dev)) {=0A=
> +		null_close_first_imp_zone(dev);=0A=
> +		return true;=0A=
> +	}=0A=
> +=0A=
> +	return false;=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * This function matches the manage open zone resources function in the =
ZBC standard,=0A=
> + * with the addition of max active zones support (added in the ZNS stand=
ard).=0A=
> + *=0A=
> + * The function determines if a zone can transition to implicit open or =
explicit open,=0A=
> + * while maintaining the max open zone (and max active zone) limit(s). I=
t may close an=0A=
> + * implicit open zone in order to make additional zone resources availab=
le.=0A=
> + *=0A=
> + * ZBC states that an implicit open zone shall be closed only if there i=
s not=0A=
> + * room within the open limit. However, with the addition of an active l=
imit,=0A=
> + * it is not certain that closing an implicit open zone will allow a new=
 zone=0A=
> + * to be opened, since we might already be at the active limit capacity.=
=0A=
> + */=0A=
> +static bool null_manage_zone_resources(struct nullb_device *dev, struct =
blk_zone *zone)=0A=
=0A=
I still do not like the name. Since this return a bool, what about=0A=
null_has_zone_resources() ?=0A=
=0A=
> +{=0A=
> +	switch (zone->cond) {=0A=
> +	case BLK_ZONE_COND_EMPTY:=0A=
> +		if (!null_can_set_active(dev))=0A=
> +			return false;=0A=
> +		fallthrough;=0A=
> +	case BLK_ZONE_COND_CLOSED:=0A=
> +		return null_can_open(dev);=0A=
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
> @@ -177,43 +292,155 @@ static blk_status_t null_zone_write(struct nullb_c=
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
>  =0A=
> -		if (zone->wp + nr_sectors > zone->start + zone->capacity)=0A=
> +	return BLK_STS_OK;=0A=
> +}=0A=
> +=0A=
> +static blk_status_t null_finish_zone(struct nullb_device *dev, struct bl=
k_zone *zone)=0A=
> +{=0A=
> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> +		return BLK_STS_IOERR;=0A=
> +=0A=
> +	switch (zone->cond) {=0A=
> +	case BLK_ZONE_COND_FULL:=0A=
> +		/* finish operation on full is not an error */=0A=
> +		return BLK_STS_OK;=0A=
> +	case BLK_ZONE_COND_EMPTY:=0A=
> +		if (!null_manage_zone_resources(dev, zone))=0A=
=0A=
OK. So you are hitting a fuzzy case here that is not actually well describe=
d in=0A=
the standards. That is, does finishing an empty zone necessarilly imply a=
=0A=
temporary transition through imp open ? Which you are assuming is a yes her=
e.=0A=
Personally, I would say that is not necessary, but no strong feeling either=
 way.=0A=
=0A=
>  			return BLK_STS_IOERR;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_IMP_OPEN:=0A=
> +		dev->nr_zones_imp_open--;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
> +		dev->nr_zones_exp_open--;=0A=
> +		break;=0A=
> +	case BLK_ZONE_COND_CLOSED:=0A=
> +		if (!null_manage_zone_resources(dev, zone))=0A=
> +			return BLK_STS_IOERR;=0A=
> +		dev->nr_zones_closed--;=0A=
> +		break;=0A=
> +	default:=0A=
> +		return BLK_STS_IOERR;=0A=
> +	}=0A=
>  =0A=
> -		if (zone->cond !=3D BLK_ZONE_COND_EXP_OPEN)=0A=
> -			zone->cond =3D BLK_ZONE_COND_IMP_OPEN;=0A=
> +	zone->cond =3D BLK_ZONE_COND_FULL;=0A=
> +	zone->wp =3D zone->start + zone->len;=0A=
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
> @@ -222,56 +449,34 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd=
 *cmd, enum req_opf op,=0A=
>  	struct nullb_device *dev =3D cmd->nq->dev;=0A=
>  	unsigned int zone_no =3D null_zone_no(dev, sector);=0A=
>  	struct blk_zone *zone =3D &dev->zones[zone_no];=0A=
> +	blk_status_t ret =3D BLK_STS_OK;=0A=
>  	size_t i;=0A=
>  =0A=
>  	switch (op) {=0A=
>  	case REQ_OP_ZONE_RESET_ALL:=0A=
> -		for (i =3D 0; i < dev->nr_zones; i++) {=0A=
> -			if (zone[i].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -				continue;=0A=
> -			zone[i].cond =3D BLK_ZONE_COND_EMPTY;=0A=
> -			zone[i].wp =3D zone[i].start;=0A=
> -		}=0A=
> +		for (i =3D dev->zone_nr_conv; i < dev->nr_zones; i++)=0A=
> +			null_reset_zone(dev, &dev->zones[i]);=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -=0A=
> -		zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
> -		zone->wp =3D zone->start;=0A=
> +		ret =3D null_reset_zone(dev, zone);=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_OPEN:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -		if (zone->cond =3D=3D BLK_ZONE_COND_FULL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -=0A=
> -		zone->cond =3D BLK_ZONE_COND_EXP_OPEN;=0A=
> +		ret =3D null_open_zone(dev, zone);=0A=
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
>  		break;=0A=
>  	case REQ_OP_ZONE_FINISH:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -=0A=
> -		zone->cond =3D BLK_ZONE_COND_FULL;=0A=
> -		zone->wp =3D zone->start + zone->len;=0A=
> +		ret =3D null_finish_zone(dev, zone);=0A=
>  		break;=0A=
>  	default:=0A=
>  		return BLK_STS_NOTSUPP;=0A=
>  	}=0A=
>  =0A=
> -	trace_nullb_zone_op(cmd, zone_no, zone->cond);=0A=
> -	return BLK_STS_OK;=0A=
> +	if (ret =3D=3D BLK_STS_OK)=0A=
> +		trace_nullb_zone_op(cmd, zone_no, zone->cond);=0A=
> +=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf =
op,=0A=
> =0A=
=0A=
Apart from the commit message and function name nits above, this looks good=
 to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
