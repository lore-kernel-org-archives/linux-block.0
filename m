Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6EDC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 21:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbiBOVdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:33:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiBOVdi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 16:33:38 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08372EBBAD
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 13:33:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzBf5Hl/dTAnYATQIQC28WFnTjTrBTrxT9iv5DnaYPTkrhKJrPMjrhJK2OKCofeDuyIOo1mDtYQl8sHw3mwuSWnOVZUDhx1DIZUbuEnvp/OAhdWhS00ZMBO59qO9HX+rPEl4n8jD+PzsviD8kzlbXc8+4lIYgShuYkxAdhm3zgMqtyunzWHbuFT6gn5sWgDw/Ii/bJrTCgRw3QZxsaFdjqG0mJkLfAW9QZoSEEg7eihkwlcc9V1dxLWwJDjj/QaOLJlwzkgT/rlA6/LZdRkyi0fRCBQmrh9PCdSsymdbCcIpk13cGReSPEDde/+9+KYcNR1plyWgErExXDkPzWI85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6YZw4bPYe7umv+eaAPy87cBRj4CtD0ZC2dr6C2o4io=;
 b=oOjjQXKpPw/iuxuUeGWtNcl0ESrbH7KKUE/SKg8ej/qMDHGncP+2HqKYtXPcLrj5J+sh+mZ/Vu0rMu95Gf+rFkQpRl17i0u2tTlqy0kY+PWbhMYDWaEFpaJZZyOOiY+AXYMoM54PLuUlZ7PS/Wlyx3ud2KhDKrEaAoNUzD2ppgEzEQdO0TNg66LDg/g3BqFdMJo+5/Auqs6HWZnVZbkVEzz6ONUUCYPTYSpk2ftgI+41TicoM5Ncm9EpQ5cvspyCJux0Z2bukQdrpxPS42eGHz2fIhOh+cnvSa7GRQB4iZ92LgidYlhkyLY6uU11P/PfNaKsn0fOBw0vCGH4TQpHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6YZw4bPYe7umv+eaAPy87cBRj4CtD0ZC2dr6C2o4io=;
 b=MhscnndoQKpw1QAasUIDDR1At1u/Gzs3wWmYdn/9XWAdXfn8crOMUjchnNRSNuIY53KHsX9DaTcS12sAQ4qk6O+4ji7Ngxoq7XxpxLXzWFSwdoH0iyFEzzdgiwvukY8tNH8jafXz0CbQDptQ9beb7/36g0TqIi+af5DHaudGCJ53mXFWtnJzkVs/xYaXPbGDMwm8TEPRzuKx+jTVEbp6m4j5R/nGONw9QrkzpSckKMMmoExd/GCsKobQ9NI7evD1td72ESZXeEcOkb7XXV45tQVi6MEcuWewtG/GUHzuw0rI3dZPxQrtoQ3QH28dVRt0nJ9UsOhW11p2KhTGvhXzug==
Received: from BN9PR03CA0555.namprd03.prod.outlook.com (2603:10b6:408:138::20)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 21:33:20 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::e9) by BN9PR03CA0555.outlook.office365.com
 (2603:10b6:408:138::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 21:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:33:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 21:33:17 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 13:33:16 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V3 0/4] loop: cleanup and few improvements
Date:   Tue, 15 Feb 2022 13:33:06 -0800
Message-ID: <20220215213310.7264-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e41e38dc-a446-46d7-4a54-08d9f0cac9c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4233:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4233198EDFF935D65C30E0B5A3349@DM6PR12MB4233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TsPSYaLUj5ovv+/9U31evCusPX7/eNt9i51Lc92nM4bSOoDayugT3sLVV84tSm/K3xPKzsfNP7P6LEskqwsx0EHPdobUdSI7VQB7moTL769Z2zuv29UWz2XQaDzwPm1QCh5/NVU1HXgSPxg6DNZkJ2oMGny3VCRCCkts37Bo4byvtpD3NKlvja5Qw8xZuwnvcIholTj1vGWQiiBIl3p0jqUjvHvVmZD+04fhwemqiLt7LsAd7wd/wm5VcZaqxGAJJiRMoXZiKaWF+fXh5HxDm9Iwq1V//bMyC0QutD/D+bEWaUNdhAD7Ftq58SCy3hK5rc3YjLeYE5Nb08d4DnbI6sjCkeAv54yX8PuLbZE8gdZJ1jrdghYtmtnw6YtjPGqf6h9TUJCvWkvinuNAwyfzKnlHdFa025wd5HgNfiRieOiiH0QUCkGz6ZJwv9+jd1dRxfcwDwjxYccpCAXqbIh216IrNSh3fcv4SPHj9EoKFXFar7m7w+CwUiAwTLE4/PeEW5vtRxBWGpEvbvwWsu6P/kCdTvDDmpwqRotRByL/Jhn47JyU41itlq1rB5Lo6lBEtuBq/Bb08x4BgBxMkcAkfkZ70IQoFZPYzz7DID2jjA45hBZkgIr4QHjlnqVJq1KuyvRMqt7dc/owXXLj1+8WCuG3KPyTiy0YCmm8/ibaCHKPbSBzzZdxhSKGUW9EdLHCAv+G9aOuaCiQ4cJtSgFecNA7bS+lvQvg5HpDsjSR/bA=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(2906002)(81166007)(356005)(40460700003)(30864003)(5660300002)(47076005)(8936002)(336012)(6666004)(70206006)(4326008)(7696005)(2616005)(426003)(186003)(70586007)(508600001)(8676002)(1076003)(19627235002)(16526019)(26005)(82310400004)(107886003)(83380400001)(316002)(6916009)(54906003)(21314003)(36900700001)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:33:20.2621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e41e38dc-a446-46d7-4a54-08d9f0cac9c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This has few improvment and cleanups such as using sysfs_emit() for the
sysfs dev attributes and removing variables that are only used once and
a cleanup with fixing declaration.

Below is the test log where 10 loop devices created, each device is
linked to it's own file in ./loopX, formatted with xfs and mounted on
/mnt/loopX. For each device it reads the offset, sizelimit, autoclear,
partscan, and dio attr from sysfs using cat command, then it runs fio
verify job on it.
root@dev loop-sysfs-emit (for-next) # grep err= 0000-cover-letter.patch
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3802: Tue Feb 15 12:53:57 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3824: Tue Feb 15 12:54:24 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3836: Tue Feb 15 12:54:51 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3849: Tue Feb 15 12:55:18 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3879: Tue Feb 15 12:55:45 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3907: Tue Feb 15 12:56:12 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3959: Tue Feb 15 12:56:39 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3980: Tue Feb 15 12:57:06 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3998: Tue Feb 15 12:57:34 2022
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4018: Tue Feb 15 12:58:01 2022

Below is detailed test log along with huge values used for hw_queue_depth.

-ck

changes from V2:-

1. Add range check for module parameter hw_queue_depth. (Jens) 

changes from V1:-

1. Squash all patches for sysfs_emit() into single patch. (Jens)

Chaitanya Kulkarni (4):
  loop: use sysfs_emit() in the sysfs xxx show()
  loop: remove extra variable in lo_fallocate()
  loop: remove extra variable in lo_req_flush
  loop: allow user to set the queue depth

 drivers/block/loop.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

* Data Verification test on 10 file backed loop devices :-

