Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDF9C001DE
	for <linux-block@archiver.kernel.org>; Tue,  1 Aug 2023 02:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjHACaB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 22:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjHACaA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 22:30:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E481FC7
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 19:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUdv9kIitHP8WFf1n0+a67xCpV3XVz6Fpbx0U5Mg5MQ+P0XJcsbhp7tX4W0B+XO3Xe+tcrG7bHzZXbRpY9GjrDbDmShTPP94Crd8I+W9FuLOP9jpy/sUwOE/ci7zMlFeMkdgB9vqauVsj1IWcYwF6+uTy/90FXNpQh8hm+V6wvGhGfXNX5nW3bk4cfnh/UmMQt3O6z7h0qMOWa8LghdfXOV2WWnBFgMMj8EQfDFjPzTNPnTIGB9natJINel4MDknyMcnvxw1wQcZY5YTOcf5qLAt+T0Uk3e3zLLBj0mb3jwIYplbjdbT4hZ5mNeI/PfC2ZL2Xu7OlvdgYcSL8AfTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN2fUcFPrdaLOFQWym31mzX/2mX/hJZXREeaIXcgw7Q=;
 b=P8fKWQnUV9mFsByMnpDKNRw9HpDqtnNMhWR2uhW7Emn9Gtwvx3phgceWqxbkYa9Cz2foh/uIspIzvDUQ3v1NriE+KVzuyJnCmi9fOHzsKU3m4mJg8U3xF9eTGZsiW78dRAX8jyvmFDDVGtfpb2y/M1y9MAsd3y8som4JcqL0pOF4o/6UbNe6yXajn45kydjsL3eGkC3VyDHBoK8ByeSxJP1jCwo9NsIHrBv+PVi/I62OClVebMfEC2AwkdxqlNZEcdhPGTtRXLfWYBQCV7AQjzJYHPoVWO0pY03INKKmiZE2tlOtDOUjoNo1Hw9EYAui1o/2M+K2xDLY1T9GU7bRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN2fUcFPrdaLOFQWym31mzX/2mX/hJZXREeaIXcgw7Q=;
 b=V2eTFaIFuYgXzlfuuT1/32wd7JotXyScc8/2ihQb7vIy2A4z9w1wVtmqzGrYm3ye4AVtiTgWGud4pQdpvpplnDVoaEYbbYfHXugGF5t0TpyhEZ8C8qrHSrG5fyz2rrdPraQ8n9Xh/xjEq7W+Xt1x0q3sPJxYLnjheiUGnFv0pAPun2IK37ll9lBI6+c2EPTNYNlj/SzqhfbJ9m9gaVjwWRQd9dnKQkn44vYhjpawVR0/jtyxQxA97oNJ+SOIzYXbcktfHfyrltSfduWWUNqCYzvdI4DHSWUwHjLfsItABRx+1D0/pTLLcDk6qnO0FpxI2Ukd8YoTF62zut8GXfokGQ==
Received: from SA1PR02CA0004.namprd02.prod.outlook.com (2603:10b6:806:2cf::8)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Tue, 1 Aug 2023 02:29:54 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::bb) by SA1PR02CA0004.outlook.office365.com
 (2603:10b6:806:2cf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 02:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 02:29:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 19:29:36 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 19:29:36 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/2] brd: small improvements
