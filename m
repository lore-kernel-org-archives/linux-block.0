Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A40C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 05:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDJFOT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 01:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJFOS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 01:14:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E864273C
        for <linux-block@vger.kernel.org>; Sun,  9 Apr 2023 22:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6Rqzkll30063Qxl2w9WBGBnq6uwycxYWsxnBJEK2+Day8l+83XiwQyxPiYVt7iiJyoAOD7L7kqSHAZK4vxIu1QhOZXMjz4ByC9oPonYq/RgoJnc7uPTfW649I0jM3CZyhnWXjstUb34hQFNdnWLt7gnsH2I2UlXtnkk/xXU3Tctz4s4vEP2ijs6msqqh1M7J5RTANzyfUy0bqAqe4euvsZ1s/5i1dO2UdvbqpBbSqE1RMl1y1R2XPKxj5Yrdu04iuYlpmk4BYxgVng0MeSu6VG2+h4ZQlpwr3afXjKaxbjzptjUzv+ihPv9ouPS1SHoIUfsqBDrLqHKTBo0ZnI4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuIuvDZQSeAaRTuuoLVStP0gmaYEWiIrmnOSHXJRlaE=;
 b=nWN0gMAwMkUPgXc4pjhleNJ/kq4p6JfknsBDe4CE4G/IZlh7xDOzZmDZ24Vv8sURxmtcjTssVVZy85FelYar/BU+1bfC3ede91LPALiGdnwg7nnsR1dxB5yErSzNQoo1kb6ZIPXhfOAGn0PBix2QFX6Ko4mpo2osghSycN+2fCN5q5/lF0als04GVfKXCwm/qL1bebZyt6rmlXOK6XkZ5Whal50iN3G1VECmSpTGZFUx2llhUNEAY1esThIWlErHvp6yEF/YxvQFRZggc3e2BOtD4aCBsK1DVN3xEkdGpPG7MUb5m+/kr0PZJFDSFdh69G21dGYPdmQnz3yKNJ6QGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuIuvDZQSeAaRTuuoLVStP0gmaYEWiIrmnOSHXJRlaE=;
 b=sj62F/o9zpoadCdtnV4Y8+4QbXN6JCIGTc3CKokmwRnN3yMtVG4WCwA68hJgNMUOi1cEwZ4qKCxUj7bc6GuMeR/XfKKZqCwP0pNjwPL4R8CWbHZq7X17AuwSCXndflX4BRX0lmGGtHa1mSUf3rsirajDQIEl0RD9wNAxhSrChApnxIYv/Q1tL4T5qED3bFZ1w31pbUPSbeR0y6lBsveJSjiYo5HT4sb6Sr5D7+GLk7/k5SoH8j1qrO6X/Xfy7s/EyIUzC+Dk6p66hJ+/K0MHy62pmSNONpNdwAsKlJj3WS2Kt9NHepDqFDCOYFJuFVOqTo9kvwkJK6zO0+Ge/8OeCA==
Received: from MW4PR04CA0031.namprd04.prod.outlook.com (2603:10b6:303:6a::6)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 05:14:09 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::9b) by MW4PR04CA0031.outlook.office365.com
 (2603:10b6:303:6a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 05:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 05:14:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 9 Apr 2023
 22:14:00 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 9 Apr 2023
 22:13:59 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 0/1 null_blk: add modparam checks
Date:   Sun, 9 Apr 2023 22:13:51 -0700
Message-ID: <20230410051352.36856-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6b6380-5b02-4df7-f53b-08db39826a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XQ/2GWZt88LjYQDC6IQuOuFnSstCZ1Em66+3wAWNN3XiwJ5xEaOrtUpBZZ5HmEwu8+U2zdxfzNSWXTP3X8CzgUXlG7kP9qIFfRbpccIvnCF4Vk4GWtBZugBm+sJNb8QQEDgsCIORT+lcirXGN4z4CLTn8FZlh0ADLsoXR7vB4kNVaySNGMBm3uyxtzAZX5YglUL8rXbAH0j4B0ew02LjmBgMmvqYstfULcGlsDcVoyscJsbITVs47zek0Z9rqlVfklH/Xdd4wYjm9ABfyTgSnE/Dg26DCAO6qZwygd+TEMWw/fS4naLSfJ5SlV2JxSz16XfeefEP1PeO6K4ZtKtGb41sJdK6WPCBBOvjPtZaMSFKubAYGbMWtXArj519V0Qgy+Cnqz75PJNUramCQ9mDL5QKP0iNUuIDugziHPgAiR4CX1Ob2bW1Vu1LlATQNVWzXaJrjoCyHfTBWHxm6RujRiD/eb6xkm54exb+8zi83ivNo8bqzsVBqu2HK9ywgZqDyzuMMc+N1PZ710d3Q4ls2n1TOGdmSiUUQSVsGSw6L+KV+F/yXxoeFGoM2rY31GTwfjeWsIiOO0phpldeF0oEIisO0yDEQuBJnsrEGxt4f81sKlWe5ks8xwm/wbzkPGQ9qKa/rvl8Uar3A8MI7KzgwYpT7gzs9UgyPPd1dkrNkqo/sR0DEUlLhckzsdo8EiKnI+H8H5N0haK3P1iuqtfovQxQdWLY0mNIrs8kr4/9eA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39850400004)(346002)(451199021)(46966006)(36840700001)(478600001)(45080400002)(7696005)(316002)(54906003)(1076003)(26005)(16526019)(186003)(6666004)(2906002)(30864003)(4326008)(70586007)(70206006)(41300700001)(6916009)(8936002)(5660300002)(82310400005)(8676002)(7636003)(356005)(82740400003)(40480700001)(36756003)(83380400001)(47076005)(2616005)(36860700001)(426003)(336012)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 05:14:09.3848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6b6380-5b02-4df7-f53b-08db39826a52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Some of the null_blk parameters are defined as int which can lead to
unwanted behaviour with certain values. One of such an example is using
large values for poll_queues parameter, previously it used to result in
OOPs see at the end [1] and now it results in warning, see testlog.
E.g. setting up -2 for poll_queues actually tries to allocate memory
instead of returning error.

