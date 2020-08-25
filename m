Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885B3C433DF
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 23:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3991820738
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 23:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qzITqsHH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iiFvGkS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHYXEE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:04:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37280 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgHYXEE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 19:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598396702; x=1629932702;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fayes6/xHcJ+Om/UEz4MdG7OwiA7isHkMygJaBFxx38=;
  b=qzITqsHHXlqFZQ91HnBwI93OldmTIk7acxUMdAFkIQ1gAfR4EnCu8gAN
   N1hqmP0M46BHLhIs1P2l9laBSmKn2M8LwmcGE8Jl1/3u0WM+lFiwh6Pgq
   cdrsN7Ni7rn71OucQrU21udwJoc/WbtfuR+Z+5tVGzYYZMd5gkxzzwejT
   I4W9mKSTphIDuuBpxg49JrDZwJjaROeUpcEE6PGoA6kUlVG7oWR6yX3WU
   JksZmDQBg/1yGid2ZIo9vjgvjvy0UftYe8Cfh5Ybh6XmNU9e2AUSH01/O
   1dgFR9VExjw6nFAHXMMniALz5ZLyS3LNqFRnNUNH8n4+CXsD8WApMdRfB
   w==;
IronPort-SDR: mBLUqRzrRuAaFJ0T7BoEIEdeFeC55Ikfqi5JPxRHKA9ZPNazHIKwcfEKfB6/UzTh/lFlTwz+JY
 jEN1mdyeXeGETsmi2+J1S96KB+n8sylwTX0a7xqrUcYKwyQSLyEu9puFIxoU94yMzA0hsFW/Wu
 s+m6GBtCS0SdJB9yGJ3MdeIY+nSD77OZKAMF0/FxquKWqZ7oKnHyeb+VSvcJ+ry7YxuYvCT4F5
 B2BE/d6vHbnIhRdpFYS8CiotKMLuBdg6gShRQxZTwsuQRdegHBLRtVd9/zjdTZO+nezKO4RNK1
 eCE=
