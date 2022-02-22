Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5880C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 15:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiBVP3c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiBVP3b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 10:29:31 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EDD15F36A
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 07:29:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwISURCOF4v0i/nXSY/ILQ7gDjijSl2+iPM9pR4cBHxq9BnSdlRI9T6QXxaRI/ithx3knIIIe8SFQJxyMAnU4iMroLnbeezenbb97UblD2wgWjdzSv0g5GlQejLCRxXg0w+NnfZb57eB1SvO6og875pPO2sVmrY53OFC5IPS4MH1vLOIVrdpi7iX4zunw0Mn8Zuh5ohLVMwGUa3wToXBYMBR1Wpi8xMiREKXsL3KolSjm+BMGalQ/LVvEgxw47kwN4mqzJey2Zd5Ov7KjkmIukKpXNfYgpnaxRgy4vhdumMyZAouo9w9EbvSUYoKpdS93iL09/YZUUBm0OyXc1ji4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJMpIS8rFKb9Xbe4h5t2bjLkH1XbwE1KHmPlNwuHIM4=;
 b=NUdVNrrxshydvr+Zai7ipw8YQMDk4KYy5O6JGz1ygANTFXwYroptEAziknIH0V/9oiacPL3yk01YkBnove4ecdKEANavkHCPlqvOa4Bs/8INK77q+PJDetJyttkCymoQnaoBCyBjIedXMeIeNth1+6hLXwsCrilUvQtQ4g2AeOTpFzr9ODVqNaJzTpyc0dzi0C6ahxfjupRcp/yAiYU3RsS6GOtN6vezwOlwPz/orq/TaC/EIJ2Crs9CGgl7LZsx4nrDfR6HkDKcwYSnV/WqJZ7sJvkLEf/+U+E25Bl+lKVfkYuX4dTxM1AV+OJ1JIoZ2VvI6ZN5vCgs4/Bm/K5HYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJMpIS8rFKb9Xbe4h5t2bjLkH1XbwE1KHmPlNwuHIM4=;
 b=qiu38CQoAmhlQiiAbJGEYV6cY3SWDjpwkcPjVgY6bwnm3D/Bz5A/7tq4v7SQrme9apjYUeeihuG5Yu1SBeTskueyZMP3JZxquFSEXrpP21GeTf7iiYxC9zZGAkgFoDFO9rzStV4OK6k6m1H0ACbxoefE7nubJ1pemCcyGyvJsYeQUXYsUu6kxIL7rs6nnu5MueN0u2709scTlHB3zFJ4MQSMc2nmIuvk4czNYqiJo95UDvrAjMNvdv6VEAXNGMIn1erzuyNASCC5p1hD3oNz0mXUIQgEvKXfslkM6bgGzD29gJOAxnmN/Crru9OfZ2VXNZ/Ch/rVFj+yCH9CPvntDQ==
Received: from DM5PR21CA0034.namprd21.prod.outlook.com (2603:10b6:3:ed::20) by
 BYAPR12MB3413.namprd12.prod.outlook.com (2603:10b6:a03:ab::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Tue, 22 Feb 2022 15:29:02 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::b1) by DM5PR21CA0034.outlook.office365.com
 (2603:10b6:3:ed::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.7 via Frontend
 Transport; Tue, 22 Feb 2022 15:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:29:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Feb
 2022 15:29:00 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 07:28:59 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <damien.lemoal@wdc.com>,
        <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/2] null_blk: null_alloc_page() cleanup
