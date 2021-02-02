Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64790C4332B
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 19:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A8864F7B
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 19:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbhBBT6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:58:01 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30419 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbhBBT5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 14:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612295866; x=1643831866;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8yVQAq8DLjvJVul8iPMq/nkwOrlnXste4hu4s9lVolo=;
  b=Kb+PHiChU3D50LogEPA/2+EDGrYpIm197AojHNqnWZyRyUBcGc6OYuo2
   7UXPpu6xY7nQx6oHZr4qAfkZfwKsAM0Pa4RLNPViOgxonr+WGhM4RF58G
   PiMsZe24oXAmBU390fnU22UzqF6EiPPSU9vwbBVYylwPk2PyO0AwCmL0E
   gRiFnQxCH5dxZcYMa57L280CY2nt79SsA8o2jUA2qSjX4J8uAEu1pCUey
   +JiM9q46SEBnDaltak/BN9ZA3KMN2zNOCAE9ebdDHDDhUW2w4+K9CEEgl
   bNvE/SESAFkvonNE0J76MYDEiHFZ+d5C1yB4mPmTas2zXRZe3t+8ekJ+m
   A==;
IronPort-SDR: l3hUyGO44n6uRDFrMBwuWT7lh5s5XrBWlGfBPdxz/epu8kQSn4iktqYw6wIqxjEigHDEhKsduU
 aLfMmralDtuNh8aYNuS+H2D5PP5ONLC0ZLg6CblJEY9ed8rtAQ5MUn7HBvg0AN1d/QaL1rfy6q
 DxXotjipNyUneFm27EkqewrQWQWkvjf1xWkhQEX6tx1M7kR+7xTfgy7zlI7VmoZOKk8UGhgfM0
 3apFXurof8jqgdRLjl4+PTPdYraXhnLEpvJDTs4qsM1nmAyvaq4Jy/Xa/5Rv+MWJvvaXngL6pl
 yLc=
X-IronPort-AV: E=Sophos;i="5.79,396,1602518400"; 
   d="scan'208";a="158955526"
Received: from mail-cys01nam02lp2058.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.58])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2021 03:56:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsJ/MED2Z1H7o9ImFtlHEhn5OOUZaFImcuMmul1oa1p4S6ADCG9jLb+yxzVw4fs7gq0N4VMwjx1iea2sHqJWFEwkNm1Ks938AbC3xAjJois2Ag4a4/6nZICMw4+wBn3fdw367VGoc5W3wewIuCpD5D7RPro6PnNsBvNQ6MvNRNsenf6jeuOmsFgf7sYX1X85mezrpaaI8Owy5z89SO6TgieojnnDWwOhkNQ27wvsp6VQCzWIiNTINf/Mb/hOPOEzOyd2QEDkbnadREjRZuL0B2ykYWRGv3kn2TGqIhdSBUxO3/W3or+d/998w9+g0hknltV1IR0lw2i4mjYhSqqxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yVQAq8DLjvJVul8iPMq/nkwOrlnXste4hu4s9lVolo=;
 b=A64dcPEvCVnZ6Gn7O7mMsZMjNW6wxRNUJmoDaTLVZLQvZoZl+ijY6wMABSYkxm2g3HCTKQPuAIZCvAEP0m5SerqS8V0iqiGdvpowS98HgweCfIdhvhlqMAJHjy1W5Ph6PBKNYzRR2XDXz/0SI6Fe2B3GY/c6pAmm4Vtlww06Kg2vQH45zVKtxDyyzwQqFeN/8esDbtbqZAKXUGZ6rhE4GHUKgYHkjedLlgLBYkg6Q6YUAP5QQ7JEclYcO1WF1tppepMX8mmowm8cARqV91HH73jS73KlQoYNJJwytQOJSfJ2x7Yz6SPJ8r66qz8B1vfseOKczyU7wotAYlHvjZ2+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yVQAq8DLjvJVul8iPMq/nkwOrlnXste4hu4s9lVolo=;
 b=LXwYafASZYilxo2NsYYDFsOz9yFmHMxDRkyVhjJVoeElNUI+kiFzz29eByu2gGMko+u3PofGf1+M8IF+yjc5dDT1fc2+we+DTDCJq/YggUnZKhU6bqTGFckMYRXEvF+uLFXuJlOQOMTKNd5AGn75TQn1Ykqt44njpkSTSrNMVq8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7632.namprd04.prod.outlook.com (2603:10b6:a03:32d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 19:56:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 19:56:37 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 05/20] loop: use snprintf for XXX_show()
Thread-Topic: [RFC PATCH 05/20] loop: use snprintf for XXX_show()
Thread-Index: AQHW+SVf9Tj+hsx+nUO1as/B6HMREA==
Date:   Tue, 2 Feb 2021 19:56:37 +0000
Message-ID: <BYAPR04MB4965AEBB4A7310232D72801386B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
 <20210202053552.4844-6-chaitanya.kulkarni@wdc.com>
 <SN4PR0401MB3598CDD73D7AEBD1D7CF72AC9BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93b274d7-00de-4dff-d9b4-08d8c7b4a660
