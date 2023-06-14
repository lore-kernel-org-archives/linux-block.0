Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2761EB64D9
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 10:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbjFNK2J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 06:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbjFNK1w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 06:27:52 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335BD4212
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686738337; x=1718274337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BTd8toamKcfYq6CX1tIU3nINvQNCiEpQMBtv10y0iqQ=;
  b=Ls4Cj4zC/Rd57JsK72wro0WePG/btbdLj8S2u5l1V2zehkuJo4MDwrsO
   q3Aje4qssddbwhackEVtXEylpM5qSWuEBF/CCaZ0I/Wd5j/ygANgBl36R
   SP+YAVlXPPnSGymLpUZ5768yCAJQWQ01CAfnghti22IjHZZxFVSE4jQXY
   j8FAtvbkoyyTB8btPlOoElX+Xtw3aFB0NifdmHZ40x3gcrzHG/AfR9ivH
   1vN6siv8ARl8i05aTWd2iZo4O57AldBd0dM8YWkaOpllbovOHrNcQhx+z
   CnJdGXbZXEgAiWKfAH5biOB9Vk8Yt1Q9/+u/aR8cr4pWAj35x+lnw6C7O
   A==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681142400"; 
   d="scan'208";a="240070090"
Received: from mail-bn1nam02lp2049.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.49])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2023 18:25:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDtMmy1ZkBkfWONHidN1PuF0AeGtxoX8l0iMiWiCTcxS4sluInTWKfqOPqxWKKQlLq0IDuqzIE4oC9e9ROJu84dyppKervt7i8CO5ZN6xcjwGSsOT6H7o7Mz6jJ+eh2leRbdXHctOy8bYKd8afGecZZ4zhPDYe6dWZiqRzI6DMEkjry47Ev7HedzepDGzcC9nBhXZL8VKOK1RYE/a5/Twwqa7FtslguFm7h9fzw038j9UkxugMkT5/Icxr8sM7KUtFxHyRmY9s13T8TJ24HaDDgD1FNoqBwJWivgSpV5ghJ4uHo19Y5mzR7DXJv0zsxRKnVjg6O6abqRR5sNCYSY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5gLpnoxwrN8xlVM1h6o729G2xqdbAVZloRUmRqYmoo=;
 b=OH68KtoqqWrZ7L3sfMl1nqPzB1OyPRicGcFsVmHRLKViBk5NSjN//sHx1jdGGlthw9Pj7Kd4xqu0Sy9DMTImMqiuU2hrMYibi+QrPTTz+fXDmuDZiEc0/jYHOufeD3NsdF2rAQ2re+/BSGLewKFaThc8Y9N4YcM4M7tnWYsF4/v6+3EjL0GeslAzYPSl0W9q4/7/ZLQSP9O3xXLyoV3mDm3+2YLbiOtqVB/0ihhSeekp5ub8IJvYYuWoDotZJJyQIULftjB88tk7nJ1eG2OoGAWxD1lgvgwZW1kn1msUZlo2pcxvZO0YivlGiashk0v80jgIbR9yaCuC6l40OlXaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5gLpnoxwrN8xlVM1h6o729G2xqdbAVZloRUmRqYmoo=;
 b=b/woGKW9Er8N86d3h14r7Tg3o8ehAnZLb3SXJaYeQl9Ln8GBFFGFNcR0Yef96wwvwKc4wrw6O93YSfpepOxUHD0PdNRiaWhUtV3PsOHZl2ymBWvxGmLL2TuBpwSgkkWawXQV/m0KS53W3u8R0kQ50c2SbP/Tz20PA80A1En36Cc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB7930.namprd04.prod.outlook.com (2603:10b6:208:339::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 10:24:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%6]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 10:24:59 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block/034: Test memory is released by null-blk
 driver with memory_backed=1
Thread-Topic: [PATCH blktests] block/034: Test memory is released by null-blk
 driver with memory_backed=1
Thread-Index: AQHZnQ45t5C62B46Dkijx0QE/oLx0q+KGtCA
Date:   Wed, 14 Jun 2023 10:24:59 +0000
Message-ID: <vo7dmulu63ugodznikrzwdcsd6crvt33qydclwuej6jqzrxp7p@jfugr2s4sp7k>
References: <CGME20230607115145epcas5p1d8a01f6fedf7b3522db1353d1a08e78f@epcas5p1.samsung.com>
 <20230607114836.9779-1-nj.shetty@samsung.com>