Add modpram validation callbacks to make sure we will not allow
users to set unintended values even by mistake and generate appropriate
error without any futher processing.

Please note that this is needed to write a big daddy testcase where it
uses all possible big values for the module parameters and make sure 
block layers tag allocation works without any OOPs and errors out
gracefully.

Below is the test result with and without this where appriparite error
is returned for modparams listed below. 
     submit_queues
     poll_queues
     queue_mode
     gb
     max_sectors
     irqmode
     hw_qdepth

-ck

v2:- 

Merge everything into one patch and only check for invalid
integer values for :-
     submit_queues
     poll_queues
     queue_mode
     gb
     max_sectors
     irqmode
     hw_qdepth

Chaitanya Kulkarni (1):
  null_blk: add moddule parameter check

 drivers/block/null_blk/main.c | 85 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

linux-block (nullb-mod-parm) # ./test-mod-param.sh 
Switched to branch 'for-next'
Your branch is ahead of 'origin/for-next' by 36 commits.
  (use "git push" to publish your local commits)
commit 09f3673266b05a8885ef309b33f53735de082c0e (HEAD -> for-next)
Merge: dba270c5627a 064c5a3dc420
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Sat Apr 8 00:55:33 2023 -0700

    Merge branch 'for-next' of git://git.kernel.dk/linux-block into for-next
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
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
+ HOST_DEST=/lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.1M Apr  9 21:44 /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=2
[25720.548250] null_blk: disk nullb0 created
[25720.548259] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[25720.841460] null_blk: disk nullb0 created
[25720.841465] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[25721.147425] null_blk: disk nullb0 created
[25721.147429] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16
[25721.439756] null_blk: disk nullb0 created
[25721.439761] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[25721.738713] null_blk: disk nullb0 created
[25721.738718] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
[25722.029984] ------------[ cut here ]------------
[25722.029989] WARNING: CPU: 23 PID: 28750 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[25722.029996] Modules linked in: null_blk(O+) ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[25722.030020] CPU: 23 PID: 28750 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[25722.030022] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[25722.030023] RIP: 0010:group_cpus_evenly+0x26e/0x280
[25722.030026] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[25722.030027] RSP: 0018:ffffc90000bdfcb8 EFLAGS: 00010287
[25722.030028] RAX: 0000000080000000 RBX: 0000000000000040 RCX: 0000000000000000
[25722.030029] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[25722.030063] RBP: ffff8887085b56c8 R08: ffff8887085b5290 R09: ffff88870db40000
[25722.030063] R10: ffff8887085b5290 R11: 0000000000000000 R12: ffff88870db40000
[25722.030064] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[25722.030066] FS:  00007f7b0d332b80(0000) GS:ffff8897df7c0000(0000) knlGS:0000000000000000
[25722.030067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[25722.030068] CR2: 00007f7b0cf06800 CR3: 000000073a8f8000 CR4: 0000000000350ee0
[25722.030070] DR0: ffffffff8436643c DR1: ffffffff8436643d DR2: ffffffff8436643e
[25722.030071] DR3: ffffffff8436643f DR6: 00000000ffff0ff0 DR7: 0000000000000600
[25722.030072] Call Trace:
[25722.030074]  <TASK>
[25722.030075]  blk_mq_map_queues+0x16/0xc0
[25722.030079]  null_map_queues+0xa5/0xe0 [null_blk]
[25722.030084]  blk_mq_alloc_tag_set+0x14d/0x3f0
[25722.030088]  ? __kmalloc+0xbc/0x130
[25722.030091]  null_add_dev.part.0+0x601/0x700 [null_blk]
[25722.030096]  null_init+0x109/0xff0 [null_blk]
[25722.030101]  ? __pfx_init_module+0x10/0x10 [null_blk]
[25722.030106]  do_one_initcall+0x44/0x220
[25722.030110]  ? kmalloc_trace+0x25/0x90
[25722.030120]  do_init_module+0x4c/0x210
[25722.030123]  __do_sys_finit_module+0xb4/0x130
[25722.030141]  do_syscall_64+0x3b/0x90
[25722.030145]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[25722.030147] RIP: 0033:0x7f7b0cf2c15d
[25722.030149] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[25722.030150] RSP: 002b:00007fff080a3148 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[25722.030151] RAX: ffffffffffffffda RBX: 00005577402eeb90 RCX: 00007f7b0cf2c15d
[25722.030152] RDX: 0000000000000000 RSI: 00005577402eef00 RDI: 0000000000000003
[25722.030153] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[25722.030154] R10: 0000000000000003 R11: 0000000000000246 R12: 00005577402eef00
[25722.030154] R13: 00005577402eecc0 R14: 00005577402eeb90 R15: 00005577402eef20
[25722.030156]  </TASK>
[25722.030156] ---[ end trace 0000000000000000 ]---
[25722.033102] null_blk: disk nullb0 created
[25722.033104] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=128
[25722.328873] ------------[ cut here ]------------
[25722.328877] WARNING: CPU: 27 PID: 28758 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[25722.328886] Modules linked in: null_blk(O+) ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[25722.328921] CPU: 27 PID: 28758 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[25722.328923] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[25722.328925] RIP: 0010:group_cpus_evenly+0x26e/0x280
[25722.328928] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[25722.328930] RSP: 0018:ffffc90000d63cb8 EFLAGS: 00010283
[25722.328933] RAX: 0000000080000000 RBX: 0000000000000080 RCX: 0000000000000000
[25722.328934] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[25722.328936] RBP: ffff88811b41c948 R08: ffff88811b41c9c8 R09: ffff889137700000
[25722.328967] R10: ffff88811b41c9c8 R11: 0000000000000000 R12: ffff889137700000
[25722.328968] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[25722.328971] FS:  00007f2d0f328b80(0000) GS:ffff8897df8c0000(0000) knlGS:0000000000000000
[25722.328973] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[25722.328974] CR2: 00007f2d0ef06800 CR3: 0000000712f0e000 CR4: 0000000000350ee0
[25722.328977] DR0: ffffffff8436644c DR1: ffffffff8436644d DR2: ffffffff8436644e
[25722.328978] DR3: ffffffff8436644f DR6: 00000000ffff0ff0 DR7: 0000000000000600
[25722.328980] Call Trace:
[25722.328983]  <TASK>
[25722.328985]  blk_mq_map_queues+0x16/0xc0
[25722.328990]  null_map_queues+0xa5/0xe0 [null_blk]
[25722.328999]  blk_mq_alloc_tag_set+0x14d/0x3f0
[25722.329003]  ? __kmalloc+0xbc/0x130
[25722.329008]  null_add_dev.part.0+0x601/0x700 [null_blk]
[25722.329016]  null_init+0x109/0xff0 [null_blk]
[25722.329024]  ? __pfx_init_module+0x10/0x10 [null_blk]
[25722.329031]  do_one_initcall+0x44/0x220
[25722.329036]  ? kmalloc_trace+0x25/0x90
[25722.329039]  do_init_module+0x4c/0x210
[25722.329044]  __do_sys_finit_module+0xb4/0x130
[25722.329049]  do_syscall_64+0x3b/0x90
[25722.329054]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[25722.329057] RIP: 0033:0x7f2d0ef2c15d
[25722.329059] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[25722.329072] RSP: 002b:00007ffd836b3478 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[25722.329074] RAX: ffffffffffffffda RBX: 0000562d35611b90 RCX: 00007f2d0ef2c15d
[25722.329076] RDX: 0000000000000000 RSI: 0000562d35611f00 RDI: 0000000000000003
[25722.329077] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[25722.329078] R10: 0000000000000003 R11: 0000000000000246 R12: 0000562d35611f00
[25722.329079] R13: 0000562d35611cc0 R14: 0000562d35611b90 R15: 0000562d35611f20
[25722.329082]  </TASK>
[25722.329082] ---[ end trace 0000000000000000 ]---
[25722.335826] null_blk: disk nullb0 created
[25722.335830] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=256
[25722.634652] ------------[ cut here ]------------
[25722.634655] WARNING: CPU: 27 PID: 28766 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[25722.634662] Modules linked in: null_blk(O+) ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[25722.634687] CPU: 27 PID: 28766 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[25722.634689] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[25722.634690] RIP: 0010:group_cpus_evenly+0x26e/0x280
[25722.634693] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[25722.634694] RSP: 0018:ffffc90000d8bcb8 EFLAGS: 00010287
[25722.634695] RAX: 0000000080000000 RBX: 0000000000000100 RCX: 0000000000000000
[25722.634696] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[25722.634697] RBP: ffff88815612d588 R08: ffff88815612dc20 R09: ffff8882f9300000
[25722.634698] R10: ffff88815612dc20 R11: 0000000000000000 R12: ffff8882f9300000
[25722.634699] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[25722.634729] FS:  00007f1994034b80(0000) GS:ffff8897df8c0000(0000) knlGS:0000000000000000
[25722.634730] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[25722.634731] CR2: 00007f1993b06800 CR3: 000000017a920000 CR4: 0000000000350ee0
[25722.634733] DR0: ffffffff8436644c DR1: ffffffff8436644d DR2: ffffffff8436644e
[25722.634734] DR3: ffffffff8436644f DR6: 00000000ffff0ff0 DR7: 0000000000000600
[25722.634734] Call Trace:
[25722.634737]  <TASK>
[25722.634738]  blk_mq_map_queues+0x16/0xc0
[25722.634742]  null_map_queues+0xa5/0xe0 [null_blk]
[25722.634748]  blk_mq_alloc_tag_set+0x14d/0x3f0
[25722.634751]  ? __kmalloc+0xbc/0x130
[25722.634755]  null_add_dev.part.0+0x601/0x700 [null_blk]
[25722.634760]  null_init+0x109/0xff0 [null_blk]
[25722.634765]  ? __pfx_init_module+0x10/0x10 [null_blk]
[25722.634779]  do_one_initcall+0x44/0x220
[25722.634783]  ? kmalloc_trace+0x25/0x90
[25722.634784]  do_init_module+0x4c/0x210
[25722.634788]  __do_sys_finit_module+0xb4/0x130
[25722.634792]  do_syscall_64+0x3b/0x90
[25722.634796]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[25722.634798] RIP: 0033:0x7f1993b2c15d
[25722.634800] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[25722.634801] RSP: 002b:00007ffc2285dea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[25722.634802] RAX: ffffffffffffffda RBX: 00005638cb918b90 RCX: 00007f1993b2c15d
[25722.634803] RDX: 0000000000000000 RSI: 00005638cb918f00 RDI: 0000000000000003
[25722.634804] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[25722.634805] R10: 0000000000000003 R11: 0000000000000246 R12: 00005638cb918f00
[25722.634811] R13: 00005638cb918cc0 R14: 00005638cb918b90 R15: 00005638cb918f20
[25722.634813]  </TASK>
[25722.634813] ---[ end trace 0000000000000000 ]---
[25722.643471] null_blk: disk nullb0 created
[25722.643475] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=512
[25722.936133] ------------[ cut here ]------------
[25722.936137] WARNING: CPU: 26 PID: 28773 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[25722.936146] Modules linked in: null_blk(O+) ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[25722.936182] CPU: 26 PID: 28773 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[25722.936184] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[25722.936186] RIP: 0010:group_cpus_evenly+0x26e/0x280
[25722.936189] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[25722.936191] RSP: 0018:ffffc90000debcb8 EFLAGS: 00010287
[25722.936193] RAX: 0000000080000000 RBX: 0000000000000200 RCX: 0000000000000000
[25722.936195] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[25722.936196] RBP: ffff888722822680 R08: ffff888722822e00 R09: ffff88945b200000
[25722.936197] R10: ffff888722822e00 R11: 0000000000000000 R12: ffff88945b200000
[25722.936198] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[25722.936201] FS:  00007f9223deab80(0000) GS:ffff8897df880000(0000) knlGS:0000000000000000
[25722.936230] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[25722.936231] CR2: 00007ffe7e142b08 CR3: 0000000593858000 CR4: 0000000000350ee0
[25722.936234] DR0: ffffffff84366448 DR1: ffffffff84366449 DR2: ffffffff8436644a
[25722.936236] DR3: ffffffff8436644b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[25722.936237] Call Trace:
[25722.936239]  <TASK>
[25722.936241]  blk_mq_map_queues+0x16/0xc0
[25722.936246]  null_map_queues+0xa5/0xe0 [null_blk]
[25722.936255]  blk_mq_alloc_tag_set+0x14d/0x3f0
[25722.936259]  ? __kmalloc+0xbc/0x130
[25722.936264]  null_add_dev.part.0+0x601/0x700 [null_blk]
[25722.936272]  null_init+0x109/0xff0 [null_blk]
[25722.936280]  ? __pfx_init_module+0x10/0x10 [null_blk]
[25722.936287]  do_one_initcall+0x44/0x220
[25722.936292]  ? kmalloc_trace+0x25/0x90
[25722.936295]  do_init_module+0x4c/0x210
[25722.936300]  __do_sys_finit_module+0xb4/0x130
[25722.936305]  do_syscall_64+0x3b/0x90
[25722.936310]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[25722.936313] RIP: 0033:0x7f9223f1115d
[25722.936315] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[25722.936317] RSP: 002b:00007ffe7e145b08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[25722.936319] RAX: ffffffffffffffda RBX: 000055a41b507b90 RCX: 00007f9223f1115d
[25722.936320] RDX: 0000000000000000 RSI: 000055a41b507f00 RDI: 0000000000000003
[25722.936321] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[25722.936322] R10: 0000000000000003 R11: 0000000000000246 R12: 000055a41b507f00
[25722.936323] R13: 000055a41b507cc0 R14: 000055a41b507b90 R15: 000055a41b507f20
[25722.936326]  </TASK>
[25722.936327] ---[ end trace 0000000000000000 ]---
[25722.956194] null_blk: disk nullb0 created
[25722.956199] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=1024
[25723.263410] ------------[ cut here ]------------
[25723.263416] WARNING: CPU: 26 PID: 28780 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[25723.263461] Modules linked in: null_blk(O+) ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[25723.263503] CPU: 26 PID: 28780 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[25723.263506] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[25723.263509] RIP: 0010:group_cpus_evenly+0x26e/0x280
[25723.263513] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[25723.263515] RSP: 0018:ffffc90000dfbcb8 EFLAGS: 00010287
[25723.263518] RAX: 0000000080000000 RBX: 0000000000000400 RCX: 0000000000000000
[25723.263520] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[25723.263522] RBP: ffff888703c8a470 R08: ffff888703c8a4b0 R09: ffff8883f4b00000
[25723.263523] R10: ffff888703c8a4b0 R11: 0000000000000000 R12: ffff8883f4b00000
[25723.263525] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[25723.263528] FS:  00007f9b016efb80(0000) GS:ffff8897df880000(0000) knlGS:0000000000000000
[25723.263530] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[25723.263532] CR2: 00007f9b01306800 CR3: 000000014fcec000 CR4: 0000000000350ee0
[25723.263548] DR0: ffffffff84366448 DR1: ffffffff84366449 DR2: ffffffff8436644a
[25723.263550] DR3: ffffffff8436644b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[25723.263551] Call Trace:
[25723.263554]  <TASK>
[25723.263557]  blk_mq_map_queues+0x16/0xc0
[25723.263562]  null_map_queues+0xa5/0xe0 [null_blk]
[25723.263573]  blk_mq_alloc_tag_set+0x14d/0x3f0
[25723.263578]  ? __kmalloc+0xbc/0x130
[25723.263584]  null_add_dev.part.0+0x601/0x700 [null_blk]
[25723.263594]  null_init+0x109/0xff0 [null_blk]
[25723.263604]  ? __pfx_init_module+0x10/0x10 [null_blk]
[25723.263613]  do_one_initcall+0x44/0x220
[25723.263619]  ? kmalloc_trace+0x25/0x90
[25723.263622]  do_init_module+0x4c/0x210
[25723.263628]  __do_sys_finit_module+0xb4/0x130
[25723.263634]  do_syscall_64+0x3b/0x90
[25723.263639]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[25723.263643] RIP: 0033:0x7f9b0132c15d
[25723.263645] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[25723.263647] RSP: 002b:00007ffdc70ebd68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[25723.263650] RAX: ffffffffffffffda RBX: 0000558ca1caab90 RCX: 00007f9b0132c15d
[25723.263651] RDX: 0000000000000000 RSI: 0000558ca1caaf00 RDI: 0000000000000003
[25723.263653] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[25723.263654] R10: 0000000000000003 R11: 0000000000000246 R12: 0000558ca1caaf00
[25723.263656] R13: 0000558ca1caacc0 R14: 0000558ca1caab90 R15: 0000558ca1caaf20
[25723.263659]  </TASK>
[25723.263660] ---[ end trace 0000000000000000 ]---
[25723.295550] null_blk: disk nullb0 created
[25723.295554] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2048
[25723.614835] ------------[ cut here ]------------
[25723.614840] WARNING: CPU: 26 PID: 28787 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[25723.614848] Modules linked in: null_blk(O+) ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[25723.614913] CPU: 26 PID: 28787 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[25723.614915] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[25723.614917] RIP: 0010:group_cpus_evenly+0x26e/0x280
[25723.614920] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[25723.614922] RSP: 0018:ffffc90000dfbcb8 EFLAGS: 00010287
[25723.614925] RAX: 0000000080000000 RBX: 0000000000000800 RCX: 0000000000000000
[25723.614926] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[25723.614928] RBP: ffff888164dfa708 R08: ffff888164dfa130 R09: ffff88871ac00000
[25723.614929] R10: ffff888164dfa130 R11: 0000000000000000 R12: ffff88871ac00000
[25723.614930] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[25723.614933] FS:  00007fabd7dedb80(0000) GS:ffff8897df880000(0000) knlGS:0000000000000000
[25723.614934] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[25723.614936] CR2: 00007fabd7906800 CR3: 0000000705338000 CR4: 0000000000350ee0
[25723.614939] DR0: ffffffff84366448 DR1: ffffffff84366449 DR2: ffffffff8436644a
[25723.614940] DR3: ffffffff8436644b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[25723.614952] Call Trace:
[25723.614955]  <TASK>
[25723.614957]  blk_mq_map_queues+0x16/0xc0
[25723.614962]  null_map_queues+0xa5/0xe0 [null_blk]
[25723.614971]  blk_mq_alloc_tag_set+0x14d/0x3f0
[25723.614975]  ? __kmalloc+0xbc/0x130
[25723.614980]  null_add_dev.part.0+0x601/0x700 [null_blk]
[25723.614988]  null_init+0x109/0xff0 [null_blk]
[25723.614995]  ? __pfx_init_module+0x10/0x10 [null_blk]
[25723.615003]  do_one_initcall+0x44/0x220
[25723.615008]  ? kmalloc_trace+0x25/0x90
[25723.615010]  do_init_module+0x4c/0x210
[25723.615015]  __do_sys_finit_module+0xb4/0x130
[25723.615020]  do_syscall_64+0x3b/0x90
[25723.615025]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[25723.615029] RIP: 0033:0x7fabd792c15d
[25723.615031] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[25723.615032] RSP: 002b:00007ffe996e5048 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[25723.615034] RAX: ffffffffffffffda RBX: 000055d5ca779b90 RCX: 00007fabd792c15d
[25723.615035] RDX: 0000000000000000 RSI: 000055d5ca779f00 RDI: 0000000000000003
[25723.615037] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[25723.615038] R10: 0000000000000003 R11: 0000000000000246 R12: 000055d5ca779f00
[25723.615039] R13: 000055d5ca779cc0 R14: 000055d5ca779b90 R15: 000055d5ca779f20
[25723.615041]  </TASK>
[25723.615042] ---[ end trace 0000000000000000 ]---
[25723.673688] null_blk: disk nullb0 created
[25723.673693] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4096
[25724.019087] ------------[ cut here ]------------
[25724.019092] WARNING: CPU: 26 PID: 28794 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[25724.019099] Modules linked in: null_blk(O+) ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[25724.019124] CPU: 26 PID: 28794 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[25724.019126] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[25724.019156] RIP: 0010:group_cpus_evenly+0x26e/0x280
[25724.019158] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[25724.019160] RSP: 0018:ffffc90000dfbcb8 EFLAGS: 00010287
[25724.019161] RAX: 0000000080000000 RBX: 0000000000001000 RCX: 0000000000000000
[25724.019162] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[25724.019163] RBP: ffff888731500358 R08: ffff8887315007f0 R09: ffff8885b5c00000
[25724.019164] R10: ffff8887315007f0 R11: 0000000000000000 R12: ffff8885b5c00000
[25724.019165] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[25724.019167] FS:  00007fb28a0eeb80(0000) GS:ffff8897df880000(0000) knlGS:0000000000000000
[25724.019168] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[25724.019169] CR2: 00007fb289d06800 CR3: 000000011ed02000 CR4: 0000000000350ee0
[25724.019171] DR0: ffffffff84366448 DR1: ffffffff84366449 DR2: ffffffff8436644a
[25724.019172] DR3: ffffffff8436644b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[25724.019179] Call Trace:
[25724.019188]  <TASK>
[25724.019190]  blk_mq_map_queues+0x16/0xc0
[25724.019193]  null_map_queues+0xa5/0xe0 [null_blk]
[25724.019199]  blk_mq_alloc_tag_set+0x14d/0x3f0
[25724.019203]  ? __kmalloc+0xbc/0x130
[25724.019206]  null_add_dev.part.0+0x601/0x700 [null_blk]
[25724.019211]  null_init+0x109/0xff0 [null_blk]
[25724.019216]  ? __pfx_init_module+0x10/0x10 [null_blk]
[25724.019221]  do_one_initcall+0x44/0x220
[25724.019225]  ? kmalloc_trace+0x25/0x90
[25724.019226]  do_init_module+0x4c/0x210
[25724.019230]  __do_sys_finit_module+0xb4/0x130
[25724.019233]  do_syscall_64+0x3b/0x90
[25724.019237]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[25724.019240] RIP: 0033:0x7fb289d2c15d
[25724.019242] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[25724.019243] RSP: 002b:00007ffe3900faf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[25724.019244] RAX: ffffffffffffffda RBX: 00005577f55a9b90 RCX: 00007fb289d2c15d
[25724.019245] RDX: 0000000000000000 RSI: 00005577f55a9f00 RDI: 0000000000000003
[25724.019246] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[25724.019246] R10: 0000000000000003 R11: 0000000000000246 R12: 00005577f55a9f00
[25724.019247] R13: 00005577f55a9cc0 R14: 00005577f55a9b90 R15: 00005577f55a9f20
[25724.019249]  </TASK>
[25724.019249] ---[ end trace 0000000000000000 ]---
[25724.139223] null_blk: disk nullb0 created
[25724.139229] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8192
[25724.761480] null_blk: disk nullb0 created
[25724.761485] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16384
[25725.720371] null_blk: disk nullb0 created
[25725.720376] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32768
[25727.361811] null_blk: disk nullb0 created
[25727.361816] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=65536
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=131072
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=262144
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=524288
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=1048576
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=2097152
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=4194304
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=8388608
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=16777216
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=33554432
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=67108864
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=134217728
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=268435456
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=536870912
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=1073741824
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Numerical result out of range
[25732.742080] null_blk: `2147483648' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Numerical result out of range
[25733.029883] null_blk: `4294967296' invalid for parameter `poll_queues'

###################################################
hw_queue_depth:
------------------------------------
modprobe null_blk hw_queue_depth=-2
[25735.976194] blk-mq: reduced tag depth to 10240
[25735.977894] null_blk: disk nullb0 created
[25735.977897] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=-1
[25736.032741] blk-mq: reduced tag depth to 10240
[25736.035035] null_blk: disk nullb0 created
[25736.035038] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
------------------------------------
modprobe null_blk hw_queue_depth=1
[25736.104180] null_blk: disk nullb0 created
[25736.104183] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=2
[25736.152827] null_blk: disk nullb0 created
[25736.152831] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=4
[25736.191686] null_blk: disk nullb0 created
[25736.191691] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=8
[25736.236288] null_blk: disk nullb0 created
[25736.236326] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=32
[25736.280051] null_blk: disk nullb0 created
[25736.280055] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=64
[25736.325196] null_blk: disk nullb0 created
[25736.325199] null_blk: module loaded

###################################################
max_sectors:
------------------------------------
modprobe null_blk max_sectors=-2
[25737.784659] null_blk: invalid max sectors
[25737.784665] null_blk: defaults max sectors to 2560
[25737.785964] null_blk: disk nullb0 created
[25737.785966] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=-1
[25737.824394] null_blk: invalid max sectors
[25737.824399] null_blk: defaults max sectors to 2560
[25737.825783] null_blk: disk nullb0 created
[25737.825785] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=0
[25737.870114] null_blk: disk nullb0 created
[25737.870118] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=1
[25737.922026] blk_queue_max_hw_sectors: set to minimum 8
[25737.923223] null_blk: disk nullb0 created
[25737.923225] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=2
[25737.964348] blk_queue_max_hw_sectors: set to minimum 8
[25737.965622] null_blk: disk nullb0 created
[25737.965625] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=4
[25738.007240] blk_queue_max_hw_sectors: set to minimum 8
[25738.008532] null_blk: disk nullb0 created
[25738.008535] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=8
[25738.058329] null_blk: disk nullb0 created
[25738.058332] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=32
[25738.105822] null_blk: disk nullb0 created
[25738.105825] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=64
[25738.154011] null_blk: disk nullb0 created
[25738.154014] null_blk: module loaded

###################################################
gb:
------------------------------------
modprobe null_blk gb=-2
[25739.200312] null_blk: disk nullb0 created
[25739.200316] null_blk: module loaded
------------------------------------
modprobe null_blk gb=-1
[25739.252216] null_blk: disk nullb0 created
[25739.252220] null_blk: module loaded
------------------------------------
modprobe null_blk gb=0
[25739.299620] null_blk: disk nullb0 created
[25739.299624] null_blk: module loaded
------------------------------------
modprobe null_blk gb=1
[25739.350625] null_blk: disk nullb0 created
[25739.350629] null_blk: module loaded
------------------------------------
modprobe null_blk gb=2
[25739.405183] null_blk: disk nullb0 created
[25739.405187] null_blk: module loaded
------------------------------------
modprobe null_blk gb=4
[25739.454612] null_blk: disk nullb0 created
[25739.454616] null_blk: module loaded
------------------------------------
modprobe null_blk gb=8
[25739.499595] null_blk: disk nullb0 created
[25739.499598] null_blk: module loaded
------------------------------------
modprobe null_blk gb=32
[25739.540085] null_blk: disk nullb0 created
[25739.540089] null_blk: module loaded
------------------------------------
modprobe null_blk gb=64
[25739.583125] null_blk: disk nullb0 created
[25739.583129] null_blk: module loaded

###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=-2
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
------------------------------------
modprobe null_blk poll_queues=0
[25740.681186] null_blk: disk nullb0 created
[25740.681191] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=1
[25740.726289] null_blk: disk nullb0 created
[25740.726292] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2
[25740.779187] null_blk: disk nullb0 created
[25740.779191] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[25740.830242] null_blk: disk nullb0 created
[25740.830245] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[25740.877588] null_blk: disk nullb0 created
[25740.877591] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[25740.925187] null_blk: disk nullb0 created
[25740.925191] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
[25740.967645] ------------[ cut here ]------------
[25740.967649] WARNING: CPU: 24 PID: 29063 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[25740.967659] Modules linked in: null_blk(O+) ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[25740.967723] CPU: 24 PID: 29063 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[25740.967726] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[25740.967728] RIP: 0010:group_cpus_evenly+0x26e/0x280
[25740.967732] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[25740.967735] RSP: 0018:ffffc900011ffcb8 EFLAGS: 00010287
[25740.967737] RAX: 0000000080000000 RBX: 0000000000000040 RCX: 0000000000000000
[25740.967739] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[25740.967741] RBP: ffff8881514df818 R08: ffff8881514df690 R09: ffff88823f250000
[25740.967742] R10: ffff8881514df690 R11: 0000000000000000 R12: ffff88823f250000
[25740.967744] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[25740.967747] FS:  00007f9777bc9b80(0000) GS:ffff8897df800000(0000) knlGS:0000000000000000
[25740.967780] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[25740.967782] CR2: 00007f9777706800 CR3: 000000011d00c000 CR4: 0000000000350ee0
[25740.967786] DR0: ffffffff843663e1 DR1: ffffffff843663e2 DR2: ffffffff843663e3
[25740.967787] DR3: ffffffff843663e3 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[25740.967788] Call Trace:
[25740.967791]  <TASK>
[25740.967794]  blk_mq_map_queues+0x16/0xc0
[25740.967800]  null_map_queues+0xa5/0xe0 [null_blk]
[25740.967811]  blk_mq_alloc_tag_set+0x14d/0x3f0
[25740.967816]  ? __kmalloc+0xbc/0x130
[25740.967822]  null_add_dev.part.0+0x601/0x700 [null_blk]
[25740.967832]  null_init+0x109/0xff0 [null_blk]
[25740.967841]  ? __pfx_init_module+0x10/0x10 [null_blk]
[25740.967851]  do_one_initcall+0x44/0x220
[25740.967857]  ? kmalloc_trace+0x25/0x90
[25740.967860]  do_init_module+0x4c/0x210
[25740.967865]  __do_sys_finit_module+0xb4/0x130
[25740.967872]  do_syscall_64+0x3b/0x90
[25740.967877]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[25740.967896] RIP: 0033:0x7f977772c15d
[25740.967898] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[25740.967900] RSP: 002b:00007ffe86643738 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[25740.967903] RAX: ffffffffffffffda RBX: 0000561d63c6ab90 RCX: 00007f977772c15d
[25740.967904] RDX: 0000000000000000 RSI: 0000561d63c6af00 RDI: 0000000000000003
[25740.967906] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[25740.967907] R10: 0000000000000003 R11: 0000000000000246 R12: 0000561d63c6af00
[25740.967909] R13: 0000561d63c6acc0 R14: 0000561d63c6ab90 R15: 0000561d63c6af20
[25740.967912]  </TASK>
[25740.967913] ---[ end trace 0000000000000000 ]---
[25740.971391] null_blk: disk nullb0 created
[25740.971393] null_blk: module loaded

###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=-2
[25743.163625] null_blk: disk nullb0 created
[25743.163630] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=-1
[25743.211020] null_blk: disk nullb0 created
[25743.211025] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=0
[25743.246247] null_blk: disk nullb0 created
[25743.246252] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1
[25743.300390] null_blk: disk nullb0 created
[25743.300395] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2
[25743.347417] null_blk: disk nullb0 created
[25743.347422] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[25743.402417] null_blk: disk nullb0 created
[25743.402420] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[25743.443739] null_blk: disk nullb0 created
[25743.443743] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[25743.484472] null_blk: disk nullb0 created
[25743.484477] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[25743.528645] null_blk: disk nullb0 created
[25743.528657] null_blk: module loaded

###################################################
queue_mode:
------------------------------------
modprobe null_blk queue_mode=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25745.048857] null_blk: `-2' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25745.076140] null_blk: `-1' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=0
[25745.108788] null_blk: disk nullb0 created
[25745.108792] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25745.152697] null_blk: legacy IO path is no longer available
------------------------------------
modprobe null_blk queue_mode=2
[25745.182242] null_blk: disk nullb0 created
[25745.182245] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25745.228851] null_blk: `4' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25745.258338] null_blk: `8' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25745.290121] null_blk: `32' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25745.323816] null_blk: `64' invalid for parameter `queue_mode'

