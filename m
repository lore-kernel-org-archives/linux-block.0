Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F6DC74A5B
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 05:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjC3Fwl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC3Fwk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 01:52:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103E2139
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 22:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHLQEnjGACORFJtiNKCkMF6E4g9IisVWszM4VIRhCMJpOZSAL+/2/kYA16NFSDGbkLavr9S922eZt4IAYPOKi3ZOeygtFIlRFHpX/69bndtju1s4mwIg82CSiaTgm/p/LCrb5q5e/PiRty2H4ATgdu2do3NV8YABcwztn9rtJDqu4tpQ5Ku1P23Fvxh0PDVceloT4VP8uQOd6ux9iyXOj9l7NxP/It3hbL0lAYt4WgedPNrU3yNz1jMo1l/qvSNAJLImIyFRNaiyslIxUpQ4CfwFusKCzQwbW+754wsJQthmwV5Cxeevig8xguoOzDzscbgIfkbeWxqGlvDnnG4ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYpizVXlfTcNGq/9ckvhUvZyjQQvobqRKQM9qG0YgGQ=;
 b=Wg9FfUu0OKeAjyAzmDVM1W1A4kTrMO+wxHY0R9XuEo5QetZHE5vRHniWaPltXCCDfA3VxTm3A7JdbzRCSgR0mrbv1sTuNoFSVfRwtz9Up4D2n54pAddDg0WZTRg0HJP71uPJwCXIQ6SFXePMQY0gqB+wEkHa81IJ7VjAPzqEi7g0rHSh6sISJbC24/0JkIwFmHSrPVjsh1x41aTIgA0SEDGflG6vm18M5TKKd0cu2HBX89ncQ8DequSt3WPoi0PNpA1AVeqet7TFniomyEakEOsDc08EAzc1BU9KabB0iJzVmth8re7pSpmpLEwmoYz1bIjtqryWp1lbT4FM5kvLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYpizVXlfTcNGq/9ckvhUvZyjQQvobqRKQM9qG0YgGQ=;
 b=BRe94grcqtMLIx3tcENCD7BvUcQn2cSNBNF74W3qF36TCoUGtsazgZunsYDdHRlCiVv9VE6j/tKdPGtpO/wK+EuklyX2vS63kx5J8j9PybHM+fWwIYr+gaa7YUgZ+CTaBFN9jFK+JLqBSnlz5U/akVsnzs9SY2FDS+kYtwvG/ld1qHOXXeGFU28omQp+vE4cHtXyQw7M2vHPDqC7GKNmdna8eeOyF/RUJ1Q+BWXLghrvAXILoOxp2CsEE2hsxoHKn6G+bIYJdd2sZzDlj3q74eFlwVYyZHDD1whtQTb1K8+sWE4p+QGTQ2TxQJubobxEc85JjbiKFQfLOV6t2xoczA==
Received: from BL1PR13CA0122.namprd13.prod.outlook.com (2603:10b6:208:2bb::7)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 05:52:28 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::42) by BL1PR13CA0122.outlook.office365.com
 (2603:10b6:208:2bb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 05:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 05:52:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 22:52:12 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 22:52:11 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 0/9] null_blk: add modparam checks
Date:   Wed, 29 Mar 2023 22:51:54 -0700
Message-ID: <20230330055203.43064-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 07be5469-c2b5-4ff1-3ff8-08db30e2f1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYN+rlvW9pPs2qU30DPGEBwwiGcPUqER3JthJLW3VrZZRNPosIcc6JmMiHqRvhOLmXaFuV3zxBCUcbtalHLpu6zzNE/j1oIZkGGx5gQ/+hlcvETVESetnBqMg4IPCc4FT/3foP1PCTFkbE5itjqXh7BSa3GH2/fzWBo6doAwh36iFZezByoDHY4eGjDf9DihtJD5Uo4xht+ZmphH3QZ0W68148YFCDch9wVTVmH5nmspkkXMZkaYOa0PnFI2c/SBnO2Q+xyrdrXA9/s5x42DnJjYXz81CDJ6C6rZ17t9mO68+09r+gpVqGVmy/DXJjUV4I1y4fqA8BJmY/KzH/4sUIrzghfzKV1/t8KNevmYsWpUzaY6epWPfqUqzyUDs3ZazywBR6z4NMpga4FT874hRtG0rS5kMGUkUJEKoqzhixEUt0B4EB6l4aZTcP083O4zRJniESD7/jk0j54iaBvRbo4iXeeDS9mfy7Qx3ZX7WR2FmYVQP9xWH6LyYp5WGZ8U1xNxGMHv+KCYq3xukUyKo6JSfwxfN0yDJD9AKcI0nGnbkn/gFZlzcwOf0Dj3HoEuEgu1nHflGH/lBuU2AXC5MkOoA9+qkjhIgfVK1gPs8ENtJln6afakGPPNhWdEAKbUcO9aa/ICESp2DpO4BnXqjLQC0z9TvFkPUXLxf4zXT5dCuNcgsDrenImXPKMa1WEx9bvxF0yD5MzGVruRiUR05OvnHX9A9EkHqpndhkBPh5fhFsev9OGFe6nw070iJPnF46XaASvImHF/I1wbdFZTtw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(336012)(36756003)(426003)(16526019)(2616005)(83380400001)(5660300002)(26005)(1076003)(30864003)(6666004)(356005)(7636003)(8936002)(82740400003)(41300700001)(186003)(36860700001)(70586007)(40480700001)(45080400002)(4326008)(7696005)(6916009)(8676002)(2906002)(47076005)(40460700003)(54906003)(316002)(70206006)(478600001)(559001)(579004)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:52:28.0559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07be5469-c2b5-4ff1-3ff8-08db30e2f1ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Some of the null_blk parameters are defined as int which can lead to
unwanted behaviour with certain values. One of such an example is using
large values for poll_queues parameter, previously it used to result in
OOPs see at the end [1] and now it results in message see patch 2.
E.g. setting up -2 for poll_queues actually tries to allocate memory
instead of returning errorr.

Add modpram validation callbacks to make sure we will not allow
users to set unintended values even by mistake and generate appropriate
error without any futher processing.

Please note that this is needed to write a big daddy testcase where it
uses all possible big values for the module parameters and make sure 
block layers tag allocation works without any OOPs  and errors out
gracefully.

Below is the test result with and without this series where appriparite
error is returned for modparams listed below. 

Last two patches removes the global variable used in modparam callback
so everything stays consistent in code.

-ck

Chaitanya Kulkarni (9):
  null_blk: adjust null_param_store_val()
  null_blk: check for valid submit_queue value
  null_blk: check for valid poll_queue value
  null_blk: check for valid gb value
  null_blk: check for valid block size value
  null_blk: check for valid max_sectors value
  null_blk: check for valid queue depth value
  null_blk: avoid use global modparam g_queue_mode
  null_blk: avoid use global modparam g_irq_mode

 drivers/block/null_blk/main.c | 112 ++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 27 deletions(-)

linux-block (nullb-mod-param) # ./test-mod-param.sh 
#######################################################################
With this patch series :-

