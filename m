Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D16C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241FF60C51
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhIUJXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:23:03 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:8577
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231310AbhIUJXD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:23:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzHB7v+m6IPtpHhpyNClKGWomKFJ5zA+uSJMwiLBQlWkMxEUWyNQL7aYfY/ughV5EK28QTdNOToG/oSt3pF+csJ2FoEiL3QzQOQwZzf7wWgSCBURsoQwpvdB077seGDjVaHk48aIAgR9cyylAiWQeKSjxCQeQFXPwTCEdYXP/AAT89+Cf66c0g8gpvazfjacVZ+btV6dp794BWKThwogH6xi6oVmo7H/IunKAz8w8J1zOnk0d6Mpn5ZkorgaYNJ8FT9hG5wneK9nxt77K5MMn43XfBUNBViBTOreFQm2nAm/Ezex1QAEoXD8r0jlnH2hSqxA5SJyHSTakahlH1+JWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qdN03l8poMhCB531pGp4XAVzwKZlzpzz9YgEMBWgy/E=;
 b=L9Enbi9kWi65f8SIb8ZIQayoUNxGXqF03Wf4Q0Qq4kYPEmIMzXrAfnXHpfxGpIHg54MlNeCfLueQEJE2Xioa5YW2waJqWCXSuMu6SP//KY+k7+9vEyPYG3jvADyiG7Z8RQ4CnlBYfu2qXnbvWEAhXC0HTcRu3r2kXKTO5dagFUIdAXPHcvNh1WrbqgAp8Dnlq0NaW4URzRFoNh+nDIf1yjDDT0V/7RGpgR90zBYuEfPRjS3IZPP98NepXeurK5deQ08IBeEVPWqhqgktq0AUkw21tnCN1YcndDbMqrFtU+XZV8dXQwJl4MSGnVEi4yqS5w/lJrP/lju9KpoiizRFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdN03l8poMhCB531pGp4XAVzwKZlzpzz9YgEMBWgy/E=;
 b=ql8F3VSyyzYfk4kZzEHOarvzABKM8GgDBvfB+4l5Cr8Zl5rVP95hghw28AsVEflaYUPLCjZqzRENaxxkV9qQ1h91bQCyiHkF4o9V7488XuqhSWqA8sJ0jF0mCcSZBWwe/wLTgV4DLgcee5bjS2Q5IOtL+RzD6wccpijrxPD7+CgpWCKdqb5HGLNixNtQwZSi6TYx9GSOaCfjOr0rsEH3GpSEDpnFRMEOMbvw6jBuCcvpliBjq5qGBqR4bbxi2pa1Jzjf6WyEo/rRIDh7c6wpha4psBwoQxnwBijxXDpnOa788RbD80C91qrCneg1lZyvpYwRwV5xS9CH2u1PPVjlhg==
Received: from MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::14)
 by DM6PR12MB3452.namprd12.prod.outlook.com (2603:10b6:5:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 09:21:31 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::7) by MW4P221CA0009.outlook.office365.com
 (2603:10b6:303:8b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 09:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 09:21:30 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:21:30 +0000
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:21:29 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/8] loop: small clenaup
Date:   Tue, 21 Sep 2021 02:21:15 -0700
Message-ID: <20210921092123.13632-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d45c5615-907f-4e0d-61e9-08d97ce1329c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3452:
X-Microsoft-Antispam-PRVS: <DM6PR12MB345248C0CD00AF32C9466A19A3A19@DM6PR12MB3452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u15+v/apIqzZi8tUK26Fo6imW/7q8lGPPMzNyxVXo8RxoNgNQme9XAUVAMtNc/ZwjmHJJsynfUx67ZrEY2hX4b2zt+hw3h7eZgQYB4/F/3po000XIbiUt1G3C89D+OtyEyRBq0Nt/aI+6eiBEBaNLrUCPvUlL5nZ6ZuyrRuZiiHKgTTEJYiO5Ji0+T/MBSn3TH4agsv//SvGkky/nzapPo08gqsYb7ElPh1a/zK8FSt52unjNK1587sP5e5OkMPoYZbX7foTHB7DjodhX5I40cAzga9luo7oRbKEtLVWVwc1EXgweYwIFwO2gDAwESdmQobMwMXJsVEUcUEZm47XT97ozdoP3jNsLEYC66eJE1TiQjmJJ/exxcN5v0JrVXTqmeU9AISu2fnblsMiVoRI1kYa73NF3/DLw5BIfEtMkrCCVTaEyvTj42B4W7GfzcdaK5RB07HmuzilhmjmjdyvFDd3LvFkYKFHOTs5SbRl1wR6ptuOnQTYQl2Rlab5jAW8nQg4KvWmHDzKZBT2scjAL6nQAFstCikpvy5tp7d+yMEBfWQ4fFpWmvXye/2boosivbTpRj3lDfLkf8MRXWV31xzaPOruWfeS+MEYbC68zESuPVLCMHLkbA8mmS3IaitkPFoar5QKN7W1RsH91BsBivvAB69+RVnLYQ1mEN3CISOnkCl6jtKyvAduIzhwIfWmcOPWVQGkWA5GMFVSfhhHbw==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(356005)(8676002)(4326008)(86362001)(2616005)(508600001)(26005)(7636003)(6916009)(336012)(83380400001)(82310400003)(16526019)(30864003)(186003)(36860700001)(36906005)(19627235002)(8936002)(316002)(70586007)(54906003)(70206006)(7696005)(1076003)(2906002)(107886003)(6666004)(426003)(47076005)(5660300002)(36756003)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 09:21:30.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45c5615-907f-4e0d-61e9-08d97ce1329c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Hi,

