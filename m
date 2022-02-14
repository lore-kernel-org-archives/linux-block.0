Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB15C4321E
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348425AbiBNKfU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:35:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348337AbiBNKes (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:34:48 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CCB10F7
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:01:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fM9QHnxXclVk5+k9CzC+/QKlEQFP6A2FeGkOiNgIo5DIXXJHjB9Tvwh5mQeydM+P1mw0HCRufQp/QMjtMg8pY3wMedTjeNpbEoH75rFRFz2Rq8fYKrLEqBqEmmJZGlJQyyO6XB/qRNtPoZBZrFoitqQnYJvzU3rWIeWOxaIrQkU7Y8+VoYJ5IEXtKlsVOlxGx8Oc+sjh83W6t7w2Yv+op0WIuxc2L7FB31I2tQ0MSNcY3Nvwpshl/Yp8pfKl1iME9hFl7GKz3j257TBhncwhr1mEIEYVnSD36vdVk1onqqPyJntd83/oyYqMDFZx1W7jsdDiOH+mH2pQaUfvjYXarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGomZ4wmMcltzPNuWqvAbik+rh3DfuJ7YguhiTb60Oo=;
 b=F/217WnEo5T1w39luK/wX0KGcF/9ebgrrFrvlC22GZ6dAbQBbTpksFU4XDOGWxPtRzDhF2yQq6CebypYSebdntfYeEWIdmQZNOWGUxFU3b7cuXkCnApDemi0mV+Jlm7NeixMEKWWkqrEw/iuZsbRCIpGMmbvSFx7oD7hcUyvAJqmb2XF+OFnCVXxAIS1oUlSImsAnuMPDSCaGC1MNMhFamPh5ydmIeQZcENDenWeVfdm+sxAmXuzDFjacdlPfLFNTWUWZ6nv2HVVF7uIVvRF13vbRPZXVNdSy+Ejyu3Swzfn92sn5dsXLSqc3X98iGE+vrICqXa2eXAzqzPkOctuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGomZ4wmMcltzPNuWqvAbik+rh3DfuJ7YguhiTb60Oo=;
 b=ErH/bA/PZNEUqduA1ThmcWaDvy/wLFFo8Hn5FIHeErHQX/x+C2GzX7cstTvqrcHT43NKOeQb27SLywvD8B0cdPAugFm7IzYOVI2hMqWpU4mxEYuerCbGhFXbJ37jZOCWFiJvVAWNEWQJNhITcnvXF2wTJFSm5OLAR5nLtlrSDx3eLiRn7s6MtAR/BIqJ0dYXisGVsGBN4YSq9q/yQpVq/Jvkf0ZPFeqTMMC9LYa1U/hMZD3vrHVN2nPIYS76THa3IIid0rvQ+lIqdAwU8bzUb/v5BFmA3RthGmNrYcBpiAMt5DG6w5sqwz1druW/Y/9f3CFBdA52s2GxDKK445BC+Q==
Received: from DM3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:0:50::24) by
 PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 10:01:33 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::90) by DM3PR03CA0014.outlook.office365.com
 (2603:10b6:0:50::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:01:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:01:32 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:01:31 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/8] loop: cleanup and few improvements
Date:   Mon, 14 Feb 2022 02:01:11 -0800
Message-ID: <20220214100119.6795-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3697e5b-f13c-49fb-2090-08d9efa0faef
X-MS-TrafficTypeDiagnostic: PH7PR12MB5688:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5688AFD7195DEBFAE6828BCBA3339@PH7PR12MB5688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzNeCUAGY5E2ZMaB3v436/wWwMJqjdIq//KikzWPN4UQFr5Y8CgSzUjm/dXGE3HenoCZUmAc1vsnYZXmfNSi1AuaLPOrdF2JNVordsPx1UuM9z+YbL+s+FeV2lWSWZ9ecQWPNLbYKyguygY6Bbj9e781awgm9IhVSTxFuMr+ekzuYPDK1Gi1dA5fVML+SwReYQh7gY7VzmKxT20VUU7vq2YqVy9ISaUoWZgcNA0jEFI7n3Oz7jKurD9rQRM03mEi63ZC4fk1rtqfkHuNUyLyA0eCefjw+4Zs+mGUlBQu4xdojeqTB+8XApWy7ayAPNzAGxEBoFx0DU6+NSNZ7ZaMCGQP4k1rmB5K3YJrpfVUPh6xwn+Z5Nrd6Euy2itfBSu+kdndJvTmIBxU2KWCsJ3ouORkuqSVMQL8ec7WLm766AMPDKgR8nMfohqmUxxUy7sLMkd6YIXL/v8goElnOPHCWfo+1vpdTrP46qmn/BjfZY1xwUYjEU5mr/87hVSr8Kwx2AWBGKMzt1EkYYquMWo31x+YsP+HSJPWr+ZQ4/9A2T2F1t54t2jte1mPIo4AjZ/yfNGGEOqBBLo/50IXyupR9XXP6DK5RrR7y/InomccUJN842Daflrx7Ny3gzFfGF2oy6DtXXbkvNnSjI/G8LKDVGsH+eOy1p7dsnbubUmTp+cXeeDgaWBoVT9JIp5bp5pKgfdJVdazcgXCg2578zk2Vw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(81166007)(82310400004)(70586007)(508600001)(6666004)(70206006)(7696005)(47076005)(5660300002)(40460700003)(36860700001)(426003)(186003)(6916009)(83380400001)(36756003)(336012)(107886003)(4326008)(26005)(2616005)(2906002)(30864003)(16526019)(1076003)(8676002)(8936002)(54906003)(19627235002)(316002)(36900700001)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:01:33.1854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3697e5b-f13c-49fb-2090-08d9efa0faef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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