Switched to branch 'for-next'
Your branch is up to date with 'origin/for-next'.
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
+ HOST_DEST=/lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.2M Mar 29 22:46 /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=2
[29784.851425] blk_queue_max_hw_sectors: set to minimum 8
[29784.852776] null_blk: disk nullb0 created
[29784.852778] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[29785.149650] blk_queue_max_hw_sectors: set to minimum 8
[29785.150682] null_blk: disk nullb0 created
[29785.150684] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[29785.445946] blk_queue_max_hw_sectors: set to minimum 8
[29785.447202] null_blk: disk nullb0 created
[29785.447204] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16
[29785.743524] blk_queue_max_hw_sectors: set to minimum 8
[29785.744776] null_blk: disk nullb0 created
[29785.744778] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[29786.044765] blk_queue_max_hw_sectors: set to minimum 8
[29786.046361] null_blk: disk nullb0 created
[29786.046362] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
[29786.340830] ------------[ cut here ]------------
[29786.340832] WARNING: CPU: 27 PID: 40628 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[29786.340838] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput nvme(O) nvme_core(O) nvme_common snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[29786.340877] CPU: 27 PID: 40628 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[29786.340878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[29786.340880] RIP: 0010:group_cpus_evenly+0x26e/0x280
[29786.340882] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[29786.340883] RSP: 0018:ffffc90000e9bcb8 EFLAGS: 00010287
[29786.340884] RAX: 0000000080000000 RBX: 0000000000000040 RCX: 0000000000000000
[29786.340886] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[29786.340886] RBP: ffff8888495608e0 R08: ffff888849560460 R09: ffff888838ad0000
[29786.340887] R10: ffff888849560460 R11: 0000000000000000 R12: ffff888838ad0000
[29786.340888] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[29786.340890] FS:  00007fa50c3c9b80(0000) GS:ffff888fff8c0000(0000) knlGS:0000000000000000
[29786.340891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29786.340892] CR2: 00007fa50bf06800 CR3: 000000083a34a000 CR4: 0000000000350ee0
[29786.340894] DR0: ffffffff843793e1 DR1: ffffffff843793e2 DR2: ffffffff843793e3
[29786.340895] DR3: ffffffff8437944f DR6: 00000000ffff0ff0 DR7: 0000000000000600
[29786.340896] Call Trace:
[29786.340897]  <TASK>
[29786.340899]  blk_mq_map_queues+0x16/0xc0
[29786.340902]  null_map_queues+0xa5/0xe0 [null_blk]
[29786.340909]  blk_mq_alloc_tag_set+0x14d/0x3f0
[29786.340911]  ? __kmalloc+0xbc/0x130
[29786.340915]  null_add_dev.part.0+0x601/0x700 [null_blk]
[29786.340920]  null_init+0x109/0xff0 [null_blk]
[29786.340926]  ? __pfx_init_module+0x10/0x10 [null_blk]
[29786.340931]  do_one_initcall+0x44/0x220
[29786.340935]  ? kmalloc_trace+0x25/0x90
[29786.340936]  do_init_module+0x4c/0x210
[29786.340942]  __do_sys_finit_module+0xb4/0x130
[29786.340946]  do_syscall_64+0x3b/0x90
[29786.340950]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[29786.340953] RIP: 0033:0x7fa50bf2c15d
[29786.340955] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[29786.340956] RSP: 002b:00007ffc3f497878 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[29786.340957] RAX: ffffffffffffffda RBX: 000055584a36fb90 RCX: 00007fa50bf2c15d
[29786.340958] RDX: 0000000000000000 RSI: 000055584a36ff00 RDI: 0000000000000003
[29786.340959] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[29786.340959] R10: 0000000000000003 R11: 0000000000000246 R12: 000055584a36ff00
[29786.340960] R13: 000055584a36fcc0 R14: 000055584a36fb90 R15: 000055584a36ff20
[29786.340962]  </TASK>
[29786.340962] ---[ end trace 0000000000000000 ]---
[29786.341596] blk_queue_max_hw_sectors: set to minimum 8
[29786.343833] null_blk: disk nullb0 created
[29786.343835] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=128
[29786.642230] ------------[ cut here ]------------
[29786.642234] WARNING: CPU: 26 PID: 40635 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[29786.642240] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput nvme(O) nvme_core(O) nvme_common snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[29786.642292] CPU: 26 PID: 40635 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[29786.642294] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[29786.642296] RIP: 0010:group_cpus_evenly+0x26e/0x280
[29786.642298] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[29786.642299] RSP: 0018:ffffc90000e9bcb8 EFLAGS: 00010283
[29786.642301] RAX: 0000000080000000 RBX: 0000000000000080 RCX: 0000000000000000
[29786.642302] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[29786.642303] RBP: ffff8888535b2ea0 R08: ffff8888535b26e0 R09: ffff8888bdca0000
[29786.642304] R10: ffff8888535b26e0 R11: 0000000000000000 R12: ffff8888bdca0000
[29786.642304] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[29786.642306] FS:  00007f546e937b80(0000) GS:ffff888fff880000(0000) knlGS:0000000000000000
[29786.642307] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29786.642308] CR2: 00007f546e506800 CR3: 00000008c02ae000 CR4: 0000000000350ee0
[29786.642310] DR0: ffffffff84379448 DR1: ffffffff84379449 DR2: ffffffff8437944a
[29786.642311] DR3: ffffffff8437944b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[29786.642312] Call Trace:
[29786.642314]  <TASK>
[29786.642315]  blk_mq_map_queues+0x16/0xc0
[29786.642321]  null_map_queues+0xa5/0xe0 [null_blk]
[29786.642328]  blk_mq_alloc_tag_set+0x14d/0x3f0
[29786.642330]  ? __kmalloc+0xbc/0x130
[29786.642334]  null_add_dev.part.0+0x601/0x700 [null_blk]
[29786.642340]  null_init+0x109/0xff0 [null_blk]
[29786.642345]  ? __pfx_init_module+0x10/0x10 [null_blk]
[29786.642350]  do_one_initcall+0x44/0x220
[29786.642355]  ? kmalloc_trace+0x25/0x90
[29786.642357]  do_init_module+0x4c/0x210
[29786.642363]  __do_sys_finit_module+0xb4/0x130
[29786.642366]  do_syscall_64+0x3b/0x90
[29786.642371]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[29786.642374] RIP: 0033:0x7f546e52c15d
[29786.642376] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[29786.642377] RSP: 002b:00007ffddbc87f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[29786.642378] RAX: ffffffffffffffda RBX: 0000561a3e535b90 RCX: 00007f546e52c15d
[29786.642379] RDX: 0000000000000000 RSI: 0000561a3e535f00 RDI: 0000000000000003
[29786.642380] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[29786.642381] R10: 0000000000000003 R11: 0000000000000246 R12: 0000561a3e535f00
[29786.642381] R13: 0000561a3e535cc0 R14: 0000561a3e535b90 R15: 0000561a3e535f20
[29786.642383]  </TASK>
[29786.642383] ---[ end trace 0000000000000000 ]---
[29786.643691] blk_queue_max_hw_sectors: set to minimum 8
[29786.647404] null_blk: disk nullb0 created
[29786.647406] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=256
[29786.945344] ------------[ cut here ]------------
[29786.945349] WARNING: CPU: 28 PID: 40642 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[29786.945355] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput nvme(O) nvme_core(O) nvme_common snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[29786.945386] CPU: 28 PID: 40642 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[29786.945395] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[29786.945397] RIP: 0010:group_cpus_evenly+0x26e/0x280
[29786.945399] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[29786.945400] RSP: 0018:ffffc90000e9bcb8 EFLAGS: 00010287
[29786.945402] RAX: 0000000080000000 RBX: 0000000000000100 RCX: 0000000000000000
[29786.945403] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[29786.945404] RBP: ffff888662e35568 R08: ffff888662e35838 R09: ffff88886c4c0000
[29786.945404] R10: ffff888662e35838 R11: 0000000000000000 R12: ffff88886c4c0000
[29786.945405] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[29786.945407] FS:  00007f8d4d7d4b80(0000) GS:ffff888fff900000(0000) knlGS:0000000000000000
[29786.945408] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29786.945409] CR2: 00007f8d4dbc3800 CR3: 00000008467f2000 CR4: 0000000000350ee0
[29786.945411] DR0: ffffffff84379450 DR1: ffffffff84379451 DR2: ffffffff84379452
[29786.945412] DR3: ffffffff84379453 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[29786.945413] Call Trace:
[29786.945414]  <TASK>
[29786.945416]  blk_mq_map_queues+0x16/0xc0
[29786.945420]  null_map_queues+0xa5/0xe0 [null_blk]
[29786.945427]  blk_mq_alloc_tag_set+0x14d/0x3f0
[29786.945429]  ? __kmalloc+0xbc/0x130
[29786.945433]  null_add_dev.part.0+0x601/0x700 [null_blk]
[29786.945439]  null_init+0x109/0xff0 [null_blk]
[29786.945444]  ? __pfx_init_module+0x10/0x10 [null_blk]
[29786.945449]  do_one_initcall+0x44/0x220
[29786.945453]  ? kmalloc_trace+0x25/0x90
[29786.945455]  do_init_module+0x4c/0x210
[29786.945458]  __do_sys_finit_module+0xb4/0x130
[29786.945465]  do_syscall_64+0x3b/0x90
[29786.945469]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[29786.945473] RIP: 0033:0x7f8d4dbe915d
[29786.945474] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[29786.945475] RSP: 002b:00007fffe1225378 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[29786.945476] RAX: ffffffffffffffda RBX: 000055db5a65eb90 RCX: 00007f8d4dbe915d
[29786.945477] RDX: 0000000000000000 RSI: 000055db5a65ef00 RDI: 0000000000000003
[29786.945478] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[29786.945479] R10: 0000000000000003 R11: 0000000000000246 R12: 000055db5a65ef00
[29786.945479] R13: 000055db5a65ecc0 R14: 000055db5a65eb90 R15: 000055db5a65ef20
[29786.945481]  </TASK>
[29786.945482] ---[ end trace 0000000000000000 ]---
[29786.947855] blk_queue_max_hw_sectors: set to minimum 8
[29786.954199] null_blk: disk nullb0 created
[29786.954201] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=512
[29787.266534] ------------[ cut here ]------------
[29787.266538] WARNING: CPU: 26 PID: 40649 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[29787.266552] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput nvme(O) nvme_core(O) nvme_common snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[29787.266592] CPU: 26 PID: 40649 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[29787.266594] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[29787.266596] RIP: 0010:group_cpus_evenly+0x26e/0x280
[29787.266606] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[29787.266608] RSP: 0018:ffffc90000e9bcb8 EFLAGS: 00010287
[29787.266610] RAX: 0000000080000000 RBX: 0000000000000200 RCX: 0000000000000000
[29787.266611] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[29787.266613] RBP: ffff88884b220d48 R08: ffff88884b2208e8 R09: ffff88885d480000
[29787.266614] R10: ffff88884b2208e8 R11: 0000000000000000 R12: ffff88885d480000
[29787.266615] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[29787.266617] FS:  00007f7edda2fb80(0000) GS:ffff888fff880000(0000) knlGS:0000000000000000
[29787.266619] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29787.266620] CR2: 00007f7eddb06800 CR3: 00000008c3d3a000 CR4: 0000000000350ee0
[29787.266622] DR0: ffffffff84379448 DR1: ffffffff84379449 DR2: ffffffff8437944a
[29787.266623] DR3: ffffffff8437944b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[29787.266624] Call Trace:
[29787.266626]  <TASK>
[29787.266628]  blk_mq_map_queues+0x16/0xc0
[29787.266632]  null_map_queues+0xa5/0xe0 [null_blk]
[29787.266640]  blk_mq_alloc_tag_set+0x14d/0x3f0
[29787.266642]  ? __kmalloc+0xbc/0x130
[29787.266646]  null_add_dev.part.0+0x601/0x700 [null_blk]
[29787.266653]  null_init+0x109/0xff0 [null_blk]
[29787.266660]  ? __pfx_init_module+0x10/0x10 [null_blk]
[29787.266667]  do_one_initcall+0x44/0x220
[29787.266671]  ? kmalloc_trace+0x25/0x90
[29787.266673]  do_init_module+0x4c/0x210
[29787.266677]  __do_sys_finit_module+0xb4/0x130
[29787.266686]  do_syscall_64+0x3b/0x90
[29787.266690]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[29787.266694] RIP: 0033:0x7f7eddb2c15d
[29787.266695] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[29787.266697] RSP: 002b:00007ffd07c0b6e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[29787.266699] RAX: ffffffffffffffda RBX: 0000562c94dd1b90 RCX: 00007f7eddb2c15d
[29787.266700] RDX: 0000000000000000 RSI: 0000562c94dd1f00 RDI: 0000000000000003
[29787.266701] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[29787.266702] R10: 0000000000000003 R11: 0000000000000246 R12: 0000562c94dd1f00
[29787.266703] R13: 0000562c94dd1cc0 R14: 0000562c94dd1b90 R15: 0000562c94dd1f20
[29787.266705]  </TASK>
[29787.266705] ---[ end trace 0000000000000000 ]---
[29787.271400] blk_queue_max_hw_sectors: set to minimum 8
[29787.283440] null_blk: disk nullb0 created
[29787.283444] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=1024
[29787.597002] ------------[ cut here ]------------
[29787.597006] WARNING: CPU: 27 PID: 40656 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[29787.597012] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput nvme(O) nvme_core(O) nvme_common snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[29787.597043] CPU: 27 PID: 40656 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[29787.597045] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[29787.597047] RIP: 0010:group_cpus_evenly+0x26e/0x280
[29787.597049] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[29787.597058] RSP: 0018:ffffc90000f33cb8 EFLAGS: 00010287
[29787.597059] RAX: 0000000080000000 RBX: 0000000000000400 RCX: 0000000000000000
[29787.597060] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[29787.597061] RBP: ffff888849560818 R08: ffff888849560608 R09: ffff88884c600000
[29787.597062] R10: ffff888849560608 R11: 0000000000000000 R12: ffff88884c600000
[29787.597063] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[29787.597065] FS:  00007fec30100b80(0000) GS:ffff888fff8c0000(0000) knlGS:0000000000000000
[29787.597066] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29787.597067] CR2: 00007fec2fd06800 CR3: 00000008c02ae000 CR4: 0000000000350ee0
[29787.597069] DR0: ffffffff843793e1 DR1: ffffffff843793e2 DR2: ffffffff843793e3
[29787.597070] DR3: ffffffff8437944f DR6: 00000000ffff0ff0 DR7: 0000000000000600
[29787.597071] Call Trace:
[29787.597072]  <TASK>
[29787.597074]  blk_mq_map_queues+0x16/0xc0
[29787.597077]  null_map_queues+0xa5/0xe0 [null_blk]
[29787.597084]  blk_mq_alloc_tag_set+0x14d/0x3f0
[29787.597086]  ? __kmalloc+0xbc/0x130
[29787.597090]  null_add_dev.part.0+0x601/0x700 [null_blk]
[29787.597096]  null_init+0x109/0xff0 [null_blk]
[29787.597102]  ? __pfx_init_module+0x10/0x10 [null_blk]
[29787.597107]  do_one_initcall+0x44/0x220
[29787.597111]  ? kmalloc_trace+0x25/0x90
[29787.597112]  do_init_module+0x4c/0x210
[29787.597117]  __do_sys_finit_module+0xb4/0x130
[29787.597121]  do_syscall_64+0x3b/0x90
[29787.597127]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[29787.597131] RIP: 0033:0x7fec2fd2c15d
[29787.597132] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[29787.597133] RSP: 002b:00007ffd01087998 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[29787.597135] RAX: ffffffffffffffda RBX: 000055c57dd83b90 RCX: 00007fec2fd2c15d
[29787.597136] RDX: 0000000000000000 RSI: 000055c57dd83f00 RDI: 0000000000000003
[29787.597136] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[29787.597137] R10: 0000000000000003 R11: 0000000000000246 R12: 000055c57dd83f00
[29787.597138] R13: 000055c57dd83cc0 R14: 000055c57dd83b90 R15: 000055c57dd83f20
[29787.597140]  </TASK>
[29787.597140] ---[ end trace 0000000000000000 ]---
[29787.605556] blk_queue_max_hw_sectors: set to minimum 8
[29787.627620] null_blk: disk nullb0 created
[29787.627626] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2048
[29787.947431] ------------[ cut here ]------------
[29787.947435] WARNING: CPU: 29 PID: 40663 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[29787.947444] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput nvme(O) nvme_core(O) nvme_common snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[29787.947486] CPU: 29 PID: 40663 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[29787.947489] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[29787.947491] RIP: 0010:group_cpus_evenly+0x26e/0x280
[29787.947494] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[29787.947496] RSP: 0018:ffffc90000e9bcb8 EFLAGS: 00010287
[29787.947505] RAX: 0000000080000000 RBX: 0000000000000800 RCX: 0000000000000000
[29787.947507] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[29787.947511] RBP: ffff88884956cba8 R08: ffff88884956c848 R09: ffff888872000000
[29787.947512] R10: ffff88884956c848 R11: 0000000000000000 R12: ffff888872000000
[29787.947513] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[29787.947516] FS:  00007f2710151b80(0000) GS:ffff888fff940000(0000) knlGS:0000000000000000
[29787.947518] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29787.947519] CR2: 00007f270fd06800 CR3: 0000000870a96000 CR4: 0000000000350ee0
[29787.947522] DR0: ffffffff84379454 DR1: ffffffff84379455 DR2: ffffffff84379456
[29787.947523] DR3: ffffffff84379457 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[29787.947525] Call Trace:
[29787.947527]  <TASK>
[29787.947529]  blk_mq_map_queues+0x16/0xc0
[29787.947534]  null_map_queues+0xa5/0xe0 [null_blk]
[29787.947544]  blk_mq_alloc_tag_set+0x14d/0x3f0
[29787.947547]  ? __kmalloc+0xbc/0x130
[29787.947552]  null_add_dev.part.0+0x601/0x700 [null_blk]
[29787.947561]  null_init+0x109/0xff0 [null_blk]
[29787.947570]  ? __pfx_init_module+0x10/0x10 [null_blk]
[29787.947578]  do_one_initcall+0x44/0x220
[29787.947583]  ? kmalloc_trace+0x25/0x90
[29787.947586]  do_init_module+0x4c/0x210
[29787.947590]  __do_sys_finit_module+0xb4/0x130
[29787.947596]  do_syscall_64+0x3b/0x90
[29787.947605]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[29787.947609] RIP: 0033:0x7f270fd2c15d
[29787.947611] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[29787.947613] RSP: 002b:00007fff347847e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[29787.947615] RAX: ffffffffffffffda RBX: 00005587f13b4b90 RCX: 00007f270fd2c15d
[29787.947616] RDX: 0000000000000000 RSI: 00005587f13b4f00 RDI: 0000000000000003
[29787.947617] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[29787.947618] R10: 0000000000000003 R11: 0000000000000246 R12: 00005587f13b4f00
[29787.947619] R13: 00005587f13b4cc0 R14: 00005587f13b4b90 R15: 00005587f13b4f20
[29787.947622]  </TASK>
[29787.947623] ---[ end trace 0000000000000000 ]---
[29787.964160] blk_queue_max_hw_sectors: set to minimum 8
[29788.007669] null_blk: disk nullb0 created
[29788.007673] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4096
[29788.346222] ------------[ cut here ]------------
[29788.346225] WARNING: CPU: 28 PID: 40672 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[29788.346230] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput nvme(O) nvme_core(O) nvme_common snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[29788.346261] CPU: 28 PID: 40672 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[29788.346263] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[29788.346264] RIP: 0010:group_cpus_evenly+0x26e/0x280
[29788.346266] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[29788.346267] RSP: 0018:ffffc90000f33cb8 EFLAGS: 00010287
[29788.346268] RAX: 0000000080000000 RBX: 0000000000001000 RCX: 0000000000000000
[29788.346269] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[29788.346270] RBP: ffff888862a93a30 R08: ffff888862a93850 R09: ffff888849c00000
[29788.346271] R10: ffff888862a93850 R11: 0000000000000000 R12: ffff888849c00000
[29788.346272] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[29788.346280] FS:  00007fa8cfb2cb80(0000) GS:ffff888fff900000(0000) knlGS:0000000000000000
[29788.346281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29788.346282] CR2: 00007fa8cf706800 CR3: 00000008467f2000 CR4: 0000000000350ee0
[29788.346284] DR0: ffffffff84379450 DR1: ffffffff84379451 DR2: ffffffff84379452
[29788.346285] DR3: ffffffff84379453 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[29788.346286] Call Trace:
[29788.346287]  <TASK>
[29788.346289]  blk_mq_map_queues+0x16/0xc0
[29788.346293]  null_map_queues+0xa5/0xe0 [null_blk]
[29788.346299]  blk_mq_alloc_tag_set+0x14d/0x3f0
[29788.346302]  ? __kmalloc+0xbc/0x130
[29788.346305]  null_add_dev.part.0+0x601/0x700 [null_blk]
[29788.346311]  null_init+0x109/0xff0 [null_blk]
[29788.346317]  ? __pfx_init_module+0x10/0x10 [null_blk]
[29788.346322]  do_one_initcall+0x44/0x220
[29788.346326]  ? kmalloc_trace+0x25/0x90
[29788.346327]  do_init_module+0x4c/0x210
[29788.346330]  __do_sys_finit_module+0xb4/0x130
[29788.346334]  do_syscall_64+0x3b/0x90
[29788.346338]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[29788.346346] RIP: 0033:0x7fa8cf72c15d
[29788.346347] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[29788.346348] RSP: 002b:00007ffe789ec758 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[29788.346350] RAX: ffffffffffffffda RBX: 0000563249b94b90 RCX: 00007fa8cf72c15d
[29788.346350] RDX: 0000000000000000 RSI: 0000563249b94f00 RDI: 0000000000000003
[29788.346351] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[29788.346352] R10: 0000000000000003 R11: 0000000000000246 R12: 0000563249b94f00
[29788.346353] R13: 0000563249b94cc0 R14: 0000563249b94b90 R15: 0000563249b94f20
[29788.346354]  </TASK>
[29788.346355] ---[ end trace 0000000000000000 ]---
[29788.378699] blk_queue_max_hw_sectors: set to minimum 8
[29788.461665] null_blk: disk nullb0 created
[29788.461670] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8192
[29788.924317] blk_queue_max_hw_sectors: set to minimum 8
[29789.086972] null_blk: disk nullb0 created
[29789.086977] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16384
[29789.709485] blk_queue_max_hw_sectors: set to minimum 8
[29790.032494] null_blk: disk nullb0 created
[29790.032499] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32768
[29790.999356] blk_queue_max_hw_sectors: set to minimum 8
[29791.635006] null_blk: disk nullb0 created
[29791.635010] null_blk: module loaded
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
[29796.993470] null_blk: `2147483648' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Numerical result out of range
[29797.279144] null_blk: `4294967296' invalid for parameter `poll_queues'
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=2
[29797.568059] blk_queue_max_hw_sectors: set to minimum 8
[29797.568980] null_blk: disk nullb0 created
[29797.568982] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[29797.868973] blk_queue_max_hw_sectors: set to minimum 8
[29797.870351] null_blk: disk nullb0 created
[29797.870353] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[29798.166218] blk_queue_max_hw_sectors: set to minimum 8
[29798.167360] null_blk: disk nullb0 created
[29798.167362] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16
[29798.460281] blk_queue_max_hw_sectors: set to minimum 8
[29798.461517] null_blk: disk nullb0 created
[29798.461519] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[29798.755324] blk_queue_max_hw_sectors: set to minimum 8
[29798.757580] null_blk: disk nullb0 created
[29798.757582] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[29799.060158] blk_queue_max_hw_sectors: set to minimum 8
[29799.062269] null_blk: disk nullb0 created
[29799.062271] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=128
[29799.362957] blk_queue_max_hw_sectors: set to minimum 8
[29799.365077] null_blk: disk nullb0 created
[29799.365079] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=256
[29799.656632] blk_queue_max_hw_sectors: set to minimum 8
[29799.658651] null_blk: disk nullb0 created
[29799.658652] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=512
[29799.961718] blk_queue_max_hw_sectors: set to minimum 8
[29799.963827] null_blk: disk nullb0 created
[29799.963829] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1024
[29800.258150] blk_queue_max_hw_sectors: set to minimum 8
[29800.260209] null_blk: disk nullb0 created
[29800.260211] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2048
[29800.552909] blk_queue_max_hw_sectors: set to minimum 8
[29800.554959] null_blk: disk nullb0 created
[29800.554961] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4096
[29800.856525] blk_queue_max_hw_sectors: set to minimum 8
[29800.858624] null_blk: disk nullb0 created
[29800.858626] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8192
[29801.151394] blk_queue_max_hw_sectors: set to minimum 8
[29801.153428] null_blk: disk nullb0 created
[29801.153430] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16384
[29801.444991] blk_queue_max_hw_sectors: set to minimum 8
[29801.447065] null_blk: disk nullb0 created
[29801.447066] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32768
[29801.740783] blk_queue_max_hw_sectors: set to minimum 8
[29801.742919] null_blk: disk nullb0 created
[29801.742921] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=65536
[29802.038628] blk_queue_max_hw_sectors: set to minimum 8
[29802.041415] null_blk: disk nullb0 created
[29802.041417] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=131072
[29802.336868] blk_queue_max_hw_sectors: set to minimum 8
[29802.339024] null_blk: disk nullb0 created
[29802.339026] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=262144
[29802.629989] blk_queue_max_hw_sectors: set to minimum 8
[29802.632067] null_blk: disk nullb0 created
[29802.632069] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=524288
[29802.931097] blk_queue_max_hw_sectors: set to minimum 8
[29802.933208] null_blk: disk nullb0 created
[29802.933210] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1048576
[29803.231594] blk_queue_max_hw_sectors: set to minimum 8
[29803.233606] null_blk: disk nullb0 created
[29803.233608] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2097152
[29803.532234] blk_queue_max_hw_sectors: set to minimum 8
[29803.534277] null_blk: disk nullb0 created
[29803.534278] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4194304
[29803.830455] blk_queue_max_hw_sectors: set to minimum 8
[29803.832491] null_blk: disk nullb0 created
[29803.832494] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8388608
[29804.129955] blk_queue_max_hw_sectors: set to minimum 8
[29804.132323] null_blk: disk nullb0 created
[29804.132325] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16777216
[29804.432470] blk_queue_max_hw_sectors: set to minimum 8
[29804.435305] null_blk: disk nullb0 created
[29804.435307] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=33554432
[29804.726435] blk_queue_max_hw_sectors: set to minimum 8
[29804.728378] null_blk: disk nullb0 created
[29804.728380] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=67108864
[29805.027874] blk_queue_max_hw_sectors: set to minimum 8
[29805.029925] null_blk: disk nullb0 created
[29805.029927] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=134217728
[29805.324505] blk_queue_max_hw_sectors: set to minimum 8
[29805.326569] null_blk: disk nullb0 created
[29805.326571] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=268435456
[29805.633367] blk_queue_max_hw_sectors: set to minimum 8
[29805.635488] null_blk: disk nullb0 created
[29805.635489] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=536870912
[29805.938570] blk_queue_max_hw_sectors: set to minimum 8
[29805.940815] null_blk: disk nullb0 created
[29805.940817] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1073741824
[29806.237513] blk_queue_max_hw_sectors: set to minimum 8
[29806.239530] null_blk: disk nullb0 created
[29806.239531] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Numerical result out of range
[29806.540076] null_blk: `2147483648' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Numerical result out of range
[29806.829807] null_blk: `4294967296' invalid for parameter `submit_queues'
###################################################
hw_queue_depth:
------------------------------------
modprobe null_blk hw_queue_depth=-2
[29807.117940] blk-mq: reduced tag depth to 10240
[29807.118650] blk_queue_max_hw_sectors: set to minimum 8
[29807.119581] null_blk: disk nullb0 created
[29807.119583] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=-1
[29807.158632] blk-mq: reduced tag depth to 10240
[29807.159771] blk_queue_max_hw_sectors: set to minimum 8
[29807.160691] null_blk: disk nullb0 created
[29807.160692] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
------------------------------------
modprobe null_blk hw_queue_depth=1
[29807.226061] blk_queue_max_hw_sectors: set to minimum 8
[29807.227065] null_blk: disk nullb0 created
[29807.227067] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=2
[29807.269100] blk_queue_max_hw_sectors: set to minimum 8
[29807.270116] null_blk: disk nullb0 created
[29807.270117] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=4
[29807.315408] blk_queue_max_hw_sectors: set to minimum 8
[29807.316664] null_blk: disk nullb0 created
[29807.316666] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=8
[29807.370872] blk_queue_max_hw_sectors: set to minimum 8
[29807.371859] null_blk: disk nullb0 created
[29807.371861] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=32
[29807.410827] blk_queue_max_hw_sectors: set to minimum 8
[29807.411816] null_blk: disk nullb0 created
[29807.411818] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=64
[29807.460970] blk_queue_max_hw_sectors: set to minimum 8
[29807.462321] null_blk: disk nullb0 created
[29807.462323] null_blk: module loaded
###################################################
max_sectors:
------------------------------------
modprobe null_blk max_sectors=-2
[29807.514058] null_blk: invalid max sectors
[29807.514062] null_blk: defaults max sectors to 2560
[29807.515309] null_blk: disk nullb0 created
[29807.515311] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=-1
[29807.559781] null_blk: invalid max sectors
[29807.559784] null_blk: defaults max sectors to 2560
[29807.561175] null_blk: disk nullb0 created
[29807.561178] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=0
[29807.610766] blk_queue_max_hw_sectors: set to minimum 8
[29807.611660] null_blk: disk nullb0 created
[29807.611662] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=1
[29807.657888] blk_queue_max_hw_sectors: set to minimum 8
[29807.659292] null_blk: disk nullb0 created
[29807.659294] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=2
[29807.707070] blk_queue_max_hw_sectors: set to minimum 8
[29807.708112] null_blk: disk nullb0 created
[29807.708114] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=4
[29807.755084] blk_queue_max_hw_sectors: set to minimum 8
[29807.756363] null_blk: disk nullb0 created
[29807.756366] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=8
[29807.807318] null_blk: disk nullb0 created
[29807.807321] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=32
[29807.855769] null_blk: disk nullb0 created
[29807.855771] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=64
[29807.899557] null_blk: disk nullb0 created
[29807.899560] null_blk: module loaded
###################################################
gb:
------------------------------------
modprobe null_blk gb=-2
[29807.940318] blk_queue_max_hw_sectors: set to minimum 8
[29807.941327] null_blk: disk nullb0 created
[29807.941329] null_blk: module loaded
------------------------------------
modprobe null_blk gb=-1
[29807.985085] blk_queue_max_hw_sectors: set to minimum 8
[29807.986050] null_blk: disk nullb0 created
[29807.986052] null_blk: module loaded
------------------------------------
modprobe null_blk gb=0
[29808.036297] blk_queue_max_hw_sectors: set to minimum 8
[29808.037138] null_blk: disk nullb0 created
[29808.037139] null_blk: module loaded
------------------------------------
modprobe null_blk gb=1
[29808.092294] blk_queue_max_hw_sectors: set to minimum 8
[29808.093445] null_blk: disk nullb0 created
[29808.093447] null_blk: module loaded
------------------------------------
modprobe null_blk gb=2
[29808.145798] blk_queue_max_hw_sectors: set to minimum 8
[29808.147196] null_blk: disk nullb0 created
[29808.147198] null_blk: module loaded
------------------------------------
modprobe null_blk gb=4
[29808.194089] blk_queue_max_hw_sectors: set to minimum 8
[29808.195554] null_blk: disk nullb0 created
[29808.195556] null_blk: module loaded
------------------------------------
modprobe null_blk gb=8
[29808.247922] blk_queue_max_hw_sectors: set to minimum 8
[29808.248933] null_blk: disk nullb0 created
[29808.248935] null_blk: module loaded
------------------------------------
modprobe null_blk gb=32
[29808.290635] blk_queue_max_hw_sectors: set to minimum 8
[29808.291455] null_blk: disk nullb0 created
[29808.291457] null_blk: module loaded
------------------------------------
modprobe null_blk gb=64
[29808.342809] blk_queue_max_hw_sectors: set to minimum 8
[29808.343742] null_blk: disk nullb0 created
[29808.343744] null_blk: module loaded
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
[29808.450203] blk_queue_max_hw_sectors: set to minimum 8
[29808.450858] null_blk: disk nullb0 created
[29808.450860] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=1
[29808.505927] blk_queue_max_hw_sectors: set to minimum 8
[29808.507197] null_blk: disk nullb0 created
[29808.507199] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2
[29808.563106] blk_queue_max_hw_sectors: set to minimum 8
[29808.564049] null_blk: disk nullb0 created
[29808.564051] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[29808.605815] blk_queue_max_hw_sectors: set to minimum 8
[29808.606820] null_blk: disk nullb0 created
[29808.606822] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[29808.651637] blk_queue_max_hw_sectors: set to minimum 8
[29808.653112] null_blk: disk nullb0 created
[29808.653114] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[29808.702975] blk_queue_max_hw_sectors: set to minimum 8
[29808.704791] null_blk: disk nullb0 created
[29808.704793] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
[29808.758787] ------------[ cut here ]------------
[29808.758790] WARNING: CPU: 27 PID: 41164 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[29808.758798] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput nvme(O) nvme_core(O) nvme_common snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[29808.758850] CPU: 27 PID: 41164 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[29808.758853] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[29808.758855] RIP: 0010:group_cpus_evenly+0x26e/0x280
[29808.758858] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[29808.758860] RSP: 0018:ffffc90000f4bcb8 EFLAGS: 00010287
[29808.758862] RAX: 0000000080000000 RBX: 0000000000000040 RCX: 0000000000000000
[29808.758864] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[29808.758865] RBP: ffff8888535b2668 R08: ffff8888535b2150 R09: ffff8888c3fa0000
[29808.758866] R10: ffff8888535b2150 R11: 0000000000000000 R12: ffff8888c3fa0000
[29808.758868] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[29808.758871] FS:  00007f00bda3eb80(0000) GS:ffff888fff8c0000(0000) knlGS:0000000000000000
[29808.758873] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29808.758875] CR2: 00007f00bd506800 CR3: 00000008330cc000 CR4: 0000000000350ee0
[29808.758878] DR0: ffffffff843793e1 DR1: ffffffff843793e2 DR2: ffffffff843793e3
[29808.758879] DR3: ffffffff8437944f DR6: 00000000ffff0ff0 DR7: 0000000000000600
[29808.758880] Call Trace:
[29808.758883]  <TASK>
[29808.758888]  blk_mq_map_queues+0x16/0xc0
[29808.758893]  null_map_queues+0xa5/0xe0 [null_blk]
[29808.758903]  blk_mq_alloc_tag_set+0x14d/0x3f0
[29808.758907]  ? __kmalloc+0xbc/0x130
[29808.758911]  null_add_dev.part.0+0x601/0x700 [null_blk]
[29808.758920]  null_init+0x109/0xff0 [null_blk]
[29808.758929]  ? __pfx_init_module+0x10/0x10 [null_blk]
[29808.758937]  do_one_initcall+0x44/0x220
[29808.758942]  ? kmalloc_trace+0x25/0x90
[29808.758945]  do_init_module+0x4c/0x210
[29808.758949]  __do_sys_finit_module+0xb4/0x130
[29808.758955]  do_syscall_64+0x3b/0x90
[29808.758959]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[29808.758963] RIP: 0033:0x7f00bd52c15d
[29808.758965] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[29808.758967] RSP: 002b:00007ffdc8b239b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[29808.758969] RAX: ffffffffffffffda RBX: 0000559f27d02b90 RCX: 00007f00bd52c15d
[29808.758970] RDX: 0000000000000000 RSI: 0000559f27d02f00 RDI: 0000000000000003
[29808.758971] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[29808.758972] R10: 0000000000000003 R11: 0000000000000246 R12: 0000559f27d02f00
[29808.758973] R13: 0000559f27d02cc0 R14: 0000559f27d02b90 R15: 0000559f27d02f20
[29808.758976]  </TASK>
[29808.758977] ---[ end trace 0000000000000000 ]---
[29808.759827] blk_queue_max_hw_sectors: set to minimum 8
[29808.762992] null_blk: disk nullb0 created
[29808.762995] null_blk: module loaded
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=-2
[29808.802324] blk_queue_max_hw_sectors: set to minimum 8
[29808.804646] null_blk: disk nullb0 created
[29808.804649] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=-1
[29808.847107] blk_queue_max_hw_sectors: set to minimum 8
[29808.849764] null_blk: disk nullb0 created
[29808.849766] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=0
[29808.897238] blk_queue_max_hw_sectors: set to minimum 8
[29808.898255] null_blk: disk nullb0 created
[29808.898257] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1
[29808.949672] blk_queue_max_hw_sectors: set to minimum 8
[29808.951152] null_blk: disk nullb0 created
[29808.951166] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2
[29808.987525] blk_queue_max_hw_sectors: set to minimum 8
[29808.988486] null_blk: disk nullb0 created
[29808.988488] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[29809.036332] blk_queue_max_hw_sectors: set to minimum 8
[29809.037691] null_blk: disk nullb0 created
[29809.037692] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[29809.080423] blk_queue_max_hw_sectors: set to minimum 8
[29809.081865] null_blk: disk nullb0 created
[29809.081875] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[29809.125690] blk_queue_max_hw_sectors: set to minimum 8
[29809.127854] null_blk: disk nullb0 created
[29809.127856] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[29809.168633] blk_queue_max_hw_sectors: set to minimum 8
[29809.171358] null_blk: disk nullb0 created
[29809.171360] null_blk: module loaded
###################################################
queue_mode:
------------------------------------
modprobe null_blk queue_mode=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29809.210899] null_blk: `-2' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29809.244039] null_blk: `-1' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=0
[29809.271652] blk_queue_max_hw_sectors: set to minimum 8
[29809.271912] null_blk: disk nullb0 created
[29809.271913] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29809.308442] null_blk: legacy IO path is no longer available
------------------------------------
modprobe null_blk queue_mode=2
[29809.338844] blk_queue_max_hw_sectors: set to minimum 8
[29809.340121] null_blk: disk nullb0 created
[29809.340124] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29809.389807] null_blk: `4' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29809.421016] null_blk: `8' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29809.453579] null_blk: `32' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29809.483690] null_blk: `64' invalid for parameter `queue_mode'
###################################################
bs:
------------------------------------
modprobe null_blk bs=-2
[29809.510883] null_blk: invalid block size
[29809.510887] null_blk: defaults block size to 4096
[29809.511021] blk_queue_max_hw_sectors: set to minimum 8
[29809.512268] null_blk: disk nullb0 created
[29809.512271] null_blk: module loaded
------------------------------------
modprobe null_blk bs=-1
[29809.565539] null_blk: invalid block size
[29809.565542] null_blk: defaults block size to 4096
[29809.565725] blk_queue_max_hw_sectors: set to minimum 8
[29809.567066] null_blk: disk nullb0 created
[29809.567068] null_blk: module loaded
------------------------------------
modprobe null_blk bs=0
[29809.617620] blk_queue_max_hw_sectors: set to minimum 8
[29809.618808] null_blk: disk nullb0 created
[29809.618810] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1
[29809.672965] blk_queue_max_hw_sectors: set to minimum 8
[29809.674380] null_blk: disk nullb0 created
[29809.674382] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2
[29809.721617] blk_queue_max_hw_sectors: set to minimum 8
[29809.722755] null_blk: disk nullb0 created
[29809.722757] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4
[29809.781839] blk_queue_max_hw_sectors: set to minimum 8
[29809.782801] null_blk: disk nullb0 created
[29809.782803] null_blk: module loaded
------------------------------------
modprobe null_blk bs=8
[29809.834800] blk_queue_max_hw_sectors: set to minimum 8
[29809.836133] null_blk: disk nullb0 created
[29809.836135] null_blk: module loaded
------------------------------------
modprobe null_blk bs=32
[29809.891144] blk_queue_max_hw_sectors: set to minimum 8
[29809.892093] null_blk: disk nullb0 created
[29809.892102] null_blk: module loaded
------------------------------------
modprobe null_blk bs=64
[29809.942584] blk_queue_max_hw_sectors: set to minimum 8
[29809.943572] null_blk: disk nullb0 created
[29809.943574] null_blk: module loaded
------------------------------------
modprobe null_blk bs=512
[29809.982219] blk_queue_max_hw_sectors: set to minimum 8
[29809.983297] null_blk: disk nullb0 created
[29809.983299] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1024
[29810.027215] blk_queue_max_hw_sectors: set to minimum 8
[29810.028126] null_blk: disk nullb0 created
[29810.028128] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2048
[29810.076627] blk_queue_max_hw_sectors: set to minimum 8
[29810.077637] null_blk: disk nullb0 created
[29810.077639] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4096
[29810.124298] blk_queue_max_hw_sectors: set to minimum 8
[29810.125469] null_blk: disk nullb0 created
[29810.125471] null_blk: module loaded