This has few improvment and cleanups such as using sysfs_emit() for the
sysfs dev attributes and removing variables that are only used once and
a cleanup with fixing declaration.

Below is the test log where 10 loop devices created, each deivce is
linked to it's own file in ./loopX, formatted with xfs and mounted on
/mnt/loopX. For each device it reads the offset, sizelimit, autoclear,
partscan, and dio attr from sysfs using cat command, then it runs fio
verify job on it.

In summary write-verify fio job seems to work fine :-

root@dev loop-sysfs-emit (for-next) # grep err= 0000-cover-letter.patch 
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8490: Tue Sep 21 01:47:04 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8559: Tue Sep 21 01:47:56 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8588: Tue Sep 21 01:48:49 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8612: Tue Sep 21 01:49:40 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8634: Tue Sep 21 01:50:30 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8659: Tue Sep 21 01:51:21 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8687: Tue Sep 21 01:52:12 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8701: Tue Sep 21 01:53:01 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8724: Tue Sep 21 01:53:52 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8753: Tue Sep 21 01:55:02 2021
root@dev loop-sysfs-emit (for-next) # 

-ck

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
+ umount /mnt/loop6
umount: /mnt/loop6: no mount point specified.
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop4
umount: /mnt/loop4: not mounted.
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop9
umount: /mnt/loop9: no mount point specified.
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop3
umount: /mnt/loop3: not mounted.
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop2
umount: /mnt/loop2: not mounted.
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop5
umount: /mnt/loop5: not mounted.
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop1
umount: /mnt/loop1: not mounted.
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop8
umount: /mnt/loop8: no mount point specified.
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop10
umount: /mnt/loop10: no mount point specified.
+ rm -fr ./loop10
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
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop7
+ rm -fr /mnt/loop1 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5
+ compile_loop
++ nproc
+ make -j 48 M=drivers/block modules
+ HOST=drivers/block/
++ uname -r
+ HOST_DEST=/lib/modules/5.15.0-rc1blk-next+/kernel/drivers/block
+ cp drivers/block//loop.ko /lib/modules/5.15.0-rc1blk-next+/kernel/drivers/block/
+ load_loop
+ insmod drivers/block/loop.ko max_loop=11 hw_queue_depth=32
++ shuf -i 1-10 -n 10
+ for i in `shuf -i  1-$NN -n $NN`
+ mkdir -p /mnt/loop5
+ truncate -s 2048M ./loop5
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop5 ./loop5
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
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
+ mkdir -p /mnt/loop8
+ truncate -s 2048M ./loop8
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop8 ./loop8
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
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
+ mkdir -p /mnt/loop6
+ truncate -s 2048M ./loop6
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop6 ./loop6
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop6         0      0         0  0 /mnt/data/linux-block/loop6   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
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
+ mkdir -p /mnt/loop3
+ truncate -s 2048M ./loop3
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop3 ./loop3
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop6         0      0         0  0 /mnt/data/linux-block/loop6   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
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
+ mkdir -p /mnt/loop4
+ truncate -s 2048M ./loop4
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop4 ./loop4
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop6         0      0         0  0 /mnt/data/linux-block/loop6   1     512
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
/dev/loop5         0      0         0  0 /mnt/data/linux-block/loop5   1     512
/dev/loop3         0      0         0  0 /mnt/data/linux-block/loop3   1     512
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
+ mkdir -p /mnt/loop1
+ truncate -s 2048M ./loop1
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop1 ./loop1
+ /mnt/data/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt/data/linux-block/loop1   1     512
/dev/loop8         0      0         0  0 /mnt/data/linux-block/loop8   1     512
/dev/loop6         0      0         0  0 /mnt/data/linux-block/loop6   1     512
/dev/loop4         0      0         0  0 /mnt/data/linux-block/loop4   1     512
/dev/loop2         0      0         0  0 /mnt/data/linux-block/loop2   1     512
/dev/loop7         0      0         0  0 /mnt/data/linux-block/loop7   1     512
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
+ mkdir -p /mnt/loop9
+ truncate -s 2048M ./loop9
+ /mnt/data/util-linux/losetup --direct-io=on /dev/loop9 ./loop9
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
/dev/loop5 on /mnt/loop5 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop7 on /mnt/loop7 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop2 on /mnt/loop2 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop8 on /mnt/loop8 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop6 on /mnt/loop6 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop3 on /mnt/loop3 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop4 on /mnt/loop4 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop1 on /mnt/loop1 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop9 on /mnt/loop9 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop10 on /mnt/loop10 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
+ dmesg -c
[ 1307.805150] XFS (loop4): Unmounting Filesystem
[ 1307.933976] XFS (loop2): Unmounting Filesystem
[ 1308.032542] XFS (loop1): Unmounting Filesystem
[ 1308.165143] XFS (loop5): Unmounting Filesystem
[ 1308.302151] XFS (loop3): Unmounting Filesystem
[ 1363.137973] loop: module loaded
[ 1363.206977] loop5: detected capacity change from 0 to 4194304
[ 1364.391833] XFS (loop5): Mounting V5 Filesystem
[ 1364.406390] XFS (loop5): Ending clean mount
[ 1364.411587] xfs filesystem being mounted at /mnt/loop5 supports timestamps until 2038 (0x7fffffff)
[ 1364.496590] loop7: detected capacity change from 0 to 4194304
[ 1365.686559] XFS (loop7): Mounting V5 Filesystem
[ 1365.721217] XFS (loop7): Ending clean mount
[ 1365.726446] xfs filesystem being mounted at /mnt/loop7 supports timestamps until 2038 (0x7fffffff)
[ 1365.811043] loop2: detected capacity change from 0 to 4194304
[ 1366.994003] XFS (loop2): Mounting V5 Filesystem
[ 1367.007705] XFS (loop2): Ending clean mount
[ 1367.013104] xfs filesystem being mounted at /mnt/loop2 supports timestamps until 2038 (0x7fffffff)
[ 1367.097475] loop8: detected capacity change from 0 to 4194304
[ 1368.278904] XFS (loop8): Mounting V5 Filesystem
[ 1368.313404] XFS (loop8): Ending clean mount
[ 1368.318916] xfs filesystem being mounted at /mnt/loop8 supports timestamps until 2038 (0x7fffffff)
[ 1368.402631] loop6: detected capacity change from 0 to 4194304
[ 1369.583730] XFS (loop6): Mounting V5 Filesystem
[ 1369.599583] XFS (loop6): Ending clean mount
[ 1369.604873] xfs filesystem being mounted at /mnt/loop6 supports timestamps until 2038 (0x7fffffff)
[ 1369.692002] loop3: detected capacity change from 0 to 4194304
[ 1370.866893] XFS (loop3): Mounting V5 Filesystem
[ 1370.879526] XFS (loop3): Ending clean mount
[ 1370.884263] xfs filesystem being mounted at /mnt/loop3 supports timestamps until 2038 (0x7fffffff)
[ 1370.969853] loop4: detected capacity change from 0 to 4194304
[ 1372.152669] XFS (loop4): Mounting V5 Filesystem
[ 1372.167886] XFS (loop4): Ending clean mount
[ 1372.172981] xfs filesystem being mounted at /mnt/loop4 supports timestamps until 2038 (0x7fffffff)
[ 1372.259372] loop1: detected capacity change from 0 to 4194304
[ 1373.442692] XFS (loop1): Mounting V5 Filesystem
[ 1373.455693] XFS (loop1): Ending clean mount
[ 1373.460599] xfs filesystem being mounted at /mnt/loop1 supports timestamps until 2038 (0x7fffffff)
[ 1373.544566] loop9: detected capacity change from 0 to 4194304
[ 1374.722577] XFS (loop9): Mounting V5 Filesystem
[ 1374.736937] XFS (loop9): Ending clean mount
[ 1374.741922] xfs filesystem being mounted at /mnt/loop9 supports timestamps until 2038 (0x7fffffff)
[ 1374.829737] loop10: detected capacity change from 0 to 4194304
[ 1376.020065] XFS (loop10): Mounting V5 Filesystem
[ 1376.035050] XFS (loop10): Ending clean mount
[ 1376.039910] xfs filesystem being mounted at /mnt/loop10 supports timestamps until 2038 (0x7fffffff)
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
Jobs: 1 (f=1): [V(1)][82.3%][r=17.2MiB/s][r=4413 IOPS][eta 00m:11s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8490: Tue Sep 21 01:47:04 2021
  read: IOPS=4954, BW=19.4MiB/s (20.3MB/s)(316MiB/16313msec)
    slat (usec): min=6, max=486, avg= 9.51, stdev= 5.37
    clat (usec): min=288, max=11340, avg=3218.29, stdev=618.71
     lat (usec): min=334, max=11348, avg=3227.87, stdev=618.89
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2343], 10.00th=[ 2507], 20.00th=[ 2868],
     | 30.00th=[ 3163], 40.00th=[ 3195], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3294], 80.00th=[ 3458], 90.00th=[ 3621], 95.00th=[ 3752],
     | 99.00th=[ 6194], 99.50th=[ 7111], 99.90th=[ 8356], 99.95th=[ 8848],
     | 99.99th=[10945]
  write: IOPS=3688, BW=14.4MiB/s (15.1MB/s)(500MiB/34699msec); 0 zone resets
    slat (usec): min=8, max=923, avg=25.13, stdev= 9.19
    clat (usec): min=591, max=61940, avg=4310.73, stdev=1327.90
     lat (usec): min=665, max=61972, avg=4336.01, stdev=1328.49
    clat percentiles (usec):
     |  1.00th=[ 2212],  5.00th=[ 2442], 10.00th=[ 2638], 20.00th=[ 3589],
     | 30.00th=[ 4015], 40.00th=[ 4228], 50.00th=[ 4424], 60.00th=[ 4621],
     | 70.00th=[ 4752], 80.00th=[ 5014], 90.00th=[ 5276], 95.00th=[ 5538],
     | 99.00th=[ 7504], 99.50th=[ 8029], 99.90th=[11469], 99.95th=[15139],
     | 99.99th=[61080]
   bw (  KiB/s): min= 4872, max=19192, per=99.14%, avg=14628.57, stdev=1692.89, samples=70
   iops        : min= 1218, max= 4798, avg=3657.14, stdev=423.22, samples=70
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.19%, 4=55.31%, 10=44.40%, 20=0.09%, 50=0.01%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.52%, sys=9.61%, ctx=200918, majf=0, minf=1911
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80820,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.4MiB/s (20.3MB/s), 19.4MiB/s-19.4MiB/s (20.3MB/s-20.3MB/s), io=316MiB (331MB), run=16313-16313msec
  WRITE: bw=14.4MiB/s (15.1MB/s), 14.4MiB/s-14.4MiB/s (15.1MB/s-15.1MB/s), io=500MiB (524MB), run=34699-34699msec