Chaitanya Kulkarni (8):
  loop: use sysfs_emit() in the sysfs offset show
  loop: use sysfs_emit() in the sysfs sizelimit show
  loop: use sysfs_emit() in the sysfs autoclear show
  loop: use sysfs_emit() in the sysfs partscan show
  loop: use sysfs_emit() in the sysfs dio show
  loop: remove extra variable in lo_fallocate()
  loop: remove extra variable in lo_req_flush
  loop: allow user to set the queue depth

 drivers/block/loop.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

# git am --skip 
Applying: loop: use sysfs_emit() in the sysfs offset show
Applying: loop: use sysfs_emit() in the sysfs sizelimit show
Applying: loop: use sysfs_emit() in the sysfs autoclear show
Applying: loop: use sysfs_emit() in the sysfs partscan show
Applying: loop: use sysfs_emit() in the sysfs dio show
Applying: loop: remove extra variable in lo_fallocate()
Applying: loop: remove extra variable in lo_req_flush
Applying: loop: allow user to set the queue depth
root@dev linux-block (for-next) # ./compile_loop.sh 10
+ FILE=./loop
+ LOOP_MNT=/mnt/loop
+ NN=10
+ unload_loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop5
umount: /mnt/loop5: no mount point specified.
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop8
umount: /mnt/loop8: no mount point specified.
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop1
umount: /mnt/loop1: no mount point specified.
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop4
umount: /mnt/loop4: no mount point specified.
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop2
umount: /mnt/loop2: no mount point specified.
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop3
umount: /mnt/loop3: no mount point specified.
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop9
umount: /mnt/loop9: no mount point specified.
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop10
umount: /mnt/loop10: no mount point specified.
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop6
umount: /mnt/loop6: no mount point specified.
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop7
umount: /mnt/loop7: no mount point specified.
+ rm -fr ./loop7
+ losetup -D
+ sleep 3
+ rmmod loop
rmmod: ERROR: Module loop is not currently loaded
+ modprobe -r loop
+ lsmod
+ grep loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop1
+ rm -fr '/mnt/loop*'
+ compile_loop
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/loop.o
  MODPOST drivers/block/Module.symvers
  CC [M]  drivers/block/brd.mod.o
  CC [M]  drivers/block/loop.mod.o
  CC [M]  drivers/block/null_blk/null_blk.mod.o
  CC [M]  drivers/block/pktcdvd.mod.o
  CC [M]  drivers/block/rbd.mod.o
  CC [M]  drivers/block/sx8.mod.o
  CC [M]  drivers/block/virtio_blk.mod.o
  CC [M]  drivers/block/xen-blkfront.mod.o
  CC [M]  drivers/block/zram/zram.mod.o
  LD [M]  drivers/block/rbd.ko
  LD [M]  drivers/block/xen-blkfront.ko
  LD [M]  drivers/block/brd.ko
  LD [M]  drivers/block/null_blk/null_blk.ko
  LD [M]  drivers/block/zram/zram.ko
  LD [M]  drivers/block/loop.ko
  LD [M]  drivers/block/pktcdvd.ko
  LD [M]  drivers/block/sx8.ko
  LD [M]  drivers/block/virtio_blk.ko
