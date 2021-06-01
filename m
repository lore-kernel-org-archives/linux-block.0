Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F3C4708F
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39380613BC
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 22:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhFAW6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Jun 2021 18:58:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54631 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAW6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Jun 2021 18:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622588233; x=1654124233;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PZ4LT7ipAZyUxc4tWK6ES7ns00jYM7jJYN9dgKNmhwU=;
  b=KGiAr6SIeKz4eV4kD3fA6akpkOFAjEGhr3yu6ig/RzvmFMmAIssNnznS
   A9dX0KosiR6VqQZ7q9TCwqyiEsHWL9l9T9usI4FbJ62nhvZNZMgafpb6V
   jAgIYURrSF9xJgCUX+Via5AA743HGZpnIjhDPVOghRk6ElCmI0ZoDJ9cr
   dQgIr1NQNqj8ZWbJoGMh7kDE/klgidOGAl9/yBc4Zq0NUth1SZ54aDtPm
   cWYeLNrQka8Kf6gRxsbbK3fzaenslv7a6N6tzLp4HhO/U9bLMbN3PT8mR
   qkafPq6keelZcIzafebvHoN2/ZZ0Sf9C0fBIOq2cuGcyTtsElQQUe8GC4
   Q==;
IronPort-SDR: 3Sk7pd7BYa3+vlOYX2wdzww/CD3u5KnfiKsyOn56zYpP6pweDPYt1M1SFBQoTIvhROgoZtIIb0
 8ZD3t/CZNCp1VMNuBboNBCZhPfdv0KIckxFOU+gOiV00NEZMhrBkV6qmrEKiC6xE/J2jO60O3E
 6Y1tSIaMun3l/B9SFgC+jebiKWkhFNUpfSSoCKPt+tZoukvGL1GHXDjIV32NxTOPkWRj7SIouv
 TXEYnG+w9WEW8lQpDfT1K/+IfNT5cb5v23xTrgjCW39NYaEMKDvYSxerzpuSCP3m1ygz/Q5JVV
 AXQ=
X-IronPort-AV: E=Sophos;i="5.83,241,1616428800"; 
   d="scan'208";a="274211773"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 06:57:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2pDd6h918LQXVlK32n82oa6UNm9M9fAcupJY3JmVhFxnbkCiRjmhDsfUSX9UYIyzpXbCl7rDy4wz7vQZnLQCr8MlcX1zwAqJY6R026TYh6O0RvZ0taUdchNSzrD0qWfMYfEKodbHPjkkoiQbWRkBOCrq5+TtLDhC/b4SRnfpMLrRxxzv3kkDo7WlSA1noUi1w5qqpdh7gVZWLb3UQ1m1K8lXvMbRGCUWwDgGYSyStM5Lk0A7NY9u3y9MEzJ1DRUPmx+rM3R+QXhrJt+HcWH01crs4pMedjDu3ncjmE/PxyCfUTYhwdQeGOAnMenQ3w+b0GdlgqlISmngnPy9nC3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiNDCf8iF1DC2VujOVlBYc5WEMn8HGQ48LlDwO15V4M=;
 b=GgOslgnjB2v14Ty/cQD2MjYVNITXP+XGuUk4at/yj3IjGow4F8V9rbYoy3BiT7yP03UmZre9E3Aym7nCqF7XILHOkFdtuO5SQ4bMq+edCGyMYmwRTXPToBeSPQkWweJtmASeRBqUjL5iCw8CJQtaPS4bubySnVOE6+xEhRXrBAJ572C/8A/y/pfBTyNgtwiL0Z0qYlQPi18s9Uxze1siuvdehN9XADRfJvgGVpWzffz6/rtoNwAG7kAf11PgzEO2/oyn2+8FCYeIkRBgkJ+XLSLCWNHNOYsmG2RqgsFyzbLSEYwBeJiw1W6HGa3kj0OkphrdYn2GDkO3rb2YDl3YEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiNDCf8iF1DC2VujOVlBYc5WEMn8HGQ48LlDwO15V4M=;
 b=M/w/2iQAGOdL8jZA6inHsjiKysV1BOA2YxM0c8WW53PkFtnkSho7JtKsGx1UInzf8zMQPycppXXMRFnxKMlV8JzCO0yVCDELlnV9YTnox9YtlZ2X/87UV4clHxVB8QI9rkvpe+v190wetCI6HCC+M6glpPkwvCbkTOaPH5iCNYo=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4826.namprd04.prod.outlook.com (2603:10b6:5:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 22:57:03 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 22:57:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5 00/11] dm: Improve zoned block device support