Disk stats (read/write):
  loop5: ios=79867/128184, merge=0/1, ticks=256599/547656, in_queue=804505, util=99.85%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop9/testfile
+ fio fio/verify.fio --filename=/mnt/loop9/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.0%][r=20.1MiB/s][r=5141 IOPS][eta 00m:12s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8559: Tue Sep 21 01:47:56 2021
  read: IOPS=4944, BW=19.3MiB/s (20.3MB/s)(316MiB/16373msec)
    slat (usec): min=7, max=405, avg= 9.72, stdev= 5.25
    clat (usec): min=273, max=62227, avg=3224.50, stdev=920.70
     lat (usec): min=320, max=62236, avg=3234.30, stdev=920.60
    clat percentiles (usec):
     |  1.00th=[ 2212],  5.00th=[ 2311], 10.00th=[ 2606], 20.00th=[ 2966],
     | 30.00th=[ 3163], 40.00th=[ 3163], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3294], 80.00th=[ 3490], 90.00th=[ 3654], 95.00th=[ 3818],
     | 99.00th=[ 5866], 99.50th=[ 6194], 99.90th=[ 6718], 99.95th=[ 7242],
     | 99.99th=[57934]
  write: IOPS=3622, BW=14.1MiB/s (14.8MB/s)(500MiB/35339msec); 0 zone resets
    slat (usec): min=9, max=709, avg=25.28, stdev= 9.25
    clat (usec): min=708, max=66373, avg=4390.52, stdev=1322.09
     lat (usec): min=745, max=66395, avg=4415.96, stdev=1322.49
    clat percentiles (usec):
     |  1.00th=[ 2278],  5.00th=[ 2540], 10.00th=[ 2835], 20.00th=[ 3818],
     | 30.00th=[ 4113], 40.00th=[ 4293], 50.00th=[ 4490], 60.00th=[ 4621],
     | 70.00th=[ 4817], 80.00th=[ 4948], 90.00th=[ 5211], 95.00th=[ 5538],
     | 99.00th=[ 7373], 99.50th=[ 7832], 99.90th=[11731], 99.95th=[18220],
     | 99.99th=[65799]
   bw (  KiB/s): min= 8776, max=18984, per=99.54%, avg=14422.54, stdev=1304.24, samples=71
   iops        : min= 2194, max= 4746, avg=3605.63, stdev=326.06, samples=71
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.10%, 4=53.00%, 10=46.79%, 20=0.06%, 50=0.02%
  lat (msec)   : 100=0.02%
  cpu          : usr=2.52%, sys=9.52%, ctx=200652, majf=0, minf=1915
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80953,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.3MiB/s (20.3MB/s), 19.3MiB/s-19.3MiB/s (20.3MB/s-20.3MB/s), io=316MiB (332MB), run=16373-16373msec
  WRITE: bw=14.1MiB/s (14.8MB/s), 14.1MiB/s-14.1MiB/s (14.8MB/s-14.8MB/s), io=500MiB (524MB), run=35339-35339msec