root@dev linux-block (for-next) # git am p/loop-sysfs-emit/*patch 
Patch is empty.
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
root@dev linux-block (for-next) # git am --skip 
Applying: loop: use sysfs_emit() in the sysfs xxx show()
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
+ umount /mnt/loop7
umount: /mnt/loop7: no mount point specified.
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop10
umount: /mnt/loop10: no mount point specified.
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop2
umount: /mnt/loop2: no mount point specified.
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop9
umount: /mnt/loop9: no mount point specified.
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop6
umount: /mnt/loop6: no mount point specified.
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop1
umount: /mnt/loop1: no mount point specified.
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop5
umount: /mnt/loop5: no mount point specified.
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop8
umount: /mnt/loop8: no mount point specified.
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop4
umount: /mnt/loop4: no mount point specified.
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop3
umount: /mnt/loop3: no mount point specified.
+ rm -fr ./loop3
+ losetup -D
+ sleep 3
+ rmmod loop
rmmod: ERROR: Module loop is not currently loaded
+ modprobe -r loop
+ lsmod
+ grep loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop6
+ rm -fr '/mnt/loop*'
+ dmesg -c
+ compile_loop
+ git apply wip.diff
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/loop.o
  CC [M]  drivers/block/pktcdvd.o
  MODPOST drivers/block/Module.symvers
  LD [M]  drivers/block/loop.ko
  LD [M]  drivers/block/pktcdvd.ko
