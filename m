Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D198C761A6
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 20:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjC2UrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 16:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjC2UrN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 16:47:13 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE141BEB
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 13:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6punvuNOxGLY74f71hFCxn8LpScSYoNkvOIsJoJsj/66WCbN1QVuIiJYHpHpeSqnnOKQdafl4hm9h7MaOxQNdyHgbXvQqFKDFSXO4356yDR6HIqYUVjAn5foTXb0TAVrnx0oDazHz/vt5qJ1Pye9zSAzQm8P3kRrFUhv8FXArK0a4dae2qZb98a/GY+E66HJUZZ0gH4tk9bLOXomeCVkUQZ4igeUrTUhnQeCe04PsstpD9d9Ir0zGswkvD+A9bQwrEhTct60+Oms6Dm3i883yf+HIsdZhFaP14rfYf5mFgD1rE7e89ZvPMvtBoeaiMmkycpPdLip/nCo4YGPpF/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY8pbB01IXQ1oDlvR4IjAqMf8Ve4AXO8FCmjAa4KwpE=;
 b=YAD6YbI2KP7Id3Z8Jfg8gFHpf2fMguBX0Ktyj9KH6kzK/pAKQ009TeKt781aJeQZrM+c0H0e9YN2J5yR+kIAQ0ampMZTwN1Cns/ZHAMzsZN0LVHe3fkM5VsrjFCWg6slp9VjpKMA7Veuw3Fn+7QaRX2b1NhgDGyQ0LzmFLUSn7rGVr5LJZXzZ3jdcQ7xrFmE8eiMCOV9djVU4eSA0TGcgTIXii8fzxtz3yEsolfoz5c5uFUGjmWnemmU9Gyw0cXfC6ctQfWx4mczlmttp4dojoYmzGBehZJYDQXdPVK2Zvf9yZMkZiKlJqAJ5ndbnAMQcmzCnAhxvaxK+I7IV971QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY8pbB01IXQ1oDlvR4IjAqMf8Ve4AXO8FCmjAa4KwpE=;
 b=JAoOfLo/gjcROtw7/AeYLJKu6yNEDlW2qCCteOtIkRdr7/bs+vu0EEvy+kCl704TjTDcy5He1YeedOfZnbpUi7iwxMU5N96yXeENQHHDrDL7gtxs5dB+FG6WQ3yJxroUtSNNBWHzflmfSlQRZSOv6xQ7uWu3iStx9BPBnjvbxsI7HWGUP/90KnxUpetW0Xgh59vE/sztYOVpAZ1Qk8uOj6k/X4pGfjgA4C08EK3gilACGhSLBcjaSTfQKFmpeaTrnZUnnEAQgnnV1Zd6k+lZNvEtxcwETpVPJNF8yJRpp6rrRAv++gY4CQFYAeydJC6Gopz4S0lzY+aYNEyFNvlLOw==
Received: from DM6PR07CA0051.namprd07.prod.outlook.com (2603:10b6:5:74::28) by
 MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 20:47:07 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::f8) by DM6PR07CA0051.outlook.office365.com
 (2603:10b6:5:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 20:47:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 13:47:00 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 13:46:59 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <kbusch@kernel.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <error27@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/4] null_blk: usr memcpy_[to|from]_page()
