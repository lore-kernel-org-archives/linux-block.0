Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26F3C433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 05:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3406135C
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 05:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbhEUFJR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 01:09:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16947 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbhEUFJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 01:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621573672; x=1653109672;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=PbkY8Caj/SWBmXiL828gtRCz1zXkgSEfgnZ5vYCKSwLpqGzCvZFgNAZr
   a46XdLcCrr/uflD0iW0dLPDFGWVp8uCdSF9HmlRsbz1tVzcplpoDq6MfP
   Muj1kB3yrWadmKM2jGIzSZbihL56wJ64r3HSoJFpck8x/2yAjA9NiyZFg
   nVEHtC2meXIA8XpnLijj9YbbOp9SrFZOLsoURZhJZzff2I23ogTKHzGrt
   9EdC47zK3sbXT+w6+JmL7kf6TZx4mzBaFrfzFkg9otUZIyDQW5kB+NkTU
   uB8c4dHmiutVGZm0cx4Aq0ra2Gm3UYZziy5XRVkUWZ7ymHdLZy9k4G0Js
   w==;
IronPort-SDR: VAHmfhvREAPx81Z65D+7F5y9DU3V41sIfO3EVyK24nNKMKM1gQ5q8x2fxG1hFuDKPUG+C6kh2d
 7wI3d/tul/HzPbiLbSlaDjagsQaW6JU4zqXOn2l6ndyMBXAYW7K8HDwoLjw0zLOisuX7WYTzPm
 Ow6EPAOfwVSw9xuQrSPZBBTgBFVAIqn88zTlsXVVPb5Zcvshu3JWAQdMg+yg2v8Gjwc1XnloAI
 JpiT7oSh8agT2nC7uduQXHwirPHj6QDbWapvzn0qb40Ll9PMFBsvLz1G7IIwtqwiPJHUf9f1X9
 umg=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="280211929"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 13:07:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQB26euprlmEh/dThsVizu9xVOR6HamFnyaoSaFZiViG6stFjOUCaDeFXiruk5gOWu8FZZgoQrqtqK06DPNnI+rWADhk/HOFn5AEHEIL6iWVY9ULexCtPY8iGs2PtaUSmaqm//37Xu7Cq/8Slo7P4cIm1Au9Wsf5oxRkVYQ2VgzVGtQLmWzOaviKWt6NOiEqlwYkUu/iy6chBhFWNBOPuRXuOPsTtPZl3Mb4tu+mhiNqAgYQh5AxJWgBTRWM2PXYRSx5Tqrk+Qv7KaK1aqnRKZhmsnmayw/rKMkL7GeWX8rktx7SNu3vVOAlqIVw9uUAP3YpFFP+gEuiejzjZnv8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lZcUr2+UkKK8QtBOVE2Yl/US/E/ZOIMoJgllFH7d8ArYNULu5wGvWkrLcikrbJtp4Jqg+Nw718UKk4WEzto76IgQ2Hr3Kn2boqMmEjFVyHR9mG4LfBEPDCk2r5aO/9+fF6avFlEA/ydYg4AgNWC32KjyI78lqiAhNNO2dC4VKh8o5qQcPmd9Uwu5NMrToYUylyE/Niy0h2H+5Mj+xGgrZmgRLW3S32bNydXajl/Y9VuU3cZpJDKDLeU7CHJQvy0lJx3tWzA7yycse8Bi+qeA+xnm9ojnp7LKwWxz2VmahXGnmLvQM4FsDABWiFV9onK+PHgVS0Ntv/S5ka/hnqCJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VWIOHMcb2KKykbZcjSi9c12zzHn5OuJskg+uQ+457bH/6Dynj+ixZA6PgcDevfkYTKlglfAarKYG6AloUXsYpvL/S0/Fz5uvWErTbimS03ul+TzyEaYDqDMA5UWrDeB+57DRuKGI9pDrtfHsL6EXYzDs2rdKv1aWcD8nGzEycyI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7687.namprd04.prod.outlook.com (2603:10b6:510:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 21 May
 2021 05:07:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 05:07:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 11/11] dm crypt: Fix zoned block device support
Thread-Topic: [PATCH v3 11/11] dm crypt: Fix zoned block device support
Thread-Index: AQHXTe2iQKcUT1xv2ECjONnMivJSnw==
Date:   Fri, 21 May 2021 05:07:50 +0000
Message-ID: <PH0PR04MB7416ACD55929833C745200B99B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
 <20210521030119.1209035-12-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7dc80ce-b0df-4026-bc19-08d91c1661ad
