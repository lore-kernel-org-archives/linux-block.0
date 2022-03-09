Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0E8C4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 22:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiCIWDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiCIWDn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 17:03:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553905839E
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 14:02:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B65v04jKiPPxzU09pjms93gXbf0OVZLja1nsY54fFLpDMjF0Qbd6A48ciu1h6PIRc24EEamXWv+HA12qHwqu6cDnB1agWLEPJ3aGFxLzHxYpUHXVgw8e2jyoHnwzvR2LjqDw8tdAyH1C2e5BVkPGxquwzyMIVcQEepH1ZvkuZGc2kc3C2DNoTFbbzr+pP/TzjgotQk6Ga8wE6RtfB3tkJdY8agOCSimD+JsRt57/7QcvJFbKZXcH5mE0d9cQSIbbnWrJqzREAsvSTUtveBdQelDpxlOAJJzHnHzDsvcPDJ9sDOyiR4XluA/n/NmNU6N2mqeJZ8tvD1cG5d7mZW5tvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkIzezOL0Cp0blCpYRWPwe5m8hlA3WvA84azxVs5QsU=;
 b=LGW+1qjl0K3IE7CpLkx3lZaAS/MhbkYe1DQUkc8LbSuD4zEDJQRJHptvHuMUBscJajYi8+z/14h8jf54/+2c3HunwCxgbo/KT0pF+HjvmM6dvWNI2IfpL/CNKzK/b6e76CX/xbmEF0b9b6XmqcWvpjuKdC2SSKPNHAqXpwo0VYhF6RukurQ6Tzw/mEGO1Xau2kOEtcxrDe8ZlIb6Ks7h+GvzNiGXBjOCK3t9f2d2bkRs/dhAoIXWZRF72kfMP5jiCv/j/e4do5bTv1sUSUU0WsahnL/ZhyNTzUeHhbB6st7NR30D1jGf0DABIEaaVGQs/N+bZQqgNnzNv/Vl1GroPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkIzezOL0Cp0blCpYRWPwe5m8hlA3WvA84azxVs5QsU=;
 b=jla6I2AcBx6cZdV+AM0gxgwycXDCbwvCnIwOSLH3zDEs0b0NgQlHelKFm0yEmBxlZWnilpQ8NiieQGxoK5kwNfwDXUxN23YAhqP3qnWiRleWrhtSHlg6LtYpm5kyrfrrXbJooxxqrARDpUX0DO+X2y0tiTz5zG3wdPwiFwBFfyDVtQgTc+okfKrqBAq1wzi1AdRcxAjxghtstR88JMwXVu/XgE9vSz+zwQZHx2pzV91uPrcqr45yRiN+WQIRILXGUkyNITLOXuBXxCXp0CHLLg97+AWGGsR8sX3fPGD7VTdsfWjDjXa4PphFchzrY9rH0DJ8i+QIIpo3DLhf9owmvA==
Received: from BN9PR03CA0405.namprd03.prod.outlook.com (2603:10b6:408:111::20)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 22:02:35 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::2c) by BN9PR03CA0405.outlook.office365.com
 (2603:10b6:408:111::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 22:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 22:02:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Mar
 2022 22:02:30 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Mar 2022
 14:02:29 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>, <damien.lemoal@wdc.com>,
        <ming.lei@redhat.com>, <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/1] null_blk: replace ida_simple_xxx()