Date:   Mon, 31 Jul 2023 19:29:27 -0700
Message-ID: <20230801022929.8972-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 253706f1-eae1-4fc6-0bb8-08db923730e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lk2shaTBW5GKYDVMtxJLiltLvf98E6wKinP6+Umg4IWMyaue1U38PvWrkjxEH7Q2Oiipf97ntawGqv2zvIEoUhhXIp9fPJdiNJgaLi5Ko2pUUQyLgooaccdNKWeMj4/XVugEm00gM/IS81P1WM4gwUqZgoyLMSZpIDlaqbrjM+gRdsOqNCJqgyqQTNNlYpZmmzx6H4Vp6qB3y22UKAOnnLfOwvsVO3ZN9xLblKteTa/E215370RZ+x9E8fFGXg9rEw2ff5kqBrOWB7rkLCkdHPgOaNRVqhRjOtryilOOxSgnfkQLGsiNn6VydsvmjwKe1HtN51QNO4Rw9sEW9vXs175YBvx2xNFNan50Bx9Mt1JNxn2Y669A6/IBTXSj8p7Z1rFX7tyZ0nmUwKPLrDMwYkjYSj5nmK9aLthWL0twWCE99MA9ApGut2W5gRHu11hwz1SG3t9zs13YQ6xU12gkTWFKGGldq4y5RO/l0ORKuV6/cq66UEYZcz6nu2hNUOltmgVXP2zuYopHtG2u7nPvLVkJuwn4Rv/elHmoT+IvSOXeJkEDpGLLVips6mjXBpIFfDtzXdUsHi8TQPo8rVIpwQ/XfyGL3UtgixKEeN9PfyaYSYmzFRlQWnmBbX0GH70Jp/0cYlJ1gE0uKKwcvTlsHSxb9X0MpTREUUVIhYUzUv30mJm/byFiCrXC+aEkGLuPPZwfIT3ulJysuYRcNZXTVUA8AAbcAPddNu4aiNhO6c+22h9foMbvckAm6VPLcxc4vupDqZVOFeBC0L8y5o0N3A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(30864003)(7696005)(2616005)(4326008)(6916009)(478600001)(2906002)(426003)(336012)(47076005)(16526019)(186003)(36756003)(36860700001)(5660300002)(83380400001)(8676002)(1076003)(316002)(26005)(70586007)(70206006)(82740400003)(40460700003)(54906003)(8936002)(107886003)(6666004)(19627235002)(7636003)(356005)(40480700001)(41300700001)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 02:29:54.3086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 253706f1-eae1-4fc6-0bb8-08db923730e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Small improvements for brd to remove deprecated APIs and add pr_fmt
macro to remove the repetative brd prefix in the pr_xxx() string.

I've ran few fio read/write/verify tests on this, they seems to pass.

-ck

Chaitanya Kulkarni (2):
  brd: use memcpy_to|from_page() in copy_to|from_brd()
  brd: remove redundent prefix with pr_fmt macro

 drivers/block/brd.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

