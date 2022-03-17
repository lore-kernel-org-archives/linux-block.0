Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414A1C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 02:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbiCQC6A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 22:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358527AbiCQC57 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 22:57:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF7A12AD8
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 19:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647485804; x=1679021804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6OgH3ntw2tRHtYQaTGBylCj3r8z/Lx9i46bsVMr3XjA=;
  b=oyNi6ZgkNxlMmGSjQgPzfWx3RFyjyKrHGKN0Jyl3s8o4v3RNR8UbiJxT
   BaYG9t2SmbTlvIfjNCNv30/6tKURnIq6ReVp7yItvkHcapFWnfA+JgKXG
   aZFvoZYVe4cxKHimlH6GFJIENRwlMt8rwp2MKIvl/QI8YYuht1jGs8dHy
   p48RDghoSyBKEqrb793zTgmmgUtlou33PuKrnL25I+kwbr4WfpIdI7vrO
   QLjjdPl/wS1dBhbNao9RbX9x47qb86PjVbz681YmAEc3xm7Cb5rpl0qsR
   gIC64dkqV7DvtyqYFSvikhVt7o5LZoRkIYjzNn71a6JUCghBwZJEyEfe+
   w==;
X-IronPort-AV: E=Sophos;i="5.90,188,1643644800"; 
   d="scan'208";a="196497149"
Received: from mail-bn8nam08lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2022 10:56:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOjP7vExDJ9Psr8GVsxjrDtzN9Im+D7y5Ma3/6pq4UriU/mpn3fV0BqRSUNcpm1oGo0Fl2zbhKfr+knabK3Ahcd2M1Ect/QgBjEkeBmmeksOPgd4tXIU5/jfvfe/r1Ch6bT3CjjjKDf11+QTv+LmBU/F3lJkXc2PtIlUmscW0jU8HdVFE3wYKqg9lkHrt3NjHBpNhuxfIa79VhAGXWI0bK3iSu0uzmU2GZnNExPFl2Mc+iNwSDuu+VJuQ2CCBCZ/KagimSHYgtf7TSw6EcE+7EcXSY7nEwYpysWr1t+cNQO8ILu6GecBzwlP1i71JJdjWKGOilSu/8sb0wEVc2oJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TOpkAwBAbgyjzQdL4wEeNFhe22ToxjF0upKwKIfDdE=;
 b=FofYGDJqobJEomGpXIvODs+kD1MV40MSM7bsY00GTYjPW4qsR8oLsKCiLUFRKBbQVIZcXAKd2FBD/deu+xGUfa7d4Wqqk0nNAIah+PWmyr9tmhdkZg/d3+K6ZBsKetjZYHF6kdUTrScf67C2hG6mHir067DYqIwVwvc7iFJqEtdURYvvIfkrYQoS46JG1hghmQoIkKNlMruvyljhyAek5LiJDxzIS3BJoMYptaBEj0duXzDjmMXlqQT3549bvB0gau1v4k0DEuev5siyNlPbOkRo6CCobMOsJmWZ7qWNfyjiV/mIYQ+ivTUHBNo/Q6TCZaJD1bDNgNbpyq0sSb16+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TOpkAwBAbgyjzQdL4wEeNFhe22ToxjF0upKwKIfDdE=;
 b=jkFEqDNJaEM+K8g47R6GPjqXC12BoSRzOqi8Yts2jqUd1haJMmLqXirfHfddWVvsiE8IibG9DDFUHj+aU+sRMWewtMdGdWCpqYy+ElKftH9JZHS9xmVBArxshFOqu/Y23gTT+NdTkSgCdIg/Wgo54/d38nQ1P89FY7xaHM7+ZZA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR04MB0492.namprd04.prod.outlook.com (2603:10b6:3:a0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Thu, 17 Mar 2022 02:56:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::954d:a46:a727:c47d]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::954d:a46:a727:c47d%3]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 02:56:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] block: limit request dispatch loop duration