Date:   Wed, 29 Mar 2023 13:46:48 -0700
Message-ID: <20230329204652.52785-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8245dd-bd85-4ca3-a3ce-08db3096c2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGKFh+p8cihZNLnlVwjyDRgYOziggVYsDx/91k5w6kK+AbPU0kE9cNDp7/8czSisZHci58GaV8/+VryStbs+FFGoaULa7OnWyOAHmDsgKMdnMEn2d9PYVPhBA2pvxmackwkTNXYFtTFJKOIIz4o+ZfZV6SO1iEgDiysnu06X89AaRg5YB6Xcu24Td9e+e6YTWrTfor8wvCWvSgNjJtFs7lWsMLIxTcdzaREJz/ZbovcS77eVebfyPbw6OBddYA/cGMPRcdvlSVOyYXJAzLKUkqH4DwIR9Ck40Hp4qS7/orBr1UrOp9l70nrAdvJTAYxqQR4U+67CkbWjy0wYaHNDoO4yfYe3OPky93LgzJNTJ3ddGqKz0NfafqxWC9+rJoO6LtkA2N/FdQwa34JL6lfgU6ubcjRBT0lth71m4XzEAP5mmAd5D7zYtBnF5bYYMWXn0yBju08WtIWYK7Fhi8xExDtIS1u/pxdY0Vsd0Yt+uwh3exjTZqX/0RBzG60/033/cZ3NVyVpxW7521iXM4463A2YMrRpuM4o8sOBzGC2Fkpaj4E7lmfPJEK/6fSTCp2YwZGTBhHr1Mfoc3my4KXX430wmlBrjxLVj/ABRtodJQd/GM6mD0t9CVSZtT8bE2wMFs3I6KFiPkE9V2mXD9sv0PA71L1Y+gtc7gsPk18gbfny17NVFqUvW0iSQD2mdsdzKFv7/agwFGZCrcyUl/oaJ59h4qcOxC9fLAd1iZfMFQunjdeX8M0KCwbRJ06zhOyb
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(47076005)(2906002)(2616005)(83380400001)(426003)(336012)(6916009)(54906003)(8676002)(4326008)(70206006)(70586007)(478600001)(7696005)(1076003)(26005)(316002)(16526019)(107886003)(82310400005)(19627235002)(186003)(30864003)(6666004)(36756003)(36860700001)(41300700001)(7636003)(5660300002)(356005)(40480700001)(40460700003)(82740400003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:47:07.3397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8245dd-bd85-4ca3-a3ce-08db3096c2d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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
* Latency (lower is better)   :- approximately the same
* IOPS/BW (higner is better)  :- ~12k higner with this patch series
* CPU Usage (lower is better) :- approximately the same 

Set 2 (Average of 3 runs) :-
-----------------------------
* Latency (lower is better)   :- ~116 lower with this patch seires
* IOPS/BW (higner is better)  :- ~5k higner with this patch series
* CPU Usage (lower is better) :- approximately the same 

Below is the test for the fio verification job and perf numbers on nullb
along with the test log with debug patch to cover all the calls that are
modified in this series:-

copy_to_nullb()
	memcpy_to_page()
copy_from_nullb()
	memcpy_to_page()
	zero_user()
null_fill_pattern()
	memset_page()
null_flush_cache_page()
	kmap_local_page()
	kunmap_local_page()

In case someone shows up with performance regression on the arch that
I've don't have access to we can decide then if we want to drop it this
series or keep using deprecated kernel API, but I think removing
deprecated API is useful in long term in anyway.

-ck

Chaitanya Kulkarni (4):
  null_blk: use memcpy_page() in copy_to_nullb()
  null_blk: use memcpy_page() in copy_from_nullb()
  null-blk: use memset_page() to fill page pattern
  null_blk: use kmap_local_page() and kunmap_local()

 drivers/block/null_blk/main.c | 37 +++++++++++------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

#######################################################################
Performance numbers :-

* Set 1:-
----------------
* Avg Latency delta (lower is better) :- ~14 higher with this patch seires

linux-block (nullb-memcpy) # grep -w "lat (usec):" *null*fio 

default-nullb.1.fio:     lat (usec): min=1794, max=2179.1k, avg=23.26, stdev=5605.88
default-nullb.2.fio:     lat (usec): min=1995, max=6038.1k, avg=24.21, stdev=6305.29
default-nullb.3.fio:     lat (usec): min=2,    max=5554,    avg=24.12, stdev= 6.27
(23.26+24.21+24.12)/3 = 23

with-memcpy-nullb.1.fio: lat (usec): min=2, max=2461,       avg=23.49, stdev= 5.30
with-memcpy-nullb.2.fio: lat (usec): min=1943, max=2500.7k, avg=23.53, stdev=5942.17
with-memcpy-nullb.3.fio: lat (usec): min=2, max=2316,       avg=23.64, stdev= 5.58
(23.49+23.53+23.64)/3 = 23

* Ave IOPS/BW delta (higner is better):- ~47k higner with this patch series

linux-block (nullb-memcpy) # grep IOPS *nullb*fio
default-nullb.1.fio:      read: IOPS=1017k, BW=3974MiB/s (4167MB/s)(233GiB/60002msec)
default-nullb.2.fio:      read: IOPS=978k, BW=3820MiB/s (4006MB/s)(224GiB/60001msec)
default-nullb.3.fio:      read: IOPS=982k, BW=3835MiB/s (4022MB/s)(225GiB/60002msec)
(1017+978+982)/3 = 992k

with-memcpy-nullb.1.fio:  read: IOPS=1008k, BW=3939MiB/s (4130MB/s)(231GiB/60002msec)
with-memcpy-nullb.2.fio:  read: IOPS=1006k, BW=3931MiB/s (4122MB/s)(230GiB/60001msec)
with-memcpy-nullb.3.fio:  read: IOPS=1002k, BW=3913MiB/s (4103MB/s)(229GiB/60001msec)
(1008+1006+1002)/3 = 1005;

* Avg CPU Usage delta (lower is better) :- approximately the same 

linux-block (nullb-memcpy) # grep cpu  *nullb*fio

default-nullb.1.fio:      cpu: usr=2.08%, sys=97.83%, ctx=4767, majf=0, minf=367
default-nullb.2.fio:      cpu: usr=2.06%, sys=97.84%, ctx=3013, majf=0, minf=379
default-nullb.3.fio:      cpu: usr=2.15%, sys=97.75%, ctx=17878, majf=0, minf=369
(97.83+97.84+97.75)/3 = 97

with-memcpy-nullb.1.fio:  cpu: usr=2.08%, sys=97.83%, ctx=8507, majf=0, minf=391
with-memcpy-nullb.2.fio:  cpu: usr=2.12%, sys=97.79%, ctx=4817, majf=0, minf=359
with-memcpy-nullb.3.fio:  cpu: usr=2.20%, sys=97.72%, ctx=2963, majf=0, minf=351
(97.83+97.79+97.72)/3 = 97

* Set 2:-
----------------
* Avg Latency delta (lower is better) :- ~14 higher with this patch seires

linux-block (nullb-memcpy) # grep -w "lat (nsec):" *null*fio 

default-nullb.1.fio:     lat (nsec): min=1975, max=4169.3k, avg=22580.36, stdev=4611.23
default-nullb.2.fio:     lat (nsec): min=1984, max=1055.5k, avg=22609.24, stdev=4611.20
default-nullb.3.fio:     lat (nsec): min=1974, max=2565.9k, avg=22750.96, stdev=4480.30
(22580.36+22609.24+22750.96)/3 = 22646

with-memcpy-nullb.1.fio: lat (nsec): min=1983, max=11398k, avg=22441.78, stdev=6809.98
with-memcpy-nullb.2.fio: lat (nsec): min=1853, max=1083.9k, avg=22620.39, stdev=4607.59
with-memcpy-nullb.3.fio: lat (nsec): min=1974, max=6048.1k, avg=22528.70, stdev=4902.61
(22441.78+22620.39+22528.70)/3 = 22530


* Ave IOPS/BW delta (higner is better ):- ~47k higner with this patch series

linux-block (nullb-memcpy) # grep IOPS *null*fio
default-nullb.1.fio:      read: IOPS=1050k, BW=4100MiB/s (4299MB/s)(240GiB/60002msec)
default-nullb.2.fio:      read: IOPS=1048k, BW=4095MiB/s (4294MB/s)(240GiB/60001msec)
default-nullb.3.fio:      read: IOPS=1042k, BW=4069MiB/s (4267MB/s)(238GiB/60001msec)
(1050+1048+1042)/3 = 1046

with-memcpy-nullb.1.fio:  read: IOPS=1055k, BW=4123MiB/s (4323MB/s)(242GiB/60001msec)
with-memcpy-nullb.2.fio:  read: IOPS=1048k, BW=4093MiB/s (4292MB/s)(240GiB/60001msec)
with-memcpy-nullb.3.fio:  read: IOPS=1051k, BW=4107MiB/s (4306MB/s)(241GiB/60001msec)
(1055+1048+1051)/3 = 1051


* Avg CPU Usage delta (lower is better) :- approximately the same 

linux-block (nullb-memcpy) # grep cpu  *nullb*fio

default-nullb.1.fio:      cpu: usr=1.99%, sys=97.94%, ctx=4581, majf=0, minf=353
default-nullb.2.fio:      cpu: usr=1.99%, sys=97.94%, ctx=7169, majf=0, minf=373
default-nullb.3.fio:      cpu: usr=2.02%, sys=97.91%, ctx=3560, majf=0, minf=348
(97.94+97.94+97.91)/3 = 97

with-memcpy-nullb.1.fio:  cpu: usr=2.03%, sys=97.91%, ctx=2405, majf=0, minf=348
with-memcpy-nullb.2.fio:  cpu: usr=2.01%, sys=97.92%, ctx=2313, majf=0, minf=364
with-memcpy-nullb.3.fio:  cpu: usr=2.04%, sys=97.88%, ctx=7224, majf=0, minf=348
(97.91+97.92+97.88)/3 = 97

#######################################################################
Testing with fio verification and randread workload on null:-

linux-block (nullb-memcpy) # sh test-nullb-memcpy-perf.sh 
Already on 'nullb-memcpy'
0eb5ac9f7c03 (HEAD -> nullb-memcpy, brd-memcpy) null_blk: use kmap_local_page() and kunmap_local()
9a8f884aea9e null-blk: use memset_page() to fill page pattern
5363fb1a0481 null_blk: use memcpy_page() in copy_from_nullb()
66dee4a65d8c null_blk: use memcpy_page() in copy_to_nullb()
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
+ rmdir config/nullb/nullb0
+ dmesg -c
+ modprobe -r null_blk
+ lsmod
+ grep null_blk
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/null_blk/main.o
  LD [M]  drivers/block/null_blk/null_blk.o
  MODPOST drivers/block/Module.symvers
  LD [M]  drivers/block/null_blk/null_blk.ko
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/6.3.0-rc4lblk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.3.0-rc4lblk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.3.0-rc4lblk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.2M Mar 28 22:19 /lib/modules/6.3.0-rc4lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
+ let NN=1-1
+ modprobe -r null_blk
+ modprobe null_blk nr_devices=0
+ echo loading devices
loading devices
++ seq 0 0
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb0
+ mkdir config/nullb/nullb0
+ cat config/nullb/nullb0/zoned
0
+ echo 256
+ echo 0
+ echo 1
+ echo 4096
+ echo 1024
+ echo 0
+ echo 1
+ echo 2
+ cat config/nullb/nullb0/queue_mode
2
+ echo 1
++ cat config/nullb/nullb0/index
+ IDX=0
+ echo -n ' 0 '
 0 + sleep .50
+ lsblk
+ grep null
+ sort
nullb0  250:0    0    1G  0 disk 
+ sleep 1
+ dmesg -c
[109428.330925] null_blk: module loaded
[109428.339399] null_blk: disk nullb0 created
+ lsblk
+ grep null
nullb0  250:0    0    1G  0 disk 
+ dmesg -c
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0   50G  0 disk 
├─sda1    8:1    0    1G  0 part /boot
└─sda2    8:2    0   49G  0 part /home
sdb       8:16   0  100G  0 disk /mnt/data
sr0      11:0    1 1024M  0 rom  
nullb0  250:0    0    1G  0 disk 
zram0   251:0    0    8G  0 disk [SWAP]
vda     252:0    0  512M  0 disk 
nvme0n1 259:0    0    1G  0 disk 
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][52.6%][r=551MiB/s,w=451MiB/s][r=141k,w=115k IOPS][eta 00m:18s]
write-and-verify: (groupid=0, jobs=1): err= 0: pid=32911: Tue Mar 28 22:23:41 2023
  read: IOPS=348k, BW=1358MiB/s (1424MB/s)(1024MiB/754msec)
    slat (nsec): min=1432, max=51208, avg=1796.19, stdev=435.47
    clat (nsec): min=1333, max=94580, avg=43406.05, stdev=2272.20
     lat (nsec): min=3147, max=96333, avg=45246.12, stdev=2322.51
    clat percentiles (nsec):
     |  1.00th=[41216],  5.00th=[41728], 10.00th=[42240], 20.00th=[42240],
     | 30.00th=[42752], 40.00th=[42752], 50.00th=[42752], 60.00th=[43264],
     | 70.00th=[43264], 80.00th=[43776], 90.00th=[44288], 95.00th=[48896],
     | 99.00th=[52480], 99.50th=[54528], 99.90th=[58112], 99.95th=[59648],
     | 99.99th=[86528]
  write: IOPS=202k, BW=788MiB/s (826MB/s)(15.0GiB/19488msec); 0 zone resets
    slat (usec): min=2, max=824, avg= 4.35, stdev= 1.01
    clat (nsec): min=1192, max=920392, avg=74631.98, stdev=5773.07
     lat (usec): min=4, max=924, avg=79.03, stdev= 6.03
    clat percentiles (usec):
     |  1.00th=[   64],  5.00th=[   71], 10.00th=[   72], 20.00th=[   73],
     | 30.00th=[   74], 40.00th=[   74], 50.00th=[   75], 60.00th=[   75],
     | 70.00th=[   76], 80.00th=[   76], 90.00th=[   80], 95.00th=[   84],
     | 99.00th=[   92], 99.50th=[  100], 99.90th=[  131], 99.95th=[  143],
     | 99.99th=[  163]
   bw (  KiB/s): min=743912, max=911200, per=99.94%, avg=806596.92, stdev=22455.14, samples=39
   iops        : min=185978, max=227800, avg=201649.23, stdev=5613.87, samples=39
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=5.97%, 100=93.56%
  lat (usec)   : 250=0.46%, 500=0.01%, 1000=0.01%
  cpu          : usr=53.05%, sys=46.87%, ctx=33, majf=0, minf=6167
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=262144,3932160,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1358MiB/s (1424MB/s), 1358MiB/s-1358MiB/s (1424MB/s-1424MB/s), io=1024MiB (1074MB), run=754-754msec
  WRITE: bw=788MiB/s (826MB/s), 788MiB/s-788MiB/s (826MB/s-826MB/s), io=15.0GiB (16.1GB), run=19488-19488msec