Disk stats (read/write):
  loop9: ios=80380/128119, merge=0/1, ticks=258908/556886, in_queue=815978, util=99.90%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop4/testfile
+ fio fio/verify.fio --filename=/mnt/loop4/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.2%][r=20.0MiB/s][r=5112 IOPS][eta 00m:12s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8588: Tue Sep 21 01:48:49 2021
  read: IOPS=4889, BW=19.1MiB/s (20.0MB/s)(316MiB/16567msec)
    slat (usec): min=7, max=375, avg= 9.94, stdev= 6.45
    clat (usec): min=362, max=80861, avg=3260.43, stdev=1267.52
     lat (usec): min=398, max=80869, avg=3270.46, stdev=1267.68
    clat percentiles (usec):
     |  1.00th=[ 2212],  5.00th=[ 2311], 10.00th=[ 2573], 20.00th=[ 2933],
     | 30.00th=[ 3130], 40.00th=[ 3163], 50.00th=[ 3195], 60.00th=[ 3261],
     | 70.00th=[ 3359], 80.00th=[ 3490], 90.00th=[ 3654], 95.00th=[ 3851],
     | 99.00th=[ 6325], 99.50th=[ 7767], 99.90th=[ 8979], 99.95th=[12125],
     | 99.99th=[79168]
  write: IOPS=3587, BW=14.0MiB/s (14.7MB/s)(500MiB/35684msec); 0 zone resets
    slat (usec): min=8, max=495, avg=25.57, stdev= 9.04
    clat (usec): min=538, max=41533, avg=4433.34, stdev=1168.26
     lat (usec): min=651, max=41562, avg=4459.07, stdev=1168.78
    clat percentiles (usec):
     |  1.00th=[ 2278],  5.00th=[ 2540], 10.00th=[ 2802], 20.00th=[ 3851],
     | 30.00th=[ 4146], 40.00th=[ 4359], 50.00th=[ 4490], 60.00th=[ 4686],
     | 70.00th=[ 4883], 80.00th=[ 5080], 90.00th=[ 5342], 95.00th=[ 5669],
     | 99.00th=[ 7635], 99.50th=[ 8225], 99.90th=[13566], 99.95th=[19792],
     | 99.99th=[40633]
   bw (  KiB/s): min= 5744, max=16840, per=99.12%, avg=14222.22, stdev=1438.27, samples=72
   iops        : min= 1436, max= 4210, avg=3555.56, stdev=359.57, samples=72
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.12%, 4=52.40%, 10=47.31%, 20=0.13%, 50=0.03%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.49%, sys=9.60%, ctx=200897, majf=0, minf=1915
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=81010,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.1MiB/s (20.0MB/s), 19.1MiB/s-19.1MiB/s (20.0MB/s-20.0MB/s), io=316MiB (332MB), run=16567-16567msec
  WRITE: bw=14.0MiB/s (14.7MB/s), 14.0MiB/s-14.0MiB/s (14.7MB/s-14.7MB/s), io=500MiB (524MB), run=35684-35684msec

Disk stats (read/write):
  loop4: ios=80377/128149, merge=0/1, ticks=261641/562817, in_queue=824655, util=99.88%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop10/testfile
+ fio fio/verify.fio --filename=/mnt/loop10/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][82.3%][r=19.3MiB/s][r=4937 IOPS][eta 00m:11s]                 
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8612: Tue Sep 21 01:49:40 2021
  read: IOPS=5002, BW=19.5MiB/s (20.5MB/s)(316MiB/16161msec)
    slat (usec): min=7, max=488, avg= 9.65, stdev= 7.47
    clat (usec): min=299, max=45475, avg=3186.60, stdev=790.52
     lat (usec): min=349, max=45484, avg=3196.33, stdev=790.39
    clat percentiles (usec):
     |  1.00th=[ 2147],  5.00th=[ 2278], 10.00th=[ 2376], 20.00th=[ 2835],
     | 30.00th=[ 3130], 40.00th=[ 3163], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3294], 80.00th=[ 3490], 90.00th=[ 3654], 95.00th=[ 3785],
     | 99.00th=[ 5866], 99.50th=[ 6259], 99.90th=[ 6849], 99.95th=[ 8717],
     | 99.99th=[43254]
  write: IOPS=3683, BW=14.4MiB/s (15.1MB/s)(500MiB/34753msec); 0 zone resets
    slat (usec): min=9, max=567, avg=24.64, stdev= 9.17
    clat (usec): min=955, max=64688, avg=4318.02, stdev=1328.89
     lat (usec): min=1003, max=64718, avg=4342.80, stdev=1329.80
    clat percentiles (usec):
     |  1.00th=[ 2278],  5.00th=[ 2474], 10.00th=[ 2671], 20.00th=[ 3490],
     | 30.00th=[ 3982], 40.00th=[ 4228], 50.00th=[ 4424], 60.00th=[ 4621],
     | 70.00th=[ 4817], 80.00th=[ 5014], 90.00th=[ 5276], 95.00th=[ 5604],
     | 99.00th=[ 7373], 99.50th=[ 7963], 99.90th=[ 9372], 99.95th=[11863],
     | 99.99th=[62129]
   bw (  KiB/s): min= 7208, max=17880, per=99.29%, avg=14628.57, stdev=1597.34, samples=70
   iops        : min= 1802, max= 4470, avg=3657.14, stdev=399.34, samples=70
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.15%, 4=56.08%, 10=43.72%, 20=0.02%, 50=0.02%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.55%, sys=9.46%, ctx=201811, majf=0, minf=1912
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80852,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.5MiB/s (20.5MB/s), 19.5MiB/s-19.5MiB/s (20.5MB/s-20.5MB/s), io=316MiB (331MB), run=16161-16161msec
  WRITE: bw=14.4MiB/s (15.1MB/s), 14.4MiB/s-14.4MiB/s (15.1MB/s-15.1MB/s), io=500MiB (524MB), run=34753-34753msec