+ HOST=drivers/block/
++ uname -r
+ HOST_DEST=/lib/modules/5.17.0-rc3blk+/kernel/drivers/block
+ cp drivers/block//loop.ko /lib/modules/5.17.0-rc3blk+/kernel/drivers/block/
+ insmod drivers/block/loop.ko max_loop=11
+ load_loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop6
+ truncate -s 2048M ./loop6
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop6 ./loop6
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop6         0      0         0  0 /mnt/data/linux-block/loop6   1     512
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
+ cat /sys/block/loop6/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/sizelimit : '
cat /sys/block/loop6/loop/sizelimit : + cat /sys/block/loop6/loop/sizelimit
0
+ cat /sys/block/loop6/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/autoclear : '
cat /sys/block/loop6/loop/autoclear : + cat /sys/block/loop6/loop/autoclear
0
+ cat /sys/block/loop6/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/partscan : '
cat /sys/block/loop6/loop/partscan : + cat /sys/block/loop6/loop/partscan
0
+ cat /sys/block/loop6/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/dio : '
cat /sys/block/loop6/loop/dio : + cat /sys/block/loop6/loop/dio
1
+ cat /sys/block/loop6/queue/nr_requests
128
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop2
+ truncate -s 2048M ./loop2
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop2 ./loop2
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop6         0      0         0  0 /mnt/data/linux-block/loop6   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
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
+ cat /sys/block/loop2/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/sizelimit : '
cat /sys/block/loop2/loop/sizelimit : + cat /sys/block/loop2/loop/sizelimit
0
+ cat /sys/block/loop2/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/autoclear : '
cat /sys/block/loop2/loop/autoclear : + cat /sys/block/loop2/loop/autoclear
0
+ cat /sys/block/loop2/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/partscan : '
cat /sys/block/loop2/loop/partscan : + cat /sys/block/loop2/loop/partscan
0
+ cat /sys/block/loop2/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/dio : '
cat /sys/block/loop2/loop/dio : + cat /sys/block/loop2/loop/dio
1
+ cat /sys/block/loop2/queue/nr_requests
128
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop10
+ truncate -s 2048M ./loop10
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop10 ./loop10
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop6          0      0         0  0 /mnt/data/linux-block/loop6    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
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
+ cat /sys/block/loop10/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/sizelimit : '
cat /sys/block/loop10/loop/sizelimit : + cat /sys/block/loop10/loop/sizelimit
0
+ cat /sys/block/loop10/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/autoclear : '
cat /sys/block/loop10/loop/autoclear : + cat /sys/block/loop10/loop/autoclear
0
+ cat /sys/block/loop10/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/partscan : '
cat /sys/block/loop10/loop/partscan : + cat /sys/block/loop10/loop/partscan
0
+ cat /sys/block/loop10/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/dio : '
cat /sys/block/loop10/loop/dio : + cat /sys/block/loop10/loop/dio
1
+ cat /sys/block/loop10/queue/nr_requests
128
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop8
+ truncate -s 2048M ./loop8
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop8 ./loop8
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop8          0      0         0  0 /mnt/data/linux-block/loop8    1     512
/dev/loop6          0      0         0  0 /mnt/data/linux-block/loop6    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
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
+ cat /sys/block/loop8/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/sizelimit : '
cat /sys/block/loop8/loop/sizelimit : + cat /sys/block/loop8/loop/sizelimit
0
+ cat /sys/block/loop8/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/autoclear : '
cat /sys/block/loop8/loop/autoclear : + cat /sys/block/loop8/loop/autoclear
0
+ cat /sys/block/loop8/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/partscan : '
cat /sys/block/loop8/loop/partscan : + cat /sys/block/loop8/loop/partscan
0
+ cat /sys/block/loop8/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/dio : '
cat /sys/block/loop8/loop/dio : + cat /sys/block/loop8/loop/dio
1
+ cat /sys/block/loop8/queue/nr_requests
128
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop1
+ truncate -s 2048M ./loop1
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop1 ./loop1
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop8          0      0         0  0 /mnt/data/linux-block/loop8    1     512
/dev/loop6          0      0         0  0 /mnt/data/linux-block/loop6    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
/dev/loop10         0      0         0  0 /mnt/data/linux-block/loop10   1     512
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
+ cat /sys/block/loop1/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/sizelimit : '
cat /sys/block/loop1/loop/sizelimit : + cat /sys/block/loop1/loop/sizelimit
0
+ cat /sys/block/loop1/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/autoclear : '
cat /sys/block/loop1/loop/autoclear : + cat /sys/block/loop1/loop/autoclear
0
+ cat /sys/block/loop1/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/partscan : '
cat /sys/block/loop1/loop/partscan : + cat /sys/block/loop1/loop/partscan
0
+ cat /sys/block/loop1/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/dio : '
cat /sys/block/loop1/loop/dio : + cat /sys/block/loop1/loop/dio
1
+ cat /sys/block/loop1/queue/nr_requests
128
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop9
+ truncate -s 2048M ./loop9
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop9 ./loop9
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop8          0      0         0  0 /mnt/data/linux-block/loop8    1     512
/dev/loop6          0      0         0  0 /mnt/data/linux-block/loop6    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
/dev/loop10         0      0         0  0 /mnt/data/linux-block/loop10   1     512
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
+ cat /sys/block/loop9/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/sizelimit : '
cat /sys/block/loop9/loop/sizelimit : + cat /sys/block/loop9/loop/sizelimit
0
+ cat /sys/block/loop9/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/autoclear : '
cat /sys/block/loop9/loop/autoclear : + cat /sys/block/loop9/loop/autoclear
0
+ cat /sys/block/loop9/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/partscan : '
cat /sys/block/loop9/loop/partscan : + cat /sys/block/loop9/loop/partscan
0
+ cat /sys/block/loop9/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/dio : '
cat /sys/block/loop9/loop/dio : + cat /sys/block/loop9/loop/dio
1
+ cat /sys/block/loop9/queue/nr_requests
128
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop3
+ truncate -s 2048M ./loop3
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop3 ./loop3
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop8          0      0         0  0 /mnt/data/linux-block/loop8    1     512
/dev/loop6          0      0         0  0 /mnt/data/linux-block/loop6    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
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
+ cat /sys/block/loop3/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/sizelimit : '
cat /sys/block/loop3/loop/sizelimit : + cat /sys/block/loop3/loop/sizelimit
0
+ cat /sys/block/loop3/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/autoclear : '
cat /sys/block/loop3/loop/autoclear : + cat /sys/block/loop3/loop/autoclear
0
+ cat /sys/block/loop3/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/partscan : '
cat /sys/block/loop3/loop/partscan : + cat /sys/block/loop3/loop/partscan
0
+ cat /sys/block/loop3/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/dio : '
cat /sys/block/loop3/loop/dio : + cat /sys/block/loop3/loop/dio
1
+ cat /sys/block/loop3/queue/nr_requests
128
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop7
+ truncate -s 2048M ./loop7
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop7 ./loop7
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop8          0      0         0  0 /mnt/data/linux-block/loop8    1     512
/dev/loop6          0      0         0  0 /mnt/data/linux-block/loop6    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
/dev/loop7          0      0         0  0 /mnt/data/linux-block/loop7    1     512
/dev/loop3          0      0         0  0 /mnt/data/linux-block/loop3    1     512
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
+ cat /sys/block/loop7/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/sizelimit : '
cat /sys/block/loop7/loop/sizelimit : + cat /sys/block/loop7/loop/sizelimit
0
+ cat /sys/block/loop7/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/autoclear : '
cat /sys/block/loop7/loop/autoclear : + cat /sys/block/loop7/loop/autoclear
0
+ cat /sys/block/loop7/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/partscan : '
cat /sys/block/loop7/loop/partscan : + cat /sys/block/loop7/loop/partscan
0
+ cat /sys/block/loop7/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/dio : '
cat /sys/block/loop7/loop/dio : + cat /sys/block/loop7/loop/dio
1
+ cat /sys/block/loop7/queue/nr_requests
128
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop4
+ truncate -s 2048M ./loop4
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop4 ./loop4
+ /mnt/data/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    DIO LOG-SEC
/dev/loop1          0      0         0  0 /mnt/data/linux-block/loop1    1     512
/dev/loop8          0      0         0  0 /mnt/data/linux-block/loop8    1     512
/dev/loop6          0      0         0  0 /mnt/data/linux-block/loop6    1     512
/dev/loop4          0      0         0  0 /mnt/data/linux-block/loop4    1     512
/dev/loop2          0      0         0  0 /mnt/data/linux-block/loop2    1     512
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
/dev/loop7          0      0         0  0 /mnt/data/linux-block/loop7    1     512
/dev/loop3          0      0         0  0 /mnt/data/linux-block/loop3    1     512
/dev/loop10         0      0         0  0 /mnt/data/linux-block/loop10   1     512
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
+ cat /sys/block/loop4/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/sizelimit : '
cat /sys/block/loop4/loop/sizelimit : + cat /sys/block/loop4/loop/sizelimit
0
+ cat /sys/block/loop4/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/autoclear : '
cat /sys/block/loop4/loop/autoclear : + cat /sys/block/loop4/loop/autoclear
0
+ cat /sys/block/loop4/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/partscan : '
cat /sys/block/loop4/loop/partscan : + cat /sys/block/loop4/loop/partscan
0
+ cat /sys/block/loop4/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/dio : '
cat /sys/block/loop4/loop/dio : + cat /sys/block/loop4/loop/dio
1
+ cat /sys/block/loop4/queue/nr_requests
128
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop5
+ truncate -s 2048M ./loop5
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop5 ./loop5
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
+ cat /sys/block/loop5/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/sizelimit : '
cat /sys/block/loop5/loop/sizelimit : + cat /sys/block/loop5/loop/sizelimit
0
+ cat /sys/block/loop5/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/autoclear : '
cat /sys/block/loop5/loop/autoclear : + cat /sys/block/loop5/loop/autoclear
0
+ cat /sys/block/loop5/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/partscan : '
cat /sys/block/loop5/loop/partscan : + cat /sys/block/loop5/loop/partscan
0
+ cat /sys/block/loop5/queue/nr_requests
128
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/dio : '
cat /sys/block/loop5/loop/dio : + cat /sys/block/loop5/loop/dio
1
+ cat /sys/block/loop5/queue/nr_requests
128
+ mount
+ grep loop
/dev/loop6 on /mnt/loop6 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop2 on /mnt/loop2 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop10 on /mnt/loop10 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop8 on /mnt/loop8 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop1 on /mnt/loop1 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop9 on /mnt/loop9 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop3 on /mnt/loop3 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop7 on /mnt/loop7 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop4 on /mnt/loop4 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop5 on /mnt/loop5 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
+ dmesg -c
[  171.755294] loop: loading out-of-tree module taints kernel.
[  171.828163] loop: module loaded
[  171.910178] loop6: detected capacity change from 0 to 4194304
[  173.115833] XFS (loop6): Mounting V5 Filesystem
[  173.129500] XFS (loop6): Ending clean mount
[  173.134024] xfs filesystem being mounted at /mnt/loop6 supports timestamps until 2038 (0x7fffffff)
[  173.249230] loop2: detected capacity change from 0 to 4194304
[  174.437102] XFS (loop2): Mounting V5 Filesystem
[  174.451598] XFS (loop2): Ending clean mount
[  174.456087] xfs filesystem being mounted at /mnt/loop2 supports timestamps until 2038 (0x7fffffff)
[  174.568373] loop10: detected capacity change from 0 to 4194304
[  175.742692] XFS (loop10): Mounting V5 Filesystem
[  175.758003] XFS (loop10): Ending clean mount
[  175.763982] xfs filesystem being mounted at /mnt/loop10 supports timestamps until 2038 (0x7fffffff)
[  175.885527] loop8: detected capacity change from 0 to 4194304
[  177.082946] XFS (loop8): Mounting V5 Filesystem
[  177.106643] XFS (loop8): Ending clean mount
[  177.113919] xfs filesystem being mounted at /mnt/loop8 supports timestamps until 2038 (0x7fffffff)
[  177.229986] loop1: detected capacity change from 0 to 4194304
[  178.427277] XFS (loop1): Mounting V5 Filesystem
[  178.443402] XFS (loop1): Ending clean mount
[  178.447290] xfs filesystem being mounted at /mnt/loop1 supports timestamps until 2038 (0x7fffffff)
[  178.573862] loop9: detected capacity change from 0 to 4194304
[  179.754568] XFS (loop9): Mounting V5 Filesystem
[  179.771420] XFS (loop9): Ending clean mount
[  179.778568] xfs filesystem being mounted at /mnt/loop9 supports timestamps until 2038 (0x7fffffff)
[  179.899783] loop3: detected capacity change from 0 to 4194304
[  181.091729] XFS (loop3): Mounting V5 Filesystem
[  181.106735] XFS (loop3): Ending clean mount
[  181.112044] xfs filesystem being mounted at /mnt/loop3 supports timestamps until 2038 (0x7fffffff)
[  181.230130] loop7: detected capacity change from 0 to 4194304
[  182.428015] XFS (loop7): Mounting V5 Filesystem
[  182.444446] XFS (loop7): Ending clean mount
[  182.449372] xfs filesystem being mounted at /mnt/loop7 supports timestamps until 2038 (0x7fffffff)
[  182.573253] loop4: detected capacity change from 0 to 4194304
[  183.760188] XFS (loop4): Mounting V5 Filesystem
[  183.777059] XFS (loop4): Ending clean mount
[  183.781288] xfs filesystem being mounted at /mnt/loop4 supports timestamps until 2038 (0x7fffffff)
[  183.898332] loop5: detected capacity change from 0 to 4194304
[  185.090310] XFS (loop5): Mounting V5 Filesystem
[  185.107226] XFS (loop5): Ending clean mount
[  185.111944] xfs filesystem being mounted at /mnt/loop5 supports timestamps until 2038 (0x7fffffff)
+ run_verify
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop6/testfile
+ fio fio/verify.fio --filename=/mnt/loop6/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.8%][r=16.6MiB/s][r=4256 IOPS][eta 00m:06s]                
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3802: Tue Feb 15 12:53:57 2022
  read: IOPS=4847, BW=18.9MiB/s (19.9MB/s)(158MiB/8368msec)
    slat (usec): min=7, max=398, avg=11.00, stdev= 4.93
    clat (usec): min=547, max=7684, avg=3287.03, stdev=692.24
     lat (usec): min=574, max=7700, avg=3298.13, stdev=693.16
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2671],
     | 30.00th=[ 2769], 40.00th=[ 2900], 50.00th=[ 3163], 60.00th=[ 3490],
     | 70.00th=[ 3720], 80.00th=[ 3851], 90.00th=[ 4113], 95.00th=[ 4293],
     | 99.00th=[ 5800], 99.50th=[ 6456], 99.90th=[ 7111], 99.95th=[ 7308],
     | 99.99th=[ 7570]
  write: IOPS=3392, BW=13.2MiB/s (13.9MB/s)(250MiB/18867msec); 0 zone resets
    slat (usec): min=9, max=1118, avg=20.17, stdev=10.60
    clat (usec): min=1029, max=53049, avg=4695.03, stdev=2586.57
     lat (usec): min=1240, max=53063, avg=4715.32, stdev=2590.37
    clat percentiles (usec):
     |  1.00th=[ 2835],  5.00th=[ 2933], 10.00th=[ 2999], 20.00th=[ 3097],
     | 30.00th=[ 3163], 40.00th=[ 3326], 50.00th=[ 3654], 60.00th=[ 4228],
     | 70.00th=[ 5014], 80.00th=[ 5604], 90.00th=[ 7504], 95.00th=[11076],
     | 99.00th=[13698], 99.50th=[14353], 99.90th=[16319], 99.95th=[35390],
     | 99.99th=[52691]
   bw (  KiB/s): min= 5136, max=19392, per=99.29%, avg=13473.68, stdev=4490.81, samples=38
   iops        : min= 1284, max= 4848, avg=3368.42, stdev=1122.70, samples=38
  lat (usec)   : 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=68.58%, 10=27.37%, 20=4.00%, 50=0.02%
  lat (msec)   : 100=0.01%
  cpu          : usr=1.88%, sys=8.59%, ctx=103927, majf=0, minf=966
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40567,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.9MiB/s (19.9MB/s), 18.9MiB/s-18.9MiB/s (19.9MB/s-19.9MB/s), io=158MiB (166MB), run=8368-8368msec
  WRITE: bw=13.2MiB/s (13.9MB/s), 13.2MiB/s-13.2MiB/s (13.9MB/s-13.9MB/s), io=250MiB (262MB), run=18867-18867msec