Disk stats (read/write):
  nullb0: ios=228219/3932160, merge=0/0, ticks=172/4509, in_queue=4682, util=99.56%

#######################################################################
Testing for each patch with debug patch to cover all modified calls in
this patch series :-

* null_flush_cache_page() write to null_blk with cache enabled.

linux-block (nullb-memcpy) # modprobe null_blk gb=1 cache_size=1 memory_backed=1
linux-block (nullb-memcpy) # dd if=/dev/zero of=/dev/nullb0 count=$((2*1024*1024/4096)) bs=4k
512+0 records in
512+0 records out
2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.00539398 s, 389 MB/s
linux-block (nullb-memcpy) # dmesg  -c
[115885.171915] null_blk: disk nullb0 created
[115885.171919] null_blk: module loaded
[115889.623978] null_blk: null_flush_cache_page 1033 kmap_local_page()
[115889.623988] null_blk: null_flush_cache_page 1033 kmap_local_page()
[115889.623991] null_blk: null_flush_cache_page 1033 kmap_local_page()
[115889.623993] null_blk: null_flush_cache_page 1033 kmap_local_page()
[115889.623996] null_blk: null_flush_cache_page 1033 kmap_local_page()
[115889.623998] null_blk: null_flush_cache_page 1033 kmap_local_page()
-----------------------------------cut--------------------------------

