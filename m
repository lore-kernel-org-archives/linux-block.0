Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12670C76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 20:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDJUUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJUUG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 16:20:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A91737
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 13:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htvQqIJ2w5DCn4lrn0aSZrHfkMPhwR2okYZknTbezgKdLqxe08h9yDZFQAjMeeWVAlkCRp4PLh3H0pGM6ciKG4hd+FsZynVY8n2fugRECM3IzFFL6SV/p4Gs5AuI61ASM3ciMPcXylpLz4oMjeVWNtbeEEMHukDxQEYORvWcKzxghcqI1Acg4FmDk0wAfaH3Y/e9WGKrN9Uq3snZQE/PPDIvLMV+HA1tJXcxiaUOIvGOEO0UZ9Af0y+h4DCTkZglJeeO9X//7WDs0yjBB7Jn5QM/kKoRxDvnWyoJWBYlclPr9bMtq64V3+govHCFV8p+9C6cAMOJPMU2sFrv0RTvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOkMiqI+qrzTXbVb+KPH9rBh6AgQ9vnt3dRUsXwHTCc=;
 b=kkeGipl8K2HhsKKKO2DlAF74pNHvM8pvBjMKBYirIMjureIVL+KMRfaZs7/TuAhElmrvjdQp1BY8PorfHKJ23T4adzN9JL2c38LHsK3sLBpvqza4aV3J/z5/BYh/R5MkmpIcuU/6q3meMvECJPxxbWVBsq4bUucWP4Sj+J4lfDalaVYt0iVx6x1YpeOYJComELmvQMiRYZcr7+TCglUhJbqtQgksZMQlZxeCqiwGlpFCTs/ToCV58K5xjvP1o0l89nRK4Sn0B8e4jtUQ+NNGp6WN7bqtpG3b2y0lcsUQgo9KmUp1e08Ek6FAIoTNLtICOS4eMAxLsbwtAD80jF+H2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOkMiqI+qrzTXbVb+KPH9rBh6AgQ9vnt3dRUsXwHTCc=;
 b=Dp/63sWpxz/zl0/nbF3d0YRvq+sBgATJm5JIW1rhCiGKfNTJOW/C7V1L+cC8cyudrqeygQrHSZ74Bz0M3uG8App7aXHGPRyhDnC3q4lM1TjdUViU4oLJSU9PMJtxYczfSUlWPPomgp5gT1cGKIP+/YoTqAMWOisQ5862LR2J84FjXqHdOs9k0CrpnoBBTqNbQ/Wgv3fPTq8bvQQV881+Gc5q2MLgvrlKEpg6n/veYMusVs6kT7SIivgxydtaurhfEMDvf/7wZRp+tThnpQP/HjfOjDjsxH4VL2Ys22gFugR6n7vRr2IgbA9Kozj3y9r49zNNLrTATSBlSuPD/MHo8A==
Received: from DM6PR01CA0013.prod.exchangelabs.com (2603:10b6:5:296::18) by
 CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Mon, 10 Apr 2023 20:20:02 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::d6) by DM6PR01CA0013.outlook.office365.com
 (2603:10b6:5:296::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35 via Frontend
 Transport; Mon, 10 Apr 2023 20:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.26 via Frontend Transport; Mon, 10 Apr 2023 20:20:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Apr 2023
 13:19:50 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Apr
 2023 13:19:50 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 0/1] brd: use memcpy_to_page() in copy_to_brd()
