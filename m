Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F418C2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 10:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0B120825
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 10:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="euCsPK3Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HRfQqbMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgKFK55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:57:57 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23749 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgKFK55 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 05:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604660796; x=1636196796;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4K5IhEZ+kEO8pc4e01tk1UbfdBFdr4taAwLhhiNnljI=;
  b=euCsPK3QjoUDfSOsGEeqB1eC2xz3y55XBWV8Gw63R4ilFTLr9Kso2NaE
   s7uxLQwmaB5Mb9B3Bg+yhSIm/F65pMWiuQzxx3BswD1YOBAOscjHo1pln
   39evA/kRRM4NIAv735yPSDoe8PIi36Zp2B3m3ed4Kty2Q2NJ1NCyp1KP8
   D563d6xNjqXfsY88bGp2UXx9NZzJYrjM6IHLysooAjobnZ4FwZfKKdqHX
   CqLjEQf6Y15BnkOPOXP75wzVDK5hbEJyhbBk+mFYX2NVUHR0kCWOOEiB3
   6G/1MIcnxKqWdTEbGC99UFDuSSJauALTR99it/YbbW+N2Mai1y+Vzw1Id
   g==;
IronPort-SDR: Q5quV1wkFj/wD648oIB4R3K5AiIb+Lg/9vIBFtq+sRFgrMslT4VO0GGAmREeXh/8behaGI0bBk
 wIm2HikKRqPgafXmbg84YtvDtYLXrdwBA9Y+bm4XrcLTZ4ilDhl19LJsK7olnF0Js4YTUqSRhr
 tJ6VXvkuvuILTZSXqnHvSF7uYvb8KZ8oHbQSc78rm3MpnOH2rZ8UnohAwyGOXGTTqFOdKEL9e1
 lAn33+ZkJFY0EZoTgyYzz+KrM0yrhWeikAoCZtdNjFKhpdjY8otdnAluSSVs7bHt0SsEn67rgV
 0xg=
X-IronPort-AV: E=Sophos;i="5.77,456,1596470400"; 
   d="scan'208";a="255569262"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 19:06:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4BB2FnmaIR7St1tQm+uVUFgTaO2w3skmm1yKx4LFp6q3XNPA1ANfRL9ys6v686XzinfULbGZR02rmFHmdtGt0q6TVUN1PNcj963mwgNQaQiA25XmoNHTvtF4XZ31nsQjj/SoQ/OXB2PjOgWhCDaWulCBrAkl15E2aohxgjkfooqyaS2tqnmcjCFdQ3D2WhU3+plqqek3886nNv3YPmSboNhgmPf64qItXj5WlWFfugP1M79WYjTRhNDDi03OYrraOLRAe4LnQpks52gzRKMdedTK44WiTwNpW3Q6dZ4n81w5vyta7akFB92/4IRauRSd1t4cm+A/XUuw9W+/gnAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCuRDOVd6w8K6/ntDp5nR1EJGHEdRLR0zmqL7eA0exA=;
 b=YuGwkImsu8W+ou0Hr6xIopCUjsN0O2qxT31ixksRukwesyWR6NIxJ3Wd3EYfy8cEnQIIf07hHFQ0xh6SUxE/n/hTDVTnZw4oAAfy/WoHradlChNf7/rgnKZnV7z0FbY/Zft54OaX0bP1fQvxG4O8mosQoc/Slv5ufI3govmLs9bl74nJNZH6BE7TOtXry6wbOsbls6UpBXBKBUznY+62a9P8e5EJjwTEOjXazcKJELDZKerwHj7t7Qto7visC0gJXmKe0y2CjBsg8OJD1iMWkUBecC1UqFsFvM9bACIiuAZw9/47gOjFwcBK325cW+m9IaZzlghbwVXIlb0ekIJLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCuRDOVd6w8K6/ntDp5nR1EJGHEdRLR0zmqL7eA0exA=;
 b=HRfQqbMK/blK06VY5ztSIS9rtDcNyR2Wt28BZn17zCvOEqrvNuG1iIjGP0bhHm22Vpuxyj2SK/8LEcN+OlIjO6SLUH0haFqbxH07Zful1gJ81er64mTr3c3ERuKPusHiOBt6d9ILxfy9FYpRltjpYMsRu/TUSja+fowqHgXy95Q=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6447.namprd04.prod.outlook.com (2603:10b6:208:1b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 10:57:54 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 10:57:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] null_blk: Set mq device as blocking with zoned mode
