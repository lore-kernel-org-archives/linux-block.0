Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC7BC433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 11:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiCGLci (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbiCGLcb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 06:32:31 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A692A248
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 03:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646652420; x=1678188420;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=hjoUITUXX5NDMQPWl+a2P36+kR/FsDNaOatt0eTI5H0=;
  b=gFjMXgmSHPOJFP+4nLCNCV1ga7M++q0HtvD3q6VY0mDx2pRH13SXMD3y
   yDYsKiUUc0dcj6DxmCYXFKcKTMXYpFj/hSvrzSz3PLWZio+4UEByDbToZ
   nOvkNFi4B84/u//251jtGGwHpigWdHo1FRBl/1t7M80tTKZwVpRjXmGud
   OokQ17nzT3O9EqGbGZmbHWQl52J7CJzIA/BZedov4JVqu9xX+WWy82PyY
   yl4x3UxScB13oUemhod47EN7VYXQ6uRSnSrCcX/4nbshZiB1aGF+dtJ7M
   D+wOWjeE7iX8cQMdCV6jQFhIf5Z0ruZOdnRhisdW2VWn0ZePS/D8WXnpj
   w==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643644800"; 
   d="scan'208";a="306565773"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 19:26:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyMfxj2wUener67AEmXdxXMxOYlBpWIkfAplMvdOwS+P4tHrjgPMFbAYrbAgfz6eKSh04IJ8dABb8HQKhPP4+Y+5IDKt01agOf/cIKTETzzdfEbp3Z/JszHtUBgu75yuhiCCk9TdTxDqFMZVa6r9BDx9NzCzFZhl0LbWZwcC3w5BPIwJUkpDInq+bq8f+76ZpYsW8ds2otWDEt6jPl/so7qLxSnELdfQZcYOqYkhMt5oKLTO+jBI142j+jpc04zm8Uvt5eXP8+tOKiMGEVz3QEoNXqO7uQCMusWurEgWD+sndrXDwnCXk0UmMpliDaVhu+Te/4c2VQnDBxt4Y+6HPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsLo09xW7uY2Z5c0ZerAwrrTKlChMyInAUDF5tTckFM=;
 b=Wpp4BzhZRnRrzlISd9P6gnj7gFPBZG7HRn6Ki8qgvVjDuLjRj3Bv4UEgeJj1gMBsKd3WBTHSy45kXGh5XOmgIdFAik2RtgEOYHcgqeDIyDTj/OXOptE4kzuWt2QzIf/LJjYw5W9V0j+rdUxV3Jq+50TgSzCZ/BmFqs8MXFTUkyGi2cquR8DfKDH53d74Xd9DrXUNzP6p7mbhCvaKdkp3yvQi0pBdaZwX0IdihrM6nWhOPCiVIEw4kn5E03PsWRKy50ZJcKeLnyF5/XGPTwPxhUHlJbQ6bMhM0mzI3cdHh3joycFShqEie2XGCcvyJRyvMRGoGmz1VULgfv0cfRv4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsLo09xW7uY2Z5c0ZerAwrrTKlChMyInAUDF5tTckFM=;
 b=bWatG67VjNcpeQrKPvOJfoKQIp0QXHMAksEjnQlokRT+sABbUC7jZ4TMIGWpPSiQsp0715pHNozwW/hA6M2Ukzflp7A1MyhYr4Yyc933tsvpiN5MwPEg8lt+0EvrZP40D9KfS+Khw27EI7ju310g0FBDQ/12vbVPYp2ivScWRxk=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by CY4PR04MB1000.namprd04.prod.outlook.com (2603:10b6:910:52::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 11:26:56 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::4db7:e845:4326:2c3d]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::4db7:e845:4326:2c3d%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 11:26:56 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [bug report] blktests block/005: KASAN uaf at bio merge
Thread-Topic: [bug report] blktests block/005: KASAN uaf at bio merge
Thread-Index: AQHYMhZAQGfK9roq2EqR+pvUaw6GVw==
Date:   Mon, 7 Mar 2022 11:26:56 +0000
Message-ID: <20220307112655.5ewkvhz5d3avglnd@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66a8e259-bd94-4fc0-d4a4-08da002d6351
x-ms-traffictypediagnostic: CY4PR04MB1000:EE_
x-microsoft-antispam-prvs: <CY4PR04MB1000EE108A996BD9E431A5C4ED089@CY4PR04MB1000.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nm1fdv4SE3D3jylmbzRqqWgMZDgd5TRXAz6DuW9YvwlGjntdBCPOz/CqdbPuMiC6bExZKQnTmcLWt28UqBlSYppFs+2HOxFG2wIcp3Dbh+8DSUHvLep+98OaE9MDEuR1kNE8ndbiq2syY/pJsZgWw0KL9EWv4JQAC/FNs/tjgRtb/KkkDGY5uHEZ7cK6ToQL76839iCTsltwzRSVejgqOp1LKYqt/2V+HZjaXGW3x/5WT18dsPK4FFVMWV1osbUrZQcAIHDsR4HhHzQEaq0+gOMyiWeVEVx100wf6nFoHpSvybuwdwmY6lWGMcXY4hQXyXE72OdtBdeNCJ1ih9lmZdXcOMIlwj6awd/s73iCxyypjyzwtJQOvF62hg6Dcl2lunvaHxzLI5FZV+aaF2OW0qEHX1thxVqPXUSWxxvz2hmhiPdQAcqusvQL+LSAVwBxKzsfIYEr1pogEjckPssBo50ojo37o4izdYXDywNv7GTQleB6I7pgMIt5E2yaDcmxy6WrnE30wzkfIE4wPH90vXM2YRDFJzWQ+fSoxv1yAcCrgIJtBT9ak/Jc5fF7hft1xI2yQY6YkowBLJAQ5eOtgvy99nm7oZTndx/Brzu/OuLCxZ81VFchCyHs5IUXC/mAqBuGrfFL0uR84ogKvH2HMctEgmFpHLgISZ7gHMz47auaRsNeNmJwI20nWWYUq1xSnGXBgUXAQDJQWeedDHrgaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6486002)(71200400001)(508600001)(54906003)(6916009)(316002)(38070700005)(66556008)(66476007)(64756008)(66446008)(4326008)(8676002)(86362001)(122000001)(38100700002)(66946007)(82960400001)(76116006)(8936002)(9686003)(33716001)(6512007)(6506007)(2906002)(44832011)(26005)(186003)(5660300002)(83380400001)(1076003)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uyu6q+qhHWcMPQCwPt8dJxyw0nSkPxmOZEO33pREkWO+aUuSE8gmhWLUOZXH?=
 =?us-ascii?Q?65sYp2ZcO+n0FexaoYO4rfa9h2IwmEwkAADVvXmHS+ZcboLYl4hTL/WdYHLA?=
 =?us-ascii?Q?WQXe0ntNY23aedyaj5M7A8UluSlqQKD0/ld8CjSMPAaP6dlnUou20w9Ppe29?=
 =?us-ascii?Q?hAZ4eVEj9FJ+zw+gAnHEXWUy9mGC4njNBMzINCYoTwt9bXtXycVL8ShHLEgS?=
 =?us-ascii?Q?aGQ2bIyi9QNcc1DPwTntLu48Kv1A9UfHJbFtP0eq1ZjwR4K1CnEF+iRjBYUW?=
 =?us-ascii?Q?wA+sWJbAt3VHhErzQCRHQikJe0kkub8JJcvMJznTgMsHuRYBWSEs1pg83jtH?=
 =?us-ascii?Q?ZknU5lp/Yzr+p5VTQIUtK4GmNraUXWrMIgHHnOcD1SZ4q/UuvFUThD9TkoFR?=
 =?us-ascii?Q?uJGS2GblItf/zrrVA7Q9pftWj/racAM/SnSYgnCiO3mO5ySLxVw/EMrPGKsv?=
 =?us-ascii?Q?L5Bj1THdok+z+2Nz21zIBJ/o4ICdUQ7RgHHciTOboDBsHoWzUhPc85VksFBs?=
 =?us-ascii?Q?+wnF2tUf3C5YUQtDJJYoSgRGNwTbgRfHxR7ZQ5REPys36w9f7wp6cLW6A9yY?=
 =?us-ascii?Q?YKQCEk1Qobi4akc1/MgsxuwK6qAuYSI4UPUt0Jv3SMgSUGd0dhWGsAi6jJvO?=
 =?us-ascii?Q?2vZM88glrb13FKWFSBvvrcW+SO+aQHoa8QJTlVnRdLeXphJ341mLooA7QJ2n?=
 =?us-ascii?Q?3vADmtMlUhtr3kMr5/52TDo3OMpPfkR7zT19bRsaioMiDtuvedVitxfn3WnH?=
 =?us-ascii?Q?6eUPjazB3dMNUElmbx4k+trLxnWXJcurRy9d6mmt+vF2/zsDMTXxmhmv9wrI?=
 =?us-ascii?Q?zfOTnHD0ZVdQiUoGXnBuXrfq3k/nu6e96E4wpG0/ZVmv/ErclBOgkNYKNUGc?=
 =?us-ascii?Q?G2WCeA8wRY6I9dmKE4iNMOg7yMSIEa9wDInLoUMAaDEhed9KZTKQ8MpyDDtP?=
 =?us-ascii?Q?nFuE1nVtfcx3VVBFeLIqsOg6OpeLU8I0DQS2QZv7DY1KRjjJvSLz7VX+/uVv?=
 =?us-ascii?Q?zLS2lwatbBUFvCxuEO3fQYltrmmO9e22CO3/zYsMrmvt+RQZEkKXo3uxkHwA?=
 =?us-ascii?Q?MO5RCVj0BSyKvz+yXBV4UbjTetw0/xq6WygjtQnPzD1qpnT7xxnC1HlGpcnj?=
 =?us-ascii?Q?XXhq6E3Cxl4erBvt9FYjVTPzdrOOL/kw6tCx3Ne8cGdTyodsYTe1f4taCEDN?=
 =?us-ascii?Q?k1QI+Cq42lTNQkot9y57FHkyUn/+UZpwa6CkQYCaPAFN02EPIMxZoFqZxMQW?=
 =?us-ascii?Q?Y2e0lEWzDQMGvKQazZOOh0mmOCIvD+KGDRKrrIOPjp7lASJl4ojbgdkb3RJu?=
 =?us-ascii?Q?iuRsf3qiit1eQAFmcJ7yVQl+SMln4YiH5T+PPNtT3qwUD5BcdN1dnHN9gx7d?=
 =?us-ascii?Q?6Nf1A996q3/TVfZn0eD5mc60v2QZRz1agcO7mddK7UW8r7GngcM96QSXOvfe?=
 =?us-ascii?Q?HXq4336nUmjW1PvOWDhqIf0hrIqVe8yYMRJ7IUL+MX4ovmFKAP3iNh5QL8Sa?=
 =?us-ascii?Q?lGhsH3vdfPuRB0OofKENfTORyax+4siPCEPUyoQBaf9NijkSJ0OZL4LFUNAa?=
 =?us-ascii?Q?eVXG7ui7UBIag3Swnr08E4FsvD3WrG4WEauMUIgab25npZ/D4YNhgLrdFNJJ?=
 =?us-ascii?Q?ZnwkEL3dfCa116PppMjg9fXikDihR3Q/aYr2fN9TjqF7jaUOpzlYU/Ky+zsS?=
 =?us-ascii?Q?iEk6LnNBTfUcnXGVJl8J9+5E800=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7EA58C78B006B24E9BE1B796EDC8CCCD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a8e259-bd94-4fc0-d4a4-08da002d6351
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 11:26:56.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgI1yfKWc1pdKYIXNnlYPNJpSMdmJ8Oa7EGFve/2zuA9OGQtIDOHBEV3gEwLC6wpTqUoNMB31f3aycHuzj9iw61PtfgyyUYLrEynJwjuSkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1000
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I observed blktests block/005 failure by KASAN use-after-free. The test cas=
e
repeats IO scheduler switch during fio workload. According to the kernel
message, it looks like bio submit path is running while IO scheduler is inv=
alid,
and kyber_bio_merge accessed the invalid IO scheduler data.