Disk stats (read/write):
  loop6: ios=39849/64032, merge=0/1, ticks=131108/297927, in_queue=429078, util=99.72%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop7/testfile
+ fio fio/verify.fio --filename=/mnt/loop7/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.2%][r=18.6MiB/s][r=4750 IOPS][eta 00m:06s]                
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3824: Tue Feb 15 12:54:24 2022
  read: IOPS=4753, BW=18.6MiB/s (19.5MB/s)(158MiB/8525msec)
    slat (usec): min=7, max=194, avg=11.24, stdev= 4.71
    clat (usec): min=307, max=10539, avg=3352.28, stdev=686.93
     lat (usec): min=350, max=10547, avg=3363.62, stdev=688.12
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2474], 10.00th=[ 2573], 20.00th=[ 2704],
     | 30.00th=[ 2802], 40.00th=[ 2999], 50.00th=[ 3326], 60.00th=[ 3654],
     | 70.00th=[ 3785], 80.00th=[ 3851], 90.00th=[ 4146], 95.00th=[ 4293],
     | 99.00th=[ 5669], 99.50th=[ 6325], 99.90th=[ 7177], 99.95th=[ 7504],
     | 99.99th=[ 9634]
  write: IOPS=3589, BW=14.0MiB/s (14.7MB/s)(250MiB/17830msec); 0 zone resets
    slat (usec): min=9, max=1079, avg=19.57, stdev=10.51
    clat (usec): min=631, max=53567, avg=4436.45, stdev=2462.06
     lat (usec): min=789, max=53594, avg=4456.14, stdev=2466.06
    clat percentiles (usec):
     |  1.00th=[ 2802],  5.00th=[ 2900], 10.00th=[ 2966], 20.00th=[ 3064],
     | 30.00th=[ 3163], 40.00th=[ 3228], 50.00th=[ 3359], 60.00th=[ 3654],
     | 70.00th=[ 4555], 80.00th=[ 5342], 90.00th=[ 6980], 95.00th=[ 9896],
     | 99.00th=[13566], 99.50th=[14353], 99.90th=[16712], 99.95th=[38536],
     | 99.99th=[52691]
   bw (  KiB/s): min= 5944, max=20144, per=99.05%, avg=14222.22, stdev=4789.28, samples=36
   iops        : min= 1486, max= 5036, avg=3555.56, stdev=1197.32, samples=36
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=72.84%, 10=24.13%, 20=2.98%, 50=0.02%
  lat (msec)   : 100=0.02%
  cpu          : usr=1.83%, sys=8.97%, ctx=103971, majf=0, minf=965
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40526,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.6MiB/s (19.5MB/s), 18.6MiB/s-18.6MiB/s (19.5MB/s-19.5MB/s), io=158MiB (166MB), run=8525-8525msec
  WRITE: bw=14.0MiB/s (14.7MB/s), 14.0MiB/s-14.0MiB/s (14.7MB/s-14.7MB/s), io=250MiB (262MB), run=17830-17830msec

Disk stats (read/write):
  loop7: ios=40321/64000, merge=0/0, ticks=134969/281138, in_queue=416108, util=99.71%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop8/testfile