###################################################
bs:
------------------------------------
modprobe null_blk bs=-2
[25746.529260] null_blk: invalid block size
[25746.529264] null_blk: defaults block size to 4096
[25746.530976] null_blk: disk nullb0 created
[25746.530978] null_blk: module loaded
------------------------------------
modprobe null_blk bs=-1
[25746.583379] null_blk: invalid block size
[25746.583428] null_blk: defaults block size to 4096
[25746.585011] null_blk: disk nullb0 created
[25746.585013] null_blk: module loaded
------------------------------------
modprobe null_blk bs=0
[25746.635050] null_blk: disk nullb0 created
[25746.635055] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1
[25746.691418] null_blk: disk nullb0 created
[25746.691422] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2
[25746.741540] null_blk: disk nullb0 created
[25746.741543] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4
[25746.786945] null_blk: disk nullb0 created
[25746.786948] null_blk: module loaded
------------------------------------
modprobe null_blk bs=8
[25746.828373] null_blk: disk nullb0 created
[25746.828377] null_blk: module loaded
------------------------------------
modprobe null_blk bs=32
[25746.871969] null_blk: disk nullb0 created
[25746.871973] null_blk: module loaded
------------------------------------
modprobe null_blk bs=64
[25746.926162] null_blk: disk nullb0 created
[25746.926165] null_blk: module loaded
------------------------------------
modprobe null_blk bs=512
[25746.968006] null_blk: disk nullb0 created
[25746.968010] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1024
[25747.022896] null_blk: disk nullb0 created
[25747.022899] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2048
[25747.065831] null_blk: disk nullb0 created
[25747.065833] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4096
[25747.109693] null_blk: disk nullb0 created
[25747.109697] null_blk: module loaded