The failure was observed with v5.17-rc1, and still observed with v5.17-rc7.
It was observed with QEMU NVME emulation device with ZNS zoned device
emulation. So far, it is not observed with other devices. To recreate the
failure, need to repeat the test case. In the worst case, 500 times repetit=
ion
is required.

I bisected and found the commit 9d497e2941c3 ("block: don't protect
submit_bio_checks by q_usage_counter") triggers it. The commit moves calls =
of
3 functions: submit_bio_checks, blk_mq_attempt_bio_merge and rq_qos_throttl=
e.
I suspected that the move of blk_mq_attempt_bio_merge is the cause, and tri=
ed
to revert only that part. But it caused linux system boot hang related to
rq_qos_throttle. Then I created another patch which reverts moves of both
blk_mq_attempt_bio_merge and rq_qos_throttle calls [2]. With this patch, th=
e
KASAN uaf disappeared. Based on this observation, I think the failure cause=
 is
the move of blk_mq_attempt_bio_merge out of guard by bio_queue_enter.

I'm not sure if the fix by the patch [2] is good enough. With that fix, the
blk_mq_attempt_bio_merge call in blk_mq_get_new_requests is guarded with
bio_queue_enter, but the blk_mq_attempt_bio_merge call in
blk_mq_get_cached_request may not be well guarded. Comments for fix approac=
h
will be appreciated.


[1]

[  335.931534] run blktests block/005 at 2022-03-07 10:15:29
[  336.285062] general protection fault, probably for non-canonical address=
 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN PTI
[  336.291190] KASAN: null-ptr-deref in range [0x0000000000000088-0x0000000=
00000008f]
[  336.297513] CPU: 0 PID: 1864 Comm: fio Not tainted 5.16.0-rc3+ #15
[  336.302034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
[  336.309636] RIP: 0010:kyber_bio_merge+0x121/0x320
[  336.315382] Code: 80 3c 16 00 0f 85 f8 01 00 00 49 8b ac 24 40 01 00 00 =
48 ba 00 00 00 00 00 fc ff df 48 8d bd 88 00 00 00 48 89 fe 48 c1 ee 03 <80=
> 3c 16 00 0f 85 80 01 00 00 49 8d bc 24 8c 01 00 00 4c 8b ad 88
[  336.330777] RSP: 0018:ffff8881105e7820 EFLAGS: 00010206
[  336.334971] RAX: 0000000000000000 RBX: ffffe8ffffc10040 RCX: 00000000000=
00000
[  336.340428] RDX: dffffc0000000000 RSI: 0000000000000011 RDI: 00000000000=
00088
[  336.345951] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888116b=
5a29f
[  336.351789] R10: ffffed1022d6b453 R11: 0000000000000001 R12: ffff8881132=
1a800
[  336.357550] R13: 0000000000000000 R14: ffff8881105e7bf0 R15: 00000000000=
00001
[  336.363334] FS:  00007f1adf654b40(0000) GS:ffff8881e5600000(0000) knlGS:=
0000000000000000
[  336.369008] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  336.373065] CR2: 000000000049be98 CR3: 0000000118c86002 CR4: 00000000001=
70ef0
[  336.378103] Call Trace:
[  336.380390]  <TASK>
[  336.382386]  blk_mq_submit_bio+0xd0c/0x1b40
[  336.386036]  ? rcu_read_lock_sched_held+0x3f/0x70
[  336.389727]  ? blk_mq_try_issue_list_directly+0x3c0/0x3c0
[  336.394052]  ? get_user_pages+0xa0/0xa0
[  336.396975]  ? should_fail_request+0x70/0x70
[  336.400050]  __submit_bio+0x245/0x2e0
[  336.402967]  ? submit_bio_checks+0x1700/0x1700
[  336.406347]  ? find_held_lock+0x2c/0x110
[  336.409339]  submit_bio_noacct+0x5a1/0x810
[  336.412178]  ? __submit_bio+0x2e0/0x2e0
[  336.415044]  ? __blkdev_direct_IO_simple+0x3f8/0x6f0
[  336.418354]  submit_bio+0x149/0x340
[  336.420715]  ? submit_bio_noacct+0x810/0x810
[  336.423491]  __blkdev_direct_IO_simple+0x3cd/0x6f0
[  336.426723]  ? blkdev_llseek+0xc0/0xc0
[  336.429513]  ? lock_release+0x3a9/0x6d0
[  336.432221]  ? lock_downgrade+0x6b0/0x6b0
[  336.435057]  ? next_uptodate_page+0x59e/0x7d0
[  336.438730]  ? blkdev_get_block+0xd0/0xd0
[  336.442617]  ? fsnotify_first_mark+0x140/0x140
[  336.446481]  blkdev_read_iter+0x3e2/0x580
[  336.450322]  ? __do_fault+0x460/0x460
[  336.453902]  new_sync_read+0x35f/0x5d0
[  336.457137]  ? __fsnotify_parent+0x275/0xb20
[  336.460911]  ? __ia32_sys_llseek+0x2f0/0x2f0
[  336.464331]  ? __fsnotify_update_child_dentry_flags+0x2e0/0x2e0
[  336.467827]  ? inode_security+0x4f/0xf0
[  336.470315]  vfs_read+0x26c/0x4c0
[  336.472552]  __x64_sys_pread64+0x17c/0x1d0
[  336.474961]  ? vfs_read+0x4c0/0x4c0
[  336.477133]  ? syscall_enter_from_user_mode+0x21/0x70
[  336.479819]  do_syscall_64+0x3b/0x90
[  336.481788]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  336.484985] RIP: 0033:0x7f1ae8d7b81f
[  336.487043] Code: 08 89 3c 24 48 89 4c 24 18 e8 bd a8 f8 ff 4c 8b 54 24 =
18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 fd a8 f8 ff 48 8b
[  336.496657] RSP: 002b:00007ffed8151d60 EFLAGS: 00000293 ORIG_RAX: 000000=
0000000011
[  336.500726] RAX: ffffffffffffffda RBX: 00000000017ce540 RCX: 00007f1ae8d=
7b81f
[  336.504702] RDX: 0000000000001000 RSI: 0000000001894000 RDI: 00000000000=
00008
[  336.508525] RBP: 00000000017ce540 R08: 0000000000000000 R09: 00000000000=
00001
[  336.512202] R10: 00000000104e6000 R11: 0000000000000293 R12: 00007f1ac9e=
f3e18
[  336.515665] R13: 0000000000000000 R14: 0000000000001000 R15: 00000000000=
00001
[  336.518168]  </TASK>