Thread-Topic: [PATCH] block: limit request dispatch loop duration
Thread-Index: AQHYOPy1/KvO7JD5KkK+9HCheDmIt6zC40QA
Date:   Thu, 17 Mar 2022 02:56:39 +0000
Message-ID: <20220317025638.ha5kh5ezsfpw2cde@shindev>
References: <20220316061134.3812309-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220316061134.3812309-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 604f3a76-50c5-480d-6dd7-08da07c1c223
x-ms-traffictypediagnostic: DM5PR04MB0492:EE_
x-microsoft-antispam-prvs: <DM5PR04MB049294D44C88372982398327ED129@DM5PR04MB0492.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRgKH715+hXfLSn5CAlYjkOaBfJCfB709qBIAy6MtlUcPx6W7Srx351H2s6srLj9xbn2B8108W0LplZHuPVnbQcAFGtwllUQkN5ZlnJLkwYnycsQQuuPpJq6YZr5dSJI6Pat50b+k8MNcaM2QqbLSnuR+A+w8mwDt9OeJmi9HrR115ILEh8XSLALVu27I1tfXW/Hbubcm/B4LkWO49T3F8bY1jUQXykD7+I0MH8X2XDuZncUGzSGx2JNiqdgJb9T4EYvJ6m6ApYbtFfzhVtgSoEbafuBI3MDDCN+rTbZfObvNxK7zhIdm/pHSHv/wm3QboHM6IIraHHZTR9f1AdTxxNbB33YoDUm8kPxKo5LJ7Hmc6M6qu9FocIJ9jUGTKs/XhaNDtu0+s5CMFfJbsDmCk5qB98qviiN/RusY9Q1MXVNIR+o0x+Kui9J6xezi/g+4nkz9D7qbRQNBS7irRdw6pIpEVwX/1xpXLU4ue+HioknTHFCB1iBcPM9437wAlQ5ldn78QcIxuzjDnOHXBvk/78GWjVXIob5ZOilNlUV3AhESkV/GtjR00X/vWXeqIiu12Api6ZeXWIQ2d1apA9GmYnIZb21mjCBrKI+bcxpMKVW7lNrr+kFlRnYojZlolTcUk01/AwuUV2vPdKzGFjTvGaOdB5HZQ33ohrxrmC/ADI2UoeyfJp617nKq/xKrpY4QoVvFgOUFM1eaM6velj0ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66476007)(76116006)(8676002)(66446008)(186003)(64756008)(66556008)(66946007)(26005)(4744005)(4326008)(33716001)(38100700002)(316002)(1076003)(122000001)(110136005)(44832011)(91956017)(6486002)(2906002)(82960400001)(38070700005)(83380400001)(5660300002)(6512007)(9686003)(8936002)(86362001)(6506007)(508600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZtE8HEf8QAlZoIivzb1F7/lj7gYSmUKBmbPrtr2oPbZeM/8Q2xxwXewNxf+7?=
 =?us-ascii?Q?gDu9FfbRxMZOEsjkgYAgRinFdSXZKQ/P1y3HFqHCjlR6EFOGEZrfUfhgbL6P?=
 =?us-ascii?Q?vE2ZcedzMcBAv0RSOkm5BlUmu1Ky/MSFUzhpQ0h2LuWCuUDNqbKj4MS/c2f2?=
 =?us-ascii?Q?2SMiBcoAOwOp3V3i4KkoUL/yjhMTdM6mgcc2aO7U7rs8AhYajmGrlOqlkZlw?=
 =?us-ascii?Q?4J8KL3xi86ApI8z0KMNv7+PQMfeEoItnNwPZgcie9kPQ6hykCoCMapDiBSqV?=
 =?us-ascii?Q?dfy613wo2Jinmwzkwry53Z6BZTqUnyPwUHVCpws+yiLHV3qo8PXG0EYqKt3G?=
 =?us-ascii?Q?QlEmyzNJGeXcGIfUz/eGPDohdHBS22eDJWdCOR0+QUOlNfYWRbpZjfqLEwJ6?=
 =?us-ascii?Q?uxyyQ9rvV3Ctz6SJvBE6T9YiOAhG6RmMb8VI8waL4FEK3snVmI/eVS258uqY?=
 =?us-ascii?Q?uS+DKt7pk/QFJSjU1A5gpWFIad7UdxzspPRdQet0I/YWYE1/SzWCpc4wpgx3?=
 =?us-ascii?Q?WlY/cBf8852a96JiW/z399SDchfQemkf6pAkDk8R93pfgtNWEhAPG039YQ/d?=
 =?us-ascii?Q?8vtZ89nnat/hJLb4eUxp+LK8po+4KFsAkUX5h0RGBQgcOH1PdG98W48t10QX?=
 =?us-ascii?Q?3oi/PYhogpooyOsaadtgGdwam+ljvcJKqibrv9B+PvBvgIK/7LRxg283AEy8?=
 =?us-ascii?Q?mIayv7qT5ZOkI9PUjSWWAmlFHXT7U9Et2yDapTO/fnLx++NQQYnkPmYOGfFq?=
 =?us-ascii?Q?iUUjSkGXFTM9dPWKcNzsTlH78tlPd82JashToOquOKqLX37eg8Dj0JPRmUow?=
 =?us-ascii?Q?yv/V4fNvFcderafuKb2GQMKU+7dkoNtKNnW0UpvQoAkViX5enL5ERp69icUI?=
 =?us-ascii?Q?riOVM+fy3h97RinFPPm1poCw4gIA93WIRZ7PN+GeGp41qsLY3CbuYhOi0wHm?=
 =?us-ascii?Q?6mQuit6cu/Pc69y607D7x1XLGjqo0tKWTHfjjdvu8RdDIBiNxe9iLgUKAl/r?=
 =?us-ascii?Q?ZwKoaVQHEym02duJm/2P4QCnZNZCBjzOMqS9xT/PLRcrb8CybM3vPmZbSGPW?=
 =?us-ascii?Q?QkYbQ6/BTBqFoH3uzUF6H6X3z2MBA2OwtHJRNvrWqbgEQv84bLN5o7XMUk0v?=
 =?us-ascii?Q?EBjidDUV3GWelBvqhGJN+S8a6zsLyH5QizQdRyzit2Wnp2cvm5D2FlpxdCHP?=
 =?us-ascii?Q?IyXiSjl/IF8fTJ+vNTg5QaZ6e4sgCmJGgyfEhcsxaQVFitJUNlU5D0e+KuH9?=
 =?us-ascii?Q?Ud1Ll6T1Ymp6r77GyAt2uolRD9dnZicRur5ZkW+AVX59kMHQ3wYM+Ik255xY?=
 =?us-ascii?Q?r/jxEu58zd/ErugIlvQy0UvZU7N9eqTjD5Cz5DXq6C5L2Iwm1zLWpgiMhl4s?=
 =?us-ascii?Q?5PZghq1V1E42l99rXb3NaiJbB1mmZCe3ja0HqKjnXRdnEXlA1/4g3f00U2Q9?=
 =?us-ascii?Q?ZEBRDJjY7axMt7Csv90ddefLfczPoxJUCYZZUhZZ80cq1KOH1PoLei0NETDX?=
 =?us-ascii?Q?Gc75CpPXXvrCPms=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13B5B2FD1D8B834DBBF12760774EE173@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604f3a76-50c5-480d-6dd7-08da07c1c223
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 02:56:39.2581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JndEOEhCTVhWVsakFDJ2SDTtyVAz9I45iAR5miV4ThWJTnsuLLlmDf5yt//vghxV8cbljsfatZC9BnUfDx5SgvXdgBjbOe73rMY00+eW+z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0492
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 16, 2022 / 15:11, Shin'ichiro Kawasaki wrote:
(snip)
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 55488ba97823..64941615befc 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -181,9 +181,15 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_=
hw_ctx *hctx)
>  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  {
>  	int ret;
> +	unsigned long end =3D jiffies + HZ;
> =20
>  	do {
>  		ret =3D __blk_mq_do_dispatch_sched(hctx);
> +		if (ret =3D=3D 1 &&
> +		    (need_resched() || time_is_after_jiffies(end))) {

I've noticed that I made a horrible mistake. The time_is_after_jiffies(end)=
 in
the line above is wrong. It should be time_is_before_jiffies(end). My bad.
Before I post v2 with this fix, I will ensure the fix by checking call freq=
uency
of blk_mq_delay_run_hw_queue using kprobe.

> +			blk_mq_delay_run_hw_queue(hctx, 0);
> +			break;
> +		}
>  	} while (ret =3D=3D 1);
> =20
>  	return ret;
> --=20
> 2.34.1
>=20

--=20
Best Regards,
Shin'ichiro Kawasaki=