linux-block # sh test-brd-memcpy-perf.sh 
+ ./compile_brd.sh
+ umount /mnt/brd
umount: /mnt/brd: not mounted.
+ dmesg -c
+ modprobe -r brd
+ lsmod
+ grep brd
++ nproc
+ make -j 48 M=drivers/block modules
+ HOST=drivers/block/brd.ko
++ uname -r
+ HOST_DEST=/lib/modules/6.5.0-rc3lblk+/kernel/drivers/block/
+ cp drivers/block/brd.ko /lib/modules/6.5.0-rc3lblk+/kernel/drivers/block//
+ ls -lrth /lib/modules/6.5.0-rc3lblk+/kernel/drivers/block//brd.ko
-rw-r--r--. 1 root root 378K Jul 31 19:13 /lib/modules/6.5.0-rc3lblk+/kernel/drivers/block//brd.ko
+ dmesg -c
+ lsmod
+ grep brd
+ modprobe brd rd_nr=1 rd_size=20971520
+ sleep 1
+ dmesg -c
[12164.622572] brd: module loaded
+ test_perf
+ git log --oneline -2
3dbc8dd05802 (HEAD -> for-next) brd: remove redundent prefix with pr_fmt macro
5644af5fe8d1 brd: use memcpy_to|from_page() in copy_to|from_brd()
+ ./compile_brd.sh
+ umount /mnt/brd
umount: /mnt/brd: not mounted.
+ dmesg -c
+ modprobe -r brd
+ lsmod
+ grep brd
++ nproc
+ make -j 48 M=drivers/block modules
+ HOST=drivers/block/brd.ko
++ uname -r
+ HOST_DEST=/lib/modules/6.5.0-rc3lblk+/kernel/drivers/block/
+ cp drivers/block/brd.ko /lib/modules/6.5.0-rc3lblk+/kernel/drivers/block//
+ ls -lrth /lib/modules/6.5.0-rc3lblk+/kernel/drivers/block//brd.ko
-rw-r--r--. 1 root root 378K Jul 31 19:13 /lib/modules/6.5.0-rc3lblk+/kernel/drivers/block//brd.ko
+ dmesg -c
[12165.683470] brd: module unloaded
+ lsmod
+ grep brd
+ modprobe brd rd_nr=1 rd_size=20971520
+ sleep 1
+ fio fio/randwrite.fio --filename=/dev/ram0 --ioengine=libaio --size=20G
RANDWRITE: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=2
...
fio-3.34
Starting 48 processes
Jobs: 48 (f=48): [w(48)][100.0%][w=26.5GiB/s][w=6948k IOPS][eta 00m:00s]
RANDWRITE: (groupid=0, jobs=48): err= 0: pid=6654: Mon Jul 31 19:14:50 2023
  write: IOPS=6580k, BW=25.1GiB/s (27.0GB/s)(1506GiB/60002msec); 0 zone resets
    slat (nsec): min=992, max=48184k, avg=6291.87, stdev=44125.08
    clat (nsec): min=741, max=48194k, avg=7820.21, stdev=48267.24
     lat (usec): min=2, max=48215, avg=14.11, stdev=65.65
    clat percentiles (usec):
     |  1.00th=[    5],  5.00th=[    5], 10.00th=[    6], 20.00th=[    6],
     | 30.00th=[    6], 40.00th=[    7], 50.00th=[    7], 60.00th=[    7],
     | 70.00th=[    8], 80.00th=[    8], 90.00th=[    9], 95.00th=[   10],
     | 99.00th=[   26], 99.50th=[   64], 99.90th=[  137], 99.95th=[  404],
     | 99.99th=[  594]
   bw (  MiB/s): min= 4967, max=30851, per=100.00%, avg=25716.15, stdev=107.71, samples=5712
   iops        : min=1271674, max=7898038, avg=6583332.27, stdev=27573.66, samples=5712
  lat (nsec)   : 750=0.01%, 1000=0.01%
  lat (usec)   : 2=0.01%, 4=0.93%, 10=94.93%, 20=3.07%, 50=0.34%
  lat (usec)   : 100=0.58%, 250=0.07%, 500=0.07%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
  cpu          : usr=12.86%, sys=84.29%, ctx=26503, majf=0, minf=627
  IO depths    : 1=0.1%, 2=100.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,394811720,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
  WRITE: bw=25.1GiB/s (27.0GB/s), 25.1GiB/s-25.1GiB/s (27.0GB/s-27.0GB/s), io=1506GiB (1617GB), run=60002-60002msec

Disk stats (read/write):
  ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/ram0 --ioengine=libaio --size=20G
RANDREAD: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=2
...
fio-3.34
Starting 48 processes
Jobs: 48 (f=48): [r(48)][100.0%][r=36.4GiB/s][r=9542k IOPS][eta 00m:00s]
RANDREAD: (groupid=0, jobs=48): err= 0: pid=6704: Mon Jul 31 19:15:50 2023
  read: IOPS=9635k, BW=36.8GiB/s (39.5GB/s)(2205GiB/60002msec)
    slat (nsec): min=1342, max=64089k, avg=4179.67, stdev=20589.24
    clat (nsec): min=771, max=64095k, avg=5428.32, stdev=23628.88
     lat (usec): min=2, max=64107, avg= 9.61, stdev=31.37
    clat percentiles (nsec):
     |  1.00th=[ 3440],  5.00th=[ 3728], 10.00th=[ 3920], 20.00th=[ 4192],
     | 30.00th=[ 4384], 40.00th=[ 4640], 50.00th=[ 4896], 60.00th=[ 5216],
     | 70.00th=[ 5600], 80.00th=[ 6048], 90.00th=[ 6752], 95.00th=[ 7456],
     | 99.00th=[ 9536], 99.50th=[34048], 99.90th=[41216], 99.95th=[43264],
     | 99.99th=[66048]
   bw (  MiB/s): min=28759, max=39419, per=100.00%, avg=37689.01, stdev=32.63, samples=5712
   iops        : min=7362346, max=10091438, avg=9648387.52, stdev=8354.07, samples=5712
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 4=12.70%, 10=86.45%, 20=0.17%, 50=0.66%
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
  lat (msec)   : 100=0.01%
  cpu          : usr=14.07%, sys=84.64%, ctx=27355, majf=0, minf=732
  IO depths    : 1=0.1%, 2=100.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=578147226,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
   READ: bw=36.8GiB/s (39.5GB/s), 36.8GiB/s-36.8GiB/s (39.5GB/s-39.5GB/s), io=2205GiB (2368GB), run=60002-60002msec

