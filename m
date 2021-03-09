Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6950C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 11:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B97F65101
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 11:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCILQo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 06:16:44 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21611 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCILQ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 06:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615288587; x=1646824587;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=My7fWdw2fDRtwbded7OrA//vmCSNGATX/vQdEn1125k=;
  b=Xl5Es1bSvUIKAhkwmnpAFd9TFq3LLmWq0klSlWyV1++3AnaaphGlkdsX
   d/ZDRo5XyAhy7F5yAcI0/Ntj9aXTQMExnWXe0MFsy4cinpSeVvdgle4uV
   p5k0jTxg2eu9FwFvNPNGFyTpJ5K3UFDPsISyv3a0/zQqxY8s6mMD54Wkh
   GnO0O0TxDCv3EsVUATq1mt49CrpaPjkZIynRO8Kg5rHSDJew14DWfRJcP
   0dKnNxuavzP2Yz0XeGph4Vippy8BgzMFyYHVuiWSj7iTod2zqwLDOAz/J
   3oTDdGXr8sDvuRvjakSA498F4nnzhVB/9LLxpTVjaglX9L8ibLxOOw0i9
   g==;
IronPort-SDR: 5czpCfUKuXnQ2piNRUBvFX0HLie1ARn1uXFsl8hcigvSOmsKKDLLGjieZWURW5KoYqmrMKQExo
 65x/iWFsqXZ0SBKo+IS+ezzMrT1UFqWVjwhrKICI/zG1+FZsN1UqNaY6oRUrmPcb3zLNUlcF35
 y/Lc7E3oe8W/xlASH0k6YrOXbKK8FlPw9xfFvnH5Ed0i/yJejyDzSFko5whwsSSB7/mDeT8j8f
 EW0HyEEAmG5/9VCMvnHaA3n2UY7Fgo+eZBorgxMdEIsDE9NsPrL6+2sdL8+BQTQ108JWOZqbnC
 xTw=
