Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E11C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 17:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiBPRaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:30:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiBPRaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 12:30:24 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58020205743
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 09:30:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhXgbhPvGiTjixuQDrv1Ot7Ks9cNxlbTNKT9CKbtFsAwHAu9oC7cFKkqlADGdeQLk+eOzHBQzDJepX2pVKG0RQ5TfVusIcT2m1Qent8H5+M0AWFZgS1QAQto4zJ+HZtsKJZVyjy7ueq46H0e+Btys5fL6z/PHyz5zuyHzyopolmw9dg7U3jf7QAqpyK3Ji8ck4pbaQHfL1fWeXsfVqB6xPhmbw38KLiso3z6OI3z/vpwvBOkyWfeLaBdqV22Ho62/0nTxEbyLu5xWEsag2K96G8t0MnwLBLvPNjL7nvPwkDQKzIpucjhEQcOoVo+yBnIcTk/NfI0dkGe9hOzOEcAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0GL8h1U22E+gbpDoMi5JGss4sK6G11RNxP7/2eAqTA=;
 b=bbyd5LWEgoKSmAvW3INtQd0linkSazIWPZYkrPT6jGPDd0WEqdwJ3kUFpSYHzClr0WSpb12ZUfBnl1LyKBfJ+s4LmkNHq/yM2tDBRsCr2yNVVrEWOizOmWK+b99JmZT9O3CRKlkRfOBXs9cRtUqDVTzZL9uv8vIPuRwpei2ICSVbioA+LYPd5LbLUGWtJi34E0tTUtGY5whvePaAzEWg2s6FrntZaU0I3eYwghLD5bSxdz9gXD2DJXAotPEGsPuSgCnGJ1WMAjfMgRfxSyHBC7v/qbT3IBENab+8hY5pS0BFDa85l1zAYA0hlbl+U1BIyhiplRskApzNQG2vkfGeMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0GL8h1U22E+gbpDoMi5JGss4sK6G11RNxP7/2eAqTA=;
 b=L77EPTe7ESY9A9L4ahmtzXKdzSW9eyLqWiX6nexsHJq4xdiJ2MXc3hKuaUMWmc6qbykHyQ7Y2UEfBvZlnX76CwxcHYU6nByP+X5NvVtyAtU8QSIQikF6LSv5AEev0AlmgFxR7pFu3AGOaH1DLbJTMY2ItsemwQ4i84rCZ8nJKOGZ4SXErKgAdqSVV+m83JtIxs/ehcaxh6+jJsStOGBj3luIhVN2GksoA70TynmI28WF8t9lcogLnEaUEyihcBi7wWDYhe11mjC954m0UNKYAjiLL0ETuWeJ809bNfSp3N1a0gSxU8j3nQYRV7u+fkc7aDJZgd/RVK8MJJi+Xhop7w==
Received: from DS7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::25) by
 BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.12; Wed, 16 Feb 2022 17:30:08 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::b4) by DS7P222CA0022.outlook.office365.com
 (2603:10b6:8:2e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 17:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 17:30:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 17:30:04 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 09:30:03 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 0/1] null_blk: cleanup null_submit_bio() & alloc_cmd()
