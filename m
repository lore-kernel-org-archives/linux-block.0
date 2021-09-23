Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961BB6115A
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbhIWBv2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:51:28 -0400
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:12001
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238177AbhIWBv1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:51:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM7/42IKowcUsOpFVzPJqvhA/6rG68/4+aKGy14tz7Jn5ZjnTWCaL6SvdcUCi0cJAiZyuGLUVy0e5Dwhv0zBfaXLVloxtcuMsasC37yR1LgukN1Jbj2TIW9EFxXZ2e7/Nllsv8NTyYj7XZA9O9nLQAeTkTKKW0ZGcTKIo03m4CWcCMWH1fOdiKwZOdTInkwE4gnR/rCX/pNqdR42iXO+2b4dvMhTXqG77vl6gwvqWl289hW8xDJWgCagNZ9dP6gPo3B8TcCmTX/qp85nf9X7o4BZ4Q0Xy4WUBr6P+ENwVicNHD+eGJCg8MhUVEgEamnmpCKh8Jc4DqnDTM2yHm08xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RyoMHqXXQ1Zl6wmVUMpW5I5aPcK2pGqzOQt/0O90yi8=;
 b=i6Vvj2qE0LevulIV/LtFzYW4X0dG79kmPTCOcuEr0yEACn/jeAdKbxGak78qzpg1tjf0vhdVB1/PVAtlEZ9lMt2Czk5hsw1v7Wsy8o7+b0XTzSG4DRM9iFQT/Qa1gnF4Uj0qa3IPPy+/RmhJEgrNQ5pYlwE5GUEdPLXe7zK9VlRDbTrsn+85QhtRsj2sXeu4ESdW1p23wv/yI87A0qJq846NpJjarJ9ZsFWgbPLxfQ2bRAzJO+5PDE2PQ0dRLXzGdjDljzoVzqi+/Ou3viHWFVm8ue/09B+li7Q749D4X1AxCsAyrDEIGB50dH/tTYMabktSPcgCmS2Hg1YU9nzRhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyoMHqXXQ1Zl6wmVUMpW5I5aPcK2pGqzOQt/0O90yi8=;
 b=sAJi74q3QqTuQic+Y7D8pSwR+Xt3HD1UlukXfJDKGpCMQNztwfXSFU3umG9SvCAZL6NmGFcaaRUNuLz64ylZjEwQktx8uiZVFFeoklO9pGpVqMpIcCRGpKJZQvZHSo/mTNYF/VB87RG5m7ZM76sWoGX1UwBjnOr6WWUoPTo+W+pIvewzfr/qVG8sa9OOCP2px4YbPdbwAd6/1eqqZytNEvxtnfUOamM/TCGuz13MQ3uiMEJnzLGa4wfKK78o+q06QW9UU9C7/UkV0FZ7kuiFlt4q1zcy7mpYQ//0d+QKxLcJZykjo+Zqfk6V4Lk88BJsit38L1DggKMjpZ7QwkITMw==
Received: from DS7PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:3b8::34)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 01:49:53 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::58) by DS7PR03CA0029.outlook.office365.com
 (2603:10b6:5:3b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 01:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 01:49:52 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:49:52 +0000
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:49:51 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 0/8] loop: small clenaup
Date:   Wed, 22 Sep 2021 18:49:37 -0700
Message-ID: <20210923014945.6229-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ed6691c-fa93-41a8-6482-08d97e346fc5
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5410963C1E62D765E6FE1590A3A39@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsLQi905cdr88JKkp2xqLb1YRjH7+8lAISMrq8EGrrQiFzrcIb/4DgIhU7c9k55OFzBNdcaniAS5F4w5I57J8203Yj4Cr63KJcCTX6m9hxO7cPkIRh+qDUqOc6Hn2Zkp58SjJGK8Yr+nNN0q4XXPQb52gAaFqFSCComItqsHbnPSGfcfENykasEu7sg9pWATeoFqHZ2u0hJl6I4bRHLRc7jWiVJB2n/tyVZObmYl9TH2ygC1MuObUi+faY99A0gviFYtCymWByUWnlgAODp+sDre6fbaSwF+Tgi5jcGkEQwGZUKxeT3rLVDAqWc+FOu3GVHD04rV3iSf0NMdlTK5PQlRbnUjecwrIODqm/J+PMI6c7oUsoSWXoVTBakh/9Jub8eCk/ks0lVeH+LVbnhJFIDYKHNtdZNUZS+CbG+dUsbMkjFM9GFLGxIKr+Ar2jKewl5bsIAH20hgjW45YnkUVfKGCqbm/ti1D5KIYxPzr8ffbb1IIhepD90/lfM99jvXvup9mPoUnyRLlIVvtL7AbxAA2HeH3GRku3ISUlekj9ELcpDxVFtOzx543yyyiEYeBTpXh3zGHlO3tHauRCWhRcv5ltOD6UeoioqsuIVefMHIZJRFB4Y13z6BJozxibxe6O78U00nKh64wViO4/6/yrxHv1cktaamhZeAglMBK7zJFG9sYyOYmwv4F/Bm8mkLYv0HtPxmeALOt+de0yL34A==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(336012)(426003)(36906005)(82310400003)(16526019)(508600001)(30864003)(2616005)(7636003)(107886003)(6916009)(8936002)(356005)(8676002)(5660300002)(186003)(47076005)(1076003)(86362001)(4326008)(2906002)(26005)(70586007)(7696005)(83380400001)(36860700001)(19627235002)(70206006)(6666004)(36756003)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 01:49:52.7132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed6691c-fa93-41a8-6482-08d97e346fc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

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

