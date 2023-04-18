Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F6DC77B71
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 04:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDREYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 00:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDREYm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 00:24:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02559D
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 21:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWhcD9JemPS4hCoigdXl5dzimDRzEAu5REGg/FMhEJBTtYpyxhAfIdtiqx31dEEf+Plt9d2cvDdsUoInWWbskU/OXf0at75T/IIpTIWlLY3HLDsJjH7fSwiuZhjT+OsHdv8oK88kariISFdZZ5AzvqTqq3AiAfY1gz5lz+Z9qQEHsIKMcfhXhejCplYpjHAKTzSMYF2kdfgWlkyA0P8tstpm17EZoeLVwEZEpq4hznszuATeB6RA4Fqw408mjuC+5LlPgxGMvyXw0NSVCjO/OMfLGEVToWAvTDH2murMku0KuJEKbW3uBPI5QQfModX3egrKoVg4ry1NQeXiyuOrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb2X9OwWR70bVUOK3h0P0mUu0FvbUweQ8bohMK45lfA=;
 b=WkNNyXL0+x+jFb+5SfEWQ8jmmuHzawIdoe89ylNvi2SeVnHETzwBP1QuH2BqUEqd/gKC8A0erFACyW0bRpAfKNuk50Ppfj7Qz031KTsGh3qOr3piHjBpZnRfKBe2B8RKJHDONYh0R9m3IBS73rf0G6QwGhfiRVhq38n4as+NsQJ2Iq8HwfNr9CBlAIy4SBh89JceMXfCk1kwuti46GIgY8F/x2JmUWpsvdxL+iCSMatimqicBCutZVhrgRwA8VcIywdRnmjxI0TQh32LplkRKwHyZb1N91/FYKiep7o4wh7sn1GH56Fv9KMa98a4GbeAkRMQk5+2Cwm+JbALceyzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb2X9OwWR70bVUOK3h0P0mUu0FvbUweQ8bohMK45lfA=;
 b=iDM5nz7qqFuZV7PUpdFV142X6ik+9dnhgWHG4r+Dv2ltbEpneJ8+lapCS9En2WXQ6N7gaHtzqfi4rln23ZrgaVCGKa5nJOSfX8NzAxUwleZaIGyD3A6+7qnflLu/Gb71vA8xpaoCF5D1r5athCSO3Yy7Rj/CaVjbD7SfdZfyNOu3Y5Yz2D7cemBSCan2/fHQWDl1NvXNJL9/vf+VwyTO8yn88BAyYbs5cZFa1R7JR6JKoAwU9rm59lNqhZz6AiGuS9vWiCGqGABR0Egn+mHH8ujJuRQXUzXVcLi1kXEH+WuNZukeh3TQ6pRdKOVHSmIQBCnBXEZuNPemAsERw0Vw3w==
