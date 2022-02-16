Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA0C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 09:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiBPJaw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:30:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiBPJat (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 04:30:49 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB94A257DF3
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 01:30:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9unZ+GolsWcAtqxhbvfzlabQPsT6rX/BZLuZTvxCObIa6lCemQyzSp9iGkg4ckKoatyRx1WRAOAHHMY62LqDmyxJwelDNOwYKGn/BjZkjX/s+WwjAxXJhGJ1lZOj7DvZD+Fb4QDazleNabnoWhZUIFt5c5M+Rlish2y2HBIRrxcwDzcKEBtff9rfaChESwTEYXZ4fT8leyCXyb0qpUEEANDk2mBEB5ODMdigNSNpRFqnGxAWMOAS8domf2/+WwIFC9AkO5msDaOG91y9KPgkFgQJnywcVQMDKbq5F6EYroncFNFQm7TIYn4FAGzrasW4Y37sA1A/N/X+WSywkGnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlTS+NUaRr/wkYjhQL01K0A+slafabyUb9DOuJP/uhw=;
 b=F+DFbbyHE7ZH8qRs6g0ttPj9pl/nMte+yW4zqcD3PVlXV+V4l+aTH1RQmzm7RZ7LEq6T3Dy83U+DJFDC2Kl0Wwb02CLol+TS/VSHA1297n74ZDFiphEUP75wnrHxqZtd9X3kEYbnWvI79Sj75AQrKHiEWDWaJfKLNsNRMAer9bUmOVmBylKCx15Z51O1C69vbfv71oMnBioaP36rVFiO6bXRDlkf3Vc+HL58wx6zFt1eZafMbIzf/qZ3Qkmgbxg88vsWYq9cRXdGj63cD1HCs8CjNXAfHCuTafs9xi+WPnHLIXkUc1FXsNUur2d99HI2vN6Tbu9N9GTYsoqXxc+RSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlTS+NUaRr/wkYjhQL01K0A+slafabyUb9DOuJP/uhw=;
 b=H8pPhqOmik3jIUzVJIO94Al0zY2IWSQj5CDA4wipBn61m5NYk7v+7CggdsZkGnPClEmT+pBRK8eZnH0BVYTExsss/Uq6aVK0jF39DIFy84gaWBAGyILjXvS+Od9WdZs+S4mYPyV91m2YI6/vfqEF848wGYu7Rfoe6EKJ7SMZjxUFQ5MFXNyi84KwDeAyBSMC+5DO3Zyc5NCZQGA5r8a5LTZW07C+DHnGzmOXBv/4YuHTrp3rDVIAvFyx79o4fK2yb4F8sqZ6tcvrEJ+53ZPLfR3GPsrifR3OTnzR9RAyr7ipF0hM/0cRzshVSue47lh7aMXwr+HTpWCpWrcxj3Q7fw==
Received: from MW4PR04CA0232.namprd04.prod.outlook.com (2603:10b6:303:87::27)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 09:30:34 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::22) by MW4PR04CA0232.outlook.office365.com
 (2603:10b6:303:87::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 09:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 09:30:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 09:30:27 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 01:30:27 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/2] null_blk: cleanup alloc_cmd()