root@dev loop-sysfs-emit (for-next) # grep err= 0000-cover-letter.patch
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3402: Wed Sep 22 18:34:50 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3680: Wed Sep 22 18:35:41 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3742: Wed Sep 22 18:36:33 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3783: Wed Sep 22 18:37:25 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3807: Wed Sep 22 18:38:16 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3865: Wed Sep 22 18:39:06 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3892: Wed Sep 22 18:39:56 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3952: Wed Sep 22 18:40:47 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4059: Wed Sep 22 18:41:41 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4079: Wed Sep 22 18:42:49 2021
root@dev loop-sysfs-emit (for-next) #

* Changes from V1:-
1. Update commit log.
2. Add reviewed-by tags.

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

 # ./compile_loop.sh 10 
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
+ umount /mnt/loop6
umount: /mnt/loop6: no mount point specified.
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop8
umount: /mnt/loop8: no mount point specified.
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop2
umount: /mnt/loop2: no mount point specified.
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop1
umount: /mnt/loop1: no mount point specified.
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop3
umount: /mnt/loop3: no mount point specified.
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop4
umount: /mnt/loop4: no mount point specified.
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop9
umount: /mnt/loop9: no mount point specified.
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop5
umount: /mnt/loop5: no mount point specified.
+ rm -fr ./loop5
+ losetup -D
+ sleep 3
+ rmmod loop
rmmod: ERROR: Module loop is not currently loaded
+ modprobe -r loop
+ lsmod
+ grep loop
++ shuf -i 1-10 -n 10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop2
+ rm -fr '/mnt/loop*'
+ compile_loop
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/loop.o
  MODPOST drivers/block/Module.symvers
  LD [M]  drivers/block/loop.ko
