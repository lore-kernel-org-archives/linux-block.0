Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9E3C433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 01:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C50864E10
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 01:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhCABuc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Feb 2021 20:50:32 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19907 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhCABub (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 20:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614563431; x=1646099431;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OfFwKIcZgTzbx2ei539oOAjBfSuCamH1dwB2R/OMnJ8=;
  b=SEr+bcKa4EDBrK1rj7bF6FF12MIZOkJsNzCov/hxq5qmMfzf2xuZqTKy
   lEwwt4C5Vd+KlIPdhXNX3RrVXUPDrbQ6mN8vsxgAhlKlMNPp4ynQ0NEwC
   z4r585NKHfAiHqTVN4vqgAkLmRHh+lo3E1IIJWF3+nDWdfZBnXvt9TP/j
   hKorSgGhZugtaZydUuD9aow9hB7TxW5K9SA/W8ucuxOWjpwkQ8+NBuaiZ
   +50min+KOTCnhAxX2H3t66S91OC3s48MkuINxAwGa0HVkiBWNNKI6qvZG
   nZiUuG81Sb7PAaXgU3qS/+3SdNUcK3CrKuL06Ansy0xxJfUX0E1lAK7YL
   Q==;
IronPort-SDR: 6Me7MjFoFDpetMC+iNt/z3Eu1bH1SMMn+K4XNO8+UuFWALGwBzqQ+GNdyWiftJBOK73C4E3Kvn
 G4IFd6L4BGZFFGLkKiLXqpOcCG/Noh+WTSvLHBXZJXFD4TLp5aEza7HR6Muq8zIBl3nMaAMeiY
 ImYSHlkFn+ETBPyyDPe+OXNYxMtZeNMvt+5NUqqGpMnYhS+pfhJDyOnYPkUUT9n9cjtrow6Cog
 pkWppHswNvP31cJzubSij9hGfTlX1oatktw7ZbT43WuasI/TI1jXoe1DHM8V84/9Gdhi2rVc7v
 sL0=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; 
   d="scan'208";a="161038864"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 09:49:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM+K4tHxqbYFwcwJ2CYxGJ9AxcVMlIe1DoaWQktMgrXJU8tvXTURjCCu1yQniFW58Gn/MSZBf54NQoA/hvlnSQ1ZdcQZ9/qtZb6M2wd688Znq5Wn5HlWUHIqZgm1tJy/A0GkEnzMPUX9C2lYstK/YasSMf5FrK8l0w8UUMtKPAwLB/eaLq7GSzZ3v3i+gmFnOEwIUQ8F60aEBHlJt6XdlYQKe0nzN9bY8AEOtz3jvZJ9NpTx4Hn1RjtGJBXNnXvOrQCBW9Q541QXeTNH88WBLdwhVk+zSCISyXzgo63/yyw13m310GGoMusZh1syTCeoJWQyQ2ra6ZhEWZm4YZdQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7Aousq3fiBRzys7q42FgxxtDUUEMgT5pOGwWcxl+9I=;
 b=OC0cX1qnkcB1WE8pibTuRQOMGN4fscUK9tPMgDMjGbO/tsaNyvc1blaUMZo8ip4xPYYnSn0RQsIjsEShbC1qlQ5bwR87Gnb+XVqbzVXcUjIl9i2gIcBGoU0JCM8wYiW4l87FAW7bEJ6TOqZfA2nGDhp0qEhoKYLVzwBAhPfJKfdMr9UZJkJVoV1gvamPU0qs+ChFYGwFrKJ5wvJE7KjMjiNFFwtZDz2ANm+pPtidpU2GB4wFdsQY0zTHQTzkBkAitjP2aPOY9IVqXA3lIuLr4oxnmsU5d1jORZ7FdzkJmk0UyP5u/tEBWl5qJuz1WOWgaBNVlqYbrrKEt3wwc2N/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7Aousq3fiBRzys7q42FgxxtDUUEMgT5pOGwWcxl+9I=;
 b=mng25whkBo709XSXD6yaiy8p+YvS+/TrqinirTFBTgNx6ys5+Vp9GhZAkR8Nwt0rycXp3m+eT+TmNMbrl60UxzbJ6eNGs87iXRn0MDAIAayeLxDVS4jd16VwBg73wJqLDO9NnD/jZuLhdVeF79onK+DzSm1uokMOgt/x+xHDvHY=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6546.namprd04.prod.outlook.com (2603:10b6:208:1c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 01:49:25 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 01:49:24 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Followup block fixes for this merge window
Thread-Topic: [GIT PULL] Followup block fixes for this merge window
Thread-Index: AQHXDUJ7f+OTeGeKZkOR4Tsefn3Ecw==
Date:   Mon, 1 Mar 2021 01:49:24 +0000
Message-ID: <BL0PR04MB651426DD935C27ABF775B8B9E79A9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <4fb0811b-af58-60db-1c27-ef367876c491@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:347a:bb00:3286:307b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b90832b-1d0b-45ef-4f15-08d8dc543e10
x-ms-traffictypediagnostic: BL0PR04MB6546:
x-microsoft-antispam-prvs: <BL0PR04MB654642D422FEB50A72742A93E79A9@BL0PR04MB6546.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVDEHlFHnIVZH03MBJD4cBFzLhE9sJjBjaCAgmxm4MhYdeT8IakL6zr/Hx0LCgk1t7Insl3i9AuEkKZRcPA1MSWRdGzACPT/wEBi+9MntGUnkxhWjcqk+lfGZaC3ne+EsiGdZNg1Hi+8JngdVJgW+5Ac8ZNnZIX4vpMGmnREN8mDWVXsVtd2xJc5rQw7SOKcp81DDjD7T+rdI0gsQCJhF7XTXC3/lxADP2c+wZmjxB2o32EphEOFrLeqN3G5naeZ184wtQwKDflAVZoA/0s9EQ+OFpScEhpNhLO1rhCePRvmfoO6mdLV0lY8+eA5jdHRSbHXbB6bEbNl0zTizGGzfLxX1cJojo/nBH95HE6DGgXPLsNv51dgrzrGF5BoUj2O/PlP8tYYW+axvZbZ3SG1RaQlnsT1k6/sa74tVnK66fikL8HD1avsUY3/3possnFM9cjRojxuIhdGg+Fv4q8TwGhOSSWKDhmmWF3440Gt9xwbCjP4ASULiBlhF+NbwMvtU88RO+9vCcB/m7tiILJJcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(478600001)(2906002)(86362001)(83380400001)(5660300002)(9686003)(71200400001)(55016002)(316002)(186003)(64756008)(6916009)(4326008)(91956017)(76116006)(8936002)(53546011)(66476007)(66556008)(66446008)(8676002)(66946007)(6506007)(33656002)(7696005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9K0eTmVo9WZ1N6BcOh3GdZpWaOc4PNReSb+YLxql/+uRvRgO7LsIRBIErWAl?=
 =?us-ascii?Q?AmOAO8/PkUG+wL+q9PI67mwkeipyiKlTenqKaORdkJJ/RJyCzOfMXbI9MFAf?=
 =?us-ascii?Q?8ivHfDGOLq6P+Gktm1XXLqqczYOeA+z1GJ+Ojwj6PwIPSOo5lrKANaReWyal?=
 =?us-ascii?Q?g5VUhGHLDusVD3L4nNmieY8YQ5lQY55v4HYkhKDKMyAhezLDl2Yig1ObDAnJ?=
 =?us-ascii?Q?Mb5PQbddpuIGfJSAUqGYgvAxSE/Sqf57jSjwO8m0hejrusR56SvzH3mUS8p5?=
 =?us-ascii?Q?K+YHaugVm90zU60BbKsQP4rxza2jLtIKmXlQkTYjIjDpo6xHhzdWCyuSHxjR?=
 =?us-ascii?Q?EpjUJch24CZ9KCorEXhC7t2CDv3BZ6P7WaxK6egrtw6fm76NI9/80vBwCzSv?=
 =?us-ascii?Q?nx7xfTj4EeSzX2uPQaVHzkaFghU3XCO6hieshT3272rvi87LR21IUAQO9iPx?=
 =?us-ascii?Q?0jdzjHGEBFeJw9puebwACaREHFcPucyOYBXfKhoEsXdVdLoy3BW0vJbkpJR0?=
 =?us-ascii?Q?cRg6gLAdBveF76l+RMm6QZWREi3PcKakmgLC5ov4xTymYxsV82MAAsAlIw78?=
 =?us-ascii?Q?bDxv9EAl29gjH5g2T6Nk6SBdpWBgMxD8XtfUD+8aLgYkwiz0LMm/Gw3smgbK?=
 =?us-ascii?Q?Lg5/T0O08dUCCGs3lxuaJ3OMo2Zpynlrtkq4Bae8fn2rDuK8o5ybZG7smNIP?=
 =?us-ascii?Q?a3gUq/vc67FoD7nJ/l+/fG07iYnBbk7lsTXLzECMMtVIZ5Tgxu99jtWndTb0?=
 =?us-ascii?Q?jyjuIdCc0i55HCXJ/3EOs6ibRUO7/nZifXwCMC4qg+b/hpD4K/uR101E88MZ?=
 =?us-ascii?Q?u4IgvbthaQDJlBy/ndsobFWU9H4a0OV7Is9wwY8bLwtP/V2dzNvt44+WjRHz?=
 =?us-ascii?Q?gA8xuBsr3NsrrVIfwsQtX5kPsg3BpeCsyPrbIf4FgfFNr3Br2BUJX+HlsAoO?=
 =?us-ascii?Q?wdSMSFnq2sc4DR7C2qoe45SmIdhjs6Qn7W9lVYosI9mhQE4gjlGwHfyRt6/5?=
 =?us-ascii?Q?3Ag3DVP1dxuSKBuL6Vgo2aqPrHiv1QfkBceJqoJ5Q6jRBIh9+AEftOE3vnFr?=
 =?us-ascii?Q?8Pnp1JwNoOdS0H0VJZ32cwqlC9WoWTQPpR0PPeNP8PRR+Wotwpcr75NynA6c?=
 =?us-ascii?Q?XDqPtu6wi9ZdiLgE248zITbDCVTID9KatAVLQ0Di5eW1UHkKrmMIOOTzuF3c?=
 =?us-ascii?Q?e2FoHH2jBs9iqi/UMcH5DJGGPaUkHO57pxARxfncIsnoNiK7JSnJo8NydE46?=
 =?us-ascii?Q?Z96g1YXrYHItYSCPsP+6Sqk6NFdi+KQIi874G72Oymc5Bc+yDaTW48h2i1CR?=
 =?us-ascii?Q?uVkErpoQrZjK07Pe7lYqp3c0gt/OjhezaBtAVjvb+NUYpRDn4XhsiEMt47vD?=
 =?us-ascii?Q?cPqDe2dg63ZWy5k1zHvdEVnTEkbJxxG6gHnSDSNdmRM4+3dn7w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b90832b-1d0b-45ef-4f15-08d8dc543e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 01:49:24.8519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3gSCmG70jQhroLYSe7ns9PXCWiQV72RN0MEULIrC1SEpmMo2B0vqC9p0o6L71KpFzfuKkxOnnYQEiEnHXYUVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6546
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/28 4:55, Jens Axboe wrote:=0A=
> Hi Linus,=0A=
> =0A=
> A few stragglers (and one due to me missing it originally), and fixes=0A=
> for changes in this merge window mostly. In particular:=0A=
> =0A=
> - blktrace cleanups (Chaitanya, Greg)=0A=
> =0A=
> - Kill dead blk_pm_* functions (Bart)=0A=
> =0A=
> - Fixes for the bio alloc changes (Christoph)=0A=
> =0A=
> - Fix for the partition changes (Christoph, Ming)=0A=
> =0A=
> - Fix for turning off iopoll with polled IO inflight (Jeffle)=0A=
> =0A=
> - nbd disconnect fix (Josef)=0A=
> =0A=
> - loop fsync error fix (Mauricio)=0A=
> =0A=
> - kyber update depth fix (Yang)=0A=
> =0A=
> - max_sectors alignment fix (Mikulas)=0A=
> =0A=
> - Add bio_max_segs helper (Matthew)=0A=
=0A=
Hi Jens,=0A=
=0A=
I think you forgot to add the patch for reverting commit 0fe37724f8e7 ("blo=
ck:=0A=
fix bd_size_lock use"). Or will that got into another PR ?=0A=
=0A=
Thanks !=0A=
=0A=
> =0A=
> Please pull!=0A=
> =0A=
> =0A=
> The following changes since commit 31caf8b2a847214be856f843e251fc2ed2cd10=
75:=0A=
> =0A=
>   Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/h=
erbert/crypto-2.6 (2021-02-21 17:23:56 -0800)=0A=
> =0A=
> are available in the Git repository at:=0A=
> =0A=
>   git://git.kernel.dk/linux-block.git tags/block-5.12-2021-02-27=0A=
> =0A=
> for you to fetch changes up to 5f7136db82996089cdfb2939c7664b29e9da141d:=
=0A=
> =0A=
>   block: Add bio_max_segs (2021-02-26 15:49:51 -0700)=0A=
> =0A=
> ----------------------------------------------------------------=0A=
> block-5.12-2021-02-27=0A=
> =0A=
> ----------------------------------------------------------------=0A=
> Bart Van Assche (1):=0A=
>       block: Remove unused blk_pm_*() function definitions=0A=
> =0A=
> Chaitanya Kulkarni (6):=0A=
>       block: remove superfluous param in blk_fill_rwbs()=0A=
>       blktrace: add blk_fill_rwbs documentation comment=0A=
>       blktrace: fix blk_rq_issue documentation=0A=
>       blktrace: fix blk_rq_merge documentation=0A=
>       block: get rid of the trace rq insert wrapper=0A=
>       blktrace: fix documentation for blk_fill_rw()=0A=
> =0A=
> Christoph Hellwig (6):=0A=
>       block: don't skip empty device in in disk_uevent=0A=
>       block: reopen the device in blkdev_reread_part=0A=
>       block-crypto-fallback: use a bio_set for splitting bios=0A=
>       block: fix bounce_clone_bio for passthrough bios=0A=
>       block: remove the gfp_mask argument to bounce_clone_bio=0A=
>       block: memory allocations in bounce_clone_bio must not fail=0A=
> =0A=
> Greg Kroah-Hartman (1):=0A=
>       blktrace: remove debugfs file dentries from struct blk_trace=0A=
> =0A=
> Jeffle Xu (1):=0A=
>       block: fix potential IO hang when turning off io_poll=0A=
> =0A=
> Josef Bacik (1):=0A=
>       nbd: handle device refs for DESTROY_ON_DISCONNECT properly=0A=
> =0A=
> Matthew Wilcox (Oracle) (1):=0A=
>       block: Add bio_max_segs=0A=
> =0A=
> Mauricio Faria de Oliveira (1):=0A=
>       loop: fix I/O error on fsync() in detached loop devices=0A=
> =0A=
> Mikulas Patocka (1):=0A=
>       blk-settings: align max_sectors on "logical_block_size" boundary=0A=
> =0A=
> Ming Lei (1):=0A=
>       block: fix logging on capacity change=0A=
> =0A=
> Yang Yang (1):=0A=
>       kyber: introduce kyber_depth_updated()=0A=
> =0A=
>  block/bfq-iosched.c                 |  4 +++-=0A=
>  block/blk-core.c                    |  1 +=0A=
>  block/blk-crypto-fallback.c         | 12 ++++++++++--=0A=
>  block/blk-map.c                     |  4 +---=0A=
>  block/blk-mq-sched.c                |  6 ------=0A=
>  block/blk-mq-sched.h                |  1 -=0A=
>  block/blk-pm.h                      | 38 -------------------------------=
------=0A=
>  block/blk-settings.c                | 12 ++++++++++++=0A=
>  block/blk-sysfs.c                   |  7 +++++--=0A=
>  block/bounce.c                      | 24 +++++++++++------------=0A=
>  block/genhd.c                       |  4 ++--=0A=
>  block/ioctl.c                       | 21 +++++++++++++-------=0A=
>  block/kyber-iosched.c               | 33 ++++++++++++++++---------------=
-=0A=
>  block/mq-deadline.c                 |  4 +++-=0A=
>  drivers/block/loop.c                |  3 +++=0A=
>  drivers/block/nbd.c                 | 32 ++++++++++++++++++-------------=
=0A=
>  drivers/block/xen-blkback/blkback.c |  4 +---=0A=
>  drivers/md/dm-io.c                  |  4 ++--=0A=
>  drivers/md/dm-log-writes.c          | 10 +++++-----=0A=
>  drivers/nvme/target/io-cmd-bdev.c   |  8 ++++----=0A=
>  drivers/nvme/target/passthru.c      |  4 ++--=0A=
>  drivers/target/target_core_iblock.c |  9 +++------=0A=
>  drivers/target/target_core_pscsi.c  |  2 +-=0A=
>  fs/block_dev.c                      | 10 +++++-----=0A=
>  fs/direct-io.c                      |  2 +-=0A=
>  fs/erofs/data.c                     |  4 +---=0A=
>  fs/ext4/readpage.c                  |  3 +--=0A=
>  fs/f2fs/data.c                      |  3 +--=0A=
>  fs/f2fs/node.c                      |  2 +-=0A=
>  fs/iomap/buffered-io.c              |  4 ++--=0A=
>  fs/mpage.c                          |  4 +---=0A=
>  fs/nfs/blocklayout/blocklayout.c    |  6 +++---=0A=
>  fs/xfs/xfs_bio_io.c                 |  2 +-=0A=
>  fs/xfs/xfs_buf.c                    |  4 ++--=0A=
>  include/linux/bio.h                 |  7 ++++++-=0A=
>  include/linux/blkdev.h              |  1 -=0A=
>  include/linux/blktrace_api.h        |  4 +---=0A=
>  include/trace/events/bcache.h       | 10 +++++-----=0A=
>  include/trace/events/block.h        | 20 +++++++++----------=0A=
>  kernel/trace/blktrace.c             | 20 ++++++++++++-------=0A=
>  40 files changed, 173 insertions(+), 180 deletions(-)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