* null_blk_fill_pattern() read beyond the zone write pointer :-

linux-block (nullb-memcpy) # modprobe null_blk gb=1 memory_backed=1 zoned=1
linux-block (nullb-memcpy) # dd if=/dev/nullb0 of=/dev/null bs=4k count=1
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000224737 s, 18.2 MB/s
linux-block (nullb-memcpy) # blkzone report /dev/nullb0
  start: 0x000000000, len 0x080000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x080000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x080000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x080000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
linux-block (nullb-memcpy) # dd if=/dev/nullb0 of=/dev/null count=10 bs=4k
10+0 records in
10+0 records out
40960 bytes (41 kB, 40 KiB) copied, 0.000398227 s, 103 MB/s
linux-block (nullb-memcpy) # dmesg  -c 
[116117.786823] null_blk: nullb_fill_pattern 1175 memset_page()
[116117.786857] null_blk: nullb_fill_pattern 1175 memset_page()
[116117.786912] null_blk: disk nullb0 created
[116117.786914] null_blk: module loaded
[116120.432254] null_blk: nullb_fill_pattern 1175 memset_page()
[116120.432259] null_blk: nullb_fill_pattern 1175 memset_page()
[116120.432261] null_blk: nullb_fill_pattern 1175 memset_page()
[116120.432263] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441410] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441418] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441421] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441423] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441490] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441492] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441494] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441497] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441499] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441500] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441502] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441504] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441509] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441511] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441513] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441515] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441517] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441519] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441521] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441523] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441525] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441527] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441529] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441531] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441534] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441536] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441538] null_blk: nullb_fill_pattern 1175 memset_page()
[116129.441539] null_blk: nullb_fill_pattern 1175 memset_page()