Date:   Mon, 10 Apr 2023 13:19:37 -0700
Message-ID: <20230410201938.59122-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 92348a1d-0c15-4059-7f88-08db3a00f6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuSgCF8FrpIb875UbqfuS2exoUHhBXxOH08ICC/LUIjK1hK0Kveg/iRMbhLmHluM8+Ttod7bwsBvyX1oNr0B0Q1mygX7Y2gqp3Zh9GanXfvG0O6fCJubkfCC6gb9BeIVHyzKonBP/DldEiUeZUCp+u8okU/jz0mHUOHI7nXNbfTQpe+rnbuABrcEY/F3rv/RRKhiJc4MGxfxvciaOEL3Ty/34t+k0wvYcpq8pZXahCpKuUck1p/c2N8Ea63JGGgcGZJDZe+ABBU2D7aSd08R7DFflXaUUV6zf1dOUNFO/SOU6uKznRjAG6BY9e94Hhq0CSFTnLNfNRUwAOqrn2VGud9K1mRYgger22dKnqgd6WjOhJz2G5KOXE+4cV1CmX02wtyRU9DQXH2B3Gfs3hiy8EQJ9ydeifUeTy3HlM6xETS64CmYxSFrzU6m/D/CmGbiUKH1teZ9iUVnaTkIujNfbaZqncJRTwVuJpxvSCsVJvn4dweXBac2hzsiP/dP8kstkJP9im2jEfBe7pPvTrHSleTpmu/F1WxSwSftKBN+0CGU14t5i1cUDMNh5MLGlQRgFhA7DCYhiBP03VsT1FFLnaRSw7EczHGZWWR5R8t6qHw9CW7UFKwmcbH56JOFoZpicmnfD4UaIXKCsITVhpKeN9WUr4PBPHlOWNjrF1a7wLlGTR6koL0yx9kdX2c3Trl+6lc9ZwP8rN7ziFuSzuxcWk9Kod28xdT45k0fFknl0jSZuLAN9U+ThWm+cIneb+jZOJ4TaJsPBYAf0XWe66loxQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36756003)(7696005)(316002)(19627235002)(41300700001)(4326008)(54906003)(478600001)(6916009)(8676002)(70586007)(70206006)(82310400005)(40480700001)(5660300002)(2906002)(8936002)(356005)(7636003)(82740400003)(186003)(36860700001)(16526019)(107886003)(6666004)(1076003)(26005)(426003)(336012)(2616005)(83380400001)(47076005)(40460700003)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 20:20:01.7420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92348a1d-0c15-4059-7f88-08db3a00f6da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From :include/linux/highmem.h:
"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Use memcpy_from_page() since does the same job of mapping, copying, and
unmaping except it uses non deprecated kmap_local_page() and
kunmap_local(). Following are the differences between kmal_local_page()
and kmap_atomic() :-

* creates local mapping per thread, local to CPU & not globally visible
* allows to be called from any context
* allows task preemption 

Performance numbers from V1 should apply as it as there is not even
a single line of change in this version which only combines
all the patches into one :-

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
or keep using deprecated kernel API, but I think removing deprecated
API is useful in long term in anyway.

-ck

v2:-

Merge all the patches into a single patch.
No functional change from V1.

Chaitanya Kulkarni (1):
  brd: use memcpy_to|from_page() in copy_to|from_brd()

 drivers/block/brd.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)


fio verify job output:

linux-block (brd-memcpy) # git log -1
commit ea45fcc44031dc56055b194f0792fb2230caba00 (HEAD -> brd-memcpy)
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Sun Apr 9 15:14:01 2023 -0700

    brd: use memcpy_xxx_page() lib functions

    "kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

    Use memcpy_from_page() helper that does same job of mapping and copying
    buffer that is opcoded in copy_from_brd() except the library function
    also uses non deprecated kmap_local_page() and kunmap_local() instead
    of kmap() amd kunmap() in current code.

    Use memcpy_to_page() helper that does same job of mapping and copying
    buffer that is opcoded in copy_to_brd() except the library function
    also uses non deprecated kmap_local_page() and kunmap_local() instead
    of kmap() amd kunmap() in current code.

    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
linux-block (brd-memcpy) # ./compile_brd.sh 
+ umount /mnt/brd
umount: /mnt/brd: not mounted.
+ dmesg -c
+ modprobe -r brd
+ lsmod
+ grep brd
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
  CC [M]  drivers/block/xen-blkback/blkback.o
  CC [M]  drivers/block/zram/zram_drv.o
  CC [M]  drivers/block/xen-blkback/xenbus.o
  CC [M]  drivers/block/null_blk/main.o
  CC [M]  drivers/block/null_blk/trace.o
  CC [M]  drivers/block/null_blk/zoned.o
  CC [M]  drivers/block/drbd/drbd_bitmap.o
  CC [M]  drivers/block/drbd/drbd_proc.o
  CC [M]  drivers/block/drbd/drbd_worker.o
  CC [M]  drivers/block/drbd/drbd_receiver.o
  CC [M]  drivers/block/drbd/drbd_req.o
  CC [M]  drivers/block/drbd/drbd_actlog.o
  CC [M]  drivers/block/drbd/drbd_main.o
  CC [M]  drivers/block/drbd/drbd_nl.o
  CC [M]  drivers/block/drbd/drbd_state.o
  CC [M]  drivers/block/drbd/drbd_nla.o
  CC [M]  drivers/block/drbd/drbd_debugfs.o
  LD [M]  drivers/block/zram/zram.o
  LD [M]  drivers/block/xen-blkback/xen-blkback.o
  LD [M]  drivers/block/null_blk/null_blk.o
  LD [M]  drivers/block/drbd/drbd.o
  MODPOST drivers/block/Module.symvers
  LD [M]  drivers/block/floppy.ko
  LD [M]  drivers/block/brd.ko
  LD [M]  drivers/block/loop.ko
  LD [M]  drivers/block/nbd.ko
  LD [M]  drivers/block/virtio_blk.ko
  LD [M]  drivers/block/xen-blkfront.ko
  LD [M]  drivers/block/xen-blkback/xen-blkback.ko
  LD [M]  drivers/block/drbd/drbd.ko
  LD [M]  drivers/block/rbd.ko
  LD [M]  drivers/block/mtip32xx/mtip32xx.ko
  LD [M]  drivers/block/zram/zram.ko
  LD [M]  drivers/block/null_blk/null_blk.ko
