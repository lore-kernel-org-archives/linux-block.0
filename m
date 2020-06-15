Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD8C433E0
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E24206DB
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RuYRL8M8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LJqPSAC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgFOXqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:46:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3621 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXqa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 19:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592264791; x=1623800791;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tVUVNc9sbl9/bbpBzV9CmLSd206pRdXabr+3vVCtXYg=;
  b=RuYRL8M8yoyD4k7yFM7ghCpvJ+ncgT9t1V9RUwWp7Iqi9qmyNVZRbTnC
   onlyN/fu+jiXDEPBVSTbA+19BmMWeavECuOZw3HyaS8Cb82UgxtGj3F3I
   /qNs4oJ3votA5+i+16J4bJr3I4ltTykuWsUOfUqVsELSErCRBIkxXteMJ
   VsS2k8cEGqqpPVdo3fkWIGJ33zlVYGmtkt1z4DPvoN6AYL0RlyCpCcFum
   048gYuEp8+7m2AxTZDQ+tPQG3frn6PA0cWqrHwNoA9yibN01koLq8hlay
   AjxMRdmv7neF00wxSo/lbpNAmGC9MM8GOH9dwuB/5j8OE58ckWsjqYWVO
   Q==;
IronPort-SDR: hYZ0t5WTLB2vvTNMgVttOJgAMJeIAtJB5s8ns/zeH0M16cmLsmVZtyCfz+fdyKADPlU0ubBf84
 0hw5+COF2CFQGEqdxd0TfutHxEPDp78DuucCkZFQlPBCiFPZs7byyjnl9ZTG3P+NHEQKV013m0
 6ieoPwTDjB/UThtA+1J7uCWxqLEuBN+vEyDXioCl/xgTyHuqpXKSCHYwPmAO0j7LTtUSHTfVLp
 g4CNP8hBjvn5UZDAxxP4HDAT3cw/Fpza2Kqyg2rdkB1iAc2aAKlWU/ABlGiKw6KKXPtfsdIaQc
 6KQ=