Date:   Wed, 16 Feb 2022 01:30:18 -0800
Message-ID: <20220216093020.175351-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fda7e89-8c9b-4063-9105-08d9f12efb53
X-MS-TrafficTypeDiagnostic: MN2PR12MB3885:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB38859E68BD69B10ED28B854AA3359@MN2PR12MB3885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INA7dkb2YIE8RM6Y+1c096CO4IvZasNCyCWPdLHoAViArcbMa++GB4ov1Ih3JhuPzbDOogt9JkhZICtaHvNO/Nw42m+THLrfGGEmaVyMfBwBnLwNJ2vA8+1Xt+1hzVAYJMHxcu6fJNWmo5e3cAezBi8bkM5rM/TVI4ZaATIYYJwYDA2yC9RjROdGVRu3QbF56kcV/YJ4IUni+PLkj0Naon3AfRVVhC0AOejoP0DYdd5OMc/HGeSloICDtqvZ8yXRsc/wQwq86+XBw6UT0arROk+SDcNI30euevEbLB7w7SekkwTyQ2B9jAvwN7/zx7USfwFZF//S8ab2htGuXLV5ouopww9XwNcnSjSl8JmgjvUIej95DMs1bVSa9msrOT5zHrRAgTgniDxSpWaqMasBfkGOUUKlhkBlQd1rQXIxsNpF1VjLrPs9rl5OJrNc8md0FqyB5C1JGMHh1keMl8JMJfq0yzGwUnQONJ15/5vQd+90r7WZohlF5fRPqRAdBZlnBKm0/mLkyXjRbrbcytTQVDihTg3MfSJq0IF54VS+7lKp3/Psbl4hEwC2bJYw4lt2qvRPXa/hAy2Egbs089iRDM+IBWGwwAQ8vl9THVfkCayrAOt3SnlUf6nwZQZ+7wFXlLhSKPIylKoKBCazPCd1M3pl4k7gkJtM1neWUThK9IRZpvRfrREHcSq6X8sxcbZvHr+LCQtcKwDsFoWWQreZcQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(316002)(83380400001)(40460700003)(47076005)(6666004)(54906003)(1076003)(6916009)(508600001)(70586007)(2616005)(336012)(36860700001)(70206006)(426003)(81166007)(186003)(5660300002)(26005)(107886003)(8936002)(30864003)(4326008)(2906002)(8676002)(356005)(82310400004)(36756003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:30:33.5889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fda7e89-8c9b-4063-9105-08d9f12efb53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This has alloc_cmd() cleanup that removes statically hardcoded function
parameter and removes the need for the local variable on the stack.

Detailed test log is below that creates 5 memory backed nullb devices
with queue_mode=0 (NULL_Q_BIO) and runs fio verify job, here is the
summery:-

# grep err= p/null-blk-alloc-cmd/0000-cover-letter.patch 
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147181: Wed Feb 16 00:09:07 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147184: Wed Feb 16 00:09:09 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147187: Wed Feb 16 00:09:10 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147190: Wed Feb 16 00:09:11 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147193: Wed Feb 16 00:09:13 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147196: Wed Feb 16 00:09:14 2022

-ck

Chaitanya Kulkarni (2):
  null_blk: remove hardcoded alloc_cmd() parameter
  null_blk: remove local var & init cmd in alloc_cmd

 drivers/block/null_blk/main.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

fio verification test log for memory backed null_blk queue mode=0 (BIO):

