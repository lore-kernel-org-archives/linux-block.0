Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934E9C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 08:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjDLIyO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 04:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjDLIyL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 04:54:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9606E8A
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 01:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+ssddzcSW/KBM6hWpWQq3AspcAriG1tFr2PX6DgOyVX0+hMAhiP6wNNMi5T2iPL0mXf+RTAfVoGZPujaavoTnJJ1rC9VRraGiHBDJ3zJcaBGN5djThPtLPFoIFVWeHuVdbl7vgiz+Z9AAPvfQjTV6HLMXlVcF5MAa04uU02u8hjcp6gNNrPm9TuzKV7BWxgLDKenLMOLB3ySrMoh09rnvFRqQQwWE5dp8A90/bvjhOve7jQywpFn/tVfLE3CZCMSpYQkc3tVH0nuNTKgX4LCl8wYJ291Rts2PF63BUDuFWiN+zOArqdd46aikuTE3sm9Vpy5brSDu0CMoquXxKVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKl+e/rslSDUERNgHTchvKvTYGi5NH31pNQyopNtU2w=;
 b=KJP9TQGafFdEi89HoWUhY0/rRrh+p8bA6/99CeZ/lcX5cKZSXolf6CnBZRGhJ3eau3LOfkoe+1Ox452u2CXpii1V4HUuEYdOqzfmQjeq+97lC/ewXRBX3uMpHV8LM2ccrgKyRK2hS67dJG1NN24jAGlNZNMVb/eRmD6rm3HCzzRfx6V1lWokaohyAP1ECPG6C/TSL2+C4QBOSczXdWfcSR+sxcKoiC41USXX6RDDcWYLAhgUnOWtFG2Vyy5Jp7wsNTe8AsoA6St3R1e2KqKjTl5Qf2NuYZwlsriMy9JUvCvV0MYGA/GMNcVaW2/swiLSkYlfB4btjy5CYFa7KNU8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKl+e/rslSDUERNgHTchvKvTYGi5NH31pNQyopNtU2w=;
 b=DNYge29mtXdMSmoP0VAMKDwulw1i5XrZPAvwerJXNZs3oB9n4/t9mxCAVZ9v7u+aczkxOxQq6UvgdcDSYlrjqLKI3dlX9Grl3xjCQLjRpOoXr/juwv8U2XiZMzeHGKWJPx5KIRZeqXB9ottnt55Niw9jiWRID46bYNehxJMBariciG9+w+uR2FIZsbbnmobF1K/xEqhFLY6PUf0mCjVUeC3f6vlfkxCqm0QlArx9ayWvOjuAUnxsKCBNNYXMKRR0/unpvvbDxuriztev/Q0zjXFwvK7ipBhJlMq3pmdM/2vN7aJ2eK1LLQgwaQ8uLtkT2ZQqA9r1cTZSN07tBOX7GA==