Date:   Tue, 22 Feb 2022 07:28:50 -0800
Message-ID: <20220222152852.26043-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae52ce27-eb74-4b92-aaca-08d9f6180d99
X-MS-TrafficTypeDiagnostic: BYAPR12MB3413:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34137BB94B83C7210506AE0CA33B9@BYAPR12MB3413.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plQKp+7JQ//WtVgX4C0eQP3YcgINhR1BwSTNhHflsU0Xz/kbftEHzjSEExCj8TeaeQ2pNQHenk+O3Kptc3H9e7AqrAvnUQM3WoGmaDus3i2SO/VV0QHAMIBh7WwhB86CmhOlo/YK268mZaNA/LqjNK41AxZGYTbSfkziYDTsITX5/bZLZXPXSgLSSObrbj3S3bZNhy2y7CFBZafNRpl8ZYFGAwHxbIfUW9QGRPgDhtAUwvh8kw4S8/ytdbdkdceB1gb/HVKzBfVySBGo1KAMQpsCadagctQQvFMBqPXjd3sc5dzDeJV/p10teN2cN9BYK2rgpP8fnDWceDWMw14ce/02OhRyVMiLiBi5qsYb/1BlzelQqLH8TXJwIR0rvAs39shPu3IVCFKTpP70CDKs3VOS0J+Tb6+SAago536S2Ob6yV0yr1vJwv7mLXMs/cNY4OuywcTyne9cTT+d+2Xxl8YXJO2dkCSDztBkM0nAQ41e77qEVn227EhbvxjKKbT+vhqgowvyG1FBxbeCbLd1eTK9HgQbCbuIuo7K4EBLwSzFA+N7iewPqRPiow0dh1OwBcDEZrDBRGXxA3aXYK5T/BvccisufqoyylxkPYAdaul3aD0BwBsjiDw1t+Qu3Tv4t0hy/DKh8Jw2H6iJwWUR5br2UvvAq9ujL16nZvbbPzeOngZzVZVL+CnAyOr9foWHS2bCNl65bvWJQqwVEwWcCw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(30864003)(47076005)(336012)(83380400001)(426003)(36756003)(40460700003)(5660300002)(8936002)(2906002)(82310400004)(2616005)(7696005)(107886003)(36860700001)(16526019)(186003)(26005)(70206006)(70586007)(1076003)(356005)(81166007)(6916009)(54906003)(6666004)(508600001)(316002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:29:01.5583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae52ce27-eb74-4b92-aaca-08d9f6180d99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3413
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This has null_alloc_page() cleanup to remvoe the unwanted function
parameter and remove function goto labels where we can return easily.

Below is the test log of memory backed null_blk with fio verify job and
blktests output.

-ck

Chaitanya Kulkarni (2):
  null_blk: remove hardcoded null_alloc_page() param
  null_blk: null_alloc_page() cleanup

 drivers/block/null_blk/main.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

root@dev linux-block (for-next) # gitlog -2
a87f21820d03 (HEAD -> for-next) Merge branch 'for-next' of git://git.kernel.dk/linux-block into for-next
bc2959102cb9 (origin/for-next) Merge branch 'for-5.18/block' into for-next
root@dev linux-block (for-next) # git am p/null-blk-alloc_page/*patch  ; git am --skip 
Patch is empty.
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
Applying: null_blk: remove hardcoded null_alloc_page() param
Applying: null_blk: null_alloc_page() cleanup
root@dev linux-block (for-next) # ./compile_nullb.sh 
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
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
-rw-r--r--. 1 root root 1.1M Feb 22 06:47 /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ git checkout include/scsi/scsi_device.h
Updated 1 path from the index
+ dmesg -c
root@dev linux-block (for-next) # ./nullbtests.sh 3
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ NN=3
+ modprobe -r null_blk
+ modprobe null_blk nr_devices=0
+ echo loading devices
loading devices
++ seq 0 3
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
+ lsblk
+ grep null
+ sort
nullb0  251:0    0    2G  0 disk 
nullb1  251:1    0    2G  0 disk 
nullb2  251:2    0    2G  0 disk 
nullb3  251:3    0    2G  0 disk 
+ sleep 1
+ dmesg -c
[ 1086.952379] null_blk: module loaded
+ lsblk
+ grep null
nullb0  251:0    0    2G  0 disk 
nullb1  251:1    0    2G  0 disk 
nullb2  251:2    0    2G  0 disk 
nullb3  251:3    0    2G  0 disk 
++ seq 0 3
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb0
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=13415: Tue Feb 22 06:47:54 2022
  read: IOPS=93.8k, BW=366MiB/s (384MB/s)(158MiB/431msec)
    slat (nsec): min=7755, max=30347, avg=8214.90, stdev=1225.66
    clat (usec): min=3, max=202, avg=161.41, stdev= 5.89
     lat (usec): min=11, max=210, avg=169.69, stdev= 5.99
    clat percentiles (usec):
     |  1.00th=[  157],  5.00th=[  157], 10.00th=[  157], 20.00th=[  157],
     | 30.00th=[  159], 40.00th=[  159], 50.00th=[  159], 60.00th=[  159],
     | 70.00th=[  163], 80.00th=[  167], 90.00th=[  172], 95.00th=[  174],
     | 99.00th=[  178], 99.50th=[  180], 99.90th=[  188], 99.95th=[  190],
     | 99.99th=[  202]
  write: IOPS=80.0k, BW=313MiB/s (328MB/s)(250MiB/800msec); 0 zone resets
    slat (usec): min=8, max=447, avg=10.37, stdev= 3.22
    clat (usec): min=3, max=434, avg=188.97, stdev=34.29
     lat (usec): min=12, max=801, avg=199.41, stdev=36.21
    clat percentiles (usec):
     |  1.00th=[  169],  5.00th=[  174], 10.00th=[  174], 20.00th=[  176],
     | 30.00th=[  178], 40.00th=[  180], 50.00th=[  182], 60.00th=[  184],
     | 70.00th=[  188], 80.00th=[  192], 90.00th=[  198], 95.00th=[  204],
     | 99.00th=[  375], 99.50th=[  392], 99.90th=[  404], 99.95th=[  408],
     | 99.99th=[  429]
   bw (  KiB/s): min=201320, max=310680, per=80.00%, avg=256000.00, stdev=77329.20, samples=2
   iops        : min=50330, max=77670, avg=64000.00, stdev=19332.30, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=97.53%
  lat (usec)   : 500=2.45%
  cpu          : usr=13.66%, sys=86.26%, ctx=1, majf=0, minf=966
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40428,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=366MiB/s (384MB/s), 366MiB/s-366MiB/s (384MB/s-384MB/s), io=158MiB (166MB), run=431-431msec
  WRITE: bw=313MiB/s (328MB/s), 313MiB/s-313MiB/s (328MB/s-328MB/s), io=250MiB (262MB), run=800-800msec