root@dev linux-block (for-next) # git am p/null-blk-alloc-cmd/*patch ; git am --skip
Patch is empty.
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
Applying: null_blk: remove hardcoded alloc_cmd() parameter
Applying: null_blk: remove local var & init cmd in alloc_cmd
root@dev linux-block (for-next) # ./compile_nullb.sh 
+ umount /mnt/nullb0
umount: /mnt/nullb0: no mount point specified.
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ dmesg -c
+ modprobe -r null_blk
+ lsmod
+ grep null_blk
+ git apply wip.diff
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/pktcdvd.o
  CC [M]  drivers/block/null_blk/main.o
  LD [M]  drivers/block/null_blk/null_blk.o
  MODPOST drivers/block/Module.symvers
  LD [M]  drivers/block/null_blk/null_blk.ko
  LD [M]  drivers/block/pktcdvd.ko
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/5.17.0-rc3blk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.1M Feb 16 00:08 /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
root@dev linux-block (for-next) # ./nullbtests.sh 5
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ NN=5
+ modprobe -r null_blk
+ modprobe null_blk nr_devices=0 queue_mode=0
+ echo loading devices
loading devices
++ seq 0 5
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb0
+ mkdir config/nullb/nullb0
+ echo 1
+ echo 512
+ echo 2048
+ cat config/nullb/nullb0/queue_mode
0
+ echo 1
++ cat config/nullb/nullb0/index
+ IDX=0
+ echo -n ' 0 '
 0 + sleep .50
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb1
+ mkdir config/nullb/nullb1
+ echo 1
+ echo 512
+ echo 2048
+ cat config/nullb/nullb1/queue_mode
0
+ echo 1
++ cat config/nullb/nullb1/index
+ IDX=1
+ echo -n ' 1 '
 1 + sleep .50
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb2
+ mkdir config/nullb/nullb2
+ echo 1
+ echo 512
+ echo 2048
+ cat config/nullb/nullb2/queue_mode
0
+ echo 1
++ cat config/nullb/nullb2/index
+ IDX=2
+ echo -n ' 2 '
 2 + sleep .50
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb3
+ mkdir config/nullb/nullb3
+ echo 1
+ echo 512
+ echo 2048
+ cat config/nullb/nullb3/queue_mode
0
+ echo 1
++ cat config/nullb/nullb3/index
+ IDX=3
+ echo -n ' 3 '
 3 + sleep .50
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb4
+ mkdir config/nullb/nullb4
+ echo 1
+ echo 512
+ echo 2048
+ cat config/nullb/nullb4/queue_mode
0
+ echo 1
++ cat config/nullb/nullb4/index
+ IDX=4
+ echo -n ' 4 '
 4 + sleep .50
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb5
+ mkdir config/nullb/nullb5
+ echo 1
+ echo 512
+ echo 2048
+ cat config/nullb/nullb5/queue_mode
0
+ echo 1
++ cat config/nullb/nullb5/index
+ IDX=5
+ echo -n ' 5 '
 5 + sleep .50
+ lsblk
+ grep null
+ sort
nullb0  251:0    0    2G  0 disk 
nullb1  251:1    0    2G  0 disk 
nullb2  251:2    0    2G  0 disk 
nullb3  251:3    0    2G  0 disk 
nullb4  251:4    0    2G  0 disk 
nullb5  251:5    0    2G  0 disk 
+ sleep 1
+ dmesg -c
[40716.294759] null_blk: module loaded
+ lsblk
+ grep null
nullb0  251:0    0    2G  0 disk 
nullb1  251:1    0    2G  0 disk 
nullb2  251:2    0    2G  0 disk 
nullb3  251:3    0    2G  0 disk 
nullb4  251:4    0    2G  0 disk 
nullb5  251:5    0    2G  0 disk 
++ seq 0 5
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb0
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147181: Wed Feb 16 00:09:07 2022
  read: IOPS=106k, BW=415MiB/s (436MB/s)(158MiB/381msec)
    slat (usec): min=6, max=264, avg= 6.98, stdev= 1.71
    clat (usec): min=3, max=991, avg=142.46, stdev=20.06
     lat (usec): min=10, max=998, avg=149.48, stdev=20.15
    clat percentiles (usec):
     |  1.00th=[  137],  5.00th=[  139], 10.00th=[  139], 20.00th=[  139],
     | 30.00th=[  139], 40.00th=[  139], 50.00th=[  139], 60.00th=[  141],
     | 70.00th=[  141], 80.00th=[  145], 90.00th=[  153], 95.00th=[  157],
     | 99.00th=[  163], 99.50th=[  167], 99.90th=[  388], 99.95th=[  404],
     | 99.99th=[  996]
  write: IOPS=90.9k, BW=355MiB/s (372MB/s)(250MiB/704msec); 0 zone resets
    slat (usec): min=7, max=575, avg= 8.93, stdev= 3.38
    clat (usec): min=3, max=936, avg=166.52, stdev=34.55
     lat (usec): min=11, max=956, avg=175.51, stdev=36.35
    clat percentiles (usec):
     |  1.00th=[  149],  5.00th=[  151], 10.00th=[  153], 20.00th=[  155],
     | 30.00th=[  155], 40.00th=[  157], 50.00th=[  159], 60.00th=[  159],
     | 70.00th=[  163], 80.00th=[  167], 90.00th=[  176], 95.00th=[  186],
     | 99.00th=[  338], 99.50th=[  351], 99.90th=[  367], 99.95th=[  371],
     | 99.99th=[  930]
   bw (  KiB/s): min=156416, max=354874, per=70.30%, avg=255645.00, stdev=140331.00, samples=2
   iops        : min=39104, max=88718, avg=63911.00, stdev=35082.40, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=97.47%
  lat (usec)   : 500=2.48%, 1000=0.03%
  cpu          : usr=15.59%, sys=84.23%, ctx=6, majf=0, minf=968
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40522,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=415MiB/s (436MB/s), 415MiB/s-415MiB/s (436MB/s-436MB/s), io=158MiB (166MB), run=381-381msec
  WRITE: bw=355MiB/s (372MB/s), 355MiB/s-355MiB/s (372MB/s-372MB/s), io=250MiB (262MB), run=704-704msec