Date:   Wed, 16 Feb 2022 09:29:44 -0800
Message-ID: <20220216172945.31124-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04066f1f-a5b5-4e7e-b9c7-08d9f171f9e1
X-MS-TrafficTypeDiagnostic: BN7PR12MB2740:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2740C3DDB340CE610F150185A3359@BN7PR12MB2740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ji/YgWYUvBVnOhUdgBuvJKU7OwsoCBHImGmJJ8rDBAtzSOq9UBfXQfQ/muHgBIbqcPeR227fI+tV3CA/+grlRxvoqJHFZKMFyRI5hTaih3jFnZD+GdH/XAeEpNfr/92KDUX66+FxMOizoG15qVhZWXr9AZRl8TCareBbT6Fnt1hCszUK51t2FjwbDTmEQ3THfx8RMtlMJy2PUkkoBy8J6Mo12L/Wa9LKiC6PjBKF5qKI8+ZznEXi+0hhk2HC/bKS3dLLziBBrwHjN8pT/WdM02+H8MnryErna4TVSkpprDTKBcqlqD3G8xYpKRbRakV5Eoaz9UhUuOXBYYtEr6rb4OGZ42onTOkNhvNtG87Uw6xufCf6mSJ+tO/ZCzKhHzS9EY9GX8NQMv7yiTc4fDG9/7pkf/d8tH174r11cTomuf4VupnVnun3IG8f7Wq+HsDgTVmmNRM9fXk0osF3cdfw9qr9ALq+IrIqgOCjvRvRgUfbePBkdp/AL7RxkIgrGHZj+bBPpWYkChDBn8HvLZQiwHv1kasBT8UbLTkTRFxW9S4jEMmfkP6Ga+Je8ZODxf3t0ioL3KBvWPSfhIepyyWTAa+odoaF1f2VdZFNDJ1q89KXyGhhBf5NkIPx/HtRXxODxx61oERd5ln8Q52i2NrBQizH7eI8mm2jVqtZx8qg4Z+aO7cMqa/PLdvH7ym7aiHFp1I3abjnmRpWNi9phUWkag==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(336012)(40460700003)(36860700001)(5660300002)(47076005)(426003)(316002)(83380400001)(7696005)(6666004)(36756003)(70586007)(2906002)(107886003)(30864003)(16526019)(54906003)(508600001)(81166007)(356005)(1076003)(186003)(26005)(4326008)(8676002)(70206006)(2616005)(6916009)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 17:30:07.4304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04066f1f-a5b5-4e7e-b9c7-08d9f171f9e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2740
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This has alloc_cmd() cleanup that removes statically hardcoded function
parameter and removes the need for the local variable on the stack.

Detailed test log is below that creates 5 memory backed nullb devices
with queue_mode=0 (NULL_Q_BIO) and runs fio verify job, here is the
summary:-

# grep err= p/null-blk-alloc-cmd/0000-cover-letter.patch 
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4785: Wed Feb 16 08:39:35 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4788: Wed Feb 16 08:39:36 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4791: Wed Feb 16 08:39:37 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4794: Wed Feb 16 08:39:39 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4797: Wed Feb 16 08:39:40 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4800: Wed Feb 16 08:39:42 2022

Below is detailed test log.

-ck

changes from v1:-
1. Squash both patches.

Chaitanya Kulkarni (1):
  null_blk: remove hardcoded alloc_cmd() parameter

 drivers/block/null_blk/main.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

fio verification test log for memory backed null_blk queue mode=0 (BIO):

 # git am p/null-blk-alloc-cmd/0001-null_blk-remove-hardcoded-alloc_cmd-parameter.patch
Applying: null_blk: remove hardcoded alloc_cmd() parameter
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
-rw-r--r--. 1 root root 1.1M Feb 16 08:39 /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/null_blk//null_blk.ko
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
[23177.918196] null_blk: module loaded
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
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4785: Wed Feb 16 08:39:35 2022
  read: IOPS=105k, BW=409MiB/s (429MB/s)(158MiB/386msec)
    slat (nsec): min=6664, max=60937, avg=7129.77, stdev=1327.63
    clat (usec): min=3, max=237, avg=144.66, stdev= 9.32
     lat (usec): min=10, max=247, avg=151.84, stdev= 9.63
    clat percentiles (usec):
     |  1.00th=[  139],  5.00th=[  141], 10.00th=[  141], 20.00th=[  141],
     | 30.00th=[  141], 40.00th=[  141], 50.00th=[  141], 60.00th=[  143],
     | 70.00th=[  145], 80.00th=[  147], 90.00th=[  155], 95.00th=[  157],
     | 99.00th=[  194], 99.50th=[  208], 99.90th=[  223], 99.95th=[  227],
     | 99.99th=[  233]
  write: IOPS=88.2k, BW=344MiB/s (361MB/s)(250MiB/726msec); 0 zone resets
    slat (usec): min=7, max=103, avg= 9.20, stdev= 2.88
    clat (usec): min=3, max=430, avg=171.65, stdev=38.49
     lat (usec): min=11, max=457, avg=180.91, stdev=40.53
    clat percentiles (usec):
     |  1.00th=[  151],  5.00th=[  153], 10.00th=[  155], 20.00th=[  157],
     | 30.00th=[  159], 40.00th=[  161], 50.00th=[  161], 60.00th=[  165],
     | 70.00th=[  167], 80.00th=[  172], 90.00th=[  180], 95.00th=[  235],
     | 99.00th=[  363], 99.50th=[  375], 99.90th=[  388], 99.95th=[  396],
     | 99.99th=[  420]
   bw (  KiB/s): min=168936, max=343064, per=72.60%, avg=256000.00, stdev=123127.09, samples=2
   iops        : min=42234, max=85766, avg=64000.00, stdev=30781.77, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=97.12%
  lat (usec)   : 500=2.86%
  cpu          : usr=15.59%, sys=84.41%, ctx=1, majf=0, minf=966
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40433,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=409MiB/s (429MB/s), 409MiB/s-409MiB/s (429MB/s-429MB/s), io=158MiB (166MB), run=386-386msec
  WRITE: bw=344MiB/s (361MB/s), 344MiB/s-344MiB/s (361MB/s-361MB/s), io=250MiB (262MB), run=726-726msec

