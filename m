Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C12C433E7
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755BD22B4D
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RAWq+MGx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jC3+V7Db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGTIL1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:11:27 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11650 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgGTILZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 04:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595232685; x=1626768685;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UMmN3Xrac2pZJh3vEIMjt0okQNS2vVQtBw6wQ5S9nYU=;
  b=RAWq+MGxeuicxBjP8vsPfbT66k7PoOIoLfFW74xg1dQDC7juJmsuUYN7
   THTuNN3Iaqds8AD7FLDtJLhJzEVE3xb65k0yqyG2mZjlAaWkiCJCT7jsG
   jIAXSY9DEXEVXEzW9W6G7QEvEGp5EYyTh5Cgj7x2pa1+Bymz5YImodq2r
   ITgdEZPA6tiVupeVAh2EFTWIVGeBE9OvciJa28K6znAMgY7hyq5YkKkbC
   nipz6OfP1nroxTYvD5Jcc/F8isCqHCyZscd+HSrZM0X66kNxL9E6ZM1T0
   K4nkxoRZywKKzWsLQxnU4FLYQ5945JrwGTvTO2iKbiMkJSeOCUYiHf5kR
   g==;
IronPort-SDR: S34q55maSgTn6B/WZMVfyGIqCrH2DC7bT+RVlrRJwTkj1IbM1VTcVcqgknjy+IvtotVsMJtmY6
 tZtAnJ4VEWIfpFpERW/YXYnRIS9iI2mfh4iNzQYwUD+1LL+VsTONX7y0pMo/IEIWTlA23++yqv
 lNUpVvfw8FjW7uz077wBSjEb0GPNxnlPxSUa/oES4NKzn8UKHfKc2TOhFHGKmwqwbDhN88lbew
 Hd8qYGR4LC3Yx6Lh1m0UK5MXK0AeSW2BFvqwDmSwBd9/nW7yKZZzjNoeIHVWkmjIujGVbeeuTu
 5Y8=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="252169072"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 16:11:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuMn3JXqvKOhz5LNCaJM1S6BS5MViR4+JyMRvr+vVn5Ho+JvLqgbsEU7Rij9rz2FvgPplZs4nE8IKGVcG41UiPnhPNK/S2TyohTAXvZtZZt8uryhPShSXodDQpwe8k7DwSSV7voDqGW1qI8lWS/wxFOQ44bImgUg1wi4iEWLd7QClCKJ7D3z+nfSPAUbytzmW3vXARGVnE2Plk2ZlYf2Hld3cBa+Ryu/TIzLvNIgJKbypJXiD+FvAhIvEKP+VcjNJ0G61XxKOLq6xquD6kel1Ih+LawB8YSw+by6vvz7lVydAWkBk+5ohLxLs8kf43ccIbkA0kpTbAwfSJr93DhqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5XbAFDKlsgmaGUonFhnhcOsP9Qj/N1++Fkox92s8m0=;
 b=N/PCP6ngFz1Um/7zLdjxXy6/oZSP4MXZTaQHxmm9brll6rXSjDZjbdP28EAQn+udU2dos7nLbnS8FHw4wIrg394bfDqpCRS0nXeW/fl+p6neSklY+DOXqUGvp8F7HqEp80ZQV5nsJj+Ugje5OiisumiX8M1yE8GK2E47/VoGVuaF880W1D2LrRbR3b640SHhEA18HB65KNKjLMh6cItFc3HhJn/K4CaiiZAJHGR5Nu7KXLcWo+L3uh6AMGD9SWs1mTaxW8r7fevH+AfxoBzt5aeC1NSd9KO8cJHedW0Kqoy2d2e8tjPod152VrtU505K8AaftY4KDk31XwhB3iBRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5XbAFDKlsgmaGUonFhnhcOsP9Qj/N1++Fkox92s8m0=;
 b=jC3+V7DbvkRzjOrRJDMc8TwVNYG/FQullMTZctWAjllY+gqraTqHcsHr6KakOm7RepotwgOH8QplFlkkv9kK5TI3V90KkQ0jGIRchDPVvOJItOb3x3bwgfFdqF34IqAZTSbc855VvmLy7A/fjt9tkzHeIo6xiXhtdhOY1f0eSzQ=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2220.namprd04.prod.outlook.com (2a01:111:e400:c60e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 08:11:23 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:11:23 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH 2/3] block: remove bdev_stack_limits