+ HOST=drivers/block/
++ uname -r
+ HOST_DEST=/lib/modules/5.17.0-rc3blk+/kernel/drivers/block
+ cp drivers/block//loop.ko /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/
+ load_loop
+ insmod drivers/block/loop.ko max_loop=11 hw_queue_depth=32
++ shuf -i 1-10 -n 10
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop1
+ truncate -s 2048M ./loop1
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop1 ./loop1
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
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
+ mkdir -p /mnt/loop4
+ truncate -s 2048M ./loop4
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop4 ./loop4
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
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
+ mkdir -p /mnt/loop9
+ truncate -s 2048M ./loop9
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop9 ./loop9
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop9         0      0         0  0 /mnt/data/linux-block/loop9   1     512
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
+ mkdir -p /mnt/loop10
+ truncate -s 2048M ./loop10
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop10 ./loop10
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop4          0      0         0  0 /mnt/data/linux-block/loop4    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
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
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop7
+ truncate -s 2048M ./loop7
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop7 ./loop7
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop4          0      0         0  0 /mnt/data/linux-block/loop4    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
/dev/loop7          0      0         0  0 /mnt/data/linux-block/loop7    1     512
/dev/loop10         0      0         0  0 /mnt/data/linux-block/loop10   1     512
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
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop4          0      0         0  0 /mnt/data/linux-block/loop4    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
/dev/loop7          0      0         0  0 /mnt/data/linux-block/loop7    1     512
/dev/loop10         0      0         0  0 /mnt/data/linux-block/loop10   1     512
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
+ mkdir -p /mnt/loop3
+ truncate -s 2048M ./loop3
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop3 ./loop3
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop4          0      0         0  0 /mnt/data/linux-block/loop4    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
/dev/loop7          0      0         0  0 /mnt/data/linux-block/loop7    1     512
/dev/loop3          0      0         0  0 /mnt/data/linux-block/loop3    1     512
/dev/loop10         0      0         0  0 /mnt/data/linux-block/loop10   1     512
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
+ mkdir -p /mnt/loop5
+ truncate -s 2048M ./loop5
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop5 ./loop5
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop4          0      0         0  0 /mnt/data/linux-block/loop4    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
/dev/loop7          0      0         0  0 /mnt/data/linux-block/loop7    1     512
/dev/loop5          0      0         0  0 /mnt/data/linux-block/loop5    1     512
/dev/loop3          0      0         0  0 /mnt/data/linux-block/loop3    1     512
/dev/loop10         0      0         0  0 /mnt/data/linux-block/loop10   1     512
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
+ mkdir -p /mnt/loop8
+ truncate -s 2048M ./loop8
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop8 ./loop8
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop8          0      0         0  0 /mnt/data/linux-block/loop8    1     512
/dev/loop4          0      0         0  0 /mnt/data/linux-block/loop4    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
/dev/loop7          0      0         0  0 /mnt/data/linux-block/loop7    1     512
/dev/loop5          0      0         0  0 /mnt/data/linux-block/loop5    1     512
/dev/loop3          0      0         0  0 /mnt/data/linux-block/loop3    1     512
/dev/loop10         0      0         0  0 /mnt/data/linux-block/loop10   1     512
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
+ mkdir -p /mnt/loop6
+ truncate -s 2048M ./loop6
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop6 ./loop6
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
+ mount
+ grep loop
/dev/loop1 on /mnt/loop1 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop4 on /mnt/loop4 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop9 on /mnt/loop9 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop10 on /mnt/loop10 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop7 on /mnt/loop7 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop2 on /mnt/loop2 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop3 on /mnt/loop3 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop5 on /mnt/loop5 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop8 on /mnt/loop8 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop6 on /mnt/loop6 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
+ dmesg -c
[    0.000000] Linux version 5.17.0-rc3blk+ (root@dev) (gcc (GCC) 11.0.1 20210324 (Red Hat 11.0.1-0), GNU ld version 2.35.1-41.fc34) #52 SMP PREEMPT Mon Feb 14 00:35:51 PST 2022
[    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.17.0-rc3blk+ root=UUID=e5f9bccb-cc5d-4577-8f74-fddb710fae7f ro rootflags=subvol=root rhgb quiet console=ttyS0,115200 kgdboc=ttyS0,115200 nokaslr
[   88.725708] loop: loading out-of-tree module taints kernel.
[   88.795243] loop: module loaded
[   88.886469] loop1: detected capacity change from 0 to 4194304
[   90.099519] XFS (loop1): Mounting V5 Filesystem
[   90.137943] XFS (loop1): Ending clean mount
[   90.142241] xfs filesystem being mounted at /mnt/loop1 supports timestamps until 2038 (0x7fffffff)
[   90.248857] loop4: detected capacity change from 0 to 4194304
[   91.445059] XFS (loop4): Mounting V5 Filesystem
[   91.461389] XFS (loop4): Ending clean mount
[   91.466664] xfs filesystem being mounted at /mnt/loop4 supports timestamps until 2038 (0x7fffffff)
[   91.567786] loop9: detected capacity change from 0 to 4194304
[   92.762834] XFS (loop9): Mounting V5 Filesystem
[   92.780240] XFS (loop9): Ending clean mount
[   92.784748] xfs filesystem being mounted at /mnt/loop9 supports timestamps until 2038 (0x7fffffff)
[   92.883355] loop10: detected capacity change from 0 to 4194304
[   94.077276] XFS (loop10): Mounting V5 Filesystem
[   94.095212] XFS (loop10): Ending clean mount
[   94.101121] xfs filesystem being mounted at /mnt/loop10 supports timestamps until 2038 (0x7fffffff)
[   94.200828] loop7: detected capacity change from 0 to 4194304
[   95.387052] XFS (loop7): Mounting V5 Filesystem
[   95.402344] XFS (loop7): Ending clean mount
[   95.408219] xfs filesystem being mounted at /mnt/loop7 supports timestamps until 2038 (0x7fffffff)
[   95.505530] loop2: detected capacity change from 0 to 4194304
[   96.696228] XFS (loop2): Mounting V5 Filesystem
[   96.712500] XFS (loop2): Ending clean mount
[   96.717802] xfs filesystem being mounted at /mnt/loop2 supports timestamps until 2038 (0x7fffffff)
[   96.815870] loop3: detected capacity change from 0 to 4194304
[   98.006189] XFS (loop3): Mounting V5 Filesystem
[   98.022896] XFS (loop3): Ending clean mount
[   98.028990] xfs filesystem being mounted at /mnt/loop3 supports timestamps until 2038 (0x7fffffff)
[   98.128314] loop5: detected capacity change from 0 to 4194304
[   99.317471] XFS (loop5): Mounting V5 Filesystem
[   99.334259] XFS (loop5): Ending clean mount
[   99.340014] xfs filesystem being mounted at /mnt/loop5 supports timestamps until 2038 (0x7fffffff)
[   99.437944] loop8: detected capacity change from 0 to 4194304
[  100.640549] XFS (loop8): Mounting V5 Filesystem
[  100.658762] XFS (loop8): Ending clean mount
[  100.663623] xfs filesystem being mounted at /mnt/loop8 supports timestamps until 2038 (0x7fffffff)
[  100.768163] loop6: detected capacity change from 0 to 4194304
[  101.964471] XFS (loop6): Mounting V5 Filesystem
[  101.985869] XFS (loop6): Ending clean mount
[  101.991076] xfs filesystem being mounted at /mnt/loop6 supports timestamps until 2038 (0x7fffffff)
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
+ fallocate -o 0 -l 524288000 /mnt/loop5/testfile
+ fio fio/verify.fio --filename=/mnt/loop5/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.7%][r=18.4MiB/s][r=4722 IOPS][eta 00m:30s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3495: Mon Feb 14 00:43:19 2022
  read: IOPS=4612, BW=18.0MiB/s (18.9MB/s)(647MiB/35913msec)
    slat (usec): min=7, max=2920, avg=13.50, stdev=23.99
    clat (usec): min=269, max=86467, avg=3453.04, stdev=1221.75
     lat (usec): min=321, max=86484, avg=3466.65, stdev=1224.18
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2474], 10.00th=[ 2540], 20.00th=[ 2671],
     | 30.00th=[ 2802], 40.00th=[ 3097], 50.00th=[ 3490], 60.00th=[ 3752],
     | 70.00th=[ 3851], 80.00th=[ 3982], 90.00th=[ 4228], 95.00th=[ 4424],
     | 99.00th=[ 6587], 99.50th=[ 7242], 99.90th=[ 9765], 99.95th=[11469],
     | 99.99th=[46924]
  write: IOPS=2671, BW=10.4MiB/s (10.9MB/s)(1024MiB/98116msec); 0 zone resets
    slat (usec): min=9, max=136085, avg=32.59, stdev=613.45
    clat (usec): min=255, max=344426, avg=5954.50, stdev=13130.50
     lat (usec): min=490, max=344452, avg=5987.24, stdev=13189.93
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    7], 95.00th=[   11],
     | 99.00th=[   36], 99.50th=[   93], 99.90th=[  228], 99.95th=[  251],
     | 99.99th=[  292]
   bw (  KiB/s): min=  240, max=19040, per=99.67%, avg=10652.53, stdev=4662.38, samples=197
   iops        : min=   60, max= 4760, avg=2663.01, stdev=1165.58, samples=197
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=63.60%, 10=33.10%, 20=1.91%, 50=0.87%
  lat (msec)   : 100=0.20%, 250=0.25%, 500=0.03%
  cpu          : usr=1.89%, sys=8.56%, ctx=422844, majf=0, minf=3901
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165662,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.0MiB/s (18.9MB/s), 18.0MiB/s-18.0MiB/s (18.9MB/s-18.9MB/s), io=647MiB (679MB), run=35913-35913msec
  WRITE: bw=10.4MiB/s (10.9MB/s), 10.4MiB/s-10.4MiB/s (10.9MB/s-10.9MB/s), io=1024MiB (1074MB), run=98116-98116msec