+ fio fio/verify.fio --filename=/mnt/loop8/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.8%][r=18.4MiB/s][r=4704 IOPS][eta 00m:06s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3836: Tue Feb 15 12:54:51 2022
  read: IOPS=4719, BW=18.4MiB/s (19.3MB/s)(158MiB/8547msec)
    slat (usec): min=7, max=216, avg=11.48, stdev= 5.09
    clat (usec): min=211, max=7510, avg=3376.50, stdev=700.03
     lat (usec): min=243, max=7528, avg=3388.07, stdev=701.71
    clat percentiles (usec):
     |  1.00th=[ 2442],  5.00th=[ 2507], 10.00th=[ 2540], 20.00th=[ 2704],
     | 30.00th=[ 2835], 40.00th=[ 2999], 50.00th=[ 3326], 60.00th=[ 3621],
     | 70.00th=[ 3785], 80.00th=[ 3916], 90.00th=[ 4228], 95.00th=[ 4359],
     | 99.00th=[ 5800], 99.50th=[ 6521], 99.90th=[ 7111], 99.95th=[ 7177],
     | 99.99th=[ 7308]
  write: IOPS=3460, BW=13.5MiB/s (14.2MB/s)(250MiB/18494msec); 0 zone resets
    slat (usec): min=9, max=842, avg=19.56, stdev=10.17
    clat (usec): min=1458, max=60483, avg=4602.45, stdev=2680.53
     lat (usec): min=1557, max=60667, avg=4622.12, stdev=2685.20
    clat percentiles (usec):
     |  1.00th=[ 2802],  5.00th=[ 2900], 10.00th=[ 2966], 20.00th=[ 3064],
     | 30.00th=[ 3163], 40.00th=[ 3261], 50.00th=[ 3458], 60.00th=[ 3752],
     | 70.00th=[ 4621], 80.00th=[ 5473], 90.00th=[ 8455], 95.00th=[10945],
     | 99.00th=[13960], 99.50th=[14615], 99.90th=[16909], 99.95th=[21890],
     | 99.99th=[57410]
   bw (  KiB/s): min= 4936, max=20424, per=99.96%, avg=13837.41, stdev=5145.65, samples=37
   iops        : min= 1234, max= 5106, avg=3459.35, stdev=1286.41, samples=37
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=71.23%, 10=24.53%, 20=4.17%, 50=0.03%
  lat (msec)   : 100=0.02%
  cpu          : usr=1.84%, sys=8.75%, ctx=103796, majf=0, minf=963
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40339,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.4MiB/s (19.3MB/s), 18.4MiB/s-18.4MiB/s (19.3MB/s-19.3MB/s), io=158MiB (165MB), run=8547-8547msec
  WRITE: bw=13.5MiB/s (14.2MB/s), 13.5MiB/s-13.5MiB/s (14.2MB/s-14.2MB/s), io=250MiB (262MB), run=18494-18494msec

Disk stats (read/write):
  loop8: ios=39457/64000, merge=0/0, ticks=133391/291634, in_queue=425025, util=99.70%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop1/testfile
+ fio fio/verify.fio --filename=/mnt/loop1/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.2%][r=19.1MiB/s][r=4881 IOPS][eta 00m:06s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3849: Tue Feb 15 12:55:18 2022
  read: IOPS=4943, BW=19.3MiB/s (20.2MB/s)(158MiB/8185msec)
    slat (usec): min=7, max=187, avg=11.01, stdev= 4.63
    clat (usec): min=201, max=8077, avg=3223.49, stdev=672.83
     lat (usec): min=237, max=8093, avg=3234.58, stdev=673.85
    clat percentiles (usec):
     |  1.00th=[ 2376],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2573],
     | 30.00th=[ 2704], 40.00th=[ 2802], 50.00th=[ 3064], 60.00th=[ 3425],
     | 70.00th=[ 3654], 80.00th=[ 3851], 90.00th=[ 4015], 95.00th=[ 4228],
     | 99.00th=[ 5276], 99.50th=[ 6128], 99.90th=[ 7439], 99.95th=[ 7701],
     | 99.99th=[ 8029]
  write: IOPS=3556, BW=13.9MiB/s (14.6MB/s)(250MiB/17997msec); 0 zone resets
    slat (usec): min=9, max=507, avg=19.54, stdev= 9.30
    clat (usec): min=1938, max=83123, avg=4478.26, stdev=2527.30
     lat (usec): min=1961, max=83160, avg=4497.92, stdev=2531.03
    clat percentiles (usec):
     |  1.00th=[ 2835],  5.00th=[ 2933], 10.00th=[ 2999], 20.00th=[ 3097],
     | 30.00th=[ 3163], 40.00th=[ 3261], 50.00th=[ 3458], 60.00th=[ 3785],
     | 70.00th=[ 4752], 80.00th=[ 5407], 90.00th=[ 6915], 95.00th=[ 9634],
     | 99.00th=[13304], 99.50th=[14091], 99.90th=[16712], 99.95th=[17957],
     | 99.99th=[81265]
   bw (  KiB/s): min= 5896, max=19408, per=99.98%, avg=14222.22, stdev=4581.54, samples=36
   iops        : min= 1474, max= 4852, avg=3555.56, stdev=1145.38, samples=36
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=72.94%, 10=24.24%, 20=2.78%, 50=0.01%
  lat (msec)   : 100=0.02%
  cpu          : usr=1.80%, sys=9.00%, ctx=104150, majf=0, minf=964
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40462,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.3MiB/s (20.2MB/s), 19.3MiB/s-19.3MiB/s (20.2MB/s-20.2MB/s), io=158MiB (166MB), run=8185-8185msec
  WRITE: bw=13.9MiB/s (14.6MB/s), 13.9MiB/s-13.9MiB/s (14.6MB/s-14.6MB/s), io=250MiB (262MB), run=17997-17997msec

Disk stats (read/write):
  loop1: ios=40293/64017, merge=0/1, ticks=129709/283917, in_queue=413649, util=99.70%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop2/testfile
+ fio fio/verify.fio --filename=/mnt/loop2/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.8%][r=18.7MiB/s][r=4778 IOPS][eta 00m:06s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3879: Tue Feb 15 12:55:45 2022
  read: IOPS=4778, BW=18.7MiB/s (19.6MB/s)(158MiB/8454msec)
    slat (usec): min=7, max=203, avg=13.36, stdev= 5.87
    clat (usec): min=211, max=7947, avg=3332.45, stdev=716.88
     lat (usec): min=252, max=7965, avg=3345.92, stdev=719.50
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2606],
     | 30.00th=[ 2737], 40.00th=[ 2966], 50.00th=[ 3326], 60.00th=[ 3621],
     | 70.00th=[ 3785], 80.00th=[ 3884], 90.00th=[ 4178], 95.00th=[ 4293],
     | 99.00th=[ 5604], 99.50th=[ 6456], 99.90th=[ 7111], 99.95th=[ 7242],
     | 99.99th=[ 7570]
  write: IOPS=3427, BW=13.4MiB/s (14.0MB/s)(250MiB/18673msec); 0 zone resets
    slat (usec): min=9, max=1784, avg=19.77, stdev=13.30
    clat (usec): min=1185, max=74491, avg=4646.90, stdev=2845.94
     lat (usec): min=1214, max=74506, avg=4666.78, stdev=2850.00
    clat percentiles (usec):
     |  1.00th=[ 2802],  5.00th=[ 2933], 10.00th=[ 2999], 20.00th=[ 3097],
     | 30.00th=[ 3195], 40.00th=[ 3326], 50.00th=[ 3523], 60.00th=[ 3982],
     | 70.00th=[ 4686], 80.00th=[ 5276], 90.00th=[ 7308], 95.00th=[11600],
     | 99.00th=[14091], 99.50th=[14877], 99.90th=[19792], 99.95th=[43254],
     | 99.99th=[73925]
   bw (  KiB/s): min= 4728, max=19848, per=98.27%, avg=13472.84, stdev=4985.35, samples=38
   iops        : min= 1182, max= 4962, avg=3368.21, stdev=1246.34, samples=38
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=69.51%, 10=25.96%, 20=4.45%, 50=0.04%
  lat (msec)   : 100=0.02%
  cpu          : usr=1.94%, sys=9.45%, ctx=103665, majf=0, minf=963
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40399,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.7MiB/s (19.6MB/s), 18.7MiB/s-18.7MiB/s (19.6MB/s-19.6MB/s), io=158MiB (165MB), run=8454-8454msec
  WRITE: bw=13.4MiB/s (14.0MB/s), 13.4MiB/s-13.4MiB/s (14.0MB/s-14.0MB/s), io=250MiB (262MB), run=18673-18673msec

Disk stats (read/write):
  loop2: ios=40252/64017, merge=0/1, ticks=133818/294832, in_queue=428682, util=99.73%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop9/testfile