* copy_to_nullb()/copy from_nullb() Read/write to memory backed null_blk

linux-block (nullb-memcpy) # dd if=/dev/zero of=/dev/nullb0 count=1 bs=4k oflag=direct
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000262448 s, 15.6 MB/s
linux-block (nullb-memcpy) # dd if=/dev/nullb0 of=/dev/null count=1 bs=4k
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000320249 s, 12.8 MB/s
linux-block (nullb-memcpy) # dmesg  -c
[116147.220358] null_blk: copy_to_nullb 1129 memcpy_page()
[116147.220366] null_blk: copy_to_nullb 1129 memcpy_page()
[116147.220368] null_blk: copy_to_nullb 1129 memcpy_page()
[116147.220369] null_blk: copy_to_nullb 1129 memcpy_page()
[116147.220370] null_blk: copy_to_nullb 1129 memcpy_page()
[116147.220371] null_blk: copy_to_nullb 1129 memcpy_page()
[116147.220372] null_blk: copy_to_nullb 1129 memcpy_page()
[116147.220373] null_blk: copy_to_nullb 1129 memcpy_page()
[116150.454379] null_blk: copy_from_nullb 1160 memcpy_page()
[116150.454388] null_blk: copy_from_nullb 1160 memcpy_page()
[116150.454391] null_blk: copy_from_nullb 1160 memcpy_page()
[116150.454393] null_blk: copy_from_nullb 1160 memcpy_page()
[116150.454395] null_blk: copy_from_nullb 1160 memcpy_page()
[116150.454396] null_blk: copy_from_nullb 1160 memcpy_page()
[116150.454398] null_blk: copy_from_nullb 1160 memcpy_page()
[116150.454400] null_blk: copy_from_nullb 1160 memcpy_page()
[116150.454401] null_blk: nullb_fill_pattern 1175 memset_page()
[116150.454404] null_blk: nullb_fill_pattern 1175 memset_page()
[116150.454407] null_blk: nullb_fill_pattern 1175 memset_page()
linux-block (nullb-memcpy) # modprobe  -r null_blk