Disk stats (read/write):
  loop5: ios=165665/274948, merge=0/1146, ticks=570916/1710663, in_queue=2291246, util=99.71%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop3/testfile
+ fio fio/verify.fio --filename=/mnt/loop3/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.4%][r=19.4MiB/s][r=4959 IOPS][eta 00m:27s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3960: Mon Feb 14 00:45:17 2022
  read: IOPS=4591, BW=17.9MiB/s (18.8MB/s)(647MiB/36059msec)
    slat (usec): min=7, max=3764, avg=12.77, stdev=37.77
    clat (usec): min=328, max=195361, avg=3469.75, stdev=2029.21
     lat (usec): min=380, max=195375, avg=3482.63, stdev=2031.19
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2507], 10.00th=[ 2573], 20.00th=[ 2737],
     | 30.00th=[ 2900], 40.00th=[ 3097], 50.00th=[ 3458], 60.00th=[ 3720],
     | 70.00th=[ 3851], 80.00th=[ 3949], 90.00th=[ 4228], 95.00th=[ 4424],
     | 99.00th=[ 6521], 99.50th=[ 7111], 99.90th=[ 9372], 99.95th=[ 9765],
     | 99.99th=[17433]
  write: IOPS=3197, BW=12.5MiB/s (13.1MB/s)(1024MiB/81996msec); 0 zone resets
    slat (usec): min=9, max=36590, avg=26.96, stdev=175.62
    clat (usec): min=383, max=140174, avg=4976.36, stdev=4045.11
     lat (usec): min=477, max=140202, avg=5003.46, stdev=4051.17
    clat percentiles (usec):
     |  1.00th=[ 2868],  5.00th=[ 2999], 10.00th=[ 3097], 20.00th=[ 3228],
     | 30.00th=[ 3326], 40.00th=[ 3556], 50.00th=[ 3949], 60.00th=[ 4686],
     | 70.00th=[ 5211], 80.00th=[ 5604], 90.00th=[ 6325], 95.00th=[ 9241],
     | 99.00th=[24511], 99.50th=[31065], 99.90th=[47449], 99.95th=[65799],
     | 99.99th=[96994]
   bw (  KiB/s): min= 4832, max=18504, per=100.00%, avg=12793.93, stdev=2620.03, samples=164
   iops        : min= 1208, max= 4626, avg=3198.38, stdev=654.99, samples=164
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.05%, 4=62.80%, 10=34.34%, 20=1.93%, 50=0.81%
  lat (msec)   : 100=0.05%, 250=0.01%
  cpu          : usr=2.02%, sys=9.13%, ctx=422417, majf=0, minf=3898
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165574,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=17.9MiB/s (18.8MB/s), 17.9MiB/s-17.9MiB/s (18.8MB/s-18.8MB/s), io=647MiB (678MB), run=36059-36059msec
  WRITE: bw=12.5MiB/s (13.1MB/s), 12.5MiB/s-12.5MiB/s (13.1MB/s-13.1MB/s), io=1024MiB (1074MB), run=81996-81996msec

Disk stats (read/write):
  loop3: ios=165516/274739, merge=0/1239, ticks=573166/1354400, in_queue=1935490, util=99.86%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop1/testfile