X-IronPort-AV: E=Sophos;i="5.81,234,1610380800"; 
   d="scan'208";a="166207928"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 19:16:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjBL19qdxfV2PNJHFkNa2Do3Gx2MKd8O6zImo9ZQEJKDTIuGmZxKBmIcDef7o3epJUkXxwBU+ZnEyL2wKxHOJPy3YeWurIergz6LNf5058fzeZY86kWbsLfWtZ6F9H0xmF2pCVPxrobHNb1OgWlVEjKlyPFf+YHN8p11dsFFddq0SI2wTtHLvE/Na4uuoVwzMQIGI1m6qWo006DC2lnWvUDn5hgGjtk6RyfbbowbNLPv4d4Z0LtCB2pCzYXLfzBHJT2akKSRtbzD4mx+kASW8SWTVL/IA4BU8G9aEeFXn+teOqxZI67EmBtHcSUVDZPdDkGJT4UEKKgzKuHjQTtw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFpaTMBRwpWcJEAjeBzjtIp+PwoKrbx+r5kjDZwle/Y=;
 b=KSgSOs248EW9j77fZyFr0Xl2GENgKr5L8V0/413+l2fFJPs35ehgegkp+UZnzP8SgTI3URLMsaEM3R3KDSNPEa51b8/uxlo0nJG5nG0UZfhoqJF6ZzdnYpt+WgDevFDjUBvl6eRPc5b8IOSizAzcOUNdUN5orukQGCCAoZKLXDGZfKEFJmBIpqUoL39FqZvPyDlKMGmx9H/XKjdvzSNaXGba0E4SPPJagkVaEIk8SFwZqp5PRvy3WO+B9MzWcpdRJkngepqPG9AnYK0qbWQFuaTSisyAjzKvIrRu1xFEC7C58U0atIwIwKm7XeFTUB0cJxWgdM5/eDprv4R/araZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFpaTMBRwpWcJEAjeBzjtIp+PwoKrbx+r5kjDZwle/Y=;
 b=yAJwiG4bquuV1KmkEmHby1hB+Ml5ot0oiAgJBMD4GFWIhPjJBDIHj2jH7cnZFqD4nHYttrD12ttxCJAfcK+B+aplvHkX3lwe8/qZJDncmBDHecxS5l82Q1JqTt/aeFM+8Apv/A6nu8N6u8A63D9fyfViwIBgVfSwPsaLE7rhaEE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4643.namprd04.prod.outlook.com (2603:10b6:208:4c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 9 Mar
 2021 11:16:24 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3912.026; Tue, 9 Mar 2021
 11:16:24 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: Discard page cache of zone reset target range
Thread-Topic: [PATCH] block: Discard page cache of zone reset target range
Thread-Index: AQHXE8uxli1x9EljZkeik2Tn6fiJcQ==
Date:   Tue, 9 Mar 2021 11:16:23 +0000
Message-ID: <BL0PR04MB651499F9C2BED9DF65E42A64E7929@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210308033232.448200-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b5c2:5e8e:bd4a:dfce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23e0abdf-1ed8-4d1d-c8f4-08d8e2ecc65d
x-ms-traffictypediagnostic: BL0PR04MB4643:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4643387ECE9C07F019752F4BE7929@BL0PR04MB4643.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xegk5g/JKmazt2RyRe7xYXsK3z5cdjEuic2oM/1FJs3DhF2wmeq7sznRpEvV1Alda2pdeCKo4gnHpQLrajZRSpfwIkjB4S1M34iXdDAeTxVDNr6MG0DWfgo1pOCZsedCKcpSh3pKotb+HR4CCFw16GOdv3GmyzoppS41Rjhl8Bjp6dNRUqZPC8oWKT0msEfX5KJxN2Gt+qVMVOtP+SlabPVX1hEYcCWlhAd7uGT04pOhiUYlDGrNIqk7rz3JMyp2xV94Uh2ecgwVD+M112/Izxk+p5bcHuDDkO1Rk1n/epxZ1mF1ANgjTvLy76YWyS7Wh9WLQS6PmwNbU2kyhlmLlwYe3/wr24/WdYJGzRmA5SgDkDIhKRZdkO6Gs+Nqs5TSBVUDI5H1LAOCGj+PATAf2oSLDSPwaFNn5iSqT3VGPP3c12oUHryDQgx+WM01lzx2QjPWh1zDMY9rqa4x3cyV/XOW1fBOjOh81yRc7rHBJvI2N2nm/8f/FYbBw8ch0cKo3jNQslqkZVTk18gZwhHfgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(54906003)(316002)(4326008)(5660300002)(83380400001)(2906002)(6506007)(71200400001)(55016002)(33656002)(86362001)(53546011)(7696005)(110136005)(66476007)(478600001)(8676002)(91956017)(8936002)(9686003)(76116006)(64756008)(66946007)(66446008)(52536014)(66556008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VMZ+okfBbI4ZBdEMYpdZQQy93Ll0g4RonzQ+K+MH++w19oKWOjBO9hPLC6+1?=
 =?us-ascii?Q?kGWZFTTSnxuvK7wPFFnvg4tCrTwK6bWmTRydLwyjE+JA+KnZYUaqmWOHPWz1?=
 =?us-ascii?Q?KfxJbJ+rKdvBj94iCigspMXjMYahw4FX4Pbsd8ZEsBaNzlzcfH9PjXyo1vvA?=
 =?us-ascii?Q?ZEtBnOlZNvFe21jTsxhbXR9QyiRL5sRGjMYQd36cNvfJkOoRhy9eZMxs12a0?=
 =?us-ascii?Q?gnHP7b36ZIjfQiq+/Xs5of5B4yZVTcdXBMzaHWzDCsrq55zQIqO/YKO3qNoS?=
 =?us-ascii?Q?0UIu8AWH7Puc0rTcp/kI7bUxj5uBAWNOj7vcO+G01euX53dvDceDsSTuZ3NI?=
 =?us-ascii?Q?zVlTcVfEtpMhoiBB5G/uCJoHz1wDzHY3V5+2RJfFoaL0815pRhpdVpDLSGiN?=
 =?us-ascii?Q?l8OhA+qhsNnOiFkoYpU2ujwsKuE17kGWwPrQraAZMeC+oukITkBl3VLk46df?=
 =?us-ascii?Q?RUD7Rx8nrdVGS2+9F9gKshlgLy66gYnKZqaPGzHhb3I4KY5qLNr7wzOkn8ro?=
 =?us-ascii?Q?KLiQWOSZSuXiL0tWzC9+RI0pNGgbYgePG8oqTVX2eZ1GkF+wpfISTbqftNEd?=
 =?us-ascii?Q?cvsq9VfoNxc0IuFGCO3UGNC7UUaI5u5Ozci5NPvg6pRbJAd0Q2qyXO5chyEp?=
 =?us-ascii?Q?rrn40GnOhXo7yYzGa8js7jaKjTVQqZRJA/R2EP8qET/v/S9SQv9/+3FjDGTw?=
 =?us-ascii?Q?PJ9h3q27AIL5OX+VvfweBMSXTaj98Mh/x+MobNOS5fIkIkf+xtl5OLQOITlI?=
 =?us-ascii?Q?beWPLAztQk5gp5BoWzIEsYyeS+WnQZ2LMi+9KoAs7ptaS6vNWgCg8fWwJPCf?=
 =?us-ascii?Q?6bec3BSCTfSAumuQS/7ZMMnA3WhEPS3AIHaSUp0dNS2q7PPHI9+cyjuwYL03?=
 =?us-ascii?Q?9H9tVrDlHgAtw16kv8E7WkaKxdwiygpcE7SAewZBm67oW5L2aBoq1tfel3zS?=
 =?us-ascii?Q?oJUs1kWw1FYHFc10HhzBxF/QKmBP+PtydrS13RQOzcDqghfRMWlFim3qIZ9E?=
 =?us-ascii?Q?Q1Z3NsGbc4rtL6BbZxD6CxOrW8ROkrypA/4gHp+E5UcjAwYUj/BIMYhlX/XG?=
 =?us-ascii?Q?cmb1MqVQyyys/VUhy2TEQpCFn5iopdJy0j9T456xMsaQfqLa+hSdvARDCyHl?=
 =?us-ascii?Q?+yWG8lRlH3C/a5tP8Uf/9GsIKB1b2Nbzmumyd4aETCUw1c3kT3QXlcJUHWUE?=
 =?us-ascii?Q?pVxicu09wN2Pyokz8/GcMiyKrEU592SzZ6bYT043Ow9VAKeQSRvcvUbsQbgh?=
 =?us-ascii?Q?RSIEcCa80L0RbcGbnpCSceyWHjokf6HW0KFrulaOCaa+R0gsIsHWH/I/vv5j?=
 =?us-ascii?Q?ybCmY7iJCjVUUAQJanExVjkffRC9JP8seBgkLgC3+cGb+FUVyHyHY8cvt6jf?=
 =?us-ascii?Q?xASp+mzhW9OWBi/tmemDFftOHQL2Y1usC6VgtzwRffC/kbU/nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e0abdf-1ed8-4d1d-c8f4-08d8e2ecc65d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 11:16:23.9864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOhAz6Qb6gxvoX293qWFtsnQyVe3lrvKKZuZsYNVYeAtYdsns/aNztv1g/Qs8TSC7i4aPHZpa2I+9gD+0YUNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4643
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/03/08 12:32, Shin'ichiro Kawasaki wrote:=0A=
> When zone reset ioctl and data read race for a same zone on zoned block=
=0A=
> devices, the data read leaves stale page cache even though the zone=0A=
> reset ioctl zero clears all the zone data on the device. To avoid=0A=
> non-zero data read from the stale page cache after zone reset, discard=0A=
> page cache of reset target zones. In same manner as fallocate, call the=
=0A=
> function truncate_bdev_range() in blkdev_zone_mgmt_ioctl() before and=0A=
> after zone reset to ensure the page cache discarded.=0A=
> =0A=
> This patch can be applied back to the stable kernel version v5.10.y.=0A=
> Rework is needed for older stable kernels.=0A=
> =0A=
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
> Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")=0A=
> Cc: <stable@vger.kernel.org> # 5.10+=0A=
> ---=0A=
>  block/blk-zoned.c | 30 ++++++++++++++++++++++++++++--=0A=
>  1 file changed, 28 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 833978c02e60..990a36be2927 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -329,6 +329,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev,=
 fmode_t mode,=0A=
>  	struct request_queue *q;=0A=
>  	struct blk_zone_range zrange;=0A=
>  	enum req_opf op;=0A=
> +	sector_t capacity;=0A=
> +	loff_t start, end;=0A=
> +	int ret;=0A=
>  =0A=
>  	if (!argp)=0A=
>  		return -EINVAL;=0A=
> @@ -349,9 +352,22 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,=0A=
>  	if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))=0A=
>  		return -EFAULT;=0A=
>  =0A=
> +	capacity =3D get_capacity(bdev->bd_disk);=0A=
> +	if (zrange.sector + zrange.nr_sectors <=3D zrange.sector ||=0A=
> +	    zrange.sector + zrange.nr_sectors > capacity)=0A=
> +		/* Out of range */=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	start =3D zrange.sector << SECTOR_SHIFT;=0A=
> +	end =3D ((zrange.sector + zrange.nr_sectors) << SECTOR_SHIFT) - 1;=0A=
=0A=
Move these under the BLKRESETZONE case as Kanchan suggested.=0A=
=0A=
> +=0A=
>  	switch (cmd) {=0A=
>  	case BLKRESETZONE:=0A=
>  		op =3D REQ_OP_ZONE_RESET;=0A=
> +		/* Invalidate the page cache, including dirty pages. */=0A=
> +		ret =3D truncate_bdev_range(bdev, mode, start, end);=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
>  		break;=0A=
>  	case BLKOPENZONE:=0A=
>  		op =3D REQ_OP_ZONE_OPEN;=0A=
> @@ -366,8 +382,18 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,=0A=
>  		return -ENOTTY;=0A=
>  	}=0A=
>  =0A=
> -	return blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors,=0A=
> -				GFP_KERNEL);=0A=
> +	ret =3D blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors,=0A=
> +			       GFP_KERNEL);=0A=
> +=0A=
> +	/*=0A=
> +	 * Invalidate the page cache again for zone reset; if someone wandered=
=0A=
> +	 * in and dirtied a page, we just discard it - userspace has no way of=
=0A=
> +	 * knowing whether the write happened before or after reset completing.=
=0A=
=0A=
I think you can simplify this comment: writes can only be direct for zoned=
=0A=
devices so concurrent writes would not add any page to the page cache=0A=
after/during reset. The page cache may be filled again due to concurrent re=
ads=0A=
though and dropping the pages for these is fine.=0A=
=0A=
> +	 */=0A=
> +	if (!ret && cmd =3D=3D BLKRESETZONE)=0A=
> +		ret =3D truncate_bdev_range(bdev, mode, start, end);=0A=
> +=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  static inline unsigned long *blk_alloc_zone_bitmap(int node,=0A=
> =0A=
=0A=
With these fixed, looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