[2]

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d69ca91fbc8b..59c66b9e8a44 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2718,7 +2718,8 @@ static bool blk_mq_attempt_bio_merge(struct request_q=
ueue *q,
=20
 static struct request *blk_mq_get_new_requests(struct request_queue *q,
 					       struct blk_plug *plug,
-					       struct bio *bio)
+					       struct bio *bio,
+					       unsigned int nsegs)
 {
 	struct blk_mq_alloc_data data =3D {
 		.q		=3D q,
@@ -2730,6 +2731,11 @@ static struct request *blk_mq_get_new_requests(struc=
t request_queue *q,
 	if (unlikely(bio_queue_enter(bio)))
 		return NULL;
=20
+	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
+		goto queue_exit;
+
+	rq_qos_throttle(q, bio);
+
 	if (plug) {
 		data.nr_tags =3D plug->nr_ios;
 		plug->nr_ios =3D 1;
@@ -2742,12 +2748,13 @@ static struct request *blk_mq_get_new_requests(stru=
ct request_queue *q,
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
+queue_exit:
 	blk_queue_exit(q);
 	return NULL;
 }
=20
 static inline struct request *blk_mq_get_cached_request(struct request_que=
ue *q,
-		struct blk_plug *plug, struct bio *bio)
+		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
 {
 	struct request *rq;
=20
@@ -2757,14 +2764,20 @@ static inline struct request *blk_mq_get_cached_req=
uest(struct request_queue *q,
 	if (!rq || rq->q !=3D q)
 		return NULL;
=20
-	if (blk_mq_get_hctx_type(bio->bi_opf) !=3D rq->mq_hctx->type)
+	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
+		*bio =3D NULL;
+		return NULL;
+	}
+
+	if (blk_mq_get_hctx_type((*bio)->bi_opf) !=3D rq->mq_hctx->type)
 		return NULL;
-	if (op_is_flush(rq->cmd_flags) !=3D op_is_flush(bio->bi_opf))
+	if (op_is_flush(rq->cmd_flags) !=3D op_is_flush((*bio)->bi_opf))
 		return NULL;
=20
-	rq->cmd_flags =3D bio->bi_opf;
+	rq->cmd_flags =3D (*bio)->bi_opf;
 	plug->cached_rq =3D rq_list_next(rq);
 	INIT_LIST_HEAD(&rq->queuelist);
+	rq_qos_throttle(q, *bio);
 	return rq;
 }
=20
@@ -2800,14 +2813,11 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		return;
=20
-	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
-		return;
-
-	rq_qos_throttle(q, bio);
-
-	rq =3D blk_mq_get_cached_request(q, plug, bio);
+	rq =3D blk_mq_get_cached_request(q, plug, &bio, nr_segs);
 	if (!rq) {
-		rq =3D blk_mq_get_new_requests(q, plug, bio);
+		if (!bio)
+			return;
+		rq =3D blk_mq_get_new_requests(q, plug, bio, nr_segs);
 		if (unlikely(!rq))
 			return;
 	}

--=20
Best Regards,
Shin'ichiro Kawasaki=