Date:   Wed, 9 Mar 2022 14:02:21 -0800
Message-ID: <20220309220222.20931-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11f63e0b-af89-414e-d0a3-08da02188468
X-MS-TrafficTypeDiagnostic: CH2PR12MB4293:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4293CAA9AF13425128C828AEA30A9@CH2PR12MB4293.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DidfQ4Pz9DTBxA+NSunutbxLnjk1nKh78hB3ysh0bMtEj5xfyxkjVAS7x/bG2nALhbnFtHl/e4oUz+6GNwP77h39VA8bZIK4CCp9/K7TI35fPRi9eIP5bEi0QQQsFqKxt4ziXrnczRA8XbmlaNLyY6e1MEJ3shgL3EVHf76gYwYLiPjjMEc3OvoL0/GBvL2AA0nz5lZnWe+P1stc+6ENrkiGr+6xkNRu2WcSpezhoRkU/GqEYV6dE/WhqGaBYa4D+Bu1u9W/HDlS0DssSludrArP8XJ/MMQyqJKfazlveM+Iobyu1HQF1G3ly9ySbFxF1sJTCrDTmhV/d29OAyJaYuhQuqajlCEFooOOEsm/FRHS83qECEliNyCXQSW06/gV3oV0mg2ziWVlgzeFbwxcuWm9Tw/ePPyDr8HgIvc4mL7dmQEj94U0XclKzDFBxifdXb0YxwIFTcLJWZIEvdZEQZrkYvn5QqyOemLI0WraL7KtUie2UkMLFuJNg6k3KqKEOVGCYnt3+O2XR3e4ZAk/zye8qsk4vgxIOnsrV/SS91qi3r6D1+lWTwh+AN0y/rIGKXy5TYye/tgCppubaA+3S5J42errygsVzfQ6wQki/1ZwnI//dyz3BmWkKIFJB308F+HrsgrqyJcARDsXXgyzTmgq0+yAe5w5r4P1y5tPb7lQvdsIJZBFk3iqggM7bjG6uUJw7gPwp0nfIz075wK5atqZMDR9AKWJ8JqJqqmaP4=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(6916009)(47076005)(5660300002)(36756003)(30864003)(8936002)(4326008)(8676002)(70206006)(70586007)(2906002)(54906003)(316002)(6666004)(336012)(2616005)(426003)(16526019)(186003)(26005)(1076003)(7696005)(82310400004)(19627235002)(81166007)(40460700003)(356005)(508600001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:02:34.7779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f63e0b-af89-414e-d0a3-08da02188468
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Like various places in kernel replace deprecated ida_simple_get() and
ida_simple_remove() with ida_alloc() and ida_free().

Below is the testlog for blktests block category and fio verify job with
null_blk memory backed devices.

-ck 

Chaitanya Kulkarni (1):
  null-blk: replace deprecated ida_simple_xxx()

 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


blktests (master) # ./check block
block/001 (stress device hotplugging)                        [passed]
    runtime  107.074s  ...  42.733s
block/002 (remove a device while running blktrace)           [passed]
    runtime  1.852s  ...  0.894s
block/006 (run null-blk in blocking mode)                    [passed]
    read iops  376026    ...  9181926
    runtime    176.328s  ...  8.794s
block/009 (check page-cache coherency after BLKDISCARD)      [passed]
    runtime  0.970s  ...  0.516s
block/010 (run I/O on null_blk with shared and non-shared tags) [passed]
    Individual tags read iops  448657    ...  8516353
    runtime                    315.200s  ...  18.082s
    Shared tags read iops      450129    ...  8680489
block/014 (run null-blk with blk-mq and timeout injection configured) [not run]
    null_blk module does not have parameter timeout
block/015 (run null-blk on different schedulers with requeue injection configured) [not run]
    null_blk module does not have parameter requeue
block/016 (send a signal to a process waiting on a frozen queue) [passed]
    runtime  7.210s  ...  7.069s
block/017 (do I/O and check the inflight counter)            [passed]
    runtime  1.851s  ...  1.681s
block/018 (do I/O and check iostats times)                   [passed]
    runtime  5.321s  ...  5.100s
block/020 (run null-blk on different schedulers with only one hardware tag) [passed]
    runtime  31.852s  ...  30.984s
block/021 (read/write nr_requests on null-blk with different schedulers) [passed]
    runtime  4.031s  ...  3.932s
block/022 (Test hang caused by freeze/unfreeze sequence)     [passed]
    runtime  30.211s  ...  30.113s
block/023 (do I/O on all null_blk queue modes)               [passed]
    runtime  0.629s  ...  0.198s
block/024 (do I/O faster than a jiffy and check iostats times) [passed]
    runtime  3.046s  ...  2.685s
block/025 (do a huge discard with 4k sector size)            [passed]
    runtime  4.397s  ...  3.796s
block/027 (stress device hotplugging with running fio jobs and different schedulers) [passed]
    runtime  21.039s  ...  17.985s
block/028 (do I/O on scsi_debug with DIF/DIX enabled)        [passed]
    runtime  57.230s  ...  8.563s
block/029 (trigger blk_mq_update_nr_hw_queues())             [passed]
    runtime  30.535s  ...  30.287s
block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [not run]
    null_blk module does not have parameter init_hctx
block/031 (do IO on null-blk with a host tag set)            [passed]
    runtime  30.529s  ...  30.272s