In-Reply-To: <20230607114836.9779-1-nj.shetty@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB7930:EE_
x-ms-office365-filtering-correlation-id: 1df6dbef-3b75-4df0-7447-08db6cc19b47
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bI71dq8KpQ+tkp0YRJQ9Nuol6Tw1Hqu/8KLONbs46agCabqvz1DXiVWtvzdo8HydEteQY3RUH2DupIVMqiddU+3rNZIZIx6BCkk81esQwsNOizVa3f6PARVnldhMozctqoyg+m5Ne1pzk3lUQ50vbnzGqQ1eQwakXp4GrXUN4MJpiSV6uQBw1+eFSycQOI0JsyvPXvxYZVKh1D1nk2a9yUqm0/eiE58YweE+m0s/VTbd1RDfdGUrEQEj2phQmqVVNPZJpa8BcMEBd6J6NctlIF0Bq/oxi+G3h15rgxvElRevSBk3hfJlwBmxP4PZWZrxVnUgwLGyHLBdaX056+A0716pvKgM947g9Y/1gArtB10d0LcYT2DJEVAJf61Oh5EFq6SzSt0NHE0gkmeGrSaAPKKY12S3DKJ20Ldt9Fa/2enSb39CiU9O5bgkzrTOejYBUtHY1mW1LNboKObXPwR6+sV6RCMyeKzBiFxbzGzVkU9CeJrI1ReNr23fxtKn12SAZkUWorkNn/wKpZSeEV6N2f9iZw9ceTNv7jgJ/7cybt3HRjcbpc4/AdEw6qMhrGT7z0tfz94IicoDsMySuPMS4eza4tl9mPp6c0QST5CQp7KRIQGZpES86weVD9jPq4m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(83380400001)(5660300002)(186003)(33716001)(6506007)(44832011)(2906002)(41300700001)(6512007)(8936002)(9686003)(26005)(8676002)(6486002)(316002)(38070700005)(54906003)(122000001)(82960400001)(478600001)(38100700002)(86362001)(4326008)(76116006)(66476007)(66556008)(64756008)(66946007)(6916009)(66446008)(91956017)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O5ReRTZ/Wpoe8xkt1vBTNTDFoKEzbg0L2/IHXGvL4ZJ4m8Y+fIcyq5diO4Mk?=
 =?us-ascii?Q?qg0JXu3pFFTcJsxPvxDVYaCXwlAnFYi/pBjVrfoA6G+uPHDZnfgYo42Wm+IU?=
 =?us-ascii?Q?JUGb04W2yLad7hbmJEO9nR4BZ9rw2A3+u1QXAvXDxJc8jlPwLib7lwlRitK9?=
 =?us-ascii?Q?EroT8CTFXujTnfVbOMg+rerTiEeepNdAEiRGCzD3wUvNKeXx1ra+FNxuDcM9?=
 =?us-ascii?Q?OvmmN2i2eDYKVOLn02aeqgucbh/1/+Y/ZaEpHBNDfsC1TG6GcWYxHt+C51lg?=
 =?us-ascii?Q?nY56FehUC9MvoMHPUvs+nuUAgHWG5DjYny8sl/f/Yfn0kQG3Iwr2+Fin7JwW?=
 =?us-ascii?Q?nkdhynaSRy9Rs38JX/3V1Ys3jR3+ygCN1CF3W/jVgPWiUS0fqvv6h6N10XUF?=
 =?us-ascii?Q?CqZ6zT3SvxXuD+GE3ARflgXGqIp3hiuFqJ4LPB14OvxyhWQ5JZUZz7GtNvaK?=
 =?us-ascii?Q?ZDIeXrcuSxgz+meNXC22krvP+pa+ymVHoPkkUiZPuKsl6tRHafn5y+O4PlTj?=
 =?us-ascii?Q?Xhmtzj+I7W5l4FEKwvletaEGuIbseUT+LJCTdqBlxup1FTo9NqhcXp9jxCto?=
 =?us-ascii?Q?yLetkLYuNcherSVJ1jEOS+cWo3kEJ7UMTNT9FCynS/uiaRnoIFoHyLHVxDVK?=
 =?us-ascii?Q?iA2dgxlnNC5sIeU5yCFD9/nKjqjykCLUADlvpYG1/HOPBnDAvf6y5+ILibYg?=
 =?us-ascii?Q?owDBKXSRLzDmAntgk67yTTVlNndpfuL/MFeIuivfUEJKdmLtm739Is/qyEy/?=
 =?us-ascii?Q?La4IYf3NePrRgv8dLLVvMG8grTdRTbyVzCgCzYHHawqzhlXyjei+KKV8WETN?=
 =?us-ascii?Q?myzoqSWZrSpQbvbcbW3b4g9q7ZDejgk2HzN5PQHavRxkuBxrZB/fWWe6o1J7?=
 =?us-ascii?Q?aEGtRcf/ONvjaoGwTn4cXGx9uBvbpWlqxoZFQwnaBU3naKj9HLpxwIJNSZXt?=
 =?us-ascii?Q?+IE7iw/xTcu+nHk29fwnPecjcgrOz2zcaEXPeA6z1ug+DhL28m+E6aLKHped?=
 =?us-ascii?Q?W8EpvFQoNcuGA+6JiicU/Ug1/77sTq/KhvXs97sffEN/vXzOJ+E/2C8+v7kT?=
 =?us-ascii?Q?YlBgun6EfRZQxnDbJWKKzd3WpFJ6O1EZyhfW0rEkNFzn2XflABviL5AzTjks?=
 =?us-ascii?Q?fPB3K5dryEfprG1S61FC0+lFScdtl2cUIp3eACJT7/N3FFN4ymb7ufJP/ceW?=
 =?us-ascii?Q?PgW5/HeANP5zSrtez6aN6QV8FhgLRTFjC4++jMO7n84IEGbXfiVxBoyCm1/J?=
 =?us-ascii?Q?B8Wtn/jBl0gWghCASl582JmiijtQpqpWKp/7gwuh6Z4eXVFYa9yTLaKBJ9dC?=
 =?us-ascii?Q?jPt+YBQ7ZTV+jZiBqI4/yGTFuf1382heGHMgWgaXnCStc3MD4xvWTi0odLBb?=
 =?us-ascii?Q?G7jHlqVU/yxgyTotR+Q0pIK3h9p6icP28SFiq3acw63QIPCwEhcnz1lL8ZLj?=
 =?us-ascii?Q?xe48SlCV1EJgfplmbUVJFnkkBMilYv8yody/Na/kWO9sk0M43E9F2yalSu7x?=
 =?us-ascii?Q?zr1GxfjZsxrGtntCYHxOoMoG5RhUG267hcIVc5xjAhfNPEksWcxC05cSPOLD?=
 =?us-ascii?Q?lclrmCR3FDP8Zwk48HBhZJQhYJHQF43bSO+u0y3nSDMpBfNGrVT6CPY2+fwI?=
 =?us-ascii?Q?He+/5JrVJuHsFX8HdOTNd1g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82BD28D25157E146B9522CF2E197191C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6OMPihqEma/fSyKDbPqLhoP4Xj8xS9Ebq/vaQZDRI/ny6gVi0CtZh6UlwnBWEoHFq2xOjHmUZKGf87goqiqv6L2UqABiugKfRAAdHvDnPXCYaklYp3vCPBcgiEH51tEEjhV7SO4rheoep0CGNH0AVZuX/H26+9LORP2P+wVBeublmJPYM3b/s+UI49FjnjsYnwDrrnOhRPbaMr3jmwd36ztNx3t15zPIzpWsrqyTGhkDNuHoKSt7XEolyFSwY0PyWw/rVBEFEQeu9zkfHQAA1QKC/m4imsEvlnSk+BneUAheVQaG7KR9GCvjFpSy/5tuCNvDIIlBHELqpkUT/Fj8tpgdDYM/p6c3O4K8W5XsSzl06t5DGZxixOciUdoWBGB9uGm3iZA8RQGsInRvD6xSyWAvp1vsrWXVeRDe12egT16KhGruwGun37f1UwJrsPsHCiYr96kmbNz6U8XfbKhxGKwrkLC+YPACgrn5SsOKt5cd3ak9XRvzKJjmap1BnCbkHXknNkVo1J82l8/1mN+S0QXcCZ9JtVLJtVjTbC20HOcncUe1mDoVH+aH9PI860C0EYt5UixU+wlNHpi0mhtphzUIBo/kE8CtxI8628GvJetKompEIFI+gsmu0LxmZX9StXx3PeGBF4LnAtiiFGI0JoKtDy/4zcL0Orbyvufqbu0K7587w9B0mZhqliSAqj3sZXzI+L/aAYXAViU5bWfhDKqLuAa9OC+5DrdI89IaRA+FkZBmarOmC8vcVWPKMGzat3IEP0ChFlUTYquDQWBczuP0hqYatHCmbp4W2u+28LHFrU5UTly5mEiiH6F+i9Dp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df6dbef-3b75-4df0-7447-08db6cc19b47
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 10:24:59.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwwsuaQEPmUQjrtTXeOJTpVazYdMR5abkT0Ck37anKXBNGIfMeC5+w8pd2y2PAfLyt3SoIy2KvOrOC1WY/IG+1oITqlx/lnJF6e44pEY2qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7930
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 07, 2023 / 17:18, Nitesh Shetty wrote:
> This tests memory leak, by loading/unloading nullblk driver.
> Steps:
> 	1. Load nullblk driver with memory_backed=3D1
> 	2. "dd" of 50M
> 	3. Unload null-blk driver
> We do it for 5 iterations to avoid any noise.
>=20
> Commit 8cfb98196cceec35416041c6b91212d2b99392e4 fixes issue in kernel