Disk stats (read/write):
  nullb0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb1
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147184: Wed Feb 16 00:09:09 2022
  read: IOPS=104k, BW=408MiB/s (428MB/s)(158MiB/387msec)
    slat (nsec): min=6572, max=89550, avg=7113.54, stdev=2792.32
    clat (usec): min=3, max=465, avg=145.00, stdev=15.42
     lat (usec): min=10, max=472, avg=152.16, stdev=15.88
    clat percentiles (usec):
     |  1.00th=[  139],  5.00th=[  139], 10.00th=[  139], 20.00th=[  141],
     | 30.00th=[  141], 40.00th=[  141], 50.00th=[  141], 60.00th=[  141],
     | 70.00th=[  143], 80.00th=[  145], 90.00th=[  157], 95.00th=[  159],
     | 99.00th=[  212], 99.50th=[  225], 99.90th=[  314], 99.95th=[  322],
     | 99.99th=[  433]
  write: IOPS=88.9k, BW=347MiB/s (364MB/s)(250MiB/720msec); 0 zone resets
    slat (nsec): min=6993, max=96042, avg=9156.56, stdev=2720.33
    clat (usec): min=3, max=450, avg=170.31, stdev=34.71
     lat (usec): min=12, max=470, avg=179.53, stdev=36.55
    clat percentiles (usec):
     |  1.00th=[  151],  5.00th=[  153], 10.00th=[  155], 20.00th=[  157],
     | 30.00th=[  157], 40.00th=[  159], 50.00th=[  161], 60.00th=[  163],
     | 70.00th=[  165], 80.00th=[  172], 90.00th=[  182], 95.00th=[  241],
     | 99.00th=[  343], 99.50th=[  351], 99.90th=[  379], 99.95th=[  396],
     | 99.99th=[  429]
   bw (  KiB/s): min=161568, max=350432, per=72.00%, avg=256000.00, stdev=133547.02, samples=2
   iops        : min=40392, max=87608, avg=64000.00, stdev=33386.75, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=97.09%
  lat (usec)   : 500=2.89%
  cpu          : usr=16.73%, sys=83.18%, ctx=1, majf=0, minf=967
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40429,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=408MiB/s (428MB/s), 408MiB/s-408MiB/s (428MB/s-428MB/s), io=158MiB (166MB), run=387-387msec
  WRITE: bw=347MiB/s (364MB/s), 347MiB/s-347MiB/s (364MB/s-364MB/s), io=250MiB (262MB), run=720-720msec