Thread-Topic: [PATCH v2] null_blk: Set mq device as blocking with zoned mode
Thread-Index: AQHWs0OvtgHIoShf5kGEYq5mLnltvQ==
Date:   Fri, 6 Nov 2020 10:57:53 +0000
Message-ID: <BL0PR04MB65142985BDE48783C219F07DE7ED0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201105071656.421762-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:89bb:1cde:d92a:2dcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8f7694c-faf1-45f4-425d-08d88242cfe3
x-ms-traffictypediagnostic: MN2PR04MB6447:
x-microsoft-antispam-prvs: <MN2PR04MB64473316E620DB2C02A43660E7ED0@MN2PR04MB6447.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IwrN3W0BvifRg7LdGJjPjwnlJQf7b0wN3jPboSCRmusK/XCppjwnbeCAdJiTPE4BamBXBFDLD5FvNKuJwyZN2Sny5UsRbnzBAdKOw2oWKXq6CZQ3/geiiKmesfFd8QkMrCazmCiFQi6QOqA64IdI7vkqFSWfemr3y/f+PnOrBFP7Mp08vpoDjFpuKYG7g9NsGMz14TLoBFYV1sonFOh8wMEPNzoYFN5D+kIW1JK6bh6gDzazUg3NqgYwSyff8Rv4tkdWtnFTkjbXqWgiT8zV/vj/yYD4dULcNLhciWsiLNMQQ6InzP+EIodSaMM6K9UoU7g7ZPBSdEwAJfAA+SZ6Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(55016002)(316002)(2906002)(186003)(53546011)(5660300002)(86362001)(6506007)(83380400001)(33656002)(66476007)(71200400001)(76116006)(66946007)(478600001)(91956017)(7696005)(52536014)(110136005)(64756008)(8936002)(9686003)(66556008)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: H00XIOcR7QiDayfItBEcOee7HS4PekrGLqMtaxyaCkS9r3C3jEnQOGcL8njY/gU9Cky6z5ZQ1iUVAHVoIaA33fS/iBokG8NrhtXN/luhjwMb2gJBOKiMzXI2H9rCXlqU99LfPBBAP/CrDXykQb0PTtMUXv0WXkjxrADQ8GW64sT+/cPRRVEDj/17VNe9ps3FsUdhqSckLUUIelW8Gov47re5bEt0O4HdCMLBKoMdLTyjwp9d0fyHYbEYUQu/J9RuRjzS+dG8Yg7VmMVHkbpPEySQ137UYq/h3ndjGDXY/1IrWaOvDaJS2eGBzQUMiJNvu+sBfZYqmLx1GNtNrnQTK4HXvjLCvsY1qUfWcKaUhB3uP3vG/zauNy0o9mEbw26SzvQcz1AuMhhDVm5/z4vkvufqvj/sba+iSxkVn4OjZNGbsIVUom0rtZXWtSNG4mujdIT505reIxmZXAXt+vrdWwodaQGmS+eBT+mf4Lqr1U4Wl2uS9/C8BaOSNMoveMW8Ufvf0jYW7ODmd4M05+0I4qon1E9qyXfXFKFsYlDE6lc43Nok09g6TPAob3YFbu93yyn0vk67DnCxvTM9WvU6cvzVG5FAwacSulHv9lYWouXkywPvZp59nCd4Nw1HLdLqS1Z3gaWEfnVwG1/HqjZJxbqMFMseKC8gkzvQUaLDFlpSe9jIRQh4wbJs4y0BUgpyOHM765jg6voI1OAq9LyaoQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f7694c-faf1-45f4-425d-08d88242cfe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 10:57:53.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TsJXQEDCPzKPbK9YW6WtFVNTL8hiZpgXuKJ/3saZvFLUpzF/oZKwts9uXoIQbnDmJw219+6xLDR7Po0qn08Akg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6447
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/05 16:17, Damien Le Moal wrote:=0A=
> Commit aa1c09cb65e2 ("null_blk: Fix locking in zoned mode") changed zone=
=0A=
> locking to using the potentially sleeping wait_on_bit_io() function. A=0A=
> zoned null_blk device must thus be marked as blocking to avoid calls to=
=0A=
> queue_rq() from invalid contexts triggering might_sleep() warnings.=0A=
> =0A=
> Reported-by: kernel test robot <lkp@intel.com>=0A=
> Fixes: aa1c09cb65e2 ("null_blk: Fix locking in zoned mode")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
Jens,=0A=
=0A=
Please ignore this patch. Sending shortly another one that removes the need=
 for=0A=
BLK_MQ_F_BLOCKING when memory backing is disabled.=0A=
=0A=
> ---=0A=
> Changes from v1:=0A=
> * Add "|| g_zoned" to condition for setting blocking to correctly handle=
=0A=
>   creation through modprobe.=0A=
> =0A=
>  drivers/block/null_blk_main.c | 9 +++++----=0A=
>  1 file changed, 5 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 4685ea401d5b..6bcf95d611a3 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -1714,7 +1714,7 @@ static int null_init_tag_set(struct nullb *nullb, s=
truct blk_mq_tag_set *set)=0A=
>  		set->flags |=3D BLK_MQ_F_TAG_HCTX_SHARED;=0A=
>  	set->driver_data =3D NULL;=0A=
>  =0A=
> -	if ((nullb && nullb->dev->blocking) || g_blocking)=0A=
> +	if ((nullb && nullb->dev->blocking) || g_blocking || g_zoned)=0A=
>  		set->flags |=3D BLK_MQ_F_BLOCKING;=0A=
>  =0A=
>  	return blk_mq_alloc_tag_set(set);=0A=
> @@ -1736,10 +1736,11 @@ static int null_validate_conf(struct nullb_device=
 *dev)=0A=
>  	dev->queue_mode =3D min_t(unsigned int, dev->queue_mode, NULL_Q_MQ);=0A=
>  	dev->irqmode =3D min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER);=0A=
>  =0A=
> -	/* Do memory allocation, so set blocking */=0A=
> -	if (dev->memory_backed)=0A=
> +	/* Memory allocation and zone handling may sleep, so set blocking */=0A=
> +	if (dev->memory_backed || dev->zoned)=0A=
>  		dev->blocking =3D true;=0A=
> -	else /* cache is meaningless */=0A=
> +	/* Cache is meaningless without memory backing */=0A=
> +	if (!dev->memory_backed)=0A=
>  		dev->cache_size =3D 0;=0A=
>  	dev->cache_size =3D min_t(unsigned long, ULONG_MAX / 1024 / 1024,=0A=
>  						dev->cache_size);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