Disk stats (read/write):
  ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/ram0 --ioengine=libaio --size=20G
RANDREAD: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=2
...
fio-3.34
Starting 48 processes
Jobs: 48 (f=48): [r(48)][100.0%][r=36.5GiB/s][r=9568k IOPS][eta 00m:00s]
RANDREAD: (groupid=0, jobs=48): err= 0: pid=6772: Mon Jul 31 19:16:50 2023
  read: IOPS=9544k, BW=36.4GiB/s (39.1GB/s)(2185GiB/60005msec)
    slat (nsec): min=1292, max=52199k, avg=4216.56, stdev=30223.82
    clat (nsec): min=761, max=52205k, avg=5481.37, stdev=34604.93
     lat (usec): min=2, max=52218, avg= 9.70, stdev=46.06
    clat percentiles (nsec):
     |  1.00th=[ 3440],  5.00th=[ 3728], 10.00th=[ 3920], 20.00th=[ 4192],
     | 30.00th=[ 4384], 40.00th=[ 4640], 50.00th=[ 4896], 60.00th=[ 5216],
     | 70.00th=[ 5600], 80.00th=[ 6048], 90.00th=[ 6752], 95.00th=[ 7392],
     | 99.00th=[ 9408], 99.50th=[35584], 99.90th=[41216], 99.95th=[42752],
     | 99.99th=[80384]
   bw (  MiB/s): min=25868, max=40243, per=100.00%, avg=37331.79, stdev=46.77, samples=5712
   iops        : min=6622274, max=10302360, avg=9556939.51, stdev=11972.54, samples=5712
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 4=12.55%, 10=86.62%, 20=0.15%, 50=0.66%
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
  lat (msec)   : 100=0.01%
  cpu          : usr=12.19%, sys=85.45%, ctx=25680, majf=0, minf=686
  IO depths    : 1=0.1%, 2=100.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=572715634,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
   READ: bw=36.4GiB/s (39.1GB/s), 36.4GiB/s-36.4GiB/s (39.1GB/s-39.1GB/s), io=2185GiB (2346GB), run=60005-60005msec

Disk stats (read/write):
  ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ for i in 1 2 3
+ fio fio/randread.fio --filename=/dev/ram0 --ioengine=libaio --size=20G
RANDREAD: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=2
...
fio-3.34
Starting 48 processes
Jobs: 48 (f=48): [r(48)][100.0%][r=36.4GiB/s][r=9549k IOPS][eta 00m:00s]
RANDREAD: (groupid=0, jobs=48): err= 0: pid=6823: Mon Jul 31 19:17:51 2023
  read: IOPS=9544k, BW=36.4GiB/s (39.1GB/s)(2185GiB/60003msec)
    slat (nsec): min=1332, max=40081k, avg=4213.58, stdev=30581.29
    clat (nsec): min=761, max=40087k, avg=5479.64, stdev=34518.58
     lat (usec): min=2, max=40100, avg= 9.69, stdev=46.18
    clat percentiles (nsec):
     |  1.00th=[ 3472],  5.00th=[ 3760], 10.00th=[ 3952], 20.00th=[ 4192],
     | 30.00th=[ 4384], 40.00th=[ 4640], 50.00th=[ 4896], 60.00th=[ 5216],
     | 70.00th=[ 5600], 80.00th=[ 6048], 90.00th=[ 6752], 95.00th=[ 7392],
     | 99.00th=[ 9408], 99.50th=[35584], 99.90th=[40704], 99.95th=[42240],
     | 99.99th=[82432]
   bw (  MiB/s): min=25167, max=40648, per=100.00%, avg=37327.34, stdev=47.56, samples=5712
   iops        : min=6442770, max=10406041, avg=9555798.60, stdev=12175.34, samples=5712
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 4=12.35%, 10=86.82%, 20=0.16%, 50=0.65%
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
  cpu          : usr=12.36%, sys=85.26%, ctx=25612, majf=0, minf=774
  IO depths    : 1=0.1%, 2=100.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=572691650,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
   READ: bw=36.4GiB/s (39.1GB/s), 36.4GiB/s-36.4GiB/s (39.1GB/s-39.1GB/s), io=2185GiB (2346GB), run=60003-60003msec

