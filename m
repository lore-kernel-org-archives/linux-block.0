Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2E7C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 11:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiBOLvb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:51:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBOLva (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 06:51:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B48989301
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 03:51:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvYz0lC2au7wDcNTeeBNsCMTwKulOGQlnTxBaBkGywLW/s0Ayk1Ugy8jR0A+zvhD9zGDmU0juu813JUfq2+8SBX70HJim3eQCL3usHcikthz6vjV6PtbqTiOO960C7tW0FX0jIquqo/A4hTktrUT0bd8fXRLLdmthyiq3NG8F812nC+FJGJKwY3deavXkqvTscjbgRqJtHNumAUQaozT4H88KbgZHP8cAZmzGptzQaQvxAGpJNEJ9MkPVhlhORmltRNsKa9vGgJJW7gCSMIIeHyvg9/PVf1DXtk7VIPrFNDdnrcL+zq2B8T2DobZWXKqWzbd1M4Yr+ppqWYL2qUZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHaJoPYdUQupYxDqJ/HgRMVvwSfwIW2xs54nS49TutE=;
 b=Xhr7sC+z0ByJD2Np3j+UsFFqBiVqtbZXYsqaXE8xrQh8Rq1Z/YaVSV+zrwJ8Ot8Uy865uPjROU6wss9BKt3cHu8I2sBlMZG6ZE2cMsoxIJapZ6KBeKU8gPkgkCiOHKBsHS4kgQTkrINuLWR6wyEplTQ9yxJrz18IfX+asyO+6uKvL2Mqjgq8GTu2HB636s8JCc8mbIx1UTxNDE1npTrxVs43YrdgVwOqH912SbcDZMVCdinedTn/EkWNJSpjpZNGdGvj7b4Y49GE/cU4QZbcid7C24kzFi0152SNoo3OpXf8lFrkELUJTeWZpWJVrucvBWOCdCqD5Vz139Go1sGSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHaJoPYdUQupYxDqJ/HgRMVvwSfwIW2xs54nS49TutE=;
 b=CW5TwDeXv5pFvnuQYBHGhnMmxGRy+cgzY0E1ARYzeDpvAZi7y7B/J+l/XSt6iEK51RfHOshq7rDSLzwjqzs4D5ypV70sNjtBE1tqDS1qUQ/ivXYkwO3OPyxsEvaVcEoSY1AWj2nNgctM/Hz211tyzoPYFmefys/WcI4TydN8indCjQb2pBlYstUJLFAQc/z+urjsfu8uKH7CeNrPYapSfoBDuKaBH9/SlzdaHwZ+HBCCZRHwjD45pqnaiekGMVp7jWFsDbr4vCYb+NqxcfXiv7qtWNWNiBaly5hvdgJU721ULdIcX9r26MyXYVI7K7MbTEvVfKPjHEjOgyYIJ5GUmA==
Received: from DM5PR04CA0045.namprd04.prod.outlook.com (2603:10b6:3:12b::31)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 11:51:15 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::1d) by DM5PR04CA0045.outlook.office365.com
 (2603:10b6:3:12b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Tue, 15 Feb 2022 11:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:51:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:51:14 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:51:13 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 0/4] loop: cleanup and few improvements
Date:   Tue, 15 Feb 2022 03:51:00 -0800
Message-ID: <20220215115104.11429-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b0064a8-adaa-468f-1ec3-08d9f0797865
X-MS-TrafficTypeDiagnostic: DM8PR12MB5414:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5414E1296F82D2FF06B09220A3349@DM8PR12MB5414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hFKWuCbd3icbQsj8GMQNdVjDFX8NeJZntUs67o1qUEKvoH2vt2cvG6cIzoDDlgKy9GgB5MHuTwB9PgHymK2Ou07xscuqF0n3ker2SVKivF3r6qw48FD0eUsBXwNZDOaHpMApwmnYpWEMAN69lRE/XVqSdLFSBOj43/LeCCuIzVQRFiYPl1ZEIXs+9Hevlrphk0Cgl1BaxXBT2hIZKQWBbzmcdlMpUakgfyKi5NgKrMQqaMgWtcs7zVlCDq5/DVH+Mq78hzOTVc6cHMdO1szsiLam9AQsp+mASA1mh7Rgdo3Z2VkiPrg1Fd7R8P4VrC75hhgg9VqdQj4psWiXPRGjkz8JsqhzH06eMPSCdcbjfERLqU4lkqPthbX5gGR7ZqrZj2urlROQP2H8LZzeeFTXXmb800lY/2Qj0PAX1j1xqM4hOub6RnrNwbZhGQeh/CWQ3bHDJWKpzC7devdHZz0I7j0dE58gBnUGw/iQPpdHy6Pk6+YVtqlGSR8aO8dGxaESt2Rv6wiB4MlWrVtM0EGA5+Maz9KA4zRKIXYM534tUO4vWPORPLWwpdeunPfbr6BoB1ULZns4+Pi86oqgCsHEaaGLZMV7+4Vgm3ISo6w0Vej8MT1qisgIvFwygoiwlkFzkVu2yee4lkobLlYDdL3nxvlhdRQvCzF5ieamK7SXiozqpTLD2qATRITkxglAX4aZi1fbzi9AxiOTjg7SL6/zY82Avz6ka3hH6h5oWvRen7o=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(8676002)(70206006)(5660300002)(8936002)(7696005)(70586007)(508600001)(47076005)(30864003)(40460700003)(6916009)(54906003)(36756003)(316002)(19627235002)(6666004)(426003)(336012)(26005)(356005)(16526019)(186003)(2616005)(82310400004)(107886003)(83380400001)(1076003)(2906002)(36860700001)(81166007)(21314003)(36900700001)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:51:14.9831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0064a8-adaa-468f-1ec3-08d9f0797865
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This has few improvment and cleanups such as using sysfs_emit() for the
sysfs dev attributes and removing variables that are only used once and
a cleanup with fixing declaration.

Below is the test log where 10 loop devices created, each device is
linked to it's own file in ./loopX, formatted with xfs and mounted on
/mnt/loopX. For each device it reads the offset, sizelimit, autoclear,
partscan, and dio attr from sysfs using cat command, then it runs fio
verify job on it.

In summary write-verify fio job seems to work fine :-
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3495: Mon Feb 14 00:43:19 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3960: Mon Feb 14 00:45:17 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4321: Mon Feb 14 00:47:15 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4369: Mon Feb 14 00:49:20 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4443: Mon Feb 14 00:51:25 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4536: Mon Feb 14 00:53:25 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4770: Mon Feb 14 00:55:24 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4933: Mon Feb 14 00:57:31 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=5008: Mon Feb 14 00:59:35 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=5048: Mon Feb 14 01:01:58 2022

Below is detailed test log.

-ck 

changes from V1:-

1. Squash all patches for sysfs_emit() into single patch. (Jens)