+ fio fio/verify.fio --filename=/mnt/loop1/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.2%][r=16.4MiB/s][r=4188 IOPS][eta 00m:27s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4321: Mon Feb 14 00:47:15 2022
  read: IOPS=4598, BW=18.0MiB/s (18.8MB/s)(648MiB/36048msec)
    slat (usec): min=7, max=6302, avg=12.44, stdev=31.83
    clat (usec): min=421, max=184955, avg=3464.65, stdev=1920.29
     lat (usec): min=450, max=184973, avg=3477.19, stdev=1921.75
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2507], 10.00th=[ 2573], 20.00th=[ 2737],
     | 30.00th=[ 2868], 40.00th=[ 3163], 50.00th=[ 3523], 60.00th=[ 3752],
     | 70.00th=[ 3851], 80.00th=[ 3949], 90.00th=[ 4228], 95.00th=[ 4359],
     | 99.00th=[ 6325], 99.50th=[ 6915], 99.90th=[ 8291], 99.95th=[ 9110],
     | 99.99th=[15139]
  write: IOPS=3213, BW=12.6MiB/s (13.2MB/s)(1024MiB/81578msec); 0 zone resets
    slat (usec): min=9, max=103942, avg=26.21, stdev=275.35
    clat (usec): min=462, max=202364, avg=4951.53, stdev=4217.15
     lat (usec): min=776, max=202401, avg=4977.88, stdev=4237.99
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    4], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    7], 95.00th=[   10],
     | 99.00th=[   24], 99.50th=[   30], 99.90th=[   40], 99.95th=[   54],
     | 99.99th=[  138]
   bw (  KiB/s): min= 4368, max=19240, per=100.00%, avg=12865.96, stdev=2971.61, samples=163
   iops        : min= 1092, max= 4810, avg=3216.49, stdev=742.90, samples=163
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=64.55%, 10=32.44%, 20=2.12%, 50=0.83%
  lat (msec)   : 100=0.03%, 250=0.01%
  cpu          : usr=2.03%, sys=9.06%, ctx=423983, majf=0, minf=3903
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165779,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.0MiB/s (18.8MB/s), 18.0MiB/s-18.0MiB/s (18.8MB/s-18.8MB/s), io=648MiB (679MB), run=36048-36048msec
  WRITE: bw=12.6MiB/s (13.2MB/s), 12.6MiB/s-12.6MiB/s (13.2MB/s-13.2MB/s), io=1024MiB (1074MB), run=81578-81578msec

Disk stats (read/write):
  loop1: ios=164590/274753, merge=0/972, ticks=569739/1340209, in_queue=1917586, util=99.90%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop7/testfile
+ fio fio/verify.fio --filename=/mnt/loop7/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.0%][r=18.5MiB/s][r=4743 IOPS][eta 00m:29s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4369: Mon Feb 14 00:49:20 2022
  read: IOPS=4576, BW=17.9MiB/s (18.7MB/s)(648MiB/36269msec)
    slat (usec): min=7, max=3455, avg=12.29, stdev=18.44
    clat (usec): min=339, max=183878, avg=3481.44, stdev=1929.01
     lat (usec): min=392, max=183901, avg=3493.84, stdev=1930.15
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2507], 10.00th=[ 2573], 20.00th=[ 2704],
     | 30.00th=[ 2868], 40.00th=[ 3163], 50.00th=[ 3523], 60.00th=[ 3752],
     | 70.00th=[ 3851], 80.00th=[ 3982], 90.00th=[ 4228], 95.00th=[ 4424],
     | 99.00th=[ 6521], 99.50th=[ 7046], 99.90th=[10159], 99.95th=[11338],
     | 99.99th=[14222]
  write: IOPS=2964, BW=11.6MiB/s (12.1MB/s)(1024MiB/88415msec); 0 zone resets
    slat (usec): min=9, max=22005, avg=26.98, stdev=119.64
    clat (usec): min=363, max=331919, avg=5368.06, stdev=8943.04
     lat (usec): min=660, max=331946, avg=5395.19, stdev=8945.60
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    4], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    7], 95.00th=[   11],
     | 99.00th=[   27], 99.50th=[   33], 99.90th=[  153], 99.95th=[  232],
     | 99.99th=[  313]
   bw (  KiB/s): min=  200, max=19288, per=99.94%, avg=11853.62, stdev=3752.39, samples=177
   iops        : min=   50, max= 4822, avg=2963.33, stdev=938.07, samples=177
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=62.68%, 10=33.85%, 20=2.47%, 50=0.82%
  lat (msec)   : 100=0.05%, 250=0.07%, 500=0.02%
  cpu          : usr=1.98%, sys=8.76%, ctx=423946, majf=0, minf=3908
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=166003,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=17.9MiB/s (18.7MB/s), 17.9MiB/s-17.9MiB/s (18.7MB/s-18.7MB/s), io=648MiB (680MB), run=36269-36269msec
  WRITE: bw=11.6MiB/s (12.1MB/s), 11.6MiB/s-11.6MiB/s (12.1MB/s-12.1MB/s), io=1024MiB (1074MB), run=88415-88415msec

Disk stats (read/write):
  loop7: ios=165505/275157, merge=0/445, ticks=575262/1491091, in_queue=2074451, util=99.80%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop2/testfile
+ fio fio/verify.fio --filename=/mnt/loop2/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.0%][r=19.8MiB/s][r=5069 IOPS][eta 00m:29s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4443: Mon Feb 14 00:51:25 2022
  read: IOPS=4727, BW=18.5MiB/s (19.4MB/s)(647MiB/35059msec)
    slat (usec): min=7, max=4887, avg=12.81, stdev=23.98
    clat (usec): min=245, max=132700, avg=3369.45, stdev=1488.12
     lat (usec): min=288, max=132731, avg=3382.36, stdev=1489.93
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2507], 10.00th=[ 2540], 20.00th=[ 2638],
     | 30.00th=[ 2769], 40.00th=[ 2966], 50.00th=[ 3294], 60.00th=[ 3621],
     | 70.00th=[ 3785], 80.00th=[ 3916], 90.00th=[ 4228], 95.00th=[ 4359],
     | 99.00th=[ 6390], 99.50th=[ 6915], 99.90th=[ 9503], 99.95th=[10552],
     | 99.99th=[13829]
  write: IOPS=2931, BW=11.5MiB/s (12.0MB/s)(1024MiB/89414msec); 0 zone resets
    slat (usec): min=9, max=64714, avg=31.32, stdev=289.47
    clat (usec): min=370, max=161699, avg=5424.62, stdev=4208.98
     lat (usec): min=524, max=161746, avg=5456.10, stdev=4225.29
    clat percentiles (usec):
     |  1.00th=[ 3064],  5.00th=[ 3163], 10.00th=[ 3228], 20.00th=[ 3392],
     | 30.00th=[ 3621], 40.00th=[ 3851], 50.00th=[ 4178], 60.00th=[ 4621],
     | 70.00th=[ 5473], 80.00th=[ 6325], 90.00th=[ 8094], 95.00th=[11469],
     | 99.00th=[25560], 99.50th=[31589], 99.90th=[44303], 99.95th=[54789],
     | 99.99th=[81265]
   bw (  KiB/s): min= 1408, max=19264, per=99.91%, avg=11717.60, stdev=3203.42, samples=179
   iops        : min=  352, max= 4816, avg=2929.39, stdev=800.85, samples=179
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.03%, 4=60.44%, 10=35.67%, 20=2.88%, 50=0.93%
  lat (msec)   : 100=0.04%, 250=0.01%
  cpu          : usr=2.12%, sys=9.57%, ctx=423544, majf=0, minf=3902
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165748,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.5MiB/s (19.4MB/s), 18.5MiB/s-18.5MiB/s (19.4MB/s-19.4MB/s), io=647MiB (679MB), run=35059-35059msec
  WRITE: bw=11.5MiB/s (12.0MB/s), 11.5MiB/s-11.5MiB/s (12.0MB/s-12.0MB/s), io=1024MiB (1074MB), run=89414-89414msec

