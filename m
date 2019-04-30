Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C52C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016A321743
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oQSJq0Eh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lMXmn7Yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfD3VkD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:40:03 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58737 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3VkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 17:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556660402; x=1588196402;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sjETgoLQKylcIHL1EGCXtbag39TVJ0JJvaFbmByYnC0=;
  b=oQSJq0EhXqNw0vvEuKrOheQgMxPEpHTCk2S35xKssXFF8wT8TZcVH0mZ
   Tor0na7ADzY67YaYL+uslMW6VqYX5Df0rTQX35lUPTTtpDvfskJyGJnj/
   mYKUltCCAuCxOgspUIL/qqebh03NFZ2NLRgrKRlGYVoQhV5YP+zedk6/e
   M6Ddyi29q0gu+d8Vrjr0V/eJt87+Bkk2MQt8pHfuz/MPZzeI2QxWUYS1K
   3KjjuMVBrI5QxO56i2vHX4N2HX7XHFYx7lUxKMqqF9i3ygLWbCNxUV29C
   zwmB4SMyIMb3/mTvkx2hVDSfl2eUbQtKVDvaqbq8Bdj77BEFV5pyQhXjo
   A==;
X-IronPort-AV: E=Sophos;i="5.60,415,1549900800"; 
   d="scan'208";a="108930460"
Received: from mail-bn3nam01lp2053.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.53])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 05:40:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UZbtTKHWsxc1hdanXASwueb24ZUtC6mscepEApKtig=;
 b=lMXmn7YbQBFPsho3puZpSTnru9nfQNPtvHsEVFELqEFu8mgdQqHrApUSuzJ2r92+/akN/+Bsr4a/3mPzhRAa0y5ynU0PAWQ1fn6ZMqNRTUMrbSsNspDwUwQqIrOxw/97L48yB1b5IKAX26hh4N7ra0I5Y7DMgYd5uDhEoZNktZw=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4272.namprd04.prod.outlook.com (52.135.72.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.16; Tue, 30 Apr 2019 21:39:58 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.015; Tue, 30 Apr 2019
 21:39:58 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] block: add SPDX tags to block layer files missing
 licensing information
Thread-Topic: [PATCH 5/5] block: add SPDX tags to block layer files missing
 licensing information