Disk stats (read/write):
  nullb0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb1
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4788: Wed Feb 16 08:39:36 2022
  read: IOPS=104k, BW=406MiB/s (425MB/s)(158MiB/389msec)
    slat (nsec): min=6523, max=38994, avg=7171.20, stdev=1427.41
    clat (usec): min=3, max=276, avg=146.06, stdev=16.82
     lat (usec): min=10, max=289, avg=153.28, stdev=17.58
    clat percentiles (usec):
     |  1.00th=[  139],  5.00th=[  139], 10.00th=[  141], 20.00th=[  141],
     | 30.00th=[  141], 40.00th=[  141], 50.00th=[  141], 60.00th=[  143],
     | 70.00th=[  145], 80.00th=[  149], 90.00th=[  153], 95.00th=[  157],
     | 99.00th=[  247], 99.50th=[  255], 99.90th=[  269], 99.95th=[  273],
     | 99.99th=[  277]
  write: IOPS=85.9k, BW=336MiB/s (352MB/s)(250MiB/745msec); 0 zone resets
    slat (usec): min=7, max=588, avg= 9.44, stdev= 3.92
    clat (usec): min=5, max=970, avg=176.13, stdev=44.46
     lat (usec): min=17, max=990, avg=185.64, stdev=46.77
    clat percentiles (usec):
     |  1.00th=[  153],  5.00th=[  155], 10.00th=[  155], 20.00th=[  157],
     | 30.00th=[  159], 40.00th=[  161], 50.00th=[  163], 60.00th=[  165],
     | 70.00th=[  169], 80.00th=[  174], 90.00th=[  186], 95.00th=[  314],
     | 99.00th=[  343], 99.50th=[  351], 99.90th=[  388], 99.95th=[  396],
     | 99.99th=[  906]
   bw (  KiB/s): min=163840, max=348160, per=74.50%, avg=256000.00, stdev=130333.92, samples=2
   iops        : min=40960, max=87040, avg=64000.00, stdev=32583.48, samples=2
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%
  lat (usec)   : 250=94.97%, 500=5.00%, 750=0.01%, 1000=0.01%
  cpu          : usr=17.65%, sys=82.17%, ctx=4, majf=0, minf=965
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40387,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=406MiB/s (425MB/s), 406MiB/s-406MiB/s (425MB/s-425MB/s), io=158MiB (165MB), run=389-389msec
  WRITE: bw=336MiB/s (352MB/s), 336MiB/s-336MiB/s (352MB/s-352MB/s), io=250MiB (262MB), run=745-745msec