Disk stats (read/write):
  loop10: ios=80342/128052, merge=0/1, ticks=255518/547044, in_queue=802607, util=99.90%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop8/testfile
+ fio fio/verify.fio --filename=/mnt/loop8/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][82.0%][r=19.5MiB/s][r=4989 IOPS][eta 00m:11s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8634: Tue Sep 21 01:50:30 2021
  read: IOPS=5086, BW=19.9MiB/s (20.8MB/s)(316MiB/15902msec)
    slat (usec): min=7, max=462, avg= 9.21, stdev= 5.41
    clat (usec): min=269, max=7474, avg=3134.97, stdev=540.77
     lat (usec): min=316, max=7491, avg=3144.26, stdev=540.69
    clat percentiles (usec):
     |  1.00th=[ 2180],  5.00th=[ 2278], 10.00th=[ 2343], 20.00th=[ 2704],
     | 30.00th=[ 3064], 40.00th=[ 3163], 50.00th=[ 3195], 60.00th=[ 3228],
     | 70.00th=[ 3294], 80.00th=[ 3458], 90.00th=[ 3621], 95.00th=[ 3752],
     | 99.00th=[ 5604], 99.50th=[ 5997], 99.90th=[ 6456], 99.95th=[ 6587],
     | 99.99th=[ 6849]
  write: IOPS=3715, BW=14.5MiB/s (15.2MB/s)(500MiB/34450msec); 0 zone resets
    slat (usec): min=8, max=1359, avg=24.98, stdev=10.21
    clat (usec): min=842, max=84403, avg=4279.76, stdev=1473.52
     lat (usec): min=876, max=84424, avg=4304.88, stdev=1474.03
    clat percentiles (usec):
     |  1.00th=[ 2212],  5.00th=[ 2474], 10.00th=[ 2638], 20.00th=[ 3359],
     | 30.00th=[ 3949], 40.00th=[ 4228], 50.00th=[ 4424], 60.00th=[ 4555],
     | 70.00th=[ 4752], 80.00th=[ 5014], 90.00th=[ 5276], 95.00th=[ 5538],
     | 99.00th=[ 7373], 99.50th=[ 8029], 99.90th=[12518], 99.95th=[22414],
     | 99.99th=[81265]
   bw (  KiB/s): min=10504, max=19360, per=99.85%, avg=14840.58, stdev=1357.36, samples=69
   iops        : min= 2626, max= 4840, avg=3710.14, stdev=339.34, samples=69
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.17%, 4=56.79%, 10=42.93%, 20=0.07%, 50=0.03%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.58%, sys=9.50%, ctx=200944, majf=0, minf=1912
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80878,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.9MiB/s (20.8MB/s), 19.9MiB/s-19.9MiB/s (20.8MB/s-20.8MB/s), io=316MiB (331MB), run=15902-15902msec
  WRITE: bw=14.5MiB/s (15.2MB/s), 14.5MiB/s-14.5MiB/s (15.2MB/s-15.2MB/s), io=500MiB (524MB), run=34450-34450msec

Disk stats (read/write):
  loop8: ios=79733/128068, merge=0/1, ticks=249748/541938, in_queue=791768, util=99.90%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop1/testfile
+ fio fio/verify.fio --filename=/mnt/loop1/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][80.6%][r=19.4MiB/s][r=4971 IOPS][eta 00m:12s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8659: Tue Sep 21 01:51:21 2021
  read: IOPS=4974, BW=19.4MiB/s (20.4MB/s)(315MiB/16227msec)
    slat (usec): min=7, max=530, avg= 9.26, stdev= 5.07
    clat (usec): min=310, max=41192, avg=3205.15, stdev=763.56
     lat (usec): min=356, max=41200, avg=3214.48, stdev=763.67
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2311], 10.00th=[ 2376], 20.00th=[ 2802],
     | 30.00th=[ 3130], 40.00th=[ 3195], 50.00th=[ 3228], 60.00th=[ 3261],
     | 70.00th=[ 3326], 80.00th=[ 3523], 90.00th=[ 3687], 95.00th=[ 3884],
     | 99.00th=[ 5866], 99.50th=[ 6325], 99.90th=[ 7373], 99.95th=[ 8717],
     | 99.99th=[38536]
  write: IOPS=3737, BW=14.6MiB/s (15.3MB/s)(500MiB/34251msec); 0 zone resets
    slat (usec): min=9, max=702, avg=24.53, stdev=10.22
    clat (usec): min=607, max=44128, avg=4255.41, stdev=1349.69
     lat (usec): min=901, max=44147, avg=4280.09, stdev=1351.06
    clat percentiles (usec):
     |  1.00th=[ 2278],  5.00th=[ 2507], 10.00th=[ 2671], 20.00th=[ 3261],
     | 30.00th=[ 3818], 40.00th=[ 4178], 50.00th=[ 4359], 60.00th=[ 4555],
     | 70.00th=[ 4752], 80.00th=[ 4948], 90.00th=[ 5211], 95.00th=[ 5538],
     | 99.00th=[ 7373], 99.50th=[ 8160], 99.90th=[19530], 99.95th=[25297],
     | 99.99th=[43779]
   bw (  KiB/s): min= 6440, max=19432, per=99.27%, avg=14840.58, stdev=2063.19, samples=69
   iops        : min= 1610, max= 4860, avg=3710.14, stdev=515.87, samples=69
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.12%, 4=58.06%, 10=41.65%, 20=0.11%, 50=0.07%
  cpu          : usr=2.62%, sys=9.29%, ctx=201148, majf=0, minf=1907
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80728,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.4MiB/s (20.4MB/s), 19.4MiB/s-19.4MiB/s (20.4MB/s-20.4MB/s), io=315MiB (331MB), run=16227-16227msec
  WRITE: bw=14.6MiB/s (15.3MB/s), 14.6MiB/s-14.6MiB/s (15.3MB/s-15.3MB/s), io=500MiB (524MB), run=34251-34251msec