+ HOST=drivers/block/
++ uname -r
+ HOST_DEST=/lib/modules/5.15.0-rc1blk-next+/kernel/drivers/block
+ cp drivers/block//loop.ko /lib/modules/5.15.0-rc1blk-next+/kernel/drivers/block/
+ load_loop
+ insmod drivers/block/loop.ko max_loop=11 hw_queue_depth=32
++ shuf -i 1-10 -n 10
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop3
+ truncate -s 2048M ./loop3
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop3 ./loop3
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
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
+ mkdir -p /mnt/loop5
+ truncate -s 2048M ./loop5
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop5 ./loop5
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
/dev/loop3         0      0         0  0 /mnt/data/linux-block/loop3   1     512
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
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
/dev/loop3         0      0         0  0 /mnt/data/linux-block/loop3   1     512
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
+ mkdir -p /mnt/loop1
+ truncate -s 2048M ./loop1
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop1 ./loop1
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
/dev/loop3         0      0         0  0 /mnt/data/linux-block/loop3   1     512
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
+ mkdir -p /mnt/loop6
+ truncate -s 2048M ./loop6
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop6 ./loop6
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop6         0      0         0  0 /mnt/data/linux-block/loop6   1     512
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
+ mkdir -p /mnt/loop7
+ truncate -s 2048M ./loop7
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop7 ./loop7
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop6         0      0         0  0 /mnt/data/linux-block/loop6   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
/dev/loop3         0      0         0  0 /mnt/data/linux-block/loop3   1     512
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
+ mkdir -p /mnt/loop9
+ truncate -s 2048M ./loop9
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop9 ./loop9
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop6         0      0         0  0 /mnt/data/linux-block/loop6   1     512
/dev/loop9         0      0         0  0 /mnt/data/linux-block/loop9   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
/dev/loop3         0      0         0  0 /mnt/data/linux-block/loop3   1     512
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
/dev/loop8          0      0         0  0 /mnt/data/linux-block/loop8    1     512
/dev/loop6          0      0         0  0 /mnt/data/linux-block/loop6    1     512
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
/dev/loop9          0      0         0  0 /mnt/data/linux-block/loop9    1     512
/dev/loop7          0      0         0  0 /mnt/data/linux-block/loop7    1     512
/dev/loop5          0      0         0  0 /mnt/data/linux-block/loop5    1     512
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
+ mkdir -p /mnt/loop2
+ truncate -s 2048M ./loop2
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop2 ./loop2
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
+ mount
+ grep loop
/dev/loop3 on /mnt/loop3 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop5 on /mnt/loop5 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop8 on /mnt/loop8 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop1 on /mnt/loop1 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop6 on /mnt/loop6 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop7 on /mnt/loop7 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop9 on /mnt/loop9 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop10 on /mnt/loop10 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop4 on /mnt/loop4 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop2 on /mnt/loop2 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
+ dmesg -c
[  393.458294] loop: loading out-of-tree module taints kernel.
[  393.540886] loop: module loaded
[  393.620402] loop3: detected capacity change from 0 to 4194304
[  394.829398] XFS (loop3): Mounting V5 Filesystem
[  394.842638] XFS (loop3): Ending clean mount
[  394.847922] xfs filesystem being mounted at /mnt/loop3 supports timestamps until 2038 (0x7fffffff)
[  394.934725] loop5: detected capacity change from 0 to 4194304
[  396.106115] XFS (loop5): Mounting V5 Filesystem
[  396.119749] XFS (loop5): Ending clean mount
[  396.125172] xfs filesystem being mounted at /mnt/loop5 supports timestamps until 2038 (0x7fffffff)
[  396.208703] loop8: detected capacity change from 0 to 4194304
[  397.396155] XFS (loop8): Mounting V5 Filesystem
[  397.410363] XFS (loop8): Ending clean mount
[  397.415509] xfs filesystem being mounted at /mnt/loop8 supports timestamps until 2038 (0x7fffffff)
[  397.501311] loop1: detected capacity change from 0 to 4194304
[  398.688110] XFS (loop1): Mounting V5 Filesystem
[  398.699181] XFS (loop1): Ending clean mount
[  398.703940] xfs filesystem being mounted at /mnt/loop1 supports timestamps until 2038 (0x7fffffff)
[  398.788759] loop6: detected capacity change from 0 to 4194304
[  399.973379] XFS (loop6): Mounting V5 Filesystem
[  399.988682] XFS (loop6): Ending clean mount
[  399.993727] xfs filesystem being mounted at /mnt/loop6 supports timestamps until 2038 (0x7fffffff)
[  400.079434] loop7: detected capacity change from 0 to 4194304
[  401.250967] XFS (loop7): Mounting V5 Filesystem
[  401.270141] XFS (loop7): Ending clean mount
[  401.276262] xfs filesystem being mounted at /mnt/loop7 supports timestamps until 2038 (0x7fffffff)
[  401.365259] loop9: detected capacity change from 0 to 4194304
[  402.553512] XFS (loop9): Mounting V5 Filesystem
[  402.568126] XFS (loop9): Ending clean mount
[  402.573195] xfs filesystem being mounted at /mnt/loop9 supports timestamps until 2038 (0x7fffffff)
[  402.659757] loop10: detected capacity change from 0 to 4194304
[  403.837513] XFS (loop10): Mounting V5 Filesystem
[  403.851346] XFS (loop10): Ending clean mount
[  403.856538] xfs filesystem being mounted at /mnt/loop10 supports timestamps until 2038 (0x7fffffff)
[  403.941934] loop4: detected capacity change from 0 to 4194304
[  405.140678] XFS (loop4): Mounting V5 Filesystem
[  405.155299] XFS (loop4): Ending clean mount
[  405.161178] xfs filesystem being mounted at /mnt/loop4 supports timestamps until 2038 (0x7fffffff)
[  405.241040] loop2: detected capacity change from 0 to 4194304
[  406.421351] XFS (loop2): Mounting V5 Filesystem
[  406.435965] XFS (loop2): Ending clean mount
[  406.441333] xfs filesystem being mounted at /mnt/loop2 supports timestamps until 2038 (0x7fffffff)
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
+ fallocate -o 0 -l 524288000 /mnt/loop6/testfile
+ fio fio/verify.fio --filename=/mnt/loop6/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][82.3%][r=21.1MiB/s][r=5408 IOPS][eta 00m:11s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3402: Wed Sep 22 18:34:50 2021
  read: IOPS=5070, BW=19.8MiB/s (20.8MB/s)(316MiB/15977msec)
    slat (usec): min=7, max=176, avg= 9.06, stdev= 4.59
    clat (usec): min=337, max=7371, avg=3144.59, stdev=533.23
     lat (usec): min=387, max=7379, avg=3153.75, stdev=533.19
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2311], 10.00th=[ 2343], 20.00th=[ 2769],
     | 30.00th=[ 3032], 40.00th=[ 3163], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3261], 80.00th=[ 3425], 90.00th=[ 3621], 95.00th=[ 3720],
     | 99.00th=[ 5735], 99.50th=[ 6128], 99.90th=[ 6652], 99.95th=[ 6783],
     | 99.99th=[ 7242]
  write: IOPS=3651, BW=14.3MiB/s (15.0MB/s)(500MiB/35055msec); 0 zone resets
    slat (usec): min=9, max=1339, avg=25.07, stdev=10.18
    clat (usec): min=855, max=92115, avg=4355.14, stdev=1660.56
     lat (usec): min=886, max=92137, avg=4380.40, stdev=1661.03
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2507], 10.00th=[ 2737], 20.00th=[ 3556],
     | 30.00th=[ 4047], 40.00th=[ 4293], 50.00th=[ 4424], 60.00th=[ 4621],
     | 70.00th=[ 4817], 80.00th=[ 5014], 90.00th=[ 5342], 95.00th=[ 5604],
     | 99.00th=[ 7570], 99.50th=[ 8160], 99.90th=[14746], 99.95th=[29492],
     | 99.99th=[90702]
   bw (  KiB/s): min=  552, max=18072, per=98.74%, avg=14422.54, stdev=2180.44, samples=71
   iops        : min=  138, max= 4518, avg=3605.63, stdev=545.11, samples=71
  lat (usec)   : 500=0.01%, 1000=0.01%
  lat (msec)   : 2=0.15%, 4=55.33%, 10=44.39%, 20=0.08%, 50=0.04%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.66%, sys=9.36%, ctx=201397, majf=0, minf=1915
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=81011,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.8MiB/s (20.8MB/s), 19.8MiB/s-19.8MiB/s (20.8MB/s-20.8MB/s), io=316MiB (332MB), run=15977-15977msec
  WRITE: bw=14.3MiB/s (15.0MB/s), 14.3MiB/s-14.3MiB/s (15.0MB/s-15.0MB/s), io=500MiB (524MB), run=35055-35055msec