linux-block (for-next) # git am 0001-null-blk-replace-deprecated-ida_simple_xxx.patch
Applying: null-blk: replace deprecated ida_simple_xxx()
linux-block (for-next) # ./compile_nullb.sh 
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ dmesg -c
+ modprobe -r null_blk
+ lsmod
+ grep null_blk
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/null_blk/main.o
  LD [M]  drivers/block/null_blk/null_blk.o
  MODPOST drivers/block/Module.symvers
  CC [M]  drivers/block/brd.mod.o
  CC [M]  drivers/block/drbd/drbd.mod.o
  CC [M]  drivers/block/floppy.mod.o
  CC [M]  drivers/block/loop.mod.o
  CC [M]  drivers/block/mtip32xx/mtip32xx.mod.o
  CC [M]  drivers/block/nbd.mod.o
  CC [M]  drivers/block/null_blk/null_blk.mod.o
  CC [M]  drivers/block/pktcdvd.mod.o
  CC [M]  drivers/block/rbd.mod.o
  CC [M]  drivers/block/sx8.mod.o
  CC [M]  drivers/block/virtio_blk.mod.o
  CC [M]  drivers/block/xen-blkback/xen-blkback.mod.o
  CC [M]  drivers/block/xen-blkfront.mod.o
  CC [M]  drivers/block/zram/zram.mod.o
  LD [M]  drivers/block/drbd/drbd.ko
  LD [M]  drivers/block/brd.ko
  LD [M]  drivers/block/mtip32xx/mtip32xx.ko
  LD [M]  drivers/block/nbd.ko
  LD [M]  drivers/block/virtio_blk.ko
  LD [M]  drivers/block/pktcdvd.ko
  LD [M]  drivers/block/xen-blkfront.ko
  LD [M]  drivers/block/rbd.ko
  LD [M]  drivers/block/xen-blkback/xen-blkback.ko
  LD [M]  drivers/block/zram/zram.ko
  LD [M]  drivers/block/loop.ko
  LD [M]  drivers/block/null_blk/null_blk.ko
  LD [M]  drivers/block/floppy.ko
  LD [M]  drivers/block/sx8.ko
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/5.17.0-rc7blk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/5.17.0-rc7blk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/5.17.0-rc7blk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.1M Mar  9 13:25 /lib/modules/5.17.0-rc7blk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
linux-block (for-next) # ./nullbtests.sh 4 
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ NN=4
+ modprobe -r null_blk
+ modprobe null_blk nr_devices=0
+ echo loading devices
loading devices
++ seq 0 4
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb0
+ mkdir config/nullb/nullb0
+ echo 1
+ echo 4096
+ echo 2048
+ echo 2
+ cat config/nullb/nullb0/queue_mode
2
+ echo 1
++ cat config/nullb/nullb0/index
+ IDX=0
+ echo -n ' 0 '
 0 + sleep .50
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb1
+ mkdir config/nullb/nullb1
+ echo 1
+ echo 4096
+ echo 2048
+ echo 2
+ cat config/nullb/nullb1/queue_mode
2
+ echo 1
++ cat config/nullb/nullb1/index
+ IDX=1
+ echo -n ' 1 '
 1 + sleep .50
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb2
+ mkdir config/nullb/nullb2
+ echo 1
+ echo 4096
+ echo 2048
+ echo 2
+ cat config/nullb/nullb2/queue_mode
2
+ echo 1
++ cat config/nullb/nullb2/index
+ IDX=2
+ echo -n ' 2 '
 2 + sleep .50
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb3
+ mkdir config/nullb/nullb3
+ echo 1
+ echo 4096
+ echo 2048
+ echo 2
+ cat config/nullb/nullb3/queue_mode
2
+ echo 1
++ cat config/nullb/nullb3/index
+ IDX=3
+ echo -n ' 3 '
 3 + sleep .50
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb4
+ mkdir config/nullb/nullb4
+ echo 1
+ echo 4096
+ echo 2048
+ echo 2
+ cat config/nullb/nullb4/queue_mode
2
+ echo 1
++ cat config/nullb/nullb4/index
+ IDX=4
+ echo -n ' 4 '
 4 + sleep .50
+ lsblk
+ grep null
+ sort
nullb0  251:0    0    2G  0 disk 
nullb1  251:1    0    2G  0 disk 
nullb2  251:2    0    2G  0 disk 
nullb3  251:3    0    2G  0 disk 
nullb4  251:4    0    2G  0 disk 
+ sleep 1
+ dmesg -c
[   62.827976] null_blk: loading out-of-tree module taints kernel.
[   62.828048] null_blk: module verification failed: signature and/or required key missing - tainting kernel
[   62.833367] null_blk: module loaded
+ lsblk
+ grep null
nullb0  251:0    0    2G  0 disk 
nullb1  251:1    0    2G  0 disk 
nullb2  251:2    0    2G  0 disk 
nullb3  251:3    0    2G  0 disk 
nullb4  251:4    0    2G  0 disk 
++ seq 0 4
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb0
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process

