Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988B0C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AF220874
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NRqNpa56";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tRucrq2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgGBJqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:46:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4179 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgGBJqQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 05:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593683187; x=1625219187;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rj1QU67BtrE2Hi7TTgLbeXtScxL1gYwIAB9qnY2HA6M=;
  b=NRqNpa56CPNA4j1XdjbbRAR3JVWW7+dRoaQNLbRxQHO/uWB9+Ts4l48W
   1H5KOsP6eFYJJeHK4mkXuxEy9XJ/uUDou5LpVMUxvmQoi0fNgHgtus9tq
   Gp6IRlDUdz3GcHqC+GzdaYDFE9YPSgPGHtFgsceO/rC2fQmoszAFcw1U1
   MY5Vfi9azDmYEcdur1IV7L2v9m6wOap91d9jG7J2KjAhWEb7VUibYC0tx
   IAafGzyuVOSva4+ZqxkGtIGILqTzHZVf90XFqxdgS1IigVvXSKwcpyW8d
   0k78Vt5GSl2qWBy1josq4cGcK8tXN8n+zVRWW4h3ZiuJMsBkO2jk68N5y
   g==;
IronPort-SDR: 6xqbtMD5pOYnNvse4T6qXwsxOE6RpX9F/UwU6XK6T+8Y+l9cpBbXvbZG+yfvqogQX1aDyX6F9d
 0wJRI+UBjWcb6KYn5V4tYJVPtGctltpL0DfzM6wz1+1iT4X4zzOO20UEB/soHdfoy0cXGRcNGf
 Fn1skYdkeZ0mcWgBqZcdonssad43LMqwuaCMQbTLWoxOSUMASo7PBTiynN92FmEhHNBgEaYRNG
 yh3i+F4xV29NxxGSpC7AlB8rVzeXgIqmWiPzvCccbZd9EWnfvmYfaSqDxTgHS/bygQc6bH62vX
 Jns=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="244488336"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 17:46:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBhmdOqlvlxA6DaiX9yFj30EoN/T0ELAXScQSXqwVeRMP3WxmM6hAg4xhKiVdXTlWOz8rC2kSLIWGcvK3M9lcyniFV28DTzuK4sqQesF+/0uuBgAttfG8XBJ2HbE6y/Dij29aHzzKoa+IQi0yIt5oKsHdfa3Teiw/NAPhSgSmn0kKa2kwcE4i36FzZMpSrYiQAKGWcw/FV8ObX6DFXrTnkQP9wLVHlPqeoRqS0MmWCvbocei6reOhS05Spibo5bliqB08iQYDRdbx/b3gq7ZG42/9Cnq6/hbuE7lRJyEeE89eQ6CpqTAOncU9vqZfrpVKfJrA7Atk+bFHTXVkbRqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5QQJSRITWo5I9LEP4IVjqdXpos30a73owGQElcxIdE=;
 b=NYvmnZ+cQBb6Nl3xDASp37XebcHY4UAZkrWQ0ZVHKOA5zEyosgjUe8CDylSlJW5VWNiQUgabYUAjgC9tnD6KoesV4NjvFvmYaC13bZudrb1FgzEyM5H8VEprIDiV3wsWO99vneIrNrR+Ws5CNKKIqxXRJ7QX5wgPtiS9HOAy0Z9xo6KFgqCrWOriCxiYrkSU8uHyTUoGkto2Frw8B6PMaN+QtyUIuNXxNWL/mQIxyNXu6DLzV4O7xiQyTeH7NWC+87T2eaaUYG5jvwxbZAYtIA3tX7AzIUL1VfkZwnOrw7fa7OzKMtb/kPJZC65eQFHBY0CFa3WfxIibpX9qxJC7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5QQJSRITWo5I9LEP4IVjqdXpos30a73owGQElcxIdE=;
 b=tRucrq2MHqV8sq4PnTqoZuhGumpLQjZYZPFRTxg0kjvcq/LH1uxucy7k7b/lxO8FCcPVYqorbkNYB/Zo1k/wYaG03GzUmh4tVoA1ujx8MybaXjXIdqTc88dX3z/XBurddS8O/etpWdex6czWspoiZVg6ZLB/QcN/X8PTjkathlU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0246.namprd04.prod.outlook.com (2603:10b6:903:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 09:46:12 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 09:46:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3 1/4] block: Add zone flags to queue zone prop.