Chaitanya Kulkarni (4):
  loop: use sysfs_emit() in the sysfs xxx show()
  loop: remove extra variable in lo_fallocate()
  loop: remove extra variable in lo_req_flush
  loop: allow user to set the queue depth

 drivers/block/loop.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)
oot@dev linux-block (for-next) # git am p/loop-sysfs-emit/*patch 
Patch is empty.
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
root@dev linux-block (for-next) # git am --skip 
Applying: loop: use sysfs_emit() in the sysfs xxx show()
Applying: loop: remove extra variable in lo_fallocate()
Applying: loop: remove extra variable in lo_req_flush
Applying: loop: allow user to set the queue depth
root@dev linux-block (for-next) # ./compile_nullb.sh 10
+ umount /mnt/nullb0
umount: /mnt/nullb0: no mount point specified.
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ dmesg -c
+ modprobe -r null_blk
+ lsmod
+ grep null_blk
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/loop.o
  CC [M]  drivers/block/pktcdvd.o
  MODPOST drivers/block/Module.symvers
  LD [M]  drivers/block/loop.ko
  LD [M]  drivers/block/pktcdvd.ko
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/5.17.0-rc3blk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.1M Feb 14 22:12 /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
root@dev linux-block (for-next) # ./compile_loop.sh 10
+ FILE=./loop
+ LOOP_MNT=/mnt/loop
+ NN=10
+ unload_loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop10
umount: /mnt/loop10: no mount point specified.
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop4
umount: /mnt/loop4: no mount point specified.
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop8
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop2
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop9
umount: /mnt/loop9: no mount point specified.
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop1
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop7
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop3
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop6
umount: /mnt/loop6: not mounted.
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop5
umount: /mnt/loop5: no mount point specified.
+ rm -fr ./loop5
+ losetup -D
+ sleep 3
+ rmmod loop
+ modprobe -r loop
+ lsmod
+ grep loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop7
+ rm -fr /mnt/loop1 /mnt/loop2 /mnt/loop3 /mnt/loop6 /mnt/loop7 /mnt/loop8
+ compile_loop
++ nproc
+ make -j 48 M=drivers/block modules
+ HOST=drivers/block/
++ uname -r
+ HOST_DEST=/lib/modules/5.17.0-rc3blk+/kernel/drivers/block
+ cp drivers/block//loop.ko /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/
+ load_loop
+ insmod drivers/block/loop.ko max_loop=11 hw_queue_depth=32
++ shuf -i 1-10 -n 10
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop4
+ truncate -s 2048M ./loop4
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop4 ./loop4
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop4
meta-data=/dev/loop4             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
+ mount /dev/loop4 /mnt/loop4
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/offset : '
cat /sys/block/loop4/loop/offset : + cat /sys/block/loop4/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/sizelimit : '
cat /sys/block/loop4/loop/sizelimit : + cat /sys/block/loop4/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/autoclear : '
cat /sys/block/loop4/loop/autoclear : + cat /sys/block/loop4/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/partscan : '
cat /sys/block/loop4/loop/partscan : + cat /sys/block/loop4/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/dio : '
cat /sys/block/loop4/loop/dio : + cat /sys/block/loop4/loop/dio
1
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop5
+ truncate -s 2048M ./loop5
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop5 ./loop5
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop5
meta-data=/dev/loop5             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
+ mount /dev/loop5 /mnt/loop5
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/offset : '
cat /sys/block/loop5/loop/offset : + cat /sys/block/loop5/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/sizelimit : '
cat /sys/block/loop5/loop/sizelimit : + cat /sys/block/loop5/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/autoclear : '
cat /sys/block/loop5/loop/autoclear : + cat /sys/block/loop5/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/partscan : '
cat /sys/block/loop5/loop/partscan : + cat /sys/block/loop5/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/dio : '
cat /sys/block/loop5/loop/dio : + cat /sys/block/loop5/loop/dio
1
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop7
+ truncate -s 2048M ./loop7
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop7 ./loop7
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop7
meta-data=/dev/loop7             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
+ mount /dev/loop7 /mnt/loop7
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/offset : '
cat /sys/block/loop7/loop/offset : + cat /sys/block/loop7/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/sizelimit : '
cat /sys/block/loop7/loop/sizelimit : + cat /sys/block/loop7/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/autoclear : '
cat /sys/block/loop7/loop/autoclear : + cat /sys/block/loop7/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/partscan : '
cat /sys/block/loop7/loop/partscan : + cat /sys/block/loop7/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/dio : '
cat /sys/block/loop7/loop/dio : + cat /sys/block/loop7/loop/dio
1
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop2
+ truncate -s 2048M ./loop2
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop2 ./loop2
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop2
meta-data=/dev/loop2             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
+ mount /dev/loop2 /mnt/loop2
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/offset : '
cat /sys/block/loop2/loop/offset : + cat /sys/block/loop2/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/sizelimit : '
cat /sys/block/loop2/loop/sizelimit : + cat /sys/block/loop2/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/autoclear : '
cat /sys/block/loop2/loop/autoclear : + cat /sys/block/loop2/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/partscan : '
cat /sys/block/loop2/loop/partscan : + cat /sys/block/loop2/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/dio : '
cat /sys/block/loop2/loop/dio : + cat /sys/block/loop2/loop/dio
1
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop9
+ truncate -s 2048M ./loop9
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop9 ./loop9
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
/dev/loop9         0      0         0  0 /mnt/data/linux-block/loop9   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop9
meta-data=/dev/loop9             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
+ mount /dev/loop9 /mnt/loop9
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/offset : '
cat /sys/block/loop9/loop/offset : + cat /sys/block/loop9/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/sizelimit : '
cat /sys/block/loop9/loop/sizelimit : + cat /sys/block/loop9/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/autoclear : '
cat /sys/block/loop9/loop/autoclear : + cat /sys/block/loop9/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/partscan : '
cat /sys/block/loop9/loop/partscan : + cat /sys/block/loop9/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/dio : '
cat /sys/block/loop9/loop/dio : + cat /sys/block/loop9/loop/dio
1
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop1
+ truncate -s 2048M ./loop1
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop1 ./loop1
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
/dev/loop9         0      0         0  0 /mnt/data/linux-block/loop9   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop1
meta-data=/dev/loop1             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
+ mount /dev/loop1 /mnt/loop1
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/offset : '
cat /sys/block/loop1/loop/offset : + cat /sys/block/loop1/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/sizelimit : '
cat /sys/block/loop1/loop/sizelimit : + cat /sys/block/loop1/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/autoclear : '
cat /sys/block/loop1/loop/autoclear : + cat /sys/block/loop1/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/partscan : '
cat /sys/block/loop1/loop/partscan : + cat /sys/block/loop1/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/dio : '
cat /sys/block/loop1/loop/dio : + cat /sys/block/loop1/loop/dio
1
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop8
+ truncate -s 2048M ./loop8
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop8 ./loop8
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
/dev/loop9         0      0         0  0 /mnt/data/linux-block/loop9   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop8
meta-data=/dev/loop8             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
+ mount /dev/loop8 /mnt/loop8
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/offset : '
cat /sys/block/loop8/loop/offset : + cat /sys/block/loop8/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/sizelimit : '
cat /sys/block/loop8/loop/sizelimit : + cat /sys/block/loop8/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/autoclear : '
cat /sys/block/loop8/loop/autoclear : + cat /sys/block/loop8/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/partscan : '
cat /sys/block/loop8/loop/partscan : + cat /sys/block/loop8/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/dio : '
cat /sys/block/loop8/loop/dio : + cat /sys/block/loop8/loop/dio
1
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop3
+ truncate -s 2048M ./loop3
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop3 ./loop3
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
/dev/loop9         0      0         0  0 /mnt/data/linux-block/loop9   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
/dev/loop3         0      0         0  0 /mnt/data/linux-block/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop3
meta-data=/dev/loop3             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
+ mount /dev/loop3 /mnt/loop3
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/offset : '
cat /sys/block/loop3/loop/offset : + cat /sys/block/loop3/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/sizelimit : '
cat /sys/block/loop3/loop/sizelimit : + cat /sys/block/loop3/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/autoclear : '
cat /sys/block/loop3/loop/autoclear : + cat /sys/block/loop3/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/partscan : '
cat /sys/block/loop3/loop/partscan : + cat /sys/block/loop3/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/dio : '
cat /sys/block/loop3/loop/dio : + cat /sys/block/loop3/loop/dio
1
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop6
+ truncate -s 2048M ./loop6
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop6 ./loop6
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop6         0      0         0  0 /mnt/data/linux-block/loop6   1     512
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
/dev/loop9         0      0         0  0 /mnt/data/linux-block/loop9   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
/dev/loop3         0      0         0  0 /mnt/data/linux-block/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop6
meta-data=/dev/loop6             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
+ mount /dev/loop6 /mnt/loop6
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/offset : '
cat /sys/block/loop6/loop/offset : + cat /sys/block/loop6/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/sizelimit : '
cat /sys/block/loop6/loop/sizelimit : + cat /sys/block/loop6/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/autoclear : '
cat /sys/block/loop6/loop/autoclear : + cat /sys/block/loop6/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/partscan : '
cat /sys/block/loop6/loop/partscan : + cat /sys/block/loop6/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/dio : '
cat /sys/block/loop6/loop/dio : + cat /sys/block/loop6/loop/dio
1
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop10
+ truncate -s 2048M ./loop10
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop10 ./loop10
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop8          0      0         0  0 /mnt/data/linux-block/loop8    1     512
/dev/loop6          0      0         0  0 /mnt/data/linux-block/loop6    1     512
/dev/loop4          0      0         0  0 /mnt/data/linux-block/loop4    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
/dev/loop7          0      0         0  0 /mnt/data/linux-block/loop7    1     512
/dev/loop5          0      0         0  0 /mnt/data/linux-block/loop5    1     512
/dev/loop3          0      0         0  0 /mnt/data/linux-block/loop3    1     512
/dev/loop10         0      0         0  0 /mnt/data/linux-block/loop10   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop10
meta-data=/dev/loop10            isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
+ mount /dev/loop10 /mnt/loop10
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/offset : '
cat /sys/block/loop10/loop/offset : + cat /sys/block/loop10/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/sizelimit : '
cat /sys/block/loop10/loop/sizelimit : + cat /sys/block/loop10/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/autoclear : '
cat /sys/block/loop10/loop/autoclear : + cat /sys/block/loop10/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/partscan : '
cat /sys/block/loop10/loop/partscan : + cat /sys/block/loop10/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/dio : '
cat /sys/block/loop10/loop/dio : + cat /sys/block/loop10/loop/dio
1
+ mount
+ grep loop
/dev/loop4 on /mnt/loop4 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop5 on /mnt/loop5 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop7 on /mnt/loop7 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop2 on /mnt/loop2 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop9 on /mnt/loop9 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop1 on /mnt/loop1 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop8 on /mnt/loop8 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop3 on /mnt/loop3 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop6 on /mnt/loop6 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop10 on /mnt/loop10 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
+ dmesg -c
[ 1241.220179] XFS (loop8): Unmounting Filesystem
[ 1241.381829] XFS (loop2): Unmounting Filesystem
[ 1241.498565] XFS (loop1): Unmounting Filesystem
[ 1241.613692] XFS (loop7): Unmounting Filesystem
[ 1241.730380] XFS (loop3): Unmounting Filesystem
[ 1248.256956] loop: module loaded
[ 1248.331571] loop4: detected capacity change from 0 to 4194304
[ 1249.434320] __blkdev_issue_discard 82 sector 0 nr_sects 4194304
[ 1249.439367] __blkdev_issue_write_zeroes 242 sector 2097200 nr_sects 20480
[ 1249.531030] XFS (loop4): Mounting V5 Filesystem
[ 1249.548436] XFS (loop4): Ending clean mount
[ 1249.554274] xfs filesystem being mounted at /mnt/loop4 supports timestamps until 2038 (0x7fffffff)
[ 1249.652646] loop5: detected capacity change from 0 to 4194304
[ 1250.750374] __blkdev_issue_discard 82 sector 0 nr_sects 4194304
[ 1250.754859] __blkdev_issue_write_zeroes 242 sector 2097200 nr_sects 20480
[ 1250.845019] XFS (loop5): Mounting V5 Filesystem
[ 1250.860792] XFS (loop5): Ending clean mount
[ 1250.868231] xfs filesystem being mounted at /mnt/loop5 supports timestamps until 2038 (0x7fffffff)
[ 1250.965924] loop7: detected capacity change from 0 to 4194304
[ 1252.063735] __blkdev_issue_discard 82 sector 0 nr_sects 4194304
[ 1252.068024] __blkdev_issue_write_zeroes 242 sector 2097200 nr_sects 20480
[ 1252.161562] XFS (loop7): Mounting V5 Filesystem
[ 1252.178133] XFS (loop7): Ending clean mount
[ 1252.182782] xfs filesystem being mounted at /mnt/loop7 supports timestamps until 2038 (0x7fffffff)
[ 1252.279860] loop2: detected capacity change from 0 to 4194304
[ 1253.379330] __blkdev_issue_discard 82 sector 0 nr_sects 4194304
[ 1253.383928] __blkdev_issue_write_zeroes 242 sector 2097200 nr_sects 20480
[ 1253.471016] XFS (loop2): Mounting V5 Filesystem
[ 1253.486297] XFS (loop2): Ending clean mount
[ 1253.491426] xfs filesystem being mounted at /mnt/loop2 supports timestamps until 2038 (0x7fffffff)
[ 1253.589263] loop9: detected capacity change from 0 to 4194304
[ 1254.683298] __blkdev_issue_discard 82 sector 0 nr_sects 4194304
[ 1254.687374] __blkdev_issue_write_zeroes 242 sector 2097200 nr_sects 20480
[ 1254.776304] XFS (loop9): Mounting V5 Filesystem
[ 1254.793984] XFS (loop9): Ending clean mount
[ 1254.800826] xfs filesystem being mounted at /mnt/loop9 supports timestamps until 2038 (0x7fffffff)
[ 1254.900277] loop1: detected capacity change from 0 to 4194304
[ 1255.997305] __blkdev_issue_discard 82 sector 0 nr_sects 4194304
[ 1256.001931] __blkdev_issue_write_zeroes 242 sector 2097200 nr_sects 20480
[ 1256.089698] XFS (loop1): Mounting V5 Filesystem
[ 1256.110355] XFS (loop1): Ending clean mount
[ 1256.115614] xfs filesystem being mounted at /mnt/loop1 supports timestamps until 2038 (0x7fffffff)
[ 1256.215617] loop8: detected capacity change from 0 to 4194304
[ 1257.315422] __blkdev_issue_discard 82 sector 0 nr_sects 4194304
[ 1257.319657] __blkdev_issue_write_zeroes 242 sector 2097200 nr_sects 20480
[ 1257.407754] XFS (loop8): Mounting V5 Filesystem
[ 1257.422580] XFS (loop8): Ending clean mount
[ 1257.429114] xfs filesystem being mounted at /mnt/loop8 supports timestamps until 2038 (0x7fffffff)
[ 1257.529780] loop3: detected capacity change from 0 to 4194304
[ 1258.634266] __blkdev_issue_discard 82 sector 0 nr_sects 4194304
[ 1258.638672] __blkdev_issue_write_zeroes 242 sector 2097200 nr_sects 20480
[ 1258.728060] XFS (loop3): Mounting V5 Filesystem
[ 1258.744939] XFS (loop3): Ending clean mount
[ 1258.749639] xfs filesystem being mounted at /mnt/loop3 supports timestamps until 2038 (0x7fffffff)
[ 1258.849570] loop6: detected capacity change from 0 to 4194304
[ 1259.956273] __blkdev_issue_discard 82 sector 0 nr_sects 4194304
[ 1259.960716] __blkdev_issue_write_zeroes 242 sector 2097200 nr_sects 20480
[ 1260.050870] XFS (loop6): Mounting V5 Filesystem
[ 1260.067469] XFS (loop6): Ending clean mount
[ 1260.072475] xfs filesystem being mounted at /mnt/loop6 supports timestamps until 2038 (0x7fffffff)
[ 1260.170808] loop10: detected capacity change from 0 to 4194304
[ 1261.274342] __blkdev_issue_discard 82 sector 0 nr_sects 4194304
[ 1261.278068] __blkdev_issue_write_zeroes 242 sector 2097200 nr_sects 20480
[ 1261.369702] XFS (loop10): Mounting V5 Filesystem
[ 1261.385775] XFS (loop10): Ending clean mount
[ 1261.390010] xfs filesystem being mounted at /mnt/loop10 supports timestamps until 2038 (0x7fffffff)
+ df -h /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      2.0G   47M  2.0G   3% /mnt/loop1
/dev/loop10     2.0G   47M  2.0G   3% /mnt/loop10
/dev/loop2      2.0G   47M  2.0G   3% /mnt/loop2
/dev/loop3      2.0G   47M  2.0G   3% /mnt/loop3
/dev/loop4      2.0G   47M  2.0G   3% /mnt/loop4
/dev/loop5      2.0G   47M  2.0G   3% /mnt/loop5
/dev/loop6      2.0G   47M  2.0G   3% /mnt/loop6
/dev/loop7      2.0G   47M  2.0G   3% /mnt/loop7
/dev/loop8      2.0G   47M  2.0G   3% /mnt/loop8
/dev/loop9      2.0G   47M  2.0G   3% /mnt/loop9
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop1/testfile
+ fio fio/verify.fio --filename=/mnt/loop1/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.2%][r=19.8MiB/s][r=5058 IOPS][eta 00m:27s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=7408: Mon Feb 14 22:15:22 2022
  read: IOPS=4719, BW=18.4MiB/s (19.3MB/s)(647MiB/35076msec)
    slat (usec): min=7, max=4436, avg=11.94, stdev=28.78
    clat (usec): min=515, max=198069, avg=3376.08, stdev=2058.70
     lat (usec): min=568, max=198084, avg=3388.12, stdev=2059.98
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2638],
     | 30.00th=[ 2737], 40.00th=[ 2933], 50.00th=[ 3326], 60.00th=[ 3654],
     | 70.00th=[ 3818], 80.00th=[ 3916], 90.00th=[ 4178], 95.00th=[ 4359],
     | 99.00th=[ 6325], 99.50th=[ 6915], 99.90th=[ 8455], 99.95th=[ 9110],
     | 99.99th=[12780]
  write: IOPS=3176, BW=12.4MiB/s (13.0MB/s)(1024MiB/82525msec); 0 zone resets
    slat (usec): min=9, max=84187, avg=29.25, stdev=349.74
    clat (usec): min=436, max=268013, avg=5006.25, stdev=4520.52
     lat (usec): min=616, max=268042, avg=5035.65, stdev=4544.01
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    7], 95.00th=[   11],
     | 99.00th=[   25], 99.50th=[   31], 99.90th=[   48], 99.95th=[   67],
     | 99.99th=[  124]
   bw (  KiB/s): min= 3008, max=19248, per=100.00%, avg=12709.96, stdev=3287.35, samples=165
   iops        : min=  752, max= 4812, avg=3177.50, stdev=821.86, samples=165
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=65.48%, 10=31.26%, 20=2.36%, 50=0.82%
  lat (msec)   : 100=0.04%, 250=0.01%, 500=0.01%
  cpu          : usr=2.05%, sys=9.14%, ctx=422964, majf=0, minf=3899
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165557,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.4MiB/s (19.3MB/s), 18.4MiB/s-18.4MiB/s (19.3MB/s-19.3MB/s), io=647MiB (678MB), run=35076-35076msec
  WRITE: bw=12.4MiB/s (13.0MB/s), 12.4MiB/s-12.4MiB/s (13.0MB/s-13.0MB/s), io=1024MiB (1074MB), run=82525-82525msec