* copy_from_nullb() read from membacked null_blk without any writes

linux-block (nullb-memcpy) # modprobe null_blk gb=1 memory_backed=1 cache_size=1
linux-block (nullb-memcpy) # dd if=/dev/nullb0 of=/dev/null bs=4k count=1
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000218966 s, 18.7 MB/s
linux-block (nullb-memcpy) # dmesg  -c
[116159.744004] null_blk: copy_from_nullb 1163 zero_user()
[116159.744009] null_blk: copy_from_nullb 1163 zero_user()
[116159.744009] null_blk: copy_from_nullb 1163 zero_user()
[116159.744010] null_blk: copy_from_nullb 1163 zero_user()
[116159.744010] null_blk: copy_from_nullb 1163 zero_user()
[116159.744011] null_blk: copy_from_nullb 1163 zero_user()
[116159.744011] null_blk: copy_from_nullb 1163 zero_user()
[116159.744012] null_blk: copy_from_nullb 1163 zero_user()
[116159.744021] null_blk: copy_from_nullb 1163 zero_user()
[116159.744022] null_blk: copy_from_nullb 1163 zero_user()
[116159.744022] null_blk: copy_from_nullb 1163 zero_user()
[116159.744023] null_blk: copy_from_nullb 1163 zero_user()
[116159.744023] null_blk: copy_from_nullb 1163 zero_user()
[116159.744024] null_blk: copy_from_nullb 1163 zero_user()
[116159.744024] null_blk: copy_from_nullb 1163 zero_user()
[116159.744025] null_blk: copy_from_nullb 1163 zero_user()
[116159.744046] null_blk: disk nullb0 created
[116159.744047] null_blk: module loaded
[116163.094839] null_blk: copy_from_nullb 1163 zero_user()
[116163.094847] null_blk: copy_from_nullb 1163 zero_user()
[116163.094848] null_blk: copy_from_nullb 1163 zero_user()
[116163.094850] null_blk: copy_from_nullb 1163 zero_user()
[116163.094851] null_blk: copy_from_nullb 1163 zero_user()
[116163.094852] null_blk: copy_from_nullb 1163 zero_user()
[116163.094853] null_blk: copy_from_nullb 1163 zero_user()
[116163.094854] null_blk: copy_from_nullb 1163 zero_user()
[116163.094856] null_blk: copy_from_nullb 1163 zero_user()
[116163.094857] null_blk: copy_from_nullb 1163 zero_user()
[116163.094858] null_blk: copy_from_nullb 1163 zero_user()
[116163.094859] null_blk: copy_from_nullb 1163 zero_user()
[116163.094860] null_blk: copy_from_nullb 1163 zero_user()
[116163.094861] null_blk: copy_from_nullb 1163 zero_user()
[116163.094862] null_blk: copy_from_nullb 1163 zero_user()
[116163.094863] null_blk: copy_from_nullb 1163 zero_user()
[116163.094864] null_blk: copy_from_nullb 1163 zero_user()
[116163.094865] null_blk: copy_from_nullb 1163 zero_user()
[116163.094866] null_blk: copy_from_nullb 1163 zero_user()
[116163.094867] null_blk: copy_from_nullb 1163 zero_user()
[116163.094868] null_blk: copy_from_nullb 1163 zero_user()
[116163.094869] null_blk: copy_from_nullb 1163 zero_user()
[116163.094870] null_blk: copy_from_nullb 1163 zero_user()
[116163.094871] null_blk: copy_from_nullb 1163 zero_user()
[116163.094873] null_blk: copy_from_nullb 1163 zero_user()
[116163.094874] null_blk: copy_from_nullb 1163 zero_user()
[116163.094875] null_blk: copy_from_nullb 1163 zero_user()
[116163.094876] null_blk: copy_from_nullb 1163 zero_user()
[116163.094877] null_blk: copy_from_nullb 1163 zero_user()
[116163.094878] null_blk: copy_from_nullb 1163 zero_user()
[116163.094879] null_blk: copy_from_nullb 1163 zero_user()
[116163.094880] null_blk: copy_from_nullb 1163 zero_user()
linux-block (nullb-memcpy) # modprobe  -r null_blk