Disk stats (read/write):
  nullb1: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb2
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147187: Wed Feb 16 00:09:10 2022
  read: IOPS=107k, BW=417MiB/s (437MB/s)(158MiB/379msec)
    slat (nsec): min=6542, max=27301, avg=6923.84, stdev=1079.78
    clat (usec): min=3, max=3044, avg=141.83, stdev=56.14
     lat (usec): min=10, max=3051, avg=148.80, stdev=56.16
    clat percentiles (usec):
     |  1.00th=[  137],  5.00th=[  139], 10.00th=[  139], 20.00th=[  139],
     | 30.00th=[  139], 40.00th=[  139], 50.00th=[  139], 60.00th=[  139],
     | 70.00th=[  139], 80.00th=[  143], 90.00th=[  151], 95.00th=[  155],
     | 99.00th=[  159], 99.50th=[  161], 99.90th=[  169], 99.95th=[  176],
     | 99.99th=[ 3032]
  write: IOPS=90.4k, BW=353MiB/s (370MB/s)(250MiB/708msec); 0 zone resets
    slat (usec): min=7, max=109, avg= 8.98, stdev= 2.98
    clat (usec): min=3, max=437, avg=167.45, stdev=35.25
     lat (usec): min=11, max=456, avg=176.50, stdev=37.09
    clat percentiles (usec):
     |  1.00th=[  149],  5.00th=[  151], 10.00th=[  151], 20.00th=[  153],
     | 30.00th=[  155], 40.00th=[  157], 50.00th=[  159], 60.00th=[  161],
     | 70.00th=[  163], 80.00th=[  169], 90.00th=[  178], 95.00th=[  235],
     | 99.00th=[  343], 99.50th=[  355], 99.90th=[  404], 99.95th=[  416],
     | 99.99th=[  429]
   bw (  KiB/s): min=160240, max=351760, per=70.80%, avg=256000.00, stdev=135425.09, samples=2
   iops        : min=40060, max=87940, avg=64000.00, stdev=33856.27, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=97.36%
  lat (usec)   : 500=2.60%
  lat (msec)   : 4=0.01%
  cpu          : usr=15.30%, sys=84.42%, ctx=3, majf=0, minf=967
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40438,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=417MiB/s (437MB/s), 417MiB/s-417MiB/s (437MB/s-437MB/s), io=158MiB (166MB), run=379-379msec
  WRITE: bw=353MiB/s (370MB/s), 353MiB/s-353MiB/s (370MB/s-370MB/s), io=250MiB (262MB), run=708-708msec

Disk stats (read/write):
  nullb2: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb3
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147190: Wed Feb 16 00:09:11 2022
  read: IOPS=108k, BW=422MiB/s (442MB/s)(159MiB/376msec)
    slat (nsec): min=6533, max=32571, avg=6916.65, stdev=1061.06
    clat (usec): min=3, max=171, avg=140.45, stdev= 5.74
     lat (usec): min=10, max=178, avg=147.41, stdev= 5.88
    clat percentiles (usec):
     |  1.00th=[  137],  5.00th=[  137], 10.00th=[  139], 20.00th=[  139],
     | 30.00th=[  139], 40.00th=[  139], 50.00th=[  139], 60.00th=[  139],
     | 70.00th=[  139], 80.00th=[  143], 90.00th=[  151], 95.00th=[  155],
     | 99.00th=[  157], 99.50th=[  159], 99.90th=[  165], 99.95th=[  165],
     | 99.99th=[  172]
  write: IOPS=91.8k, BW=359MiB/s (376MB/s)(250MiB/697msec); 0 zone resets
    slat (nsec): min=7034, max=78768, avg=8833.05, stdev=2474.79
    clat (usec): min=3, max=370, avg=164.93, stdev=32.58
     lat (usec): min=11, max=387, avg=173.82, stdev=34.29
    clat percentiles (usec):
     |  1.00th=[  147],  5.00th=[  149], 10.00th=[  151], 20.00th=[  153],
     | 30.00th=[  155], 40.00th=[  155], 50.00th=[  157], 60.00th=[  159],
     | 70.00th=[  161], 80.00th=[  165], 90.00th=[  176], 95.00th=[  184],
     | 99.00th=[  338], 99.50th=[  347], 99.90th=[  355], 99.95th=[  359],
     | 99.99th=[  363]
   bw (  KiB/s): min=152648, max=359352, per=69.70%, avg=256000.00, stdev=146161.80, samples=2
   iops        : min=38162, max=89838, avg=64000.00, stdev=36540.45, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=97.62%
  lat (usec)   : 500=2.36%
  cpu          : usr=16.79%, sys=83.21%, ctx=1, majf=0, minf=969
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40603,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=422MiB/s (442MB/s), 422MiB/s-422MiB/s (442MB/s-442MB/s), io=159MiB (166MB), run=376-376msec
  WRITE: bw=359MiB/s (376MB/s), 359MiB/s-359MiB/s (376MB/s-376MB/s), io=250MiB (262MB), run=697-697msec