Disk stats (read/write):
  loop2: ios=165107/275671, merge=0/849, ticks=555353/1492768, in_queue=2056959, util=99.84%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop9/testfile
+ fio fio/verify.fio --filename=/mnt/loop9/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.6%][r=17.8MiB/s][r=4544 IOPS][eta 00m:27s]                 
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4536: Mon Feb 14 00:53:25 2022
  read: IOPS=4578, BW=17.9MiB/s (18.8MB/s)(648MiB/36203msec)
    slat (usec): min=7, max=3656, avg=12.64, stdev=30.11
    clat (usec): min=433, max=172133, avg=3479.80, stdev=1835.20
     lat (usec): min=461, max=172146, avg=3492.54, stdev=1836.82
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2507], 10.00th=[ 2540], 20.00th=[ 2737],
     | 30.00th=[ 2868], 40.00th=[ 3195], 50.00th=[ 3556], 60.00th=[ 3785],
     | 70.00th=[ 3851], 80.00th=[ 3982], 90.00th=[ 4228], 95.00th=[ 4359],
     | 99.00th=[ 6194], 99.50th=[ 6849], 99.90th=[ 9634], 99.95th=[10945],
     | 99.99th=[27657]
  write: IOPS=3129, BW=12.2MiB/s (12.8MB/s)(1024MiB/83768msec); 0 zone resets
    slat (usec): min=9, max=118411, avg=27.16, stdev=269.68
    clat (usec): min=399, max=156396, avg=5084.28, stdev=4265.18
     lat (usec): min=611, max=156425, avg=5111.58, stdev=4275.66
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    7], 95.00th=[   11],
     | 99.00th=[   25], 99.50th=[   31], 99.90th=[   48], 99.95th=[   68],
     | 99.99th=[  127]
   bw (  KiB/s): min= 3808, max=17688, per=99.75%, avg=12486.86, stdev=2928.80, samples=168
   iops        : min=  952, max= 4422, avg=3121.66, stdev=732.17, samples=168
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.06%, 4=62.84%, 10=33.78%, 20=2.44%, 50=0.82%
  lat (msec)   : 100=0.05%, 250=0.01%
  cpu          : usr=1.94%, sys=9.19%, ctx=422880, majf=0, minf=3903
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165766,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=17.9MiB/s (18.8MB/s), 17.9MiB/s-17.9MiB/s (18.8MB/s-18.8MB/s), io=648MiB (679MB), run=36203-36203msec
  WRITE: bw=12.2MiB/s (12.8MB/s), 12.2MiB/s-12.2MiB/s (12.8MB/s-12.8MB/s), io=1024MiB (1074MB), run=83768-83768msec

Disk stats (read/write):
  loop9: ios=164914/275126, merge=0/801, ticks=573496/1387584, in_queue=1969380, util=99.87%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop8/testfile