Disk stats (read/write):
  loop1: ios=164509/275092, merge=0/1727, ticks=554589/1384386, in_queue=1947254, util=99.77%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop2/testfile
+ fio fio/verify.fio --filename=/mnt/loop2/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.4%][r=16.4MiB/s][r=4187 IOPS][eta 00m:27s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=7700: Mon Feb 14 22:17:21 2022
  read: IOPS=4600, BW=18.0MiB/s (18.8MB/s)(647MiB/35979msec)
    slat (usec): min=7, max=3925, avg=12.38, stdev=22.80
    clat (usec): min=245, max=125327, avg=3463.42, stdev=1588.96
     lat (usec): min=287, max=125347, avg=3475.91, stdev=1590.52
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2507], 10.00th=[ 2540], 20.00th=[ 2704],
     | 30.00th=[ 2835], 40.00th=[ 3130], 50.00th=[ 3523], 60.00th=[ 3752],
     | 70.00th=[ 3851], 80.00th=[ 3949], 90.00th=[ 4228], 95.00th=[ 4424],
     | 99.00th=[ 6587], 99.50th=[ 7111], 99.90th=[ 8848], 99.95th=[10290],
     | 99.99th=[74974]
  write: IOPS=3168, BW=12.4MiB/s (13.0MB/s)(1024MiB/82741msec); 0 zone resets
    slat (usec): min=9, max=30339, avg=26.76, stdev=128.31
    clat (usec): min=325, max=131766, avg=5021.92, stdev=3882.26
     lat (usec): min=564, max=132078, avg=5048.82, stdev=3887.07
    clat percentiles (usec):
     |  1.00th=[ 2868],  5.00th=[ 2999], 10.00th=[ 3097], 20.00th=[ 3195],
     | 30.00th=[ 3326], 40.00th=[ 3523], 50.00th=[ 3818], 60.00th=[ 4686],
     | 70.00th=[ 5211], 80.00th=[ 5669], 90.00th=[ 6652], 95.00th=[10290],
     | 99.00th=[23987], 99.50th=[29754], 99.90th=[43254], 99.95th=[49546],
     | 99.99th=[82314]
   bw (  KiB/s): min= 4512, max=18968, per=99.68%, avg=12633.56, stdev=2872.42, samples=166
   iops        : min= 1128, max= 4742, avg=3158.38, stdev=718.11, samples=166
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=63.56%, 10=33.19%, 20=2.33%, 50=0.85%
  lat (msec)   : 100=0.03%, 250=0.01%
  cpu          : usr=2.05%, sys=9.25%, ctx=423277, majf=0, minf=3898
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165523,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.0MiB/s (18.8MB/s), 18.0MiB/s-18.0MiB/s (18.8MB/s-18.8MB/s), io=647MiB (678MB), run=35979-35979msec
  WRITE: bw=12.4MiB/s (13.0MB/s), 12.4MiB/s-12.4MiB/s (13.0MB/s-13.0MB/s), io=1024MiB (1074MB), run=82741-82741msec