Disk stats (read/write):
  loop1: ios=80339/128148, merge=0/78, ticks=257157/539997, in_queue=797307, util=99.90%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop7/testfile
+ fio fio/verify.fio --filename=/mnt/loop7/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][82.0%][r=19.9MiB/s][r=5104 IOPS][eta 00m:11s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8687: Tue Sep 21 01:52:12 2021
  read: IOPS=5097, BW=19.9MiB/s (20.9MB/s)(316MiB/15850msec)
    slat (usec): min=7, max=223, avg= 9.22, stdev= 5.96
    clat (usec): min=295, max=20700, avg=3127.93, stdev=691.52
     lat (usec): min=346, max=20709, avg=3137.22, stdev=691.81
    clat percentiles (usec):
     |  1.00th=[ 2180],  5.00th=[ 2278], 10.00th=[ 2343], 20.00th=[ 2671],
     | 30.00th=[ 2900], 40.00th=[ 3130], 50.00th=[ 3163], 60.00th=[ 3228],
     | 70.00th=[ 3261], 80.00th=[ 3425], 90.00th=[ 3589], 95.00th=[ 3752],
     | 99.00th=[ 6128], 99.50th=[ 7242], 99.90th=[ 8455], 99.95th=[ 8979],
     | 99.99th=[19530]
  write: IOPS=3747, BW=14.6MiB/s (15.3MB/s)(500MiB/34159msec); 0 zone resets
    slat (usec): min=8, max=636, avg=24.59, stdev= 9.79
    clat (usec): min=381, max=32024, avg=4243.85, stdev=1083.88
     lat (usec): min=422, max=32066, avg=4268.58, stdev=1084.70
    clat percentiles (usec):
     |  1.00th=[ 2278],  5.00th=[ 2540], 10.00th=[ 2737], 20.00th=[ 3392],
     | 30.00th=[ 3916], 40.00th=[ 4178], 50.00th=[ 4359], 60.00th=[ 4555],
     | 70.00th=[ 4686], 80.00th=[ 4948], 90.00th=[ 5211], 95.00th=[ 5473],
     | 99.00th=[ 7308], 99.50th=[ 7767], 99.90th=[10159], 99.95th=[17695],
     | 99.99th=[31065]
   bw (  KiB/s): min= 4040, max=19568, per=99.01%, avg=14840.58, stdev=1919.64, samples=69
   iops        : min= 1010, max= 4892, avg=3710.14, stdev=479.91, samples=69
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.21%, 4=57.49%, 10=42.21%, 20=0.05%, 50=0.02%
  cpu          : usr=2.50%, sys=9.52%, ctx=201015, majf=0, minf=1910
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80792,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.9MiB/s (20.9MB/s), 19.9MiB/s-19.9MiB/s (20.9MB/s-20.9MB/s), io=316MiB (331MB), run=15850-15850msec
  WRITE: bw=14.6MiB/s (15.3MB/s), 14.6MiB/s-14.6MiB/s (15.3MB/s-15.3MB/s), io=500MiB (524MB), run=34159-34159msec

Disk stats (read/write):
  loop7: ios=79845/128091, merge=0/1, ticks=249588/538035, in_queue=787718, util=99.88%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop3/testfile
+ fio fio/verify.fio --filename=/mnt/loop3/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][80.3%][r=20.2MiB/s][r=5164 IOPS][eta 00m:12s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8701: Tue Sep 21 01:53:01 2021
  read: IOPS=5092, BW=19.9MiB/s (20.9MB/s)(316MiB/15886msec)
    slat (usec): min=7, max=213, avg= 8.90, stdev= 3.35
    clat (usec): min=264, max=13187, avg=3131.33, stdev=593.30
     lat (usec): min=279, max=13195, avg=3140.30, stdev=593.38
    clat percentiles (usec):
     |  1.00th=[ 2311],  5.00th=[ 2343], 10.00th=[ 2409], 20.00th=[ 2704],
     | 30.00th=[ 2900], 40.00th=[ 3163], 50.00th=[ 3195], 60.00th=[ 3261],
     | 70.00th=[ 3294], 80.00th=[ 3392], 90.00th=[ 3621], 95.00th=[ 3720],
     | 99.00th=[ 5932], 99.50th=[ 6390], 99.90th=[ 7504], 99.95th=[ 7635],
     | 99.99th=[10814]
  write: IOPS=3805, BW=14.9MiB/s (15.6MB/s)(500MiB/33633msec); 0 zone resets
    slat (usec): min=8, max=4286, avg=22.56, stdev=16.05
    clat (usec): min=371, max=57309, avg=4180.18, stdev=1403.07
     lat (usec): min=430, max=57351, avg=4202.87, stdev=1404.78
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2474], 10.00th=[ 2704], 20.00th=[ 3228],
     | 30.00th=[ 3621], 40.00th=[ 4015], 50.00th=[ 4293], 60.00th=[ 4490],
     | 70.00th=[ 4621], 80.00th=[ 4883], 90.00th=[ 5211], 95.00th=[ 5604],
     | 99.00th=[ 7701], 99.50th=[ 8848], 99.90th=[14222], 99.95th=[16909],
     | 99.99th=[55313]
   bw (  KiB/s): min= 4528, max=19200, per=98.92%, avg=15058.82, stdev=2378.77, samples=68
   iops        : min= 1132, max= 4800, avg=3764.71, stdev=594.69, samples=68
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.09%, 4=62.27%, 10=37.44%, 20=0.17%, 50=0.01%
  lat (msec)   : 100=0.02%
  cpu          : usr=2.44%, sys=8.90%, ctx=201525, majf=0, minf=1915
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80897,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.9MiB/s (20.9MB/s), 19.9MiB/s-19.9MiB/s (20.9MB/s-20.9MB/s), io=316MiB (331MB), run=15886-15886msec
  WRITE: bw=14.9MiB/s (15.6MB/s), 14.9MiB/s-14.9MiB/s (15.6MB/s-15.6MB/s), io=500MiB (524MB), run=33633-33633msec