Thread-Topic: [PATCH 2/3] block: remove bdev_stack_limits
Thread-Index: AQHWXlzTg7R0GrKIAkSqC/1NtcRXyQ==
Date:   Mon, 20 Jul 2020 08:11:23 +0000
Message-ID: <CY4PR04MB3751CDE47A50C4F06D4C97F9E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200720061251.652457-1-hch@lst.de>
 <20200720061251.652457-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c512c907-4ff0-4fd7-d266-08d82c847de3
x-ms-traffictypediagnostic: CY1PR04MB2220:
x-microsoft-antispam-prvs: <CY1PR04MB2220AFF26A5AED40C3E0574AE77B0@CY1PR04MB2220.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:172;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: duaJhkUFj1GSZPJhP44F0kfpKgLGQbAEqeQE9+SmOgfMLD8o2Bqkd6J8lZnZVpV53L1ORh9zrvPv89yMh68OI4CUvnnIsrXRax+gsYWQgJ0ZMTDQob5Z6HT7WML72D6F8eGdXjvIcF1G1fzYHrmQ9iCIxDji+D6JRKFpx7bHCl5O1BJrpfLSWQ6hF14TRGBERw33hJQLKASNvXHDy3mi0+0dl3JaJqgRsDJi1BwEYMOvTXscvVIxCoKSaWQ6XisazdamJoZOKAxo/I2PxRG5YA80an7xJlQIy07njKxFpKpMnJsfPZFeXtrUKzJ9oecWTvkGeEzJ2nnu68U8omgCUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(83380400001)(8676002)(7696005)(71200400001)(66946007)(316002)(55016002)(66476007)(2906002)(8936002)(478600001)(53546011)(6506007)(186003)(33656002)(86362001)(5660300002)(110136005)(52536014)(66446008)(64756008)(66556008)(4326008)(26005)(9686003)(76116006)(91956017)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mtCAzvsctP+s7uiEiFTwa+5OO0O5YueLp/yMyrVREfuFxCn9pAPntaUTvzefIiYnm9POdhsoyvIXmvug/15LtuZmmSedUVuxVxPs133opAPIzdadTnRW2KaHRw8uUtB6UT/eDe0Kwl7tT53Hql/EwUKgddMSsXnzusqJKRzggwPwKhduNys0FkeD7jTnlDclu3Fqs+AK6r2BLbVetbKtVq8q/XBL4VYHHaBlEpw1LPHajaIaKwsXfy7Hm86feBPYtWaMxpHks20HIq/HA6DfV+8v0+6dGhqzXHRyEnJVKnzCxlPuCCr65T7FRviW3G84SI5EZ6QPPfTFrhAkMl7xD8/KFtYVkrrT4fXXLx19CqXfkGziHULC6OHYyAKBbIMnxSC/80/pue/0NrTY2n9hgAlEABcCtt+02ibg47LxcPgum/Cg17owetc9ykI3hjVTNFQv6CwWbQAO0ZSAkUXYJx00J/pGf1hFfvJ4O/lUfvrYBQkPpM9xhn3eQ72AYM6n
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c512c907-4ff0-4fd7-d266-08d82c847de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:11:23.1703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jXMbUCC8hRIQbYv3uy7j5UDlW3DxWazzx7Mgo+HenB4gTgMY5X5RNuNpQ7XJmDvxVELiHuJvRRgXkRYBuektQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2220
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/20 15:13, Christoph Hellwig wrote:=0A=
> This function is just a tiny wrapper around blk_stack_limit and has=0A=
> two callers.  Simplify the stack a bit by open coding it in the two=0A=
> callers.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  block/blk-settings.c   | 25 ++-----------------------=0A=
>  drivers/md/dm-table.c  |  3 ++-=0A=
>  include/linux/blkdev.h |  2 --=0A=
>  3 files changed, 4 insertions(+), 26 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 9cddbd73647405..8c63af7726850c 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -614,28 +614,6 @@ int blk_stack_limits(struct queue_limits *t, struct =
queue_limits *b,=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_stack_limits);=0A=
>  =0A=
> -/**=0A=
> - * bdev_stack_limits - adjust queue limits for stacked drivers=0A=
> - * @t:	the stacking driver limits (top device)=0A=
> - * @bdev:  the component block_device (bottom)=0A=
> - * @start:  first data sector within component device=0A=
> - *=0A=
> - * Description:=0A=
> - *    Merges queue limits for a top device and a block_device.  Returns=
=0A=
> - *    0 if alignment didn't change.  Returns -1 if adding the bottom=0A=
> - *    device caused misalignment.=0A=
> - */=0A=
> -int bdev_stack_limits(struct queue_limits *t, struct block_device *bdev,=
=0A=
> -		      sector_t start)=0A=
> -{=0A=
> -	struct request_queue *bq =3D bdev_get_queue(bdev);=0A=
> -=0A=
> -	start +=3D get_start_sect(bdev);=0A=
> -=0A=
> -	return blk_stack_limits(t, &bq->limits, start);=0A=
> -}=0A=
> -EXPORT_SYMBOL(bdev_stack_limits);=0A=
> -=0A=
>  /**=0A=
>   * disk_stack_limits - adjust queue limits for stacked drivers=0A=
>   * @disk:  MD/DM gendisk (top)=0A=
> @@ -651,7 +629,8 @@ void disk_stack_limits(struct gendisk *disk, struct b=
lock_device *bdev,=0A=
>  {=0A=
>  	struct request_queue *t =3D disk->queue;=0A=
>  =0A=
> -	if (bdev_stack_limits(&t->limits, bdev, offset >> 9) < 0) {=0A=
> +	if (blk_stack_limits(&t->limits, &bdev_get_queue(bdev)->limits,=0A=
> +			get_start_sect(bdev) + (offset >> 9)) < 0) {=0A=
>  		char top[BDEVNAME_SIZE], bottom[BDEVNAME_SIZE];=0A=
>  =0A=
>  		disk_name(disk, 0, top);=0A=
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c=0A=
> index ec5364133cef7f..aac4c31cfc8498 100644=0A=
> --- a/drivers/md/dm-table.c=0A=
> +++ b/drivers/md/dm-table.c=0A=
> @@ -458,7 +458,8 @@ static int dm_set_device_limits(struct dm_target *ti,=
 struct dm_dev *dev,=0A=
>  		return 0;=0A=
>  	}=0A=
>  =0A=
> -	if (bdev_stack_limits(limits, bdev, start) < 0)=0A=
> +	if (blk_stack_limits(limits, &q->limits,=0A=
> +			get_start_sect(bdev) + start) < 0)=0A=
>  		DMWARN("%s: adding target device %s caused an alignment inconsistency:=
 "=0A=
>  		       "physical_block_size=3D%u, logical_block_size=3D%u, "=0A=
>  		       "alignment_offset=3D%u, start=3D%llu",=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 67b9ccc1da3560..247b0e0a2901f0 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -1106,8 +1106,6 @@ extern void blk_set_default_limits(struct queue_lim=
its *lim);=0A=
>  extern void blk_set_stacking_limits(struct queue_limits *lim);=0A=
>  extern int blk_stack_limits(struct queue_limits *t, struct queue_limits =
*b,=0A=
>  			    sector_t offset);=0A=
> -extern int bdev_stack_limits(struct queue_limits *t, struct block_device=
 *bdev,=0A=
> -			    sector_t offset);=0A=
>  extern void disk_stack_limits(struct gendisk *disk, struct block_device =
*bdev,=0A=
>  			      sector_t offset);=0A=
>  extern void blk_queue_stack_limits(struct request_queue *t, struct reque=
st_queue *b);=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