Disk stats (read/write):
  nullb0: ios=27074/64000, merge=0/0, ticks=42/177, in_queue=219, util=91.51%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb1
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=13418: Tue Feb 22 06:47:55 2022
  read: IOPS=90.4k, BW=353MiB/s (370MB/s)(158MiB/448msec)
    slat (nsec): min=7664, max=36409, avg=8462.57, stdev=1693.70
    clat (usec): min=3, max=307, avg=167.50, stdev=12.40
     lat (usec): min=17, max=322, avg=176.03, stdev=12.82
    clat percentiles (usec):
     |  1.00th=[  157],  5.00th=[  159], 10.00th=[  161], 20.00th=[  161],
     | 30.00th=[  163], 40.00th=[  163], 50.00th=[  163], 60.00th=[  165],
     | 70.00th=[  169], 80.00th=[  174], 90.00th=[  178], 95.00th=[  182],
     | 99.00th=[  233], 99.50th=[  258], 99.90th=[  289], 99.95th=[  293],
     | 99.99th=[  302]
  write: IOPS=76.9k, BW=300MiB/s (315MB/s)(250MiB/832msec); 0 zone resets
    slat (usec): min=7, max=681, avg=10.81, stdev= 4.43
    clat (usec): min=3, max=1057, avg=196.71, stdev=50.00
     lat (usec): min=12, max=1080, avg=207.59, stdev=52.64
    clat percentiles (usec):
     |  1.00th=[  172],  5.00th=[  174], 10.00th=[  174], 20.00th=[  176],
     | 30.00th=[  178], 40.00th=[  180], 50.00th=[  182], 60.00th=[  184],
     | 70.00th=[  188], 80.00th=[  192], 90.00th=[  212], 95.00th=[  351],
     | 99.00th=[  388], 99.50th=[  396], 99.90th=[  537], 99.95th=[  578],
     | 99.99th=[  971]
   bw (  KiB/s): min=220328, max=291672, per=83.20%, avg=256000.00, stdev=50447.83, samples=2
   iops        : min=55082, max=72918, avg=64000.00, stdev=12611.96, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=94.16%
  lat (usec)   : 500=5.73%, 750=0.07%, 1000=0.01%
  lat (msec)   : 2=0.01%
  cpu          : usr=14.86%, sys=85.14%, ctx=3, majf=0, minf=967
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40495,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=353MiB/s (370MB/s), 353MiB/s-353MiB/s (370MB/s-370MB/s), io=158MiB (166MB), run=448-448msec
  WRITE: bw=300MiB/s (315MB/s), 300MiB/s-300MiB/s (315MB/s-315MB/s), io=250MiB (262MB), run=832-832msec

