Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A12C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 19:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjC1T5q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjC1T5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 15:57:44 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA640CF
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDA5LUZLXt60QBm/s0SDBV8iehVkvrKz2GDdSck2e6mIUnCfAjmsWm+TG8q3VkhaU0CcynW89KkhmuuGbSpqF+R5hBf9QPhBbOFcfaQz2q5sAZ4KYSw8yhcOrklpGMq8UpEM6Xj3ry988zTs4uXGJqpHxuxw9adK2fk22j6VooNRmsKSapUin14F9Gv46YYiN3OU4QAvtky9qZTLFrhIVLaZ1v7yNgoXOjmwL5KwRcNlJUoUNwKvh7tKqcrOZvHfbxTMpluzMfJJnSkDgXLJ0idirXpNT0M+kZ4KQ6qUywVuRmQS+aVVFpbMmOP+Fl4DnaUMp4kmKrKYIY7dXa5Ljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqBTZ6EiHBzLK4aXoaVmZgMJHm1UhKBv8LwMPkqQ0Zo=;
 b=bbSTmd8dLQG8XWYDPvdHaowavndy5TqvJybOXIilQ5DxM0rF1Dc2tuTO4RoBgNtvrd1Ap7XJHOtMBIwe+6t5AVWN2Wga1Jioaj78arduy8k2pZIfyk4ticmdmdpAZvADfF2UQyJXyZzPV0TL281b0fUY1UmRecCLpY4RUzEJbG0wh3x1hsjchpwvyEtI7K3W1Dk6kgCkND9gp/1grnTi1eGDqDDcJqRpMzP6y8XlY4rGpsXy16D5LFa/I19xJYUVAFqgtVyjXJnK2gVmsBbLzok75e3gUjwSzlGqbYJ0BYIgBrhEul+opoprfHV4bePARBGCPDu8eBM/5iB5ORMIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqBTZ6EiHBzLK4aXoaVmZgMJHm1UhKBv8LwMPkqQ0Zo=;
 b=pGO+0TJ4Gr3unnQMM57/mVgZxGiDeUyG7vB0jhVaSb78d3Ao6FDuLpnYYbMNnVia5VyiGruJh93vWhfpNCu4DlRFEnqL0xh4685Izej60PmZu3ra1P2xV1XESnzSxqRndT/A33fWItm+RQ6d/OWoMrFaTVJcc0ItKNDCD9jtJ1vAfvjYu8TjEibGtMTFo52kKYp34hKhhDtHkGCxqsSbSjhTzdSbbA41QXvWKOGhZQwZatq/3Qm2wJwTvKrkoQoYESRppKsEEdujg4LT2Wh1dABJwCelf0/hlrIqID6kUHlhs8g+Fdx7wrJ3J9WYTaGsXMoMqTe4t9NxsCuMuAgYzA==
Received: from BN0PR04CA0036.namprd04.prod.outlook.com (2603:10b6:408:e8::11)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 19:56:49 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::c6) by BN0PR04CA0036.outlook.office365.com
 (2603:10b6:408:e8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 19:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 19:56:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 28 Mar 2023
 12:56:33 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 28 Mar
 2023 12:56:32 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/4] brd: usr memcpy_[to|from]_page() in brd
Date:   Tue, 28 Mar 2023 12:56:22 -0700
Message-ID: <20230328195626.12075-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d333e4-f76e-4a7e-8bc2-08db2fc691b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbMfbVY3imtakNJe/6xHU6CXEgC0LYYfmPb8UKnURg4lYUxwIyviFkk4LrgpqiLBpcTCBKH0TfsTLt2JWuO+gVJ//FvfAsaoHtMYUC+jEWzugyLMc6ygymgdyOMFHYGYSXN4LJSKUbSNE6+1rWiWFjLT//4jy38Jg+ZCbU8Qo+6an4kN/Bijq/Spd5NBkZ7iUuoh28WvXb60m/awmxh4dLMlenhaQLN+TI5B14PbvZTf1rt5dOYnUtXNfTEjuCzIKjj55DvE3Ya3Z8QMqA/7+z5YtdlZmILUXqe7U1ok24hGiYRCisXbt9Cfh6+Z1QIzCgwQHufZh4lPUQDNnNq+diQCrIi2hIp1nG7CLgDSJFdiIWOYIkPgGRTAxSJBGQ+1+O8aUqzoumsR5goX1szKLjWgG6ICxeUXXg1QSgM+8FyrxmYqR/4qZypdd0Eb/mi3ie8lbm+5Rm4U0diem6m3E+ys8zyNPsvUTKu74JhvIh1tCLiwSc1toEJWW3IlU0kMcEwuyTKDO8JpH8qYoEoP3wjAmxzlz8QISpheHXvM0fX+wQ738NAh8XDVnvB6F4KQ4Muai5KKfq7CWX9PzXISfzGSNtMJQcMyEGd80mKKONgZuvVmL1wTqaeAqeJUHmeDRcsIZ3OdWNInnlAJcrKkdtjJf9yz+oQrYeLa26ZFzhWOwfXnvSkZS86XqYbcqSqHQ5VA1RwLdg6ATgH9Eaeiz4FzN7EAzSxIIU7dgFyvatxd3vKxCjgnYnLyYBr4zlO4e+Q8xLFTLBlFwAlruWTXsRhZRO8dqAuNPZxWgc02WL4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(30864003)(2906002)(82740400003)(4326008)(41300700001)(8936002)(5660300002)(356005)(426003)(40480700001)(36756003)(82310400005)(40460700003)(7636003)(478600001)(1076003)(6916009)(54906003)(316002)(19627235002)(7696005)(6666004)(107886003)(26005)(70586007)(83380400001)(2616005)(8676002)(336012)(70206006)(186003)(34020700004)(16526019)(36860700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 19:56:49.5715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d333e4-f76e-4a7e-8bc2-08db2fc691b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