Disk stats (read/write):
  loop6: ios=80080/128129, merge=0/1, ticks=251747/552688, in_queue=804671, util=99.82%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop5/testfile
+ fio fio/verify.fio --filename=/mnt/loop5/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][82.5%][r=19.3MiB/s][r=4930 IOPS][eta 00m:11s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3680: Wed Sep 22 18:35:41 2021
  read: IOPS=5023, BW=19.6MiB/s (20.6MB/s)(316MiB/16086msec)
    slat (usec): min=7, max=186, avg= 9.33, stdev= 4.56
    clat (usec): min=341, max=35583, avg=3174.20, stdev=661.43
     lat (usec): min=386, max=35591, avg=3183.62, stdev=661.41
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2343], 10.00th=[ 2376], 20.00th=[ 2835],
     | 30.00th=[ 3130], 40.00th=[ 3195], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3294], 80.00th=[ 3458], 90.00th=[ 3621], 95.00th=[ 3720],
     | 99.00th=[ 5538], 99.50th=[ 6063], 99.90th=[ 6521], 99.95th=[ 6783],
     | 99.99th=[32375]
  write: IOPS=3669, BW=14.3MiB/s (15.0MB/s)(500MiB/34881msec); 0 zone resets
    slat (usec): min=9, max=905, avg=25.26, stdev=10.05
    clat (usec): min=729, max=94797, avg=4333.32, stdev=1536.34
     lat (usec): min=758, max=94828, avg=4358.76, stdev=1536.86
    clat percentiles (usec):
     |  1.00th=[ 2212],  5.00th=[ 2507], 10.00th=[ 2769], 20.00th=[ 3621],
     | 30.00th=[ 4015], 40.00th=[ 4228], 50.00th=[ 4424], 60.00th=[ 4555],
     | 70.00th=[ 4752], 80.00th=[ 4948], 90.00th=[ 5276], 95.00th=[ 5604],
     | 99.00th=[ 7570], 99.50th=[ 8094], 99.90th=[15401], 99.95th=[20841],
     | 99.99th=[93848]
   bw (  KiB/s): min=10744, max=18848, per=99.66%, avg=14628.11, stdev=1301.02, samples=70
   iops        : min= 2686, max= 4712, avg=3657.03, stdev=325.25, samples=70
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.18%, 4=55.48%, 10=44.18%, 20=0.11%, 50=0.04%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.65%, sys=9.47%, ctx=201446, majf=0, minf=1910
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80801,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.6MiB/s (20.6MB/s), 19.6MiB/s-19.6MiB/s (20.6MB/s-20.6MB/s), io=316MiB (331MB), run=16086-16086msec
  WRITE: bw=14.3MiB/s (15.0MB/s), 14.3MiB/s-14.3MiB/s (15.0MB/s-15.0MB/s), io=500MiB (524MB), run=34881-34881msec

Disk stats (read/write):
  loop5: ios=80061/128091, merge=0/1, ticks=253649/549027, in_queue=802813, util=99.89%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop7/testfile
+ fio fio/verify.fio --filename=/mnt/loop7/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.2%][r=19.1MiB/s][r=4883 IOPS][eta 00m:12s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3742: Wed Sep 22 18:36:33 2021
  read: IOPS=4949, BW=19.3MiB/s (20.3MB/s)(316MiB/16332msec)
    slat (usec): min=7, max=244, avg= 8.99, stdev= 5.03
    clat (usec): min=344, max=16615, avg=3221.85, stdev=631.29
     lat (usec): min=391, max=16624, avg=3230.92, stdev=631.52
    clat percentiles (usec):
     |  1.00th=[ 2278],  5.00th=[ 2311], 10.00th=[ 2474], 20.00th=[ 2868],
     | 30.00th=[ 3163], 40.00th=[ 3195], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3294], 80.00th=[ 3458], 90.00th=[ 3621], 95.00th=[ 3752],
     | 99.00th=[ 6128], 99.50th=[ 7242], 99.90th=[ 8455], 99.95th=[ 9765],
     | 99.99th=[12911]
  write: IOPS=3583, BW=14.0MiB/s (14.7MB/s)(500MiB/35723msec); 0 zone resets
    slat (usec): min=8, max=1302, avg=24.69, stdev= 9.99
    clat (usec): min=532, max=54345, avg=4439.08, stdev=1260.87
     lat (usec): min=567, max=54365, avg=4463.96, stdev=1261.39
    clat percentiles (usec):
     |  1.00th=[ 2278],  5.00th=[ 2573], 10.00th=[ 2966], 20.00th=[ 3851],
     | 30.00th=[ 4146], 40.00th=[ 4359], 50.00th=[ 4490], 60.00th=[ 4686],
     | 70.00th=[ 4817], 80.00th=[ 5014], 90.00th=[ 5276], 95.00th=[ 5669],
     | 99.00th=[ 7570], 99.50th=[ 8225], 99.90th=[17957], 99.95th=[26608],
     | 99.99th=[33424]
   bw (  KiB/s): min= 5400, max=16944, per=99.23%, avg=14222.22, stdev=1447.88, samples=72
   iops        : min= 1350, max= 4236, avg=3555.56, stdev=361.97, samples=72
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.14%, 4=52.68%, 10=47.00%, 20=0.14%, 50=0.04%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.63%, sys=8.99%, ctx=201428, majf=0, minf=1910
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80836,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.3MiB/s (20.3MB/s), 19.3MiB/s-19.3MiB/s (20.3MB/s-20.3MB/s), io=316MiB (331MB), run=16332-16332msec
  WRITE: bw=14.0MiB/s (14.7MB/s), 14.0MiB/s-14.0MiB/s (14.7MB/s-14.7MB/s), io=500MiB (524MB), run=35723-35723msec

