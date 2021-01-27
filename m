Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2746CC433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 04:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84BE2070C
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 04:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbhA0Eqb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 23:46:31 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40363 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404278AbhA0B3V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 20:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611711155; x=1643247155;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DZHRm8NWrQPgqxYztg1coGZ/xrYWtdUpM1l9/Bm2Blw=;
  b=HssEuMSBP62Y8ap4sZotEFri510btkmyqrtb34o3A6aVYO+ck9bjdUcU
   axpHatRWnb+laf/8/kDkBAcl5MWKFgpF7rpyOZ1oWTxOrbrbTHDdKJ8ur
   nGOnKsPoIOwCLinYyFR5A6+jThbuPCOCK4en4eKFgRHfiTjh21cRlNBCE
   qDMWCbck/EDK++ij4OCy6M4ueFzRImLKYV9V4VMwxXepHkWkPJR/eU6pc
   a/mMoqoaeW8a+PRv90ynKc29Dys/1clGuzMz1GHZRqNbD7mHeLOsozncv
   0sQmYjHYw5aDlmFwlayZk/eJmTfiTgMCe5f9c0nGbmRPf7nUPHTWYFip5
   Q==;
IronPort-SDR: FUp9x8h14MuC+Qx1S3YptQafeolqh/Le+iNuVVXUw9Bs7eZ0t5auCSmbjXLQLpwtoSeCoIF3iJ
 RIagM6KUaH483yiuD1N92uaWFPc8AQCWPgW9+hTHXA4EE1kLPRT4hXnSRDj2KgwdX8zzfVTQnl
 YurL82igeDqo6V3lGIHvdGURJcVGD9qo1R5xiCctRJq2k7tU52x2Q4mbMefcVZdfmKDhRagkvT
 Mwsw4kFYK5NB7ajJm4ZqnECDl+seh/VIctdxWIQAAsR6gIqxP7R41Oc9+IYhvMUrCxKc57uMRB
 xP0=