+ fio fio/verify.fio --filename=/mnt/loop9/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.2%][r=19.9MiB/s][r=5094 IOPS][eta 00m:06s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3907: Tue Feb 15 12:56:12 2022
  read: IOPS=4925, BW=19.2MiB/s (20.2MB/s)(159MiB/8239msec)
    slat (usec): min=7, max=245, avg=10.61, stdev= 4.70
    clat (usec): min=195, max=68866, avg=3235.75, stdev=1698.12
     lat (usec): min=225, max=68882, avg=3246.44, stdev=1698.93
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2540],
     | 30.00th=[ 2671], 40.00th=[ 2769], 50.00th=[ 3032], 60.00th=[ 3359],
     | 70.00th=[ 3589], 80.00th=[ 3785], 90.00th=[ 3982], 95.00th=[ 4178],
     | 99.00th=[ 5669], 99.50th=[ 6390], 99.90th=[11469], 99.95th=[52167],
     | 99.99th=[66323]
  write: IOPS=3498, BW=13.7MiB/s (14.3MB/s)(250MiB/18293msec); 0 zone resets
    slat (usec): min=9, max=532, avg=19.42, stdev= 9.47
    clat (usec): min=1342, max=37045, avg=4552.37, stdev=2663.41
     lat (usec): min=1353, max=37059, avg=4571.90, stdev=2667.66
    clat percentiles (usec):
     |  1.00th=[ 2835],  5.00th=[ 2933], 10.00th=[ 2999], 20.00th=[ 3097],
     | 30.00th=[ 3163], 40.00th=[ 3228], 50.00th=[ 3425], 60.00th=[ 3687],
     | 70.00th=[ 4359], 80.00th=[ 5211], 90.00th=[ 7832], 95.00th=[11469],
     | 99.00th=[13960], 99.50th=[14484], 99.90th=[18744], 99.95th=[27132],
     | 99.99th=[35914]
   bw (  KiB/s): min= 5208, max=19848, per=98.88%, avg=13837.84, stdev=5211.78, samples=37
   iops        : min= 1302, max= 4962, avg=3459.46, stdev=1302.95, samples=37
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.02%, 4=74.95%, 10=20.36%, 20=4.59%, 50=0.05%
  lat (msec)   : 100=0.03%
  cpu          : usr=1.81%, sys=8.68%, ctx=103980, majf=0, minf=968
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40582,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.2MiB/s (20.2MB/s), 19.2MiB/s-19.2MiB/s (20.2MB/s-20.2MB/s), io=159MiB (166MB), run=8239-8239msec
  WRITE: bw=13.7MiB/s (14.3MB/s), 13.7MiB/s-13.7MiB/s (14.3MB/s-14.3MB/s), io=250MiB (262MB), run=18293-18293msec

Disk stats (read/write):
  loop9: ios=39401/64033, merge=0/1, ticks=127854/288524, in_queue=416410, util=99.71%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop3/testfile
+ fio fio/verify.fio --filename=/mnt/loop3/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.2%][r=18.3MiB/s][r=4693 IOPS][eta 00m:06s]                 
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3959: Tue Feb 15 12:56:39 2022
  read: IOPS=4763, BW=18.6MiB/s (19.5MB/s)(158MiB/8515msec)
    slat (usec): min=7, max=219, avg=12.04, stdev= 5.40
    clat (usec): min=308, max=56523, avg=3344.25, stdev=1461.98
     lat (usec): min=359, max=56543, avg=3356.41, stdev=1462.92
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2474], 10.00th=[ 2540], 20.00th=[ 2638],
     | 30.00th=[ 2737], 40.00th=[ 2933], 50.00th=[ 3294], 60.00th=[ 3556],
     | 70.00th=[ 3752], 80.00th=[ 3851], 90.00th=[ 4146], 95.00th=[ 4293],
     | 99.00th=[ 5997], 99.50th=[ 6652], 99.90th=[ 9110], 99.95th=[44303],
     | 99.99th=[55313]
  write: IOPS=3590, BW=14.0MiB/s (14.7MB/s)(250MiB/17823msec); 0 zone resets
    slat (usec): min=9, max=486, avg=19.20, stdev= 9.18
    clat (usec): min=1254, max=54452, avg=4434.97, stdev=2561.25
     lat (usec): min=1300, max=54466, avg=4454.31, stdev=2565.16
    clat percentiles (usec):
     |  1.00th=[ 2835],  5.00th=[ 2966], 10.00th=[ 2999], 20.00th=[ 3097],
     | 30.00th=[ 3163], 40.00th=[ 3228], 50.00th=[ 3392], 60.00th=[ 3589],
     | 70.00th=[ 4359], 80.00th=[ 5211], 90.00th=[ 6456], 95.00th=[10683],
     | 99.00th=[13960], 99.50th=[14615], 99.90th=[17433], 99.95th=[31065],
     | 99.99th=[54264]
   bw (  KiB/s): min= 4768, max=20432, per=99.02%, avg=14222.22, stdev=5045.75, samples=36
   iops        : min= 1192, max= 5108, avg=3555.56, stdev=1261.44, samples=36
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=74.23%, 10=22.15%, 20=3.54%, 50=0.05%
  lat (msec)   : 100=0.03%
  cpu          : usr=1.90%, sys=9.15%, ctx=104152, majf=0, minf=967
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40563,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.6MiB/s (19.5MB/s), 18.6MiB/s-18.6MiB/s (19.5MB/s-19.5MB/s), io=158MiB (166MB), run=8515-8515msec
  WRITE: bw=14.0MiB/s (14.7MB/s), 14.0MiB/s-14.0MiB/s (14.7MB/s-14.7MB/s), io=250MiB (262MB), run=17823-17823msec

Disk stats (read/write):
  loop3: ios=40375/64034, merge=0/1, ticks=134695/281516, in_queue=416260, util=99.70%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop10/testfile
+ fio fio/verify.fio --filename=/mnt/loop10/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.8%][r=18.3MiB/s][r=4695 IOPS][eta 00m:06s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3980: Tue Feb 15 12:57:06 2022
  read: IOPS=4812, BW=18.8MiB/s (19.7MB/s)(158MiB/8395msec)
    slat (usec): min=7, max=216, avg=11.48, stdev= 5.24
    clat (usec): min=208, max=59072, avg=3311.11, stdev=1320.91
     lat (usec): min=235, max=59081, avg=3322.68, stdev=1321.70
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2638],
     | 30.00th=[ 2704], 40.00th=[ 2835], 50.00th=[ 3163], 60.00th=[ 3556],
     | 70.00th=[ 3752], 80.00th=[ 3884], 90.00th=[ 4113], 95.00th=[ 4293],
     | 99.00th=[ 5997], 99.50th=[ 6521], 99.90th=[ 9241], 99.95th=[20055],
     | 99.99th=[58459]
  write: IOPS=3429, BW=13.4MiB/s (14.0MB/s)(250MiB/18659msec); 0 zone resets
    slat (usec): min=9, max=489, avg=19.18, stdev= 9.32
    clat (usec): min=1272, max=75630, avg=4644.09, stdev=2864.34
     lat (usec): min=1314, max=75654, avg=4663.38, stdev=2868.47
    clat percentiles (usec):
     |  1.00th=[ 2835],  5.00th=[ 2933], 10.00th=[ 2999], 20.00th=[ 3097],
     | 30.00th=[ 3163], 40.00th=[ 3261], 50.00th=[ 3425], 60.00th=[ 3851],
     | 70.00th=[ 4752], 80.00th=[ 5473], 90.00th=[ 8029], 95.00th=[11469],
     | 99.00th=[13960], 99.50th=[14877], 99.90th=[23987], 99.95th=[33162],
     | 99.99th=[74974]
   bw (  KiB/s): min= 5136, max=20600, per=98.20%, avg=13473.68, stdev=5123.48, samples=38
   iops        : min= 1284, max= 5150, avg=3368.42, stdev=1280.87, samples=38
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.03%, 4=71.53%, 10=23.79%, 20=4.56%, 50=0.05%
  lat (msec)   : 100=0.03%
  cpu          : usr=1.85%, sys=8.46%, ctx=103833, majf=0, minf=964
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40400,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.8MiB/s (19.7MB/s), 18.8MiB/s-18.8MiB/s (19.7MB/s-19.7MB/s), io=158MiB (165MB), run=8395-8395msec
  WRITE: bw=13.4MiB/s (14.0MB/s), 13.4MiB/s-13.4MiB/s (14.0MB/s-14.0MB/s), io=250MiB (262MB), run=18659-18659msec