X-IronPort-AV: E=Sophos;i="5.73,516,1583164800"; 
   d="scan'208";a="144394932"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 07:46:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzxs47TSxCPgr5oyhJltH+/zvvdPVuRUfJEOrG75BKientRFp5zQhSzwsaPl9qIefPQBtfOKVPkQaET5SCc44JHqw7FT/bXln6Y6icesEampZgS+rDN/j6SoEjtfhFp7Q+FtBw02GIydLfzLUTpUiTs6puONv8LyVjuY1uLIldY/pLSDLOQPvYRhTTbbIaLGs4Dg4JGNJuo/fUZKdGCnOliGrNr/EXObQkRx6nD463JWlBQBpt0ope82dxJ07tEmxFHtLlMHiNDO2UNCSqxWNSeE6mYke1vhAjdxCdc+XU44xkTYCG5cbE2UU3+ndVO0LWezh+o5RiyS+euHaHyQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLEwv9b8J6eGd+cjaUn1MZ7nzn9XhBMJKVYLPvKh8Zc=;
 b=GFwXoKegIpYLmedw9A5QuTuEd2LRnBWm91NZNynP4hn22V826Jjun0lh8AY7fBQre7HGA3GtRW/1//lUvDwTpDB3Of90tB0+D8tdaSFSWFiFNYO+oNfwvUZSoA5skc9vedn+ONgzirXZelOfz/uvAa/7W/zoJqB2/Tf68HR1WeOj5wnQO+LcLFAqVzLovt+iozJM8YCpSeNXWpibqg0Smdi/rJrgHDu/ZIH3ravPIrsyRhQxk4kfp8Nd08M7fORpqL1ahw+ZJbdT7F87upN8T24fC7JctJ3xBj0SaUKNrLGPfzsEbPs13lbRmhE+p9Mdbojyeh+z+bpIgLpWKBxYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLEwv9b8J6eGd+cjaUn1MZ7nzn9XhBMJKVYLPvKh8Zc=;
 b=LJqPSAC5Mn1aFlp4xmR1XSvCqTT/VMMiewq9LwJAOYQvNmpzw2OhgnRzpT1k+FhBBZ7XHcBP+CExp8Zy5ujCSNG8ft4QQpymJzZj6HZFykq8Aly6cR2HnSSqqewk26C6UkZ1ArC1801rQz5UrSpRHYrjnD2Zfh7dL59zk0CVUNM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5334.namprd04.prod.outlook.com (2603:10b6:a03:c8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 23:46:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 23:46:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>
Subject: Re: [PATCH 2/5] null_blk: introduce zone capacity for zoned device
Thread-Topic: [PATCH 2/5] null_blk: introduce zone capacity for zoned device
Thread-Index: AQHWQ22kUu9c0Grr/EKhSnAaI+KUeQ==
Date:   Mon, 15 Jun 2020 23:46:25 +0000
Message-ID: <BYAPR04MB4965573D0109F13F1E6BA8D1869C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-3-keith.busch@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af1c9bca-82d7-4aa2-3190-08d81186519e
x-ms-traffictypediagnostic: BYAPR04MB5334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5334DA949AFA00F1221F7F13869C0@BYAPR04MB5334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgcq9idPYki2pfNLM4LgeOzyUL2PQHCnQiJAUt8RdhUpdvDfGP5AwRl/jE75RPkEmhSA3CcPxq2tw8WuiL3kpfcPHwD7RTret6TaDudCZrOn2utteD7GhviNzL2D/Knz02LoW1eOUPD6LoIDtPP4w0R5Bn1bUse2eROMpGc3ECSRzxILxstmYpPXSFkqpA7jVTJ/8rhUragEFlYbAZsKlREQetio35am3rGwpYGjf+P3Mij4gASZ8dwZ/drX2DTrqyXihpRaK6YPBRuMg8sBsTZw79x0Xq2P9ETkXBmPgJrIKT72dui2P657AYK4OI9m7O0AZyU5alSgKK9ZV9GmTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(7696005)(52536014)(478600001)(9686003)(54906003)(26005)(76116006)(66446008)(66556008)(2906002)(71200400001)(64756008)(66946007)(66476007)(8936002)(86362001)(316002)(110136005)(33656002)(8676002)(186003)(55016002)(83380400001)(5660300002)(4326008)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: grL7mWqVW1uhZfYcUKZOJzqe2TJIoWnd6ZLAZVeQogZP2Sp+utlM83YdQcj8FN5Ber0zs8WmMQQBuH0Lo9EPZf1wQJTEuzswlCiId6AGvZWl3S0TDpat9STQLzM8yuovgTYGVgofdoPiDIHfTOKbbRHEqTRrcV5se4dYNlZtYAwPE5EWJv9hm4CjxQG7/sxPtXnVvpUUEBVQtXldT799tIXULEdRrNve5vJHXvR0X5vvtiwA8m8gSKbzbL/Art3ZbTnw3rQJOO63b/sn2LCD+S9p8emFPobHs3aly9mchjhH9gOKQbO1tH2K4QtogrnWkEbQzFds/e+WlRUIlUYAWiM98UiWdc0/8+fJ9C5dE90CCwtBLtO35iLE1WAJAqL0tyVDfX0/3xgHI35/9Yq3BOhVm1enNTBnTX8WaV16Au8CscfAns7fDe+5jqqgxY0cDHHyzCUTxYddoKIUDY50X63ZHM/uIMfiqWLGfVJszsI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1c9bca-82d7-4aa2-3190-08d81186519e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 23:46:25.9930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1ctAq3obG6G6Vv18gXm7Hl+Jt4eLV29FZLCj0+C4kJYzA7Yi0LD+ojxbJo0+3EoWbkTmUtow+2y1qt1f5zYdsoivmsMPTRvq7NTFyeHojw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Apart from couple of nits this looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 6/15/20 4:35 PM, Keith Busch wrote:=0A=
=0A=
> From: Aravind Ramesh <aravind.ramesh@wdc.com>=0A=
> =0A=
> Allow emulation of a zoned device with a per zone capacity smaller than=
=0A=
> the zone size as as defined in the Zoned Namespace (ZNS) Command Set=0A=
> specification. The zone capacity defaults to the zone size if not=0A=
> specified and must be smaller than the zone size otherwise.=0A=
> =0A=
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>=0A=
> ---=0A=
>   drivers/block/null_blk.h       |  2 ++=0A=
>   drivers/block/null_blk_main.c  |  9 ++++++++-=0A=
>   drivers/block/null_blk_zoned.c | 17 +++++++++++++++--=0A=
>   3 files changed, 25 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h=0A=
> index 81b311c9d781..7eadf190528c 100644=0A=
> --- a/drivers/block/null_blk.h=0A=
> +++ b/drivers/block/null_blk.h=0A=
> @@ -44,11 +44,13 @@ struct nullb_device {=0A=
>   	unsigned int nr_zones;=0A=
>   	struct blk_zone *zones;=0A=
>   	sector_t zone_size_sects;=0A=
> +	sector_t zone_capacity_sects;=0A=
>   =0A=
>   	unsigned long size; /* device size in MB */=0A=
>   	unsigned long completion_nsec; /* time in ns to complete a request */=
=0A=
>   	unsigned long cache_size; /* disk cache size in MB */=0A=
>   	unsigned long zone_size; /* zone size in MB if device is zoned */=0A=
> +	unsigned long zone_capacity; /* zone cap in MB if device is zoned */=0A=
>   	unsigned int zone_nr_conv; /* number of conventional zones */=0A=
>   	unsigned int submit_queues; /* number of submission queues */=0A=
>   	unsigned int home_node; /* home node for the device */=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 87b31f9ca362..54c5b5df399d 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -200,6 +200,10 @@ static unsigned long g_zone_size =3D 256;=0A=
>   module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);=0A=
>   MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned=
. Must be power-of-two: Default: 256");=0A=
>   =0A=
> +static unsigned long g_zone_capacity;=0A=
> +module_param_named(zone_capacity, g_zone_capacity, ulong, 0444);=0A=
> +MODULE_PARM_DESC(zone_capacity, "Zone capacity in MB when block device i=
s zoned. Can be less than or equal to zone size. Default: Zone size");=0A=
> +=0A=
>   static unsigned int g_zone_nr_conv;=0A=
>   module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);=0A=
>   MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block=
 device is zoned. Default: 0");=0A=
> @@ -341,6 +345,7 @@ NULLB_DEVICE_ATTR(mbps, uint, NULL);=0A=
>   NULLB_DEVICE_ATTR(cache_size, ulong, NULL);=0A=
>   NULLB_DEVICE_ATTR(zoned, bool, NULL);=0A=
>   NULLB_DEVICE_ATTR(zone_size, ulong, NULL);=0A=
> +NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);=0A=
>   NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);=0A=
>   =0A=
>   static ssize_t nullb_device_power_show(struct config_item *item, char *=
page)=0A=
> @@ -457,6 +462,7 @@ static struct configfs_attribute *nullb_device_attrs[=
] =3D {=0A=
>   	&nullb_device_attr_badblocks,=0A=
>   	&nullb_device_attr_zoned,=0A=
>   	&nullb_device_attr_zone_size,=0A=
> +	&nullb_device_attr_zone_capacity,=0A=
>   	&nullb_device_attr_zone_nr_conv,=0A=
>   	NULL,=0A=
>   };=0A=
> @@ -510,7 +516,7 @@ nullb_group_drop_item(struct config_group *group, str=
uct config_item *item)=0A=
>   =0A=
>   static ssize_t memb_group_features_show(struct config_item *item, char =
*page)=0A=
>   {=0A=
> -	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache=
,badblocks,zoned,zone_size,zone_nr_conv\n");=0A=
> +	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache=
,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");=0A=
This line is becoming ridiculously long even for new 100 char limit. =0A=
Maybe we should do a cleanup patch for feature to string conversion.=0A=
>   }=0A=
>   =0A=
>   CONFIGFS_ATTR_RO(memb_group_, features);=0A=
> @@ -571,6 +577,7 @@ static struct nullb_device *null_alloc_dev(void)=0A=
>   	dev->use_per_node_hctx =3D g_use_per_node_hctx;=0A=
>   	dev->zoned =3D g_zoned;=0A=
>   	dev->zone_size =3D g_zone_size;=0A=
> +	dev->zone_capacity =3D g_zone_capacity;=0A=
>   	dev->zone_nr_conv =3D g_zone_nr_conv;=0A=
>   	return dev;=0A=
>   }=0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index 624aac09b005..b05832eb21b2 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -28,7 +28,17 @@ int null_init_zoned_dev(struct nullb_device *dev, stru=
ct request_queue *q)=0A=
>   		return -EINVAL;=0A=
>   	}=0A=
>   =0A=
> +	if (!dev->zone_capacity)=0A=
> +		dev->zone_capacity =3D dev->zone_size;=0A=
> +=0A=
> +	if (dev->zone_capacity > dev->zone_size) {=0A=
> +		pr_err("null_blk: zone capacity %lu more than its size %lu\n",=0A=
> +					dev->zone_capacity, dev->zone_size);=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
>   	dev->zone_size_sects =3D dev->zone_size << ZONE_SIZE_SHIFT;=0A=
> +	dev->zone_capacity_sects =3D dev->zone_capacity << ZONE_SIZE_SHIFT;=0A=
Do we really need zone_capacity_sects ? As far as I can see its is not =0A=
used into fast path, correct me if I'm wrong.=0A=
>   	dev->nr_zones =3D dev_size >>=0A=
>   				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));=0A=
>   	dev->zones =3D kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),=
=0A=
> @@ -60,7 +70,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struc=
t request_queue *q)=0A=
>   =0A=
>   		zone->start =3D zone->wp =3D sector;=0A=
>   		zone->len =3D dev->zone_size_sects;=0A=
> -		zone->capacity =3D zone->len;=0A=
> +		zone->capacity =3D dev->zone_capacity_sects;=0A=
We can just dev->zone_capacity << ZONE_SIZE_SHIFT here.=0A=
>   		zone->type =3D BLK_ZONE_TYPE_SEQWRITE_REQ;=0A=
>   		zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
>   =0A=
> @@ -187,6 +197,9 @@ static blk_status_t null_zone_write(struct nullb_cmd =
*cmd, sector_t sector,=0A=
>   			return BLK_STS_IOERR;=0A=
>   		}=0A=
>   =0A=
> +		if (zone->wp + nr_sectors > zone->start + zone->capacity)=0A=
> +			return BLK_STS_IOERR;=0A=
> +=0A=
>   		if (zone->cond !=3D BLK_ZONE_COND_EXP_OPEN)=0A=
>   			zone->cond =3D BLK_ZONE_COND_IMP_OPEN;=0A=
>   =0A=
> @@ -195,7 +208,7 @@ static blk_status_t null_zone_write(struct nullb_cmd =
*cmd, sector_t sector,=0A=
>   			return ret;=0A=
>   =0A=
>   		zone->wp +=3D nr_sectors;=0A=
> -		if (zone->wp =3D=3D zone->start + zone->len)=0A=
> +		if (zone->wp =3D=3D zone->start + zone->capacity)=0A=
>   			zone->cond =3D BLK_ZONE_COND_FULL;=0A=
>   		return BLK_STS_OK;=0A=
>   	default:=0A=
> =0A=
=0A=
