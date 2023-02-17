Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB43EC64ED6
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 14:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBQOV2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 09:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBQOV0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 09:21:26 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E643C6E65A
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 06:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676643671; x=1708179671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GWxVZHdGym4rPOsOKHAw1OKh2IfaCPyBYI3bBBHVfcc=;
  b=R315LUAehGyjfsXUaScKW8ProNBwCTl1SFS12ga8/nUPNKNS+pNxKVor
   CqL0DTSeOmCZdNqi6zjwKE+Msa4Q5Igj36VXM41F3d1tI/+rJa7LOeVNc
   p0MkZ8wZF91sXV8e5/++njYwPYqyNY5mHVV5W1Y3w43R/7KQR3rGx5O6r
   bVC6gWPtX13M/mtqwZdk4HkYOvXkHGVXLVCaLWFq4EytIZ4gAv2vPuEWH
   wNPNFqUuAzcgQysIOkzqGihhhlmj4KbP9AqTp6flcfh2X7hBqH+HeIu6S
   bOaF++YXEmubFXciJ2sy91uFrKGO42N3TvkZNus9G6SFV6xUXhCiwsLwc
   g==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669046400"; 
   d="scan'208";a="223366774"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2023 22:21:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiJTzrHv8iMZYWoDjcBo6rGD5E0ctXLya5F7D8L0+IPG8XnCL1CTYsVWj5y8Td+9/m8z5uP2i5Xk1FTJiszzgYWFwFVOuj+QGo8F+CJtmpZPK4vOgBkZXw3CTqT1nL0cDwrbMcCl/3JtLRe8sPbSekrEJX3Dz0o4GZv/Zn8d0KN9cu0VK/bgrYUcY4ZOdz9PrEtlm3o2xpqPBv73evmvBzJfkJ1qgjoJiw0DYDPM0G67nnTl5zpy6lu1WscdwSiZNXg60JhaqpgDithJyzD3+boTCbGrMaf0QMZyW8Pz0AJ3Js3m/gJflOBAF/KuGztn3CzCb+OY1ZuWE9TQshUKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hai6cM8u957Ko5Rr10rMpObK3d2MEiEDmqDXAkbH0hQ=;
 b=ic6gzGemR9qjB3nG8pRrldGx2OYGBoa3G0VCz3ULpqRD21Bp+0OhVZVxDS/5Q/WF5q7U4WEU3WJcRIEaJut5iG5YiVUT0fZiNluwF8p5pkvO1cE1L05xW54l3KKR9RIlFOibMiH3V2ok3q3GYgcLBKQdeCaCLkD1BGVsoELygnWop/xc/Cg9NcYxHYDLWWGzA6SW3RiyYPX4lvwC0sNLXbk01wdgUTh60V6yorpYO4a5hlQuuPzN3XSpTTOehDnGMqf032sOuMjOQAtGQFGYpXF2b9WWMeMVXYMumCyETLXxKmeCRNYsyV5G+C4il+vDc6kJ3yzhvWoo/GxQ3K+GIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hai6cM8u957Ko5Rr10rMpObK3d2MEiEDmqDXAkbH0hQ=;
 b=zm2MvU+d1fKEL56A3YNKUqX8mVhGTZgslxiHQMNn2JJiEFNq+2YCJ8Iaq9xdTdOwf9t56wtpuunh8a0cbHWWik94lHkJyM3wVf0FBND1ZTjIhD3Ihvu9RUR+eZLDYYRxg3U7iCDMlW05HXUbQvyHBVduKMvYMTqGuzUrbHjzrJ8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB3981.namprd04.prod.outlook.com (2603:10b6:805:48::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.15; Fri, 17 Feb 2023 14:21:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%8]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 14:21:06 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 2/2] block/033: add test to cover gendisk leak
Thread-Topic: [PATCH blktests v2 2/2] block/033: add test to cover gendisk
 leak
Thread-Index: AQHZQnCqaJ6P8PuXqE+dO5cekzC4W67TMUMA
Date:   Fri, 17 Feb 2023 14:21:06 +0000
Message-ID: <20230217142106.yisjzahdgfxd3ddz@shindev>
References: <20230217013851.1402864-1-ming.lei@redhat.com>
 <20230217013851.1402864-3-ming.lei@redhat.com>
