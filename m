Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69190C4332F
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 07:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiL3Hi5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiL3Hib (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 02:38:31 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB2BD8;
        Thu, 29 Dec 2022 23:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672385909; x=1703921909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EdM2QqNeyi8i1eoWwUVd/AZY73FLYevKeY+BjwSch5k=;
  b=pS1hmwtA/w4EKj73uZcbj49OaNmHzBH+SJyYS7CTfiZXOhM6pPFcvYQc
   5vfLu/yaY4R5z0DwgZWQoJHTv0CilXb1vdvFAHi5afSL4qnIajK2yKc7e
   dLHlK2Dvx1Q+JJ3zdUI+JK2N9bHeKhvqU2eiSKhgJeIi4zvCibZhAta54
   LA04frH2BFVbrxujWgw7+ZwwIauY1F3XUX36Qq7JNenmAg32ZlfWzMv5z
   1M3GJGgyG4Ck9hcDVHHTHwXnU01XZhIYPHm/WEJeT398q2siq90ik2SIj
   K26cC1riv5r1wRGpAJxc2LxLINIDAj/GXZntPTnXNWZPeKZmWrUhbyZ1A
   w==;
X-IronPort-AV: E=Sophos;i="5.96,286,1665417600"; 
   d="scan'208";a="219862909"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 15:38:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYat7HXl+Z4AoY7Ww1QBt1mMwAuzcWHyXkTsjPnwiPsDwgZQqCgaIJtuGRmPd8pxwz7zyKwn+Y1WwrsuzkW1HnoebF89Av+DqfpuSBKsqefGct18ME0khdNOFnbuvRdVOUIZC/3gTPLWNFQNZxs8COwIHtK6CY1UVn2q36awtv9s91zx1FIn7tl9krrNrmlusW2qZVyAoCbzLu61+ZgoDVy4Goy6Xe8CP+ko5z1Sb/K1A5kDHCOMhR6C17HcnXM09hfR3LGF6wFU9oeZwL9I2LtM7Dpj/GRZpUWBfAMs9h/l6jzPnStt0iJlMau9JNM/T0KLxNShCNZdNoOf6gllEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VGyn+Q67SGQ6uKCfm3awfEY6j4dA7gIh/iEaDzMGNM=;
 b=XeKEft+JKR9nJIKkQQhXPVW9A9bqCgvHykrU0+AXOca0dxWT3GMDIzoq915syo5Q+cfww+ty5Aq+rBX7RhjCBGsu1w8zX9u5XTnEf0zeyPSTV+h2UAeCSYsaON0TXyzys3DFJZkxsDmqoB4Dm/12fxxOMdhpscY7las19r1bFlfeR0Fdy0weiWukSDpiudoKEqY5/y8bxR26mkAdHdaUeKJ939VZyeL9FhVeY1fcirxqQWVy9zsFsgrJk/1Mj7EuIuYIa2UDu+1b2IVLT8LyskwKWFo99BKRXpf4aIEJpDH0FM/dTci2lpro4+Hs3D7IAK3IftsLKGLW7igybX92zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VGyn+Q67SGQ6uKCfm3awfEY6j4dA7gIh/iEaDzMGNM=;
 b=yWDI6JoKG8pGWp705A8tHFPCgQP521DCu8HtFKMbuHFlq8BZQwnIPXWYWn7YVL7cLDpJxxgAVDPLx8WH3pg0EniumM4T4HL0y524YajxFS3Ao4T8h1NoyiBp0ysg971kKOOALvddeIhqHKhHzfqI1ckO9APXhzmLNrEBg3psdqI=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM5PR04MB1053.namprd04.prod.outlook.com (2603:10b6:4:43::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Fri, 30 Dec
 2022 07:38:24 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 07:38:24 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 2/7] ata: libata: Introduce ata_ncq_supported()
Thread-Topic: [PATCH v6 2/7] ata: libata: Introduce ata_ncq_supported()
Thread-Index: AQHZHCGyoiLFrx0Nk0G6/BpnP5YJQg==
Date:   Fri, 30 Dec 2022 07:38:23 +0000
Message-ID: <Y66Vbs+g78RvBrjS@x1-carbon>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-3-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-3-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM5PR04MB1053:EE_
x-ms-office365-filtering-correlation-id: 06ca2a85-d6bb-43be-a906-08daea38d510
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQz+MF1ReIl1kYue/xMw/6h0nNFrXCkXJYJDLzFgFkyh7m7FHn54cQCyKzJn5iYn4q9PmuJbOJQuzMbdJkFAUpuBgr02Misr/roz+AVkL8M5YpbUHQZnCv7wz33MNTpAxJuPH+uamxYjBQ9SV3LfstbdOLy6CDOOD+A/RaeyfR64vwBhO/+KKFuA9EvdyB8onQColikTUJw5kbtqDh3xo5NBwCVHR4JS6g4ZM6FwW9Xo67oA1t4H+1OK/kcLh4dOWjqraWMxqna1xJAL9+2/QZLCzVWiJHBSVgVJ6pYjKnRRSDe5VEfI23JSOSC49xoNHNjV2lS4gDkmDWZWdOQzMye4omOX8oAZVNNBIgfnsC6EXYTIzqmJmA2bKjDLbt4BHbmTSZ5eb6tKp4UgVNDK1m0gPjYV/P7HbV6e6pLab86UP3QQKy/P58OEtRCrNTVyuUTEzLLaO7FEEjM035fnQJK1c1QioQIV48xeneGi843sdpUBopVLWOub+yuRv8FGE2F+DOvAaDfLMgXkIx1bNKZlpUZoWWWvejSJVmQPW2TT2IDUsDVlqXU10TATqDuV2l0OFnTZkzrRQO+iykzXYBcA+bE9FPgKbn2vFvRaA+awx5VJRL2MUes8xLCsXbS0OCL3Pciw+VMHJouD9jApAFrVS9nO1TO6l28xa/yZP5b/jgBur//ym1ZVLYmM64y1thY96Ym3FJliRxh6wdeJ5TXDmCusYSSuRtiIJPBBtVQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(2906002)(8936002)(5660300002)(6862004)(316002)(76116006)(8676002)(41300700001)(66446008)(66476007)(66946007)(66556008)(478600001)(64756008)(4326008)(91956017)(33716001)(6486002)(122000001)(71200400001)(38100700002)(82960400001)(186003)(26005)(6506007)(6512007)(9686003)(38070700005)(86362001)(54906003)(83380400001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RcfrlZ6vMjVpjC/UVkBhGjt60x2oTUWUdMF01LpI8LEoLXInacedOCTT6rGC?=
 =?us-ascii?Q?qZlWrd/OnZOyFumuJfCB/kepxHKsA9TDq5SnuP1ih9hHedJ8ZTZrk5zujyN8?=
 =?us-ascii?Q?oBLoCCEtKS5YhJASAEbibarjp/e17tql7lyJnt9jgWk594JiMMBFwZRI+qjY?=
 =?us-ascii?Q?IQyNQn0GYHCwVfeFZEklFB+PAkseyzr+K0DWIYIVYT0PEChUsvQau3Ouyp9p?=
 =?us-ascii?Q?PAcfrhhBEt1EdW99fs037W9hOYvghPbw/fuDyz66p3yyoEyMKNrPamdlx4oI?=
 =?us-ascii?Q?I2MfQn9VtKmiHcrsNBFDLuxFO/DYJegurcwZtSjovwkU1QYhuqDXal/eh2+C?=
 =?us-ascii?Q?QHhN2xQaAEDuj144Bdf2zyp3He7qPFREF5OOyJhpnzor+58pc77U/XdjzmC8?=
 =?us-ascii?Q?Hn0zVXsM89/0bX5a7EQ82kfV1Dudb6llAi/lRL/UqjBqdgyl15wj4ueLz/Eo?=
 =?us-ascii?Q?X8L14WMs5JBYWuXbVoaJrIPLsHwuGtHLmJD1fDdge8MBUg1JE2bAHg0CBgMp?=
 =?us-ascii?Q?6mgjia1+9L0mXx2eRKbOTWhCbbK2lsc9p1olPovvrziTMftOGo60la6iZ1TJ?=
 =?us-ascii?Q?9NW16JKHFwmlPLIvDOfVbjOYy6q+ZyQnM0DJ0qIDk5gxmqbCGM5mj+jAoW4e?=
 =?us-ascii?Q?oRrOxia4iKQ2vgrxflt7ojjEuEt9Hr++0Fr57exWhiSCtOxNVhEsi650YyQg?=
 =?us-ascii?Q?7Hkh77vu86t+64IwulV3ty7+lACKYb/tu3/Q+DvoFOmGsUEXgq9238ZEIJB0?=
 =?us-ascii?Q?O2t5U43XotXs7SUfrpLRLLI+DF6wKvtjGonwujAtqucqxo1Qz048/X7YLxIm?=
 =?us-ascii?Q?k2hETpaaTFyXf1OHBHQPdhGgGBBhvNyPUeuzVcbKrjQ6vEI5R+faZsnlUAev?=
 =?us-ascii?Q?lheA944gAIImq/wfH9S1vf79ex2lT0ZhWFHScPSiezIdbLPq6Cb6k5Rmk+II?=
 =?us-ascii?Q?W24E/FiA6U/YNzRt2CA54KnpfHsnGopKFkLikMFXAVJnqcuWnjij4oBd9hwI?=
 =?us-ascii?Q?9lUUdQXwxA7JbfqiLoTYHGCEtwIqnxX/cKDIBp0uGRDzObOukixoPi4tr22I?=
 =?us-ascii?Q?zRy0vNKb2C+IBJ68V3vrMbqukTXXnlL77gWCcDwHg9bz5YNzGZFJUEtFNkvm?=
 =?us-ascii?Q?DIdEMAxvQ3/0yXuJbKxGopH1CnTD5l6/c69l0hBhXhV1Tqx1aInI72vixFuZ?=
 =?us-ascii?Q?KVrJooX3s1nc8HTSy8jN6nIkiIKBLwrzK3Tf+l02GnHHOZrrFMW885LvJyOP?=
 =?us-ascii?Q?CuwYYRrJvuTAC98VgTT4IHYWVe45Ij36t1e//zSDjp/1KDUwa4pwbhWeT19M?=
 =?us-ascii?Q?PYPgK3RZhh6nJfaATLcBOX8+XmI4lbpIAIGKZTUneSfPexgilRtqan3jxUyn?=
 =?us-ascii?Q?xrbE1/gt/qMDGHH3SSUZZhif4NjGdUPorrk0CQiz6wQRVf9jaPN3qYl4nsTE?=
 =?us-ascii?Q?EJs3/i9ZTaVih0rw4EOPt6fhO+kjEgsN5wFqLk9sBkKJrLztTnogWYMJXRkD?=
 =?us-ascii?Q?rBJ/37LGIpzbAkmZxo8NKg7RtoTA4y8ZlvIhADlvOQL2ryXnj9quDGZm82cL?=
 =?us-ascii?Q?1AHeRM7DPuFuDqDSHRZL6BEk531rTWkipazb/ffDcCC1m8f/GVEDa9c1XDO9?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26190FA4C5C1254B8E01D882173293C6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ca2a85-d6bb-43be-a906-08daea38d510
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 07:38:23.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYYOACLTr/k0iAwnGIjMQ+EeqCzRyoa0X2sqJCvz9ZVB+YzS+1rxvgWiOHV2zNjR6v0b9H2iZ9qBxmP+c0Rtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1053
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 08, 2022 at 02:55:39PM +0900, Damien Le Moal wrote:
> Introduce the inline helper function ata_ncq_supported() to test if a
> device supports NCQ commands. The function ata_ncq_enabled() is also
> rewritten using this new helper function.
>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/libata.h | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index af4953b95f76..58651f565b36 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1690,21 +1690,35 @@ extern struct ata_device *ata_dev_next(struct ata=
_device *dev,
>  	     (dev) =3D ata_dev_next((dev), (link), ATA_DITER_##mode))
> =20
>  /**
> - *	ata_ncq_enabled - Test whether NCQ is enabled
> - *	@dev: ATA device to test for
> + *	ata_ncq_supported - Test whether NCQ is supported
> + *	@dev: ATA device to test
>   *
>   *	LOCKING:
>   *	spin_lock_irqsave(host lock)
>   *
>   *	RETURNS:
> - *	1 if NCQ is enabled for @dev, 0 otherwise.
> + *	true if @dev supports NCQ, false otherwise.
>   */
> -static inline int ata_ncq_enabled(struct ata_device *dev)
> +static inline bool ata_ncq_supported(struct ata_device *dev)
>  {
>  	if (!IS_ENABLED(CONFIG_SATA_HOST))
>  		return 0;

Since you changed the return type to bool, and the function comment says
that you should return "false otherwise", perhaps change "return 0" to
"return false".

(Yes, they are technically the same, but it still makes me double check the
function's return type every time I see a "return 0" where I expected a boo=
l,
since perhaps I was reading too quickly and overlooked something.)

> -	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
> -			      ATA_DFLAG_NCQ)) =3D=3D ATA_DFLAG_NCQ;
> +	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ)) =3D=3D ATA_DFLAG_=
NCQ;
> +}
> +
> +/**
> + *	ata_ncq_enabled - Test whether NCQ is enabled
> + *	@dev: ATA device to test
> + *
> + *	LOCKING:
> + *	spin_lock_irqsave(host lock)
> + *
> + *	RETURNS:
> + *	true if NCQ is enabled for @dev, false otherwise.
> + */
> +static inline bool ata_ncq_enabled(struct ata_device *dev)
> +{
> +	return ata_ncq_supported(dev) && !(dev->flags & ATA_DFLAG_NCQ_OFF);
>  }
> =20
>  static inline bool ata_fpdma_dsm_supported(struct ata_device *dev)
> --=20
> 2.38.1
>=20

With the small nit:
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
