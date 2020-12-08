Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584BDC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 00:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152CA23A04
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 00:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgLHA34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:29:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15943 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgLHA34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 19:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607387394; x=1638923394;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DXUVIo0VRaNSJdkHOBKr2QcRxnbSbqNCndynWPTs804=;
  b=YSdb1YUgC4nkvmEs3+BHwba4uPs7fyS5gn1i2dP69G2mWlnDibiW3pzq
   75t+EjWaH6Gxgbm89PdM0ylOeJmNp4a6Ncl2vif06t5iXZ2yZEND8c5+5
   VmT8Pbnj29D3LApOVkJ28djZD/25mQukl1DK83mAB6F5Nxu+Wkob6lrM1
   pkKVUMYKe39M7q+XY/TYNbwPFpCgO3eXlKyw+bjEpKAKCxoLLyGKhO4hK
   XYgnDJPzs8Gf0TrKhIvgw27Jw2B/C6/8puaMAkYHXqc58dHMGKIGVH5Mz
   Dkaz1sdhPL+YIE7KSwgkUm/zJ8CNCNsvVrdHEe8CsHRclP1O5K2SIk7In
   Q==;
IronPort-SDR: l3DYgz1lJtC0zbUPSWwfri9oiqCQR5tBvOO9rykyu6UDwDJJ6tqu/t68fAKF/UVKU6fOPLo/Pm
 6WGNWqhUHsn9vKwUyE9cdjOGhX9VvFur+IBuCLpgRBubmQN84vkLbTlKXjnVAxBQR5++eMoeDT
 ZVZx+PzzbbcGzU5WnTzeyyAf/Mbv9eOjrqt6CkHiaLTQ1D+MEek8b2B2k9fizN5U7XdUmHPL6t
 +RzmDwcB/ubND+EcMXeiunP3/tKqSw3LoA2Fl4/hKobiVqV9D5u9o7UjOkx5RzCVbm1IA2+etT
 l/I=
X-IronPort-AV: E=Sophos;i="5.78,401,1599494400"; 
   d="scan'208";a="159101525"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2020 08:28:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obbjawd0J+qeiOSHhyoEuaVTR9+Ypx9SwzwoMzX/w3GYAD4rnsHMt0fgJoWelj8TAVjAmhgdDibznFfYCAKUpKgjNR6eWQmmr65YdelQ+FTotpMCDYsbc1Mfeben+bj5/BFGw2B6lggKCp0YYHz6QLJ7OsYwoHqNMO6W3nGXM//EDRNQw9wwoQZ9rFyLzzTBIr1QKYj47Jnhih0BuXDxdCW9359++bfwrz129oFf3xpY+qiRFaVwx2nYkJHYLS73q19t9rRenw5wr7pzLeH6myQz7dT3WF4Qn9HirUfwBSCmVJDNolJW2xhw53T0P8xP9DEoOqv+xJjTz4X5E2vhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfCCoYgoctmtO1/UhKHIPRqSPThwqQ8XqpU/n5L9rQo=;
 b=BvaCFiAuPUqXUHKkSLfkIVMrG0IApBfP+1BQQ+EkBThkS0lLz6iugNt2XbRNW/uTqr/sptw7VQH7VnN4WvGdWklDVUVtngiyfkw+1PAsXlWMQXKcIX5zCw0B/niUhHUZKrmzyEcVin6YyXyc/fG/PWfoP0hHdkU+hwC4Thbd/22UmgA5++gR7dV1uatUTvNV+GAkAovwM0KlI+zLQa8xFjaJdO2KHKOmLwY5BwjeDXEcPvqhdkiz2kc6KvB5lSY+QqprnLe18s2MtVi1H3G5r867QfwBMuKQdu46dtib5HsvpdQl+hER0UWxeKyDUURh9LqZVGi/kDs8pnU3DdkfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfCCoYgoctmtO1/UhKHIPRqSPThwqQ8XqpU/n5L9rQo=;
 b=V3fy1O7Mnku2qw/QvEv0xgvYX4bmepp86e65AyXwCFng8AbNqx+uhdxbXkaI7FyHhh/Jz/r331zVPtl97Ed2MLPFAVtfyE4neRgDq9c2LTku6ZtbjqnCRKdF9xmDgI7C9Dirsj8rV7ImsNQUYW3vy8qXBEH52oqD7geJzIBdLv8=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6757.namprd04.prod.outlook.com (2603:10b6:610:98::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Tue, 8 Dec
 2020 00:28:48 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 00:28:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/9] null_blk fixes, improvements and cleanup