Disk stats (read/write):
  loop2: ios=165009/275205, merge=0/792, ticks=570345/1373899, in_queue=1951630, util=99.83%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop4/testfile
+ fio fio/verify.fio --filename=/mnt/loop4/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.1%][r=20.9MiB/s][r=5356 IOPS][eta 00m:27s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=7852: Mon Feb 14 22:19:18 2022
  read: IOPS=4806, BW=18.8MiB/s (19.7MB/s)(647MiB/34475msec)
    slat (usec): min=7, max=452, avg=12.38, stdev= 5.62
    clat (usec): min=297, max=178459, avg=3314.45, stdev=1832.28
     lat (usec): min=349, max=178470, avg=3326.93, stdev=1833.07
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2573],
     | 30.00th=[ 2704], 40.00th=[ 2868], 50.00th=[ 3261], 60.00th=[ 3589],
     | 70.00th=[ 3785], 80.00th=[ 3884], 90.00th=[ 4113], 95.00th=[ 4293],
     | 99.00th=[ 6063], 99.50th=[ 6849], 99.90th=[ 8291], 99.95th=[ 8979],
     | 99.99th=[17171]
  write: IOPS=3184, BW=12.4MiB/s (13.0MB/s)(1024MiB/82307msec); 0 zone resets
    slat (usec): min=9, max=42384, avg=27.19, stdev=150.70
    clat (usec): min=409, max=118493, avg=4995.02, stdev=4056.09
     lat (usec): min=467, max=118526, avg=5022.36, stdev=4061.17
    clat percentiles (usec):
     |  1.00th=[ 2835],  5.00th=[ 2966], 10.00th=[ 3064], 20.00th=[ 3163],
     | 30.00th=[ 3261], 40.00th=[ 3425], 50.00th=[ 3818], 60.00th=[ 4621],
     | 70.00th=[ 5211], 80.00th=[ 5669], 90.00th=[ 6587], 95.00th=[10159],
     | 99.00th=[25035], 99.50th=[30540], 99.90th=[46400], 99.95th=[64750],
     | 99.99th=[86508]
   bw (  KiB/s): min= 4560, max=19392, per=99.77%, avg=12710.01, stdev=2951.46, samples=165
   iops        : min= 1140, max= 4848, avg=3177.50, stdev=737.86, samples=165
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.03%, 4=65.52%, 10=31.26%, 20=2.29%, 50=0.84%
  lat (msec)   : 100=0.05%, 250=0.01%
  cpu          : usr=2.23%, sys=9.52%, ctx=422696, majf=0, minf=3901
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165701,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.8MiB/s (19.7MB/s), 18.8MiB/s-18.8MiB/s (19.7MB/s-19.7MB/s), io=647MiB (679MB), run=34475-34475msec
  WRITE: bw=12.4MiB/s (13.0MB/s), 12.4MiB/s-12.4MiB/s (13.0MB/s-13.0MB/s), io=1024MiB (1074MB), run=82307-82307msec