Switched to branch 'nullb-mod-parm'
commit 4dae3e7d1264deea1b1257ba4cf73396cfe0ab0e (HEAD -> nullb-mod-parm)
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Tue Apr 4 15:36:21 2023 -0700

    null_blk: add moddule parameter check
    
    Move null_param_store_int() function to the top of the code so that
    it can be accessed by the new NULL_PARAM() macro. The macro takes
    name of the module parameter, minimum value, and maximum value as
    input, then creates specific callback functions and kernel_param
    ops for each module parameter. This macro ultimately calls the
    null_param_store_int() function, which returns an error if the
    user-provided value is out of bounds(min,max).
    
    To prevent negative values from being set by the user for following
    list of module parameters, uses NULL_PARM() macro to add user input
    validation:
            submit_queues
            poll_queues
            queue_mode
            gb
            max_sectors
            irqmode
            hw_qdepth
            bs
    
    This commit improves the organization and safety of the code, making
    it easier to maintain and preventing users from accidentally setting
    negative values for the specified parameters.
    
    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
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
+ HOST_DEST=/lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.2M Apr  9 21:45 /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=2
[25776.164336] null_blk: disk nullb0 created
[25776.164340] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[25776.463367] null_blk: disk nullb0 created
[25776.463372] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[25776.761298] null_blk: disk nullb0 created
[25776.761302] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16
[25777.066067] null_blk: disk nullb0 created
[25777.066071] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[25777.365061] null_blk: disk nullb0 created
[25777.365065] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25777.668446] null_blk: `64' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=128
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25777.953276] null_blk: `128' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=256
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25778.241435] null_blk: `256' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=512
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25778.535973] null_blk: `512' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1024
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25778.820244] null_blk: `1024' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2048
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25779.109780] null_blk: `2048' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4096
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25779.391087] null_blk: `4096' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=8192
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25779.680139] null_blk: `8192' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=16384
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25779.968831] null_blk: `16384' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=32768
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25780.260772] null_blk: `32768' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=65536
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25780.550788] null_blk: `65536' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=131072
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25780.836378] null_blk: `131072' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=262144
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25781.123029] null_blk: `262144' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=524288
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25781.407094] null_blk: `524288' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1048576
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25781.695025] null_blk: `1048576' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2097152
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25781.980943] null_blk: `2097152' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4194304
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25782.270311] null_blk: `4194304' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=8388608
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25782.560530] null_blk: `8388608' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=16777216
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25782.849118] null_blk: `16777216' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=33554432
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25783.139874] null_blk: `33554432' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=67108864
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25783.425812] null_blk: `67108864' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=134217728
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25783.713279] null_blk: `134217728' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=268435456
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25783.995692] null_blk: `268435456' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=536870912
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25784.281032] null_blk: `536870912' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1073741824
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25784.570647] null_blk: `1073741824' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25784.856083] null_blk: `2147483648' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25785.143474] null_blk: `4294967296' invalid for parameter `poll_queues'

###################################################
hw_queue_depth:
------------------------------------
modprobe null_blk hw_queue_depth=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25787.306489] null_blk: `-2' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25787.339024] null_blk: `-1' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25787.373115] null_blk: `0' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=1
[25787.406981] null_blk: disk nullb0 created
[25787.406984] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=2
[25787.453287] null_blk: disk nullb0 created
[25787.453291] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=4
[25787.504638] null_blk: disk nullb0 created
[25787.504642] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=8
[25787.546326] null_blk: disk nullb0 created
[25787.546329] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=32
[25787.591883] null_blk: disk nullb0 created
[25787.591887] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=64
[25787.643497] null_blk: disk nullb0 created
[25787.643502] null_blk: module loaded

###################################################
max_sectors:
------------------------------------
modprobe null_blk max_sectors=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25788.309523] null_blk: `-2' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25788.340004] null_blk: `-1' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25788.370858] null_blk: `0' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=1
[25788.398297] blk_queue_max_hw_sectors: set to minimum 8
[25788.399911] null_blk: disk nullb0 created
[25788.399914] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=2
[25788.443408] blk_queue_max_hw_sectors: set to minimum 8
[25788.444802] null_blk: disk nullb0 created
[25788.444804] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=4
[25788.484144] blk_queue_max_hw_sectors: set to minimum 8
[25788.485202] null_blk: disk nullb0 created
[25788.485204] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=8
[25788.535492] null_blk: disk nullb0 created
[25788.535496] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=32
[25788.585743] null_blk: disk nullb0 created
[25788.585745] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=64
[25788.640337] null_blk: disk nullb0 created
[25788.640342] null_blk: module loaded

###################################################
gb:
------------------------------------
modprobe null_blk gb=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25789.949395] null_blk: `-2' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25789.979654] null_blk: `-1' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25790.007997] null_blk: `0' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=1
[25790.047631] null_blk: disk nullb0 created
[25790.047636] null_blk: module loaded
------------------------------------
modprobe null_blk gb=2
[25790.097269] null_blk: disk nullb0 created
[25790.097273] null_blk: module loaded
------------------------------------
modprobe null_blk gb=4
[25790.144199] null_blk: disk nullb0 created
[25790.144202] null_blk: module loaded
------------------------------------
modprobe null_blk gb=8
[25790.183399] null_blk: disk nullb0 created
[25790.183402] null_blk: module loaded
------------------------------------
modprobe null_blk gb=32
[25790.229548] null_blk: disk nullb0 created
[25790.229550] null_blk: module loaded
------------------------------------
modprobe null_blk gb=64
[25790.271844] null_blk: disk nullb0 created
[25790.271848] null_blk: module loaded

###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25792.071352] null_blk: `-2' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25792.103918] null_blk: `-1' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25792.132886] null_blk: `0' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1
[25792.168441] null_blk: disk nullb0 created
[25792.168443] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2
[25792.215092] null_blk: disk nullb0 created
[25792.215096] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[25792.259892] null_blk: disk nullb0 created
[25792.259897] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[25792.308354] null_blk: disk nullb0 created
[25792.308359] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[25792.366024] null_blk: disk nullb0 created
[25792.366029] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25792.401833] null_blk: `64' invalid for parameter `poll_queues'