Thread-Topic: [PATCH v5 00/11] dm: Improve zoned block device support
Thread-Index: AQHXUaxyAuyK4c4Z+0yqEP2QqnaCJA==
Date:   Tue, 1 Jun 2021 22:57:03 +0000
Message-ID: <DM6PR04MB708146E418BF65FC2F7847E3E73E9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d7b:9386:76d5:60d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c0f75cd-f9b2-4b95-9587-08d92550925f
x-ms-traffictypediagnostic: DM6PR04MB4826:
x-microsoft-antispam-prvs: <DM6PR04MB48263B9C1729C5600F71F622E73E9@DM6PR04MB4826.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qh6mA7erlg7tVeBdR2B1LyLA5tUJGQb7RpUIHxiZRajK8zPvQK+4hAi5Ggu5cPy4ED+ynD9Cfc4Mp8b3j4tt0/iF2pyfbvonh1/NsNZz1E9E2oYLBWREvQ4R1WiyHzGeeN39BDaFhFVDkZd++fsHwFaCYh204F3cSKL4kZuVnb90JKviWt3FnMnjz3OW0pcLIauTzFH2vCp415EW6GpbSUPusDbMlS4Odpbe9NORKbyx7DbMWROPOgdKG6nNSnK05dd0PEpy++Twd69/bXtsZkTHX7kzcoppNop5jnv6zmwJ47XJ5qhkf4ZWFy0QiI9GpXe5PO+cYtztAgCzPjA9tSxRC5aWZzjLU8fvcq93d5H/JfI1bRHOznwNm/dskjjiWOF+0BX+ZIlyjj1DOnWAj2cD38rvzvyZ05K7lihGLxg54xPHg+tIPPzsBXM7u/usGLLpgcJ8ERPRM7LCNkPbpJR5b3EzEjAaUHFNcBwpAmwCFIRYkuJgIhgLOBSlSfRRXiBcU/RlCwCaHoF+WcGaugD1teyH2bhGmCPmkNAvHtnnUzjR5vrN76OgZgUqE5PTU+oq7XQN3XDZ6vsvbwr3B2v67eS7bhOenyTo7FGsnJE8MA2TmvLjUjFu6tLMKFRY8F05s9T8065MEus90Vv6/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(55016002)(8936002)(53546011)(8676002)(71200400001)(478600001)(66556008)(2906002)(64756008)(9686003)(76116006)(110136005)(66476007)(7696005)(122000001)(66446008)(5660300002)(38100700002)(33656002)(316002)(91956017)(86362001)(52536014)(83380400001)(66946007)(6506007)(186003)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s9gxgBUuxKbh6qpahKDOI87/KpEljevV+WbHeGpRV2ImI5nPUU/HAZkDXqsY?=
 =?us-ascii?Q?ZoJTeVgzz1YnBHM3jlXbRGFwAAU1GMeICpDaf5c8ttJQer0UlM3Mqq9pAcdY?=
 =?us-ascii?Q?/UWgEQ58X8Rz3yv1WlUbU8a951NKcTJq4UwOzIxbOBtIFaaFpkszA3kXRftm?=
 =?us-ascii?Q?HSVHNcdwE4t4wuBHfHo1InN3ExP9BUFChxJIk0cljIclj7163xgpK8izKnva?=
 =?us-ascii?Q?Y4th7ehWreTWfJ9RjiNErMm1HlAwT2ga5yCtqXOKP7M1Xokn7ADJAuWN6wJf?=
 =?us-ascii?Q?zZfVXJ7ZZkrtGZ6r9KiPxOp1suMpFAMO/q2WFNcu/mDY6ST8ougpeY8+SoCd?=
 =?us-ascii?Q?zSlhAQdxOvBUSddq+FkYJ4+x9Qfgms+F0rZhE2tT+lKHPRIEATiTzOPGZprL?=
 =?us-ascii?Q?j4KMuGnuWScbpglCe8d2fmMtTFjhdYxW5ouDXNmFEaoQeoDocgxI03KGkgvo?=
 =?us-ascii?Q?bLaRZjeMna9ge+CWYVFqguAg27+umr4+l/ithehPL2ADjWdOQdUETK90TFOF?=
 =?us-ascii?Q?chqOWC1QTyOdxHJ6ny6Wzzgmq7XeajcHamc/9m8JG4ksBzwO06YvPWf010l5?=
 =?us-ascii?Q?lV5VUHV/k06FyKGHlRoFFF6ZdADRLtK204L15NFG1gLZ/KoRhrQuYZOxMWBn?=
 =?us-ascii?Q?rt4M7REV2S4sVAbZS4xOBxUftl5ZZnlxl+vH//3LxWXcC676pSVIc/NLgKS0?=
 =?us-ascii?Q?wjktXFkRIya5NRXXeD4xEJy/Og0sM+5lmj+sF2r/Z2xRHoYXvwiiCxCj1BwP?=
 =?us-ascii?Q?PGqi5HHZnO6H3J/reKfjoYENt0jfeZvAmMBsYnjS0JFV9a32sOtalLcKLIpM?=
 =?us-ascii?Q?JlS8TrChVPO1E0KUzEUKD6uXLb4LTdpEvqR6wHGO87JH95Hb1ODiH5oGO/SN?=
 =?us-ascii?Q?nlLFM3mE9SoBqKX0rKVICgLaCmVbKWgrvdJoyqqhc7D/jGFlmG5AfdJdEgIA?=
 =?us-ascii?Q?oBZKdYyzlniZDurBBNoanMQVpIR+c3I21a6OJye73etuYFdtBQVyq/Qcgk5s?=
 =?us-ascii?Q?KQWJ8V0qZyNuDlBnZlvGv57OiKuR1Vh9VP+SXuMy4SXLW1rh2R0dUQtoUEO7?=
 =?us-ascii?Q?we3MVotwoyVwHXtTCB+cixTveqxGhPqm4M8OO9guudLWWYoqZ/qyXeUx4GsE?=
 =?us-ascii?Q?dgRCYqloYOlX+5vXkNxyZw2QuVMxdBOO3QIwH+ZKZRUuTDgDx1nb0NxMSaT9?=
 =?us-ascii?Q?FpJYY/T8sbY9ngsH9nKOZikbys9wfvjMAwPVTw4zhSYhrIVu/zALEW4jfFJY?=
 =?us-ascii?Q?rHbsO6+inCXvEEOvKtsy3fNb47JARUuHB/7CukuIty/yIlqRuLnp7pIFSSaB?=
 =?us-ascii?Q?9PaeXOfue2GEeEp4QGp+wOL04uRX5k3eKn4OPbJybdHACgHPjk4auy9S5utE?=
 =?us-ascii?Q?xwWy32DiLj3gaG72z7lD1TWoo17k/CEHXYy33Y02RfI/2ZHPGw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0f75cd-f9b2-4b95-9587-08d92550925f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 22:57:03.1690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxsFi+1eEhsR4hr8jSzOiCQOf6Q7HVs4MLul2PXLbyDQCTE7GuNKQsI8d4lDiNtGCjKiIuBXhFBorRi7GcHSag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4826
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/26 6:25, Damien Le Moal wrote:=0A=
> This series improve device mapper support for zoned block devices and=0A=
> of targets exposing a zoned device.=0A=
=0A=
Mike, Jens,=0A=
=0A=
Any feedback regarding this series ?=0A=
=0A=
> =0A=
> The first patch improve support for user requests to reset all zones of=
=0A=
> the target device. With the fix, such operation behave similarly to=0A=
> physical block devices implementation based on the single zone reset=0A=
> command with the ALL bit set.=0A=
> =0A=
> The following 2 patches are preparatory block layer patches.=0A=
> =0A=
> Patch 4 and 5 are 2 small fixes to DM core zoned block device support.=0A=
> =0A=
> Patch 6 reorganizes DM core code, moving conditionally defined zoned=0A=
> block device code into the new dm-zone.c file. This avoids sprinkly DM=0A=
> with zone related code defined under an #ifdef CONFIG_BLK_DEV_ZONED.=0A=
> =0A=
> Patch 7 improves DM zone report helper functions for target drivers.=0A=
> =0A=
> Patch 8 fixes a potential problem with BIO requeue on zoned target.=0A=
> =0A=
> Finally, patch 9 to 11 implement zone append emulation using regular=0A=
> writes for target drivers that cannot natively support this BIO type.=0A=
> The only target currently needing this emulation is dm-crypt. With this=
=0A=
> change, a zoned dm-crypt device behaves exactly like a regular zoned=0A=
> block device, correctly executing user zone append BIOs.=0A=
> =0A=
> This series passes the following tests:=0A=
> 1) zonefs tests on top of dm-crypt with a zoned nullblk device=0A=
> 2) zonefs tests on top of dm-crypt+dm-linear with an SMR HDD=0A=
> 3) btrfs fstests on top of dm-crypt with zoned nullblk devices.=0A=
> =0A=
> Comments are as always welcome.=0A=
> =0A=
> Changes from v4:=0A=
> * Remove useless extra space in variable initialization in patch 1=0A=
> * Shorten dm_accept_partial_bio() documentation comment in patch 4=0A=
> * Added reviewed-by tags=0A=
> =0A=
> Changes from v3:=0A=
> * Fixed missing variable initialization in=0A=
>   blkdev_zone_reset_all_emulated() in patch 1.=0A=
> * Rebased on rc3=0A=
> * Added reviewed-by tags=0A=
> =0A=
> Changes from v2:=0A=
> * Replace use of spinlock to protect the zone write pointer offset=0A=
>   array in patch 11 with READ_ONCE/WRITE_ONCE as suggested by Hannes.=0A=
> * Added reviewed-by tags=0A=
> =0A=
> Changes from v1:=0A=
> * Use Christoph proposed approach for patch 1 (split reset all=0A=
>   processing into different functions)=0A=
> * Changed helpers introduced in patch 2 to remove the request_queue=0A=
>   argument=0A=
> * Improve patch 3 commit message as suggested by Christoph (explaining=0A=
>   that the flag is a special case that cannot use a REQ_XXX flag)=0A=
> * Changed DMWARN() into DMDEBUG in patch 11 as suggested by Milan=0A=
> * Added reviewed-by tags=0A=
> =0A=
> Damien Le Moal (11):=0A=
>   block: improve handling of all zones reset operation=0A=
>   block: introduce bio zone helpers=0A=
>   block: introduce BIO_ZONE_WRITE_LOCKED bio flag=0A=
>   dm: Fix dm_accept_partial_bio()=0A=
>   dm: cleanup device_area_is_invalid()=0A=
>   dm: move zone related code to dm-zone.c=0A=
>   dm: Introduce dm_report_zones()=0A=
>   dm: Forbid requeue of writes to zones=0A=
>   dm: rearrange core declarations=0A=
>   dm: introduce zone append emulation=0A=
>   dm crypt: Fix zoned block device support=0A=
> =0A=
>  block/blk-zoned.c             | 119 +++++--=0A=
>  drivers/md/Makefile           |   4 +=0A=
>  drivers/md/dm-core.h          |  65 ++++=0A=
>  drivers/md/dm-crypt.c         |  31 +-=0A=
>  drivers/md/dm-flakey.c        |   7 +-=0A=
>  drivers/md/dm-linear.c        |   7 +-=0A=
>  drivers/md/dm-table.c         |  21 +-=0A=
>  drivers/md/dm-zone.c          | 654 ++++++++++++++++++++++++++++++++++=
=0A=
>  drivers/md/dm.c               | 201 +++--------=0A=
>  drivers/md/dm.h               |  30 +-=0A=
>  include/linux/blk_types.h     |   1 +=0A=
>  include/linux/blkdev.h        |  12 +=0A=
>  include/linux/device-mapper.h |   9 +-=0A=
>  13 files changed, 954 insertions(+), 207 deletions(-)=0A=
>  create mode 100644 drivers/md/dm-zone.c=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