Disk stats (read/write):
  nullb1: ios=27149/64000, merge=0/0, ticks=45/185, in_queue=231, util=91.81%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb2
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=13428: Tue Feb 22 06:47:57 2022
  read: IOPS=94.3k, BW=368MiB/s (386MB/s)(158MiB/429msec)
    slat (nsec): min=7705, max=37021, avg=8173.44, stdev=1307.59
    clat (usec): min=3, max=223, avg=160.64, stdev= 6.55
     lat (usec): min=11, max=231, avg=168.87, stdev= 6.70
    clat percentiles (usec):
     |  1.00th=[  155],  5.00th=[  157], 10.00th=[  157], 20.00th=[  157],
     | 30.00th=[  157], 40.00th=[  157], 50.00th=[  157], 60.00th=[  159],
     | 70.00th=[  161], 80.00th=[  167], 90.00th=[  172], 95.00th=[  174],
     | 99.00th=[  180], 99.50th=[  186], 99.90th=[  208], 99.95th=[  210],
     | 99.99th=[  219]
  write: IOPS=80.5k, BW=314MiB/s (330MB/s)(250MiB/795msec); 0 zone resets
    slat (nsec): min=8055, max=92325, avg=10308.42, stdev=2763.18
    clat (usec): min=3, max=430, avg=187.82, stdev=34.03
     lat (usec): min=13, max=454, avg=198.19, stdev=35.85
    clat percentiles (usec):
     |  1.00th=[  169],  5.00th=[  172], 10.00th=[  174], 20.00th=[  176],
     | 30.00th=[  176], 40.00th=[  178], 50.00th=[  180], 60.00th=[  182],
     | 70.00th=[  186], 80.00th=[  190], 90.00th=[  196], 95.00th=[  206],
     | 99.00th=[  371], 99.50th=[  383], 99.90th=[  404], 99.95th=[  416],
     | 99.99th=[  424]
   bw (  KiB/s): min=199456, max=312544, per=79.50%, avg=256000.00, stdev=79965.29, samples=2
   iops        : min=49864, max=78136, avg=64000.00, stdev=19991.32, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=97.45%
  lat (usec)   : 500=2.53%
  cpu          : usr=15.04%, sys=84.79%, ctx=1, majf=0, minf=966
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40451,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=368MiB/s (386MB/s), 368MiB/s-368MiB/s (386MB/s-386MB/s), io=158MiB (166MB), run=429-429msec
  WRITE: bw=314MiB/s (330MB/s), 314MiB/s-314MiB/s (330MB/s-330MB/s), io=250MiB (262MB), run=795-795msec

Disk stats (read/write):
  nullb2: ios=29364/64000, merge=0/0, ticks=45/174, in_queue=220, util=91.64%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb3
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=13431: Tue Feb 22 06:47:58 2022
  read: IOPS=96.2k, BW=376MiB/s (394MB/s)(158MiB/421msec)
    slat (nsec): min=7393, max=52019, avg=7988.62, stdev=1575.15
    clat (usec): min=3, max=264, avg=157.17, stdev=10.48
     lat (usec): min=11, max=280, avg=165.22, stdev=10.81
    clat percentiles (usec):
     |  1.00th=[  151],  5.00th=[  151], 10.00th=[  151], 20.00th=[  153],
     | 30.00th=[  153], 40.00th=[  153], 50.00th=[  153], 60.00th=[  155],
     | 70.00th=[  157], 80.00th=[  163], 90.00th=[  167], 95.00th=[  169],
     | 99.00th=[  208], 99.50th=[  231], 99.90th=[  251], 99.95th=[  255],
     | 99.99th=[  265]
  write: IOPS=81.8k, BW=320MiB/s (335MB/s)(250MiB/782msec); 0 zone resets
    slat (usec): min=7, max=201, avg=10.15, stdev= 3.28
    clat (usec): min=3, max=689, avg=184.88, stdev=37.38
     lat (usec): min=13, max=699, avg=195.10, stdev=39.33
    clat percentiles (usec):
     |  1.00th=[  163],  5.00th=[  167], 10.00th=[  167], 20.00th=[  169],
     | 30.00th=[  172], 40.00th=[  174], 50.00th=[  176], 60.00th=[  178],
     | 70.00th=[  182], 80.00th=[  186], 90.00th=[  194], 95.00th=[  258],
     | 99.00th=[  375], 99.50th=[  383], 99.90th=[  404], 99.95th=[  412],
     | 99.99th=[  586]
   bw (  KiB/s): min=193824, max=318176, per=78.20%, avg=256000.00, stdev=87930.14, samples=2
   iops        : min=48456, max=79544, avg=64000.00, stdev=21982.54, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=96.78%
  lat (usec)   : 500=3.19%, 750=0.01%
  cpu          : usr=15.56%, sys=84.19%, ctx=0, majf=0, minf=968
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40513,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), io=158MiB (166MB), run=421-421msec
  WRITE: bw=320MiB/s (335MB/s), 320MiB/s-320MiB/s (335MB/s-335MB/s), io=250MiB (262MB), run=782-782msec