+ HOST=drivers/block/brd.ko
++ uname -r
+ HOST_DEST=/lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/
+ cp drivers/block/brd.ko /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block//
+ ls -lrth /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block//brd.ko
-rw-r--r--. 1 root root 375K Apr 10 13:17 /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block//brd.ko
+ dmesg -c
[81687.581471] brd: module unloaded
+ lsmod
+ grep brd
linux-block (brd-memcpy) # modprobe brd rd_size=$((70*1024*1204)) rd_nr=1; ls /dev/ram0
/dev/ram0
linux-block (brd-memcpy) # cat fio/verify.fio
[write-and-verify]
rw=randwrite
bs=4k
direct=1
ioengine=libaio
iodepth=16
norandommap
randrepeat=0
verify=crc32c
size=15G
allow_file_create=0
group_reporting
linux-block (brd-memcpy) # fio --filename= /dev/ram0
fio: option filename requires an argument
linux-block (brd-memcpy) # fio fio/verify.fio  --filename=/dev/ram0
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=0): [f(1)][100.0%][r=1058MiB/s][r=271k IOPS][eta 00m:00s]
write-and-verify: (groupid=0, jobs=1): err= 0: pid=57965: Mon Apr 10 13:16:54 2023
  read: IOPS=390k, BW=1522MiB/s (1596MB/s)(9710MiB/6381msec)
    slat (nsec): min=1152, max=70725, avg=1481.93, stdev=397.01
    clat (nsec): min=1092, max=224095, avg=38774.90, stdev=2190.45
     lat (usec): min=2, max=225, avg=40.30, stdev= 2.23
    clat percentiles (nsec):
     |  1.00th=[37120],  5.00th=[37120], 10.00th=[37632], 20.00th=[37632],
     | 30.00th=[38144], 40.00th=[38144], 50.00th=[38144], 60.00th=[38656],
     | 70.00th=[38656], 80.00th=[39168], 90.00th=[39680], 95.00th=[43264],
     | 99.00th=[47360], 99.50th=[49920], 99.90th=[52480], 99.95th=[54528],
     | 99.99th=[85504]
  write: IOPS=162k, BW=634MiB/s (665MB/s)(15.0GiB/24209msec); 0 zone resets
    slat (usec): min=2, max=744, avg= 5.54, stdev= 2.45
    clat (nsec): min=1002, max=843151, avg=92648.20, stdev=18028.23
     lat (usec): min=5, max=848, avg=98.24, stdev=19.04
    clat percentiles (usec):
     |  1.00th=[   64],  5.00th=[   72], 10.00th=[   76], 20.00th=[   79],
     | 30.00th=[   82], 40.00th=[   85], 50.00th=[   90], 60.00th=[   93],
     | 70.00th=[   97], 80.00th=[  106], 90.00th=[  120], 95.00th=[  129],
     | 99.00th=[  147], 99.50th=[  155], 99.90th=[  176], 99.95th=[  186],
     | 99.99th=[  206]
   bw (  KiB/s): min=222288, max=761392, per=98.81%, avg=641985.14, stdev=90922.65, samples=49
   iops        : min=55572, max=190348, avg=160496.33, stdev=22730.68, samples=49
  lat (usec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=38.57%
  lat (usec)   : 100=46.17%, 250=15.26%, 500=0.01%, 1000=0.01%
  cpu          : usr=48.58%, sys=51.34%, ctx=17, majf=0, minf=58280
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=2485856,3932160,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1522MiB/s (1596MB/s), 1522MiB/s-1522MiB/s (1596MB/s-1596MB/s), io=9710MiB (10.2GB), run=6381-6381msec
  WRITE: bw=634MiB/s (665MB/s), 634MiB/s-634MiB/s (665MB/s-665MB/s), io=15.0GiB (16.1GB), run=24209-24209msec

Disk stats (read/write):
  ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
linux-block (brd-memcpy) #


-- 
2.29.0