In-Reply-To: <20230217013851.1402864-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN6PR04MB3981:EE_
x-ms-office365-filtering-correlation-id: b33335a6-4c52-4134-e672-08db10f23565
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wt7eQ29BsynIbyCddhwWvcYkzPXHqlTGitxXGHYMgEz1HrMTmrrucDNka1xyNC39lJ5XZwCE6ifHWJ5DSsR5GcIvhAUdsdQiVdeyMFMnuQ4jao3YN7BWudBRTLLcDGj6Kjb9GORsrMMpBnTLftmVRBT8bB6949aftb1uC83zpZIxnedW54DNCfu2Ni0Mpkk6vQCl7JKmk1fg+sy5onna0XuBQrAiAYcs0edrkvsrvw3rqYgQQuejQ7qGu7horKo8TUtJQnrnE8JKKJy4rWdXJagnl8EJG2Rbbm2N104aEWqLECTkZgbYk/V7eQ16v4ktcX20oIguVLPtNN5IwYpRxRFwCPpXKUKwgAeIQ3aeIWNWxNhhwQftGhN0bKWFIW1pqHW/13ly4GgyYqv3bfRba+JVP/o5vl72e2l3WrmT6j2T1RiUYrmxh2k0JuKL+6Oy/JCzEK+5pkwzd+rj+LKahCBoG5Dq2RREDoota4xCTBm/SQ+wZK1N+hYy3i1E7Wd2P6icUn1atB0RHgtwbaLDfMwooCwtBTC7g5krvwTU4AGIeKW9ePKHBHI4z3Nm0qc983Lo9E9OuGEL7dLnFF3K8bywPHGgr8NRF7RK1bHPBItDeLLOFxc5Cd1k0cWhto/qCK7YAySeUG1gvy6a+oYSYRf7+HcO0jYHpWl+xfIZSosvaDdFsW5qNPoHHYB80TsVOvN6jaz/qIeRZGwC80hPaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199018)(38070700005)(86362001)(316002)(6486002)(478600001)(33716001)(83380400001)(71200400001)(26005)(6512007)(186003)(1076003)(6506007)(9686003)(122000001)(82960400001)(2906002)(38100700002)(5660300002)(8936002)(44832011)(41300700001)(8676002)(4326008)(6916009)(91956017)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MZu2S/7waRWc/Ix2wVwhuaOQe/845+VTsCrPHYGXUOH3Hy6LLPvJmpcibInQ?=
 =?us-ascii?Q?iz/3/1Ta/asW65jPeeDs75PJIRJOh65bEBXdVMQmxAZgBzy40wMsDz/9esgE?=
 =?us-ascii?Q?6tDWfg8Eg2VzycKO8mjxDN8H7cdSQPJxr9KxYT8iHXB/nHJksbHUONRV0LGu?=
 =?us-ascii?Q?Y5+zJY/gtbQ5InFqP0JptDJlokD+v1d4j+SRtibNDGomAKxPYh8DDuv82Ja1?=
 =?us-ascii?Q?jFgzWUW0S2NPaysTm9zBL4yqYB0bz+ahpf675VkPtnLNl3iiwPd5wmLjMw+6?=
 =?us-ascii?Q?myyx71jL/JD8t7v8lT7BKsBUu4KG6YII6K2CpkyH1wDsA+CIogmuNwX5yx/x?=
 =?us-ascii?Q?qo5gZ9rGjlbNBFEW4DCuzUMf9n0CptxowEkyU2GL685fpleYqlpcXdUdX1Gl?=
 =?us-ascii?Q?TWwftHce1xPAx4bde5QJ8fB9nIdMyrpXP/yDs1wzrPll9qIQNGg5Ratz0iLA?=
 =?us-ascii?Q?orcTXmdikCXN8zzzc4HheSiI9ekxQA2ljWjBV2Mpmaii2zHG5tXfcdCvzUgP?=
 =?us-ascii?Q?N/ZHpDc74KVsZjD7HxOCteKM6lMLL+JtPXZh6f6DcbE8L3DBHXt2syG2SUcQ?=
 =?us-ascii?Q?GS31ZQXUf6VSIqGkbbS+BdWhDp5NTk5NxqhOSyio3lseC+cD29QCcrI78r4y?=
 =?us-ascii?Q?gZfQb7qs+cqsVaIGYDKOcLioTxaWxy2bmHMS2RaNcVMmjZz+lGmPzTnOzW7g?=
 =?us-ascii?Q?e0Cc4VO7i6elCdWzhmGLrJC4UKPUsUPuUuaQLSYSkj/pFp5Zx/uArSvgiawD?=
 =?us-ascii?Q?QMb2YiqSn7g9O07hVcUMbamDBJg4Z9yH5Bb2NNEK8UFWiI9r5/Gjel8B0h5y?=
 =?us-ascii?Q?BtwCfS6B5TL9kT6DDoZULj7A4oCD+DS0y2JJ+SMLPAA9DraieXyf81Q1mD/8?=
 =?us-ascii?Q?o1J1AlTMoezjFxm2wraSuabSUDCWxsLOFX3ngfeZmvq3AdduZp2KxdiH3UVm?=
 =?us-ascii?Q?awthDkkLJRcrsstRvdhIjY7e4GPjGrDWil1TGe9uYKv1Ig4GriVQQfGOVHrv?=
 =?us-ascii?Q?9Zx9m25IwciqqZ3+E1BjsW8e/WnkII2yrZtn95SiAJ5+hQvHi3f/JfRMVhzg?=
 =?us-ascii?Q?wWGauGLc7Jbe91heHqo5sBHKJbIPyvoFfR/fX0b5i0HA2RNkk84Uo1qikpse?=
 =?us-ascii?Q?J96jhTtF349uiU1ys6qw1P1G8U2wpfKmIc0DfAuKgSCr/lx3DfiNUpj8UHYv?=
 =?us-ascii?Q?Nn2bJ1cqp9fSjoIHFXkW+zvufAjlzfVlD31yEesWDQE1F0uvuX+U2Xdcn0qG?=
 =?us-ascii?Q?7BDNlqtTwUc5E+N067afzCJjGIdlI+u+/FgomcA/Z70ZCYbLy2pIvwkgxgzc?=
 =?us-ascii?Q?Z6QQr4XxaQl9jopSky0SXTdaL2ophxaEdQhTaqRqY4qaSkyQFd3xG4cd0qma?=
 =?us-ascii?Q?HBFVAfiiU0T4Nk+LJuEXIOJGh1ADMUZgiNGQOfleNVhgMtd9Lkv32ogIdRIh?=
 =?us-ascii?Q?DKQIpiIWVH/pl852ntSbgFLky1sguTVkAp2HXuxPDBb98hbpOxvqvhVuWrVp?=
 =?us-ascii?Q?AOvSFaT4gTIE2a61O7G7Z03TsaFHs3uGrwNQQ/KgllB3J5SWDxhoTzFfP+mx?=
 =?us-ascii?Q?eFlpygZBHdKGuH0WHIg0WsTiAlfKdUZZM9PHjkYIeb7bEm6Pls6Q5dj5U4oU?=
 =?us-ascii?Q?RSSiWbcawWX1/yWTJdVbjg4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <03982AA17A179E49831BF3BE2F23682E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N+6ay57vDLcYRdcn/QelJDwIjyJMJ/O0VJpFKFvsQmsOobpTKfZv9qbqXktTZB0wI8rs9EBgeULOFqi/K++r2fvAS8Mffqm3o+4rJRwXLYTIRwHAwGvjHF4cyST/ObKdsFiBGtL/y5uFrG2EsSb8aA0cXP5/GI+1KjOrIc7gAyvEpBKkRKgtuvJUIStYRwCnfBRa2Ppndo0RcSRwatAp8QHtSl0nF2nPvFAqiuWjpmiWPMH60V8/mC2ApwnxIPWWiC1eDOBTAsZGYWUotrB19DSMagVmgnQmV3Bd9Tlm2KLB0g2eLSDdKNMgWTELSttL1vDdrRBpUwon5HBTmegKXkw3D6694F+bqPfCnwRkb51+aRXmbliRDFxbWOmBeijBgbiv6u3hSp7m+UMIy6oi7bmsKGEZ4iFYhGBCn6s6z56t48sEr0GBlYZYxKO2PPpx535KiP1RFy8jqjKBe7aM0JT5e9nyUx/xq7AKvZNzGo/PXpmvkLpeHbL097wQfxtXSj9Ua0WErkAFjsBgTSNlZ8ZGL7eKDxiC9QQzeYk6V+3Da3WrTydHg13vGvJBsPH/O2H4so7DKex8AkS8t7BSxwSJV9veUityuzFtg/BuZAMEF7zL9RhvaiGR8sN2Fjsgm68S1oFmwWgPfHI13O6Fqk2LL8AFYf+qByqMFITK2CDUweYa8SIE2q9nn174jLwqLBrPYaVYvAWP1Ht2ihXxijN4ZPeQNhUr/JEoewFMA7dUnryHdx9iNeMD+IjP1EgB5hK/qrVpXRyKTkeJCf5k0cdwsGeWgpu2ghTF0RSKXuuj68mRxZoGpMtx8AF5DdeE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33335a6-4c52-4134-e672-08db10f23565
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 14:21:06.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcaEP2QacTKCn4itUATA48C3dT7l1EmetybLzybTqzJKfFycRmqWn94pvhBaFRFF/FkG7p+w0yHzEC0Nu4UDXJKRvdGKhK7U7FStXGdneCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3981
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 17, 2023 / 09:38, Ming Lei wrote:
> So far only sync ublk removal is supported, and the device's
> last reference is dropped in gendisk's ->free_disk(), so it
> can be used to test gendisk leak issue.
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  common/ublk         | 34 ++++++++++++++++++++++++++++++++++
>  tests/block/033     | 40 ++++++++++++++++++++++++++++++++++++++++
>  tests/block/033.out |  2 ++
>  3 files changed, 76 insertions(+)
>  create mode 100644 common/ublk
>  create mode 100755 tests/block/033
>  create mode 100644 tests/block/033.out
>=20
> diff --git a/common/ublk b/common/ublk
> new file mode 100644
> index 0000000..a7b442a
> --- /dev/null
> +++ b/common/ublk
> @@ -0,0 +1,34 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ming Lei
> +#
> +# ublk_drv helper functions.
> +
> +. common/shellcheck
> +
> +_have_ublk() {
> +	_have_driver ublk_drv
> +	_have_src_program ublk/miniublk
> +}
> +
> +_remove_ublk_devices() {
> +	src/ublk/miniublk del -a
> +}
> +
> +_init_ublk() {
> +	_remove_ublk_devices
> +
> +	if ! modprobe -r ublk_drv || ! modprobe ublk_drv; then

When ublk_drv is built as a built-in module, modprobe -r fails and prints o=
ut an
error. I suggest to modify the line above as follows:

	modprobe -rq ublk_drv
	if ! modprobe ublk_drv; then

With this, I confirmed that the test case can be run with built-in ublk_drv=
.
I suggest to remove the word "modular" in the message below.

> +		SKIP_REASONS+=3D("requires modular ublk_drv")
> +		return 1
> +	fi
> +
> +	udevadm settle
> +	return 0
> +}
> +
> +_exit_ublk() {
> +	_remove_ublk_devices
> +	udevadm settle
> +	modprobe -r -q ublk_drv
> +}
> diff --git a/tests/block/033 b/tests/block/033
> new file mode 100755
> index 0000000..eaba599
> --- /dev/null
> +++ b/tests/block/033
> @@ -0,0 +1,40 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ming Lei
> +#
> +# Test if gendisk is leaked, and regression in the following commit
> +# c43332fe028c ("blk-cgroup: delay calling blkcg_exit_disk until disk_re=
lease")
> +# can be covered
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION=3D"add & delete ublk device and test if gendisk is leaked"
> +QUICK=3D1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/ublk/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 --quiet > /dev/null 2>&1
> +	if ! ${ublk_prog} list -n 0 > /dev/null 2>&1; then
> +		echo "fail to list dev"
> +	fi

When I repeated to run this test case, I often observed failure. The dd bel=
ow
reported an error: "failed to open '/dev/ublkb0': No such file or directory=
". I
added "udevadm settle" here, then the failure disappeared.

> +	if ! dd if=3D/dev/ublkb0 iflag=3Ddirect of=3D/dev/null bs=3D1M count=3D=
512 > /dev/null 2>&1; then
> +		echo "fail io"
> +	fi
> +	${ublk_prog} del -n 0 > /dev/null 2>&1

The outputs of ${ublk_prog} and dd are all redirected to /dev/null, so it w=
as a
bit difficult for me to debug the error. I suggest to redirect and append t=
o
"$FULL" instead.

> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/033.out b/tests/block/033.out
> new file mode 100644
> index 0000000..067846a
> --- /dev/null
> +++ b/tests/block/033.out
> @@ -0,0 +1,2 @@
> +Running block/033
> +Test complete
> --=20
> 2.31.1
>=20

--=20
Shin'ichiro Kawasaki=