Thread-Index: AQHU/4St3GJzMF7xz02g3LNYGamIQw==
Date:   Tue, 30 Apr 2019 21:39:58 +0000
Message-ID: <SN6PR04MB45276BA5137B6113F5DE3D42863A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190430184243.23436-1-hch@lst.de>
 <20190430184243.23436-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e77f6370-204b-4a23-8b73-08d6cdb46498
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4272;
x-ms-traffictypediagnostic: SN6PR04MB4272:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4272BA8DFAFE1076F34D4551863A0@SN6PR04MB4272.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(54906003)(99286004)(26005)(74316002)(25786009)(7736002)(6436002)(76176011)(68736007)(66066001)(53936002)(6116002)(33656002)(3846002)(52536014)(6246003)(4326008)(486006)(186003)(2906002)(305945005)(66446008)(55016002)(110136005)(446003)(66946007)(91956017)(76116006)(71190400001)(66476007)(7696005)(64756008)(476003)(81166006)(81156014)(86362001)(72206003)(256004)(8676002)(102836004)(478600001)(14454004)(229853002)(53546011)(73956011)(316002)(6506007)(66556008)(7416002)(9686003)(8936002)(71200400001)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4272;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JD4JkP7ikw5Spr+ay7SX9pSCMghTKD3Fg2Fm7VF6UJyMLnyQ4bS94td2+8L7zkatF19GTOipjcMfCLN78VrjKqgGaYrg1gQ8K5Mg+gfJTvILR6yUzejEe3kJz9XhK7X/8h95zJZ28tps6pOei2QcFJHP+WK0rBDNtMXVJcRdcCCl2KrBXOQUEbXdttwQT8Qcaefp8JTsnSbBPYVXZA/pup8PZ+y22ILucF3lNzHynb1cf5SjNWryT+x8+GkFeJzRL7a9nh5mu1M5MJSXdWPAPGo1o6Q199Pli8zHI2Qi9M8sKgC/e5O2tP9I00BOSP94KkBVHuf7DFpsc0cc/lzEkInjbwS8cd0tZz3cZCezREJvrDtDasHteQ66eXLT1CxGq3StnugGZutX4szA4cLbqUTvL4peMGNSxS7/YTs6Zfk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77f6370-204b-4a23-8b73-08d6cdb46498
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 21:39:58.3418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4272
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 4/30/19 11:44 AM, Christoph Hellwig wrote:=0A=
> Various block layer files do not have any licensing information at all.=
=0A=
> Add SPDX tags for the default kernel GPLv2 license to those.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/blk-cgroup.c        | 1 +=0A=
>   block/blk-core.c          | 1 +=0A=
>   block/blk-exec.c          | 1 +=0A=
>   block/blk-iolatency.c     | 1 +=0A=
>   block/blk-mq-cpumap.c     | 1 +=0A=
>   block/blk-mq-sched.c      | 1 +=0A=
>   block/blk-mq-sysfs.c      | 1 +=0A=
>   block/blk-mq-tag.c        | 1 +=0A=
>   block/blk-mq.c            | 1 +=0A=
>   block/blk-rq-qos.c        | 2 ++=0A=
>   block/blk-rq-qos.h        | 1 +=0A=
>   block/blk-settings.c      | 1 +=0A=
>   block/blk-stat.c          | 1 +=0A=
>   block/blk-timeout.c       | 1 +=0A=
>   block/blk-wbt.c           | 1 +=0A=
>   block/blk-zoned.c         | 1 +=0A=
>   block/elevator.c          | 1 +=0A=
>   block/genhd.c             | 1 +=0A=
>   block/ioctl.c             | 1 +=0A=
>   block/ioprio.c            | 1 +=0A=
>   block/mq-deadline.c       | 1 +=0A=
>   block/partitions/aix.h    | 1 +=0A=
>   block/partitions/amiga.h  | 1 +=0A=
>   block/partitions/ibm.h    | 1 +=0A=
>   block/partitions/karma.h  | 1 +=0A=
>   block/partitions/msdos.h  | 1 +=0A=
>   block/partitions/osf.h    | 1 +=0A=
>   block/partitions/sgi.h    | 1 +=0A=
>   block/partitions/sun.h    | 1 +=0A=
>   block/partitions/sysv68.h | 1 +=0A=
>   block/partitions/ultrix.h | 1 +=0A=
>   31 files changed, 32 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c=0A=
> index 617a2b3f7582..b97b479e4f64 100644=0A=
> --- a/block/blk-cgroup.c=0A=
> +++ b/block/blk-cgroup.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Common Block IO controller cgroup interface=0A=
>    *=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index a55389ba8779..b044829135c9 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Copyright (C) 1991, 1992 Linus Torvalds=0A=
>    * Copyright (C) 1994,      Karl Keyte: Added support for disk statisti=
cs=0A=
> diff --git a/block/blk-exec.c b/block/blk-exec.c=0A=
> index a34b7d918742..1db44ca0f4a6 100644=0A=
> --- a/block/blk-exec.c=0A=
> +++ b/block/blk-exec.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Functions related to setting various queue properties from drivers=
=0A=
>    */=0A=
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c=0A=
> index 507212d75ee2..d22e61bced86 100644=0A=
> --- a/block/blk-iolatency.c=0A=
> +++ b/block/blk-iolatency.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Block rq-qos base io controller=0A=
>    *=0A=
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c=0A=
> index 03a534820271..48bebf00a5f3 100644=0A=
> --- a/block/blk-mq-cpumap.c=0A=
> +++ b/block/blk-mq-cpumap.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * CPU <-> hardware queue mapping helpers=0A=
>    *=0A=
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
> index aa6bc5c02643..f6e3b10b52eb 100644=0A=
> --- a/block/blk-mq-sched.c=0A=
> +++ b/block/blk-mq-sched.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * blk-mq scheduling framework=0A=
>    *=0A=
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c=0A=
> index 3f9c3f4ac44c..61efc2a29e58 100644=0A=
> --- a/block/blk-mq-sysfs.c=0A=
> +++ b/block/blk-mq-sysfs.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   #include <linux/kernel.h>=0A=
>   #include <linux/module.h>=0A=
>   #include <linux/backing-dev.h>=0A=
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c=0A=
> index a4931fc7be8a..7513c8eaabee 100644=0A=
> --- a/block/blk-mq-tag.c=0A=
> +++ b/block/blk-mq-tag.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Tag allocation using scalable bitmaps. Uses active queue tracking to=
 support=0A=