write-and-verify: (groupid=0, jobs=1): err= 0: pid=2862: Wed Mar  9 13:25:49 2022
  read: IOPS=445k, BW=1737MiB/s (1822MB/s)(158MiB/91msec)
    slat (nsec): min=1062, max=12223, avg=1349.08, stdev=315.29
    clat (nsec): min=932, max=46237, avg=33631.24, stdev=1793.19
     lat (nsec): min=2265, max=47981, avg=35022.15, stdev=1838.86
    clat percentiles (nsec):
     |  1.00th=[32128],  5.00th=[32384], 10.00th=[32384], 20.00th=[32640],
     | 30.00th=[33024], 40.00th=[33024], 50.00th=[33024], 60.00th=[33536],
     | 70.00th=[33536], 80.00th=[34048], 90.00th=[35072], 95.00th=[38144],
     | 99.00th=[40704], 99.50th=[41728], 99.90th=[44800], 99.95th=[45824],
     | 99.99th=[45824]
  write: IOPS=268k, BW=1046MiB/s (1097MB/s)(250MiB/239msec); 0 zone resets
    slat (nsec): min=2214, max=42160, avg=3124.73, stdev=1051.23
    clat (nsec): min=771, max=116021, avg=56206.26, stdev=14239.21
     lat (usec): min=3, max=131, avg=59.39, stdev=15.00
    clat percentiles (usec):
     |  1.00th=[   47],  5.00th=[   47], 10.00th=[   48], 20.00th=[   49],
     | 30.00th=[   49], 40.00th=[   50], 50.00th=[   50], 60.00th=[   51],
     | 70.00th=[   52], 80.00th=[   58], 90.00th=[   88], 95.00th=[   91],
     | 99.00th=[  100], 99.50th=[  103], 99.90th=[  109], 99.95th=[  110],
     | 99.99th=[  115]
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=68.57%, 100=30.79%
  lat (usec)   : 250=0.63%
  cpu          : usr=48.02%, sys=51.67%, ctx=0, majf=0, minf=966
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40470,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1737MiB/s (1822MB/s), 1737MiB/s-1737MiB/s (1822MB/s-1822MB/s), io=158MiB (166MB), run=91-91msec
  WRITE: bw=1046MiB/s (1097MB/s), 1046MiB/s-1046MiB/s (1097MB/s-1097MB/s), io=250MiB (262MB), run=239-239msec

Disk stats (read/write):
  nullb0: ios=0/35688, merge=0/0, ticks=0/30, in_queue=30, util=58.85%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb1
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process

write-and-verify: (groupid=0, jobs=1): err= 0: pid=2865: Wed Mar  9 13:25:50 2022
  read: IOPS=455k, BW=1776MiB/s (1862MB/s)(158MiB/89msec)
    slat (nsec): min=1052, max=14828, avg=1334.48, stdev=311.47
    clat (nsec): min=932, max=46809, avg=33151.56, stdev=1804.86
     lat (nsec): min=2225, max=48121, avg=34528.03, stdev=1852.32
    clat percentiles (nsec):
     |  1.00th=[31616],  5.00th=[31616], 10.00th=[31872], 20.00th=[32128],
     | 30.00th=[32384], 40.00th=[32384], 50.00th=[32640], 60.00th=[33024],
     | 70.00th=[33024], 80.00th=[33536], 90.00th=[35072], 95.00th=[37632],
     | 99.00th=[40192], 99.50th=[40704], 99.90th=[43776], 99.95th=[44800],
     | 99.99th=[46848]
  write: IOPS=275k, BW=1073MiB/s (1125MB/s)(250MiB/233msec); 0 zone resets
    slat (nsec): min=2114, max=43754, avg=3045.27, stdev=1031.67
    clat (nsec): min=721, max=126910, avg=54771.05, stdev=14107.80
     lat (usec): min=3, max=132, avg=57.87, stdev=14.86
    clat percentiles (usec):
     |  1.00th=[   45],  5.00th=[   46], 10.00th=[   47], 20.00th=[   48],
     | 30.00th=[   48], 40.00th=[   49], 50.00th=[   49], 60.00th=[   50],
     | 70.00th=[   51], 80.00th=[   56], 90.00th=[   87], 95.00th=[   91],
     | 99.00th=[   99], 99.50th=[  102], 99.90th=[  110], 99.95th=[  112],
     | 99.99th=[  124]
  lat (nsec)   : 750=0.01%, 1000=0.01%
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=77.56%, 100=21.97%
  lat (usec)   : 250=0.46%
  cpu          : usr=48.60%, sys=51.40%, ctx=0, majf=0, minf=966
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40465,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1776MiB/s (1862MB/s), 1776MiB/s-1776MiB/s (1862MB/s-1862MB/s), io=158MiB (166MB), run=89-89msec
  WRITE: bw=1073MiB/s (1125MB/s), 1073MiB/s-1073MiB/s (1125MB/s-1125MB/s), io=250MiB (262MB), run=233-233msec

