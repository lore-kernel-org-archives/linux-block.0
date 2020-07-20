Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B8FC433E0
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB1E2080D
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c6MO7wn0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Sj8fZyc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgGTIL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:11:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11686 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgGTILz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 04:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595232714; x=1626768714;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QcesJcF1Ypn74ChTM9l6qSR5D2LPDejOPPVa38NBU5A=;
  b=c6MO7wn0wC9XtqXe7r68+MVdue3C61+gd3zd5JqFZZENrhPz8jVYJ+Ao
   6dCNoP72Dc8Ozpe4JH+7akQtqYKogE2DLwkz9C9euJwigQwwB122e0ZYv
   WL3/kTnQmUck4YU1UapB+Xl+nkpMudySGlsHqmgMs6IdNQ5nsbQlFjDGD
   OyYwSPLKNNWWYFFa2cM/GIQIst9SRar+jMIcjo9mdstEfJsle60/vbE5F
   zsifdHZdMcdpNh42Aw2fmQQ5M7jf0K+aIs66TGd6q7W4IZrZX5pOfjg5E
   3NeFNzg94Pq/TsHnAQ2/IP3t9JrKGQRlqYUJvVC8bo2djevfO3Dnd+Z98
   w==;
IronPort-SDR: 4SW1Mn9CGPxIRwPq4jToTj1pz4+M4+OvAa2XxV5nsO+yEvYLR30lQ0iN0aHWPfZ+qzfyQpUMGc
 OQ4sGBJtM4UuvKOghmcsawhBncm37zNaaVE6+YL8mtmhjO7Pr4KI1OUMEfKLAWqV7VqUgx9/Aq
 dQCLknARcIkjRlsTL2QoUXWOAagL8yVmmuWh7oiwzJRI9QUt8yYAyPPHeH2BEkBZXv+TO76Bw1
 nBwukOVKbPxllfJ1Aw2jkfPgt6mc2xvbV2SLQn3WdjYuGyges6754RcOdfCZPVxh3w5o2Ex1Jf
 9G0=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="252169118"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 16:11:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5/kV09nTi0JtQYdxHeRCB0v392Cvsu/IutB6gfakq4xQ/ZxSHgiY/KIZIWMvbc35jgjYxZh8E8Bmb7H//HiJelGcIXNRN+EiMBNwU3wen8Q5JTGnRwQ0+haQGttApl5ttxata2VylcF+/joIrGui+Uabnmw/eDB5rNEVBjLT0qdDsKhFCtz9yyyH/PUOjJqn320Y3EtCOuJzPGtCyiOPF6GMiLjUnGlAlPb1sih1nPGm4Pi+xYiI1GSM5ktCegEcKO3vvPYXijwOKbcpki7VI0r/aejqWGoEdAn2enoyJSQn1PMljx+eD8i9uf8qicnuHqBwX5p43gtduCItsZD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCDUczjUfbBszB4LlUJ0eKZyo9+3zmUBL08Ot2EkTX8=;
 b=lr+OlFZvkkaNwFoZwlIpvouRbzDfFaZW3xMQJSK2dnA+NmQAk7A49zkoVDagbHFxZZHZSeYIQAjyV0KBOnvzvJf86yPgHrO/A9z8TO+hdBO2vDy8A/KP5107r1lTgDPkzpPaNOV43wgzABAYXM6yrK6ZEuPWBT6PRTAHu9227jQ8aW4QRT/3AQ0qnCBNh6WpJZPeWKpgYl/cX1l5KKCaKCYbFTGliHUtudLFDS0+0bNoWf9hmcKBW6+M4lGJ+FjOpdcuyvmvsnVXwmxUDKbblbRpv0LgAzi+U8OZv6Cc61nHkp5euAG5yLYK5++2E4xkrqDC49qW0OYIeViusiKr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCDUczjUfbBszB4LlUJ0eKZyo9+3zmUBL08Ot2EkTX8=;
 b=Sj8fZyc/OfJWdcwLnq+OMu6sPxPQqPVWNJDPKiIwJmV+kBq/JTF08uAfIsBiD6fLng0CFqI5IXoTgMW/w5cYW0kkccjSfWCinUJnCOf0oGizkhzbmiQPF+xX3Cz/FInBN7K03fzVKZAP85Oox8gV1Sz4+ReK+WUhklzvaXbVt/I=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2220.namprd04.prod.outlook.com (2a01:111:e400:c60e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 08:11:53 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:11:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH 3/3] block: remove blk_queue_stack_limits