Disk stats (read/write):
  loop4: ios=164887/274862, merge=0/1165, ticks=545520/1364713, in_queue=1918059, util=99.80%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop3/testfile
+ fio fio/verify.fio --filename=/mnt/loop3/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.1%][r=18.4MiB/s][r=4713 IOPS][eta 00m:27s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=7941: Mon Feb 14 22:21:15 2022
  read: IOPS=4730, BW=18.5MiB/s (19.4MB/s)(648MiB/35062msec)
    slat (usec): min=7, max=5336, avg=11.28, stdev=25.22
    clat (usec): min=202, max=107070, avg=3369.29, stdev=1411.41
     lat (usec): min=231, max=107086, avg=3380.66, stdev=1413.05
    clat percentiles (usec):
     |  1.00th=[ 2376],  5.00th=[ 2442], 10.00th=[ 2507], 20.00th=[ 2638],
     | 30.00th=[ 2769], 40.00th=[ 2966], 50.00th=[ 3326], 60.00th=[ 3654],
     | 70.00th=[ 3785], 80.00th=[ 3884], 90.00th=[ 4146], 95.00th=[ 4293],
     | 99.00th=[ 6325], 99.50th=[ 6980], 99.90th=[10028], 99.95th=[11994],
     | 99.99th=[64226]
  write: IOPS=3218, BW=12.6MiB/s (13.2MB/s)(1024MiB/81458msec); 0 zone resets
    slat (usec): min=9, max=54830, avg=25.50, stdev=174.11
    clat (usec): min=355, max=81015, avg=4944.97, stdev=3889.15
     lat (usec): min=430, max=81049, avg=4970.61, stdev=3895.80
    clat percentiles (usec):
     |  1.00th=[ 2868],  5.00th=[ 2999], 10.00th=[ 3097], 20.00th=[ 3195],
     | 30.00th=[ 3261], 40.00th=[ 3425], 50.00th=[ 3687], 60.00th=[ 4490],
     | 70.00th=[ 5080], 80.00th=[ 5604], 90.00th=[ 6521], 95.00th=[10159],
     | 99.00th=[25035], 99.50th=[30802], 99.90th=[43779], 99.95th=[52691],
     | 99.99th=[68682]
   bw (  KiB/s): min= 4072, max=19128, per=100.00%, avg=12873.14, stdev=2986.77, samples=163
   iops        : min= 1018, max= 4782, avg=3218.17, stdev=746.68, samples=163
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=66.71%, 10=30.09%, 20=2.29%, 50=0.83%
  lat (msec)   : 100=0.04%, 250=0.01%
  cpu          : usr=2.02%, sys=8.88%, ctx=424486, majf=0, minf=3905
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165854,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.5MiB/s (19.4MB/s), 18.5MiB/s-18.5MiB/s (19.4MB/s-19.4MB/s), io=648MiB (679MB), run=35062-35062msec
  WRITE: bw=12.6MiB/s (13.2MB/s), 12.6MiB/s-12.6MiB/s (13.2MB/s-13.2MB/s), io=1024MiB (1074MB), run=81458-81458msec

Disk stats (read/write):
  loop3: ios=164700/274567, merge=0/1211, ticks=554381/1352572, in_queue=1914775, util=99.84%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop8/testfile
+ fio fio/verify.fio --filename=/mnt/loop8/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.5%][r=18.6MiB/s][r=4771 IOPS][eta 00m:28s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8004: Mon Feb 14 22:23:19 2022
  read: IOPS=4749, BW=18.6MiB/s (19.5MB/s)(647MiB/34896msec)
    slat (usec): min=7, max=5788, avg=11.65, stdev=32.39
    clat (usec): min=264, max=168300, avg=3355.35, stdev=1792.07
     lat (usec): min=295, max=168311, avg=3367.10, stdev=1793.67
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2606],
     | 30.00th=[ 2737], 40.00th=[ 2933], 50.00th=[ 3326], 60.00th=[ 3654],
     | 70.00th=[ 3785], 80.00th=[ 3884], 90.00th=[ 4146], 95.00th=[ 4293],
     | 99.00th=[ 6325], 99.50th=[ 6849], 99.90th=[ 9503], 99.95th=[10945],
     | 99.99th=[14484]
  write: IOPS=2963, BW=11.6MiB/s (12.1MB/s)(1024MiB/88464msec); 0 zone resets
    slat (usec): min=9, max=32981, avg=29.19, stdev=157.06
    clat (usec): min=441, max=108702, avg=5368.69, stdev=3858.95
     lat (usec): min=640, max=108726, avg=5398.04, stdev=3865.29
    clat percentiles (usec):
     |  1.00th=[ 2966],  5.00th=[ 3130], 10.00th=[ 3228], 20.00th=[ 3359],
     | 30.00th=[ 3621], 40.00th=[ 3916], 50.00th=[ 4359], 60.00th=[ 4948],
     | 70.00th=[ 5538], 80.00th=[ 6259], 90.00th=[ 7767], 95.00th=[10290],
     | 99.00th=[24511], 99.50th=[29492], 99.90th=[42730], 99.95th=[52167],
     | 99.99th=[87557]
   bw (  KiB/s): min= 4488, max=19328, per=99.96%, avg=11848.32, stdev=2947.65, samples=177
   iops        : min= 1122, max= 4832, avg=2962.08, stdev=736.91, samples=177
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=59.16%, 10=37.59%, 20=2.33%, 50=0.84%
  lat (msec)   : 100=0.03%, 250=0.01%
  cpu          : usr=2.17%, sys=9.15%, ctx=423338, majf=0, minf=3902
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165736,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.6MiB/s (19.5MB/s), 18.6MiB/s-18.6MiB/s (19.5MB/s-19.5MB/s), io=647MiB (679MB), run=34896-34896msec
  WRITE: bw=11.6MiB/s (12.1MB/s), 11.6MiB/s-11.6MiB/s (12.1MB/s-12.1MB/s), io=1024MiB (1074MB), run=88464-88464msec