Disk stats (read/write):
  nullb3: ios=27496/64000, merge=0/0, ticks=42/172, in_queue=215, util=91.45%
+ echo deleteing devices
deleteing devices
++ seq 0 3
+ for i in `seq 0 $NN`
+ rmdir config/nullb/nullb0
+ for i in `seq 0 $NN`
+ rmdir config/nullb/nullb1
+ for i in `seq 0 $NN`
+ rmdir config/nullb/nullb2
+ for i in `seq 0 $NN`
+ rmdir config/nullb/nullb3
+ modprobe -r null_blk
root@dev linux-block (for-next) # cdblktests 
root@dev blktests (master) # ./check block
block/001 (stress device hotplugging)                        [passed]
    runtime  94.285s  ...  107.074s
block/002 (remove a device while running blktrace)           [passed]
    runtime  1.836s  ...  1.852s
block/006 (run null-blk in blocking mode)                    [passed]
    read iops  334390    ...  376026
    runtime    197.045s  ...  176.328s
block/009 (check page-cache coherency after BLKDISCARD)      [passed]
    runtime  0.960s  ...  0.970s
block/010 (run I/O on null_blk with shared and non-shared tags) [passed]
    Individual tags read iops    ...  448657
    runtime                      ...  315.200s
    Shared tags read iops        ...  450129
block/014 (run null-blk with blk-mq and timeout injection configured) [not run]
    null_blk module does not have parameter timeout
block/015 (run null-blk on different schedulers with requeue injection configured) [not run]
    null_blk module does not have parameter requeue
block/016 (send a signal to a process waiting on a frozen queue) [passed]
    runtime  7.206s  ...  7.210s
block/017 (do I/O and check the inflight counter)            [passed]
    runtime  1.847s  ...  1.851s
block/018 (do I/O and check iostats times)                   [passed]
    runtime  5.322s  ...  5.321s
block/020 (run null-blk on different schedulers with only one hardware tag) [passed]
    runtime  31.856s  ...  31.852s
block/021 (read/write nr_requests on null-blk with different schedulers) [passed]
    runtime  4.096s  ...  4.031s
block/022 (Test hang caused by freeze/unfreeze sequence)     [passed]
    runtime  30.270s  ...  30.211s
block/023 (do I/O on all null_blk queue modes)               [passed]
    runtime  0.630s  ...  0.629s
block/024 (do I/O faster than a jiffy and check iostats times) [passed]
    runtime  3.042s  ...  3.046s
block/025 (do a huge discard with 4k sector size)            [passed]
    runtime  4.369s  ...  4.397s
block/027 (stress device hotplugging with running fio jobs and different schedulers) [passed]
    runtime  21.158s  ...  21.039s
block/028 (do I/O on scsi_debug with DIF/DIX enabled)        [passed]
    runtime  57.059s  ...  57.230s
block/029 (trigger blk_mq_update_nr_hw_queues())             [passed]
    runtime  30.511s  ...  30.535s
block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [not run]
    null_blk module does not have parameter init_hctx
block/031 (do IO on null-blk with a host tag set)            [passed]
    runtime  30.537s  ...  30.529s
root@dev blktests (master) # 


-- 
2.29.0