X-IronPort-AV: E=Sophos;i="5.79,378,1602518400"; 
   d="scan'208";a="262422057"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 09:23:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaIDacLlaK+oyxEqldwRGnkb/TpsoJcQCpsZbZMyelGXqqESmYXYaw182lM3kARXH2XhgSTzD4LHYCsV741wqfnXzELcyegG+o8M1cb3LQvo1uk2W/Yz92ZXMSpD70xWtMK3gq+8It86kaC+ngSb+l9CjZw6wdXlBulACpkZtALl6xXG/1zKqV3jmmwB0cTxUr6YToVDNanOc4/pN563PEHTR6YcvPAE4tscfKRr+/Ed96gw3+o0664KTTueysGBu/OwtkEg8zw3jp7adKOfPxqu5nG2W5APpU1VR0PQ54ByE+P6a5xpulJtz+8e50H1OFRj1h45ezhUVCItjdcaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZd9flg+sZKK2j1GPMJ4q1AmzaFemeYJf5BVFYZShN4=;
 b=VppC8NVhHPoWGZMH0m5JW0uJETrzXFoOWrPlu+yQuIik9wYZEs3A4V7toOHXwAwZa50bFYuCgbpZFB0vtPXSaiWSisR6AC5HffIsANVVm54eP9wrqjTLMX5uKDFGeZmCN/9398j8zHmzjJrbpjUR+lxCeRFd/g789FsC3iWG5HqKTPOifr89qXPUQBo6sB9Ln5mGbXw2neyAr7lLx5WThp6V3aOLJ4G3/BaqHnx6A6BkGp78h8a+kRNGHTgd1objCsMdlfOcOm5c5KIT6+O9Lo2oOV9Pr1vC0aOiFHR+MXUCwAcUZOBd16sqbrmYDiP4ZapCtzBrfa8QAdpI7a7lbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZd9flg+sZKK2j1GPMJ4q1AmzaFemeYJf5BVFYZShN4=;
 b=ZbgRwXl0ps/r6h3uCDlDqx9Lx021OtIfr9RDk+c1P2XhBSQiBHjUkXYbrylUd1nWHSNYL+nVngh9tEx8dnFyxStzKH0V79a0v9kQNX0eavDhdeBrKix/iNCFft5fLUKePtHovIGaZNrjdUMDpafh/S7ey69a5PPeZNrqRwTwQiQ=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6733.namprd04.prod.outlook.com (2603:10b6:208:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 27 Jan
 2021 01:09:39 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 01:09:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: cleanup zoned mode initialization
Thread-Topic: [PATCH] null_blk: cleanup zoned mode initialization
Thread-Index: AQHW6JWhTDBaNFwpekOwBKcgOK9iWw==
Date:   Wed, 27 Jan 2021 01:09:38 +0000
Message-ID: <BL0PR04MB65148F93DBF17D752D599166E7BB9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112034453.1220131-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:59be:e05f:a0a7:a46c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ff65acb-cf7b-418f-beaf-08d8c260384d
x-ms-traffictypediagnostic: MN2PR04MB6733:
x-microsoft-antispam-prvs: <MN2PR04MB6733EE54198F6217A1C0F01AE7BB9@MN2PR04MB6733.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1i4UWjVfAA91jyItq2MTTSHh6n7beatfR1XN5s1F3UMPy4W7yOOwhsMVY8p0OfHcr0wMVR592grw0DYDkel1Ss+Kp0eaNCb73xUSprehLNiMU0IayyswHWe1viH+qjgzQoPgdM4hpnbLKAuiWjCya6SmE8uiUORKvbpahzTGUd5lrqjfYzd5AcEFQZqBwclnxl73wafbooo2rMaquN6iuu9FA0p5dYP+kt9rXCAh6ehwPirBM21mfACtE3uXZ7Njv+xn8HRE0AKk0c9LfU7pJYcY/2XSZga79BEA1dI/NMZ5pyDoe/JiVbgWhy1lGyENomj7FJ4XEePjfw99QjmWzLu4JlSXu59lGp1OHhXR3ucobEIb37DRpqnrxQSjqUB1JkjkHnd1au6ZaQ1NNnBEEBxwIgr36i92TGvJA18r47AB3Vvy/ynXnvfSUYlM97azzFTISQsYtAYDqc1Z4YcMPatzhJGF6mqo8ihHYgUCWSMvveCXSAzlMXo5094UmzB6Jg8lH/7fn3d+h+rEpJDIvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(83380400001)(66946007)(316002)(2906002)(66556008)(8676002)(91956017)(86362001)(66446008)(478600001)(66476007)(8936002)(7696005)(33656002)(186003)(5660300002)(53546011)(76116006)(64756008)(52536014)(110136005)(55016002)(71200400001)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3J/TwOxWEDo5kFYLCStOQUGI4Pu2bkfXiKcTXHf0t7/tKbx4bnEb5XDyFAMC?=
 =?us-ascii?Q?RgxVVi3hIngnNhgwWJ6JZEeltzHsBYsCwoGXeE03jNbFqSC1zylnyVgE0m/j?=
 =?us-ascii?Q?kwKSpE+CTsoq5NeRcPn4w0yihuBzC3u0iyuVXiViGcczqErf42qabVvPbSsb?=
 =?us-ascii?Q?y/nQugeybrwbSMXz7WhfLWavewseWcJ0dgGzlSz3rgr1bf8Lp6roEs6y//qy?=
 =?us-ascii?Q?fhNzseBj8OtsDRGix7REotGsepR8lDPjvzELdLQmjWRp4H0sZj3bbh1nISfP?=
 =?us-ascii?Q?iCrVQr8MmS8Kfe5EkBmAoKc8urfrYKlm20lkv+Ejp2xytlVDAfwaN8fag3tN?=
 =?us-ascii?Q?mpKhDsESA6JflH8JXpyHjQElUtFamEv+BZhfT73s5sPOGuqCB2sKNVM2BKf5?=
 =?us-ascii?Q?dqhqA7WRBv+vuP/iD9IaA+SUf28xMCPUAOs7bVMyWtNK5an2vDfH2c7YRToW?=
 =?us-ascii?Q?aKlpcsrXDUHlqUAbLm/fKsxY2/zxZi2GYxA9f+ez4Dri5JqK0HU+kIB90Hiy?=
 =?us-ascii?Q?wpdfo/sFctW8WLgrwf+NHm0ZVT/qPmDlZ59ToB+Ie3XMpTa9ZkyPxQfaXvg2?=
 =?us-ascii?Q?rAq6DxQuEJLv9dK4vwAQrM+NoXCeD+75YnYyuh6ZzHSsRU3UP93vnLkSETLs?=
 =?us-ascii?Q?rm9u7mB5xIJvN0ZzCAEZnkExo9ND1Ais6oElxKvqEySs69//EugmSLZ4hs11?=
 =?us-ascii?Q?LtjglZTN3zJpLsDM40HjrmC1g9IR46ixPtkYq5tZehsg/tn72GhoMI8jiv/s?=
 =?us-ascii?Q?3RbDKRVZ2qYq+zIJ/HguN7MG8P38eJCob3wAjpWwPRTPljBldoo+Rq4YRqXB?=
 =?us-ascii?Q?odH414WOiOJ1k1g+760NRQObhGX1ll2UAMyiBFDDMnapes41H5jylBah2Zzm?=
 =?us-ascii?Q?ehDt4y9oSYO5ukW4uT1lKDg6hM5dWf148kUNHhwUTlxCLvydzfoB/VvdzA+a?=
 =?us-ascii?Q?jhvH/bUDG2LqtvuQymDCttH1dM1ZQjYEnmV37+HSyKzOGgoS4aLh/rbXcL+b?=
 =?us-ascii?Q?IvWvUsrMl57Hb9TkRmwfvaQlXi1Y45M9T3aGAQvBnNNhQnIqsgcFBKHvM/YN?=
 =?us-ascii?Q?0XlzqXkp2NZi10Er2rDDLfAy3PK+My6AhmrPi7X8lqTFFXXQQia6/dpO0vmQ?=
 =?us-ascii?Q?jsg2IfJter/I60z5vEQSxZJdigQGCH7ctA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff65acb-cf7b-418f-beaf-08d8c260384d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 01:09:38.8918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7JSee0+kbfvLNLnv8P/cX6QGRb6R71vc2SqnmhJoff6cB5aXvxLQw3Q2MXL8LqV/7teg1XPA1hAgGUHnbrsPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6733
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/12 12:47, Damien Le Moal wrote:=0A=
> To avoid potential compilation problems, replaced the badly written=0A=
> MB_TO_SECTS macro (missing parenthesis around the argument use) with=0A=
> the inline function mb_to_sects(). And while at it, use DIV_ROUND_UP()=0A=
> to calculate the total number of zones of a zoned device, simplifying=0A=
> the code.=0A=
> =0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
Jens,=0A=
=0A=
Ping ?=0A=
=0A=
=0A=
> ---=0A=
>  drivers/block/null_blk/zoned.c | 15 ++++++++-------=0A=
>  1 file changed, 8 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c=0A=
> index 148b871f263b..535351570bb2 100644=0A=
> --- a/drivers/block/null_blk/zoned.c=0A=
> +++ b/drivers/block/null_blk/zoned.c=0A=
> @@ -6,7 +6,10 @@=0A=
>  #define CREATE_TRACE_POINTS=0A=
>  #include "trace.h"=0A=
>  =0A=
> -#define MB_TO_SECTS(mb) (((sector_t)mb * SZ_1M) >> SECTOR_SHIFT)=0A=
> +static inline sector_t mb_to_sects(unsigned long mb)=0A=
> +{=0A=
> +	return ((sector_t)mb * SZ_1M) >> SECTOR_SHIFT;=0A=
> +}=0A=
>  =0A=
>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector=
_t sect)=0A=
>  {=0A=
> @@ -77,12 +80,10 @@ int null_init_zoned_dev(struct nullb_device *dev, str=
uct request_queue *q)=0A=
>  		return -EINVAL;=0A=
>  	}=0A=
>  =0A=
> -	zone_capacity_sects =3D MB_TO_SECTS(dev->zone_capacity);=0A=
> -	dev_capacity_sects =3D MB_TO_SECTS(dev->size);=0A=
> -	dev->zone_size_sects =3D MB_TO_SECTS(dev->zone_size);=0A=
> -	dev->nr_zones =3D dev_capacity_sects >> ilog2(dev->zone_size_sects);=0A=
> -	if (dev_capacity_sects & (dev->zone_size_sects - 1))=0A=
> -		dev->nr_zones++;=0A=
> +	zone_capacity_sects =3D mb_to_sects(dev->zone_capacity);=0A=
> +	dev_capacity_sects =3D mb_to_sects(dev->size);=0A=
> +	dev->zone_size_sects =3D mb_to_sects(dev->zone_size);=0A=
> +	dev->nr_zones =3D DIV_ROUND_UP(dev_capacity_sects, dev->zone_size_sects=
);=0A=
>  =0A=
>  	dev->zones =3D kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),=
=0A=
>  				    GFP_KERNEL | __GFP_ZERO);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