Disk stats (read/write):
  loop3: ios=79821/128051, merge=0/1, ticks=249624/529630, in_queue=779324, util=99.87%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop6/testfile
+ fio fio/verify.fio --filename=/mnt/loop6/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][80.6%][r=20.7MiB/s][r=5310 IOPS][eta 00m:12s]                 
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8724: Tue Sep 21 01:53:52 2021
  read: IOPS=5095, BW=19.9MiB/s (20.9MB/s)(316MiB/15873msec)
    slat (usec): min=7, max=183, avg= 9.20, stdev= 4.69
    clat (usec): min=325, max=15035, avg=3129.45, stdev=577.53
     lat (usec): min=371, max=15045, avg=3138.72, stdev=577.56
    clat percentiles (usec):
     |  1.00th=[ 2278],  5.00th=[ 2343], 10.00th=[ 2376], 20.00th=[ 2704],
     | 30.00th=[ 2868], 40.00th=[ 3163], 50.00th=[ 3228], 60.00th=[ 3261],
     | 70.00th=[ 3294], 80.00th=[ 3425], 90.00th=[ 3621], 95.00th=[ 3720],
     | 99.00th=[ 5604], 99.50th=[ 6063], 99.90th=[ 6587], 99.95th=[ 8160],
     | 99.99th=[14746]
  write: IOPS=3665, BW=14.3MiB/s (15.0MB/s)(500MiB/34920msec); 0 zone resets
    slat (usec): min=9, max=465, avg=24.90, stdev= 8.93
    clat (usec): min=491, max=73496, avg=4338.64, stdev=1362.98
     lat (usec): min=527, max=73516, avg=4363.68, stdev=1363.66
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2474], 10.00th=[ 2704], 20.00th=[ 3720],
     | 30.00th=[ 4080], 40.00th=[ 4293], 50.00th=[ 4424], 60.00th=[ 4621],
     | 70.00th=[ 4752], 80.00th=[ 4948], 90.00th=[ 5211], 95.00th=[ 5473],
     | 99.00th=[ 7373], 99.50th=[ 8029], 99.90th=[17433], 99.95th=[23725],
     | 99.99th=[46924]
   bw (  KiB/s): min= 9496, max=19320, per=99.77%, avg=14628.57, stdev=1426.59, samples=70
   iops        : min= 2374, max= 4830, avg=3657.14, stdev=356.65, samples=70
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.13%, 4=54.50%, 10=45.18%, 20=0.14%, 50=0.04%
  lat (msec)   : 100=0.01%
  cpu          : usr=2.43%, sys=9.55%, ctx=201342, majf=0, minf=1912
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80873,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=19.9MiB/s (20.9MB/s), 19.9MiB/s-19.9MiB/s (20.9MB/s-20.9MB/s), io=316MiB (331MB), run=15873-15873msec
  WRITE: bw=14.3MiB/s (15.0MB/s), 14.3MiB/s-14.3MiB/s (15.0MB/s-15.0MB/s), io=500MiB (524MB), run=34920-34920msec