Disk stats (read/write):
  nullb1: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb2
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4791: Wed Feb 16 08:39:37 2022
  read: IOPS=106k, BW=413MiB/s (433MB/s)(158MiB/383msec)
    slat (nsec): min=6523, max=55355, avg=7071.79, stdev=1960.31
    clat (usec): min=4, max=223, avg=143.34, stdev=10.38
     lat (usec): min=10, max=230, avg=150.46, stdev=10.68
    clat percentiles (usec):
     |  1.00th=[  137],  5.00th=[  137], 10.00th=[  139], 20.00th=[  139],
     | 30.00th=[  139], 40.00th=[  139], 50.00th=[  139], 60.00th=[  141],
     | 70.00th=[  143], 80.00th=[  149], 90.00th=[  153], 95.00th=[  159],
     | 99.00th=[  198], 99.50th=[  200], 99.90th=[  215], 99.95th=[  217],
     | 99.99th=[  223]
  write: IOPS=92.8k, BW=362MiB/s (380MB/s)(250MiB/690msec); 0 zone resets
    slat (nsec): min=7073, max=97565, avg=8751.19, stdev=2544.55
    clat (usec): min=3, max=460, avg=163.23, stdev=15.67
     lat (usec): min=10, max=478, avg=172.04, stdev=16.25
    clat percentiles (usec):
     |  1.00th=[  149],  5.00th=[  151], 10.00th=[  153], 20.00th=[  155],
     | 30.00th=[  157], 40.00th=[  159], 50.00th=[  161], 60.00th=[  163],
     | 70.00th=[  165], 80.00th=[  169], 90.00th=[  176], 95.00th=[  182],
     | 99.00th=[  227], 99.50th=[  237], 99.90th=[  351], 99.95th=[  359],
     | 99.99th=[  449]
   bw (  KiB/s): min=143672, max=368328, per=69.00%, avg=256000.00, stdev=158855.78, samples=2
   iops        : min=35918, max=92082, avg=64000.00, stdev=39713.95, samples=2
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%
  lat (usec)   : 250=99.83%, 500=0.15%
  cpu          : usr=15.21%, sys=84.05%, ctx=0, majf=0, minf=968
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40506,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=413MiB/s (433MB/s), 413MiB/s-413MiB/s (433MB/s-433MB/s), io=158MiB (166MB), run=383-383msec
  WRITE: bw=362MiB/s (380MB/s), 362MiB/s-362MiB/s (380MB/s-380MB/s), io=250MiB (262MB), run=690-690msec

Disk stats (read/write):
  nullb2: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb3
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4794: Wed Feb 16 08:39:39 2022
  read: IOPS=104k, BW=408MiB/s (428MB/s)(159MiB/389msec)
    slat (nsec): min=6683, max=27382, avg=7160.42, stdev=1167.62
    clat (usec): min=4, max=221, avg=145.13, stdev= 5.78
     lat (usec): min=11, max=228, avg=152.33, stdev= 5.91
    clat percentiles (usec):
     |  1.00th=[  139],  5.00th=[  141], 10.00th=[  141], 20.00th=[  143],
     | 30.00th=[  143], 40.00th=[  143], 50.00th=[  143], 60.00th=[  145],
     | 70.00th=[  147], 80.00th=[  149], 90.00th=[  155], 95.00th=[  157],
     | 99.00th=[  163], 99.50th=[  165], 99.90th=[  172], 99.95th=[  182],
     | 99.99th=[  219]
  write: IOPS=89.3k, BW=349MiB/s (366MB/s)(250MiB/717msec); 0 zone resets
    slat (nsec): min=7153, max=83438, avg=9084.91, stdev=2529.20
    clat (usec): min=3, max=370, avg=169.60, stdev=32.10
     lat (usec): min=11, max=387, avg=178.75, stdev=33.80
    clat percentiles (usec):
     |  1.00th=[  151],  5.00th=[  153], 10.00th=[  155], 20.00th=[  157],
     | 30.00th=[  159], 40.00th=[  161], 50.00th=[  163], 60.00th=[  165],
     | 70.00th=[  167], 80.00th=[  172], 90.00th=[  178], 95.00th=[  186],
     | 99.00th=[  334], 99.50th=[  343], 99.90th=[  355], 99.95th=[  359],
     | 99.99th=[  367]
   bw (  KiB/s): min=162784, max=349216, per=71.70%, avg=256000.00, stdev=131827.33, samples=2
   iops        : min=40696, max=87304, avg=64000.00, stdev=32956.83, samples=2
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%
  lat (usec)   : 250=97.45%, 500=2.53%
  cpu          : usr=15.75%, sys=84.16%, ctx=2, majf=0, minf=971
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40628,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=408MiB/s (428MB/s), 408MiB/s-408MiB/s (428MB/s-428MB/s), io=159MiB (166MB), run=389-389msec
  WRITE: bw=349MiB/s (366MB/s), 349MiB/s-349MiB/s (366MB/s-366MB/s), io=250MiB (262MB), run=717-717msec