#######################################################################
With this patch series :-

Switched to branch 'nullb-mod-param'
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
+ HOST_DEST=/lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.2M Mar 29 22:47 /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=2
[29813.024441] blk_queue_max_hw_sectors: set to minimum 8
[29813.025409] null_blk: disk nullb0 created
[29813.025411] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[29813.321057] blk_queue_max_hw_sectors: set to minimum 8
[29813.321965] null_blk: disk nullb0 created
[29813.321967] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[29813.617310] blk_queue_max_hw_sectors: set to minimum 8
[29813.618305] null_blk: disk nullb0 created
[29813.618307] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16
[29813.923088] blk_queue_max_hw_sectors: set to minimum 8
[29813.924246] null_blk: disk nullb0 created
[29813.924248] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[29814.227634] blk_queue_max_hw_sectors: set to minimum 8
[29814.229116] null_blk: disk nullb0 created
[29814.229117] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29814.525425] null_blk: `64' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=128
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29814.809105] null_blk: `128' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=256
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29815.093143] null_blk: `256' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=512
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29815.379904] null_blk: `512' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1024
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29815.662093] null_blk: `1024' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2048
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29815.949799] null_blk: `2048' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4096
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29816.232209] null_blk: `4096' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=8192
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29816.519289] null_blk: `8192' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=16384
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29816.805991] null_blk: `16384' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=32768
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29817.091800] null_blk: `32768' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=65536
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29817.383358] null_blk: `65536' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=131072
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29817.686788] null_blk: `131072' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=262144
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29817.974447] null_blk: `262144' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=524288
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29818.256769] null_blk: `524288' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1048576
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29818.541387] null_blk: `1048576' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2097152
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29818.833378] null_blk: `2097152' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4194304
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29819.118551] null_blk: `4194304' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=8388608
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29819.406672] null_blk: `8388608' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=16777216
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29819.693256] null_blk: `16777216' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=33554432
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29819.982153] null_blk: `33554432' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=67108864
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29820.264819] null_blk: `67108864' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=134217728
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29820.558358] null_blk: `134217728' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=268435456
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29820.844221] null_blk: `268435456' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=536870912
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29821.126973] null_blk: `536870912' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1073741824
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29821.411697] null_blk: `1073741824' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29821.696025] null_blk: `2147483648' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29821.980636] null_blk: `4294967296' invalid for parameter `poll_queues'
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=2
[29822.271058] blk_queue_max_hw_sectors: set to minimum 8
[29822.272013] null_blk: disk nullb0 created
[29822.272015] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[29822.577250] blk_queue_max_hw_sectors: set to minimum 8
[29822.578306] null_blk: disk nullb0 created
[29822.578308] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[29822.878662] blk_queue_max_hw_sectors: set to minimum 8
[29822.879803] null_blk: disk nullb0 created
[29822.879805] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16
[29823.176293] blk_queue_max_hw_sectors: set to minimum 8
[29823.177622] null_blk: disk nullb0 created
[29823.177625] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[29823.470223] blk_queue_max_hw_sectors: set to minimum 8
[29823.471933] null_blk: disk nullb0 created
[29823.471935] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[29823.765404] blk_queue_max_hw_sectors: set to minimum 8
[29823.767401] null_blk: disk nullb0 created
[29823.767402] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=128
[29824.062000] blk_queue_max_hw_sectors: set to minimum 8
[29824.064011] null_blk: disk nullb0 created
[29824.064013] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=256
[29824.362641] blk_queue_max_hw_sectors: set to minimum 8
[29824.364717] null_blk: disk nullb0 created
[29824.364720] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=512
[29824.664729] blk_queue_max_hw_sectors: set to minimum 8
[29824.668431] null_blk: disk nullb0 created
[29824.668434] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1024
[29824.963714] blk_queue_max_hw_sectors: set to minimum 8
[29824.966648] null_blk: disk nullb0 created
[29824.966652] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2048
[29825.259201] blk_queue_max_hw_sectors: set to minimum 8
[29825.261395] null_blk: disk nullb0 created
[29825.261397] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4096
[29825.556350] blk_queue_max_hw_sectors: set to minimum 8
[29825.558394] null_blk: disk nullb0 created
[29825.558406] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8192
[29825.853873] blk_queue_max_hw_sectors: set to minimum 8
[29825.856075] null_blk: disk nullb0 created
[29825.856077] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16384
[29826.148449] blk_queue_max_hw_sectors: set to minimum 8
[29826.150502] null_blk: disk nullb0 created
[29826.150504] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32768
[29826.450036] blk_queue_max_hw_sectors: set to minimum 8
[29826.452492] null_blk: disk nullb0 created
[29826.452494] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=65536
[29826.746168] blk_queue_max_hw_sectors: set to minimum 8
[29826.748250] null_blk: disk nullb0 created
[29826.748260] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=131072
[29827.039776] blk_queue_max_hw_sectors: set to minimum 8
[29827.042615] null_blk: disk nullb0 created
[29827.042617] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=262144
[29827.336681] blk_queue_max_hw_sectors: set to minimum 8
[29827.338643] null_blk: disk nullb0 created
[29827.338644] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=524288
[29827.635509] blk_queue_max_hw_sectors: set to minimum 8
[29827.637710] null_blk: disk nullb0 created
[29827.637712] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1048576
[29827.932758] blk_queue_max_hw_sectors: set to minimum 8
[29827.935607] null_blk: disk nullb0 created
[29827.935608] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2097152
[29828.234509] blk_queue_max_hw_sectors: set to minimum 8
[29828.236562] null_blk: disk nullb0 created
[29828.236563] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4194304
[29828.536530] blk_queue_max_hw_sectors: set to minimum 8
[29828.538603] null_blk: disk nullb0 created
[29828.538605] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8388608
[29828.844830] blk_queue_max_hw_sectors: set to minimum 8
[29828.846929] null_blk: disk nullb0 created
[29828.846931] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16777216
[29829.146860] blk_queue_max_hw_sectors: set to minimum 8
[29829.148905] null_blk: disk nullb0 created
[29829.148907] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=33554432
[29829.446979] blk_queue_max_hw_sectors: set to minimum 8
[29829.449044] null_blk: disk nullb0 created
[29829.449046] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=67108864
[29829.740760] blk_queue_max_hw_sectors: set to minimum 8
[29829.742919] null_blk: disk nullb0 created
[29829.742921] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=134217728
[29830.046604] blk_queue_max_hw_sectors: set to minimum 8
[29830.048645] null_blk: disk nullb0 created
[29830.048646] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=268435456
[29830.345440] blk_queue_max_hw_sectors: set to minimum 8
[29830.347542] null_blk: disk nullb0 created
[29830.347544] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=536870912
[29830.647596] blk_queue_max_hw_sectors: set to minimum 8
[29830.649615] null_blk: disk nullb0 created
[29830.649616] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1073741824
[29830.942929] blk_queue_max_hw_sectors: set to minimum 8
[29830.944998] null_blk: disk nullb0 created
[29830.945000] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29831.243009] null_blk: `2147483648' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29831.525673] null_blk: `4294967296' invalid for parameter `submit_queues'
###################################################
hw_queue_depth:
------------------------------------
modprobe null_blk hw_queue_depth=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29831.813457] null_blk: `-2' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29831.845628] null_blk: `-1' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29831.879108] null_blk: `0' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=1
[29831.908773] blk_queue_max_hw_sectors: set to minimum 8
[29831.910063] null_blk: disk nullb0 created
[29831.910065] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=2
[29831.958733] blk_queue_max_hw_sectors: set to minimum 8
[29831.959736] null_blk: disk nullb0 created
[29831.959738] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=4
[29832.006813] blk_queue_max_hw_sectors: set to minimum 8
[29832.007754] null_blk: disk nullb0 created
[29832.007756] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=8
[29832.049729] blk_queue_max_hw_sectors: set to minimum 8
[29832.050784] null_blk: disk nullb0 created
[29832.050785] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=32
[29832.095557] blk_queue_max_hw_sectors: set to minimum 8
[29832.096561] null_blk: disk nullb0 created
[29832.096563] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=64
[29832.140050] blk_queue_max_hw_sectors: set to minimum 8
[29832.141414] null_blk: disk nullb0 created
[29832.141416] null_blk: module loaded
###################################################
max_sectors:
------------------------------------
modprobe null_blk max_sectors=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29832.184817] null_blk: `-2' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29832.217725] null_blk: `-1' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29832.249801] null_blk: `0' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=1
[29832.281462] blk_queue_max_hw_sectors: set to minimum 8
[29832.282385] null_blk: disk nullb0 created
[29832.282387] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=2
[29832.342301] blk_queue_max_hw_sectors: set to minimum 8
[29832.343222] null_blk: disk nullb0 created
[29832.343224] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=4
[29832.398334] blk_queue_max_hw_sectors: set to minimum 8
[29832.399311] null_blk: disk nullb0 created
[29832.399313] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=8
[29832.442835] null_blk: disk nullb0 created
[29832.442838] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=32
[29832.511577] null_blk: disk nullb0 created
[29832.511589] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=64
[29832.553778] null_blk: disk nullb0 created
[29832.553786] null_blk: module loaded
###################################################
gb:
------------------------------------
modprobe null_blk gb=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29832.603651] null_blk: `-2' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29832.634366] null_blk: `-1' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29832.664260] null_blk: `0' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=1
[29832.691916] blk_queue_max_hw_sectors: set to minimum 8
[29832.693222] null_blk: disk nullb0 created
[29832.693224] null_blk: module loaded
------------------------------------
modprobe null_blk gb=2
[29832.743811] blk_queue_max_hw_sectors: set to minimum 8
[29832.745026] null_blk: disk nullb0 created
[29832.745028] null_blk: module loaded
------------------------------------
modprobe null_blk gb=4
[29832.792099] blk_queue_max_hw_sectors: set to minimum 8
[29832.793308] null_blk: disk nullb0 created
[29832.793309] null_blk: module loaded
------------------------------------
modprobe null_blk gb=8
[29832.837967] blk_queue_max_hw_sectors: set to minimum 8
[29832.839361] null_blk: disk nullb0 created
[29832.839363] null_blk: module loaded
------------------------------------
modprobe null_blk gb=32
[29832.883769] blk_queue_max_hw_sectors: set to minimum 8
[29832.884732] null_blk: disk nullb0 created
[29832.884734] null_blk: module loaded
------------------------------------
modprobe null_blk gb=64
[29832.928900] blk_queue_max_hw_sectors: set to minimum 8
[29832.930070] null_blk: disk nullb0 created
[29832.930072] null_blk: module loaded
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29832.967599] null_blk: `-2' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29832.996833] null_blk: `-1' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.024833] null_blk: `0' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1
[29833.058229] blk_queue_max_hw_sectors: set to minimum 8
[29833.059267] null_blk: disk nullb0 created
[29833.059269] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2
[29833.117816] blk_queue_max_hw_sectors: set to minimum 8
[29833.118890] null_blk: disk nullb0 created
[29833.118891] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[29833.171873] blk_queue_max_hw_sectors: set to minimum 8
[29833.173055] null_blk: disk nullb0 created
[29833.173058] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[29833.216892] blk_queue_max_hw_sectors: set to minimum 8
[29833.218046] null_blk: disk nullb0 created
[29833.218048] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[29833.257716] blk_queue_max_hw_sectors: set to minimum 8
[29833.259512] null_blk: disk nullb0 created
[29833.259514] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.326387] null_blk: `64' invalid for parameter `poll_queues'
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.354191] null_blk: `-2' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.388238] null_blk: `-1' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.421095] null_blk: `0' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=1
[29833.450202] blk_queue_max_hw_sectors: set to minimum 8
[29833.451111] null_blk: disk nullb0 created
[29833.451125] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2
[29833.493092] blk_queue_max_hw_sectors: set to minimum 8
[29833.494401] null_blk: disk nullb0 created
[29833.494403] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[29833.533913] blk_queue_max_hw_sectors: set to minimum 8
[29833.535311] null_blk: disk nullb0 created
[29833.535313] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[29833.588867] blk_queue_max_hw_sectors: set to minimum 8
[29833.590556] null_blk: disk nullb0 created
[29833.590558] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[29833.637832] blk_queue_max_hw_sectors: set to minimum 8
[29833.639653] null_blk: disk nullb0 created
[29833.639655] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[29833.690645] blk_queue_max_hw_sectors: set to minimum 8
[29833.692850] null_blk: disk nullb0 created
[29833.692852] null_blk: module loaded
###################################################
queue_mode:
------------------------------------
modprobe null_blk queue_mode=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.729738] null_blk: `-2' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.756616] null_blk: `-1' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=0
[29833.791282] blk_queue_max_hw_sectors: set to minimum 8
[29833.791509] null_blk: disk nullb0 created
[29833.791510] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.830674] null_blk: legacy IO path is no longer available
------------------------------------
modprobe null_blk queue_mode=2
[29833.860434] blk_queue_max_hw_sectors: set to minimum 8
[29833.861943] null_blk: disk nullb0 created
[29833.861946] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.906765] null_blk: `4' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.936713] null_blk: `8' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29833.972052] null_blk: `32' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29834.003994] null_blk: `64' invalid for parameter `queue_mode'
###################################################
bs:
------------------------------------
modprobe null_blk bs=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29834.040940] null_blk: `-2' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29834.070123] null_blk: `-1' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29834.103347] null_blk: `0' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29834.138453] null_blk: `1' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29834.174581] null_blk: `2' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29834.203604] null_blk: `4' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29834.232990] null_blk: `8' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29834.262000] null_blk: `32' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[29834.293152] null_blk: `64' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=512
[29834.321551] blk_queue_max_hw_sectors: set to minimum 8
[29834.322880] null_blk: disk nullb0 created
[29834.322883] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1024
[29834.362304] blk_queue_max_hw_sectors: set to minimum 8
[29834.363459] null_blk: disk nullb0 created
[29834.363461] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2048
[29834.404065] blk_queue_max_hw_sectors: set to minimum 8
[29834.405237] null_blk: disk nullb0 created
[29834.405239] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4096
[29834.447518] blk_queue_max_hw_sectors: set to minimum 8
[29834.448860] null_blk: disk nullb0 created
[29834.448861] null_blk: module loaded
linux-block (nullb-mod-param) # 



