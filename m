Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D704C77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 08:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbjELIa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 04:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbjELIaZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 04:30:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73127ECC
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 01:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJHjRPrCjgldmmYqKUoTv51kjAlaY0BbJHBSMS2OyLDiBS+Ic0ZyZ8KGjMLY4l6I+puosp7GCs8VAFO9QhVSBs/61d9N50umVgub+be9PC40PBlX/VZVbij528s/6ZpY9i9AS1R0/cIBMYt9GioFhv9LQBRnlksxWEZYJ5zky20cDAJkuZ7XfQUNRH7KSAzaaDkmOynB1TB0UlD9ybdbdsb1rR/N6nXrnzhcFt1ZtCGiF3N8bGbdVA/t0j7FQ2+AGW33vvTUlXFFug9OMBSLlt+VYcogmUwBRSs1N1w79bV84L0SLho5LKwtvsVu2qyFvfmaPWD6hTP92JfUksB/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTjA+olRR6V4HPETCc7+6dHQB7GR3JEP1jVgyEh+02k=;
 b=gOcHw5+XQYIZR2yhYEm09xxxZdNYopEE+gs5ntqAiaeLf/zRGN5yE9R1UGnmTlE5Lx7f1cSSpvLYxTz3u6tvoQhPQxZKqo87BquPUEsfMf8fjxDb19wocncjqS/5RvZmZ2kWHYtmBJs65cGuWu8dcHnKts/PHSyIVAP62GFOJ4ZyIXEhvZODuCOihYUovR/UUvoSTL6gYYCK/vEhmDJf9mnoZ9XSIAeCEl/HR9NoR9ShoBERPC54TceEvnj2jStoRPZUJba2bZ0tCnAQkqt6EYMSfVbg+QFwt/Lx2NNATGAveNdY9gn+iga46a5wyx1CZk3x5PI+HZcdUjdEsS9U7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTjA+olRR6V4HPETCc7+6dHQB7GR3JEP1jVgyEh+02k=;
 b=fYWHavr7vSp+kOdyKsG2HSkJnmnmnAPieO2/ExSSYQZFnQDCNOUBuy67Szw9mThNf7Fr3AEgpF8JXHgZ8Q30VDjXHP0NQQ4rzG9b/jrdUgPnZ/8NHxa5k0Z5Ml/vcod8mOMzVwyAI7jxIhPtTj11n+ytjGP4Bv2PoCTVJ3RQwFyPev8Msq7aGNJesJfO11NVQi5rk0pVXCeonesUUTFbMLqboJvpUnQXQNwOaAjVF8xOPPx37uVMwlt2FAJNPVtd9EBnkx/fxFR63zW6hlNKa8ZyLWg8I9mr/NmvIPQI4RvKjl/j1H+GlGN/idNXM9wamE5IZ/C+NyXT5BibkPHd8g==
Received: from BY3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:254::31)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 08:30:19 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:254:cafe::30) by BY3PR05CA0026.outlook.office365.com
 (2603:10b6:a03:254::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.10 via Frontend
 Transport; Fri, 12 May 2023 08:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.24 via Frontend Transport; Fri, 12 May 2023 08:30:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 01:30:05 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 01:30:04 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/3] zram: queue flag nowait and mior cleanup