Disk stats (read/write):
  nullb3: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb4
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147193: Wed Feb 16 00:09:13 2022
  read: IOPS=107k, BW=418MiB/s (439MB/s)(158MiB/378msec)
    slat (nsec): min=6573, max=29957, avg=6952.35, stdev=1092.02
    clat (usec): min=3, max=215, avg=141.35, stdev= 6.36
     lat (usec): min=10, max=225, avg=148.35, stdev= 6.51
    clat percentiles (usec):
     |  1.00th=[  137],  5.00th=[  139], 10.00th=[  139], 20.00th=[  139],
     | 30.00th=[  139], 40.00th=[  139], 50.00th=[  139], 60.00th=[  139],
     | 70.00th=[  141], 80.00th=[  143], 90.00th=[  153], 95.00th=[  157],
     | 99.00th=[  161], 99.50th=[  165], 99.90th=[  174], 99.95th=[  192],
     | 99.99th=[  212]
  write: IOPS=90.4k, BW=353MiB/s (370MB/s)(250MiB/708msec); 0 zone resets
    slat (nsec): min=7033, max=86665, avg=8993.79, stdev=2568.28
    clat (usec): min=3, max=377, avg=167.49, stdev=33.02
     lat (usec): min=11, max=397, avg=176.55, stdev=34.75
    clat percentiles (usec):
     |  1.00th=[  149],  5.00th=[  151], 10.00th=[  153], 20.00th=[  155],
     | 30.00th=[  155], 40.00th=[  157], 50.00th=[  159], 60.00th=[  161],
     | 70.00th=[  163], 80.00th=[  169], 90.00th=[  178], 95.00th=[  204],
     | 99.00th=[  338], 99.50th=[  347], 99.90th=[  359], 99.95th=[  359],
     | 99.99th=[  371]
   bw (  KiB/s): min=158648, max=353352, per=70.80%, avg=256000.00, stdev=137676.52, samples=2
   iops        : min=39662, max=88338, avg=64000.00, stdev=34419.13, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=97.45%
  lat (usec)   : 500=2.53%
  cpu          : usr=16.42%, sys=83.58%, ctx=3, majf=0, minf=967
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40484,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=418MiB/s (439MB/s), 418MiB/s-418MiB/s (439MB/s-439MB/s), io=158MiB (166MB), run=378-378msec
  WRITE: bw=353MiB/s (370MB/s), 353MiB/s-353MiB/s (370MB/s-370MB/s), io=250MiB (262MB), run=708-708msec