Disk stats (read/write):
  loop8: ios=164585/275039, merge=0/998, ticks=551377/1460715, in_queue=2019766, util=99.85%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop7/testfile
+ fio fio/verify.fio --filename=/mnt/loop7/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.7%][r=19.4MiB/s][r=4957 IOPS][eta 00m:26s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8069: Mon Feb 14 22:25:15 2022
  read: IOPS=4741, BW=18.5MiB/s (19.4MB/s)(646MiB/34895msec)
    slat (usec): min=7, max=5653, avg=11.49, stdev=25.14
    clat (usec): min=262, max=112471, avg=3361.01, stdev=1505.71
     lat (usec): min=314, max=112488, avg=3372.59, stdev=1507.24
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2507], 10.00th=[ 2540], 20.00th=[ 2638],
     | 30.00th=[ 2769], 40.00th=[ 2966], 50.00th=[ 3326], 60.00th=[ 3621],
     | 70.00th=[ 3785], 80.00th=[ 3884], 90.00th=[ 4146], 95.00th=[ 4293],
     | 99.00th=[ 6259], 99.50th=[ 6783], 99.90th=[ 9110], 99.95th=[11469],
     | 99.99th=[73925]
  write: IOPS=3234, BW=12.6MiB/s (13.2MB/s)(1024MiB/81041msec); 0 zone resets
    slat (usec): min=9, max=92800, avg=26.58, stdev=238.92
    clat (usec): min=465, max=174470, avg=4918.39, stdev=4191.56
     lat (usec): min=490, max=174492, avg=4945.12, stdev=4199.86
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    7], 95.00th=[   11],
     | 99.00th=[   24], 99.50th=[   30], 99.90th=[   43], 99.95th=[   66],
     | 99.99th=[  131]
   bw (  KiB/s): min= 2208, max=19560, per=100.00%, avg=12947.73, stdev=3018.88, samples=162
   iops        : min=  552, max= 4890, avg=3236.91, stdev=754.70, samples=162
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.04%, 4=66.35%, 10=30.40%, 20=2.36%, 50=0.78%
  lat (msec)   : 100=0.03%, 250=0.02%
  cpu          : usr=1.98%, sys=9.14%, ctx=423059, majf=0, minf=3895
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165460,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.5MiB/s (19.4MB/s), 18.5MiB/s-18.5MiB/s (19.4MB/s-19.4MB/s), io=646MiB (678MB), run=34895-34895msec
  WRITE: bw=12.6MiB/s (13.2MB/s), 12.6MiB/s-12.6MiB/s (13.2MB/s-13.2MB/s), io=1024MiB (1074MB), run=81041-81041msec