Disk stats (read/write):
  loop7: ios=79753/128204, merge=0/1, ticks=256630/564437, in_queue=821344, util=99.84%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop10/testfile
+ fio fio/verify.fio --filename=/mnt/loop10/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.0%][r=18.7MiB/s][r=4780 IOPS][eta 00m:12s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3783: Wed Sep 22 18:37:25 2021
  read: IOPS=4974, BW=19.4MiB/s (20.4MB/s)(316MiB/16257msec)
    slat (usec): min=7, max=171, avg= 9.23, stdev= 5.34
    clat (usec): min=290, max=54228, avg=3205.30, stdev=793.73
     lat (usec): min=337, max=54237, avg=3214.62, stdev=793.53
    clat percentiles (usec):
     |  1.00th=[ 2212],  5.00th=[ 2311], 10.00th=[ 2704], 20.00th=[ 3064],
     | 30.00th=[ 3130], 40.00th=[ 3163], 50.00th=[ 3195], 60.00th=[ 3195],
     | 70.00th=[ 3294], 80.00th=[ 3425], 90.00th=[ 3556], 95.00th=[ 3654],
     | 99.00th=[ 5407], 99.50th=[ 6063], 99.90th=[ 6521], 99.95th=[ 6652],
     | 99.99th=[46400]
  write: IOPS=3628, BW=14.2MiB/s (14.9MB/s)(500MiB/35280msec); 0 zone resets
    slat (usec): min=8, max=931, avg=25.05, stdev= 8.99
    clat (usec): min=669, max=55424, avg=4383.41, stdev=1213.07
     lat (usec): min=688, max=55453, avg=4408.65, stdev=1213.59
    clat percentiles (usec):
     |  1.00th=[ 2278],  5.00th=[ 2540], 10.00th=[ 2835], 20.00th=[ 3785],
     | 30.00th=[ 4113], 40.00th=[ 4293], 50.00th=[ 4490], 60.00th=[ 4621],
     | 70.00th=[ 4817], 80.00th=[ 5014], 90.00th=[ 5211], 95.00th=[ 5538],
     | 99.00th=[ 7439], 99.50th=[ 7898], 99.90th=[11863], 99.95th=[21627],
     | 99.99th=[53216]
   bw (  KiB/s): min= 7496, max=18952, per=99.38%, avg=14422.54, stdev=1517.15, samples=71
   iops        : min= 1874, max= 4738, avg=3605.63, stdev=379.29, samples=71
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.14%, 4=53.58%, 10=46.18%, 20=0.05%, 50=0.03%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.58%, sys=9.30%, ctx=201223, majf=0, minf=1912
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80871,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.4MiB/s (20.4MB/s), 19.4MiB/s-19.4MiB/s (20.4MB/s-20.4MB/s), io=316MiB (331MB), run=16257-16257msec
  WRITE: bw=14.2MiB/s (14.9MB/s), 14.2MiB/s-14.2MiB/s (14.9MB/s-14.9MB/s), io=500MiB (524MB), run=35280-35280msec

Disk stats (read/write):
  loop10: ios=79636/128108, merge=0/1, ticks=255275/556087, in_queue=811461, util=99.90%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop4/testfile
+ fio fio/verify.fio --filename=/mnt/loop4/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][80.6%][r=21.8MiB/s][r=5580 IOPS][eta 00m:12s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3807: Wed Sep 22 18:38:16 2021
  read: IOPS=5112, BW=20.0MiB/s (20.9MB/s)(316MiB/15823msec)
    slat (usec): min=7, max=833, avg= 9.39, stdev= 7.15
    clat (usec): min=326, max=6938, avg=3118.49, stdev=532.66
     lat (usec): min=370, max=6954, avg=3127.97, stdev=532.64
    clat percentiles (usec):
     |  1.00th=[ 2212],  5.00th=[ 2278], 10.00th=[ 2376], 20.00th=[ 2704],
     | 30.00th=[ 2999], 40.00th=[ 3163], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3261], 80.00th=[ 3392], 90.00th=[ 3589], 95.00th=[ 3687],
     | 99.00th=[ 5604], 99.50th=[ 5997], 99.90th=[ 6521], 99.95th=[ 6587],
     | 99.99th=[ 6718]
  write: IOPS=3704, BW=14.5MiB/s (15.2MB/s)(500MiB/34550msec); 0 zone resets
    slat (usec): min=8, max=1298, avg=24.80, stdev=10.11
    clat (usec): min=487, max=90343, avg=4292.40, stdev=1546.17
     lat (usec): min=521, max=90361, avg=4317.38, stdev=1546.87
    clat percentiles (usec):
     |  1.00th=[ 2212],  5.00th=[ 2474], 10.00th=[ 2704], 20.00th=[ 3523],
     | 30.00th=[ 3982], 40.00th=[ 4228], 50.00th=[ 4424], 60.00th=[ 4555],
     | 70.00th=[ 4752], 80.00th=[ 4948], 90.00th=[ 5211], 95.00th=[ 5538],
     | 99.00th=[ 7504], 99.50th=[ 8029], 99.90th=[11731], 99.95th=[21365],
     | 99.99th=[88605]
   bw (  KiB/s): min=  480, max=19744, per=98.71%, avg=14628.57, stdev=2236.68, samples=70
   iops        : min=  120, max= 4936, avg=3657.14, stdev=559.17, samples=70
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.19%, 4=56.53%, 10=43.18%, 20=0.06%, 50=0.02%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.69%, sys=9.38%, ctx=200912, majf=0, minf=1911
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80895,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=20.0MiB/s (20.9MB/s), 20.0MiB/s-20.0MiB/s (20.9MB/s-20.9MB/s), io=316MiB (331MB), run=15823-15823msec
  WRITE: bw=14.5MiB/s (15.2MB/s), 14.5MiB/s-14.5MiB/s (15.2MB/s-15.2MB/s), io=500MiB (524MB), run=34550-34550msec