Disk stats (read/write):
  nullb4: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb5
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=147196: Wed Feb 16 00:09:14 2022
  read: IOPS=106k, BW=413MiB/s (433MB/s)(158MiB/383msec)
    slat (nsec): min=6582, max=79441, avg=7054.21, stdev=1404.54
    clat (usec): min=3, max=362, avg=143.50, stdev=10.11
     lat (usec): min=10, max=378, avg=150.60, stdev=10.45
    clat percentiles (usec):
     |  1.00th=[  139],  5.00th=[  139], 10.00th=[  139], 20.00th=[  139],
     | 30.00th=[  141], 40.00th=[  141], 50.00th=[  141], 60.00th=[  141],
     | 70.00th=[  143], 80.00th=[  145], 90.00th=[  157], 95.00th=[  161],
     | 99.00th=[  169], 99.50th=[  174], 99.90th=[  273], 99.95th=[  318],
     | 99.99th=[  334]
  write: IOPS=91.7k, BW=358MiB/s (376MB/s)(250MiB/698msec); 0 zone resets
    slat (nsec): min=7104, max=68841, avg=8834.00, stdev=2372.91
    clat (usec): min=3, max=388, avg=165.07, stdev=27.10
     lat (usec): min=11, max=407, avg=173.97, stdev=28.46
    clat percentiles (usec):
     |  1.00th=[  149],  5.00th=[  151], 10.00th=[  153], 20.00th=[  155],
     | 30.00th=[  155], 40.00th=[  157], 50.00th=[  159], 60.00th=[  161],
     | 70.00th=[  163], 80.00th=[  169], 90.00th=[  178], 95.00th=[  186],
     | 99.00th=[  322], 99.50th=[  355], 99.90th=[  371], 99.95th=[  375],
     | 99.99th=[  383]
   bw (  KiB/s): min=149928, max=362072, per=69.80%, avg=256000.00, stdev=150008.46, samples=2
   iops        : min=37482, max=90518, avg=64000.00, stdev=37502.12, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=98.32%
  lat (usec)   : 500=1.65%
  cpu          : usr=16.03%, sys=83.87%, ctx=2, majf=0, minf=968
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40473,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=413MiB/s (433MB/s), 413MiB/s-413MiB/s (433MB/s-433MB/s), io=158MiB (166MB), run=383-383msec
  WRITE: bw=358MiB/s (376MB/s), 358MiB/s-358MiB/s (376MB/s-376MB/s), io=250MiB (262MB), run=698-698msec

Disk stats (read/write):
  nullb5: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%

blktests results :-

root@dev blktests (master) # ./check block
block/001 (stress device hotplugging)                        [passed]
    runtime  89.813s  ...  91.043s
block/002 (remove a device while running blktrace)           [passed]
    runtime  1.824s  ...  1.852s
block/006 (run null-blk in blocking mode)                    [passed]
    read iops  364023    ...  359050
    runtime    181.911s  ...  184.498s
block/009 (check page-cache coherency after BLKDISCARD)      [passed]
    runtime  0.926s  ...  1.067s
block/010 (run I/O on null_blk with shared and non-shared tags) [passed]
    Individual tags read iops  448837    ...  445592
    runtime                    315.205s  ...  316.587s
    Shared tags read iops      449357    ...  448645
block/014 (run null-blk with blk-mq and timeout injection configured) [not run]
    null_blk module does not have parameter timeout
block/015 (run null-blk on different schedulers with requeue injection configured) [not run]
    null_blk module does not have parameter requeue
block/016 (send a signal to a process waiting on a frozen queue) [passed]
    runtime  7.201s  ...  7.199s
block/017 (do I/O and check the inflight counter)            [passed]
    runtime  1.845s  ...  1.846s
block/018 (do I/O and check iostats times)                   [passed]
    runtime  5.316s  ...  5.323s
block/020 (run null-blk on different schedulers with only one hardware tag) [passed]
    runtime  31.868s  ...  31.902s
block/021 (read/write nr_requests on null-blk with different schedulers) [passed]
    runtime  4.234s  ...  4.095s
block/022 (Test hang caused by freeze/unfreeze sequence)     [passed]
    runtime  30.287s  ...  30.249s
block/023 (do I/O on all null_blk queue modes)               [passed]
    runtime  0.580s  ...  0.571s
block/024 (do I/O faster than a jiffy and check iostats times) [passed]
    runtime  3.042s  ...  3.064s
block/025 (do a huge discard with 4k sector size)            [passed]
    runtime  4.419s  ...  4.404s
block/027 (stress device hotplugging with running fio jobs and different schedulers) [passed]
    runtime  21.121s  ...  21.100s
block/028 (do I/O on scsi_debug with DIF/DIX enabled)        [passed]
    runtime  55.964s  ...  55.719s
block/029 (trigger blk_mq_update_nr_hw_queues())             [passed]
    runtime  30.547s  ...  30.520s
block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [not run]
    null_blk module does not have parameter init_hctx
block/031 (do IO on null-blk with a host tag set)            [passed]
    runtime  30.512s  ...  30.503s

-- 
2.29.0