Disk stats (read/write):
  nullb3: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb4
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4797: Wed Feb 16 08:39:40 2022
  read: IOPS=104k, BW=407MiB/s (427MB/s)(158MiB/389msec)
    slat (nsec): min=6692, max=30297, avg=7184.25, stdev=1205.87
    clat (usec): min=3, max=210, avg=145.52, stdev= 5.61
     lat (usec): min=10, max=218, avg=152.75, stdev= 5.72
    clat percentiles (usec):
     |  1.00th=[  141],  5.00th=[  141], 10.00th=[  141], 20.00th=[  143],
     | 30.00th=[  143], 40.00th=[  143], 50.00th=[  143], 60.00th=[  145],
     | 70.00th=[  147], 80.00th=[  151], 90.00th=[  155], 95.00th=[  157],
     | 99.00th=[  159], 99.50th=[  163], 99.90th=[  169], 99.95th=[  176],
     | 99.99th=[  208]
  write: IOPS=89.1k, BW=348MiB/s (365MB/s)(250MiB/718msec); 0 zone resets
    slat (nsec): min=7233, max=79141, avg=9099.52, stdev=2549.46
    clat (usec): min=3, max=391, avg=169.83, stdev=31.81
     lat (usec): min=11, max=407, avg=178.99, stdev=33.49
    clat percentiles (usec):
     |  1.00th=[  151],  5.00th=[  155], 10.00th=[  155], 20.00th=[  157],
     | 30.00th=[  159], 40.00th=[  161], 50.00th=[  163], 60.00th=[  165],
     | 70.00th=[  167], 80.00th=[  172], 90.00th=[  178], 95.00th=[  188],
     | 99.00th=[  334], 99.50th=[  347], 99.90th=[  359], 99.95th=[  363],
     | 99.99th=[  367]
   bw (  KiB/s): min=163824, max=348176, per=71.80%, avg=256000.00, stdev=130356.55, samples=2
   iops        : min=40956, max=87044, avg=64000.00, stdev=32589.14, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=97.53%
  lat (usec)   : 500=2.45%
  cpu          : usr=15.55%, sys=84.45%, ctx=1, majf=0, minf=969
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40552,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=407MiB/s (427MB/s), 407MiB/s-407MiB/s (427MB/s-427MB/s), io=158MiB (166MB), run=389-389msec
  WRITE: bw=348MiB/s (365MB/s), 348MiB/s-348MiB/s (365MB/s-365MB/s), io=250MiB (262MB), run=718-718msec

Disk stats (read/write):
  nullb4: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in `seq 0 $NN`