Disk stats (read/write):
  loop4: ios=80839/128147, merge=0/1, ticks=251719/544528, in_queue=796409, util=99.85%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop2/testfile
+ fio fio/verify.fio --filename=/mnt/loop2/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][82.0%][r=20.2MiB/s][r=5171 IOPS][eta 00m:11s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3865: Wed Sep 22 18:39:06 2021
  read: IOPS=5076, BW=19.8MiB/s (20.8MB/s)(316MiB/15950msec)
    slat (usec): min=7, max=157, avg= 9.10, stdev= 3.25
    clat (usec): min=300, max=27472, avg=3140.74, stdev=629.10
     lat (usec): min=347, max=27481, avg=3149.91, stdev=629.04
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2343], 10.00th=[ 2376], 20.00th=[ 2737],
     | 30.00th=[ 2999], 40.00th=[ 3163], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3294], 80.00th=[ 3392], 90.00th=[ 3621], 95.00th=[ 3720],
     | 99.00th=[ 5800], 99.50th=[ 6194], 99.90th=[ 6652], 99.95th=[ 7767],
     | 99.99th=[26870]
  write: IOPS=3772, BW=14.7MiB/s (15.5MB/s)(500MiB/33931msec); 0 zone resets
    slat (usec): min=9, max=834, avg=23.67, stdev= 9.04
    clat (usec): min=792, max=36997, avg=4216.23, stdev=1121.55
     lat (usec): min=816, max=37019, avg=4240.08, stdev=1122.77
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2507], 10.00th=[ 2704], 20.00th=[ 3294],
     | 30.00th=[ 3818], 40.00th=[ 4146], 50.00th=[ 4359], 60.00th=[ 4490],
     | 70.00th=[ 4686], 80.00th=[ 4883], 90.00th=[ 5211], 95.00th=[ 5538],
     | 99.00th=[ 7308], 99.50th=[ 7832], 99.90th=[10814], 99.95th=[16712],
     | 99.99th=[35914]
   bw (  KiB/s): min=11872, max=19072, per=99.79%, avg=15058.82, stdev=1497.26, samples=68
   iops        : min= 2968, max= 4768, avg=3764.71, stdev=374.32, samples=68
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.07%, 4=59.15%, 10=40.69%, 20=0.05%, 50=0.03%
  cpu          : usr=2.41%, sys=9.31%, ctx=201072, majf=0, minf=1913
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80975,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.8MiB/s (20.8MB/s), 19.8MiB/s-19.8MiB/s (20.8MB/s-20.8MB/s), io=316MiB (332MB), run=15950-15950msec
  WRITE: bw=14.7MiB/s (15.5MB/s), 14.7MiB/s-14.7MiB/s (15.5MB/s-15.5MB/s), io=500MiB (524MB), run=33931-33931msec

Disk stats (read/write):
  loop2: ios=80860/128089, merge=0/1, ticks=253666/534697, in_queue=788405, util=99.89%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop1/testfile