Disk stats (read/write):
  loop7: ios=164861/274762, merge=0/1097, ticks=553467/1339136, in_queue=1900082, util=99.85%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop6/testfile
+ fio fio/verify.fio --filename=/mnt/loop6/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.6%][r=20.4MiB/s][r=5224 IOPS][eta 00m:26s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8138: Mon Feb 14 22:27:10 2022
  read: IOPS=4756, BW=18.6MiB/s (19.5MB/s)(647MiB/34821msec)
    slat (usec): min=7, max=4753, avg=11.17, stdev=30.09
    clat (usec): min=660, max=176614, avg=3350.69, stdev=1853.67
     lat (usec): min=710, max=176622, avg=3361.95, stdev=1855.21
    clat percentiles (usec):
     |  1.00th=[ 2376],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2638],
     | 30.00th=[ 2737], 40.00th=[ 2966], 50.00th=[ 3326], 60.00th=[ 3621],
     | 70.00th=[ 3785], 80.00th=[ 3884], 90.00th=[ 4113], 95.00th=[ 4228],
     | 99.00th=[ 6063], 99.50th=[ 6718], 99.90th=[10421], 99.95th=[12780],
     | 99.99th=[16581]
  write: IOPS=3273, BW=12.8MiB/s (13.4MB/s)(1024MiB/80088msec); 0 zone resets
    slat (usec): min=9, max=93505, avg=26.54, stdev=253.80
    clat (usec): min=465, max=144963, avg=4860.35, stdev=3706.66
     lat (usec): min=577, max=145285, avg=4887.03, stdev=3723.14
    clat percentiles (usec):
     |  1.00th=[ 2769],  5.00th=[ 2900], 10.00th=[ 2999], 20.00th=[ 3097],
     | 30.00th=[ 3228], 40.00th=[ 3392], 50.00th=[ 3851], 60.00th=[ 4621],
     | 70.00th=[ 5080], 80.00th=[ 5473], 90.00th=[ 6259], 95.00th=[10159],
     | 99.00th=[22152], 99.50th=[28443], 99.90th=[38536], 99.95th=[49546],
     | 99.99th=[70779]
   bw (  KiB/s): min= 3432, max=19704, per=100.00%, avg=13107.20, stdev=3183.74, samples=160
   iops        : min=  858, max= 4926, avg=3276.80, stdev=795.93, samples=160
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.05%, 4=65.21%, 10=31.53%, 20=2.40%, 50=0.77%
  lat (msec)   : 100=0.03%, 250=0.01%
  cpu          : usr=2.04%, sys=8.84%, ctx=422363, majf=0, minf=3900
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165635,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.6MiB/s (19.5MB/s), 18.6MiB/s-18.6MiB/s (19.5MB/s-19.5MB/s), io=647MiB (678MB), run=34821-34821msec
  WRITE: bw=12.8MiB/s (13.4MB/s), 12.8MiB/s-12.8MiB/s (13.4MB/s-13.4MB/s), io=1024MiB (1074MB), run=80088-80088msec

Disk stats (read/write):
  loop6: ios=165432/274759, merge=0/1560, ticks=553349/1326413, in_queue=1887360, util=99.85%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop10/testfile
+ fio fio/verify.fio --filename=/mnt/loop10/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=0): [f(1)][100.0%][r=15.2MiB/s][r=3898 IOPS][eta 00m:00s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8226: Mon Feb 14 22:29:08 2022
  read: IOPS=4648, BW=18.2MiB/s (19.0MB/s)(647MiB/35634msec)
    slat (usec): min=7, max=3527, avg=12.14, stdev=26.31
    clat (usec): min=197, max=42316, avg=3428.06, stdev=870.56
     lat (usec): min=227, max=42335, avg=3440.30, stdev=873.41
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2507], 10.00th=[ 2540], 20.00th=[ 2671],
     | 30.00th=[ 2802], 40.00th=[ 3064], 50.00th=[ 3425], 60.00th=[ 3720],
     | 70.00th=[ 3851], 80.00th=[ 3949], 90.00th=[ 4228], 95.00th=[ 4424],
     | 99.00th=[ 6456], 99.50th=[ 7046], 99.90th=[ 8586], 99.95th=[ 9896],
     | 99.99th=[17433]
  write: IOPS=3230, BW=12.6MiB/s (13.2MB/s)(1024MiB/81141msec); 0 zone resets
    slat (usec): min=9, max=162004, avg=28.38, stdev=482.65
    clat (usec): min=435, max=278095, avg=4922.76, stdev=5104.52
     lat (usec): min=520, max=278126, avg=4951.28, stdev=5152.39
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    3], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    7], 95.00th=[   10],
     | 99.00th=[   25], 99.50th=[   32], 99.90th=[   61], 99.95th=[   80],
     | 99.99th=[  194]
   bw (  KiB/s): min= 1880, max=20304, per=99.61%, avg=12873.77, stdev=3180.18, samples=163
   iops        : min=  470, max= 5076, avg=3218.34, stdev=795.03, samples=163
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.05%, 4=64.31%, 10=32.82%, 20=1.96%, 50=0.76%
  lat (msec)   : 100=0.07%, 250=0.02%, 500=0.01%
  cpu          : usr=2.02%, sys=8.97%, ctx=423387, majf=0, minf=3902
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165635,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.2MiB/s (19.0MB/s), 18.2MiB/s-18.2MiB/s (19.0MB/s-19.0MB/s), io=647MiB (678MB), run=35634-35634msec
  WRITE: bw=12.6MiB/s (13.2MB/s), 12.6MiB/s-12.6MiB/s (13.2MB/s-13.2MB/s), io=1024MiB (1074MB), run=81141-81141msec

Disk stats (read/write):
  loop10: ios=164704/274985, merge=0/1497, ticks=563065/1356524, in_queue=1927980, util=99.83%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop5/testfile