Disk stats (read/write):
  ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ fio fio/verify.fio --filename=/dev/ram0 --ioengine=io_uring --size=10G
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=16
fio-3.34
Starting 1 process
Jobs: 1 (f=1): [V(1)][77.8%][r=1829MiB/s][r=468k IOPS][eta 00m:04s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=6876: Mon Jul 31 19:18:06 2023
  read: IOPS=468k, BW=1827MiB/s (1916MB/s)(6472MiB/3542msec)
    slat (nsec): min=1022, max=96523, avg=1313.44, stdev=369.23
    clat (nsec): min=711, max=128955, avg=32147.10, stdev=2033.64
     lat (nsec): min=1974, max=130207, avg=33460.54, stdev=2081.94
    clat percentiles (nsec):
     |  1.00th=[30592],  5.00th=[31104], 10.00th=[31104], 20.00th=[31360],
     | 30.00th=[31360], 40.00th=[31616], 50.00th=[31616], 60.00th=[31872],
     | 70.00th=[32128], 80.00th=[32128], 90.00th=[32640], 95.00th=[34560],
     | 99.00th=[40192], 99.50th=[43264], 99.90th=[51456], 99.95th=[55552],
     | 99.99th=[84480]
  write: IOPS=237k, BW=926MiB/s (971MB/s)(10.0GiB/11061msec); 0 zone resets
    slat (nsec): min=1954, max=71735, avg=3897.72, stdev=938.16
    clat (nsec): min=430, max=136489, avg=63372.98, stdev=5430.72
     lat (usec): min=4, max=142, avg=67.27, stdev= 5.70
    clat percentiles (usec):
     |  1.00th=[   48],  5.00th=[   55], 10.00th=[   58], 20.00th=[   61],
     | 30.00th=[   62], 40.00th=[   63], 50.00th=[   64], 60.00th=[   65],
     | 70.00th=[   66], 80.00th=[   67], 90.00th=[   70], 95.00th=[   73],
     | 99.00th=[   80], 99.50th=[   83], 99.90th=[   91], 99.95th=[   99],
     | 99.99th=[  118]
   bw (  KiB/s): min=93464, max=1144224, per=96.18%, avg=911805.22, stdev=187568.47, samples=23
   iops        : min=23366, max=286056, avg=227951.30, stdev=46892.12, samples=23
  lat (nsec)   : 500=0.01%, 750=0.01%
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=39.72%, 100=60.25%
  lat (usec)   : 250=0.03%
  cpu          : usr=55.59%, sys=44.35%, ctx=20, majf=0, minf=45314
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=1656716,2621440,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1827MiB/s (1916MB/s), 1827MiB/s-1827MiB/s (1916MB/s-1916MB/s), io=6472MiB (6786MB), run=3542-3542msec
  WRITE: bw=926MiB/s (971MB/s), 926MiB/s-926MiB/s (971MB/s-971MB/s), io=10.0GiB (10.7GB), run=11061-11061msec

Disk stats (read/write):
  ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
+ modprobe -r brd
+ modprobe -r brd
+ set +x

-- 
2.40.0