+ fio fio/verify.fio --filename=/mnt/loop1/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][80.3%][r=20.7MiB/s][r=5293 IOPS][eta 00m:12s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3892: Wed Sep 22 18:39:56 2021
  read: IOPS=5029, BW=19.6MiB/s (20.6MB/s)(316MiB/16068msec)
    slat (usec): min=7, max=172, avg= 9.35, stdev= 4.87
    clat (usec): min=289, max=38314, avg=3170.00, stdev=708.79
     lat (usec): min=334, max=38322, avg=3179.43, stdev=708.76
    clat percentiles (usec):
     |  1.00th=[ 2311],  5.00th=[ 2343], 10.00th=[ 2376], 20.00th=[ 2802],
     | 30.00th=[ 3097], 40.00th=[ 3195], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3294], 80.00th=[ 3425], 90.00th=[ 3654], 95.00th=[ 3752],
     | 99.00th=[ 5735], 99.50th=[ 6063], 99.90th=[ 6521], 99.95th=[ 7111],
     | 99.99th=[37487]
  write: IOPS=3790, BW=14.8MiB/s (15.5MB/s)(500MiB/33766msec); 0 zone resets
    slat (usec): min=8, max=568, avg=23.76, stdev= 8.75
    clat (usec): min=453, max=54336, avg=4195.51, stdev=1219.36
     lat (usec): min=525, max=54366, avg=4219.45, stdev=1220.49
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2442], 10.00th=[ 2638], 20.00th=[ 3294],
     | 30.00th=[ 3818], 40.00th=[ 4113], 50.00th=[ 4359], 60.00th=[ 4490],
     | 70.00th=[ 4686], 80.00th=[ 4883], 90.00th=[ 5145], 95.00th=[ 5473],
     | 99.00th=[ 7308], 99.50th=[ 7767], 99.90th=[ 8979], 99.95th=[12387],
     | 99.99th=[52167]
   bw (  KiB/s): min= 6872, max=19560, per=99.31%, avg=15058.32, stdev=1738.01, samples=68
   iops        : min= 1718, max= 4890, avg=3764.57, stdev=434.49, samples=68
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.08%, 4=59.34%, 10=40.52%, 20=0.03%, 50=0.02%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.43%, sys=9.46%, ctx=201149, majf=0, minf=1909
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80817,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.6MiB/s (20.6MB/s), 19.6MiB/s-19.6MiB/s (20.6MB/s-20.6MB/s), io=316MiB (331MB), run=16068-16068msec
  WRITE: bw=14.8MiB/s (15.5MB/s), 14.8MiB/s-14.8MiB/s (15.5MB/s-15.5MB/s), io=500MiB (524MB), run=33766-33766msec

Disk stats (read/write):
  loop1: ios=79895/128092, merge=0/1, ticks=252918/532368, in_queue=785393, util=99.89%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop3/testfile
+ fio fio/verify.fio --filename=/mnt/loop3/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][80.6%][r=19.8MiB/s][r=5081 IOPS][eta 00m:12s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=3952: Wed Sep 22 18:40:47 2021
  read: IOPS=4964, BW=19.4MiB/s (20.3MB/s)(316MiB/16314msec)
    slat (usec): min=7, max=490, avg= 9.28, stdev= 5.91
    clat (usec): min=247, max=27179, avg=3211.98, stdev=603.98
     lat (usec): min=294, max=27187, avg=3221.35, stdev=603.90
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2343], 10.00th=[ 2442], 20.00th=[ 2900],
     | 30.00th=[ 3163], 40.00th=[ 3195], 50.00th=[ 3195], 60.00th=[ 3261],
     | 70.00th=[ 3326], 80.00th=[ 3490], 90.00th=[ 3621], 95.00th=[ 3752],
     | 99.00th=[ 5800], 99.50th=[ 6128], 99.90th=[ 6980], 99.95th=[ 8291],
     | 99.99th=[24511]
  write: IOPS=3723, BW=14.5MiB/s (15.2MB/s)(500MiB/34380msec); 0 zone resets
    slat (usec): min=8, max=454, avg=22.60, stdev= 9.96
    clat (usec): min=391, max=79334, avg=4273.40, stdev=1574.27
     lat (usec): min=435, max=79367, avg=4296.17, stdev=1574.81
    clat percentiles (usec):
     |  1.00th=[ 2114],  5.00th=[ 2507], 10.00th=[ 2671], 20.00th=[ 3523],
     | 30.00th=[ 3982], 40.00th=[ 4228], 50.00th=[ 4359], 60.00th=[ 4555],
     | 70.00th=[ 4752], 80.00th=[ 4948], 90.00th=[ 5211], 95.00th=[ 5473],
     | 99.00th=[ 7373], 99.50th=[ 7898], 99.90th=[13304], 99.95th=[25822],
     | 99.99th=[78119]
   bw (  KiB/s): min=10960, max=19384, per=99.65%, avg=14840.58, stdev=1483.91, samples=69
   iops        : min= 2740, max= 4846, avg=3710.14, stdev=370.98, samples=69
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.02%
  lat (msec)   : 2=0.49%, 4=56.11%, 10=43.27%, 20=0.07%, 50=0.03%
  lat (msec)   : 100=0.02%
  cpu          : usr=2.44%, sys=8.74%, ctx=201212, majf=0, minf=1915
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80986,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.4MiB/s (20.3MB/s), 19.4MiB/s-19.4MiB/s (20.3MB/s-20.3MB/s), io=316MiB (332MB), run=16314-16314msec
  WRITE: bw=14.5MiB/s (15.2MB/s), 14.5MiB/s-14.5MiB/s (15.2MB/s-15.2MB/s), io=500MiB (524MB), run=34380-34380msec

Disk stats (read/write):
  loop3: ios=80354/128095, merge=0/1, ticks=257764/542042, in_queue=799968, util=99.90%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop8/testfile