Thread-Topic: [PATCH 3/3] block: remove blk_queue_stack_limits
Thread-Index: AQHWXlzVh7oGnzbSMEeGw8J4Z4JGYg==
Date:   Mon, 20 Jul 2020 08:11:53 +0000
Message-ID: <CY4PR04MB37519991BBC1A1341F3CBFA6E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200720061251.652457-1-hch@lst.de>
 <20200720061251.652457-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47495b88-b2aa-4873-44ee-08d82c848fbb
x-ms-traffictypediagnostic: CY1PR04MB2220:
x-microsoft-antispam-prvs: <CY1PR04MB2220E56A3397BBC7AEC3F43BE77B0@CY1PR04MB2220.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pN3tNSp2o96/RaAs3mzVFoz1eXRn6jJpR0H5B5xLcJLxbNlE680CXE24ny5oOf8xVkcCQHrHeNydErvb7fnH/y0YA1CixF0sjZIlB7cAg0LbGe6ABw0MosX7xS2gU3ZnPGlXFX4F6CI3tE6OpsbTpC5IxdoId5Z+7fcqpUG0JEZM0bfWTmFBbTTt63BvcVPnXqs/BlMF4QF8z6g9pw1X2u0fag3q38WPwGNuJnxDDnGbKuoLZTRuLsHqraXNCoMnGk/9cEFhmnzuc4nJIYovuGpONqqV/5S0nfbZo/ubm/dmP5Q8dHASllJbPchf1MC8gwxGOJMWO1takzLjMMwlRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(83380400001)(8676002)(7696005)(71200400001)(66946007)(316002)(55016002)(66476007)(2906002)(8936002)(478600001)(53546011)(6506007)(186003)(33656002)(86362001)(5660300002)(110136005)(52536014)(66446008)(64756008)(66556008)(4326008)(26005)(9686003)(76116006)(91956017)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: H+usXrfvklC4It3GgDcByq9VR0zdO2/byjC1S260C8D6TQexS9Gw0gauF/LLd96dlLANwI1gOxsoBayKIpTg3bhlwGFxkct/I4EcXc6WSllEfDqHHtkzue+nAk0kf4Vv1OHHmS6xi0TA5gyiK6rMbEIfUwTpuJlBQmaNOq3AzkYjuVWlHmrqSDRwtIRXfdNIqLgVGSVpkJzUgflDiVLIHNJJJsBRrwR4cnrbub1SvslepNYkxOxfRnqWJAwZWIGBzVHDusPT1wwBypWUZzRZcWGreuIDFeD6x1K4CDj06v1EUgZCLV2G3yRnWxsmWeP2l0htGMAemcrhvr5vaW5d+jR8Jka4fy//6t7RsBmwiFyQ22+0+PL1gMycJ2dvSfQYMpQSUDbcXVLyiaJZY2Y123SRig1twEiXd+GYvrFEn2TreC6nIPdzFsQYclNG0jaJMWqCLXVXyfb85mZ0+UkDnUmldHn9UgjsNfjxk0lEQMW7c4v0fplcC/GLWP8F0tih
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47495b88-b2aa-4873-44ee-08d82c848fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:11:53.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdGGmHrVwKrbgbYcE8Ahdm3+0J1JFLTh2R1pJJBXWpnDjP1ooiUMdnRuZud7soaoZIqVMtcA/Iv61VGSH4fkRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2220
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/20 15:13, Christoph Hellwig wrote:=0A=
> This function is just a tiny wrapper around blk_stack_limits.  Open code=
=0A=
> it int the two callers.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  block/blk-settings.c         | 11 -----------=0A=
>  drivers/block/drbd/drbd_nl.c |  4 ++--=0A=
>  drivers/nvme/host/core.c     |  3 ++-=0A=
>  include/linux/blkdev.h       |  1 -=0A=
>  4 files changed, 4 insertions(+), 15 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 8c63af7726850c..76a7e03bcd6cac 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -455,17 +455,6 @@ void blk_queue_io_opt(struct request_queue *q, unsig=
ned int opt)=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_queue_io_opt);=0A=
>  =0A=
> -/**=0A=
> - * blk_queue_stack_limits - inherit underlying queue limits for stacked =
drivers=0A=
> - * @t:	the stacking driver (top)=0A=
> - * @b:  the underlying device (bottom)=0A=
> - **/=0A=
> -void blk_queue_stack_limits(struct request_queue *t, struct request_queu=
e *b)=0A=
> -{=0A=
> -	blk_stack_limits(&t->limits, &b->limits, 0);=0A=
> -}=0A=
> -EXPORT_SYMBOL(blk_queue_stack_limits);=0A=
> -=0A=
>  /**=0A=
>   * blk_stack_limits - adjust queue_limits for stacked devices=0A=
>   * @t:	the stacking driver limits (top device)=0A=
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c=
=0A=
> index da4a3ebe04efa5..d0d9a549b58388 100644=0A=
> --- a/drivers/block/drbd/drbd_nl.c=0A=
> +++ b/drivers/block/drbd/drbd_nl.c=0A=
> @@ -1250,7 +1250,7 @@ static void fixup_discard_if_not_supported(struct r=
equest_queue *q)=0A=
>  =0A=
>  static void fixup_write_zeroes(struct drbd_device *device, struct reques=
t_queue *q)=0A=
>  {=0A=
> -	/* Fixup max_write_zeroes_sectors after blk_queue_stack_limits():=0A=
> +	/* Fixup max_write_zeroes_sectors after blk_stack_limits():=0A=
>  	 * if we can handle "zeroes" efficiently on the protocol,=0A=
>  	 * we want to do that, even if our backend does not announce=0A=
>  	 * max_write_zeroes_sectors itself. */=0A=
> @@ -1361,7 +1361,7 @@ static void drbd_setup_queue_param(struct drbd_devi=
ce *device, struct drbd_backi=0A=
>  	decide_on_write_same_support(device, q, b, o, disable_write_same);=0A=
>  =0A=
>  	if (b) {=0A=
> -		blk_queue_stack_limits(q, b);=0A=
> +		blk_stack_limits(&q->limits, &b->limits, 0);=0A=
>  =0A=
>  		if (q->backing_dev_info->ra_pages !=3D=0A=
>  		    b->backing_dev_info->ra_pages) {=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index 5192a024dc1b9c..45c4c408649080 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -1973,7 +1973,8 @@ static int __nvme_revalidate_disk(struct gendisk *d=
isk, struct nvme_id_ns *id)=0A=
>  #ifdef CONFIG_NVME_MULTIPATH=0A=
>  	if (ns->head->disk) {=0A=
>  		nvme_update_disk_info(ns->head->disk, ns, id);=0A=
> -		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);=0A=
> +		blk_stack_limits(&ns->head->disk->queue->limits,=0A=
> +				 &ns->queue->limits, 0);=0A=
>  		revalidate_disk(ns->head->disk);=0A=
>  	}=0A=
>  #endif=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 247b0e0a2901f0..484cd3c8447452 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -1108,7 +1108,6 @@ extern int blk_stack_limits(struct queue_limits *t,=
 struct queue_limits *b,=0A=
>  			    sector_t offset);=0A=
>  extern void disk_stack_limits(struct gendisk *disk, struct block_device =
*bdev,=0A=
>  			      sector_t offset);=0A=
> -extern void blk_queue_stack_limits(struct request_queue *t, struct reque=
st_queue *b);=0A=
>  extern void blk_queue_update_dma_pad(struct request_queue *, unsigned in=
t);=0A=
>  extern void blk_queue_segment_boundary(struct request_queue *, unsigned =
long);=0A=
>  extern void blk_queue_virt_boundary(struct request_queue *, unsigned lon=
g);=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