Disk stats (read/write):
  nullb1: ios=0/38401, merge=0/0, ticks=0/31, in_queue=31, util=60.08%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb2
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process

write-and-verify: (groupid=0, jobs=1): err= 0: pid=2868: Wed Mar  9 13:25:50 2022
  read: IOPS=426k, BW=1663MiB/s (1744MB/s)(158MiB/95msec)
    slat (nsec): min=1082, max=11932, avg=1424.57, stdev=381.94
    clat (nsec): min=952, max=73750, avg=35268.03, stdev=2448.22
     lat (nsec): min=2254, max=75514, avg=36739.98, stdev=2516.34
    clat percentiles (nsec):
     |  1.00th=[33024],  5.00th=[33536], 10.00th=[33536], 20.00th=[34048],
     | 30.00th=[34048], 40.00th=[34560], 50.00th=[34560], 60.00th=[35072],
     | 70.00th=[35072], 80.00th=[35584], 90.00th=[37120], 95.00th=[40192],
     | 99.00th=[45312], 99.50th=[50432], 99.90th=[57600], 99.95th=[61184],
     | 99.99th=[71168]
  write: IOPS=259k, BW=1012MiB/s (1061MB/s)(250MiB/247msec); 0 zone resets
    slat (nsec): min=2214, max=32622, avg=3230.35, stdev=1091.64
    clat (nsec): min=621, max=126089, avg=57938.70, stdev=14139.18
     lat (usec): min=3, max=131, avg=61.23, stdev=14.89
    clat percentiles (usec):
     |  1.00th=[   47],  5.00th=[   49], 10.00th=[   50], 20.00th=[   50],
     | 30.00th=[   51], 40.00th=[   52], 50.00th=[   52], 60.00th=[   53],
     | 70.00th=[   55], 80.00th=[   60], 90.00th=[   89], 95.00th=[   92],
     | 99.00th=[  103], 99.50th=[  106], 99.90th=[  116], 99.95th=[  121],
     | 99.99th=[  126]
  lat (nsec)   : 750=0.01%, 1000=0.01%
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=50.54%, 100=48.53%
  lat (usec)   : 250=0.92%
  cpu          : usr=45.59%, sys=54.12%, ctx=1, majf=0, minf=966
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40444,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1663MiB/s (1744MB/s), 1663MiB/s-1663MiB/s (1744MB/s-1744MB/s), io=158MiB (166MB), run=95-95msec
  WRITE: bw=1012MiB/s (1061MB/s), 1012MiB/s-1012MiB/s (1061MB/s-1061MB/s), io=250MiB (262MB), run=247-247msec

Disk stats (read/write):
  nullb2: ios=0/35202, merge=0/0, ticks=0/31, in_queue=31, util=59.59%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb3
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process