Received: from DM6PR14CA0067.namprd14.prod.outlook.com (2603:10b6:5:18f::44)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 08:47:51 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::a2) by DM6PR14CA0067.outlook.office365.com
 (2603:10b6:5:18f::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 08:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30 via Frontend Transport; Wed, 12 Apr 2023 08:47:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Apr 2023
 01:47:42 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Apr
 2023 01:47:41 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <kch@nvidia.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <yukuai3@huawei.com>
Subject: [PATCH 0/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Date:   Wed, 12 Apr 2023 01:47:29 -0700
Message-ID: <20230412084730.51694-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 64950331-73e3-4f72-58a6-08db3b329944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3saQBPGEX+PUUfiWRpU9X8/Ap8mSDM+d87K5v43JP4JIdH5ZYat0PaNe5xU/NfeoJ7ddSdkjk27CVLEs1zVzDvhnJHnMXcOgO6dajS4F3kXAV2XMTGoZlwpZZQcbz61H6UwxZ9ec+qpj7rhyvDKCHI/Thv8hCaVEER3U9MwcfRhneNgJsW9Pa7eWi+NG/HQtRH2M6WNQow5nh9gX3SC0Xt4SHaVK2YMPeYxxLjrWZU7vndUvuAuaw8TMiyntukD/eqTPKfaYBQyZNE2Asz3fuuNYVuxRN6pAo4aIirbzenv1EiWLTusGv0S5MGNM25cs19Tjyu7d93OJBmvFIte2X3uVENkUjEg9AIfsihJJZmKEUt0UZiDbwYxOeiLdJLBXbMKn7O/sVAwBkHkRNOkZQq3T5IcirrSO2NYiOVaZgCl9Blj7/a3jKpBfmkJRnVAHyjFQbhEGiO1IjUVfdbwqzW4r10HnA8PFzk1x3HJwaDliUDd+jGBBIB9tvqnSvjRwlG3y/NmFRN4OWdne7ijo/cE4krjQd3V/4VcjYQza9MAHTBPgzhY1XIgnxyuqX6KnFAKF1kkT/IJJGpOxmF3be2LZzAo0xfDcJeaubgTxuggj2BBjWKfcC56spqZNnEeHGChaxLkFQNxj/cMjieTN+lzbtU/QvfCEOlJGOseNNWfE1Mml83DWxRlHGbGoOZf/LaAYEtX4IkozimTcj5N5aqYsN25Jtwi7FUz24XUc/YTGLXo4boQHnimSALgZ34hTa1VN300Sp80hP1Ttn3LyQuezUV48E7ObwR6oKN4QwzE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(30864003)(8936002)(47076005)(2616005)(83380400001)(336012)(426003)(2906002)(16526019)(36756003)(186003)(356005)(7636003)(82740400003)(34070700002)(36860700001)(82310400005)(1076003)(26005)(40480700001)(6666004)(41300700001)(478600001)(54906003)(70586007)(8676002)(6916009)(4326008)(70206006)(7696005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 08:47:50.7291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64950331-73e3-4f72-58a6-08db3b329944
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

QUEUE_FLAG_NOWAIT is set by default to mq drivers such as null_blk as
a part of QUEUE_FLAG_MQ_DEFAULT that gets assigned in following code
path see blk_mq_init_allocated_queue():-

null_add_dev()
if (dev->queue_mode == NULL_Q_MQ) {
        blk_mq_alloc_disk()
          __blk_mq_alloc_disk()
	    blk_mq_init_queue_data()
              blk_mq_init_allocated_queue()
                q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
}

But it not set when null_blk is loaded with NULL_Q_BIO mode in following
code path :-

if (dev->queue_mode == NULL_Q_BIO) {
        nullb->disk = blk_alloc_disk(nullb->dev->home_node);
        	blk_alloc_disk()
        	  blk_alloc_queue()
        	  __alloc_disk_nodw()
}

Add a new module parameter nowait and respective configfs attr
that will set and clear the QUEUE_FLAG_NOWAIT based on a value set by
user in null_add_dev() irrespective of the queue mode, by default keep
it enabled to retain the original behaviour for the NULL_Q_MQ mode.

* Configfs Membacked mode:-

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT disabled:-
---------------------------------------------
configfs-qmode-0-nowait-0-fio-1.log:  read: IOPS=1295k, BW=5058MiB/s
configfs-qmode-0-nowait-0-fio-2.log:  read: IOPS=1362k, BW=5318MiB/s
configfs-qmode-0-nowait-0-fio-3.log:  read: IOPS=1332k, BW=5201MiB/s

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
configfs-qmode-0-nowait-1-fio-1.log:  read: IOPS=2095k, BW=8183MiB/s
configfs-qmode-0-nowait-1-fio-2.log:  read: IOPS=2085k, BW=8145MiB/s
configfs-qmode-0-nowait-1-fio-3.log:  read: IOPS=2036k, BW=7955MiB/s

NULL_Q_MQ mode QUEUE_FLAG_NOWAIT disabled :-
---------------------------------------------
configfs-qmode-2-nowait-0-fio-1.log:  read: IOPS=1288k, BW=5031MiB/s
configfs-qmode-2-nowait-0-fio-2.log:  read: IOPS=1239k, BW=4839MiB/s
configfs-qmode-2-nowait-0-fio-3.log:  read: IOPS=1252k, BW=4889MiB/s

NULL_Q_MQ mode QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
configfs-qmode-2-nowait-1-fio-1.log:  read: IOPS=2101k, BW=8208MiB/s
configfs-qmode-2-nowait-1-fio-2.log:  read: IOPS=2091k, BW=8169MiB/s
configfs-qmode-2-nowait-1-fio-3.log:  read: IOPS=2088k, BW=8155MiB/s

* Non Configfs non-membacked mode:-

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT disabled:-
---------------------------------------------
qmode-0-nowait-0-fio-1.log:  read: IOPS=1362k, BW=5321MiB/s
qmode-0-nowait-0-fio-2.log:  read: IOPS=1334k, BW=5210MiB/s
qmode-0-nowait-0-fio-3.log:  read: IOPS=1386k, BW=5416MiB/s

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
qmode-0-nowait-1-fio-1.log:  read: IOPS=5405k, BW=20.6GiB/s
qmode-0-nowait-1-fio-2.log:  read: IOPS=5502k, BW=21.0GiB/s
qmode-0-nowait-1-fio-3.log:  read: IOPS=5518k, BW=21.0GiB/s

NULL_Q_MQ mode QUEUE_FLAG_NOWAIT disabled :-
---------------------------------------------
qmode-2-nowait-0-fio-1.log:  read: IOPS=1356k, BW=5296MiB/s
qmode-2-nowait-0-fio-2.log:  read: IOPS=1318k, BW=5148MiB/s
qmode-2-nowait-0-fio-3.log:  read: IOPS=1252k, BW=4891MiB/s

NULL_Q_MQ mode QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
qmode-2-nowait-1-fio-1.log:  read: IOPS=5466k, BW=20.9GiB/s
qmode-2-nowait-1-fio-2.log:  read: IOPS=5446k, BW=20.8GiB/s
qmode-2-nowait-1-fio-3.log:  read: IOPS=5482k, BW=20.9GiB/s

Below is a performance test log for with and without configfs mambeacked
mode.

-ck

Chaitanya Kulkarni (1):
  null_blk: allow user to set QUEUE_FLAG_NOWAIT

 drivers/block/null_blk/main.c     | 22 +++++++++++++++++-----
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 18 insertions(+), 5 deletions(-)

Performance test log for null_blk configfs and non-configfs:-

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
  CC [M]  drivers/block/drbd/drbd_buildtag.o
  CC [M]  drivers/block/xen-blkback/blkback.o
  CC [M]  drivers/block/mtip32xx/mtip32xx.o
  CC [M]  drivers/block/zram/zcomp.o
  CC [M]  drivers/block/drbd/drbd_bitmap.o
  CC [M]  drivers/block/drbd/drbd_proc.o
  CC [M]  drivers/block/xen-blkback/xenbus.o
  CC [M]  drivers/block/zram/zram_drv.o
  CC [M]  drivers/block/drbd/drbd_worker.o
  CC [M]  drivers/block/null_blk/main.o
  CC [M]  drivers/block/drbd/drbd_receiver.o
  CC [M]  drivers/block/null_blk/trace.o
  CC [M]  drivers/block/null_blk/zoned.o
  CC [M]  drivers/block/drbd/drbd_req.o
  CC [M]  drivers/block/drbd/drbd_actlog.o
  CC [M]  drivers/block/drbd/drbd_main.o
  CC [M]  drivers/block/drbd/drbd_strings.o
  CC [M]  drivers/block/drbd/drbd_nl.o
  CC [M]  drivers/block/drbd/drbd_interval.o
  CC [M]  drivers/block/drbd/drbd_state.o
  CC [M]  drivers/block/drbd/drbd_nla.o
  CC [M]  drivers/block/drbd/drbd_debugfs.o
  LD [M]  drivers/block/zram/zram.o
  LD [M]  drivers/block/null_blk/null_blk.o
  LD [M]  drivers/block/xen-blkback/xen-blkback.o
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
  LD [M]  drivers/block/xen-blkfront.ko
  LD [M]  drivers/block/brd.ko
  LD [M]  drivers/block/xen-blkback/xen-blkback.ko
  LD [M]  drivers/block/loop.ko
  LD [M]  drivers/block/virtio_blk.ko
  LD [M]  drivers/block/mtip32xx/mtip32xx.ko
  LD [M]  drivers/block/rbd.ko
  LD [M]  drivers/block/zram/zram.ko
  LD [M]  drivers/block/nbd.ko
  LD [M]  drivers/block/drbd/drbd.ko
  LD [M]  drivers/block/floppy.ko
  LD [M]  drivers/block/null_blk/null_blk.ko
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.2M Apr 12 01:01 /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
+ test_non_configfs
+ modprobe null_blk nowait=0 queue_mode=0
+ dmesg -c
[ 9509.969343] null_blk: disk nullb0 created
[ 9509.969347] null_blk: module loaded
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-0-fio-1.log
+ for i in 1 2 3 [r(24)][100.0%][r=5415MiB/s][r=1386k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-0-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=5184MiB/s][r=1327k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-0-fio-3.log
+ modprobe -r null_blk)][100.0%][r=5525MiB/s][r=1414k IOPS][eta 00m:00s]
+ modprobe null_blk nowait=1 queue_mode=0
+ dmesg -c
[ 9570.634724] null_blk: disk nullb0 created
[ 9570.634729] null_blk: module loaded
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-1-fio-1.log
+ for i in 1 2 3 [r(24)][100.0%][r=20.8GiB/s][r=5452k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-1-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=21.3GiB/s][r=5577k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-0-nowait-1-fio-3.log
+ modprobe -r null_blk)][100.0%][r=21.1GiB/s][r=5536k IOPS][eta 00m:00s]
+ modprobe null_blk nowait=0 queue_mode=2
+ dmesg -c
[ 9631.320182] null_blk: disk nullb0 created
[ 9631.320186] null_blk: module loaded
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-2-nowait-0-fio-1.log
+ for i in 1 2 3 [r(24)][100.0%][r=6132MiB/s][r=1570k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-2-nowait-0-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=5554MiB/s][r=1422k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-2-nowait-0-fio-3.log
+ modprobe -r null_blk)][100.0%][r=5218MiB/s][r=1336k IOPS][eta 00m:00s]
+ modprobe null_blk nowait=1 queue_mode=2
+ dmesg -c
[ 9691.986330] null_blk: disk nullb0 created
[ 9691.986333] null_blk: module loaded
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-2-nowait-1-fio-1.log
+ for i in 1 2 3 [r(24)][100.0%][r=21.2GiB/s][r=5547k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-2-nowait-1-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=20.3GiB/s][r=5313k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=qmode-2-nowait-1-fio-3.log
+ modprobe -r null_blk)][100.0%][r=21.2GiB/s][r=5547k IOPS][eta 00m:00s]
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
+ for i in 1 2 3 [r(24)][100.0%][r=5174MiB/s][r=1325k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-0-nowait-0-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=5904MiB/s][r=1512k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-0-nowait-0-fio-3.log
+ rmdir config/nullb/nullb00.0%][r=5493MiB/s][r=1406k IOPS][eta 00m:00s]
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
+ for i in 1 2 3 [r(24)][100.0%][r=8265MiB/s][r=2116k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-0-nowait-1-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=8090MiB/s][r=2071k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-0-nowait-1-fio-3.log
+ rmdir config/nullb/nullb00.0%][r=7971MiB/s][r=2041k IOPS][eta 00m:00s]
+ modprobe -r null_blk
+ test_configfs 2 0
+ qmode=2
+ nowait=0
+ modprobe null_blk nr_devices=0
+ NULLB_DIR=config/nullb/nullb0
+ mkdir config/nullb/nullb0
+ echo 1
+ echo 4096
+ echo 20480
+ echo 2
+ echo 0
+ echo 1
+ '[' 0 -ne 0 ']'
+ sleep .50
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-2-nowait-0-fio-1.log
+ for i in 1 2 3 [r(24)][100.0%][r=5247MiB/s][r=1343k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-2-nowait-0-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=5132MiB/s][r=1314k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-2-nowait-0-fio-3.log
+ rmdir config/nullb/nullb00.0%][r=4960MiB/s][r=1270k IOPS][eta 00m:00s]
+ modprobe -r null_blk
+ test_configfs 2 1
+ qmode=2
+ nowait=1
+ modprobe null_blk nr_devices=0
+ NULLB_DIR=config/nullb/nullb0
+ mkdir config/nullb/nullb0
+ echo 1
+ echo 4096
+ echo 20480
+ echo 2
+ echo 1
+ echo 1
+ '[' 0 -ne 0 ']'
+ sleep .50
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-2-nowait-1-fio-1.log
+ for i in 1 2 3 [r(24)][100.0%][r=8220MiB/s][r=2104k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-2-nowait-1-fio-2.log
+ for i in 1 2 3 [r(24)][100.0%][r=8257MiB/s][r=2114k IOPS][eta 00m:00s]
+ fio fio/randread.fio --filename=/dev/nullb0 --output=configfs-qmode-2-nowait-1-fio-3.log
+ rmdir config/nullb/nullb00.0%][r=8163MiB/s][r=2090k IOPS][eta 00m:00s]
+ modprobe -r null_blk
linux-block (for-next) # 
linux-block (for-next) # 
linux-block (for-next) # 
linux-block (for-next) # 
linux-block (for-next) # grep IOPS *fio*log 
configfs-qmode-0-nowait-0-fio-1.log:  read: IOPS=1295k, BW=5058MiB/s (5303MB/s)(98.8GiB/20002msec)
configfs-qmode-0-nowait-0-fio-2.log:  read: IOPS=1362k, BW=5318MiB/s (5577MB/s)(104GiB/20002msec)
configfs-qmode-0-nowait-0-fio-3.log:  read: IOPS=1332k, BW=5201MiB/s (5454MB/s)(102GiB/20001msec)
configfs-qmode-0-nowait-1-fio-1.log:  read: IOPS=2095k, BW=8183MiB/s (8581MB/s)(160GiB/20001msec)
configfs-qmode-0-nowait-1-fio-2.log:  read: IOPS=2085k, BW=8145MiB/s (8541MB/s)(159GiB/20002msec)
configfs-qmode-0-nowait-1-fio-3.log:  read: IOPS=2036k, BW=7955MiB/s (8341MB/s)(155GiB/20001msec)
configfs-qmode-2-nowait-0-fio-1.log:  read: IOPS=1288k, BW=5031MiB/s (5275MB/s)(98.3GiB/20002msec)
configfs-qmode-2-nowait-0-fio-2.log:  read: IOPS=1239k, BW=4839MiB/s (5074MB/s)(94.5GiB/20001msec)
configfs-qmode-2-nowait-0-fio-3.log:  read: IOPS=1252k, BW=4889MiB/s (5127MB/s)(95.5GiB/20001msec)
configfs-qmode-2-nowait-1-fio-1.log:  read: IOPS=2101k, BW=8208MiB/s (8607MB/s)(160GiB/20001msec)
configfs-qmode-2-nowait-1-fio-2.log:  read: IOPS=2091k, BW=8169MiB/s (8565MB/s)(160GiB/20001msec)
configfs-qmode-2-nowait-1-fio-3.log:  read: IOPS=2088k, BW=8155MiB/s (8551MB/s)(159GiB/20001msec)
qmode-0-nowait-0-fio-1.log:  read: IOPS=1362k, BW=5321MiB/s (5579MB/s)(104GiB/20001msec)
qmode-0-nowait-0-fio-2.log:  read: IOPS=1334k, BW=5210MiB/s (5463MB/s)(102GiB/20001msec)
qmode-0-nowait-0-fio-3.log:  read: IOPS=1386k, BW=5416MiB/s (5679MB/s)(106GiB/20001msec)
qmode-0-nowait-1-fio-1.log:  read: IOPS=5405k, BW=20.6GiB/s (22.1GB/s)(412GiB/20002msec)
qmode-0-nowait-1-fio-2.log:  read: IOPS=5502k, BW=21.0GiB/s (22.5GB/s)(420GiB/20001msec)
qmode-0-nowait-1-fio-3.log:  read: IOPS=5518k, BW=21.0GiB/s (22.6GB/s)(421GiB/20002msec)
qmode-2-nowait-0-fio-1.log:  read: IOPS=1356k, BW=5296MiB/s (5554MB/s)(103GiB/20001msec)
qmode-2-nowait-0-fio-2.log:  read: IOPS=1318k, BW=5148MiB/s (5398MB/s)(101GiB/20001msec)
qmode-2-nowait-0-fio-3.log:  read: IOPS=1252k, BW=4891MiB/s (5128MB/s)(95.5GiB/20001msec)
qmode-2-nowait-1-fio-1.log:  read: IOPS=5466k, BW=20.9GiB/s (22.4GB/s)(417GiB/20001msec)
qmode-2-nowait-1-fio-2.log:  read: IOPS=5446k, BW=20.8GiB/s (22.3GB/s)(416GiB/20002msec)
qmode-2-nowait-1-fio-3.log:  read: IOPS=5482k, BW=20.9GiB/s (22.5GB/s)(418GiB/20002msec)

-- 
2.29.0