X-IronPort-AV: E=Sophos;i="5.76,354,1592841600"; 
   d="scan'208";a="249055523"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 07:05:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHqwLa7OxZHqbgF5dMJ/N+9kw86OKbtS+ch8AD8gg70alJr1Jb7WSd4jAeJcO7u87d700cxkMFyag+lsRi5eGIXSm9CgO9C6FNXvZO3VBMTUnCGQ1Nn388cXB1k7jeU3CabBEQuYqi+5NAXY4ShvI07nzAQwZiyyVAVqRIvBoVErkj5CpDlK9Amf/DHUqJdHUSGoRl1UHk/gW2EfbjPQBw1LnXfb1taOir4xlV9bkBUbQhIQvly4u8jrJeouhbTV5CsnoitHolT5JXA974zHLY15VxZet1s3xedBWN2yxGcjLY2MT2zLbmz2eiYsmNgDLGi4aWL4k3WbJhGUao98Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/6Gas7AwTp0xC0j5Q7uNGj8czR9lNZKL+atcXVkiZI=;
 b=WOXYOiifnF4eubV+8gzuecOfuWn9ndv/Syw8y71Ud/E2/2AbRwFk0ZFDSFdF0y1vpRn2iPep7/2GCeDWzgBX6L1qwnkltdMzt4KqUPEgqKLRSbgpGFp7qT3rmhWcDMjOC7xfa62YslYeO4FHdBkPPe1G+tIKTJGFR+Fn1nsssuKeIIZqL6kMLFAhfUpP+H9EazkpelHJ/9GUgd8RmZo608Qbzh479YuUa0V6ncL2Tcc+fFUjTQP5I+t2O9uRSNNF5gGaPEFSQvTGLDuhrNzjVtHUO19hckmJH1HyV98cMGU4AMxVke10dorMP+ixHKYIh6vPZw/Y3A2NCnntm6lJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/6Gas7AwTp0xC0j5Q7uNGj8czR9lNZKL+atcXVkiZI=;
 b=iiFvGkS6YeSaKx9hZz19ARIHA/HqQy2MdTBDHdL6j2Y8rnN6kBEh1STpykP0VdrMrNXO4tffUVUdvxArhNbLFFtu0r1d4RCGkShHpj7V1PV6dQfrM+5KZBsrToJshh3UPKlbfYHCxRmxhnz4rqIFCX3UahQyaS+hFQoipLLty7I=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3634.namprd04.prod.outlook.com (2603:10b6:910:8f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 23:03:58 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3305.026; Tue, 25 Aug
 2020 23:03:58 +0000
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
Date:   Tue, 25 Aug 2020 23:03:58 +0000
Message-ID: <CY4PR04MB3751304895558D34A8EE8DB1E7570@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200825122244.126129-1-niklas.cassel@wdc.com>
 <CY4PR04MB37518DF84867B6E8573A13B0E7570@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:95f6:21b7:9982:4fac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7807641-d004-419b-ad83-08d8494b266d
x-ms-traffictypediagnostic: CY4PR0401MB3634:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB3634ACC002E7B2C269580424E7570@CY4PR0401MB3634.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ShZMjmQAb0xF8isb/z6mpo0s7w3z2Na1vcZF+34wj5M0lxJHW1QmDQzItUTVA1als072JcS6eVT4nTcPZ3jmhHxaOtg2fbtmrk0qSUGE+1mPAN48R7wIfljWOSK5lX22JWhX5hkswsw1ouKKyamZoDWR3lPsBYzz7d9RXD0pWVnvM1ToBXmEI1lh5lFztn5uk6GACaSNFnlMTs/DbrcGqYKIKf7c4LjHk+3a53UYuDURkZ881FSWjv1Te8BHIWOhU/uIHZafBhuXBG1mgny6lCJcdHgSQPC5ln+1+Wcx6zwaBR8VEVDvp+afZH5uCjz0PTLcKEhSLDCRcLPqv3dlZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66556008)(64756008)(76116006)(66946007)(9686003)(55016002)(91956017)(66446008)(53546011)(83380400001)(4326008)(54906003)(7696005)(6506007)(2906002)(316002)(110136005)(8936002)(71200400001)(33656002)(478600001)(30864003)(86362001)(52536014)(5660300002)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: C15r/xzz5JD7muwXJ4g2aivhJxgCY95XIgta+5RmbCh8YvUHE+1i/RiWdzJLZAp/FqSLMLt/utPk8xtorDLCa/g0tF1RlIuJbyNm5Tgaq3F1sbtU1PtYYa08gIENJNqZpKMdeSeTeZrMof2LXlB5/Uaf/5LZimA+vAab6hRgfJnTextZkK6EUVrcvgBLUA9LGS5Hj+QlGk/cq9Xtqi8IMA9by53QaM5jPtB+2ChEO8QJkVOel8K9FnunUzbJwO6wqxhPa/2nXB801ipZhNgh5aX6DQMHKTXgSU+DvqG2bOP1hQxu9znY5bANVo64kYdCqcGVfHCZMFWh1kqUiMukOc11nKNXgu7/itnpXW1L1Ea0ybWJCEirzWWgwaBbjqCvJqrlPzL5eiCW79MjGa1z7F2W1/AC99KBInIdEI29yjOYXXUEBNyJyKxo6/jAwjXv9P+RN10TKGrZQ2TgCkaXrUaDnVg3tmtrIDSJx4Zo5u/FzuDFFy0ZQ0C6QmeOxBaH4CG5ClJ5C/fjEd0LMu0BYE4KCQF4KqfGc5ZhloSOf46YZcdt5/xjJLRIARVwydTpsbpnVCk67rglJE6czxLMuMrRTEgV0g5dfkJM6vUauyucRMS63bv+WKKWMSPrtqKwV5PsWOnhF8M+ybaTmTiAVrMyaXZvG9B61IpdBBHRqYT3knwHvCwWNFABzQcHcSUo75GnAKVeBn4mhlvTp16xUg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7807641-d004-419b-ad83-08d8494b266d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 23:03:58.8492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyAiX7LoYlWY3snEoj2Elbq3Ub1qfjn9TPHHaQ2nt1zGvQxJi3Sf340DMj04YGDp77IQf7p+Ix5hooNnZjEE8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3634
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/08/26 7:52, Damien Le Moal wrote:=0A=
> On 2020/08/25 21:22, Niklas Cassel wrote:=0A=
>> Add support for user space to set a max open zone and a max active zone=
=0A=
>> limit via configfs. By default, the default value is 0 =3D=3D no limit.=
=0A=
> =0A=
> s/value is/values are/=0A=
> =0A=
>>=0A=
>> Call the block layer API functions used for exposing the configured=0A=
>> limits to sysfs.=0A=
>>=0A=
>> Add accounting in null_blk_zoned so that these new limits are respected.=
=0A=
>> Performing an operating that would exceed these limits results is a=0A=
> =0A=
> s/is a/in a/=0A=
> =0A=
>> standard I/O error.=0A=
>>=0A=
>> A max open zone limit exists in the ZBC standard.=0A=
>> While null_blk_zoned is used to test the Zoned Block Device model in=0A=
>> Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned=
=0A=
>> mostly follows ZBC.=0A=
>>=0A=
>> Therefore, implement the manage open zone resources function from ZBC,=
=0A=
>> but additionally add support for max active zones.=0A=
>> This enables user space not only to test against a device with an open=
=0A=
>> zone limit, but also to test against a device with an active zone limit.=
=0A=
>>=0A=
>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>=0A=
>> ---=0A=
>>  drivers/block/null_blk.h       |   5 +=0A=
>>  drivers/block/null_blk_main.c  |  16 +-=0A=
>>  drivers/block/null_blk_zoned.c | 316 +++++++++++++++++++++++++++------=
=0A=
>>  3 files changed, 283 insertions(+), 54 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h=0A=
>> index daed4a9c34367..d2e7db43a52a7 100644=0A=
>> --- a/drivers/block/null_blk.h=0A=
>> +++ b/drivers/block/null_blk.h=0A=
>> @@ -42,6 +42,9 @@ struct nullb_device {=0A=
>>  	struct badblocks badblocks;=0A=
>>  =0A=
>>  	unsigned int nr_zones;=0A=
>> +	unsigned int nr_zones_imp_open;=0A=
>> +	unsigned int nr_zones_exp_open;=0A=
>> +	unsigned int nr_zones_closed;=0A=
>>  	struct blk_zone *zones;=0A=
>>  	sector_t zone_size_sects;=0A=
>>  =0A=
>> @@ -51,6 +54,8 @@ struct nullb_device {=0A=
>>  	unsigned long zone_size; /* zone size in MB if device is zoned */=0A=
>>  	unsigned long zone_capacity; /* zone capacity in MB if device is zoned=
 */=0A=
>>  	unsigned int zone_nr_conv; /* number of conventional zones */=0A=
>> +	unsigned int zone_max_open; /* max number of open zones */=0A=
>> +	unsigned int zone_max_active; /* max number of active zones */=0A=
>>  	unsigned int submit_queues; /* number of submission queues */=0A=
>>  	unsigned int home_node; /* home node for the device */=0A=
>>  	unsigned int queue_mode; /* block interface */=0A=
>> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main=
.c=0A=
>> index d74443a9c8fa2..53161a418611b 100644=0A=
>> --- a/drivers/block/null_blk_main.c=0A=
>> +++ b/drivers/block/null_blk_main.c=0A=
>> @@ -208,6 +208,14 @@ static unsigned int g_zone_nr_conv;=0A=
>>  module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);=0A=
>>  MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block=
 device is zoned. Default: 0");=0A=
>>  =0A=
>> +static unsigned int g_zone_max_open;=0A=
>> +module_param_named(zone_max_open, g_zone_max_open, uint, 0444);=0A=
>> +MODULE_PARM_DESC(zone_max_open, "Maximum number of open zones when bloc=
k device is zoned. Default: 0 (no limit)");=0A=
>> +=0A=
>> +static unsigned int g_zone_max_active;=0A=
>> +module_param_named(zone_max_active, g_zone_max_active, uint, 0444);=0A=
>> +MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when =
block device is zoned. Default: 0 (no limit)");=0A=
>> +=0A=
>>  static struct nullb_device *null_alloc_dev(void);=0A=
>>  static void null_free_dev(struct nullb_device *dev);=0A=
>>  static void null_del_dev(struct nullb *nullb);=0A=
>> @@ -347,6 +355,8 @@ NULLB_DEVICE_ATTR(zoned, bool, NULL);=0A=
>>  NULLB_DEVICE_ATTR(zone_size, ulong, NULL);=0A=
>>  NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);=0A=
>>  NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);=0A=
>> +NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);=0A=
>> +NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);=0A=
>>  =0A=
>>  static ssize_t nullb_device_power_show(struct config_item *item, char *=
page)=0A=
>>  {=0A=
>> @@ -464,6 +474,8 @@ static struct configfs_attribute *nullb_device_attrs=
[] =3D {=0A=
>>  	&nullb_device_attr_zone_size,=0A=
>>  	&nullb_device_attr_zone_capacity,=0A=
>>  	&nullb_device_attr_zone_nr_conv,=0A=
>> +	&nullb_device_attr_zone_max_open,=0A=
>> +	&nullb_device_attr_zone_max_active,=0A=
>>  	NULL,=0A=
>>  };=0A=
>>  =0A=
>> @@ -517,7 +529,7 @@ nullb_group_drop_item(struct config_group *group, st=
ruct config_item *item)=0A=
>>  static ssize_t memb_group_features_show(struct config_item *item, char =
*page)=0A=
>>  {=0A=
>>  	return snprintf(page, PAGE_SIZE,=0A=
>> -			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zon=
e_capacity,zone_nr_conv\n");=0A=
>> +			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zon=
e_capacity,zone_nr_conv,zone_max_open,zone_max_active\n");=0A=
>>  }=0A=
>>  =0A=
>>  CONFIGFS_ATTR_RO(memb_group_, features);=0A=
>> @@ -580,6 +592,8 @@ static struct nullb_device *null_alloc_dev(void)=0A=
>>  	dev->zone_size =3D g_zone_size;=0A=
>>  	dev->zone_capacity =3D g_zone_capacity;=0A=
>>  	dev->zone_nr_conv =3D g_zone_nr_conv;=0A=
>> +	dev->zone_max_open =3D g_zone_max_open;=0A=
>> +	dev->zone_max_active =3D g_zone_max_active;=0A=
>>  	return dev;=0A=
>>  }=0A=
>>  =0A=
>> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zon=
ed.c=0A=
>> index 3d25c9ad23831..5fb38c9bdd4ae 100644=0A=
>> --- a/drivers/block/null_blk_zoned.c=0A=
>> +++ b/drivers/block/null_blk_zoned.c=0A=
>> @@ -51,6 +51,24 @@ int null_init_zoned_dev(struct nullb_device *dev, str=
uct request_queue *q)=0A=
>>  			dev->zone_nr_conv);=0A=
>>  	}=0A=
>>  =0A=
>> +	/* Max active zones has to be <=3D number of sequential zones */=0A=
>> +	if (dev->zone_max_active > dev->nr_zones - dev->zone_nr_conv) {=0A=
>> +		dev->zone_max_active =3D dev->nr_zones - dev->zone_nr_conv;=0A=
>> +		pr_info("changed the maximum number of active zones to %u\n",=0A=
>> +			dev->nr_zones);=0A=
>> +	}=0A=
> =0A=
> if dev->zone_max_active =3D=3D dev->nr_zones - dev->zone_nr_conv, you cou=
ld also=0A=
> change dev->zone_max_active to 0, since that is equivalent. Not a blocker=
=0A=
> though, I think.=0A=
> =0A=
>> +=0A=
>> +	/* Max open zones has to be <=3D max active zones */=0A=
>> +	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active)=
 {=0A=
>> +		dev->zone_max_open =3D dev->zone_max_active;=0A=
>> +		pr_info("changed the maximum number of open zones to %u\n",=0A=
>> +			dev->nr_zones);=0A=
>> +	} else if (dev->zone_max_open > dev->nr_zones - dev->zone_nr_conv) {=
=0A=
>> +		dev->zone_max_open =3D dev->nr_zones - dev->zone_nr_conv;=0A=
>> +		pr_info("changed the maximum number of open zones to %u\n",=0A=
>> +			dev->nr_zones);=0A=
>> +	}=0A=
> =0A=
> And same here for zone_max_open.=0A=
> =0A=
>> +=0A=
>>  	for (i =3D 0; i <  dev->zone_nr_conv; i++) {=0A=
>>  		struct blk_zone *zone =3D &dev->zones[i];=0A=
>>  =0A=
>> @@ -99,6 +117,8 @@ int null_register_zoned_dev(struct nullb *nullb)=0A=
>>  	}=0A=
>>  =0A=
>>  	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);=0A=
>> +	blk_queue_max_open_zones(q, dev->zone_max_open);=0A=
>> +	blk_queue_max_active_zones(q, dev->zone_max_active);=0A=
>>  =0A=
>>  	return 0;=0A=
>>  }=0A=
>> @@ -159,6 +179,99 @@ size_t null_zone_valid_read_len(struct nullb *nullb=
,=0A=
>>  	return (zone->wp - sector) << SECTOR_SHIFT;=0A=
>>  }=0A=
>>  =0A=
>> +static blk_status_t null_close_zone(struct nullb_device *dev, struct bl=
k_zone *zone)=0A=
>> +{=0A=
>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +=0A=
>> +	switch (zone->cond) {=0A=
>> +	case BLK_ZONE_COND_CLOSED:=0A=
>> +		/* close operation on closed is not an error */=0A=
>> +		return BLK_STS_OK;=0A=
>> +	case BLK_ZONE_COND_IMP_OPEN:=0A=
>> +		dev->nr_zones_imp_open--;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
>> +		dev->nr_zones_exp_open--;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_EMPTY:=0A=
>> +	case BLK_ZONE_COND_FULL:=0A=
>> +	default:=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (zone->wp =3D=3D zone->start) {=0A=
>> +		zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
>> +	} else {=0A=
>> +		zone->cond =3D BLK_ZONE_COND_CLOSED;=0A=
>> +		dev->nr_zones_closed++;=0A=
>> +	}=0A=
>> +=0A=
>> +	return BLK_STS_OK;=0A=
>> +}=0A=
>> +=0A=
>> +static void null_close_first_imp_zone(struct nullb_device *dev)=0A=
>> +{=0A=
>> +	unsigned int i;=0A=
>> +=0A=
>> +	for (i =3D 0; i < dev->nr_zones; i++) {=0A=
> =0A=
> You can start the loop from dev->nr_conv_zones, that will avoid the first=
 if below.=0A=
> =0A=
>> +		if (dev->zones[i].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> +			continue;=0A=
>> +		if (dev->zones[i].cond =3D=3D BLK_ZONE_COND_IMP_OPEN) {=0A=
>> +			null_close_zone(dev, &dev->zones[i]);=0A=
>> +			return;=0A=
>> +		}=0A=
>> +	}=0A=
>> +}=0A=
>> +=0A=
>> +static bool null_room_in_active(struct nullb_device *dev)=0A=
> =0A=
> The name is a little strange. What about null_can_set_active() ?=0A=
> =0A=
>> +{=0A=
>> +	if (!dev->zone_max_active)=0A=
>> +		return true;=0A=
>> +=0A=
>> +	return dev->nr_zones_exp_open + dev->nr_zones_imp_open +=0A=
>> +	       dev->nr_zones_closed < dev->zone_max_active;=0A=
>> +}=0A=
>> +=0A=
>> +static bool null_room_in_open(struct nullb_device *dev)=0A=
> =0A=
> Same here: null_can_open() ?=0A=
> =0A=
>> +{=0A=
>> +	if (!dev->zone_max_open)=0A=
>> +		return true;=0A=
>> +=0A=
>> +	return dev->nr_zones_exp_open + dev->nr_zones_imp_open < dev->zone_max=
_open;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * This function matches the manage open zone resources function in the=
 ZBC standard,=0A=
>> + * with the addition of max active zones support (added in the ZNS stan=
dard).=0A=
>> + *=0A=
>> + * ZBC states that an implicitly open zone shall be closed only if ther=
e is not=0A=
>> + * room within the open limit. However, if an active limit is set, it i=
s not certain=0A=
>> + * that an implicitly opened zone can be closed without exceeding the a=
ctive limit.=0A=
> =0A=
> Hu... imp open and close both being an active state, closing an imp open =
zone=0A=
> will never result in exceeding the max active limit. Did you mean somethi=
ng like=0A=
> "closing an imp open zone to open another one" ? or something else ? This=
 needs=0A=
> clarification as the function name does not really tell us what this is t=
rying=0A=
> to do. It looks like this is checking if a zone can be open... So why not=
 merge=0A=
> that into null_room_in_open(), renamed null_can_open() ?=0A=
> =0A=
>> + */=0A=
>> +static bool null_manage_zone_resources(struct nullb_device *dev, struct=
 blk_zone *zone)=0A=
>> +{=0A=
>> +	switch (zone->cond) {=0A=
>> +	case BLK_ZONE_COND_EMPTY:=0A=
>> +		if (!null_room_in_active(dev))=0A=
>> +			return false;=0A=
>> +		fallthrough;=0A=
>> +	case BLK_ZONE_COND_CLOSED:=0A=
>> +		if (null_room_in_open(dev)) {=0A=
>> +			return true;=0A=
>> +		} else if (dev->nr_zones_imp_open && null_room_in_active(dev)) {=0A=
>> +			null_close_first_imp_zone(dev);=0A=
>> +			return true;=0A=
>> +		} else {=0A=
> =0A=
> else is not needed here.=0A=
> =0A=
>> +			return false;=0A=
>> +		}=0A=
>> +	default:=0A=
>> +		/* Should never be called for other states */=0A=
>> +		WARN_ON(1);=0A=
>> +		return false;=0A=
>> +	}=0A=
>> +}=0A=
>> +=0A=
>>  static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sec=
tor,=0A=
>>  				    unsigned int nr_sectors, bool append)=0A=
>>  {=0A=
>> @@ -177,43 +290,155 @@ static blk_status_t null_zone_write(struct nullb_=
cmd *cmd, sector_t sector,=0A=
>>  		/* Cannot write to a full zone */=0A=
>>  		return BLK_STS_IOERR;=0A=
>>  	case BLK_ZONE_COND_EMPTY:=0A=
>> +	case BLK_ZONE_COND_CLOSED:=0A=
>> +		if (!null_manage_zone_resources(dev, zone))=0A=
>> +			return BLK_STS_IOERR;=0A=
>> +		break;=0A=
>>  	case BLK_ZONE_COND_IMP_OPEN:=0A=
>>  	case BLK_ZONE_COND_EXP_OPEN:=0A=
>> +		break;=0A=
>> +	default:=0A=
>> +		/* Invalid zone condition */=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +	}=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Regular writes must be at the write pointer position.=0A=
>> +	 * Zone append writes are automatically issued at the write=0A=
>> +	 * pointer and the position returned using the request or BIO=0A=
>> +	 * sector.=0A=
>> +	 */=0A=
>> +	if (append) {=0A=
>> +		sector =3D zone->wp;=0A=
>> +		if (cmd->bio)=0A=
>> +			cmd->bio->bi_iter.bi_sector =3D sector;=0A=
>> +		else=0A=
>> +			cmd->rq->__sector =3D sector;=0A=
>> +	} else if (sector !=3D zone->wp) {=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (zone->wp + nr_sectors > zone->start + zone->capacity)=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +=0A=
>> +	if (zone->cond =3D=3D BLK_ZONE_COND_CLOSED) {=0A=
>> +		dev->nr_zones_closed--;=0A=
>> +		dev->nr_zones_imp_open++;=0A=
>> +	} else if (zone->cond =3D=3D BLK_ZONE_COND_EMPTY) {=0A=
>> +		dev->nr_zones_imp_open++;=0A=
>> +	}=0A=
>> +	if (zone->cond !=3D BLK_ZONE_COND_EXP_OPEN)=0A=
>> +		zone->cond =3D BLK_ZONE_COND_IMP_OPEN;=0A=
>> +=0A=
>> +	ret =3D null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);=0A=
>> +	if (ret !=3D BLK_STS_OK)=0A=
>> +		return ret;=0A=
>> +=0A=
>> +	zone->wp +=3D nr_sectors;=0A=
>> +	if (zone->wp =3D=3D zone->start + zone->capacity) {=0A=
>> +		if (zone->cond =3D=3D BLK_ZONE_COND_EXP_OPEN)=0A=
>> +			dev->nr_zones_exp_open--;=0A=
>> +		else if (zone->cond =3D=3D BLK_ZONE_COND_IMP_OPEN)=0A=
>> +			dev->nr_zones_imp_open--;=0A=
>> +		zone->cond =3D BLK_ZONE_COND_FULL;=0A=
>> +	}=0A=
>> +	return BLK_STS_OK;=0A=
>> +}=0A=
>> +=0A=
>> +static blk_status_t null_open_zone(struct nullb_device *dev, struct blk=
_zone *zone)=0A=
>> +{=0A=
>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +=0A=
>> +	switch (zone->cond) {=0A=
>> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
>> +		/* open operation on exp open is not an error */=0A=
>> +		return BLK_STS_OK;=0A=
>> +	case BLK_ZONE_COND_EMPTY:=0A=
>> +		if (!null_manage_zone_resources(dev, zone))=0A=
>> +			return BLK_STS_IOERR;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_IMP_OPEN:=0A=
>> +		dev->nr_zones_imp_open--;=0A=
>> +		break;=0A=
>>  	case BLK_ZONE_COND_CLOSED:=0A=
>> -		/*=0A=
>> -		 * Regular writes must be at the write pointer position.=0A=
>> -		 * Zone append writes are automatically issued at the write=0A=
>> -		 * pointer and the position returned using the request or BIO=0A=
>> -		 * sector.=0A=
>> -		 */=0A=
>> -		if (append) {=0A=
>> -			sector =3D zone->wp;=0A=
>> -			if (cmd->bio)=0A=
>> -				cmd->bio->bi_iter.bi_sector =3D sector;=0A=
>> -			else=0A=
>> -				cmd->rq->__sector =3D sector;=0A=
>> -		} else if (sector !=3D zone->wp) {=0A=
>> +		if (!null_manage_zone_resources(dev, zone))=0A=
>>  			return BLK_STS_IOERR;=0A=
>> -		}=0A=
>> +		dev->nr_zones_closed--;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_FULL:=0A=
>> +	default:=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +	}=0A=
>> +=0A=
>> +	zone->cond =3D BLK_ZONE_COND_EXP_OPEN;=0A=
>> +	dev->nr_zones_exp_open++;=0A=
>> +=0A=
>> +	return BLK_STS_OK;=0A=
>> +}=0A=
>> +=0A=
>> +static blk_status_t null_finish_zone(struct nullb_device *dev, struct b=
lk_zone *zone)=0A=
>> +{=0A=
>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> +		return BLK_STS_IOERR;=0A=
>>  =0A=
>> -		if (zone->wp + nr_sectors > zone->start + zone->capacity)=0A=
>> +	switch (zone->cond) {=0A=
>> +	case BLK_ZONE_COND_FULL:=0A=
>> +		/* finish operation on full is not an error */=0A=
>> +		return BLK_STS_OK;=0A=
>> +	case BLK_ZONE_COND_EMPTY:=0A=
>> +		if (!null_manage_zone_resources(dev, zone))=0A=
>> +			return BLK_STS_IOERR;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_IMP_OPEN:=0A=
>> +		dev->nr_zones_imp_open--;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
>> +		dev->nr_zones_exp_open--;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_CLOSED:=0A=
>> +		if (!null_manage_zone_resources(dev, zone))=0A=
>>  			return BLK_STS_IOERR;=0A=
>> +		dev->nr_zones_closed--;=0A=
>> +		break;=0A=
>> +	default:=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +	}=0A=
>>  =0A=
>> -		if (zone->cond !=3D BLK_ZONE_COND_EXP_OPEN)=0A=
>> -			zone->cond =3D BLK_ZONE_COND_IMP_OPEN;=0A=
>> +	zone->cond =3D BLK_ZONE_COND_FULL;=0A=
>> +	zone->wp =3D zone->len;=0A=
> =0A=
> zone->wp =3D zone=3D>start + zone->len;=0A=
> =0A=
>>  =0A=
>> -		ret =3D null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);=0A=
>> -		if (ret !=3D BLK_STS_OK)=0A=
>> -			return ret;=0A=
>> +	return BLK_STS_OK;=0A=
>> +}=0A=
>> +=0A=
>> +static blk_status_t null_reset_zone(struct nullb_device *dev, struct bl=
k_zone *zone)=0A=
>> +{=0A=
>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> +		return BLK_STS_IOERR;=0A=
>>  =0A=
>> -		zone->wp +=3D nr_sectors;=0A=
>> -		if (zone->wp =3D=3D zone->start + zone->capacity)=0A=
>> -			zone->cond =3D BLK_ZONE_COND_FULL;=0A=
>> +	switch (zone->cond) {=0A=
>> +	case BLK_ZONE_COND_EMPTY:=0A=
>> +		/* reset operation on empty is not an error */=0A=
>>  		return BLK_STS_OK;=0A=
>> +	case BLK_ZONE_COND_IMP_OPEN:=0A=
>> +		dev->nr_zones_imp_open--;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
>> +		dev->nr_zones_exp_open--;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_CLOSED:=0A=
>> +		dev->nr_zones_closed--;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_FULL:=0A=
>> +		break;=0A=
>>  	default:=0A=
>> -		/* Invalid zone condition */=0A=
>>  		return BLK_STS_IOERR;=0A=
>>  	}=0A=
>> +=0A=
>> +	zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
>> +	zone->wp =3D zone->start;=0A=
>> +=0A=
>> +	return BLK_STS_OK;=0A=
>>  }=0A=
>>  =0A=
>>  static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf =
op,=0A=
>> @@ -222,49 +447,34 @@ static blk_status_t null_zone_mgmt(struct nullb_cm=
d *cmd, enum req_opf op,=0A=
>>  	struct nullb_device *dev =3D cmd->nq->dev;=0A=
>>  	unsigned int zone_no =3D null_zone_no(dev, sector);=0A=
>>  	struct blk_zone *zone =3D &dev->zones[zone_no];=0A=
>> +	blk_status_t ret;=0A=
>>  	size_t i;=0A=
>>  =0A=
>>  	switch (op) {=0A=
>>  	case REQ_OP_ZONE_RESET_ALL:=0A=
>>  		for (i =3D 0; i < dev->nr_zones; i++) {=0A=
>> -			if (zone[i].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> -				continue;=0A=
>> -			zone[i].cond =3D BLK_ZONE_COND_EMPTY;=0A=
>> -			zone[i].wp =3D zone[i].start;=0A=
>> +			null_reset_zone(dev, &dev->zones[i]);=0A=
>>  		}=0A=
> =0A=
> You can drop the curly brackets too, and start the loop from nr_conv_zone=
s too.=0A=
> =0A=
>>  		break;=0A=
>>  	case REQ_OP_ZONE_RESET:=0A=
>> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> -			return BLK_STS_IOERR;=0A=
>> -=0A=
>> -		zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
>> -		zone->wp =3D zone->start;=0A=
>> +		ret =3D null_reset_zone(dev, zone);=0A=
>> +		if (ret !=3D BLK_STS_OK)=0A=
>> +			return ret;=0A=
> =0A=
> You can return directly here:=0A=
> =0A=
> return null_reset_zone(dev, zone);=0A=
=0A=
Arg. No, you can't. There is the trace call after the switch. So please ign=
ore=0A=
this comment :)=0A=
=0A=
But you can still avoid repeating the "if (ret !=3D BLK_STS_OK) return ret;=
" by=0A=
calling the trace only for BLK_STS_OK and returning ret at the end.=0A=
=0A=
> =0A=
>>  		break;=0A=
>>  	case REQ_OP_ZONE_OPEN:=0A=
>> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> -			return BLK_STS_IOERR;=0A=
>> -		if (zone->cond =3D=3D BLK_ZONE_COND_FULL)=0A=
>> -			return BLK_STS_IOERR;=0A=
>> -=0A=
>> -		zone->cond =3D BLK_ZONE_COND_EXP_OPEN;=0A=
>> +		ret =3D null_open_zone(dev, zone);=0A=
>> +		if (ret !=3D BLK_STS_OK)=0A=
>> +			return ret;=0A=
> =0A=
> same here.=0A=
> =0A=
>>  		break;=0A=
>>  	case REQ_OP_ZONE_CLOSE:=0A=
>> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> -			return BLK_STS_IOERR;=0A=
>> -		if (zone->cond =3D=3D BLK_ZONE_COND_FULL)=0A=
>> -			return BLK_STS_IOERR;=0A=
>> -=0A=
>> -		if (zone->wp =3D=3D zone->start)=0A=
>> -			zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
>> -		else=0A=
>> -			zone->cond =3D BLK_ZONE_COND_CLOSED;=0A=
>> +		ret =3D null_close_zone(dev, zone);=0A=
>> +		if (ret !=3D BLK_STS_OK)=0A=
>> +			return ret;=0A=
> =0A=
> And here.=0A=
> =0A=
>>  		break;=0A=
>>  	case REQ_OP_ZONE_FINISH:=0A=
>> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> -			return BLK_STS_IOERR;=0A=
>> -=0A=
>> -		zone->cond =3D BLK_ZONE_COND_FULL;=0A=
>> -		zone->wp =3D zone->start + zone->len;=0A=
>> +		ret =3D null_finish_zone(dev, zone);=0A=
>> +		if (ret !=3D BLK_STS_OK)=0A=
>> +			return ret;=0A=
> =0A=
> And here too.=0A=
> =0A=
>>  		break;=0A=
>>  	default:=0A=
>>  		return BLK_STS_NOTSUPP;=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
