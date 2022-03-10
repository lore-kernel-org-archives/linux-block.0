Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 09:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiCJJRz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiCJJRz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 04:17:55 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF4A1390F2
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 01:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646903813; x=1678439813;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=L9nP1EoEHUXa1lQLpMe4cdwXwm5xvv3r1u99xJitAuU=;
  b=BzNN2vLB/4WsDb+q7s70Iq0pfxoT6rxl5hAiGYtZnsvfMyT9fsHa+De3
   qqSXfApHSJlRpiTsc7keHvKjmAdCNAdHynSNXsfgjd97byIfutI1Y7jPx
   Rxf2wvkByzjRYf3yyYZP3RFrv6NRYkg/AGLh66InNskrzwdAgaXlr8B+i
   OqYQ51Map3vD8OHg9MFgcK1OfSfxgz/JfyOUjn8WBCC7oD/BfHYobC3Sm
   aG4TiJaw6DAYytjsjWDJDR3C0B2wvDw7WWkzQ4IpFqJQuXmDwq37Y0ZxA
   Bx+BrxeBd5z2DvMq9x8W9UJWrbkqaXe3y8ReScl66q8Fc8Lbf2w5rZQjc
   g==;
X-IronPort-AV: E=Sophos;i="5.90,169,1643644800"; 
   d="scan'208";a="306896998"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 17:16:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3G002qU41ke0PKc5i0IgBnBFnAqcGStv+mIrTTfxPivn0n4ucA3szAATiZTdy5lInHFJVM21ILggqJ+X+vplUDdhts81ESwNHcC0LEmJBobzvW7CYTKFQcdmMPscHvYzTGyEeq5ikggAR/Ngv49txWuw4tyW6qJzxRwtM0IHnb2DpCVhf7fUuwXXJgaYowp4+/RhPS/K6cXIczXX/lztTsPFohSvWSVSOl0L8AReEIF6NXdwtiysP4KYWj+GoAlZCdP7vJxY9Hu0hFw9keDtMhDwNV3W/CLIz0dAp6pQakj7KRGt9y5PTIOUZKAEgo+sW8MKVMBUBzFIo0FVb6o+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxLBj6H1pvoOsBpoRLCV+djkvAwYgJj8TbT930HBdkA=;
 b=mf37Mg/7ZYtt5gwFAbbsJ5HSiBuH9T45S1EqxSHaTv+rey5unAj0huRATvgDwVxQdCU/kuV6brxIZtk/7lRHHspXTYF7GBzdbYbikKyi0t8yTfKyRjcJy4UWkHRTrd5nF5TdpV45Rk56KrKP5sUO8VZrCB3oMAFg/7UzOaCWyTqtzKDUuVMmPwxg2D2OFFrwNJMM3O1R2qALS4GiTtaRtDF9nPzx+1+vvNne7gRGjpp5PgvM1h8IoAcC+oC0sgUGmKPW2Q1hz882VcN7GMYx5NM522X2FX7kN+iXxbYz2cfpz2PN0HzZsrodCc6NLexPC00TBtY62aND7L2CTVOIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxLBj6H1pvoOsBpoRLCV+djkvAwYgJj8TbT930HBdkA=;
 b=UCAiO5eyqrH5tGbbmSI+qgI/TuZED8/yxQ7MDmei4gvOME6pCBZZCNGAC9OxpoeAinj2QcJq7xJ/U9S8SDD+0BphYeDrIw6fTwXs+H5XaqAR82/E1V4AkvjUnMmxhFcT8NzY6Y6u4KcrnxlRncPqDcxpuY2uvFK19on6ORFHxjc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB4646.namprd04.prod.outlook.com (2603:10b6:a03:13::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Thu, 10 Mar 2022 09:16:50 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::58d1:70c4:5b35:6c0a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::58d1:70c4:5b35:6c0a%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 09:16:50 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [bug report] worker watchdog timeout in dispatch loop for null_blk
Thread-Topic: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Index: AQHYNF+T3Cwh4555b06Tjj5eYItVAA==
Date:   Thu, 10 Mar 2022 09:16:50 +0000
Message-ID: <20220310091649.zypaem5lkyfadymg@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1d7aa2d-f5b5-49e8-c4f3-08da0276b5e2
x-ms-traffictypediagnostic: BYAPR04MB4646:EE_
x-microsoft-antispam-prvs: <BYAPR04MB464681BFE6EB0322200C75C7ED0B9@BYAPR04MB4646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: koqvD514iP4nBTVgHXDVjiTTH9twMMICoXhldEdPTf8InXynqSuF8co6/kISTQvIIevHuGubuvjAjWOZ51pNjwbV6h7Of35o2qQzRbKjcHy+4K6DMM1WNzjoe1tlVxvStzHvmoxCffRsZkMS2iHMJQpVwySYy6rLb57btsOoPaoITohXkxMezKKFIdPydzMDqMd7UxB8H8lpqHGdGMI6SGd9VKWf3NZo9BvG5b9kDXJZa7S+RARf/74/dhse9VzgcsZFcxDcVLnez6O4uSZXT2x0E3YRpGU5GMLrXdeA9x1K0qXEvhQP1NfdVb5NxS/MPqXon5goFPXsekCIjeS2ovYqDbF6+C1dFHD4zr/C5uMIR5bOqVmUDB4xDuqN0kNd9vVEugxvg8SfoDsjh9X5+KJaeV9bsdtrNFravAjDg5RqMOS+dbfi6tXu1e6tbBBJsLhe2AedYyPF/mJL/R5YNwv3ueK7ThMBLKxqpc6XDh/wzDMnzJdr8o0OCjAENfnoCkY77fIfRsOznI1iSq35gkqJQS24xGe127SLFFKIboUTnzWiJHgol16O3wQ9X8YiaY+323/nT+WG8iEOug19KmasK1OZZThRBSKx46re/WY0Vu2tZnFGD4kSEpSkq1XLG5OtoNtSfY3mFOYAGaMqZ7afMMmARnaMVWRXtBrAMHDjRB8KpnsGyLTAbu+/rzJ2c7qQ9JQwCtbm33+IPo7HaP+cogLLAKoGc1B8KQT6Hf0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(186003)(6512007)(1076003)(26005)(82960400001)(6506007)(66556008)(66476007)(64756008)(66946007)(9686003)(71200400001)(2906002)(66446008)(33716001)(6486002)(508600001)(5660300002)(83380400001)(4326008)(8936002)(86362001)(44832011)(91956017)(8676002)(38100700002)(38070700005)(6916009)(122000001)(316002)(54906003)(76116006)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GevTyEFMR0ReVaR4r8Z/AkALunniEWQc1egVR5JTfcmY3tVrgshqbhN4UJok?=
 =?us-ascii?Q?qjAURgVhctQ41svJqxR9mcJQUPFehAanXYJ+7exM0CpNUGPbZD0N7i69xptg?=
 =?us-ascii?Q?g2tYyygZQlvDqDHJ+AkfcPJnes4xH/kgQ0TnooMif2P5YvmxlpsRd0S7nN9b?=
 =?us-ascii?Q?wRgNM4dwGu1pCPb5bCDc720zbS/1VVx3p36CFh3Auc8/axRev/LhoVIn0eVE?=
 =?us-ascii?Q?Wj9ZUxo+M5URjMY1hgNYes6hJkEA6o5L/p0Tob1FF2n5NrsVxBl9QsYGdq/S?=
 =?us-ascii?Q?NasDuHrXnmtR/Kc2IUn9PZTWWDLL22OZiQGCltdOyoU9RIlLzyZn7QOon1kE?=
 =?us-ascii?Q?q7fZVYvSLWbsZpLmKAd9se2WIbEBup8TaVlvYqq8+lnkPfLtpuaCOf8dtxmj?=
 =?us-ascii?Q?3ZKC/s1BVK/Ty3xNvg+umD6zmwAN3fdTQ9dY7lmuEDs6VBTraTooThJBkxy7?=
 =?us-ascii?Q?e6P+hpCCFrg4AU8/QZZgvuxnrOKE8NKL2OKLqEcT/vX7IMPY9+G8bRDiizAb?=
 =?us-ascii?Q?GCRuDWqffhMZ98zcKLPH4n96XqWO3kVQcqc5t+z0+Fdp7fJpj50+a99ziibd?=
 =?us-ascii?Q?D8oLBPWeUgtiTxw2I/hJ6gNhdlCOYBVWbT0xCrum/XkAgtwOlteg5oVLHcTB?=
 =?us-ascii?Q?YRox9uBX6+6jA3yWEjbx76Mcvw8hR98hURW9S/Po8eGGVaawaQ5U+4YIHMPB?=
 =?us-ascii?Q?vcM38g8nhYAHi8BoLohJ+Bc9QiGeezIX5UfuGaGmjTcy6KV+ZEQ0MoYm4+Rf?=
 =?us-ascii?Q?z8l9qbftnnR4BMb7uXQuyQERzv8kL5b6fzJEbcS4uN4Pwc96KSvzNVNXgh5Y?=
 =?us-ascii?Q?FO8iN1XpgIBic6mGYWFe/fG9FYjrQfXTUfeFcLVB8gN2/Lp5dKJIoGpuTDBF?=
 =?us-ascii?Q?IlcPKXEeestEnwlgV1roLyP8CD50vLSEo8jfbSm1nKHbk5D3tySY56oVJWGQ?=
 =?us-ascii?Q?1uEr9KEn8q+3YzylBdMnIDCEoBHFkCiXsbZ6L78PY/cjrUYTLR8rjVAJM0im?=
 =?us-ascii?Q?x0Az7/vyiP2BMrdywZMnkr+x1dGZFZ1xdo8hRxvqheThMRmc1qeO5iDOgW25?=
 =?us-ascii?Q?9hs/RKzmZrRmrwTp3gBA6Xxdc4sSzrIaNvlR8vNlA37PqghNhofm0Pi/awmU?=
 =?us-ascii?Q?5TN1/8ueIwULyUcnqedKXyGTgrmZcI6fhCh6PaRV32cD0eLuZlBmQmhqN/n/?=
 =?us-ascii?Q?zAYgGL5WxtzP5RQIg4vpHucOg40sU9R4KuybgNfh2BjxYoRyFqV3uEbN+Af9?=
 =?us-ascii?Q?zj2mrcM7HG3QfE7FxDY1s6TktvtU0jEe2/kEQFo8hTUI+dcUfdDmd1wLK+a5?=
 =?us-ascii?Q?itJIV0wqpq5oWpjyn27SjxgncJY8ISzCZ6iA5tmQ06tnm67gbkT68EuuFze2?=
 =?us-ascii?Q?mEG9nlxSetlsvH/q/fVpb9grW/quhU6ax8CiooeerUe0BgCpBDyvpXik4MZo?=
 =?us-ascii?Q?wl+tFNWF+ZBXrYbYW94s6KUbptcJ/cvJCngYFVCTIusfCK/hi+xYdIgCGh1q?=
 =?us-ascii?Q?S79vOWtR8W+7WLeJcQ/u2bUcrPvkZIe6+AvQSoRGUWBCm67zLXr6cEb0iYo4?=
 =?us-ascii?Q?HosIzsgYXV/MmuJrovE4p2Aro3IvlDhXx4Fa1WmLvSaTV+lGqMBKX94AJA0X?=
 =?us-ascii?Q?2YeLeKDysLmHIkkaRCRNLpG10pehi/NKQ9YdanT6TXLb4UKuGnhRAb3mgNCF?=
 =?us-ascii?Q?a4Dgh0at3FXbiOuYw3PHkCXnRJw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F964A9D7BC3C24E92F8BB4155C79DAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d7aa2d-f5b5-49e8-c4f3-08da0276b5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 09:16:50.5718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BhYhtxbbaWwFNf8Jsg+J5sldfZL3sAs6yH8pQUlXi36wE6jx4yyxOM3FT+jSkA2Ub9ci9O2jt0ud7p3Js/sb6QtmPnSLc+hK1Z5SfZOxmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4646
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This issue does not look critical, but let me share it to ask comments for =
fix.

When fio command with 40 jobs [1] is run for a null_blk device with memory
backing and mq-deadline scheduler, kernel reports a BUG message [2]. The
workqueue watchdog reports that kblockd blk_mq_run_work_fn keeps on running
more than 30 seconds and other work can not run. The 40 fio jobs keep on
creating many read requests to a single null_blk device, then the every tim=
e
the mq_run task calls __blk_mq_do_dispatch_sched(), it returns ret =3D=3D 1=
 which
means more than one request was dispatched. Hence, the while loop in
blk_mq_do_dispatch_sched() does not break.

static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
{
        int ret;

        do {
               ret =3D __blk_mq_do_dispatch_sched(hctx);
        } while (ret =3D=3D 1);

        return ret;
}

The BUG message was observed when I ran blktests block/005 with various
conditions on a system with 40 CPUs. It was observed with kernel version
v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593fbbc245 ("null_blk=
:
poll queue support"). This commit added blk_mq_ops.map_queues callback. I
guess it changed dispatch behavior for null_blk devices and triggered the
BUG message.

I'm not so sure if we really need to fix this issue. It does not seem the r=
eal
world problem since it is observed only with null_blk. The real block devic=
es
have slower IO operation then the dispatch should stop sooner when the hard=
ware
queue gets full. Also the 40 jobs for single device is not realistic worklo=
ad.

Having said that, it does not feel right that other works are pended during
dispatch for null_blk devices. To avoid the BUG message, I can think of two
fix approaches. First one is to break the while loop in blk_mq_do_dispatch_=
sched
using a loop counter [3] (or jiffies timeout check). But it may not be good=
 to
add such a check in the loop, assuming it is the hot path. The other fix id=
ea is
to count number of requests within null_blk so that null_queue_rq() sometim=
es
returns BLK_STS_RESOURCE [4]. It will make the request requeued and the
dispatch loop have a break. This approach looks better for me since it touc=
hes
only null_blk.

Comments on solution will be appreciated. Is there better fix idea?  Now I'=
m
tempted to the fix in null_blk.


[1]

# fio --bs=3D4k --rw=3Drandread --norandommap --numjobs=3D40 --name=3Dreads=
 --direct=3D1 \
    --filename=3D/dev/nullb0 --size=3D1g --group_reporting

[2]

[  609.691437] BUG: workqueue lockup - pool cpus=3D10 node=3D1 flags=3D0x0 =
nice=3D-20 stuck for 35s!
[  609.701820] Showing busy workqueues and worker pools:
[  609.707915] workqueue events: flags=3D0x0
[  609.712615]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/2=
56 refcnt=3D2
[  609.712626]     pending: drm_fb_helper_damage_work [drm_kms_helper]
[  609.712687] workqueue events_freezable: flags=3D0x4
[  609.732943]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/2=
56 refcnt=3D2
[  609.732952]     pending: pci_pme_list_scan
[  609.732968] workqueue events_power_efficient: flags=3D0x80
[  609.751947]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/2=
56 refcnt=3D2
[  609.751955]     pending: neigh_managed_work
[  609.752018] workqueue kblockd: flags=3D0x18
[  609.769480]   pwq 21: cpus=3D10 node=3D1 flags=3D0x0 nice=3D-20 active=
=3D3/256 refcnt=3D4
[  609.769488]     in-flight: 1020:blk_mq_run_work_fn
[  609.769498]     pending: blk_mq_timeout_work, blk_mq_run_work_fn
[  609.769744] pool 21: cpus=3D10 node=3D1 flags=3D0x0 nice=3D-20 hung=3D35=
s workers=3D2 idle: 67
[  639.899730] BUG: workqueue lockup - pool cpus=3D10 node=3D1 flags=3D0x0 =
nice=3D-20 stuck for 66s!
[  639.909513] Showing busy workqueues and worker pools:
[  639.915404] workqueue events: flags=3D0x0
[  639.920197]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/2=
56 refcnt=3D2
[  639.920215]     pending: drm_fb_helper_damage_work [drm_kms_helper]
[  639.920365] workqueue kblockd: flags=3D0x18
[  639.939932]   pwq 21: cpus=3D10 node=3D1 flags=3D0x0 nice=3D-20 active=
=3D3/256 refcnt=3D4
[  639.939942]     in-flight: 1020:blk_mq_run_work_fn
[  639.939955]     pending: blk_mq_timeout_work, blk_mq_run_work_fn
[  639.940212] pool 21: cpus=3D10 node=3D1 flags=3D0x0 nice=3D-20 hung=3D66=
s workers=3D2 idle: 67

[3]

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55488ba978232..746c75cb6aafb 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -178,13 +178,16 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_h=
w_ctx *hctx)
 	return !!dispatched;
 }