Thread-Topic: [PATCH v4 0/9] null_blk fixes, improvements and cleanup
Thread-Index: AQHWvuCE62oitkQP2EGTL15SsbBFhw==
Date:   Tue, 8 Dec 2020 00:28:48 +0000
Message-ID: <CH2PR04MB65225AA2D38CDA11FCA290CEE7CD0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf3:4043:c21d:e871]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3a4d544-fd43-46a9-0428-08d89b103b0c
x-ms-traffictypediagnostic: CH2PR04MB6757:
x-microsoft-antispam-prvs: <CH2PR04MB67571B67729FEBE7A3CA3EFEE7CD0@CH2PR04MB6757.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:53;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMMx8zksZc157wqbU+EOdl4ezwQIG4/MiYAiFkdVJG7tbIP46f1dNkq16XCydzYikZ5NCYky+wwjUiH/yF01iZqVx/RoMPbL6KyVdhprhyf6KXHvLjtJnxhNw3l+Of9PA7S93a3RxSiKIR20eYAvd693cQkqg8ufWn1rG0HstFMxOCszTXIIPrIqMBHorZj7arZ124T820dz3kJKO2vg7Ot4343p3znS6AS6HdH0MmIT416MkgIkVj/r4i4XLrgjN5ERfWZB9SPkfFUrX/uGwfiw9zKx5/u8KmZFhTAOcyd0skg80tyFqQUPj4rP+dNo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(66446008)(83380400001)(76116006)(66946007)(5660300002)(186003)(66556008)(66476007)(7696005)(52536014)(6506007)(53546011)(64756008)(91956017)(2906002)(478600001)(33656002)(86362001)(316002)(9686003)(55016002)(110136005)(8936002)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AX6MFrjv9fIHZQEYYWhFR+0CQ5ydsdnxdF25g+2vq1Uq0xNDMDcNhAQ7WeKS?=
 =?us-ascii?Q?h4vC8A0fxF25PgkywDWR9luoyAK+HaHCnt4lI5xo9iQLi0BekCFJtgckP/4X?=
 =?us-ascii?Q?z3r7G36CMWM4M/ufouyLiPSlnytkjvfZbdSh+u503YK/E9YK9ck5fi4LpvfD?=
 =?us-ascii?Q?rVtsUsS4rQTOiOU/WGM3nWT2H9SSOkWp8Cr15SGGL+Z99XzUGL+lkdFu/hHf?=
 =?us-ascii?Q?EB6KEkKNMsMADDdOm+71KhVf9ImNggXZ6D06VwmKl7b5ieFwKPDN/w9aDGFI?=
 =?us-ascii?Q?M/79sd85um7fzBEzTk4TnYjFhXV0cxx5Jq0X/jFAGpk3wFQWYS5JAnZwa+fM?=
 =?us-ascii?Q?QZh0FIXy+p3IYFV1ts5RdogbbYbpvJf8zx6OjE0E6jg1250Arwkqcv6AjGC7?=
 =?us-ascii?Q?hmpFAMGSLiPtq9jpkjCQFtYv24Jvw8SBI1iE8Gp+KMinuu7F9l4f5SvKYegV?=
 =?us-ascii?Q?L1BdjZTqNV6KuXVKNEBaU0Nu6RPKPGk5vLyv4lRiHWz7VohE0J3HoGYvcCV1?=
 =?us-ascii?Q?KbyThmeuUcqldr9vI05kdNuj32Msdqzl6GGsWN6ul7QvGNpveLKYnC1SauyT?=
 =?us-ascii?Q?NvLX6S2SvWxEU/aOD/I4t1yM6cVl+vtbiCT5/ewtirY1KBUic7jfYgDpQyUG?=
 =?us-ascii?Q?+GMIfctw55JyBnabDYU5Z0zPqIISkbMTSmZxUgO7ZrXFlajpxzqG0msco1lZ?=
 =?us-ascii?Q?g+goCYEFCBWdBMoxm7IjNeJzE/IwTvZmEhqt9q8OLair+QJku39S83wQxC0S?=
 =?us-ascii?Q?OcoH7slADcImVcIn2dllh9MScMbBYxsKaswVXvnhRT7MvlrUsKpSiH5QQDxT?=
 =?us-ascii?Q?T5GzlMrxWrq/+Xnm0+RuAViXAJwTcpepmJyXx5YcWQgd7q72n8ROBMKulfOc?=
 =?us-ascii?Q?9+zS29IvOCzyo5tNCbo0kyk+BWrtrXDdgBmEx6phqIfkl+1p4U8nHo74fYTr?=
 =?us-ascii?Q?8RYp6aHYwQ0L6sVV8oaM8y79PWHjrVfkvCkyFCPEP2mhyzqBaFi5BYC6x7pw?=
 =?us-ascii?Q?2A0zvR4lCf8GyQh+oA2TFm2VfdqM2ncVztI1tWD+Lj8IQ2JT+m7X4OCZ71yz?=
 =?us-ascii?Q?D35uR+fU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a4d544-fd43-46a9-0428-08d89b103b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 00:28:48.4852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uZ5h+g9lR1H0wv/7KTcRBeFN22YPPU35MSehjknif6z+OGCpsuMGKmk78h6ozTc2doB+Bs7MtBTvluGWBJi4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6757
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/20 10:57, Damien Le Moal wrote:=0A=
> Jens,=0A=
> =0A=
> This series provides fixes and improvements for null_blk.=0A=
> =0A=
> The first two patches are bug fixes which likely should go into 5.10.=0A=
> The first patch fixes a problem with zone initialization when the=0A=
> device capacity is not a multiple of the zone size and the second=0A=
> patch fixes zone append handling.=0A=
> =0A=
> The following patches are improvements and cleanups:=0A=
> * Patch 3 makes sure that the device max_sectors limit is aligned to the=
=0A=
>   block size.=0A=
> * Patch 4 improves zone locking overall, and especially the memory=0A=
>   backing disabled case by introducing a spinlock array to implement a=0A=
>   per zone lock in place of a global lock. With this patch, write=0A=
>   performance remains mostly unchanged, but read performance with a=0A=
>   multi-queue setup more than double from 1.3 MIOPS to 3.3 MIOPS (4K=0A=
>   random reads to zones with fio zonemode=3Dzbd).=0A=
> * Patch 5 improves implicit zone close=0A=
> * Patch 6 and 7 cleanup discard handling code and use that code to free=
=0A=
>   the memory backing a zone that is being reset.=0A=
> * Patch 8 adds the max_sectors configuration option to allow changing=0A=
>   the max_sectors/max_hw_sectors of the device.=0A=
> * Finally, patch 9 moves nullblk into its own directory under=0A=
>   drivers/block/null_blk/=0A=
> =0A=
> Comments are as always welcome.=0A=
=0A=
Jens,=0A=
=0A=
Any problem with this series ?=0A=
=0A=
> =0A=
> Changes from v3:=0A=
> * Use inline function for zone res lock instead of macro as suggested by=
=0A=
>   Christoph.=0A=
> * Added Reviewed-by tags=0A=
> =0A=
> Changes from v2:=0A=
> * Make patch 3 a generic blk-settings fix=0A=
> * Reworked patch 4 zone locking as suggested by Christoph=0A=
> * Small change in patch 6 as suggested by Christoph=0A=
> =0A=
> Changes from v1:=0A=
> * Added patch 2, 3 and 8.=0A=
> * Fix the last patch as suggested by Bart (file names under=0A=
>   driver/block/null_blk/)=0A=
> * Reworded patch 1 commit message to more correctly describe the=0A=
>   problem.=0A=
> =0A=
> Damien Le Moal (9):=0A=
>   null_blk: Fix zone size initialization=0A=
>   null_blk: Fail zone append to conventional zones=0A=
>   block: Align max_hw_sectors to logical blocksize=0A=
>   null_blk: improve zone locking=0A=
>   null_blk: Improve implicit zone close=0A=
>   null_blk: cleanup discard handling=0A=
>   null_blk: discard zones on reset=0A=
>   null_blk: Allow controlling max_hw_sectors limit=0A=
>   null_blk: Move driver into its own directory=0A=
> =0A=
>  block/blk-settings.c                          |  23 +-=0A=
>  drivers/block/Kconfig                         |   8 +-=0A=
>  drivers/block/Makefile                        |   7 +-=0A=
>  drivers/block/null_blk/Kconfig                |  12 +=0A=
>  drivers/block/null_blk/Makefile               |  11 +=0A=
>  .../{null_blk_main.c =3D> null_blk/main.c}      |  63 ++--=0A=
>  drivers/block/{ =3D> null_blk}/null_blk.h       |  32 +-=0A=
>  .../{null_blk_trace.c =3D> null_blk/trace.c}    |   2 +-=0A=
>  .../{null_blk_trace.h =3D> null_blk/trace.h}    |   2 +-=0A=
>  .../{null_blk_zoned.c =3D> null_blk/zoned.c}    | 333 +++++++++++-------=
=0A=
>  10 files changed, 317 insertions(+), 176 deletions(-)=0A=
>  create mode 100644 drivers/block/null_blk/Kconfig=0A=
>  create mode 100644 drivers/block/null_blk/Makefile=0A=
>  rename drivers/block/{null_blk_main.c =3D> null_blk/main.c} (97%)=0A=
>  rename drivers/block/{ =3D> null_blk}/null_blk.h (83%)=0A=
>  rename drivers/block/{null_blk_trace.c =3D> null_blk/trace.c} (93%)=0A=
>  rename drivers/block/{null_blk_trace.h =3D> null_blk/trace.h} (97%)=0A=
>  rename drivers/block/{null_blk_zoned.c =3D> null_blk/zoned.c} (68%)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