+ fio fio/verify.fio --filename=/mnt/loop5/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][82.0%][r=16.7MiB/s][r=4281 IOPS][eta 00m:27s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8337: Mon Feb 14 22:31:11 2022
  read: IOPS=4546, BW=17.8MiB/s (18.6MB/s)(647MiB/36422msec)
    slat (usec): min=7, max=1962, avg=12.78, stdev=11.72
    clat (usec): min=315, max=191618, avg=3504.53, stdev=2050.26
     lat (usec): min=346, max=191634, avg=3517.41, stdev=2051.11
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2540], 10.00th=[ 2573], 20.00th=[ 2737],
     | 30.00th=[ 2900], 40.00th=[ 3195], 50.00th=[ 3556], 60.00th=[ 3752],
     | 70.00th=[ 3884], 80.00th=[ 3982], 90.00th=[ 4293], 95.00th=[ 4424],
     | 99.00th=[ 6587], 99.50th=[ 7111], 99.90th=[10290], 99.95th=[13304],
     | 99.99th=[35390]
  write: IOPS=3034, BW=11.9MiB/s (12.4MB/s)(1024MiB/86397msec); 0 zone resets
    slat (usec): min=9, max=80013, avg=27.65, stdev=208.54
    clat (usec): min=332, max=98007, avg=5244.13, stdev=4379.37
     lat (usec): min=528, max=98034, avg=5271.94, stdev=4386.11
    clat percentiles (usec):
     |  1.00th=[ 2966],  5.00th=[ 3097], 10.00th=[ 3195], 20.00th=[ 3294],
     | 30.00th=[ 3392], 40.00th=[ 3589], 50.00th=[ 3884], 60.00th=[ 4555],
     | 70.00th=[ 5342], 80.00th=[ 5932], 90.00th=[ 7701], 95.00th=[10945],
     | 99.00th=[26346], 99.50th=[32637], 99.90th=[53216], 99.95th=[63701],
     | 99.99th=[86508]
   bw (  KiB/s): min= 4280, max=18960, per=99.92%, avg=12127.60, stdev=3143.79, samples=173
   iops        : min= 1070, max= 4740, avg=3031.83, stdev=785.95, samples=173
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.03%, 4=63.30%, 10=33.04%, 20=2.67%, 50=0.88%
  lat (msec)   : 100=0.08%, 250=0.01%
  cpu          : usr=2.01%, sys=9.26%, ctx=422718, majf=0, minf=3898
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165588,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=17.8MiB/s (18.6MB/s), 17.8MiB/s-17.8MiB/s (18.6MB/s-18.6MB/s), io=647MiB (678MB), run=36422-36422msec
  WRITE: bw=11.9MiB/s (12.4MB/s), 11.9MiB/s-11.9MiB/s (12.4MB/s-12.4MB/s), io=1024MiB (1074MB), run=86397-86397msec

Disk stats (read/write):
  loop5: ios=165482/274893, merge=0/888, ticks=579133/1437227, in_queue=2024581, util=99.75%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop9/testfile
+ fio fio/verify.fio --filename=/mnt/loop9/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.1%][r=18.9MiB/s][r=4830 IOPS][eta 00m:27s]]                 
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8513: Mon Feb 14 22:33:08 2022
  read: IOPS=4665, BW=18.2MiB/s (19.1MB/s)(647MiB/35492msec)
    slat (usec): min=7, max=3920, avg=12.76, stdev=20.93
    clat (usec): min=205, max=58280, avg=3414.45, stdev=977.48
     lat (usec): min=235, max=58298, avg=3427.32, stdev=980.02
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2507], 10.00th=[ 2540], 20.00th=[ 2671],
     | 30.00th=[ 2802], 40.00th=[ 2999], 50.00th=[ 3392], 60.00th=[ 3720],
     | 70.00th=[ 3851], 80.00th=[ 3949], 90.00th=[ 4228], 95.00th=[ 4424],
     | 99.00th=[ 6194], 99.50th=[ 6915], 99.90th=[ 8586], 99.95th=[10290],
     | 99.99th=[32637]
  write: IOPS=3236, BW=12.6MiB/s (13.3MB/s)(1024MiB/80995msec); 0 zone resets
    slat (usec): min=9, max=28361, avg=25.61, stdev=119.40
    clat (usec): min=299, max=268878, avg=4916.61, stdev=4152.62
     lat (usec): min=654, max=268907, avg=4942.36, stdev=4157.14
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    7], 95.00th=[   11],
     | 99.00th=[   24], 99.50th=[   29], 99.90th=[   39], 99.95th=[   47],
     | 99.99th=[  157]
   bw (  KiB/s): min= 2904, max=19120, per=100.00%, avg=12947.98, stdev=3093.01, samples=162
   iops        : min=  726, max= 4780, avg=3236.96, stdev=773.22, samples=162
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=64.96%, 10=31.86%, 20=2.34%, 50=0.80%
  lat (msec)   : 100=0.01%, 250=0.01%, 500=0.01%
  cpu          : usr=2.01%, sys=9.38%, ctx=423986, majf=0, minf=3899
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165598,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.2MiB/s (19.1MB/s), 18.2MiB/s-18.2MiB/s (19.1MB/s-19.1MB/s), io=647MiB (678MB), run=35492-35492msec
  WRITE: bw=12.6MiB/s (13.3MB/s), 12.6MiB/s-12.6MiB/s (13.3MB/s-13.3MB/s), io=1024MiB (1074MB), run=80995-80995msec

Disk stats (read/write):
  loop9: ios=164728/275088, merge=0/522, ticks=561877/1343351, in_queue=1912902, util=99.83%
+ df -h /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      2.0G  1.1G  965M  53% /mnt/loop1
/dev/loop10     2.0G  1.1G  966M  53% /mnt/loop10
/dev/loop2      2.0G  1.1G  966M  53% /mnt/loop2
/dev/loop3      2.0G  1.1G  965M  53% /mnt/loop3
/dev/loop4      2.0G  1.1G  965M  53% /mnt/loop4
/dev/loop5      2.0G  1.1G  965M  53% /mnt/loop5
/dev/loop6      2.0G  1.1G  965M  53% /mnt/loop6
/dev/loop7      2.0G  1.1G  965M  53% /mnt/loop7
/dev/loop8      2.0G  1.1G  965M  53% /mnt/loop8
/dev/loop9      2.0G  1.1G  965M  53% /mnt/loop9
+ unload_loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop2
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop6
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop3
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop5
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop4
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop7
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop1
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop9
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop10
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop8
+ rm -fr ./loop8
+ losetup -D
+ sleep 3
+ rmmod loop
+ modprobe -r loop
+ lsmod
+ grep loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop4
+ rm -fr /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
+ dmesg -c
[ 2444.772430] XFS (loop2): Unmounting Filesystem
[ 2444.920447] XFS (loop6): Unmounting Filesystem
[ 2445.057306] XFS (loop3): Unmounting Filesystem
[ 2445.197380] XFS (loop5): Unmounting Filesystem
[ 2445.357324] XFS (loop4): Unmounting Filesystem
[ 2445.483461] XFS (loop7): Unmounting Filesystem
[ 2445.623297] XFS (loop1): Unmounting Filesystem
[ 2445.765312] XFS (loop9): Unmounting Filesystem
[ 2446.024364] XFS (loop10): Unmounting Filesystem
[ 2446.194357] XFS (loop8): Unmounting Filesystem
-- 
2.29.0