>    * fairer distribution of tags between multiple submitters when a share=
d tag map=0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index fc60ed7e940e..4f15adfbab29 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Block multiqueue core code=0A=
>    *=0A=
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c=0A=
> index d169d7188fa6..3f55b56f24bc 100644=0A=
> --- a/block/blk-rq-qos.c=0A=
> +++ b/block/blk-rq-qos.c=0A=
> @@ -1,3 +1,5 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +=0A=
>   #include "blk-rq-qos.h"=0A=
>   =0A=
>   /*=0A=
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h=0A=
> index 564851889550..2300e038b9fa 100644=0A=
> --- a/block/blk-rq-qos.h=0A=
> +++ b/block/blk-rq-qos.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   #ifndef RQ_QOS_H=0A=
>   #define RQ_QOS_H=0A=
>   =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 6375afaedcec..ec150f88db09 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Functions related to setting various queue properties from drivers=
=0A=
>    */=0A=
> diff --git a/block/blk-stat.c b/block/blk-stat.c=0A=
> index 696a04176e4d..940f15d600f8 100644=0A=
> --- a/block/blk-stat.c=0A=
> +++ b/block/blk-stat.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Block stat tracking code=0A=
>    *=0A=
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c=0A=
> index 124c26128bf6..8aa68fae96ad 100644=0A=
> --- a/block/blk-timeout.c=0A=
> +++ b/block/blk-timeout.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Functions related to generic timeout handling of requests.=0A=
>    */=0A=
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c=0A=
> index fd166fbb0f65..313f45a37e9d 100644=0A=
> --- a/block/blk-wbt.c=0A=
> +++ b/block/blk-wbt.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * buffered writeback throttling. loosely based on CoDel. We can't drop=
=0A=
>    * packets for IO scheduling, so the logic is something like this:=0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 2d98803faec2..ae7e91bd0618 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Zoned block device handling=0A=
>    *=0A=
> diff --git a/block/elevator.c b/block/elevator.c=0A=
> index 2e5399d9f40f..ec55d5fc0b3e 100644=0A=
> --- a/block/elevator.c=0A=
> +++ b/block/elevator.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    *  Block device elevator/IO-scheduler.=0A=
>    *=0A=
> diff --git a/block/genhd.c b/block/genhd.c=0A=
> index 83f5c33d1e80..ad6826628e79 100644=0A=
> --- a/block/genhd.c=0A=
> +++ b/block/genhd.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    *  gendisk handling=0A=
>    */=0A=
> diff --git a/block/ioctl.c b/block/ioctl.c=0A=
> index 4825c78a6baa..15a0eb80ada9 100644=0A=
> --- a/block/ioctl.c=0A=
> +++ b/block/ioctl.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   #include <linux/capability.h>=0A=
>   #include <linux/blkdev.h>=0A=
>   #include <linux/export.h>=0A=
> diff --git a/block/ioprio.c b/block/ioprio.c=0A=
> index f9821080c92c..2e0559f157c8 100644=0A=
> --- a/block/ioprio.c=0A=
> +++ b/block/ioprio.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * fs/ioprio.c=0A=
>    *=0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index 14288f864e94..1876f5712bfd 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    *  MQ Deadline i/o scheduler - adaptation of the legacy deadline sched=
uler,=0A=
>    *  for the blk-mq scheduling framework=0A=
> diff --git a/block/partitions/aix.h b/block/partitions/aix.h=0A=
> index e0c66a987523..b4449f0b9f2b 100644=0A=
> --- a/block/partitions/aix.h=0A=
> +++ b/block/partitions/aix.h=0A=
> @@ -1 +1,2 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   extern int aix_partition(struct parsed_partitions *state);=0A=
> diff --git a/block/partitions/amiga.h b/block/partitions/amiga.h=0A=
> index d094585cadaa..7e63f4d9d969 100644=0A=
> --- a/block/partitions/amiga.h=0A=
> +++ b/block/partitions/amiga.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    *  fs/partitions/amiga.h=0A=
>    */=0A=
> diff --git a/block/partitions/ibm.h b/block/partitions/ibm.h=0A=
> index 08fb0804a812..8bf13febb2b6 100644=0A=
> --- a/block/partitions/ibm.h=0A=
> +++ b/block/partitions/ibm.h=0A=
> @@ -1 +1,2 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   int ibm_partition(struct parsed_partitions *);=0A=
> diff --git a/block/partitions/karma.h b/block/partitions/karma.h=0A=
> index c764b2e9df21..48e074d417fb 100644=0A=
> --- a/block/partitions/karma.h=0A=
> +++ b/block/partitions/karma.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    *  fs/partitions/karma.h=0A=
>    */=0A=
> diff --git a/block/partitions/msdos.h b/block/partitions/msdos.h=0A=
> index 38c781c490b3..fcacfc486092 100644=0A=
> --- a/block/partitions/msdos.h=0A=
> +++ b/block/partitions/msdos.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    *  fs/partitions/msdos.h=0A=
>    */=0A=
> diff --git a/block/partitions/osf.h b/block/partitions/osf.h=0A=
> index 20ed2315ec16..4d8088e7ea8c 100644=0A=
> --- a/block/partitions/osf.h=0A=
> +++ b/block/partitions/osf.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    *  fs/partitions/osf.h=0A=
>    */=0A=
> diff --git a/block/partitions/sgi.h b/block/partitions/sgi.h=0A=
> index b9553ebdd5a9..a5b77c3987cf 100644=0A=
> --- a/block/partitions/sgi.h=0A=
> +++ b/block/partitions/sgi.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    *  fs/partitions/sgi.h=0A=
>    */=0A=
> diff --git a/block/partitions/sun.h b/block/partitions/sun.h=0A=
> index 2424baa8319f..ae1b9eed3fd7 100644=0A=
> --- a/block/partitions/sun.h=0A=
> +++ b/block/partitions/sun.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    *  fs/partitions/sun.h=0A=
>    */=0A=
> diff --git a/block/partitions/sysv68.h b/block/partitions/sysv68.h=0A=
> index bf2f5ffa97ac..4fb6b8ec78ae 100644=0A=
> --- a/block/partitions/sysv68.h=0A=
> +++ b/block/partitions/sysv68.h=0A=
> @@ -1 +1,2 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   extern int sysv68_partition(struct parsed_partitions *state);=0A=
> diff --git a/block/partitions/ultrix.h b/block/partitions/ultrix.h=0A=
> index a3cc00b2bded..9f676cead222 100644=0A=
> --- a/block/partitions/ultrix.h=0A=
> +++ b/block/partitions/ultrix.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    *  fs/partitions/ultrix.h=0A=
>    */=0A=
> =0A=
=0A=