Disk stats (read/write):
  loop10: ios=40344/64034, merge=0/1, ticks=133338/294863, in_queue=428249, util=99.72%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop4/testfile
+ fio fio/verify.fio --filename=/mnt/loop4/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.8%][r=17.9MiB/s][r=4577 IOPS][eta 00m:06s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3998: Tue Feb 15 12:57:34 2022
  read: IOPS=4649, BW=18.2MiB/s (19.0MB/s)(158MiB/8690msec)
    slat (usec): min=7, max=238, avg=11.84, stdev= 5.30
    clat (usec): min=319, max=37645, avg=3427.20, stdev=978.28
     lat (usec): min=372, max=37660, avg=3439.13, stdev=979.21
    clat percentiles (usec):
     |  1.00th=[ 2409],  5.00th=[ 2507], 10.00th=[ 2606], 20.00th=[ 2737],
     | 30.00th=[ 2835], 40.00th=[ 3097], 50.00th=[ 3458], 60.00th=[ 3720],
     | 70.00th=[ 3818], 80.00th=[ 3916], 90.00th=[ 4178], 95.00th=[ 4359],
     | 99.00th=[ 6128], 99.50th=[ 6849], 99.90th=[ 7635], 99.95th=[ 8029],
     | 99.99th=[37487]
  write: IOPS=3477, BW=13.6MiB/s (14.2MB/s)(250MiB/18402msec); 0 zone resets
    slat (usec): min=9, max=503, avg=19.01, stdev= 8.74
    clat (usec): min=1137, max=72366, avg=4580.01, stdev=2709.13
     lat (usec): min=1256, max=72386, avg=4599.13, stdev=2712.38
    clat percentiles (usec):
     |  1.00th=[ 2802],  5.00th=[ 2933], 10.00th=[ 2999], 20.00th=[ 3064],
     | 30.00th=[ 3163], 40.00th=[ 3261], 50.00th=[ 3490], 60.00th=[ 3916],
     | 70.00th=[ 4686], 80.00th=[ 5276], 90.00th=[ 7373], 95.00th=[11469],
     | 99.00th=[13829], 99.50th=[14484], 99.90th=[15926], 99.95th=[16712],
     | 99.99th=[71828]
   bw (  KiB/s): min= 4832, max=19768, per=99.46%, avg=13837.84, stdev=4836.00, samples=37
   iops        : min= 1208, max= 4942, avg=3459.46, stdev=1209.00, samples=37
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.03%, 4=69.87%, 10=25.76%, 20=4.30%, 50=0.02%
  lat (msec)   : 100=0.02%
  cpu          : usr=1.87%, sys=8.59%, ctx=103458, majf=0, minf=963
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40402,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=18.2MiB/s (19.0MB/s), 18.2MiB/s-18.2MiB/s (19.0MB/s-19.0MB/s), io=158MiB (165MB), run=8690-8690msec
  WRITE: bw=13.6MiB/s (14.2MB/s), 13.6MiB/s-13.6MiB/s (14.2MB/s-14.2MB/s), io=250MiB (262MB), run=18402-18402msec

Disk stats (read/write):
  loop4: ios=39421/64024, merge=0/1, ticks=134529/290360, in_queue=424895, util=99.72%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop5/testfile
+ fio fio/verify.fio --filename=/mnt/loop5/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][78.8%][r=21.9MiB/s][r=5605 IOPS][eta 00m:07s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4018: Tue Feb 15 12:58:01 2022
  read: IOPS=4872, BW=19.0MiB/s (20.0MB/s)(158MiB/8313msec)
    slat (usec): min=7, max=228, avg=11.50, stdev= 6.11
    clat (usec): min=206, max=16991, avg=3270.43, stdev=729.51
     lat (usec): min=236, max=17000, avg=3282.02, stdev=730.70
    clat percentiles (usec):
     |  1.00th=[ 2376],  5.00th=[ 2442], 10.00th=[ 2507], 20.00th=[ 2573],
     | 30.00th=[ 2704], 40.00th=[ 2933], 50.00th=[ 3261], 60.00th=[ 3523],
     | 70.00th=[ 3687], 80.00th=[ 3818], 90.00th=[ 4047], 95.00th=[ 4228],
     | 99.00th=[ 5932], 99.50th=[ 6521], 99.90th=[ 6980], 99.95th=[ 7832],
     | 99.99th=[14877]
  write: IOPS=3511, BW=13.7MiB/s (14.4MB/s)(250MiB/18228msec); 0 zone resets
    slat (usec): min=9, max=511, avg=19.07, stdev= 9.42
    clat (usec): min=2103, max=68064, avg=4536.64, stdev=2739.21
     lat (usec): min=2150, max=68099, avg=4555.82, stdev=2743.73
    clat percentiles (usec):
     |  1.00th=[ 2737],  5.00th=[ 2868], 10.00th=[ 2933], 20.00th=[ 3032],
     | 30.00th=[ 3130], 40.00th=[ 3228], 50.00th=[ 3326], 60.00th=[ 3654],
     | 70.00th=[ 4621], 80.00th=[ 5342], 90.00th=[ 7832], 95.00th=[11207],
     | 99.00th=[13829], 99.50th=[14746], 99.90th=[18220], 99.95th=[30016],
     | 99.99th=[65799]
   bw (  KiB/s): min= 4944, max=20792, per=98.52%, avg=13837.84, stdev=5345.91, samples=37
   iops        : min= 1236, max= 5198, avg=3459.46, stdev=1336.48, samples=37
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=74.03%, 10=21.73%, 20=4.16%, 50=0.04%
  lat (msec)   : 100=0.01%
  cpu          : usr=1.73%, sys=8.94%, ctx=103415, majf=0, minf=965
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=40503,64000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.0MiB/s (20.0MB/s), 19.0MiB/s-19.0MiB/s (20.0MB/s-20.0MB/s), io=158MiB (166MB), run=8313-8313msec
  WRITE: bw=13.7MiB/s (14.4MB/s), 13.7MiB/s-13.7MiB/s (14.4MB/s-14.4MB/s), io=250MiB (262MB), run=18228-18228msec

Disk stats (read/write):
  loop5: ios=39085/64000, merge=0/0, ticks=128427/287510, in_queue=415937, util=99.71%
+ df -h /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      2.0G  548M  1.5G  27% /mnt/loop1
/dev/loop10     2.0G  548M  1.5G  27% /mnt/loop10
/dev/loop2      2.0G  548M  1.5G  27% /mnt/loop2
/dev/loop3      2.0G  548M  1.5G  27% /mnt/loop3
/dev/loop4      2.0G  548M  1.5G  27% /mnt/loop4
/dev/loop5      2.0G  548M  1.5G  27% /mnt/loop5
/dev/loop6      2.0G  548M  1.5G  27% /mnt/loop6
/dev/loop7      2.0G  548M  1.5G  27% /mnt/loop7
/dev/loop8      2.0G  548M  1.5G  27% /mnt/loop8
/dev/loop9      2.0G  548M  1.5G  27% /mnt/loop9
+ unload_loop
++ shuf -i 1-10 -n 10
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
+ umount /mnt/loop10
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop5
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop1
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop6
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop2
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop3
+ rm -fr ./loop3
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
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop10
+ rm -fr /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
+ dmesg -c
[  456.209665] XFS (loop9): Unmounting Filesystem
[  456.333663] XFS (loop4): Unmounting Filesystem
[  456.469664] XFS (loop7): Unmounting Filesystem
[  456.597736] XFS (loop10): Unmounting Filesystem
[  456.729668] XFS (loop5): Unmounting Filesystem
[  456.858646] XFS (loop1): Unmounting Filesystem
[  456.993723] XFS (loop6): Unmounting Filesystem
[  457.114716] XFS (loop2): Unmounting Filesystem
[  457.235711] XFS (loop3): Unmounting Filesystem
[  457.360641] XFS (loop8): Unmounting Filesystem
+ dmesg -c

* Test huge value for the hw_queue_depth module param:-

for i in `seq 1 32`;do depth=`echo 2^${i}|bc`; echo "------------------------------------";echo "modprobe loop hw_queue_depth=${depth}" ;modprobe loop hw_queue_depth=${depth}; dmesg -c ; modprobe -r loop; done 
------------------------------------
modprobe loop hw_queue_depth=2
[ 1637.905605] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=4
[ 1638.077261] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=8
[ 1638.251812] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=16
[ 1638.431560] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=32
[ 1638.604985] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=64
[ 1638.782457] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=128
[ 1638.975905] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=256
[ 1639.158885] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=512
[ 1639.350887] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=1024
[ 1639.528603] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=2048
[ 1639.713119] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=4096
[ 1639.912199] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=8192
[ 1640.099533] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=16384
[ 1640.248658] blk-mq: reduced tag depth to 10240
[ 1640.255557] blk-mq: reduced tag depth to 10240
[ 1640.262469] blk-mq: reduced tag depth to 10240
[ 1640.269514] blk-mq: reduced tag depth to 10240
[ 1640.276446] blk-mq: reduced tag depth to 10240
[ 1640.283051] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=32768
[ 1640.425876] blk-mq: reduced tag depth to 10240
[ 1640.432965] blk-mq: reduced tag depth to 10240
[ 1640.440087] blk-mq: reduced tag depth to 10240
[ 1640.447152] blk-mq: reduced tag depth to 10240
[ 1640.454045] blk-mq: reduced tag depth to 10240
[ 1640.460847] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=65536
[ 1640.592307] blk-mq: reduced tag depth to 10240
[ 1640.599937] blk-mq: reduced tag depth to 10240
[ 1640.607501] blk-mq: reduced tag depth to 10240
[ 1640.614982] blk-mq: reduced tag depth to 10240
[ 1640.622431] blk-mq: reduced tag depth to 10240
[ 1640.629722] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=131072
[ 1640.771094] blk-mq: reduced tag depth to 10240
[ 1640.778259] blk-mq: reduced tag depth to 10240
[ 1640.785261] blk-mq: reduced tag depth to 10240
[ 1640.792321] blk-mq: reduced tag depth to 10240
[ 1640.799506] blk-mq: reduced tag depth to 10240
[ 1640.806317] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=262144
[ 1640.954736] blk-mq: reduced tag depth to 10240
[ 1640.962317] blk-mq: reduced tag depth to 10240
[ 1640.969650] blk-mq: reduced tag depth to 10240
[ 1640.977074] blk-mq: reduced tag depth to 10240
[ 1640.984205] blk-mq: reduced tag depth to 10240
[ 1640.990996] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=524288
[ 1641.136413] blk-mq: reduced tag depth to 10240
[ 1641.143446] blk-mq: reduced tag depth to 10240
[ 1641.150543] blk-mq: reduced tag depth to 10240
[ 1641.157581] blk-mq: reduced tag depth to 10240
[ 1641.164707] blk-mq: reduced tag depth to 10240
[ 1641.171526] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=1048576
[ 1641.329604] blk-mq: reduced tag depth to 10240
[ 1641.336720] blk-mq: reduced tag depth to 10240
[ 1641.343774] blk-mq: reduced tag depth to 10240
[ 1641.350826] blk-mq: reduced tag depth to 10240
[ 1641.357844] blk-mq: reduced tag depth to 10240
[ 1641.364706] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=2097152
[ 1641.508727] blk-mq: reduced tag depth to 10240
[ 1641.515761] blk-mq: reduced tag depth to 10240
[ 1641.522757] blk-mq: reduced tag depth to 10240
[ 1641.529689] blk-mq: reduced tag depth to 10240
[ 1641.536608] blk-mq: reduced tag depth to 10240
[ 1641.543375] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=4194304
[ 1641.698598] blk-mq: reduced tag depth to 10240
[ 1641.705752] blk-mq: reduced tag depth to 10240
[ 1641.712900] blk-mq: reduced tag depth to 10240
[ 1641.719879] blk-mq: reduced tag depth to 10240
[ 1641.726931] blk-mq: reduced tag depth to 10240
[ 1641.733727] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=8388608
[ 1641.876095] blk-mq: reduced tag depth to 10240
[ 1641.883004] blk-mq: reduced tag depth to 10240
[ 1641.890159] blk-mq: reduced tag depth to 10240
[ 1641.897117] blk-mq: reduced tag depth to 10240
[ 1641.904067] blk-mq: reduced tag depth to 10240
[ 1641.910864] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=16777216
[ 1642.041044] blk-mq: reduced tag depth to 10240
[ 1642.048670] blk-mq: reduced tag depth to 10240
[ 1642.055810] blk-mq: reduced tag depth to 10240
[ 1642.062959] blk-mq: reduced tag depth to 10240
[ 1642.070100] blk-mq: reduced tag depth to 10240
[ 1642.077033] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=33554432
[ 1642.214993] blk-mq: reduced tag depth to 10240
[ 1642.222289] blk-mq: reduced tag depth to 10240
[ 1642.229563] blk-mq: reduced tag depth to 10240
[ 1642.236746] blk-mq: reduced tag depth to 10240
[ 1642.243956] blk-mq: reduced tag depth to 10240
[ 1642.250764] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=67108864
[ 1642.382283] blk-mq: reduced tag depth to 10240
[ 1642.389452] blk-mq: reduced tag depth to 10240
[ 1642.396639] blk-mq: reduced tag depth to 10240
[ 1642.403823] blk-mq: reduced tag depth to 10240
[ 1642.410976] blk-mq: reduced tag depth to 10240
[ 1642.417925] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=134217728
[ 1642.546158] blk-mq: reduced tag depth to 10240
[ 1642.553431] blk-mq: reduced tag depth to 10240
[ 1642.560563] blk-mq: reduced tag depth to 10240
[ 1642.567618] blk-mq: reduced tag depth to 10240
[ 1642.574691] blk-mq: reduced tag depth to 10240
[ 1642.581591] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=268435456
[ 1642.713767] blk-mq: reduced tag depth to 10240
[ 1642.721264] blk-mq: reduced tag depth to 10240
[ 1642.728443] blk-mq: reduced tag depth to 10240
[ 1642.735465] blk-mq: reduced tag depth to 10240
[ 1642.742415] blk-mq: reduced tag depth to 10240
[ 1642.749413] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=536870912
[ 1642.877780] blk-mq: reduced tag depth to 10240
[ 1642.885137] blk-mq: reduced tag depth to 10240
[ 1642.892257] blk-mq: reduced tag depth to 10240
[ 1642.899312] blk-mq: reduced tag depth to 10240
[ 1642.906441] blk-mq: reduced tag depth to 10240
[ 1642.912813] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=1073741824
[ 1643.061239] blk-mq: reduced tag depth to 10240
[ 1643.069120] blk-mq: reduced tag depth to 10240
[ 1643.076770] blk-mq: reduced tag depth to 10240
[ 1643.084382] blk-mq: reduced tag depth to 10240
[ 1643.091630] blk-mq: reduced tag depth to 10240
[ 1643.098358] loop: module loaded
------------------------------------
modprobe loop hw_queue_depth=2147483648
modprobe: ERROR: could not insert 'loop': Invalid argument
[ 1643.245395] loop: `2147483648' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe loop hw_queue_depth=4294967296
modprobe: ERROR: could not insert 'loop': Invalid argument
[ 1643.317319] loop: `4294967296' invalid for parameter `hw_queue_depth'

-- 
2.29.0