Debug Patch used for testing :-

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index bc2c58724df3..46b3381cd42b 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1030,6 +1030,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
        if (!t_page)
                return -ENOMEM;
 
+       pr_info("%s %d kmap_local_page()\n", __func__, __LINE__);
        src = kmap_local_page(c_page->page);
        dst = kmap_local_page(t_page->page);
 
@@ -1125,6 +1126,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
                if (!t_page)
                        return -ENOSPC;
 
+               pr_info("%s %d memcpy_page()\n", __func__, __LINE__);
                memcpy_page(t_page->page, offset, source, off + count, temp);
 
                __set_bit(sector & SECTOR_MASK, t_page->bitmap);
@@ -1152,11 +1154,14 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
                t_page = null_lookup_page(nullb, sector, false,
                        !null_cache_active(nullb));
 
-               if (t_page)
+               if (t_page) {
                        memcpy_page(dest, off + count, t_page->page, offset,
                                    temp);
-               else
+                       pr_info("%s %d memcpy_page()\n", __func__, __LINE__);
+               } else {
                        zero_user(dest, off + count, temp);
+                       pr_info("%s %d zero_user()\n", __func__, __LINE__);
+               }
 
                count += temp;
                sector += temp >> SECTOR_SHIFT;
@@ -1167,6 +1172,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
                               unsigned int len, unsigned int off)
 {
+       pr_info("%s %d memset_page()\n", __func__, __LINE__);
        memset_page(page, off, 0xff, len);
 }


-- 
2.29.0