+ fio fio/verify.fio --filename=/mnt/loop8/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.8%][r=20.0MiB/s][r=5125 IOPS][eta 00m:12s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4059: Wed Sep 22 18:41:41 2021
  read: IOPS=4982, BW=19.5MiB/s (20.4MB/s)(316MiB/16256msec)
    slat (usec): min=7, max=218, avg= 9.07, stdev= 4.02
    clat (usec): min=311, max=13537, avg=3200.12, stdev=578.34
     lat (usec): min=359, max=13545, avg=3209.29, stdev=578.63
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2343], 10.00th=[ 2376], 20.00th=[ 2835],
     | 30.00th=[ 3130], 40.00th=[ 3195], 50.00th=[ 3228], 60.00th=[ 3261],
     | 70.00th=[ 3326], 80.00th=[ 3490], 90.00th=[ 3654], 95.00th=[ 3785],
     | 99.00th=[ 5866], 99.50th=[ 6259], 99.90th=[ 8029], 99.95th=[ 9765],
     | 99.99th=[11994]
  write: IOPS=3480, BW=13.6MiB/s (14.3MB/s)(500MiB/36776msec); 0 zone resets
    slat (usec): min=8, max=528, avg=23.67, stdev= 9.33
    clat (usec): min=829, max=149982, avg=4571.88, stdev=2285.49
     lat (usec): min=860, max=150005, avg=4595.73, stdev=2286.11
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    3], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    5], 50.00th=[    5], 60.00th=[    5],
     | 70.00th=[    5], 80.00th=[    6], 90.00th=[    7], 95.00th=[    7],
     | 99.00th=[    9], 99.50th=[   10], 99.90th=[   28], 99.95th=[   54],
     | 99.99th=[  111]
   bw (  KiB/s): min= 5128, max=19008, per=99.39%, avg=13837.38, stdev=2737.15, samples=74
   iops        : min= 1282, max= 4752, avg=3459.34, stdev=684.28, samples=74
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.07%, 4=56.69%, 10=43.04%, 20=0.13%, 50=0.04%
  lat (msec)   : 100=0.03%, 250=0.01%
  cpu          : usr=2.51%, sys=8.56%, ctx=201922, majf=0, minf=1915
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=81002,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.5MiB/s (20.4MB/s), 19.5MiB/s-19.5MiB/s (20.4MB/s-20.4MB/s), io=316MiB (332MB), run=16256-16256msec
  WRITE: bw=13.6MiB/s (14.3MB/s), 13.6MiB/s-13.6MiB/s (14.3MB/s-14.3MB/s), io=500MiB (524MB), run=36776-36776msec

Disk stats (read/write):
  loop8: ios=80192/128086, merge=0/1, ticks=256554/580337, in_queue=836984, util=99.90%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop9/testfile
+ fio fio/verify.fio --filename=/mnt/loop9/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.9%][r=18.8MiB/s][r=4801 IOPS][eta 00m:15s]                 
write-and-verify: (groupid=0, jobs=1): err= 0: pid=4079: Wed Sep 22 18:42:49 2021
  read: IOPS=4999, BW=19.5MiB/s (20.5MB/s)(316MiB/16178msec)
    slat (usec): min=6, max=571, avg= 9.39, stdev= 5.53
    clat (usec): min=287, max=9799, avg=3189.10, stdev=505.18
     lat (usec): min=314, max=9810, avg=3198.58, stdev=505.01
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2343], 10.00th=[ 2442], 20.00th=[ 2868],
     | 30.00th=[ 3163], 40.00th=[ 3195], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3294], 80.00th=[ 3458], 90.00th=[ 3621], 95.00th=[ 3720],
     | 99.00th=[ 5604], 99.50th=[ 6063], 99.90th=[ 6783], 99.95th=[ 7504],
     | 99.99th=[ 9503]
  write: IOPS=2470, BW=9881KiB/s (10.1MB/s)(500MiB/51818msec); 0 zone resets
    slat (usec): min=9, max=662, avg=26.55, stdev= 9.28
    clat (usec): min=927, max=64814, avg=6449.01, stdev=1895.80
     lat (usec): min=991, max=64839, avg=6475.75, stdev=1896.34
    clat percentiles (usec):
     |  1.00th=[ 3097],  5.00th=[ 4047], 10.00th=[ 4555], 20.00th=[ 5014],
     | 30.00th=[ 5342], 40.00th=[ 5735], 50.00th=[ 6128], 60.00th=[ 6652],
     | 70.00th=[ 7242], 80.00th=[ 7963], 90.00th=[ 8848], 95.00th=[ 9503],
     | 99.00th=[10683], 99.50th=[11600], 99.90th=[13829], 99.95th=[20841],
     | 99.99th=[63177]
   bw (  KiB/s): min= 6784, max=15336, per=99.64%, avg=9845.94, stdev=1867.84, samples=104
   iops        : min= 1696, max= 3834, avg=2461.48, stdev=466.96, samples=104
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=40.87%, 10=57.87%, 20=1.22%, 50=0.02%
  lat (msec)   : 100=0.01%
  cpu          : usr=1.93%, sys=7.41%, ctx=201842, majf=0, minf=1912
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80883,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.5MiB/s (20.5MB/s), 19.5MiB/s-19.5MiB/s (20.5MB/s-20.5MB/s), io=316MiB (331MB), run=16178-16178msec
  WRITE: bw=9881KiB/s (10.1MB/s), 9881KiB/s-9881KiB/s (10.1MB/s-10.1MB/s), io=500MiB (524MB), run=51818-51818msec

Disk stats (read/write):
  loop9: ios=80146/128091, merge=0/1, ticks=255250/820483, in_queue=1075849, util=99.94%
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
+ umount /mnt/loop7
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop8
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop4
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop10
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop3
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop9
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop1
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop2
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop5
+ rm -fr ./loop5
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
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop3


-- 
2.29.0