+ fio fio/verify.fio --filename=/mnt/loop8/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
./kernel_compile.sh Jobs: 1 (f=1): [V(1)][75.7%][r=19.5MiB/s][r=4996 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [V(1)][81.5%][r=18.9MiB/s][r=4826 IOPS][eta 00m:27s]
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4770: Mon Feb 14 00:55:24 2022
  read: IOPS=4440, BW=17.3MiB/s (18.2MB/s)(647MiB/37270msec)
    slat (usec): min=7, max=2362, avg=13.33, stdev=18.79
    clat (usec): min=303, max=197336, avg=3587.52, stdev=2050.10
     lat (usec): min=355, max=197349, avg=3600.96, stdev=2051.09
    clat percentiles (usec):
     |  1.00th=[ 2474],  5.00th=[ 2540], 10.00th=[ 2638], 20.00th=[ 2802],
     | 30.00th=[ 2999], 40.00th=[ 3392], 50.00th=[ 3720], 60.00th=[ 3851],
     | 70.00th=[ 3916], 80.00th=[ 4047], 90.00th=[ 4293], 95.00th=[ 4490],
     | 99.00th=[ 6521], 99.50th=[ 7046], 99.90th=[ 9110], 99.95th=[10421],
     | 99.99th=[17433]
  write: IOPS=3205, BW=12.5MiB/s (13.1MB/s)(1024MiB/81785msec); 0 zone resets
    slat (usec): min=9, max=90569, avg=27.29, stdev=290.77
    clat (usec): min=360, max=145421, avg=4963.20, stdev=4064.59
     lat (usec): min=506, max=145449, avg=4990.62, stdev=4085.24
    clat percentiles (usec):
     |  1.00th=[ 2835],  5.00th=[ 2966], 10.00th=[ 3032], 20.00th=[ 3163],
     | 30.00th=[ 3261], 40.00th=[ 3490], 50.00th=[ 3982], 60.00th=[ 4621],
     | 70.00th=[ 5145], 80.00th=[ 5604], 90.00th=[ 6521], 95.00th=[ 9372],
     | 99.00th=[25035], 99.50th=[30540], 99.90th=[45351], 99.95th=[58459],
     | 99.99th=[88605]
   bw (  KiB/s): min= 2632, max=20184, per=99.73%, avg=12787.02, stdev=2904.81, samples=164
   iops        : min=  658, max= 5046, avg=3196.75, stdev=726.20, samples=164
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.05%, 4=60.54%, 10=36.65%, 20=1.84%, 50=0.86%
  lat (msec)   : 100=0.04%, 250=0.01%
  cpu          : usr=1.99%, sys=9.24%, ctx=423283, majf=0, minf=3903
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165505,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=17.3MiB/s (18.2MB/s), 17.3MiB/s-17.3MiB/s (18.2MB/s-18.2MB/s), io=647MiB (678MB), run=37270-37270msec
  WRITE: bw=12.5MiB/s (13.1MB/s), 12.5MiB/s-12.5MiB/s (13.1MB/s-13.1MB/s), io=1024MiB (1074MB), run=81785-81785msec

Disk stats (read/write):
  loop8: ios=164724/275455, merge=0/496, ticks=589770/1367679, in_queue=1965080, util=99.91%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop10/testfile
+ fio fio/verify.fio --filename=/mnt/loop10/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.3%][r=17.8MiB/s][r=4556 IOPS][eta 00m:29s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4933: Mon Feb 14 00:57:31 2022
  read: IOPS=4707, BW=18.4MiB/s (19.3MB/s)(647MiB/35192msec)
    slat (usec): min=7, max=3278, avg=12.42, stdev=17.36
    clat (usec): min=188, max=110908, avg=3384.22, stdev=1312.64
     lat (usec): min=216, max=110935, avg=3396.74, stdev=1314.44
    clat percentiles (usec):
     |  1.00th=[ 2376],  5.00th=[ 2442], 10.00th=[ 2474], 20.00th=[ 2573],
     | 30.00th=[ 2737], 40.00th=[ 2966], 50.00th=[ 3425], 60.00th=[ 3720],
     | 70.00th=[ 3851], 80.00th=[ 3949], 90.00th=[ 4228], 95.00th=[ 4359],
     | 99.00th=[ 6390], 99.50th=[ 6915], 99.90th=[ 9765], 99.95th=[10945],
     | 99.99th=[13960]
  write: IOPS=2875, BW=11.2MiB/s (11.8MB/s)(1024MiB/91151msec); 0 zone resets
    slat (usec): min=9, max=188191, avg=31.96, stdev=677.26
    clat (usec): min=327, max=498572, avg=5530.16, stdev=11129.13
     lat (usec): min=360, max=498617, avg=5562.26, stdev=11210.29
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    3], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    7], 95.00th=[   11],
     | 99.00th=[   30], 99.50th=[   48], 99.90th=[  207], 99.95th=[  249],
     | 99.99th=[  292]
   bw (  KiB/s): min=  208, max=20048, per=99.67%, avg=11466.34, stdev=4330.86, samples=183
   iops        : min=   52, max= 5012, avg=2866.48, stdev=1082.72, samples=183
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.04%, 4=63.80%, 10=32.95%, 20=2.05%, 50=0.86%
  lat (msec)   : 100=0.11%, 250=0.15%, 500=0.03%
  cpu          : usr=1.84%, sys=8.64%, ctx=423262, majf=0, minf=3902
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165678,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.4MiB/s (19.3MB/s), 18.4MiB/s-18.4MiB/s (19.3MB/s-19.3MB/s), io=647MiB (679MB), run=35192-35192msec
  WRITE: bw=11.2MiB/s (11.8MB/s), 11.2MiB/s-11.2MiB/s (11.8MB/s-11.8MB/s), io=1024MiB (1074MB), run=91151-91151msec

Disk stats (read/write):
  loop10: ios=165337/275417, merge=0/558, ticks=558916/1602182, in_queue=2171960, util=99.48%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop6/testfile
+ fio fio/verify.fio --filename=/mnt/loop6/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.5%][r=17.2MiB/s][r=4407 IOPS][eta 00m:28s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=5008: Mon Feb 14 00:59:35 2022
  read: IOPS=4388, BW=17.1MiB/s (18.0MB/s)(648MiB/37775msec)
    slat (usec): min=7, max=3957, avg=13.73, stdev=18.70
    clat (usec): min=214, max=30818, avg=3630.04, stdev=887.40
     lat (usec): min=246, max=30833, avg=3643.89, stdev=889.77
    clat percentiles (usec):
     |  1.00th=[ 2474],  5.00th=[ 2573], 10.00th=[ 2671], 20.00th=[ 2835],
     | 30.00th=[ 3032], 40.00th=[ 3326], 50.00th=[ 3654], 60.00th=[ 3851],
     | 70.00th=[ 3982], 80.00th=[ 4228], 90.00th=[ 4490], 95.00th=[ 4817],
     | 99.00th=[ 6521], 99.50th=[ 7242], 99.90th=[ 9634], 99.95th=[10814],
     | 99.99th=[26608]
  write: IOPS=3058, BW=11.9MiB/s (12.5MB/s)(1024MiB/85702msec); 0 zone resets
    slat (usec): min=9, max=64165, avg=28.45, stdev=341.57
    clat (usec): min=283, max=292636, avg=5201.04, stdev=7778.65
     lat (usec): min=419, max=300151, avg=5229.64, stdev=7823.47
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    5],
     | 70.00th=[    5], 80.00th=[    6], 90.00th=[    7], 95.00th=[   11],
     | 99.00th=[   28], 99.50th=[   35], 99.90th=[  121], 99.95th=[  188],
     | 99.99th=[  259]
   bw (  KiB/s): min=  368, max=19680, per=99.66%, avg=12193.70, stdev=3835.99, samples=172
   iops        : min=   92, max= 4920, avg=3048.40, stdev=958.99, samples=172
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.05%, 4=61.29%, 10=35.42%, 20=2.16%, 50=0.89%
  lat (msec)   : 100=0.11%, 250=0.07%, 500=0.01%
  cpu          : usr=1.93%, sys=8.80%, ctx=423706, majf=0, minf=3901
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165770,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=17.1MiB/s (18.0MB/s), 17.1MiB/s-17.1MiB/s (18.0MB/s-18.0MB/s), io=648MiB (679MB), run=37775-37775msec
  WRITE: bw=11.9MiB/s (12.5MB/s), 11.9MiB/s-11.9MiB/s (12.5MB/s-12.5MB/s), io=1024MiB (1074MB), run=85702-85702msec