Disk stats (read/write):
  loop6: ios=80041/128111, merge=0/1, ticks=250035/550052, in_queue=800208, util=99.90%
+ for i in `shuf -i 1-$NN -n $NN`
+ fallocate -o 0 -l 524288000 /mnt/loop2/testfile
+ fio fio/verify.fio --filename=/mnt/loop2/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.2%][r=19.1MiB/s][r=4885 IOPS][eta 00m:16s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8753: Tue Sep 21 01:55:02 2021
  read: IOPS=5145, BW=20.1MiB/s (21.1MB/s)(316MiB/15712msec)
    slat (usec): min=7, max=368, avg= 9.14, stdev= 4.98
    clat (usec): min=244, max=6925, avg=3098.61, stdev=561.83
     lat (usec): min=291, max=6933, avg=3107.82, stdev=561.80
    clat percentiles (usec):
     |  1.00th=[ 2343],  5.00th=[ 2376], 10.00th=[ 2376], 20.00th=[ 2442],
     | 30.00th=[ 2835], 40.00th=[ 3032], 50.00th=[ 3228], 60.00th=[ 3261],
     | 70.00th=[ 3326], 80.00th=[ 3425], 90.00th=[ 3654], 95.00th=[ 3785],
     | 99.00th=[ 5407], 99.50th=[ 5997], 99.90th=[ 6587], 99.95th=[ 6718],
     | 99.99th=[ 6849]
  write: IOPS=2394, BW=9578KiB/s (9807kB/s)(500MiB/53458msec); 0 zone resets
    slat (usec): min=9, max=761, avg=27.46, stdev= 9.62
    clat (usec): min=686, max=34607, avg=6653.12, stdev=1948.49
     lat (usec): min=717, max=34630, avg=6680.74, stdev=1949.10
    clat percentiles (usec):
     |  1.00th=[ 2900],  5.00th=[ 3785], 10.00th=[ 4490], 20.00th=[ 5080],
     | 30.00th=[ 5538], 40.00th=[ 5997], 50.00th=[ 6456], 60.00th=[ 6915],
     | 70.00th=[ 7504], 80.00th=[ 8225], 90.00th=[ 9241], 95.00th=[ 9896],
     | 99.00th=[11207], 99.50th=[12125], 99.90th=[19268], 99.95th=[23725],
     | 99.99th=[29492]
   bw (  KiB/s): min= 6416, max=16448, per=99.91%, avg=9569.89, stdev=1902.35, samples=107
   iops        : min= 1604, max= 4112, avg=2392.47, stdev=475.58, samples=107
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.04%, 4=41.59%, 10=55.64%, 20=2.66%, 50=0.06%
  cpu          : usr=1.95%, sys=7.37%, ctx=202445, majf=0, minf=1910
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80846,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=20.1MiB/s (21.1MB/s), 20.1MiB/s-20.1MiB/s (21.1MB/s-21.1MB/s), io=316MiB (331MB), run=15712-15712msec
  WRITE: bw=9578KiB/s (9807kB/s), 9578KiB/s-9578KiB/s (9807kB/s-9807kB/s), io=500MiB (524MB), run=53458-53458msec

Disk stats (read/write):
  loop2: ios=80593/128083, merge=0/1, ticks=249267/846323, in_queue=1095650, util=99.97%
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
+ umount /mnt/loop1
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop2
+ rm -fr ./loop2
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop4
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop9
+ rm -fr ./loop9
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop5
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop10
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop7
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop3
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ umount /mnt/loop8
+ rm -fr ./loop8
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
+ rm -fr ./loop3
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop8
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop1
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop5
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop10
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop6
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop4
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop7
+ for i in `shuf -i 1-$NN -n $NN`
+ rm -fr ./loop9
+ rm -fr /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
root@dev linux-block #
-- 
2.29.0