###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25793.064461] null_blk: `-2' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25793.092677] null_blk: `-1' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25793.128131] null_blk: `0' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=1
[25793.166024] null_blk: disk nullb0 created
[25793.166028] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2
[25793.223361] null_blk: disk nullb0 created
[25793.223363] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[25793.262770] null_blk: disk nullb0 created
[25793.262773] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[25793.312909] null_blk: disk nullb0 created
[25793.312913] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[25793.367483] null_blk: disk nullb0 created
[25793.367487] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[25793.417746] null_blk: disk nullb0 created
[25793.417750] null_blk: module loaded

###################################################
queue_mode:
------------------------------------
modprobe null_blk queue_mode=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25794.171162] null_blk: `-2' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25794.198640] null_blk: `-1' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=0
[25794.226505] null_blk: disk nullb0 created
[25794.226509] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25794.261317] null_blk: legacy IO path is no longer available
------------------------------------
modprobe null_blk queue_mode=2
[25794.290184] null_blk: disk nullb0 created
[25794.290188] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25794.334131] null_blk: `4' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25794.361336] null_blk: `8' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25794.396722] null_blk: `32' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25794.430704] null_blk: `64' invalid for parameter `queue_mode'

###################################################
bs:
------------------------------------
modprobe null_blk bs=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25795.119840] null_blk: `-2' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25795.148778] null_blk: `-1' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[25795.181153] null_blk: `0' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=1
[25795.209134] null_blk: disk nullb0 created
[25795.209168] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2
[25795.258023] null_blk: disk nullb0 created
[25795.258027] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4
[25795.307965] null_blk: disk nullb0 created
[25795.307968] null_blk: module loaded
------------------------------------
modprobe null_blk bs=8
[25795.347780] null_blk: disk nullb0 created
[25795.347783] null_blk: module loaded
------------------------------------
modprobe null_blk bs=32
[25795.406619] null_blk: disk nullb0 created
[25795.406622] null_blk: module loaded
------------------------------------
modprobe null_blk bs=64
[25795.452789] null_blk: disk nullb0 created
[25795.452792] null_blk: module loaded
------------------------------------
modprobe null_blk bs=512
[25795.510244] null_blk: disk nullb0 created
[25795.510247] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1024
[25795.560363] null_blk: disk nullb0 created
[25795.560365] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2048
[25795.606855] null_blk: disk nullb0 created
[25795.606857] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4096
[25795.653595] null_blk: disk nullb0 created
[25795.653636] null_blk: module loaded



-- 
2.29.0