Disk stats (read/write):
  loop6: ios=165239/275207, merge=0/399, ticks=599041/1461570, in_queue=2069975, util=99.69%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop4/testfile
+ fio fio/verify.fio --filename=/mnt/loop4/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [V(1)][81.1%][r=18.5MiB/s][r=4724 IOPS][eta 00m:33s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=5048: Mon Feb 14 01:01:58 2022
  read: IOPS=4523, BW=17.7MiB/s (18.5MB/s)(647MiB/36630msec)
    slat (usec): min=7, max=5014, avg=13.45, stdev=45.87
    clat (usec): min=231, max=180178, avg=3521.35, stdev=1920.30
     lat (usec): min=263, max=180195, avg=3534.91, stdev=1923.48
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2573], 10.00th=[ 2638], 20.00th=[ 2802],
     | 30.00th=[ 2933], 40.00th=[ 3130], 50.00th=[ 3425], 60.00th=[ 3687],
     | 70.00th=[ 3884], 80.00th=[ 4047], 90.00th=[ 4359], 95.00th=[ 4621],
     | 99.00th=[ 6521], 99.50th=[ 7177], 99.90th=[10945], 99.95th=[12256],
     | 99.99th=[20055]
  write: IOPS=2477, BW=9911KiB/s (10.1MB/s)(1024MiB/105799msec); 0 zone resets
    slat (usec): min=9, max=149056, avg=38.32, stdev=830.44
    clat (usec): min=576, max=335748, avg=6417.70, stdev=16705.28
     lat (usec): min=677, max=335834, avg=6456.18, stdev=16804.79
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    4], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    5], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    8], 95.00th=[   12],
     | 99.00th=[   41], 99.50th=[  132], 99.90th=[  271], 99.95th=[  292],
     | 99.99th=[  330]
   bw (  KiB/s): min=  200, max=17667, per=99.85%, avg=9896.22, stdev=4614.79, samples=212
   iops        : min=   50, max= 4416, avg=2473.96, stdev=1153.68, samples=212
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=60.24%, 10=36.23%, 20=2.09%, 50=0.90%
  lat (msec)   : 100=0.14%, 250=0.29%, 500=0.10%
  cpu          : usr=1.82%, sys=7.77%, ctx=422823, majf=0, minf=3901
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=165702,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=17.7MiB/s (18.5MB/s), 17.7MiB/s-17.7MiB/s (18.5MB/s-18.5MB/s), io=647MiB (679MB), run=36630-36630msec
  WRITE: bw=9911KiB/s (10.1MB/s), 9911KiB/s-9911KiB/s (10.1MB/s-10.1MB/s), io=1024MiB (1074MB), run=105799-105799msec

Disk stats (read/write):
  loop4: ios=165422/275347, merge=0/459, ticks=581057/1918398, in_queue=2512842, util=99.54%
+ df -h /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      2.0G  1.1G  965M  53% /mnt/loop1
/dev/loop10     2.0G  1.1G  966M  53% /mnt/loop10
/dev/loop2      2.0G  1.1G  966M  53% /mnt/loop2
/dev/loop3      2.0G  1.1G  966M  53% /mnt/loop3
/dev/loop4      2.0G  1.1G  965M  53% /mnt/loop4
/dev/loop5      2.0G  1.1G  966M  53% /mnt/loop5
/dev/loop6      2.0G  1.1G  966M  53% /mnt/loop6
/dev/loop7      2.0G  1.1G  966M  53% /mnt/loop7
/dev/loop8      2.0G  1.1G  965M  53% /mnt/loop8
/dev/loop9      2.0G  1.1G  965M  53% /mnt/loop9
+ unload_loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop3
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop10
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop5
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop8
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop9
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop4
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop7
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop2
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop1
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop6
+ rm -fr ./loop6
+ losetup -D
+ sleep 3
+ rmmod loop
+ modprobe -r loop
+ lsmod
+ grep loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop9
+ rm -fr /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
+ dmesg -c
[ 1355.637847] XFS (loop3): Unmounting Filesystem
[ 1355.777851] XFS (loop10): Unmounting Filesystem
[ 1355.916829] XFS (loop5): Unmounting Filesystem
[ 1356.049920] XFS (loop8): Unmounting Filesystem
[ 1356.197833] XFS (loop9): Unmounting Filesystem
[ 1356.332848] XFS (loop4): Unmounting Filesystem
[ 1356.519850] XFS (loop7): Unmounting Filesystem
[ 1356.655913] XFS (loop2): Unmounting Filesystem
[ 1356.781838] XFS (loop1): Unmounting Filesystem
[ 1356.909819] XFS (loop6): Unmounting Filesystem

-- 
2.29.0