From :include/linux/highmem.h:
"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Use memcpy_from_page() since does the same job of mapping, copying, and
unmaping except it uses non deprecated kmap_local_page() and
kunmap_local(). Following are the differences between kmal_local_page()
and kmap_atomic() :-

* creates local mapping per thread, local to CPU & not globally visible
* allows to be called from any context
* allows task preemption 

There is a slight performance difference observed with the use of new
API on the one arch I've tested with two different sets :-

Set 1 (Average of 3 runs) :-
-----------------------------
* Latency (lower is better)   :- ~14 higher with this patch seires
* IOPS/BW (higner is better)  :- ~47k higner with this patch series
* CPU Usage (lower is better) :- approximately the same 

Set 2 (Average of 3 runs) :-
-----------------------------
* Latency (lower is better)   :- ~9 higher with this patch seires
* IOPS/BW (higner is better)  :- ~23k higner with this patch series
* CPU Usage (lower is better) :- approximately the same 

Below is the test for the fio verification job and perf numbers on brd.

In case someone shows up with performance regression on the arch that
I've don't have access to we can decide then if we want to drop it this
series or keep using deprecated kernel API, but I think removing
deprecated API is useful in long term in anyway.

-ck

Chaitanya Kulkarni (4):
  brd: use memcpy_to_page() in copy_to_brd()
  brd: use memcpy_to_page() in copy_to_brd()
  brd: use memcpy_from_page() in copy_from_brd()
  brd: use memcpy_from_page() in copy_from_brd()

 drivers/block/brd.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

#######################################################################
Testing with fio verification and randread workload on brd:-

linux-block (brd-memcpy) # sh test-brd-memcpy-perf.sh 
Switched to branch 'for-next'
Your branch is ahead of 'origin/for-next' by 274 commits.
  (use "git push" to publish your local commits)
+ umount /mnt/brd
umount: /mnt/brd: not mounted.
+ dmesg -c
+ modprobe -r brd
+ lsmod
+ grep brd
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/brd.o
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
  LD [M]  drivers/block/brd.ko
  LD [M]  drivers/block/virtio_blk.ko
  LD [M]  drivers/block/floppy.ko
  LD [M]  drivers/block/xen-blkfront.ko
  LD [M]  drivers/block/mtip32xx/mtip32xx.ko
  LD [M]  drivers/block/drbd/drbd.ko
  LD [M]  drivers/block/nbd.ko
  LD [M]  drivers/block/xen-blkback/xen-blkback.ko
  LD [M]  drivers/block/null_blk/null_blk.ko
  LD [M]  drivers/block/rbd.ko
  LD [M]  drivers/block/loop.ko
  LD [M]  drivers/block/zram/zram.ko