x-ms-traffictypediagnostic: SJ0PR04MB7632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7632B8EF42CC7D2754599AB186B59@SJ0PR04MB7632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WWBIQTiY86DoTxum+uZ7rTCGmuFZKT8h1tuwwfmA993Lqzgb53ZF5zDsjs2ZKkUJtsmyNI4XrVM4bIr+HdlbYr3PbqU8YIQ07tta4vLoGN5NuUA1OVCnOwtKZXu0oU3xCjowLqsS9BlJzOo9Ydt/SbMgKSArgIqkKawfSpIFn0nwYmn/bwePocDzpHG1IR4rA4A/xAgkboJYTL1h5jqRXYenoKnbje00sJvxQ1Exr3yxcEDC3+E5bDGMstxkQ7qoAHUEAVv+Oc+mAJZw1pdQwM1ahRoTutNVr9a/GnVhQPXEBKQn2BptmcH5lF1HsiyB6xCwEPEVMmyWWtQJcDGLCKuxv2TtvgRr7eG6C32BwAFOPUcj+whJ87R148J4l38koWr8WKA0Zlk1u+TYCZpeVT2+6ht6APA8NxvSXDLMQ51Suf5zd2A1Xq185m1ESEydY2r81ZNMT+dr+pI+PUr98bxJRlmmnVd8uOYEr8ZqiJzuywKx3+v29Ri8qssTut60h4ljAAxW09YTWwQSBKFOnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(8676002)(86362001)(9686003)(186003)(7696005)(55016002)(8936002)(26005)(83380400001)(2906002)(71200400001)(66556008)(5660300002)(558084003)(4326008)(76116006)(478600001)(6506007)(53546011)(66446008)(64756008)(66946007)(110136005)(316002)(52536014)(33656002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HZT+8iVcHMbeMCctv1ueOvIRi43uDaT1mq2D99irCPgGwVZLzAsIrEbDhDb6?=
 =?us-ascii?Q?/VowoPzQzMrAtE6UOzOo6mFP8t6/Fo4A6qqeGyfTr81R7TmKaTb6my5DvCv3?=
 =?us-ascii?Q?XuMHO4tGgucdayEOgEExgOmbRsBl1wFUyaBAXYqef5Pw47agVY7eGeWD97eU?=
 =?us-ascii?Q?xIiA9QC4TumPDHxR/aZIY5K29B70xwcbfr1Cn0Nc1Hz8fdY3DRAGSksbkFPw?=
 =?us-ascii?Q?Hd15rfRzG0f2jWHVH1hDmUGNjffmKVlD8dehRyKJ1/G0nlrgHDJDiti3VssD?=
 =?us-ascii?Q?4Xe/2maYtb41RZT7qTPUc105PeiSKjAHxPlmQS+b2sUXoyVgaf3IFaWTH8c3?=
 =?us-ascii?Q?y8m5t//eJjR5BXHZJRyg/HQkXssXABezMsVRd8UAVeQirz/3jMe29pXd+tsB?=
 =?us-ascii?Q?j13PyRHc3g/plIDFu14ZF+hshgtUs/up2R3yu8bIcjHBrkhbtrAZMu42ieDZ?=
 =?us-ascii?Q?dXaSl3PhDiBQwoW3oSbyVExJF46AEs/MLJsG+1OQIcVbAo4/SaKJjpTcBjE3?=
 =?us-ascii?Q?IsVekrMWluR6iGio5LbzDPF8d9UA4TzDZTV3LcQa/vWdN7d4wKt9nZLKDB0a?=
 =?us-ascii?Q?eZ16sNUldtKERKpxAOQKx+GulP9a2AIYywJ1N6/jXEdM2MwGaTX+dpJxux/X?=
 =?us-ascii?Q?6wzokl60HWy68tVg7mNm4WRAZ5Zn7d3db09o9tsD5F8/Q/XGH5iGFsvMLdWH?=
 =?us-ascii?Q?vHRdkzczIJABM8NaQcWWF5VoEJSRMpIymPjJDTjaNDhY1tt3Cm4pQLZqaqhH?=
 =?us-ascii?Q?3EYbcXI0Ocpi1XwNxNH7mt5fql0b0bgz3CAdof9q75ifHGjpHnqP1P/tDThm?=
 =?us-ascii?Q?pAExhC0WwSzYtybYhZEsHYuWj/df0DbyT8dtK84OBa0twtDLYlaTufiUEMAV?=
 =?us-ascii?Q?eUr2rwMDayLabjhNu3RCdyO1v620S3JHdnsMZ8aqakXjbNmOtNEJxs9rNQQS?=
 =?us-ascii?Q?DB25kD+28pJr46otShai8yBeLoB/tRmWC+AaQq+h1cZ+ZXnZ3fM0VQABDcWf?=
 =?us-ascii?Q?gVklpiFWiV2S3kOLM5RqUKZZgXuJi3PFP9VGK5rI96H7SsXTR+9/xO0c2jbt?=
 =?us-ascii?Q?M2NO8TGwxZEX/0NnVk0hTEbKPWlv/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b274d7-00de-4dff-d9b4-08d8c7b4a660
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 19:56:37.1101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ab5sJAxPhgH3ihU8qAsVz+N9g3DW7P295ti9N77GOopjNGA0mrqncwld+Sp7LpJQmdYX7jC/PnSgKkWy4JlpSC1SnCS6pdYK/9HUZZpyToo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7632
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/21 03:05, Johannes Thumshirn wrote:=0A=
> On 02/02/2021 06:39, Chaitanya Kulkarni wrote:=0A=
>> Use snprintf() over sprintf() which allows us to limit the target=0A=
>> buffer size.=0A=
> Why not sysfs_emit()?=0A=
>=0A=
Sure, will add to V1.=0A=