Date:   Fri, 12 May 2023 01:29:55 -0700
Message-ID: <20230512082958.6550-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: f4302ded-4cad-4765-0cdb-08db52c31e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDbmQlILAjNpWXJbILH3DkTskapDsMVzOrA95G9ms2mVooCE2B0/eUbOLCspxKSXqDoq8vWPPzDTfq8HejpOpLOWttoqy2rUBRH0UD1N7a4mE+6hxj1jcLuy7F4WidEbrOhrSxObdBy0/eHPdeViw/U31KJj2tAA4UIjHRBCAQ9r2/MMOIYCOmXMsk7RGz7Y8Jceufu1b0PoaiHD4Xnpyn61FrJHw74M2I3hSzDZ8LF45xT2jOkx2dInGlhSvHVb9zrFfcxJpdXo/vMrsZB6aTCKfszzPUqNv2cPrwV9c+vdtI3RdEm2hE/e6Yet9BKlb3RfVOKoIEIUFqC4mirUskw/RWJiE95bcd5JAqSW9wgr5avcGLUAUYu77IBUFF2dWSVHYxEib4SSvtwJBG3D5VbpKqiv8Y5WIHVIqp84nEEFv5OBIKGPTI4Uu2L3DnazQYlkL+6OneZBCskOwqD6z9lCcLKNooboN+j0lk4ZSy1RN/LbsiZcKrSijVh8OWenzmzVjVN5o8Z4MgEGKgMldbERGmDwrUFU4HaLpVcVnpqSCN9ST8xnXcCPQWjWym6Qwrj0eox+Ny77gZqXayGoUowX9/oa7/boi4NuXbq5+S0w6wYElk/qVB/JUyF5y/3o6qW4+PK0tKiSThNw6tA6pEHRhtrpMOoO0a4KztsbFxrj+UPw2/YDbjL3w6yvU5tT1OWzk+ZiAU3OWfEzJbDLpImQGeO4UykqamB1pjliJEwsgAvhEJVxwIOPbtgpQgyl
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(4326008)(40460700003)(70586007)(54906003)(70206006)(19627235002)(110136005)(478600001)(8676002)(5660300002)(2906002)(30864003)(8936002)(316002)(336012)(426003)(356005)(7696005)(41300700001)(40480700001)(7636003)(16526019)(6666004)(82740400003)(1076003)(26005)(82310400005)(186003)(36860700001)(83380400001)(107886003)(2616005)(47076005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 08:30:18.5696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4302ded-4cad-4765-0cdb-08db52c31e86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Minchan/Sergey,

Consolidate the zram_bvec_read() and zram_bvec_write() into one
function, add missing flush_dcache_page() before zram_bvec_write(),
and allow user to set the QUEUE_FLAG_NOWAIT to get the better
performance with io_uring:-

* linux-block (for-next) # grep IOPS  zram*fio | column -t

default-nowait-off-1.fio:  read:  IOPS=792k,  BW=3095MiB/s
default-nowait-off-2.fio:  read:  IOPS=812k,  BW=3173MiB/s
default-nowait-off-3.fio:  read:  IOPS=803k,  BW=3137MiB/s

nowait-on-1.fio:           read:  IOPS=864k,  BW=3374MiB/s
nowait-on-2.fio:           read:  IOPS=863k,  BW=3371MiB/s
nowait-on-3.fio:           read:  IOPS=864k,  BW=3374MiB/s

* linux-block (for-next) # grep cpu  zram*fio | column -t
default-nowait-off-1.fio:  cpu  :  usr=5.92%,  sys=13.05%,  ctx=37784503
default-nowait-off-2.fio:  cpu  :  usr=6.07%,  sys=13.66%,  ctx=37821095
default-nowait-off-3.fio:  cpu  :  usr=6.06%,  sys=13.33%,  ctx=38395321

nowait-on-1.fio:           cpu  :  usr=1.78%,  sys=97.58%,  ctx=23848,
nowait-on-2.fio:           cpu  :  usr=1.78%,  sys=97.61%,  ctx=22537,
nowait-on-3.fio:           cpu  :  usr=1.80%,  sys=97.60%,  ctx=21582,

* linux-block (for-next) # grep slat  zram*fio | column -t
default-nowait-off-1.fio: slat (nsec): min=410, max=4827.1k,  avg=1868.3
default-nowait-off-2.fio: slat (nsec): min=411, max=5335.4k,  avg=1953.2
default-nowait-off-3.fio: slat (nsec): min=420, max=5102.4k,  avg=1852.9

nowait-on-1.fio:          slat (nsec): min=1072,max=33725k,  avg=54834.7
nowait-on-2.fio:          slat (nsec): min=972, max=16048k,  avg=54874.8
nowait-on-3.fio:          slat (nsec): min=1042,max=7085.1k, avg=54823.7

Please let me know if further testing is needed I've ran fio
verification job in order to make verify these changes.

-ck

Chaitanya Kulkarni (3):
  zram: allow user to set QUEUE_FLAG_NOWAIT
  zram: consolidate zram_bio_read()_zram_bio_write()
  zram: add flush_dcache_page() call for write

 drivers/block/zram/zram_drv.c | 63 +++++++++++++++--------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

oinux-block (for-next) # sh test-zram-nowait.sh 
+ git log -4
commit f6654c00ddea9b02952ac94551e0d7469fc8e8d8 (HEAD -> for-next)
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Thu May 11 23:50:37 2023 -0700

    zram: add flush_dcache_page() call for write
    
    Just like we have a call flush_dcache_read() after zrma_bvec_read, add
    missing flush_dcache_page() call before zram_bdev_write() in order to
    handle the cache congruency of the kernel and userspace mappings of
    page when zram does write.
    
    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

commit bfe3e67f81284663bf84bc5121c27bf90410d433
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Thu May 11 23:46:43 2023 -0700

    zram: consolidate zram_bio_read()_zram_bio_write()
    
    zram_bio_read() and zram_bio_write() are 26 lines rach and share most of
    the code except call to zram_bdev_read() and zram_bvec_write() calls.
    Consolidate code into single zram_bio_rw() to remove the duplicate code
    and an extra function that is only needed for 2 lines of code :-
    
    1c1
    < static void zram_bio_read(struct zram *zram, struct bio *bio)

commit 6f5b4f6dec19464158ead387739ceb72b97e991c
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Thu May 11 23:03:32 2023 -0700

    zram: allow user to set QUEUE_FLAG_NOWAIT
    
    Allow user to set the QUEUE_FLAG_NOWAIT optionally using module
    parameter to retain the default behaviour. Also, update respective
    allocation flags in the write path. Following are the performance
    numbers with io_uring fio engine for random read, note that device has
    been populated fully with randwrite workload before taking these
    numbers :-
    
    * linux-block (for-next) # grep IOPS  zram*fio | column -t
    
    default-nowait-off-1.fio:  read:  IOPS=792k,  BW=3095MiB/s
    default-nowait-off-2.fio:  read:  IOPS=812k,  BW=3173MiB/s
    default-nowait-off-3.fio:  read:  IOPS=803k,  BW=3137MiB/s
    
    nowait-on-1.fio:           read:  IOPS=864k,  BW=3374MiB/s
    nowait-on-2.fio:           read:  IOPS=863k,  BW=3371MiB/s
    nowait-on-3.fio:           read:  IOPS=864k,  BW=3374MiB/s
    
    * linux-block (for-next) # grep cpu  zram*fio | column -t
    default-nowait-off-1.fio:  cpu  :  usr=5.92%,  sys=13.05%,  ctx=37784503
    default-nowait-off-2.fio:  cpu  :  usr=6.07%,  sys=13.66%,  ctx=37821095
    default-nowait-off-3.fio:  cpu  :  usr=6.06%,  sys=13.33%,  ctx=38395321
    
    nowait-on-1.fio:           cpu  :  usr=1.78%,  sys=97.58%,  ctx=23848,
    nowait-on-2.fio:           cpu  :  usr=1.78%,  sys=97.61%,  ctx=22537,
    nowait-on-3.fio:           cpu  :  usr=1.80%,  sys=97.60%,  ctx=21582,
    
    * linux-block (for-next) # grep slat  zram*fio | column -t
    default-nowait-off-1.fio: slat (nsec): min=410, max=4827.1k,  avg=1868.3
    default-nowait-off-2.fio: slat (nsec): min=411, max=5335.4k,  avg=1953.2
    default-nowait-off-3.fio: slat (nsec): min=420, max=5102.4k,  avg=1852.9
    
    nowait-on-1.fio:          slat (nsec): min=1072,max=33725k,  avg=54834.7
    nowait-on-2.fio:          slat (nsec): min=972, max=16048k,  avg=54874.8
    nowait-on-3.fio:          slat (nsec): min=1042,max=7085.1k, avg=54823.7
    
    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

commit 6622cc4e0c7139d5173ae5f115a7d87e45a51c1a
Merge: 2742538c4d28 7387653a6022
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Thu May 11 22:57:28 2023 -0700

    Merge branch 'for-next' of git://git.kernel.dk/linux-block into for-next
+ ./compile_zram.sh
+ umount /mnt/zram
umount: /mnt/zram: no mount point specified.
+ dmesg -c
+ modprobe -r zram
+ lsmod
+ grep zram
++ nproc
+ make -j 48 M=drivers/block modules
+ HOST=drivers/block/zram/zram.ko
++ uname -r
+ HOST_DEST=/lib/modules/6.4.0-rc1lblk+/kernel/drivers/block/zram/
+ cp drivers/block/zram/zram.ko /lib/modules/6.4.0-rc1lblk+/kernel/drivers/block/zram//
+ ls -lrth /lib/modules/6.4.0-rc1lblk+/kernel/drivers/block/zram//zram.ko
-rw-r--r--. 1 root root 676K May 12 00:23 /lib/modules/6.4.0-rc1lblk+/kernel/drivers/block/zram//zram.ko
+ dmesg -c
+ lsmod
+ grep zram
+ modprobe zram
+ sleep 1
+ zramctl -s 20GB /dev/zram0
+ sleep 1
+ test_nowait default-nowait-off
+ fio fio/verify.fio --ioengine=io_uring --size=2G --filename=/dev/zram0
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=16
fio-3.34
Starting 1 process
Jobs: 1 (f=1): [V(1)][100.0%][r=995MiB/s][r=255k IOPS][eta 00m:00s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=176756: Fri May 12 00:23:34 2023
  read: IOPS=255k, BW=995MiB/s (1043MB/s)(1295MiB/1302msec)
    slat (nsec): min=922, max=37201, avg=2879.25, stdev=1196.56
    clat (usec): min=3, max=134, avg=58.98, stdev= 5.43
     lat (usec): min=6, max=137, avg=61.85, stdev= 5.61
    clat percentiles (usec):
     |  1.00th=[   48],  5.00th=[   51], 10.00th=[   53], 20.00th=[   55],
     | 30.00th=[   57], 40.00th=[   58], 50.00th=[   59], 60.00th=[   60],
     | 70.00th=[   62], 80.00th=[   63], 90.00th=[   67], 95.00th=[   69],
     | 99.00th=[   76], 99.50th=[   78], 99.90th=[   86], 99.95th=[   92],
     | 99.99th=[  103]
  write: IOPS=201k, BW=785MiB/s (823MB/s)(2048MiB/2609msec); 0 zone resets
    slat (nsec): min=1132, max=148451, avg=4590.62, stdev=2151.57
    clat (usec): min=19, max=250, avg=74.77, stdev=11.44
     lat (usec): min=23, max=338, avg=79.36, stdev=11.92
    clat percentiles (usec):
     |  1.00th=[   54],  5.00th=[   61], 10.00th=[   65], 20.00th=[   69],
     | 30.00th=[   71], 40.00th=[   73], 50.00th=[   75], 60.00th=[   76],
     | 70.00th=[   78], 80.00th=[   81], 90.00th=[   86], 95.00th=[   91],
     | 99.00th=[  116], 99.50th=[  145], 99.90th=[  165], 99.95th=[  176],
     | 99.99th=[  204]
   bw (  KiB/s): min=161184, max=886504, per=86.97%, avg=699050.67, stdev=266603.81, samples=6
   iops        : min=40296, max=221626, avg=174762.67, stdev=66650.95, samples=6
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=1.57%, 100=97.06%
  lat (usec)   : 250=1.37%, 500=0.01%
  cpu          : usr=42.84%, sys=56.55%, ctx=4056, majf=0, minf=9079
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=331621,524288,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=995MiB/s (1043MB/s), 995MiB/s-995MiB/s (1043MB/s-1043MB/s), io=1295MiB (1358MB), run=1302-1302msec
  WRITE: bw=785MiB/s (823MB/s), 785MiB/s-785MiB/s (823MB/s-823MB/s), io=2048MiB (2147MB), run=2609-2609msec

Disk stats (read/write):
  zram0: ios=327141/524288, merge=0/0, ticks=484/1980, in_queue=2464, util=97.57%
+ fio fio/randwrite.fio --ioengine=io_uring --size=20G --filename=/dev/zram0
RANDWRITE: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=2
...
fio-3.34
Starting 48 processes
Jobs: 48 (f=48): [w(48)][100.0%][w=714MiB/s][w=183k IOPS][eta 00m:00s]
RANDWRITE: (groupid=0, jobs=48): err= 0: pid=176785: Fri May 12 00:24:34 2023
  write: IOPS=214k, BW=836MiB/s (877MB/s)(49.0GiB/60002msec); 0 zone resets
    slat (nsec): min=381, max=1706.8k, avg=2462.04, stdev=2710.88
    clat (nsec): min=221, max=19317k, avg=445142.67, stdev=614360.19
     lat (usec): min=8, max=19319, avg=447.60, stdev=614.51
    clat percentiles (usec):
     |  1.00th=[   21],  5.00th=[   26], 10.00th=[   31], 20.00th=[   43],
     | 30.00th=[   55], 40.00th=[   74], 50.00th=[  251], 60.00th=[  465],
     | 70.00th=[  515], 80.00th=[  725], 90.00th=[ 1020], 95.00th=[ 1418],
     | 99.00th=[ 3228], 99.50th=[ 4015], 99.90th=[ 5407], 99.95th=[ 6063],
     | 99.99th=[ 7570]
   bw (  KiB/s): min=479679, max=1759836, per=100.00%, avg=857832.81, stdev=5081.52, samples=5712
   iops        : min=119913, max=439954, avg=214451.85, stdev=1270.39, samples=5712
  lat (nsec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (usec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.86%, 50=25.67%
  lat (usec)   : 100=18.97%, 250=4.47%, 500=17.37%, 750=12.90%, 1000=8.96%
  lat (msec)   : 2=8.51%, 4=1.77%, 10=0.50%, 20=0.01%
  cpu          : usr=5.18%, sys=9.25%, ctx=9890182, majf=0, minf=579
  IO depths    : 1=0.1%, 2=100.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,12840341,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
  WRITE: bw=836MiB/s (877MB/s), 836MiB/s-836MiB/s (877MB/s-877MB/s), io=49.0GiB (52.6GB), run=60002-60002msec

Disk stats (read/write):
  zram0: ios=0/12822005, merge=0/0, ticks=0/2558435, in_queue=2558435, util=99.96%
+ for i in 1 2 3
+ fio fio/randread.fio --ioengine=io_uring --size=20G --filename=/dev/zram0 --output=zram-default-nowait-off-1.fio
+ for i in 1 2 3 [r(48)][100.0%][r=3138MiB/s][r=803k IOPS][eta 00m:00s]
+ fio fio/randread.fio --ioengine=io_uring --size=20G --filename=/dev/zram0 --output=zram-default-nowait-off-2.fio
+ for i in 1 2 3 [r(48)][100.0%][r=3027MiB/s][r=775k IOPS][eta 00m:00s]
+ fio fio/randread.fio --ioengine=io_uring --size=20G --filename=/dev/zram0 --output=zram-default-nowait-off-3.fio
+ modprobe -r zramr(48)][100.0%][r=3074MiB/s][r=787k IOPS][eta 00m:00s]
+ modprobe zram nowait=1
+ sleep 1
+ zramctl -s 20GB /dev/zram0
+ sleep 1
+ test_nowait nowait-on
+ fio fio/verify.fio --ioengine=io_uring --size=2G --filename=/dev/zram0
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=16
fio-3.34
Starting 1 process
Jobs: 1 (f=1): [V(1)][80.0%][r=1192MiB/s,w=124MiB/s][r=305k,w=31.8k IOPS][eta 00m:01s]
write-and-verify: (groupid=0, jobs=1): err= 0: pid=177580: Fri May 12 00:27:46 2023
  read: IOPS=386k, BW=1507MiB/s (1581MB/s)(1293MiB/858msec)
    slat (nsec): min=1242, max=44093, avg=1777.71, stdev=460.23
    clat (nsec): min=721, max=92537, avg=38932.85, stdev=2677.45
     lat (nsec): min=2494, max=95692, avg=40710.56, stdev=2756.19
    clat percentiles (nsec):
     |  1.00th=[36608],  5.00th=[37120], 10.00th=[37632], 20.00th=[37632],
     | 30.00th=[38144], 40.00th=[38144], 50.00th=[38144], 60.00th=[38656],
     | 70.00th=[38656], 80.00th=[39168], 90.00th=[39680], 95.00th=[44800],
     | 99.00th=[49920], 99.50th=[54016], 99.90th=[64256], 99.95th=[65280],
     | 99.99th=[79360]
  write: IOPS=169k, BW=660MiB/s (692MB/s)(2048MiB/3104msec); 0 zone resets
    slat (usec): min=3, max=1097, avg= 5.59, stdev= 2.13
    clat (nsec): min=601, max=1389.5k, avg=88874.27, stdev=12749.86
     lat (usec): min=5, max=1402, avg=94.46, stdev=13.41
    clat percentiles (usec):
     |  1.00th=[   69],  5.00th=[   73], 10.00th=[   76], 20.00th=[   80],
     | 30.00th=[   84], 40.00th=[   87], 50.00th=[   90], 60.00th=[   92],
     | 70.00th=[   95], 80.00th=[   97], 90.00th=[  101], 95.00th=[  104],
     | 99.00th=[  116], 99.50th=[  128], 99.90th=[  167], 99.95th=[  186],
     | 99.99th=[  241]
   bw (  KiB/s): min=122368, max=788104, per=88.69%, avg=599186.29, stdev=219358.99, samples=7
   iops        : min=30592, max=197026, avg=149796.57, stdev=54839.75, samples=7
  lat (nsec)   : 750=0.01%
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=38.32%, 100=55.08%
  lat (usec)   : 250=6.60%, 500=0.01%
  lat (msec)   : 2=0.01%
  cpu          : usr=35.09%, sys=64.76%, ctx=6, majf=0, minf=9067
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=331086,524288,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1507MiB/s (1581MB/s), 1507MiB/s-1507MiB/s (1581MB/s-1581MB/s), io=1293MiB (1356MB), run=858-858msec
  WRITE: bw=660MiB/s (692MB/s), 660MiB/s-660MiB/s (692MB/s-692MB/s), io=2048MiB (2147MB), run=3104-3104msec

Disk stats (read/write):
  zram0: ios=304865/524288, merge=0/0, ticks=262/1514, in_queue=1776, util=97.57%
+ fio fio/randwrite.fio --ioengine=io_uring --size=20G --filename=/dev/zram0
RANDWRITE: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=2
...
fio-3.34
Starting 48 processes
Jobs: 48 (f=48): [w(48)][100.0%][w=759MiB/s][w=194k IOPS][eta 00m:00s]
RANDWRITE: (groupid=0, jobs=48): err= 0: pid=177583: Fri May 12 00:28:47 2023
  write: IOPS=227k, BW=887MiB/s (931MB/s)(52.0GiB/60001msec); 0 zone resets
    slat (usec): min=6, max=26750, avg=210.18, stdev=316.16
    clat (nsec): min=681, max=26752k, avg=211628.33, stdev=316425.45
     lat (usec): min=18, max=27199, avg=421.81, stdev=457.77
    clat percentiles (usec):
     |  1.00th=[   16],  5.00th=[   18], 10.00th=[   19], 20.00th=[   21],
     | 30.00th=[   23], 40.00th=[   26], 50.00th=[   29], 60.00th=[   36],
     | 70.00th=[  457], 80.00th=[  506], 90.00th=[  545], 95.00th=[  594],
     | 99.00th=[ 1074], 99.50th=[ 1254], 99.90th=[ 3425], 99.95th=[ 3687],
     | 99.99th=[ 4686]
   bw (  KiB/s): min=710189, max=1653080, per=100.00%, avg=910501.29, stdev=3653.62, samples=5712
   iops        : min=177535, max=413270, avg=227617.18, stdev=913.41, samples=5712
  lat (nsec)   : 750=0.01%, 1000=0.01%
  lat (usec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=16.56%, 50=49.44%
  lat (usec)   : 100=0.93%, 250=0.06%, 500=11.29%, 750=18.02%, 1000=1.51%
  lat (msec)   : 2=1.91%, 4=0.24%, 10=0.03%, 20=0.01%, 50=0.01%
  cpu          : usr=0.69%, sys=98.61%, ctx=26601, majf=0, minf=582
  IO depths    : 1=0.1%, 2=100.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,13631002,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
  WRITE: bw=887MiB/s (931MB/s), 887MiB/s-887MiB/s (931MB/s-931MB/s), io=52.0GiB (55.8GB), run=60001-60001msec

Disk stats (read/write):
  zram0: ios=0/13604021, merge=0/0, ticks=0/2807107, in_queue=2807107, util=99.95%
+ for i in 1 2 3
+ fio fio/randread.fio --ioengine=io_uring --size=20G --filename=/dev/zram0 --output=zram-nowait-on-1.fio
+ for i in 1 2 3 [r(48)][100.0%][r=3378MiB/s][r=865k IOPS][eta 00m:00s]
+ fio fio/randread.fio --ioengine=io_uring --size=20G --filename=/dev/zram0 --output=zram-nowait-on-2.fio
+ for i in 1 2 3 [r(48)][100.0%][r=3357MiB/s][r=859k IOPS][eta 00m:00s]
+ fio fio/randread.fio --ioengine=io_uring --size=20G --filename=/dev/zram0 --output=zram-nowait-on-3.fio
+ modprobe -r zramr(48)][100.0%][r=3357MiB/s][r=859k IOPS][eta 00m:00s]

linux-block (for-next) # for i in IOPS cpu; do grep $i zram*fio | column -t ; done
zram-default-nowait-off-1.fio:  read:  IOPS=802k,  BW=3133MiB/s  (3285MB/s)(184GiB/60001msec)
zram-default-nowait-off-2.fio:  read:  IOPS=796k,  BW=3111MiB/s  (3262MB/s)(182GiB/60002msec)
zram-default-nowait-off-3.fio:  read:  IOPS=796k,  BW=3108MiB/s  (3259MB/s)(182GiB/60002msec)
zram-nowait-on-1.fio:           read:  IOPS=857k,  BW=3346MiB/s  (3509MB/s)(196GiB/60001msec)
zram-nowait-on-2.fio:           read:  IOPS=857k,  BW=3347MiB/s  (3509MB/s)(196GiB/60001msec)
zram-nowait-on-3.fio:           read:  IOPS=858k,  BW=3353MiB/s  (3516MB/s)(196GiB/60001msec)
zram-default-nowait-off-1.fio:  cpu  :  usr=5.82%,  sys=13.54%,  ctx=36301915,  majf=0,  minf=687
zram-default-nowait-off-2.fio:  cpu  :  usr=5.84%,  sys=13.03%,  ctx=37781937,  majf=0,  minf=640
zram-default-nowait-off-3.fio:  cpu  :  usr=5.84%,  sys=12.90%,  ctx=37492533,  majf=0,  minf=688
zram-nowait-on-1.fio:           cpu  :  usr=1.74%,  sys=97.62%,  ctx=24068,     majf=0,  minf=783
zram-nowait-on-2.fio:           cpu  :  usr=1.74%,  sys=97.57%,  ctx=24674,     majf=0,  minf=763
zram-nowait-on-3.fio:           cpu  :  usr=1.76%,  sys=97.59%,  ctx=24725,     majf=0,  minf=723



-- 
2.40.0