+ HOST=drivers/block/brd.ko
++ uname -r
+ HOST_DEST=/lib/modules/6.3.0-rc4lblk+/kernel/drivers/block/null_blk/
+ cp drivers/block/brd.ko /lib/modules/6.3.0-rc4lblk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.3.0-rc4lblk+/kernel/drivers/block/null_blk//brd.ko
-rw-r--r--. 1 root root 377K Mar 27 16:00 /lib/modules/6.3.0-rc4lblk+/kernel/drivers/block/null_blk//brd.ko
+ dmesg -c
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=0): [f(1)][100.0%][r=1222MiB/s][r=313k IOPS][eta 00m:00s]                
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3701: Mon Mar 27 16:07:51 2023
  read: IOPS=401k, BW=1565MiB/s (1641MB/s)(6470MiB/4135msec)
    slat (nsec): min=1082, max=117624, avg=1430.90, stdev=419.78
    clat (nsec): min=1122, max=158170, avg=37721.35, stdev=2449.84
     lat (usec): min=2, max=159, avg=39.20, stdev= 2.51
    clat percentiles (nsec):
     |  1.00th=[36096],  5.00th=[36096], 10.00th=[36608], 20.00th=[36608],
     | 30.00th=[36608], 40.00th=[37120], 50.00th=[37120], 60.00th=[37120],
     | 70.00th=[37632], 80.00th=[37632], 90.00th=[38656], 95.00th=[42752],
     | 99.00th=[46848], 99.50th=[49920], 99.90th=[59648], 99.95th=[65280],
     | 99.99th=[90624]
  write: IOPS=209k, BW=817MiB/s (856MB/s)(10.0GiB/12540msec); 0 zone resets
    slat (usec): min=2, max=130, avg= 4.18, stdev= 1.04
    clat (nsec): min=1152, max=297666, avg=72041.65, stdev=6856.78
     lat (usec): min=5, max=300, avg=76.27, stdev= 7.21
    clat percentiles (usec):
     |  1.00th=[   55],  5.00th=[   62], 10.00th=[   65], 20.00th=[   69],
     | 30.00th=[   71], 40.00th=[   72], 50.00th=[   73], 60.00th=[   74],
     | 70.00th=[   75], 80.00th=[   76], 90.00th=[   79], 95.00th=[   83],
     | 99.00th=[   91], 99.50th=[   97], 99.90th=[  122], 99.95th=[  130],
     | 99.99th=[  155]
   bw (  KiB/s): min=48776, max=1028502, per=96.45%, avg=806517.46, stdev=164544.29, samples=26
   iops        : min=12194, max=257125, avg=201629.42, stdev=41136.06, samples=26
  lat (usec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=38.63%
  lat (usec)   : 100=61.12%, 250=0.25%, 500=0.01%
  cpu          : usr=54.26%, sys=45.67%, ctx=20, majf=0, minf=38837
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=1656350,2621440,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1565MiB/s (1641MB/s), 1565MiB/s-1565MiB/s (1641MB/s-1641MB/s), io=6470MiB (6784MB), run=4135-4135msec
  WRITE: bw=817MiB/s (856MB/s), 817MiB/s-817MiB/s (856MB/s-856MB/s), io=10.0GiB (10.7GB), run=12540-12540msec

Disk stats (read/write):
  ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%


#######################################################################
Performance numbers :-

* Set 1:-
----------------
* Avg Latency delta (lower is better) :- ~14 higher with this patch seires

linux-block (brd-memcpy) # grep -w "lat (nsec):" *brd*fio 
default-brd.1.fio:     lat (nsec): min=1363, max=4413.5k, avg=2918.00, stdev=1731.03
default-brd.2.fio:     lat (nsec): min=1393, max=4754.7k, avg=2904.26, stdev=1692.10
default-brd.3.fio:     lat (nsec): min=1393, max=4646.2k, avg=2934.00, stdev=1652.24
(2918.00+2904.26+2934.00)/3 = 2918

with-memcpy-brd.1.fio: lat (nsec): min=1413, max=1176.6k, avg=2895.35, stdev=1552.79
with-memcpy-brd.2.fio: lat (nsec): min=1393, max=647331,  avg=2919.57, stdev=1564.59
with-memcpy-brd.3.fio: lat (nsec): min=1393, max=1685.6k, avg=2899.98, stdev=1558.76
(2895.35+2919.57+2899.98)/3 = 2904

* Ave IOPS/BW delta (higner is better ):- ~47k higner with this patch series

linux-block (brd-memcpy) # grep IOPS *brd*fio
default-brd.1.fio:     read: IOPS=7504k, BW=28.6GiB/s (30.7GB/s)(1717GiB/60001msec)
default-brd.2.fio:     read: IOPS=7525k, BW=28.7GiB/s (30.8GB/s)(1722GiB/60002msec)
default-brd.3.fio:     read: IOPS=7441k, BW=28.4GiB/s (30.5GB/s)(1703GiB/60001msec)
(7504+7525+7441)/3 = 7490

with-memcpy-brd.1.fio: read: IOPS=7558k, BW=28.8GiB/s (31.0GB/s)(1730GiB/60002msec)
with-memcpy-brd.2.fio: read: IOPS=7494k, BW=28.6GiB/s (30.7GB/s)(1715GiB/60001msec)
with-memcpy-brd.3.fio: read: IOPS=7561k, BW=28.8GiB/s (31.0GB/s)(1731GiB/60001msec)
(7558+7494+7561)/3 = 7537


* Avg CPU Usage delta (lower is better) :- approximately the same 

linux-block (brd-memcpy) # grep cpu  *brd*fio
default-brd.1.fio:      cpu: usr=15.98%, sys=83.92%, ctx=2858, majf=0, minf=347
default-brd.2.fio:      cpu: usr=16.37%, sys=83.53%, ctx=2181, majf=0, minf=351
default-brd.3.fio:      cpu: usr=15.97%, sys=83.94%, ctx=2363, majf=0, minf=353
(83.92+83.53+83.94)/3 = 83

with-memcpy-brd.1.fio:  cpu: usr=16.48%, sys=83.42%, ctx=8127, majf=0, minf=348
with-memcpy-brd.2.fio:  cpu: usr=16.41%, sys=83.48%, ctx=9116, majf=0, minf=371
with-memcpy-brd.3.fio:  cpu: usr=16.38%, sys=83.52%, ctx=2361, majf=0, minf=360
(83.42+83.48+83.52)/3 83


* Set 2:-
---------------
* Avg Latency delta (lower is better) :- ~9 higher with this patch seires

linux-block (brd-memcpy) # grep -w "lat (nsec):" *brd*fio 
default-brd.1.fio:     lat (nsec): min=1362, max=895642, avg=2879.71, stdev=1554.52
default-brd.2.fio:     lat (nsec): min=1363, max=856197, avg=2905.51, stdev=1539.65
default-brd.3.fio:     lat (nsec): min=1362, max=1114.1k, avg=2843.13, stdev=1581.05
(2879.71+2905.51+2843.13)/3 = 2876

with-memcpy-brd.1.fio: lat (nsec): min=1362, max=1079.7k, avg=2867.75, stdev=1565.19
with-memcpy-brd.2.fio: lat (nsec): min=1362, max=1160.5k, avg=2867.36, stdev=1539.65
with-memcpy-brd.3.fio: lat (nsec): min=1343, max=859683, avg=2866.50, stdev=1546.11
(2867.75+2867.36+2866.50)/3 = 2867

* Avg IOPS/BW delta (higner is better ):- ~23k higner with this patch series

linux-block (brd-memcpy) # grep IOPS  *brd*fio
default-brd.1.fio:     read: IOPS=7613k, BW=29.0GiB/s (31.2GB/s)(1743GiB/60002msec)
default-brd.2.fio:     read: IOPS=7503k, BW=28.6GiB/s (30.7GB/s)(1717GiB/60002msec)
default-brd.3.fio:     read: IOPS=7698k, BW=29.4GiB/s (31.5GB/s)(1762GiB/60001msec)
(7613+7503+7698)/3 = 7604

with-memcpy-brd.1.fio: read: IOPS=7623k, BW=29.1GiB/s (31.2GB/s)(1745GiB/60002msec)
with-memcpy-brd.2.fio: read: IOPS=7623k, BW=29.1GiB/s (31.2GB/s)(1745GiB/60001msec)
with-memcpy-brd.3.fio: read: IOPS=7637k, BW=29.1GiB/s (31.3GB/s)(1748GiB/60001msec)
(7623+7623+7637)/3 = 7627


* Avg CPU Usage delta (lower is better) :- approximately the same 

linux-block (brd-memcpy) # grep cpu  *brd*fio
default-brd.1.fio:      cpu: usr=15.32%, sys=84.58%, ctx=1485, majf=0, minf=360
default-brd.2.fio:      cpu: usr=16.70%, sys=83.20%, ctx=1691, majf=0, minf=357
default-brd.3.fio:      cpu: usr=15.59%, sys=84.31%, ctx=1835, majf=0, minf=345
(84.58+83.20+84.31)/3 = 84

with-memcpy-brd.1.fio:  cpu: usr=15.84%, sys=84.06%, ctx=1800, majf=0, minf=350
with-memcpy-brd.2.fio:  cpu: usr=16.22%, sys=83.68%, ctx=1831, majf=0, minf=342
with-memcpy-brd.3.fio:  cpu: usr=15.79%, sys=84.11%, ctx=1689, majf=0, minf=341
(84.06+83.68+84.11)/3 = 83

-- 
2.29.0