x-ms-traffictypediagnostic: PH0PR04MB7687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7687404F828AE8D1C8C6DE759B299@PH0PR04MB7687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TvhH3xsuwvtGTMT1ORHHTs2Y+YztuxnvH6A8EnD9OEyMMUVAMx1xI32Rd88Dq2vAgJXgb3W0oXa0OTzvcoNyn/0/o4Xi64kIC40UChGEJN4UtN4hmbay3VJNoF8XKLsYlPVZAny7ZpLeq/a/BTer5jao2Aa1Ei/pFIzX2AC6dFyXPDJQ/xBTo8Zj9njdDqX4t79ZmDW6viG+IZ/M1jQhddLXEICE8YZMFi0TccjZrnguRjnliufLVUop/KDC7tdaE1EjgHWJLlsrZN2qsgWeRaHBlkdAdPCwyaMT3Cn1szw9aZMpy+t3k/lQBBzyHfHRMznUFLV0WxSF38rW4XhTegYh/CBnKAU/Vvp61GjAdVEZbHfs0FODSFINnQHvJMcESGR2Y4LFK0gPYAbLOrwjsFtLtvlSjon4qOPPIsu338SHqx3o19TA4CkIMAV9I1vwQugfeh66JRnaHYppYVs0HF6mdw9wZPHltsWbFRHDSZT3Xjy2AtpZOPkOaSbRa7HAlCEV3vSSNe26ROQnJzGVylDZd6dVqyxeYRGigzKn06FCFKEpawzigUIEcttm18Kw8MyC1vOcQ8Cgd5AX1c/0D+z1ZxOA7pDO4T2U1q9JxQY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(52536014)(478600001)(86362001)(76116006)(33656002)(5660300002)(71200400001)(66556008)(66446008)(91956017)(66946007)(66476007)(64756008)(19618925003)(110136005)(38100700002)(558084003)(55016002)(4270600006)(316002)(7696005)(9686003)(2906002)(8676002)(186003)(8936002)(122000001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Xz0L7+JTdWMAkmANhWwXkPUKuV1L9jTNn3mqtFJQbpNdr/TwNVihk+tGmzfy?=
 =?us-ascii?Q?/59HKfwies+twrt/fMBQ4/pE42JkxWaiUHTYAPZodYB9ixNcTKerdSvUfYkf?=
 =?us-ascii?Q?obbUKo7gSHYidbMGkU3ZphggaEa8yYvlZQEKikIz+JiPKsqQXxC5hesPHPk7?=
 =?us-ascii?Q?u0k4ms/f0pc+oz0aahISObGvWxHWi5etQnWYjkaw4Uf+jrXtWqJiYl+wXPRE?=
 =?us-ascii?Q?g/gvAuIb5k36dJH+revI6MZ7KPWfmuBnydCVoxtdukPoAerPaIA3sHV5NN+i?=
 =?us-ascii?Q?ao/iC1X0pnF1nOGxwu0gg2uCxkE2xYbo3NguMDwGkxuhBjKeD/NeoqayDvBa?=
 =?us-ascii?Q?JtC8zqVdU6tN/3KLoaImJAqzw6xZLAL2ajwr9kJe+l67rqg8DK2Ygsdebd+1?=
 =?us-ascii?Q?y/BMBn0+41j1t4HAFpRIkSr5jbgQ6IcCymBMwbYGDvlGXFzLNHbW5FBYSklP?=
 =?us-ascii?Q?yAlnyf+e6Ow1q74bL0Fd7DphU/ANQbNCgniO5qIvsyncH3BtsMlisz4L0Zpo?=
 =?us-ascii?Q?rx3dyYpftv9wV/ifyoDwvuP1/usufNEQDrapFWrtTCJnmDq8XbLXtShnodfN?=
 =?us-ascii?Q?E6DlWQv4wJxzAKZfciZ4xpET3kA8jWhkEskF8T7buI/+/AioztHOGX+OvhX5?=
 =?us-ascii?Q?zhvwwUZfS+g4U8oZET+7ejTkly+CxMZK6DGKQ9TgcAVQxf7mdurSBOpzH3oB?=
 =?us-ascii?Q?b0x1coDMobtavlsq+fYXUHuYhvHzaPJfGeaWt7N6Pi+zfMRi1E6f4TVULvN4?=
 =?us-ascii?Q?hE36oMtFutSIm3EDq8fxVfgYv6zvjpl73DgjRCZj9beEMyiOm+JpdIPdKXVX?=
 =?us-ascii?Q?UonuUDUTBXvCX113RSUzuDYymcEM4ls1Z0HQBE9DcIJM2HzCQfu/wou4RIr2?=
 =?us-ascii?Q?ZLwBIsLgdezrrxguB8LIb7USJ73YkI8i7cFXjJiwDETMN1oIV0hDdDbG/K3w?=
 =?us-ascii?Q?WqCfykUozM5ivvjRWjdl3zwCHPSuzdS51OTjioUrZ1L19sd4ulANGB3VlBbi?=
 =?us-ascii?Q?vlIUTrp4RSKo7jgH3orzOHp9IBc3rTY2oprjejaiCBIwjkeUZ1Ye2yL3UZHL?=
 =?us-ascii?Q?IekQUOfPgbb3CHUTo7pgU6Jf3IwSafA01e8P1vvcO037wCZF6bUQzOL/C5Ex?=
 =?us-ascii?Q?3YgYmd5y40JRHAgNagIWWIre/taMZjLRCDoEg+0TrZTe5TK9DxhzyYE5J1AO?=
 =?us-ascii?Q?V66BN/AinaTGiI4DYO6BlV8B8uPv3yFH+t2ZTbYL1VDw/yPwoIjY4q7HSfO3?=
 =?us-ascii?Q?mhgNgI3gQxRkLv4El2vnykkI2cGUNSR8Uf40vjc3nhkKfghCD8gafek2oQ8l?=
 =?us-ascii?Q?ohHC21Astji6UYHMRTpW+Bat5o3f9vKJ+crwoCoEMnBmkCoTl76CSdC2aWm8?=
 =?us-ascii?Q?QLAYfw7o5n/T+PhNjjGj0NMJ7/DGmmZ219RqAwMwPAwkkPfNDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dc80ce-b0df-4026-bc19-08d91c1661ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 05:07:50.2164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPgMXU/k4F88jgbW82npc6LwNE9NlQyPaw7WTHuEFGx8z8oQawDD+eIMsH1VdI7b+WovpX76WXA0g0DohbN2sL7/TMOpAmFoiNKDeTWGHQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7687
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
