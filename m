Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EABDC433ED
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 00:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC57B61057
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 00:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhDAAsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 20:48:18 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38557 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhDAAsO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 20:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617238094; x=1648774094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2sAD5H6RPKcZOMJAV0qv9GFAo8V1xr+GP4Z67+yUFh4=;
  b=GIs4gLk8q6lFI/BXQtAZpx6g9hUFSkBXMo4k3CuA+NocOcbyHPf261NN
   ERuhEpmz3DPwMjP2NHpSedw3mVT6YLrwzGtXBNQBGZIHuX3BhC/AWJUmV
   MDftThgXHjdpuiwRnnD5U4/6ZEcdogZ1FtaLCJkpUyekXjUN3hOb9hjJH
   lVpEAeCYmenV1ZuHzQtfb0A+7hFFvuxTEJ9JUL/Sqws0LtyUjhVlVQjQN
   pd/0kbIIk+zsT6t8rzWhWBJGSaRBbczzFfNsIVi/BL6M6xVNMFmi1dIoR
   d6Czm7jQUulus/SG1kLys+C2b7g3ol8YTI28Ap5Mi41QvBmypE/TOTwVG
   A==;
IronPort-SDR: rPhyVj2TBXXYivZ4+eAz8G47Oj0l10d+lYQ19wCpewo8HmlI5M390CFoJp17FUf3x/4LtyNxWI
 D41wt98RBXefnkQGM28QvvgeS0G0HBwMDCFOyUZQZAbrcARATMZz1lwo0AlUi3yyOpb1DuoojR
 QHigBJqh4lBLJckVqAlleUTbkQWkQdz4XZUagIHcjNxMH78eEFJ5nG7tuC3lWiy3piR4IvnsWZ
 k3+HYHGt5rcVw9Yfln3R9r7ZOfkn3d0U7ouCejgbt/W3wnXuKETZGE4aalYjCKmP6HHMjkXic4
 M8s=
X-IronPort-AV: E=Sophos;i="5.81,295,1610380800"; 
   d="scan'208";a="163506554"
Received: from mail-dm6nam08lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 08:48:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiQh0bBnR8WARDntZjYQnPZef8coIAfsPsyt9YMP5ggIC/BLU2onNejefiWGen9SwQpzNv4lf/z5iu0Fi/0NFPv+LiXQ5W+2bl8vwdltC8iB1dIKHRw+DhBM720C52vEUPRfewPjFHkA/2wQ+LR/8X5LxGUeOgDznIZA3uCP7os4c10oZZce/LSV0oGW8UEy9Nj0ErqB0y+yxtaIwzh8xiYBDs6AH9MXEVeZU7AS2hohxemYHSfi1BDQAdSYDKzapbYj+R0XBZVEOKb63Q0Ob7oDPHUjeGktYeqd/ZcuhWqAhTkAAJdzm22FfRvyPGVCaz8keFh7/DGU2pFL4sDHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHN3sjiKQm94wj49bgxx8uvcPrqy0qiJg2IJG1ccb+U=;
 b=Qrl8jkjsfIWuMST41mABXiWt0Ujj5yqlIDwy4QfNsgqd17V4GB7fMAhhTFErE2WN+mOk0axuaJamLIeWt+GMmGb0d3mS3l7EWO3VJlipA8Xtk6x5v4C+z3Z9zowMQ5Alv1bPWLrzKhsIG3z+TBJlZt8rHEGikyh2Wh0AQVfR8MGF43AsgJA3+M5flNLUu2PZ+P3p39VlG4Jwdl1D2gU0r4a1FmrhT6Zx7YsH+AznIkVQtcZ3gLWo82zGvNSTyskBMy0uoEEvN+/dv3dy3/3r4o4aGP5rG1s04n9qXlmKhN3V/llr9MJnWh6xD+iS4yYaG4uU9jiYY8SO3nijVsQCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHN3sjiKQm94wj49bgxx8uvcPrqy0qiJg2IJG1ccb+U=;
 b=YcX+Fn+T5CRy8ImT++wDs6KOy3VgYDM//CRGuAvomdxu3Oemxqjbo9C+/MFuM8UVCF+ive8662w7KvRU/hxelvjfOVB7yiAEAzj0Q71k9LNNr+5YpMg3ZdnWFfZKcVl4WYDySTC1QYYOkgAILUupw/prHOm35VZ6tGK9J/VEoz0=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB5606.namprd04.prod.outlook.com (2603:10b6:a03:10a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 1 Apr
 2021 00:48:12 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972%7]) with mapi id 15.20.3890.041; Thu, 1 Apr 2021
 00:48:12 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 0/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
Thread-Topic: [PATCH v4 0/3] blk-mq: Fix a race between iterating over
 requests and freeing requests