+ fio fio/verify.fio --filename=/dev/nullb5
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1)
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4800: Wed Feb 16 08:39:42 2022
  read: IOPS=105k, BW=409MiB/s (429MB/s)(158MiB/385msec)
    slat (nsec): min=6682, max=30087, avg=7134.95, stdev=1215.07
    clat (usec): min=3, max=257, avg=144.83, stdev=11.35
     lat (usec): min=10, max=268, avg=152.01, stdev=11.82
    clat percentiles (usec):
     |  1.00th=[  139],  5.00th=[  141], 10.00th=[  141], 20.00th=[  141],
     | 30.00th=[  141], 40.00th=[  141], 50.00th=[  141], 60.00th=[  143],
     | 70.00th=[  145], 80.00th=[  147], 90.00th=[  153], 95.00th=[  155],
     | 99.00th=[  219], 99.50th=[  229], 99.90th=[  237], 99.95th=[  241],
     | 99.99th=[  251]
  write: IOPS=89.4k, BW=349MiB/s (366MB/s)(250MiB/716msec); 0 zone resets
    slat (nsec): min=7133, max=91994, avg=9065.45, stdev=2530.98
    clat (usec): min=3, max=377, avg=169.33, stdev=32.19
     lat (usec): min=12, max=394, avg=178.46, stdev=33.88
    clat percentiles (usec):
     |  1.00th=[  151],  5.00th=[  153], 10.00th=[  155], 20.00th=[  157],
     | 30.00th=[  159], 40.00th=[  159], 50.00th=[  161], 60.00th=[  163],
     | 70.00th=[  167], 80.00th=[  172], 90.00th=[  178], 95.00th=[  188],
     | 99.00th=[  334], 99.50th=[  343], 99.90th=[  359], 99.95th=[  359],
     | 99.99th=[  371]
   bw (  KiB/s): min=163056, max=348944, per=71.60%, avg=256000.00, stdev=131442.67, samples=2
   iops        : min=40764, max=87236, avg=64000.00, stdev=32860.67, samples=2
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=97.48%
  lat (usec)   : 500=2.50%
  cpu          : usr=16.55%, sys=83.36%, ctx=1, majf=0, minf=964
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40321,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=409MiB/s (429MB/s), 409MiB/s-409MiB/s (429MB/s-429MB/s), io=158MiB (165MB), run=385-385msec
  WRITE: bw=349MiB/s (366MB/s), 349MiB/s-349MiB/s (366MB/s-366MB/s), io=250MiB (262MB), run=716-716msec

Disk stats (read/write):
  nullb5: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%

blktests results :-

oot@dev blktests (master) #  ./check block
block/001 (stress device hotplugging)                        [passed]
    runtime  91.043s  ...  92.441s
block/002 (remove a device while running blktrace)           [passed]
    runtime  1.852s  ...  1.779s
block/006 (run null-blk in blocking mode)                    [passed]
    read iops  359050    ...  363021
    runtime    184.498s  ...  182.672s
block/009 (check page-cache coherency after BLKDISCARD)      [passed]
    runtime  1.067s  ...  0.968s
block/010 (run I/O on null_blk with shared and non-shared tags) [passed]
    Individual tags read iops  445592    ...  450283
    runtime                    316.587s  ...  314.206s
    Shared tags read iops      448645    ...  451558
block/014 (run null-blk with blk-mq and timeout injection configured) [not run]
    null_blk module does not have parameter timeout
block/015 (run null-blk on different schedulers with requeue injection configured) [not run]
    null_blk module does not have parameter requeue
block/016 (send a signal to a process waiting on a frozen queue) [passed]
    runtime  7.199s  ...  7.209s
block/017 (do I/O and check the inflight counter)            [passed]
    runtime  1.846s  ...  1.854s
block/018 (do I/O and check iostats times)                   [passed]
    runtime  5.323s  ...  5.320s
block/020 (run null-blk on different schedulers with only one hardware tag) [passed]
    runtime  31.902s  ...  31.824s
block/021 (read/write nr_requests on null-blk with different schedulers) [passed]
    runtime  4.095s  ...  4.062s
block/022 (Test hang caused by freeze/unfreeze sequence)     [passed]
    runtime  30.249s  ...  30.244s
block/023 (do I/O on all null_blk queue modes)               [passed]
    runtime  0.571s  ...  0.639s
block/024 (do I/O faster than a jiffy and check iostats times) [passed]
    runtime  3.064s  ...  3.038s
block/025 (do a huge discard with 4k sector size)            [passed]
    runtime  4.404s  ...  4.407s
block/027 (stress device hotplugging with running fio jobs and different schedulers) [passed]
    runtime  21.100s  ...  21.150s
block/028 (do I/O on scsi_debug with DIF/DIX enabled)        [passed]
    runtime  55.719s  ...  58.058s
block/029 (trigger blk_mq_update_nr_hw_queues())             [passed]
    runtime  30.520s  ...  30.539s
block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [not run]
    null_blk module does not have parameter init_hctx
block/031 (do IO on null-blk with a host tag set)            [passed]
    runtime  30.503s  ...  30.552s

-- 
2.29.0