write-and-verify: (groupid=0, jobs=1): err= 0: pid=2871: Wed Mar  9 13:25:51 2022
  read: IOPS=454k, BW=1774MiB/s (1860MB/s)(158MiB/89msec)
    slat (nsec): min=1052, max=18965, avg=1330.48, stdev=327.51
    clat (nsec): min=932, max=50977, avg=33145.60, stdev=1853.80
     lat (nsec): min=2466, max=52239, avg=34517.16, stdev=1902.39
    clat percentiles (nsec):
     |  1.00th=[31360],  5.00th=[31616], 10.00th=[31872], 20.00th=[32128],
     | 30.00th=[32384], 40.00th=[32384], 50.00th=[32640], 60.00th=[33024],
     | 70.00th=[33024], 80.00th=[33536], 90.00th=[35072], 95.00th=[37632],
     | 99.00th=[40192], 99.50th=[41216], 99.90th=[45312], 99.95th=[46848],
     | 99.99th=[50944]
  write: IOPS=271k, BW=1059MiB/s (1111MB/s)(250MiB/236msec); 0 zone resets
    slat (nsec): min=2154, max=25269, avg=3073.42, stdev=1039.66
    clat (nsec): min=672, max=125849, avg=55367.59, stdev=14444.12
     lat (usec): min=3, max=130, avg=58.50, stdev=15.21
    clat percentiles (usec):
     |  1.00th=[   45],  5.00th=[   46], 10.00th=[   47], 20.00th=[   48],
     | 30.00th=[   48], 40.00th=[   49], 50.00th=[   50], 60.00th=[   50],
     | 70.00th=[   52], 80.00th=[   57], 90.00th=[   87], 95.00th=[   91],
     | 99.00th=[  100], 99.50th=[  102], 99.90th=[  109], 99.95th=[  112],
     | 99.99th=[  122]
  lat (nsec)   : 750=0.01%, 1000=0.01%
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=76.05%, 100=23.34%
  lat (usec)   : 250=0.60%
  cpu          : usr=47.84%, sys=51.85%, ctx=1, majf=0, minf=965
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40416,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1774MiB/s (1860MB/s), 1774MiB/s-1774MiB/s (1860MB/s-1860MB/s), io=158MiB (166MB), run=89-89msec
  WRITE: bw=1059MiB/s (1111MB/s), 1059MiB/s-1059MiB/s (1111MB/s-1111MB/s), io=250MiB (262MB), run=236-236msec

Disk stats (read/write):
  nullb3: ios=0/35934, merge=0/0, ticks=0/29, in_queue=29, util=59.09%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb4
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process

write-and-verify: (groupid=0, jobs=1): err= 0: pid=2876: Wed Mar  9 13:25:51 2022
  read: IOPS=444k, BW=1733MiB/s (1817MB/s)(158MiB/91msec)
    slat (nsec): min=1062, max=10130, avg=1342.86, stdev=297.90
    clat (nsec): min=952, max=51177, avg=33670.92, stdev=1803.05
     lat (nsec): min=2214, max=52590, avg=35055.68, stdev=1845.21
    clat percentiles (nsec):
     |  1.00th=[31872],  5.00th=[32128], 10.00th=[32384], 20.00th=[32640],
     | 30.00th=[33024], 40.00th=[33024], 50.00th=[33024], 60.00th=[33536],
     | 70.00th=[33536], 80.00th=[34048], 90.00th=[35072], 95.00th=[38144],
     | 99.00th=[40704], 99.50th=[41728], 99.90th=[44288], 99.95th=[46336],
     | 99.99th=[47872]
  write: IOPS=268k, BW=1046MiB/s (1097MB/s)(250MiB/239msec); 0 zone resets
    slat (nsec): min=2174, max=36739, avg=3118.08, stdev=1032.84
    clat (nsec): min=681, max=114448, avg=56228.67, stdev=14207.31
     lat (usec): min=3, max=129, avg=59.40, stdev=14.96
    clat percentiles (usec):
     |  1.00th=[   47],  5.00th=[   48], 10.00th=[   48], 20.00th=[   49],
     | 30.00th=[   49], 40.00th=[   50], 50.00th=[   50], 60.00th=[   51],
     | 70.00th=[   52], 80.00th=[   57], 90.00th=[   88], 95.00th=[   91],
     | 99.00th=[  101], 99.50th=[  103], 99.90th=[  109], 99.95th=[  111],
     | 99.99th=[  113]
  lat (nsec)   : 750=0.01%, 1000=0.01%
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=67.98%, 100=31.30%
  lat (usec)   : 250=0.70%
  cpu          : usr=46.81%, sys=52.89%, ctx=0, majf=0, minf=963
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40366,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1733MiB/s (1817MB/s), 1733MiB/s-1733MiB/s (1817MB/s-1817MB/s), io=158MiB (165MB), run=91-91msec
  WRITE: bw=1046MiB/s (1097MB/s), 1046MiB/s-1046MiB/s (1097MB/s-1097MB/s), io=250MiB (262MB), run=239-239msec

Disk stats (read/write):
  nullb4: ios=0/36626, merge=0/0, ticks=0/31, in_queue=31, util=59.51%


-- 
2.29.0