Hi Nitesh, thanks for the patch. Good to have this test case. I ran it
and confirmed it detects the issue in stable manner. Please find some
comments in line for improvements, and see if they are reasonable.

>=20
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  tests/block/034     | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/034.out |  2 ++
>  2 files changed, 62 insertions(+)
>  create mode 100644 tests/block/034
>  create mode 100644 tests/block/034.out
>=20
> diff --git a/tests/block/034 b/tests/block/034
> new file mode 100644
> index 0000000..dc4f447
> --- /dev/null
> +++ b/tests/block/034
> @@ -0,0 +1,60 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Nitesh Shetty
> +#
> +# Check memory leak when null_blk driver is loaded with memory_backed=3D=
1
> +
> +. tests/block/rc
> +. common/null_blk
> +
> +DESCRIPTION=3D"load/unload null_blk memory_backed=3D1 and run dd to chec=
k memleak"

Nit: the line is a bit long. I suggest to remove the part "and run dd".

> +TIMED=3D1

The line above is not appropriate since this test case does not refer $TIME=
OUT.
Instead, I suggest to add "QUICK=3D1", since it takes only a few seconds to=
 run.

> +
> +requires() {
> +	_have_null_blk

Instead of the line above, I suggest "_have_module" null_blk. It will expli=
citly
tell that this test case requires loadable null_blk. It will avoid executio=
n of
the test() function when null_blk is built-in.

> +	_have_module_param null_blk memory_backed
> +	_have_program dd
> +}
> +
> +run_nullblk_dd() {
> +	if ! _init_null_blk memory_backed=3D1; then
> +		echo "Loading null_blk failed"
> +		return 1
> +	fi
> +	dd if=3D/dev/urandom of=3D/dev/nullb0 oflag=3Ddirect bs=3D1M count=3D"$=
1" > \
> +		/dev/null 2>&1
> +	_exit_null_blk
> +}
> +
> +free_memory() {
> +	mem=3D$(sed -n 's/^MemFree:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' =
\
> +		/proc/meminfo)
> +	echo "$mem"

Nit: I think the mem variable assignment and echo command are not required.=
 Just
executing the sed command is enough.

> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	mem_leak=3D0
> +	size=3D50

Nit: local variable declarations will help to read code a bit, like:

       local mem_leak=3D0 size=3D50
       local i mem_start mem_end mem_used

> +	for ((i =3D 0; i < 5; i++)); do
> +		mem_start=3D$(free_memory)
> +		run_nullblk_dd $size
> +		mem_end=3D$(free_memory)
> +
> +		mem_used=3D$((((mem_start - mem_end)) / 1024))

Number of parenetheses can be reduced:

                mem_used=3D$(((mem_start - mem_end) / 1024))

> +		# -10MB to account for some randomness in freeing by some
> +		# simultaneous process
> +		if [ $mem_used -ge $((size - 10)) ]; then

Nit: Bash arithmetic could be easier to read:

                if ((mem_used >=3D size - 10)); then

> +			mem_leak=3D$((mem_leak + 1))
> +		fi
> +	done
> +
> +	# There might be possibilty of some random process freeing up memory at
> +	# same time nullblk is unloaded.
> +	# we consider 3/5 times to be positive.
> +	if [ $mem_leak -gt 3 ]; then

Nit: same here:

        if ((mem_leak > 3)); then

> +		echo "Memleak: Memory is not freed by null-blk driver"
> +	fi
> +	echo "Test complete"
> +}
> diff --git a/tests/block/034.out b/tests/block/034.out
> new file mode 100644
> index 0000000..a916dd8
> --- /dev/null
> +++ b/tests/block/034.out
> @@ -0,0 +1,2 @@
> +Running block/034
> +Test complete
> --=20
> 2.25.1
> =