Thread-Index: AQHXJD+FwISeQzOXXkKLhcKPXN0FHqqe2OKA
Date:   Thu, 1 Apr 2021 00:48:12 +0000
Message-ID: <20210401004811.6xcuca2kpjx75ois@shindev.dhcp.fujisawa.hgst.com>
References: <20210329020028.18241-1-bvanassche@acm.org>
In-Reply-To: <20210329020028.18241-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 591d0018-c16e-49b2-42f9-08d8f4a7d3fa
x-ms-traffictypediagnostic: BYAPR04MB5606:
x-microsoft-antispam-prvs: <BYAPR04MB560663FEECF0E63626003DA0ED7B9@BYAPR04MB5606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZmigAj3etwjEU+3lYEJR1LCzsuF9m2KvLyVHZ37lcexvpW/j8EZeNu4d5Ox6BRd1j6rkk+UT1nFVbxWjy9w81TuVruPAhr3OgvDLM7ERbMvVxbEC/iDzthLzC/u5iJWdt5Uot7Jc2yzgEEESwrvgQMbzv2vl/fk21lNs2PissQXOMSR5Yy03FzN6z+TLuVGjdYs/v7WXV55lnfOQKFkY8m/ZgMSULyL16z50O+3lCCTvP1Qy0/K9nFTz9ZyTcv5vhrMFMYH8NSnLPnGBdSU72y2NqA78pzmahpmWaNSc+6ry6ibXth0ZVBpem46vXgkCpCVIJ9ojsZ1tenOg51HdqfPb1xoRUAym5467UvK8F18GdBxWi24G5ZVB2i0Z674f80+7uCcJLtt3lSNDxoLU8FFJwCmNwoOvYbuIwegnJejr9bIpqlV2p9FF1cmTo8bUirGwRlBl7wbuPT0bjODod0MMol2vEZS/DFa566nsmhQW9DPMXWgijEZjxFvqVqR/bx5qFWeDM64dBxKuIGrvfslyUqxb6POAYMoAC+v7739sbX5y/4BY+0UdJf6u7XRMjjSvpOl4b1EwzEA5wa2QuVniVApHPXCeM128AqhPRdsAwSgtI25pJrJUJGfQWuIV/tQ7RVuptnQFS8yjDATBhmZApV+rv3U6j+ewdLhZuY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(186003)(83380400001)(6486002)(8936002)(38100700001)(76116006)(66446008)(66946007)(91956017)(6512007)(64756008)(478600001)(66556008)(5660300002)(9686003)(2906002)(54906003)(6916009)(71200400001)(4326008)(44832011)(86362001)(26005)(316002)(8676002)(6506007)(1076003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?spzj0WLN7jApt5g57mn9abSQs+egDyOY0EvKUhJ5B5CHpdcy/hbOfskCCPig?=
 =?us-ascii?Q?Ia6G2C8pTcKVZemvaA6ziXD6NaCbzOzVJQ8U+kF2hS21Pb9cxX8XeuqfgU/m?=
 =?us-ascii?Q?GFJfnV5Y3VuVwOnZZW089hdTWix93dDAuuGooTN/8iD52nEKRl078YEZen0X?=
 =?us-ascii?Q?nkYwkqV6j4E/iUAyHPUAWkqNFSe3yeBZtr4ZE+TYRkvTIjuK42eFeGE1b99G?=
 =?us-ascii?Q?IZ+Wj8HXbaesk64nNt/EO50GunHMeVbEXqu73C+/x94vrZkmJAOTvEd0Svd5?=
 =?us-ascii?Q?KF9AB01HTIKuqMFYbjjc1AJoO4um5sEfEouG5t6EHy/f2P7MuQtk+2H5WYhD?=
 =?us-ascii?Q?AC6Miw4EQIfqFNI7T8MGqYnJcZV8k63ArCV+QHfh9zDJOzpAnJ/a09R5FSVi?=
 =?us-ascii?Q?YrvNeBO6+83Gp7IhDR8maL1TjBWD2GecEG3eH+/vD0SknII0FEandZQgbWjo?=
 =?us-ascii?Q?xdjwfSR+npa0aA31Jn6g87ilHeKhg6Lx1Pk/XUvmkwnOUBrgy3N8bbJjhVlh?=
 =?us-ascii?Q?Vs+xenVOOcP83juB+PCesUValRytTHkLq0xQP9kl06GyS1NM00OUgsJRSMPM?=
 =?us-ascii?Q?LfYNmYjuAXMSNYZTfwlb8QxM5K8OeuTmeRHXkC2/hmTUCLlAP42H/UJEhofb?=
 =?us-ascii?Q?3fL3Qv3P2Dm8nAT7gpSAv5F5w8a+tQQ1ADkHzqMYItXwDAR/5VTG9PJyqFHI?=
 =?us-ascii?Q?8amH34UBRwOuhQMY80QBDq63s/Vf8uXzX2u+ZqFIlaTdT6w3lKmnuNKuuShC?=
 =?us-ascii?Q?XmkHvWuGX89wBb4V58WwE9TgvJiHbAcowHsYnuDgHojI1pYQn6f6QmAxfLpq?=
 =?us-ascii?Q?4688B+AwgDGrSvHGkAbwXyEpYUGeU6MnStcEaHDfwSXduGEmNPKNAj4xyl6n?=
 =?us-ascii?Q?g4S60GHmwaXMX+2jSHGipiC8YdfKbpf0DGCtuFGE1z59hQM6u5fRMnsEupPq?=
 =?us-ascii?Q?koZzGztlWurhd2NBCm2NyQXBcWqSK7jCcgzv+pPDeIydBVwoW8/1rJeeGJDO?=
 =?us-ascii?Q?GhhHzVwC0+4bg0AeMjUQlDvt2+A0qnKKb7tOWmdPtWbJMMCl4HbbvMj9AG+F?=
 =?us-ascii?Q?8AHl+20KK/5kiLGUde2dvtpVK+ZeKlIQrZ6fk+28Eazl517P9bi6CGJRiWSh?=
 =?us-ascii?Q?rYJNlm1LbNbbJKEI44cm/fovGaXPZliXvRELOxizOc4N96Lh1MgQyl/zLSB3?=
 =?us-ascii?Q?aQr7PuVbzn/SpaAKAZnuHTULfgGnNuFnbajQKm8tSwCE6POnvAzg7F3WfNlV?=
 =?us-ascii?Q?j5NeB2+UgQThg8kC5DPw27F7ViJ04c2woByUYa0Ui2JykpYc6KFrFYxEJHqV?=
 =?us-ascii?Q?T3vbxi9Cxpnoxg20Ajh2CptIxQBeAD5csmfae/MEQYOVGw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2023C7C8EB53454594865266FBA77223@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591d0018-c16e-49b2-42f9-08d8f4a7d3fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 00:48:12.4475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOR34aIP8yHKqiFG8ihhcFOgKk3ro/VtxRarhNWLKfM05oKTiXy4qnZ9qMBY/UMlS8FWUYtshjtLI4mRCUd5LtnZ/KSOrXo6uVYXsuNlS44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5606
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 29, 2021 / 02:00, Bart Van Assche wrote:
> Hi Jens,
>=20
> This patch series fixes the race between iterating over requests and
> freeing requests that has been reported by multiple different users over
> the past two years. Please consider this patch series for kernel v5.13.

I suggest to pick this up for v5.12. The blktests block/005 test case alway=
s
fails with the use-after-free message, when it is run with KASAN enabled ke=
rnel
v5.12-rcX and HDDs behind SAS HBA (Broadcom 9400 in my environment).

I confirmed that this series fixes the problem. Also, no regression was obs=
erved
with my test set. So, for the whole series,

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki

>=20
> Thank you,
>=20
> Bart.
>=20
> Changes between v3 and v4:
> - Fixed support for tag sets shared across hardware queues.
> - Renamed blk_mq_wait_for_tag_readers() into blk_mq_wait_for_tag_iter().
> - Removed the fourth argument of blk_mq_queue_tag_busy_iter() again.
>=20
> Changes between v2 and v3:
> - Converted the single v2 patch into a series of three patches.
> - Switched from SRCU to a combination of RCU and semaphores.
>=20
> Changes between v1 and v2:
> - Reformatted patch description.
> - Added Tested-by/Reviewed-by tags.
> - Changed srcu_barrier() calls into synchronize_srcu() calls.
>=20
> Bart Van Assche (3):
>   blk-mq: Move the elevator_exit() definition
>   blk-mq: Introduce atomic variants of the tag iteration functions
>   blk-mq: Fix a race between iterating over requests and freeing
>     requests
>=20
>  block/blk-core.c          | 34 ++++++++++++++++-
>  block/blk-mq-tag.c        | 79 ++++++++++++++++++++++++++++++++++-----
>  block/blk-mq-tag.h        |  6 ++-
>  block/blk-mq.c            | 23 +++++++++---
>  block/blk-mq.h            |  1 +
>  block/blk.h               | 11 +-----
>  block/elevator.c          |  9 +++++
>  drivers/scsi/hosts.c      | 16 ++++----
>  drivers/scsi/ufs/ufshcd.c |  4 +-
>  include/linux/blk-mq.h    |  2 +
>  10 files changed, 149 insertions(+), 36 deletions(-)
> =