[1] Entering kdb (current=0xffff88817eaed100, pid 5624) on processor 12 Oops: (null)
due to oops @ 0xffffffff8165093f
CPU: 12 PID: 5624 Comm: modprobe Tainted: G           OE      6.0.0-rc7blk+ #53
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:blk_mq_alloc_tag_set+0x14f/0x380
Code: 83 c5 01 3b 6b 40 0f 83 9a 01 00 00 48 8b 43 68 4c 63 e5 4e 8d 34 e0 f6 43 58 08 75 d7 8b 53 44 89 ee 48 89 df e8 d1 ed ff ff <49> 89 06 48 8b 43 68 4a 83 3c e0 00 75 c3 83 ed 01 78 0f 89 ee 48
RSP: 0018:ffffc90002eefd70 EFLAGS: 00010282
RAX: ffff888112b155c0 RBX: ffff88811069dc38 RCX: 0000000000000003
RDX: ffff88811069d000 RSI: ffff88810ed60000 RDI: 00000000000001f8
RBP: 0000000000000000 R08: 0000000000000003 R09: ffff888112b15650
R10: 000000000010ed60 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000040 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f71e4147b80(0000) GS:ffff888fff500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000014d81c000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 null_add_dev+0x7a7/0x870 [null_blk]
 null_init+0x1de/0x1000 [null_blk]
 ? 0xffffffffc03a9000
 do_one_initcall+0x44/0x210
 ? kmem_cache_alloc_trace+0x15b/0x2b0
 do_init_module+0x4c/0x1f0
 __do_sys_finit_module+0xb4/0x130
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f71e426e15d
Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fffb29f27a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000564b29d78b90 RCX: 00007f71e426e15d
RDX: 0000000000000000 RSI: 0000564b29d78f00 RDI: 0000000000000003
RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
R10: 0000000000000003 R11: 0000000000000246 R12: 0000564b29d78f00
R13: 0000564b29d78cc0 R14: 0000564b29d78b90 R15: 0000564b29d78f20
 </TASK>
-- 
2.29.0