=20
+#define DISPATCH_BREAK_COUNT 0x10000
+
 static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	int ret;
+	unsigned int count =3D DISPATCH_BREAK_COUNT;
=20
 	do {
 		ret =3D __blk_mq_do_dispatch_sched(hctx);
-	} while (ret =3D=3D 1);
+	} while (ret =3D=3D 1 && count--);
=20
 	return ret;
 }


[4]

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 13004beb48cab..3ef3a18fa8f3f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -22,6 +22,8 @@ static DECLARE_FAULT_ATTR(null_requeue_attr);
 static DECLARE_FAULT_ATTR(null_init_hctx_attr);
 #endif
=20
+#define REQUEST_BREAK_COUNT 0x10000
+
 static inline u64 mb_per_tick(int mbps)
 {
 	return (1 << 20) / TICKS_PER_SEC * ((u64) mbps);
@@ -1493,13 +1495,13 @@ static bool should_timeout_request(struct request *=
rq)
 	return false;
 }
=20
-static bool should_requeue_request(struct request *rq)
+static bool should_requeue_request(struct request *rq, struct nullb_queue =
*nq)
 {
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
 	if (g_requeue_str[0])
 		return should_fail(&null_requeue_attr, 1);
 #endif
-	return false;
+	return !(nq->request_count % REQUEST_BREAK_COUNT);
 }
=20
 static int null_map_queues(struct blk_mq_tag_set *set)
@@ -1632,8 +1634,9 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ct=
x *hctx,
 	cmd->fake_timeout =3D should_timeout_request(bd->rq);
=20
 	blk_mq_start_request(bd->rq);
+	nq->request_count++;
=20
-	if (should_requeue_request(bd->rq)) {
+	if (should_requeue_request(bd->rq, nq)) {
 		/*
 		 * Alternate between hitting the core BUSY path, and the
 		 * driver driven requeue path
@@ -1690,6 +1693,7 @@ static void null_init_queue(struct nullb *nullb, stru=
ct nullb_queue *nq)
 	nq->dev =3D nullb->dev;
 	INIT_LIST_HEAD(&nq->poll_list);
 	spin_lock_init(&nq->poll_lock);
+	nq->request_count =3D 0;
 }
=20
 static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/nul=
l_blk.h
index 78eb56b0ca55f..165669ce97ad3 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -36,6 +36,7 @@ struct nullb_queue {
 	spinlock_t poll_lock;
=20
 	struct nullb_cmd *cmds;
+	unsigned int request_count;
 };
=20
 struct nullb_zone {

--=20
Best Regards,
Shin'ichiro Kawasaki=