Thread-Topic: [PATCH v3 1/4] block: Add zone flags to queue zone prop.
Thread-Index: AQHWUFK1aUt5RXCV0Eaj2nicmpl1Cw==
Date:   Thu, 2 Jul 2020 09:46:12 +0000
Message-ID: <CY4PR04MB37519E324412FC96FDE6BFC1E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702092438.63717-1-javier@javigon.com>
 <20200702092438.63717-2-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1d6c221-0a4d-4718-929c-08d81e6cc15f
x-ms-traffictypediagnostic: CY4PR04MB0246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0246A3A0DA544B9CBA79D535E76D0@CY4PR04MB0246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2vFXqXQjKARB7t6MwrfQ1Vx4yI6uBfq+5JjXEVsdmZ+d3x/0hdAwxFrztkMdMLGpAPbGT13bUEHrJlhDV+josJQRm+c9r1blqYBXlet/+w2+zWrpek+NcFyxn95iYViFQ2pmT2DfYuyNTjJ+wf0tVEdOQmPTmLOObWJMGoXT8UQpxHck6JeKrUp2pWvlZJGHfi3fHOCjbP8d4BT0tZPaZJRqqfiKXlyPhUaf3QG3vK6Zzk/boGGift+eFi668hds5OKVgbyikTCPbHSV0o5zt24VhdQlh5dHXm0vdrsBQIIgN+hKfg7mmni7unt1lrUafXu58b6aF8IoNSp2hKFCBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(186003)(316002)(5660300002)(66556008)(91956017)(66946007)(66476007)(55016002)(66446008)(64756008)(478600001)(9686003)(26005)(76116006)(2906002)(83380400001)(53546011)(8676002)(7696005)(66574015)(52536014)(54906003)(33656002)(8936002)(7416002)(86362001)(71200400001)(4326008)(110136005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lZTv3gfbsEK8MSSE9BWHGwkFuIcTbHdZaM5zb7KeVbK9s9YNLqFrodZrBZXBiqS4u06Wv4iCONDbkhoiIpx7j6TVJkqFC5zbxY6A+YTawL4ciT1J1NWIlNf4HtM9pChGnMO1J3NgSxGFjYFQ4RsIp/ganRPBl8BZhvRxFTcUPtIqvXD5KxRFeMrkVRezRFoSF+RIpEKEaNOgtV/x9UpAV85npc2dPlU+wED78oi6/tAmi4NGVewrNwp15Ms3z4xtidjS2Ticrk3uSz2ooZLYSPHQemNbdZrxPWdSXvdJya1gAXPI1VnK78PSLLIcTgef+i5eNlhfJny6+zlT91bOLaEpJPmjJ6lonF/lDSrBB8bYw9e7YIlhVnp8RFNZzPvYCcIswJVlReAKGXDhNhwLXe189vMc59JdkpTioUn+X7Yz8Mx4l8f/pJSjlT+JA3jtMLjkTH72TlKwtyIzHmhUPun67akC939cYcE8LfPr2o06unoRInrpolO9Orh8/wQ0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d6c221-0a4d-4718-929c-08d81e6cc15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 09:46:12.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8oyTfFsiT5LECy/BKRcwKR+onunrq60bY4eDp4TfJE/iCncYOVENG66sAAv4qrhMZVc8xtQgXtBAr0qQGRKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0246
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/02 18:25, Javier Gonz=E1lez wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> =0A=
> As the zoned block device will have to deal with features that are=0A=
> optional for the backend device, add a flag field to inform the block=0A=
> layer about supported features. This builds on top of=0A=
> blk_zone_report_flags and extendes to the zone report code.=0A=
> =0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> ---=0A=
>  block/blk-zoned.c              | 3 ++-=0A=
>  drivers/block/null_blk_zoned.c | 2 ++=0A=
>  drivers/nvme/host/zns.c        | 1 +=0A=
>  drivers/scsi/sd.c              | 2 ++=0A=
>  include/linux/blkdev.h         | 3 +++=0A=
>  5 files changed, 10 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 81152a260354..0f156e96e48f 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -312,7 +312,8 @@ int blkdev_report_zones_ioctl(struct block_device *bd=
ev, fmode_t mode,=0A=
>  		return ret;=0A=
>  =0A=
>  	rep.nr_zones =3D ret;=0A=
> -	rep.flags =3D BLK_ZONE_REP_CAPACITY;=0A=
> +	rep.flags =3D q->zone_flags;=0A=
=0A=
*all* zoned devices support capacity. So why changing this ?=0A=
You are only forcing adding setting the queue flags for all device drivers.=
 That=0A=
is more code.=0A=
=0A=
> +=0A=
=0A=
White line change=0A=
=0A=
>  	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))=0A=
>  		return -EFAULT;=0A=
>  	return 0;=0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index b05832eb21b2..957c2103f240 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -78,6 +78,8 @@ int null_init_zoned_dev(struct nullb_device *dev, struc=
t request_queue *q)=0A=
>  	}=0A=
>  =0A=
>  	q->limits.zoned =3D BLK_ZONED_HM;=0A=
> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;=0A=
> +=0A=
=0A=
White line change=0A=
=0A=
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);=0A=
>  =0A=
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
> index c08f6281b614..afe62dc27ff7 100644=0A=
> --- a/drivers/nvme/host/zns.c=0A=
> +++ b/drivers/nvme/host/zns.c=0A=
> @@ -81,6 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct =
nvme_ns *ns,=0A=
>  	}=0A=
>  =0A=
>  	q->limits.zoned =3D BLK_ZONED_HM;=0A=
> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;=0A=
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
>  free_data:=0A=
>  	kfree(id);=0A=
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
> index d90fefffe31b..b9c920bace28 100644=0A=
> --- a/drivers/scsi/sd.c=0A=
> +++ b/drivers/scsi/sd.c=0A=
> @@ -2967,6 +2967,7 @@ static void sd_read_block_characteristics(struct sc=
si_disk *sdkp)=0A=
>  	if (sdkp->device->type =3D=3D TYPE_ZBC) {=0A=
>  		/* Host-managed */=0A=
>  		q->limits.zoned =3D BLK_ZONED_HM;=0A=
> +		q->zone_flags =3D BLK_ZONE_REP_CAPACITY;=0A=
>  	} else {=0A=
>  		sdkp->zoned =3D (buffer[8] >> 4) & 3;=0A=
>  		if (sdkp->zoned =3D=3D 1 && !disk_has_partitions(sdkp->disk)) {=0A=
> @@ -2983,6 +2984,7 @@ static void sd_read_block_characteristics(struct sc=
si_disk *sdkp)=0A=
>  					  "Drive-managed SMR disk\n");=0A=
>  		}=0A=
>  	}=0A=
> +=0A=
=0A=
White line change=0A=
=0A=
>  	if (blk_queue_is_zoned(q) && sdkp->first_scan)=0A=
>  		sd_printk(KERN_NOTICE, sdkp, "Host-%s zoned block device\n",=0A=
>  		      q->limits.zoned =3D=3D BLK_ZONED_HM ? "managed" : "aware");=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 8fd900998b4e..3f2e3425fa53 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -512,12 +512,15 @@ struct request_queue {=0A=
>  	 * Stacking drivers (device mappers) may or may not initialize=0A=
>  	 * these fields.=0A=
>  	 *=0A=
> +	 * Flags represent features as described by blk_zone_report_flags in bl=
kzoned.h=0A=
> +	 *=0A=
>  	 * Reads of this information must be protected with blk_queue_enter() /=
=0A=
>  	 * blk_queue_exit(). Modifying this information is only allowed while=
=0A=
>  	 * no requests are being processed. See also blk_mq_freeze_queue() and=
=0A=
>  	 * blk_mq_unfreeze_queue().=0A=
>  	 */=0A=
>  	unsigned int		nr_zones;=0A=
> +	unsigned int		zone_flags;=0A=
>  	unsigned long		*conv_zones_bitmap;=0A=
>  	unsigned long		*seq_zones_wlock;=0A=
>  #endif /* CONFIG_BLK_DEV_ZONED */=0A=
> =0A=
=0A=
And you are still breaking device mapper targets report zones with this pat=
ch.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