Received: from DS7PR05CA0063.namprd05.prod.outlook.com (2603:10b6:8:57::19) by
 PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Tue, 18 Apr 2023 04:24:38 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::84) by DS7PR05CA0063.outlook.office365.com
 (2603:10b6:8:57::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 04:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 04:24:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Apr 2023
 21:24:27 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 17 Apr
 2023 21:24:26 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <dlemoal@kernel.org>, <kch@nvidia.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <vincent.fu@samsung.com>, <shinichiro.kawasaki@wdc.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V2 0/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Date:   Mon, 17 Apr 2023 21:24:19 -0700
Message-ID: <20230418042420.93629-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb8b44e-218d-4d43-9bb1-08db3fc4d286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYiwQSY4KB/269bzr2O4ECkOWsdRmWG6DE+4fR1vq47XX1MgDZfbrHAcFLyJmbtXvvV3JTAbVihVLQA7AfquO+WcRZSn2pyQN43rsMwKg5aP5/KnnSftT/m/3b+xcAyms0vyN6LKnZBtz+23RrC1AxTqo+TrF+aTQ1G5Zsjr1mIp7er41qJO78zsF97lldZslvB28TReWlkeTXTmFldc8PveBZ+fqorB0CWjf5az3N4PawXr32efdRRxTABdsP2txKJc75TXLJ14Lu43lXyvh7XmWmaiMpUjwoJqE6JQJXJfrMo0zxCogTSCsoluh0I0iN5USWhdaY2PaJAW5eFdeGNv0GbCRqV8Ly/nERV/KfjCzrTIzL6bMZ/b9o3/4cp5smrQSw1B1PnRPgqjxXrX1f7wwwHa4rdhlX94B3H/f6Adx1TNo47u7hK84TpFgo6nfRaaTbVhuhSzPV2u2ajkuSl0CRtYko3Gr4OTCdKyxJuDG4JOjfKIA4ixwl4kZYlokEwSH4JE4yzVm7CtEM504eA3+tw5cdapiYDlcHxhmMUF/th73Zf889f1kzKWKgcNLIGR6SCFOzEXmRT9K6KhhLrdE/3wYfAz+21MqSNExXS+62thudRoJvKuB1dPD7Fn1r0TY6MwG2HSjtwrupmhg/wfMdNPONGEOPsjG2LQWkapCc7xgUWJCR0xEb8ZKxHB8cq/YrkrL3dEe5RH0E3MKrkTyYoKlTpEL0mxqH1bkng9dCj5MmVTXj2xjQfg/FmAy6FDVzEnQdKJjHqOywAK0X1q4wyGOUSfAKKAzTiXM3G+jm0UompUL+TaRUGIYCbxBHNfqYkwVC7LJCIzoY7mvg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(5660300002)(966005)(82310400005)(8936002)(30864003)(40460700003)(7696005)(54906003)(316002)(34020700004)(41300700001)(40480700001)(478600001)(70206006)(8676002)(4326008)(6916009)(70586007)(36756003)(82740400003)(356005)(7636003)(2616005)(36860700001)(1076003)(2906002)(26005)(16526019)(186003)(336012)(47076005)(83380400001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 04:24:37.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb8b44e-218d-4d43-9bb1-08db3fc4d286
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

QUEUE_FLAG_NOWAIT is set by default to mq drivers such null_blk when
it is used with NULL_Q_MQ mode as a part of QUEUE_FLAG_MQ_DEFAULT that
gets assigned in following code path see blk_mq_init_allocated_queue():-

null_add_dev()
if (dev->queue_mode == NULL_Q_MQ) {
        blk_mq_alloc_disk()
          __blk_mq_alloc_disk()
	    blk_mq_init_queue_data()
              blk_mq_init_allocated_queue()
                q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
}

But it is not set when null_blk is loaded with NULL_Q_BIO mode in following
code path like other bio drivers do e.g. nvme-multipath :-

if (dev->queue_mode == NULL_Q_BIO) {
        nullb->disk = blk_alloc_disk(nullb->dev->home_node);
        	blk_alloc_disk()
        	  blk_alloc_queue()
        	  __alloc_disk_nodw()
}

Add a new module parameter nowait and respective configfs attr that will
set or clear the QUEUE_FLAG_NOWAIT based on a value set by user in
null_add_dev() when queue_mode is set to NULL_Q_BIO, by default keep it
disabled to retain the original behaviour for the NULL_Q_BIO mode.

Depending on nowait value, use GFP_NOWAIT or GFP_NOIO for the alloction
in the null_alloc_page() for alloc_pages() and in null_insert_page()
for radix_tree_preload() only when queue_mode is NULL_Q_BIO.

Observed performance difference with this patch for fio iouring with
configfs and non configfs null_blk with queue modes NULL_Q_BIO:-

* Configfs non-membacked mode:-

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT disabled :-
---------------------------------------------
configfs-qmode-0-nowait-0-fio-1.log:  read: IOPS=1299k, BW=5076MiB/s
configfs-qmode-0-nowait-0-fio-2.log:  read: IOPS=1250k, BW=4884MiB/s
configfs-qmode-0-nowait-0-fio-3.log:  read: IOPS=1251k, BW=4888MiB/s


NULL_Q_BIO mode QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
configfs-qmode-0-nowait-1-fio-1.log:  read: IOPS=5469k, BW=20.9GiB/s
configfs-qmode-0-nowait-1-fio-2.log:  read: IOPS=5525k, BW=21.1GiB/s
configfs-qmode-0-nowait-1-fio-3.log:  read: IOPS=5561k, BW=21.2GiB/s

* Non Configfs non-membacked mode:-

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT disabled :-
---------------------------------------------
qmode-0-nowait-0-fio-1.log:  read: IOPS=1261k, BW=4924MiB/s
qmode-0-nowait-0-fio-2.log:  read: IOPS=1295k, BW=5060MiB/s
qmode-0-nowait-0-fio-3.log:  read: IOPS=1280k, BW=4999MiB/s

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
qmode-0-nowait-1-fio-1.log:  read: IOPS=5521k, BW=21.1GiB/s
qmode-0-nowait-1-fio-2.log:  read: IOPS=5524k, BW=21.1GiB/s
qmode-0-nowait-1-fio-3.log:  read: IOPS=5541k, BW=21.1GiB/s

Below is a performance test log for with and without configfs mambeacked
mode.

Please note that this patch is generated on the top of previously
posted patch for null_blk queue_mode Oops :-
https://marc.info/?l=linux-block&m=168168262517700&w=2

-ck

V2:-

Only allow setting QUEUE_FLAG_NOWAIT when qmode is set to NULL_Q_BIO.


Chaitanya Kulkarni (1):
  null_blk: allow user to set QUEUE_FLAG_NOWAIT

 drivers/block/null_blk/main.c     | 33 ++++++++++++++++++++++++++-----
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 29 insertions(+), 5 deletions(-)

linux-block (for-next) # sh test-null-blk-no-wait.sh
+ modprobe -r null_blk
+ ./compile_nullb.sh
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ dmesg -c
+ modprobe -r null_blk
+ lsmod
+ grep null_blk
++ nproc
+ make -j 48 M=drivers/block/ clean
  CLEAN   drivers/block/Module.symvers
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/floppy.o
  CC [M]  drivers/block/brd.o
  CC [M]  drivers/block/loop.o
  CC [M]  drivers/block/nbd.o
  CC [M]  drivers/block/virtio_blk.o
  CC [M]  drivers/block/xen-blkfront.o
  CC [M]  drivers/block/rbd.o
  CC [M]  drivers/block/mtip32xx/mtip32xx.o
  CC [M]  drivers/block/drbd/drbd_buildtag.o
  CC [M]  drivers/block/drbd/drbd_bitmap.o
  CC [M]  drivers/block/drbd/drbd_proc.o
  CC [M]  drivers/block/drbd/drbd_worker.o
  CC [M]  drivers/block/zram/zcomp.o
  CC [M]  drivers/block/null_blk/main.o
  CC [M]  drivers/block/drbd/drbd_receiver.o
  CC [M]  drivers/block/xen-blkback/blkback.o
  CC [M]  drivers/block/null_blk/trace.o
  CC [M]  drivers/block/zram/zram_drv.o
  CC [M]  drivers/block/null_blk/zoned.o
  CC [M]  drivers/block/drbd/drbd_req.o
  CC [M]  drivers/block/drbd/drbd_main.o
  CC [M]  drivers/block/drbd/drbd_actlog.o
  CC [M]  drivers/block/drbd/drbd_strings.o
  CC [M]  drivers/block/xen-blkback/xenbus.o
  CC [M]  drivers/block/drbd/drbd_nl.o
  CC [M]  drivers/block/drbd/drbd_interval.o
  CC [M]  drivers/block/drbd/drbd_state.o
  CC [M]  drivers/block/drbd/drbd_nla.o
  CC [M]  drivers/block/drbd/drbd_debugfs.o
  LD [M]  drivers/block/zram/zram.o
  LD [M]  drivers/block/xen-blkback/xen-blkback.o
  LD [M]  drivers/block/null_blk/null_blk.o
  LD [M]  drivers/block/drbd/drbd.o
  MODPOST drivers/block/Module.symvers
  CC [M]  drivers/block/floppy.mod.o
  CC [M]  drivers/block/brd.mod.o
  CC [M]  drivers/block/loop.mod.o
  CC [M]  drivers/block/nbd.mod.o
  CC [M]  drivers/block/virtio_blk.mod.o
  CC [M]  drivers/block/xen-blkfront.mod.o
  CC [M]  drivers/block/xen-blkback/xen-blkback.mod.o
  CC [M]  drivers/block/drbd/drbd.mod.o
  CC [M]  drivers/block/rbd.mod.o
  CC [M]  drivers/block/mtip32xx/mtip32xx.mod.o
  CC [M]  drivers/block/zram/zram.mod.o
  CC [M]  drivers/block/null_blk/null_blk.mod.o
  LD [M]  drivers/block/nbd.ko
  LD [M]  drivers/block/brd.ko
  LD [M]  drivers/block/null_blk/null_blk.ko
  LD [M]  drivers/block/loop.ko
  LD [M]  drivers/block/floppy.ko
  LD [M]  drivers/block/xen-blkfront.ko
  LD [M]  drivers/block/zram/zram.ko
  LD [M]  drivers/block/mtip32xx/mtip32xx.ko
  LD [M]  drivers/block/drbd/drbd.ko
  LD [M]  drivers/block/virtio_blk.ko
  LD [M]  drivers/block/rbd.ko
  LD [M]  drivers/block/xen-blkback/xen-blkback.ko
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.2M Apr 16 00:27 /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
+ test_non_configfs
+ modprobe null_blk nowait=0 queue_mode=0
+ dmesg -c
[ 2899.900308] null_blk: disk nullb0 created
[ 2899.900311] null_blk: module loaded
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-0-fio-1.log
+ for i in 1 2 3 [r(24)][100.0%][r=5060MiB/s][r=1295k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-0-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=5420MiB/s][r=1387k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-0-fio-3.log
+ modprobe -r null_blk)][100.0%][r=5198MiB/s][r=1331k IOPS][eta 00m:00s]
+ modprobe null_blk nowait=1 queue_mode=0
+ dmesg -c
[ 2960.569964] null_blk: disk nullb0 created
[ 2960.569975] null_blk: module loaded
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-1-fio-1.log
+ for i in 1 2 3 [r(24)][100.0%][r=21.3GiB/s][r=5572k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-1-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=21.0GiB/s][r=5518k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-1-fio-3.log
+ modprobe -r null_blk)][100.0%][r=20.8GiB/s][r=5459k IOPS][eta 00m:00s]
+ test_configfs 0 0
+ qmode=0
+ nowait=0
+ modprobe null_blk nr_devices=0
+ NULLB_DIR=config/nullb/nullb0
+ mkdir config/nullb/nullb0
+ echo 1
+ echo 4096
+ echo 20480
+ echo 0
+ echo 0
+ echo 1
+ '[' 0 -ne 0 ']'
+ sleep .50
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-0-nowait-0-fio-1.log
+ for i in 1 2 3 [r(24)][100.0%][r=5001MiB/s][r=1280k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-0-nowait-0-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=4684MiB/s][r=1199k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-0-nowait-0-fio-3.log
+ rmdir config/nullb/nullb00.0%][r=4829MiB/s][r=1236k IOPS][eta 00m:00s]
+ modprobe -r null_blk
+ test_configfs 0 1
+ qmode=0
+ nowait=1
+ modprobe null_blk nr_devices=0
+ NULLB_DIR=config/nullb/nullb0
+ mkdir config/nullb/nullb0
+ echo 1
+ echo 4096
+ echo 20480
+ echo 0
+ echo 1
+ echo 1
+ '[' 0 -ne 0 ']'
+ sleep .50
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-0-nowait-1-fio-1.log
+ for i in 1 2 3 [r(24)][100.0%][r=8289MiB/s][r=2122k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-0-nowait-1-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=8278MiB/s][r=2119k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-0-nowait-1-fio-3.log
+ rmdir config/nullb/nullb00.0%][r=7908MiB/s][r=2024k IOPS][eta 00m:00s]
+ modprobe -r null_blk
linux-block (for-next) # grep IOPS *fio*log
configfs-qmode-0-nowait-0-fio-1.log:  read: IOPS=1267k, BW=4950MiB/s (5190MB/s)(96.7GiB/20002msec)
configfs-qmode-0-nowait-0-fio-2.log:  read: IOPS=1225k, BW=4783MiB/s (5016MB/s)(93.4GiB/20001msec)
configfs-qmode-0-nowait-0-fio-3.log:  read: IOPS=1250k, BW=4884MiB/s (5121MB/s)(95.4GiB/20002msec)
configfs-qmode-0-nowait-1-fio-1.log:  read: IOPS=2096k, BW=8189MiB/s (8587MB/s)(160GiB/20001msec)
configfs-qmode-0-nowait-1-fio-2.log:  read: IOPS=2108k, BW=8233MiB/s (8633MB/s)(161GiB/20002msec)
configfs-qmode-0-nowait-1-fio-3.log:  read: IOPS=2061k, BW=8049MiB/s (8440MB/s)(157GiB/20002msec)
qmode-0-nowait-0-fio-1.log:  read: IOPS=1321k, BW=5158MiB/s (5409MB/s)(101GiB/20001msec)
qmode-0-nowait-0-fio-2.log:  read: IOPS=1266k, BW=4945MiB/s (5186MB/s)(96.6GiB/20001msec)
qmode-0-nowait-0-fio-3.log:  read: IOPS=1313k, BW=5129MiB/s (5378MB/s)(100GiB/20002msec)
qmode-0-nowait-1-fio-1.log:  read: IOPS=5511k, BW=21.0GiB/s (22.6GB/s)(421GiB/20002msec)
qmode-0-nowait-1-fio-2.log:  read: IOPS=5506k, BW=21.0GiB/s (22.6GB/s)(420GiB/20002msec)
qmode-0-nowait-1-fio-3.log:  read: IOPS=5508k, BW=21.0GiB/s (22.6GB/s)(420GiB/20002msec)
linux-block (for-next) #

-- 
2.40.0

