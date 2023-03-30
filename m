Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1775C7619A
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjC3VcH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjC3VcH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:32:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3358AC17F
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+a1lZ2dWgHL/mbg1dKwOVHnQAPfKSgTU+Kac9mtrNeSfwiBv+KUjWoHp6Gei/zm7ayWpNvPKnUQyHy2euHMoldQDx8g5apUCJV9R8ovIpM004vytwcNSP2OglLzyCZ/R9YsYVzV1+MO7+IRphEnMKQbssgmAxyiXvELaGTXAADQyHfDBMDxlpeU3hcVTyIDes7r5aBIjBRV3XtebpjmcIOIF712MRQA2dDNU3Tj7I6Y7EK6XGC6nq6QxxmIHSFqAp0RfSJ/r4NnTAfWfmE9cIfxAlrhbNq7np7QK2XPROh8yppEZoEWY7tJxOq06zjjZSnug/yqMQ+Ejy5Jqpcy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/stHffpBr1DeyxmVz8QP00j+RDWZdC6eitTS+XwPpE=;
 b=Rafoze0XDukjGg5PWm5uCJ/fguGQAbT0yyG7wudUvhHEANi47C7asJtlQsYcyRTJ1vzZPy/Z/JEuxhibbRPJa8vGeBK4HyAP/hjAT761notNuZFtMusTtvZTWXuIy7BHAVzZqETG0PLNyQweg1x9KesmGDtlQ+e7CNpgqyddGOFbP4XhcVQhRaurq1g5IAXStxgegqQWAB2kYOZtz86M4/daXKiZQtbYVNgC8d5Bh2+xDe/6IPpvQsjzf6IJP//w1wRmffu4uD8OaM7VARbZqEM3XZ5WRpbSvjgo7FZd1SHqXyXPU+povqyrTg/mlrXoFpj4Izny7tGBZHK27PQ/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/stHffpBr1DeyxmVz8QP00j+RDWZdC6eitTS+XwPpE=;
 b=coz3zVbnH0CPJYjo4QG64Kg+9J/Oy9s1st1imgN+aoSTGZV73rMQ6KHb0zK2gaRbaqKt6OHl+MIyfqwREEfLLseLTfYKzHTqUPST4KbjoHoBQVvCh/EWcqlAfVMzfoRWQ+u0XlwABL0h4pF2E1Gt2ovw9r4OKGKZBhcTTKru6O5jJjUhee60RkldnrIKbBdozuyzfaQmYFwiE+1FvGSDVrZwVxvcs9ZaAVP0pOUFxAoEVyZGhVQ7J3SVGSdLexLDIqZbRsWRF0n/ZYcrLnZi9hA/iNbE2JU2SfdPBozb7kiNrgCFS4ShW+JfUgyWZGClyJ99d688k33cS392kPBbpg==
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 21:31:56 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::8f) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 21:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.23 via Frontend Transport; Thu, 30 Mar 2023 21:31:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 14:31:45 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 14:31:44 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 0/9] null_blk: add modparam checks
Date:   Thu, 30 Mar 2023 14:31:25 -0700
Message-ID: <20230330213134.131298-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: b223f882-6fe3-4ea5-3732-08db31663023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ii/vYyfB4M961G3F9QaMfXGlzs4kuJE/WfCBKxWj0WkxEe2y6Mn7XRhKevpG7cnAwln6uwWQuN/+OKuEEHqR8+/AVKNK/S3KfEKwN0qIS2yF7xXbZF3asss5+Pu8dlqLxwZ+A/TgLbR78vWygfW8pW5mMBk7+ot4x/8kVxJmUbnRtyZAApgXvUbMHxUuvONsCjnhMyXSIfjOYzUIYWdDsVyfA4mvpP5ke0vXnfjK2igFYqCAWvmL5qUghyg85mUX6cYeN9+JCNg0tOkEJq0cM32rjojrilHn9skvq/MT7SJW07UGH14H8N115AAqId/XgrmhjzGHavgxnSdbrFnJ5IGTvuUElwYIv52gym+wo238gK8PJbfxJAIduZYvLhfI24Ra0CVX3vIqXi8AUEvcGcb6tQp22LfwMjPPy6EmWZHwDbhAGJ8FH0VgaclD5+g9gylXYpRaoe8wXbtuIuqwAR2sUhGff9d08RIR06pEquR/hDE3TzDlGKeP9AsVe3TEq5HnG08kq7UlzitTsssylhpSqkqlVElmL3212+kwnPqobiuE8NtD10Tv9SWfSop5Yhf8iz0/zv302bV2hL1DLupVxTHOvBz6SsjatZvaxC7PWul+SlEfjWSyi+xN+F+s2VEkp3RUKswcxN2Cgn8FSqE7XQRsCOmZf/gvygGti1ODLqbu7ib/Osl4/JOyHRjdRLmfd/xhok0+yz9d4hYBRCWIA0LpQTXqL9765uK7hSvRbxQ603UtPwhQd367SsH2XuKjcBkZqlT6D39KbUn56oCFshhDxz7rC2T65mRvqxXLRmvVNPYLGTtNA70KQw+q
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(40460700003)(36756003)(70206006)(356005)(7636003)(6916009)(5660300002)(82310400005)(30864003)(8936002)(4326008)(70586007)(82740400003)(40480700001)(8676002)(41300700001)(336012)(54906003)(2616005)(426003)(34020700004)(36860700001)(83380400001)(1076003)(6666004)(2906002)(26005)(45080400002)(478600001)(7696005)(186003)(16526019)(316002)(579004)(559001)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:31:56.6159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b223f882-6fe3-4ea5-3732-08db31663023
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
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

Add modpram validation callbacks to make sure we will not allow users
to set unintended values even by mistake and generate appropriate
error without any futher processing.

Please note that this is needed to write a big daddy testcase where it
uses all possible big values for the module parameters and make sure 
block layers tag allocation works without any OOPs  and errors out
gracefully.

Below is the test result with and without this series where appriparite
error is returned for modparams listed below. 

Last two patches removes the global variable used in modparam callback
so everything stays consistent in code and adds a proper error message.

-ck

v1->v2:

* Add meaningful error messages with valid ranges on error in param
callbacks.
* Retest/regenerate testlog with new error messages.

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

 drivers/block/null_blk/main.c | 148 +++++++++++++++++++++++++++-------
 1 file changed, 121 insertions(+), 27 deletions(-)

inux-block (nullb-mod-param) # ./test-mod-param.sh 
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
-rw-r--r--. 1 root root 1.2M Mar 30 14:16 /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=2
[85535.786996] blk_queue_max_hw_sectors: set to minimum 8
[85535.787994] null_blk: disk nullb0 created
[85535.787995] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[85536.084914] blk_queue_max_hw_sectors: set to minimum 8
[85536.085938] null_blk: disk nullb0 created
[85536.085941] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[85536.383295] blk_queue_max_hw_sectors: set to minimum 8
[85536.384388] null_blk: disk nullb0 created
[85536.384390] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16
[85536.676315] blk_queue_max_hw_sectors: set to minimum 8
[85536.677582] null_blk: disk nullb0 created
[85536.677585] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[85536.975031] blk_queue_max_hw_sectors: set to minimum 8
[85536.976667] null_blk: disk nullb0 created
[85536.976669] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
[85537.271485] ------------[ cut here ]------------
[85537.271487] WARNING: CPU: 17 PID: 80557 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[85537.271493] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[85537.271523] CPU: 17 PID: 80557 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[85537.271525] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[85537.271526] RIP: 0010:group_cpus_evenly+0x26e/0x280
[85537.271528] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[85537.271530] RSP: 0018:ffffc90000da3cb8 EFLAGS: 00010287
[85537.271531] RAX: 0000000080000000 RBX: 0000000000000040 RCX: 0000000000000000
[85537.271533] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[85537.271534] RBP: ffff8888391ad478 R08: ffff8888391ade28 R09: ffff8888703c0000
[85537.271535] R10: ffff8888391ade28 R11: 0000000000000000 R12: ffff8888703c0000
[85537.271536] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[85537.271538] FS:  00007f3f2492fb80(0000) GS:ffff888fff640000(0000) knlGS:0000000000000000
[85537.271539] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[85537.271540] CR2: 00007f3f24506800 CR3: 0000000876f32000 CR4: 0000000000350ee0
[85537.271543] DR0: ffffffff84379424 DR1: ffffffff84379425 DR2: ffffffff84379426
[85537.271544] DR3: ffffffff84379427 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[85537.271545] Call Trace:
[85537.271546]  <TASK>
[85537.271548]  blk_mq_map_queues+0x16/0xc0
[85537.271556]  null_map_queues+0xa5/0xe0 [null_blk]
[85537.271562]  blk_mq_alloc_tag_set+0x14d/0x3f0
[85537.271565]  ? __kmalloc+0xbc/0x130
[85537.271568]  null_add_dev.part.0+0x601/0x700 [null_blk]
[85537.271574]  null_init+0x109/0xff0 [null_blk]
[85537.271580]  ? __pfx_init_module+0x10/0x10 [null_blk]
[85537.271587]  do_one_initcall+0x44/0x220
[85537.271591]  ? kmalloc_trace+0x25/0x90
[85537.271593]  do_init_module+0x4c/0x210
[85537.271596]  __do_sys_finit_module+0xb4/0x130
[85537.271600]  do_syscall_64+0x3b/0x90
[85537.271604]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[85537.271607] RIP: 0033:0x7f3f2452c15d
[85537.271609] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[85537.271610] RSP: 002b:00007ffdf84e38b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[85537.271611] RAX: ffffffffffffffda RBX: 000055850f4a7b90 RCX: 00007f3f2452c15d
[85537.271612] RDX: 0000000000000000 RSI: 000055850f4a7f00 RDI: 0000000000000003
[85537.271613] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[85537.271614] R10: 0000000000000003 R11: 0000000000000246 R12: 000055850f4a7f00
[85537.271615] R13: 000055850f4a7cc0 R14: 000055850f4a7b90 R15: 000055850f4a7f20
[85537.271617]  </TASK>
[85537.271617] ---[ end trace 0000000000000000 ]---
[85537.272231] blk_queue_max_hw_sectors: set to minimum 8
[85537.274531] null_blk: disk nullb0 created
[85537.274533] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=128
[85537.574253] ------------[ cut here ]------------
[85537.574258] WARNING: CPU: 19 PID: 80564 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[85537.574266] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[85537.574340] CPU: 19 PID: 80564 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[85537.574343] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[85537.574345] RIP: 0010:group_cpus_evenly+0x26e/0x280
[85537.574348] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[85537.574351] RSP: 0018:ffffc90000da3cb8 EFLAGS: 00010283
[85537.574353] RAX: 0000000080000000 RBX: 0000000000000080 RCX: 0000000000000000
[85537.574354] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[85537.574356] RBP: ffff8888772a6a38 R08: ffff8888772a6278 R09: ffff888832f00000
[85537.574357] R10: ffff8888772a6278 R11: 0000000000000000 R12: ffff888832f00000
[85537.574358] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[85537.574361] FS:  00007f375db00b80(0000) GS:ffff888fff6c0000(0000) knlGS:0000000000000000
[85537.574363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[85537.574364] CR2: 00007f375d706800 CR3: 00000001432c2000 CR4: 0000000000350ee0
[85537.574368] DR0: ffffffff8437942c DR1: ffffffff8437942d DR2: ffffffff8437942e
[85537.574369] DR3: ffffffff8437942f DR6: 00000000ffff0ff0 DR7: 0000000000000600
[85537.574370] Call Trace:
[85537.574372]  <TASK>
[85537.574375]  blk_mq_map_queues+0x16/0xc0
[85537.574380]  null_map_queues+0xa5/0xe0 [null_blk]
[85537.574389]  blk_mq_alloc_tag_set+0x14d/0x3f0
[85537.574393]  ? __kmalloc+0xbc/0x130
[85537.574397]  null_add_dev.part.0+0x601/0x700 [null_blk]
[85537.574406]  null_init+0x109/0xff0 [null_blk]
[85537.574415]  ? __pfx_init_module+0x10/0x10 [null_blk]
[85537.574423]  do_one_initcall+0x44/0x220
[85537.574429]  ? kmalloc_trace+0x25/0x90
[85537.574432]  do_init_module+0x4c/0x210
[85537.574437]  __do_sys_finit_module+0xb4/0x130
[85537.574442]  do_syscall_64+0x3b/0x90
[85537.574448]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[85537.574461] RIP: 0033:0x7f375d72c15d
[85537.574464] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[85537.574465] RSP: 002b:00007ffff88d8be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[85537.574468] RAX: ffffffffffffffda RBX: 000055e8fc068b90 RCX: 00007f375d72c15d
[85537.574469] RDX: 0000000000000000 RSI: 000055e8fc068f00 RDI: 0000000000000003
[85537.574470] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[85537.574472] R10: 0000000000000003 R11: 0000000000000246 R12: 000055e8fc068f00
[85537.574473] R13: 000055e8fc068cc0 R14: 000055e8fc068b90 R15: 000055e8fc068f20
[85537.574476]  </TASK>
[85537.574477] ---[ end trace 0000000000000000 ]---
[85537.575962] blk_queue_max_hw_sectors: set to minimum 8
[85537.580150] null_blk: disk nullb0 created
[85537.580152] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=256
[85537.876910] ------------[ cut here ]------------
[85537.876914] WARNING: CPU: 17 PID: 80571 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[85537.876921] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[85537.876950] CPU: 17 PID: 80571 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[85537.876952] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[85537.876953] RIP: 0010:group_cpus_evenly+0x26e/0x280
[85537.876955] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[85537.876957] RSP: 0018:ffffc90000da3cb8 EFLAGS: 00010287
[85537.876958] RAX: 0000000080000000 RBX: 0000000000000100 RCX: 0000000000000000
[85537.876959] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[85537.876960] RBP: ffff88820b9168d0 R08: ffff88820b916920 R09: ffff888f02580000
[85537.876961] R10: ffff88820b916920 R11: 0000000000000000 R12: ffff888f02580000
[85537.876962] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[85537.876964] FS:  00007fefe9fd0b80(0000) GS:ffff888fff640000(0000) knlGS:0000000000000000
[85537.876965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[85537.876966] CR2: 00007fefe9b06800 CR3: 0000000832b18000 CR4: 0000000000350ee0
[85537.876969] DR0: ffffffff84379424 DR1: ffffffff84379425 DR2: ffffffff84379426
[85537.876970] DR3: ffffffff84379427 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[85537.876970] Call Trace:
[85537.876972]  <TASK>
[85537.876974]  blk_mq_map_queues+0x16/0xc0
[85537.876977]  null_map_queues+0xa5/0xe0 [null_blk]
[85537.876984]  blk_mq_alloc_tag_set+0x14d/0x3f0
[85537.876986]  ? __kmalloc+0xbc/0x130
[85537.876989]  null_add_dev.part.0+0x601/0x700 [null_blk]
[85537.876995]  null_init+0x109/0xff0 [null_blk]
[85537.877001]  ? __pfx_init_module+0x10/0x10 [null_blk]
[85537.877006]  do_one_initcall+0x44/0x220
[85537.877010]  ? kmalloc_trace+0x25/0x90
[85537.877012]  do_init_module+0x4c/0x210
[85537.877015]  __do_sys_finit_module+0xb4/0x130
[85537.877018]  do_syscall_64+0x3b/0x90
[85537.877022]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[85537.877026] RIP: 0033:0x7fefe9b2c15d
[85537.877027] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[85537.877033] RSP: 002b:00007fff51dbc868 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[85537.877035] RAX: ffffffffffffffda RBX: 00005612f7aa2b90 RCX: 00007fefe9b2c15d
[85537.877036] RDX: 0000000000000000 RSI: 00005612f7aa2f00 RDI: 0000000000000003
[85537.877036] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[85537.877037] R10: 0000000000000003 R11: 0000000000000246 R12: 00005612f7aa2f00
[85537.877038] R13: 00005612f7aa2cc0 R14: 00005612f7aa2b90 R15: 00005612f7aa2f20
[85537.877040]  </TASK>
[85537.877041] ---[ end trace 0000000000000000 ]---
[85537.879390] blk_queue_max_hw_sectors: set to minimum 8
[85537.885714] null_blk: disk nullb0 created
[85537.885717] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=512
[85538.187662] ------------[ cut here ]------------
[85538.187665] WARNING: CPU: 17 PID: 80578 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[85538.187671] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[85538.187707] CPU: 17 PID: 80578 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[85538.187709] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[85538.187711] RIP: 0010:group_cpus_evenly+0x26e/0x280
[85538.187713] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[85538.187714] RSP: 0018:ffffc90000da3cb8 EFLAGS: 00010287
[85538.187715] RAX: 0000000080000000 RBX: 0000000000000200 RCX: 0000000000000000
[85538.187717] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[85538.187718] RBP: ffff8888391add08 R08: ffff8888391ad430 R09: ffff888f02500000
[85538.187718] R10: ffff8888391ad430 R11: 0000000000000000 R12: ffff888f02500000
[85538.187719] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[85538.187721] FS:  00007f9740b7eb80(0000) GS:ffff888fff640000(0000) knlGS:0000000000000000
[85538.187722] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[85538.187723] CR2: 00007f9740706800 CR3: 0000000f0260a000 CR4: 0000000000350ee0
[85538.187725] DR0: ffffffff84379424 DR1: ffffffff84379425 DR2: ffffffff84379426
[85538.187726] DR3: ffffffff84379427 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[85538.187727] Call Trace:
[85538.187729]  <TASK>
[85538.187730]  blk_mq_map_queues+0x16/0xc0
[85538.187734]  null_map_queues+0xa5/0xe0 [null_blk]
[85538.187740]  blk_mq_alloc_tag_set+0x14d/0x3f0
[85538.187743]  ? __kmalloc+0xbc/0x130
[85538.187746]  null_add_dev.part.0+0x601/0x700 [null_blk]
[85538.187752]  null_init+0x109/0xff0 [null_blk]
[85538.187757]  ? __pfx_init_module+0x10/0x10 [null_blk]
[85538.187762]  do_one_initcall+0x44/0x220
[85538.187766]  ? kmalloc_trace+0x25/0x90
[85538.187768]  do_init_module+0x4c/0x210
[85538.187771]  __do_sys_finit_module+0xb4/0x130
[85538.187775]  do_syscall_64+0x3b/0x90
[85538.187779]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[85538.187782] RIP: 0033:0x7f974072c15d
[85538.187784] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[85538.187785] RSP: 002b:00007ffefc5e20a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[85538.187787] RAX: ffffffffffffffda RBX: 0000562fac3f2b90 RCX: 00007f974072c15d
[85538.187787] RDX: 0000000000000000 RSI: 0000562fac3f2f00 RDI: 0000000000000003
[85538.187791] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[85538.187791] R10: 0000000000000003 R11: 0000000000000246 R12: 0000562fac3f2f00
[85538.187792] R13: 0000562fac3f2cc0 R14: 0000562fac3f2b90 R15: 0000562fac3f2f20
[85538.187794]  </TASK>
[85538.187795] ---[ end trace 0000000000000000 ]---
[85538.192164] blk_queue_max_hw_sectors: set to minimum 8
[85538.204007] null_blk: disk nullb0 created
[85538.204010] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=1024
[85538.509224] ------------[ cut here ]------------
[85538.509229] WARNING: CPU: 19 PID: 80585 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[85538.509237] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[85538.509296] CPU: 19 PID: 80585 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[85538.509299] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[85538.509301] RIP: 0010:group_cpus_evenly+0x26e/0x280
[85538.509304] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[85538.509306] RSP: 0018:ffffc90000da3cb8 EFLAGS: 00010287
[85538.509308] RAX: 0000000080000000 RBX: 0000000000000400 RCX: 0000000000000000
[85538.509310] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[85538.509311] RBP: ffff8888772a64e0 R08: ffff8888772a6878 R09: ffff888f02400000
[85538.509313] R10: ffff8888772a6878 R11: 0000000000000000 R12: ffff888f02400000
[85538.509314] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[85538.509316] FS:  00007fb886fa2b80(0000) GS:ffff888fff6c0000(0000) knlGS:0000000000000000
[85538.509318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[85538.509320] CR2: 00007fb886b06800 CR3: 00000001432c2000 CR4: 0000000000350ee0
[85538.509324] DR0: ffffffff8437942c DR1: ffffffff8437942d DR2: ffffffff8437942e
[85538.509325] DR3: ffffffff8437942f DR6: 00000000ffff0ff0 DR7: 0000000000000600
[85538.509326] Call Trace:
[85538.509328]  <TASK>
[85538.509330]  blk_mq_map_queues+0x16/0xc0
[85538.509335]  null_map_queues+0xa5/0xe0 [null_blk]
[85538.509344]  blk_mq_alloc_tag_set+0x14d/0x3f0
[85538.509348]  ? __kmalloc+0xbc/0x130
[85538.509352]  null_add_dev.part.0+0x601/0x700 [null_blk]
[85538.509361]  null_init+0x109/0xff0 [null_blk]
[85538.509370]  ? __pfx_init_module+0x10/0x10 [null_blk]
[85538.509378]  do_one_initcall+0x44/0x220
[85538.509384]  ? kmalloc_trace+0x25/0x90
[85538.509387]  do_init_module+0x4c/0x210
[85538.509393]  __do_sys_finit_module+0xb4/0x130
[85538.509398]  do_syscall_64+0x3b/0x90
[85538.509403]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[85538.509409] RIP: 0033:0x7fb886b2c15d
[85538.509412] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[85538.509414] RSP: 002b:00007ffeb2461088 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[85538.509416] RAX: ffffffffffffffda RBX: 00005644410f0b90 RCX: 00007fb886b2c15d
[85538.509417] RDX: 0000000000000000 RSI: 00005644410f0f00 RDI: 0000000000000003
[85538.509418] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[85538.509420] R10: 0000000000000003 R11: 0000000000000246 R12: 00005644410f0f00
[85538.509421] R13: 00005644410f0cc0 R14: 00005644410f0b90 R15: 00005644410f0f20
[85538.509434]  </TASK>
[85538.509434] ---[ end trace 0000000000000000 ]---
[85538.519776] blk_queue_max_hw_sectors: set to minimum 8
[85538.541932] null_blk: disk nullb0 created
[85538.541936] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2048
[85538.865601] ------------[ cut here ]------------
[85538.865605] WARNING: CPU: 18 PID: 80592 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[85538.865611] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[85538.865642] CPU: 18 PID: 80592 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[85538.865644] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[85538.865645] RIP: 0010:group_cpus_evenly+0x26e/0x280
[85538.865647] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[85538.865649] RSP: 0018:ffffc90000da3cb8 EFLAGS: 00010287
[85538.865650] RAX: 0000000080000000 RBX: 0000000000000800 RCX: 0000000000000000
[85538.865651] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[85538.865653] RBP: ffff88882c117c48 R08: ffff88882c117488 R09: ffff88884e000000
[85538.865654] R10: ffff88882c117488 R11: 0000000000000000 R12: ffff88884e000000
[85538.865654] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[85538.865656] FS:  00007f1198066b80(0000) GS:ffff888fff680000(0000) knlGS:0000000000000000
[85538.865658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[85538.865659] CR2: 00007f1197b06800 CR3: 000000083a5e8000 CR4: 0000000000350ee0
[85538.865661] DR0: ffffffff84379428 DR1: ffffffff84379429 DR2: ffffffff8437942a
[85538.865672] DR3: ffffffff8437942b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[85538.865673] Call Trace:
[85538.865675]  <TASK>
[85538.865676]  blk_mq_map_queues+0x16/0xc0
[85538.865680]  null_map_queues+0xa5/0xe0 [null_blk]
[85538.865686]  blk_mq_alloc_tag_set+0x14d/0x3f0
[85538.865689]  ? __kmalloc+0xbc/0x130
[85538.865692]  null_add_dev.part.0+0x601/0x700 [null_blk]
[85538.865698]  null_init+0x109/0xff0 [null_blk]
[85538.865704]  ? __pfx_init_module+0x10/0x10 [null_blk]
[85538.865709]  do_one_initcall+0x44/0x220
[85538.865713]  ? kmalloc_trace+0x25/0x90
[85538.865715]  do_init_module+0x4c/0x210
[85538.865718]  __do_sys_finit_module+0xb4/0x130
[85538.865722]  do_syscall_64+0x3b/0x90
[85538.865726]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[85538.865730] RIP: 0033:0x7f1197b2c15d
[85538.865731] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[85538.865733] RSP: 002b:00007ffc7dabc748 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[85538.865734] RAX: ffffffffffffffda RBX: 000055c316c2db90 RCX: 00007f1197b2c15d
[85538.865735] RDX: 0000000000000000 RSI: 000055c316c2df00 RDI: 0000000000000003
[85538.865736] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[85538.865737] R10: 0000000000000003 R11: 0000000000000246 R12: 000055c316c2df00
[85538.865738] R13: 000055c316c2dcc0 R14: 000055c316c2db90 R15: 000055c316c2df20
[85538.865740]  </TASK>
[85538.865740] ---[ end trace 0000000000000000 ]---
[85538.884052] blk_queue_max_hw_sectors: set to minimum 8
[85538.935360] null_blk: disk nullb0 created
[85538.935365] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4096
[85539.272074] ------------[ cut here ]------------
[85539.272084] WARNING: CPU: 17 PID: 80599 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[85539.272090] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[85539.272118] CPU: 17 PID: 80599 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[85539.272120] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[85539.272121] RIP: 0010:group_cpus_evenly+0x26e/0x280
[85539.272123] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[85539.272125] RSP: 0018:ffffc90000da3cb8 EFLAGS: 00010287
[85539.272126] RAX: 0000000080000000 RBX: 0000000000001000 RCX: 0000000000000000
[85539.272128] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[85539.272129] RBP: ffff88886e0ff3e0 R08: ffff88886e0ffe18 R09: ffff88882e800000
[85539.272130] R10: ffff88886e0ffe18 R11: 0000000000000000 R12: ffff88882e800000
[85539.272130] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[85539.272132] FS:  00007f96a8d90b80(0000) GS:ffff888fff640000(0000) knlGS:0000000000000000
[85539.272133] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[85539.272134] CR2: 00007f96a8906800 CR3: 000000084f5c6000 CR4: 0000000000350ee0
[85539.272137] DR0: ffffffff84379424 DR1: ffffffff84379425 DR2: ffffffff84379426
[85539.272138] DR3: ffffffff84379427 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[85539.272139] Call Trace:
[85539.272141]  <TASK>
[85539.272142]  blk_mq_map_queues+0x16/0xc0
[85539.272146]  null_map_queues+0xa5/0xe0 [null_blk]
[85539.272152]  blk_mq_alloc_tag_set+0x14d/0x3f0
[85539.272154]  ? __kmalloc+0xbc/0x130
[85539.272157]  null_add_dev.part.0+0x601/0x700 [null_blk]
[85539.272163]  null_init+0x109/0xff0 [null_blk]
[85539.272169]  ? __pfx_init_module+0x10/0x10 [null_blk]
[85539.272175]  do_one_initcall+0x44/0x220
[85539.272179]  ? kmalloc_trace+0x25/0x90
[85539.272180]  do_init_module+0x4c/0x210
[85539.272184]  __do_sys_finit_module+0xb4/0x130
[85539.272187]  do_syscall_64+0x3b/0x90
[85539.272191]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[85539.272194] RIP: 0033:0x7f96a892c15d
[85539.272196] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[85539.272197] RSP: 002b:00007ffd6328fa18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[85539.272199] RAX: ffffffffffffffda RBX: 000055720d3a2b90 RCX: 00007f96a892c15d
[85539.272200] RDX: 0000000000000000 RSI: 000055720d3a2f00 RDI: 0000000000000003
[85539.272201] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[85539.272202] R10: 0000000000000003 R11: 0000000000000246 R12: 000055720d3a2f00
[85539.272202] R13: 000055720d3a2cc0 R14: 000055720d3a2b90 R15: 000055720d3a2f20
[85539.272204]  </TASK>
[85539.272205] ---[ end trace 0000000000000000 ]---
[85539.307208] blk_queue_max_hw_sectors: set to minimum 8
[85539.392459] null_blk: disk nullb0 created
[85539.392464] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8192
[85539.859071] blk_queue_max_hw_sectors: set to minimum 8
[85540.027607] null_blk: disk nullb0 created
[85540.027612] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16384
[85540.655160] blk_queue_max_hw_sectors: set to minimum 8
[85540.986004] null_blk: disk nullb0 created
[85540.986009] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32768
[85541.950356] blk_queue_max_hw_sectors: set to minimum 8
[85542.616912] null_blk: disk nullb0 created
[85542.616917] null_blk: module loaded
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
[85548.024996] null_blk: `2147483648' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Numerical result out of range
[85548.317839] null_blk: `4294967296' invalid for parameter `poll_queues'
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=2
[85548.607278] blk_queue_max_hw_sectors: set to minimum 8
[85548.608246] null_blk: disk nullb0 created
[85548.608248] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[85548.900217] blk_queue_max_hw_sectors: set to minimum 8
[85548.901255] null_blk: disk nullb0 created
[85548.901258] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[85549.198608] blk_queue_max_hw_sectors: set to minimum 8
[85549.199634] null_blk: disk nullb0 created
[85549.199635] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16
[85549.499112] blk_queue_max_hw_sectors: set to minimum 8
[85549.500355] null_blk: disk nullb0 created
[85549.500357] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[85549.792556] blk_queue_max_hw_sectors: set to minimum 8
[85549.794668] null_blk: disk nullb0 created
[85549.794670] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[85550.087530] blk_queue_max_hw_sectors: set to minimum 8
[85550.089580] null_blk: disk nullb0 created
[85550.089582] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=128
[85550.381325] blk_queue_max_hw_sectors: set to minimum 8
[85550.383356] null_blk: disk nullb0 created
[85550.383359] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=256
[85550.677934] blk_queue_max_hw_sectors: set to minimum 8
[85550.679829] null_blk: disk nullb0 created
[85550.679831] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=512
[85550.979365] blk_queue_max_hw_sectors: set to minimum 8
[85550.981348] null_blk: disk nullb0 created
[85550.981349] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1024
[85551.278829] blk_queue_max_hw_sectors: set to minimum 8
[85551.280806] null_blk: disk nullb0 created
[85551.280808] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2048
[85551.585651] blk_queue_max_hw_sectors: set to minimum 8
[85551.587642] null_blk: disk nullb0 created
[85551.587644] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4096
[85551.882261] blk_queue_max_hw_sectors: set to minimum 8
[85551.884239] null_blk: disk nullb0 created
[85551.884241] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8192
[85552.179227] blk_queue_max_hw_sectors: set to minimum 8
[85552.181221] null_blk: disk nullb0 created
[85552.181223] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16384
[85552.477940] blk_queue_max_hw_sectors: set to minimum 8
[85552.480921] null_blk: disk nullb0 created
[85552.480922] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32768
[85552.782169] blk_queue_max_hw_sectors: set to minimum 8
[85552.784198] null_blk: disk nullb0 created
[85552.784200] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=65536
[85553.082069] blk_queue_max_hw_sectors: set to minimum 8
[85553.084073] null_blk: disk nullb0 created
[85553.084075] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=131072
[85553.383975] blk_queue_max_hw_sectors: set to minimum 8
[85553.385943] null_blk: disk nullb0 created
[85553.385944] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=262144
[85553.677991] blk_queue_max_hw_sectors: set to minimum 8
[85553.679921] null_blk: disk nullb0 created
[85553.679923] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=524288
[85553.972282] blk_queue_max_hw_sectors: set to minimum 8
[85553.974135] null_blk: disk nullb0 created
[85553.974137] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1048576
[85554.271399] blk_queue_max_hw_sectors: set to minimum 8
[85554.273293] null_blk: disk nullb0 created
[85554.273295] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2097152
[85554.569012] blk_queue_max_hw_sectors: set to minimum 8
[85554.570835] null_blk: disk nullb0 created
[85554.570837] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4194304
[85554.867135] blk_queue_max_hw_sectors: set to minimum 8
[85554.869001] null_blk: disk nullb0 created
[85554.869003] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8388608
[85555.173352] blk_queue_max_hw_sectors: set to minimum 8
[85555.175154] null_blk: disk nullb0 created
[85555.175156] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16777216
[85555.467814] blk_queue_max_hw_sectors: set to minimum 8
[85555.469632] null_blk: disk nullb0 created
[85555.469634] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=33554432
[85555.762872] blk_queue_max_hw_sectors: set to minimum 8
[85555.764739] null_blk: disk nullb0 created
[85555.764741] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=67108864
[85556.057454] blk_queue_max_hw_sectors: set to minimum 8
[85556.059485] null_blk: disk nullb0 created
[85556.059486] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=134217728
[85556.359936] blk_queue_max_hw_sectors: set to minimum 8
[85556.361833] null_blk: disk nullb0 created
[85556.361834] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=268435456
[85556.658591] blk_queue_max_hw_sectors: set to minimum 8
[85556.660519] null_blk: disk nullb0 created
[85556.660521] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=536870912
[85556.957393] blk_queue_max_hw_sectors: set to minimum 8
[85556.959334] null_blk: disk nullb0 created
[85556.959336] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1073741824
[85557.257751] blk_queue_max_hw_sectors: set to minimum 8
[85557.259656] null_blk: disk nullb0 created
[85557.259658] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Numerical result out of range
[85557.555721] null_blk: `2147483648' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Numerical result out of range
[85557.845728] null_blk: `4294967296' invalid for parameter `submit_queues'
###################################################
hw_queue_depth:
------------------------------------
modprobe null_blk hw_queue_depth=-2
[85558.129326] blk-mq: reduced tag depth to 10240
[85558.130277] blk_queue_max_hw_sectors: set to minimum 8
[85558.131687] null_blk: disk nullb0 created
[85558.131690] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=-1
[85558.186663] blk-mq: reduced tag depth to 10240
[85558.187976] blk_queue_max_hw_sectors: set to minimum 8
[85558.189195] null_blk: disk nullb0 created
[85558.189197] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
------------------------------------
modprobe null_blk hw_queue_depth=1
[85558.259795] blk_queue_max_hw_sectors: set to minimum 8
[85558.260747] null_blk: disk nullb0 created
[85558.260763] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=2
[85558.305479] blk_queue_max_hw_sectors: set to minimum 8
[85558.306481] null_blk: disk nullb0 created
[85558.306483] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=4
[85558.353269] blk_queue_max_hw_sectors: set to minimum 8
[85558.354345] null_blk: disk nullb0 created
[85558.354347] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=8
[85558.403575] blk_queue_max_hw_sectors: set to minimum 8
[85558.404526] null_blk: disk nullb0 created
[85558.404527] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=32
[85558.441443] blk_queue_max_hw_sectors: set to minimum 8
[85558.442708] null_blk: disk nullb0 created
[85558.442711] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=64
[85558.485167] blk_queue_max_hw_sectors: set to minimum 8
[85558.486093] null_blk: disk nullb0 created
[85558.486094] null_blk: module loaded
###################################################
max_sectors:
------------------------------------
modprobe null_blk max_sectors=-2
[85558.538348] null_blk: invalid max sectors
[85558.538352] null_blk: defaults max sectors to 2560
[85558.539607] null_blk: disk nullb0 created
[85558.539610] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=-1
[85558.582289] null_blk: invalid max sectors
[85558.582294] null_blk: defaults max sectors to 2560
[85558.584133] null_blk: disk nullb0 created
[85558.584136] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=0
[85558.625540] blk_queue_max_hw_sectors: set to minimum 8
[85558.626702] null_blk: disk nullb0 created
[85558.626703] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=1
[85558.667530] blk_queue_max_hw_sectors: set to minimum 8
[85558.668807] null_blk: disk nullb0 created
[85558.668809] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=2
[85558.711834] blk_queue_max_hw_sectors: set to minimum 8
[85558.713118] null_blk: disk nullb0 created
[85558.713120] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=4
[85558.759802] blk_queue_max_hw_sectors: set to minimum 8
[85558.761166] null_blk: disk nullb0 created
[85558.761168] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=8
[85558.807917] null_blk: disk nullb0 created
[85558.807920] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=32
[85558.855595] null_blk: disk nullb0 created
[85558.855599] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=64
[85558.901662] null_blk: disk nullb0 created
[85558.901665] null_blk: module loaded
###################################################
gb:
------------------------------------
modprobe null_blk gb=-2
[85558.949139] blk_queue_max_hw_sectors: set to minimum 8
[85558.950050] null_blk: disk nullb0 created
[85558.950052] null_blk: module loaded
------------------------------------
modprobe null_blk gb=-1
[85558.996237] blk_queue_max_hw_sectors: set to minimum 8
[85558.997448] null_blk: disk nullb0 created
[85558.997451] null_blk: module loaded
------------------------------------
modprobe null_blk gb=0
[85559.037473] blk_queue_max_hw_sectors: set to minimum 8
[85559.038352] null_blk: disk nullb0 created
[85559.038354] null_blk: module loaded
------------------------------------
modprobe null_blk gb=1
[85559.092707] blk_queue_max_hw_sectors: set to minimum 8
[85559.093793] null_blk: disk nullb0 created
[85559.093795] null_blk: module loaded
------------------------------------
modprobe null_blk gb=2
[85559.133673] blk_queue_max_hw_sectors: set to minimum 8
[85559.134684] null_blk: disk nullb0 created
[85559.134686] null_blk: module loaded
------------------------------------
modprobe null_blk gb=4
[85559.188892] blk_queue_max_hw_sectors: set to minimum 8
[85559.189826] null_blk: disk nullb0 created
[85559.189828] null_blk: module loaded
------------------------------------
modprobe null_blk gb=8
[85559.232294] blk_queue_max_hw_sectors: set to minimum 8
[85559.233619] null_blk: disk nullb0 created
[85559.233624] null_blk: module loaded
------------------------------------
modprobe null_blk gb=32
[85559.276242] blk_queue_max_hw_sectors: set to minimum 8
[85559.277172] null_blk: disk nullb0 created
[85559.277174] null_blk: module loaded
------------------------------------
modprobe null_blk gb=64
[85559.312163] blk_queue_max_hw_sectors: set to minimum 8
[85559.313290] null_blk: disk nullb0 created
[85559.313292] null_blk: module loaded
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
[85559.433033] blk_queue_max_hw_sectors: set to minimum 8
[85559.433942] null_blk: disk nullb0 created
[85559.433944] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=1
[85559.473659] blk_queue_max_hw_sectors: set to minimum 8
[85559.474607] null_blk: disk nullb0 created
[85559.474609] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2
[85559.525021] blk_queue_max_hw_sectors: set to minimum 8
[85559.526057] null_blk: disk nullb0 created
[85559.526059] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[85559.569431] blk_queue_max_hw_sectors: set to minimum 8
[85559.570381] null_blk: disk nullb0 created
[85559.570383] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[85559.613191] blk_queue_max_hw_sectors: set to minimum 8
[85559.614314] null_blk: disk nullb0 created
[85559.614316] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[85559.666663] blk_queue_max_hw_sectors: set to minimum 8
[85559.669083] null_blk: disk nullb0 created
[85559.669086] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
[85559.709611] ------------[ cut here ]------------
[85559.709615] WARNING: CPU: 23 PID: 81095 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[85559.709621] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr intel_rapl_common xfs kvm_amd ppdev ccp kvm parport_pc parport irqbypass pcspkr joydev i2c_piix4 zram ip_tables bochs drm_vram_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm sha512_ssse3 virtio_net net_failover serio_raw virtio_blk drm failover ata_generic pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[85559.709653] CPU: 23 PID: 81095 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
[85559.709655] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[85559.709656] RIP: 0010:group_cpus_evenly+0x26e/0x280
[85559.709658] Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[85559.709660] RSP: 0018:ffffc900007f3cb8 EFLAGS: 00010287
[85559.709662] RAX: 0000000080000000 RBX: 0000000000000040 RCX: 0000000000000000
[85559.709663] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[85559.709664] RBP: ffff888902f41bd8 R08: ffff888902f41e68 R09: ffff888839df0000
[85559.709665] R10: ffff888902f41e68 R11: 0000000000000000 R12: ffff888839df0000
[85559.709666] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[85559.709668] FS:  00007fe1ad1c1b80(0000) GS:ffff888fff7c0000(0000) knlGS:0000000000000000
[85559.709669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[85559.709670] CR2: 00007fe1acd06800 CR3: 0000000148702000 CR4: 0000000000350ee0
[85559.709672] DR0: ffffffff843793e0 DR1: ffffffff843793e1 DR2: ffffffff843793e2
[85559.709673] DR3: ffffffff843793e3 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[85559.709674] Call Trace:
[85559.709676]  <TASK>
[85559.709678]  blk_mq_map_queues+0x16/0xc0
[85559.709681]  null_map_queues+0xa5/0xe0 [null_blk]
[85559.709688]  blk_mq_alloc_tag_set+0x14d/0x3f0
[85559.709690]  ? __kmalloc+0xbc/0x130
[85559.709694]  null_add_dev.part.0+0x601/0x700 [null_blk]
[85559.709700]  null_init+0x109/0xff0 [null_blk]
[85559.709706]  ? __pfx_init_module+0x10/0x10 [null_blk]
[85559.709727]  do_one_initcall+0x44/0x220
[85559.709731]  ? kmalloc_trace+0x25/0x90
[85559.709733]  do_init_module+0x4c/0x210
[85559.709736]  __do_sys_finit_module+0xb4/0x130
[85559.709740]  do_syscall_64+0x3b/0x90
[85559.709744]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[85559.709756] RIP: 0033:0x7fe1acd2c15d
[85559.709758] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[85559.709759] RSP: 002b:00007ffd0d940538 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[85559.709761] RAX: ffffffffffffffda RBX: 000055682288db90 RCX: 00007fe1acd2c15d
[85559.709762] RDX: 0000000000000000 RSI: 000055682288df00 RDI: 0000000000000003
[85559.709763] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[85559.709764] R10: 0000000000000003 R11: 0000000000000246 R12: 000055682288df00
[85559.709765] R13: 000055682288dcc0 R14: 000055682288db90 R15: 000055682288df20
[85559.709767]  </TASK>
[85559.709767] ---[ end trace 0000000000000000 ]---
[85559.710336] blk_queue_max_hw_sectors: set to minimum 8
[85559.712770] null_blk: disk nullb0 created
[85559.712772] null_blk: module loaded
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=-2
[85559.756834] blk_queue_max_hw_sectors: set to minimum 8
[85559.758904] null_blk: disk nullb0 created
[85559.758918] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=-1
[85559.805436] blk_queue_max_hw_sectors: set to minimum 8
[85559.807516] null_blk: disk nullb0 created
[85559.807518] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=0
[85559.848229] blk_queue_max_hw_sectors: set to minimum 8
[85559.849370] null_blk: disk nullb0 created
[85559.849373] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1
[85559.895488] blk_queue_max_hw_sectors: set to minimum 8
[85559.896844] null_blk: disk nullb0 created
[85559.896847] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2
[85559.941426] blk_queue_max_hw_sectors: set to minimum 8
[85559.942518] null_blk: disk nullb0 created
[85559.942520] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[85559.980639] blk_queue_max_hw_sectors: set to minimum 8
[85559.982007] null_blk: disk nullb0 created
[85559.982010] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[85560.030519] blk_queue_max_hw_sectors: set to minimum 8
[85560.031809] null_blk: disk nullb0 created
[85560.031811] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[85560.082676] blk_queue_max_hw_sectors: set to minimum 8
[85560.084549] null_blk: disk nullb0 created
[85560.084551] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[85560.129425] blk_queue_max_hw_sectors: set to minimum 8
[85560.131390] null_blk: disk nullb0 created
[85560.131392] null_blk: module loaded
###################################################
queue_mode:
------------------------------------
modprobe null_blk queue_mode=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85560.175901] null_blk: `-2' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85560.204604] null_blk: `-1' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=0
[85560.232339] blk_queue_max_hw_sectors: set to minimum 8
[85560.232561] null_blk: disk nullb0 created
[85560.232563] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85560.261620] null_blk: legacy IO path is no longer available
------------------------------------
modprobe null_blk queue_mode=2
[85560.290494] blk_queue_max_hw_sectors: set to minimum 8
[85560.291497] null_blk: disk nullb0 created
[85560.291500] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85560.347650] null_blk: `4' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85560.378796] null_blk: `8' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85560.414507] null_blk: `32' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85560.442651] null_blk: `64' invalid for parameter `queue_mode'
###################################################
bs:
------------------------------------
modprobe null_blk bs=-2
[85560.477657] null_blk: invalid block size
[85560.477661] null_blk: defaults block size to 4096
[85560.477825] blk_queue_max_hw_sectors: set to minimum 8
[85560.479080] null_blk: disk nullb0 created
[85560.479082] null_blk: module loaded
------------------------------------
modprobe null_blk bs=-1
[85560.517134] null_blk: invalid block size
[85560.517137] null_blk: defaults block size to 4096
[85560.517265] blk_queue_max_hw_sectors: set to minimum 8
[85560.518283] null_blk: disk nullb0 created
[85560.518284] null_blk: module loaded
------------------------------------
modprobe null_blk bs=0
[85560.567392] blk_queue_max_hw_sectors: set to minimum 8
[85560.568510] null_blk: disk nullb0 created
[85560.568512] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1
[85560.615012] blk_queue_max_hw_sectors: set to minimum 8
[85560.616525] null_blk: disk nullb0 created
[85560.616527] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2
[85560.660023] blk_queue_max_hw_sectors: set to minimum 8
[85560.661300] null_blk: disk nullb0 created
[85560.661301] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4
[85560.712280] blk_queue_max_hw_sectors: set to minimum 8
[85560.713218] null_blk: disk nullb0 created
[85560.713220] null_blk: module loaded
------------------------------------
modprobe null_blk bs=8
[85560.752370] blk_queue_max_hw_sectors: set to minimum 8
[85560.753285] null_blk: disk nullb0 created
[85560.753287] null_blk: module loaded
------------------------------------
modprobe null_blk bs=32
[85560.795409] blk_queue_max_hw_sectors: set to minimum 8
[85560.796666] null_blk: disk nullb0 created
[85560.796668] null_blk: module loaded
------------------------------------
modprobe null_blk bs=64
[85560.847397] blk_queue_max_hw_sectors: set to minimum 8
[85560.848883] null_blk: disk nullb0 created
[85560.848886] null_blk: module loaded
------------------------------------
modprobe null_blk bs=512
[85560.892234] blk_queue_max_hw_sectors: set to minimum 8
[85560.893361] null_blk: disk nullb0 created
[85560.893363] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1024
[85560.935179] blk_queue_max_hw_sectors: set to minimum 8
[85560.936401] null_blk: disk nullb0 created
[85560.936403] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2048
[85560.982917] blk_queue_max_hw_sectors: set to minimum 8
[85560.984266] null_blk: disk nullb0 created
[85560.984269] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4096
[85561.030383] blk_queue_max_hw_sectors: set to minimum 8
[85561.031641] null_blk: disk nullb0 created
[85561.031643] null_blk: module loaded
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
-rw-r--r--. 1 root root 1.2M Mar 30 14:16 /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=2
[85564.011102] blk_queue_max_hw_sectors: set to minimum 8
[85564.012076] null_blk: disk nullb0 created
[85564.012078] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[85564.306459] blk_queue_max_hw_sectors: set to minimum 8
[85564.307465] null_blk: disk nullb0 created
[85564.307468] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[85564.598907] blk_queue_max_hw_sectors: set to minimum 8
[85564.600010] null_blk: disk nullb0 created
[85564.600012] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16
[85564.894899] blk_queue_max_hw_sectors: set to minimum 8
[85564.896134] null_blk: disk nullb0 created
[85564.896136] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[85565.188927] blk_queue_max_hw_sectors: set to minimum 8
[85565.190563] null_blk: disk nullb0 created
[85565.190573] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85565.482563] null_blk: out of bound poll_queues [1 .. 48]
[85565.483127] null_blk: `64' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=128
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85565.769840] null_blk: out of bound poll_queues [1 .. 48]
[85565.770366] null_blk: `128' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=256
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85566.060762] null_blk: out of bound poll_queues [1 .. 48]
[85566.061352] null_blk: `256' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=512
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85566.344862] null_blk: out of bound poll_queues [1 .. 48]
[85566.345406] null_blk: `512' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1024
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85566.634577] null_blk: out of bound poll_queues [1 .. 48]
[85566.635363] null_blk: `1024' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2048
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85566.917949] null_blk: out of bound poll_queues [1 .. 48]
[85566.918572] null_blk: `2048' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4096
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85567.211693] null_blk: out of bound poll_queues [1 .. 48]
[85567.212159] null_blk: `4096' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=8192
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85567.502193] null_blk: out of bound poll_queues [1 .. 48]
[85567.502701] null_blk: `8192' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=16384
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85567.788828] null_blk: out of bound poll_queues [1 .. 48]
[85567.789320] null_blk: `16384' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=32768
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85568.072916] null_blk: out of bound poll_queues [1 .. 48]
[85568.073462] null_blk: `32768' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=65536
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85568.366130] null_blk: out of bound poll_queues [1 .. 48]
[85568.367316] null_blk: `65536' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=131072
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85568.654239] null_blk: out of bound poll_queues [1 .. 48]
[85568.654760] null_blk: `131072' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=262144
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85568.939704] null_blk: out of bound poll_queues [1 .. 48]
[85568.940296] null_blk: `262144' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=524288
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85569.223783] null_blk: out of bound poll_queues [1 .. 48]
[85569.224635] null_blk: `524288' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1048576
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85569.508002] null_blk: out of bound poll_queues [1 .. 48]
[85569.508502] null_blk: `1048576' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2097152
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85569.796954] null_blk: out of bound poll_queues [1 .. 48]
[85569.797454] null_blk: `2097152' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4194304
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85570.086926] null_blk: out of bound poll_queues [1 .. 48]
[85570.087368] null_blk: `4194304' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=8388608
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85570.370835] null_blk: out of bound poll_queues [1 .. 48]
[85570.371921] null_blk: `8388608' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=16777216
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85570.656931] null_blk: out of bound poll_queues [1 .. 48]
[85570.657451] null_blk: `16777216' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=33554432
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85570.951826] null_blk: out of bound poll_queues [1 .. 48]
[85570.952337] null_blk: `33554432' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=67108864
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85571.240357] null_blk: out of bound poll_queues [1 .. 48]
[85571.240925] null_blk: `67108864' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=134217728
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85571.528914] null_blk: out of bound poll_queues [1 .. 48]
[85571.529498] null_blk: `134217728' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=268435456
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85571.820082] null_blk: out of bound poll_queues [1 .. 48]
[85571.820609] null_blk: `268435456' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=536870912
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85572.107721] null_blk: out of bound poll_queues [1 .. 48]
[85572.108218] null_blk: `536870912' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1073741824
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85572.394780] null_blk: out of bound poll_queues [1 .. 48]
[85572.395288] null_blk: `1073741824' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85572.682059] null_blk: out of bound poll_queues [1 .. 48]
[85572.682723] null_blk: `2147483648' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85572.969250] null_blk: out of bound poll_queues [1 .. 48]
[85572.969861] null_blk: `4294967296' invalid for parameter `poll_queues'
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=2
[85573.263265] blk_queue_max_hw_sectors: set to minimum 8
[85573.264282] null_blk: disk nullb0 created
[85573.264284] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[85573.567537] blk_queue_max_hw_sectors: set to minimum 8
[85573.569013] null_blk: disk nullb0 created
[85573.569015] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[85573.861851] blk_queue_max_hw_sectors: set to minimum 8
[85573.862890] null_blk: disk nullb0 created
[85573.862892] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16
[85574.156393] blk_queue_max_hw_sectors: set to minimum 8
[85574.157641] null_blk: disk nullb0 created
[85574.157643] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[85574.455053] blk_queue_max_hw_sectors: set to minimum 8
[85574.456612] null_blk: disk nullb0 created
[85574.456614] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[85574.757074] blk_queue_max_hw_sectors: set to minimum 8
[85574.758949] null_blk: disk nullb0 created
[85574.758951] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=128
[85575.055850] blk_queue_max_hw_sectors: set to minimum 8
[85575.057854] null_blk: disk nullb0 created
[85575.057856] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=256
[85575.349116] blk_queue_max_hw_sectors: set to minimum 8
[85575.351232] null_blk: disk nullb0 created
[85575.351234] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=512
[85575.647463] blk_queue_max_hw_sectors: set to minimum 8
[85575.649849] null_blk: disk nullb0 created
[85575.649851] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1024
[85575.948175] blk_queue_max_hw_sectors: set to minimum 8
[85575.950206] null_blk: disk nullb0 created
[85575.950215] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2048
[85576.240546] blk_queue_max_hw_sectors: set to minimum 8
[85576.242649] null_blk: disk nullb0 created
[85576.242650] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4096
[85576.542909] blk_queue_max_hw_sectors: set to minimum 8
[85576.545345] null_blk: disk nullb0 created
[85576.545347] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8192
[85576.840511] blk_queue_max_hw_sectors: set to minimum 8
[85576.842534] null_blk: disk nullb0 created
[85576.842536] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16384
[85577.138588] blk_queue_max_hw_sectors: set to minimum 8
[85577.141155] null_blk: disk nullb0 created
[85577.141157] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32768
[85577.437709] blk_queue_max_hw_sectors: set to minimum 8
[85577.440398] null_blk: disk nullb0 created
[85577.440400] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=65536
[85577.730395] blk_queue_max_hw_sectors: set to minimum 8
[85577.732529] null_blk: disk nullb0 created
[85577.732531] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=131072
[85578.026397] blk_queue_max_hw_sectors: set to minimum 8
[85578.028453] null_blk: disk nullb0 created
[85578.028455] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=262144
[85578.330794] blk_queue_max_hw_sectors: set to minimum 8
[85578.332805] null_blk: disk nullb0 created
[85578.332807] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=524288
[85578.627053] blk_queue_max_hw_sectors: set to minimum 8
[85578.629106] null_blk: disk nullb0 created
[85578.629108] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1048576
[85578.922543] blk_queue_max_hw_sectors: set to minimum 8
[85578.924623] null_blk: disk nullb0 created
[85578.924625] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2097152
[85579.219753] blk_queue_max_hw_sectors: set to minimum 8
[85579.221773] null_blk: disk nullb0 created
[85579.221775] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4194304
[85579.523543] blk_queue_max_hw_sectors: set to minimum 8
[85579.525960] null_blk: disk nullb0 created
[85579.525966] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8388608
[85579.819689] blk_queue_max_hw_sectors: set to minimum 8
[85579.821859] null_blk: disk nullb0 created
[85579.821861] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16777216
[85580.123133] blk_queue_max_hw_sectors: set to minimum 8
[85580.125268] null_blk: disk nullb0 created
[85580.125270] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=33554432
[85580.422998] blk_queue_max_hw_sectors: set to minimum 8
[85580.425035] null_blk: disk nullb0 created
[85580.425037] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=67108864
[85580.719427] blk_queue_max_hw_sectors: set to minimum 8
[85580.721507] null_blk: disk nullb0 created
[85580.721509] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=134217728
[85581.021063] blk_queue_max_hw_sectors: set to minimum 8
[85581.023203] null_blk: disk nullb0 created
[85581.023205] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=268435456
[85581.322971] blk_queue_max_hw_sectors: set to minimum 8
[85581.324895] null_blk: disk nullb0 created
[85581.324897] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=536870912
[85581.622382] blk_queue_max_hw_sectors: set to minimum 8
[85581.624442] null_blk: disk nullb0 created
[85581.624444] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1073741824
[85581.920251] blk_queue_max_hw_sectors: set to minimum 8
[85581.922288] null_blk: disk nullb0 created
[85581.922290] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85582.216539] null_blk: `2147483648' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85582.509467] null_blk: `4294967296' invalid for parameter `submit_queues'
###################################################
hw_queue_depth:
------------------------------------
modprobe null_blk hw_queue_depth=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85582.797355] null_blk: only positive values are allowed for queue_depth
[85582.797903] null_blk: `-2' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85582.832203] null_blk: only positive values are allowed for queue_depth
[85582.832829] null_blk: `-1' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85582.862840] null_blk: only positive values are allowed for queue_depth
[85582.863668] null_blk: `0' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=1
[85582.897489] blk_queue_max_hw_sectors: set to minimum 8
[85582.898480] null_blk: disk nullb0 created
[85582.898482] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=2
[85582.947036] blk_queue_max_hw_sectors: set to minimum 8
[85582.948441] null_blk: disk nullb0 created
[85582.948445] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=4
[85582.992295] blk_queue_max_hw_sectors: set to minimum 8
[85582.993249] null_blk: disk nullb0 created
[85582.993251] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=8
[85583.039676] blk_queue_max_hw_sectors: set to minimum 8
[85583.040713] null_blk: disk nullb0 created
[85583.040715] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=32
[85583.089206] blk_queue_max_hw_sectors: set to minimum 8
[85583.090224] null_blk: disk nullb0 created
[85583.090226] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=64
[85583.133894] blk_queue_max_hw_sectors: set to minimum 8
[85583.134909] null_blk: disk nullb0 created
[85583.134911] null_blk: module loaded
###################################################
max_sectors:
------------------------------------
modprobe null_blk max_sectors=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.194222] null_blk: only positive values are allowed for max_sectors
[85583.194800] null_blk: `-2' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.225225] null_blk: only positive values are allowed for max_sectors
[85583.225867] null_blk: `-1' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.256480] null_blk: only positive values are allowed for max_sectors
[85583.256997] null_blk: `0' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=1
[85583.286669] blk_queue_max_hw_sectors: set to minimum 8
[85583.287723] null_blk: disk nullb0 created
[85583.287726] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=2
[85583.322502] blk_queue_max_hw_sectors: set to minimum 8
[85583.323437] null_blk: disk nullb0 created
[85583.323439] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=4
[85583.374818] blk_queue_max_hw_sectors: set to minimum 8
[85583.376114] null_blk: disk nullb0 created
[85583.376117] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=8
[85583.424539] null_blk: disk nullb0 created
[85583.424543] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=32
[85583.475677] null_blk: disk nullb0 created
[85583.475681] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=64
[85583.525939] null_blk: disk nullb0 created
[85583.525942] null_blk: module loaded
###################################################
gb:
------------------------------------
modprobe null_blk gb=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.572592] null_blk: only positive values are allowed for gb
[85583.573197] null_blk: `-2' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.602694] null_blk: only positive values are allowed for gb
[85583.603397] null_blk: `-1' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=0
[85583.630890] blk_queue_max_hw_sectors: set to minimum 8
[85583.631778] null_blk: disk nullb0 created
[85583.631783] null_blk: module loaded
------------------------------------
modprobe null_blk gb=1
[85583.671929] blk_queue_max_hw_sectors: set to minimum 8
[85583.673180] null_blk: disk nullb0 created
[85583.673182] null_blk: module loaded
------------------------------------
modprobe null_blk gb=2
[85583.713429] blk_queue_max_hw_sectors: set to minimum 8
[85583.714814] null_blk: disk nullb0 created
[85583.714816] null_blk: module loaded
------------------------------------
modprobe null_blk gb=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.760532] null_blk: only positive values are allowed for gb
[85583.761085] null_blk: `4' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.788925] null_blk: only positive values are allowed for gb
[85583.789710] null_blk: `8' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.819740] null_blk: only positive values are allowed for gb
[85583.820305] null_blk: `32' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.849148] null_blk: only positive values are allowed for gb
[85583.849978] null_blk: `64' invalid for parameter `gb'
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.879887] null_blk: out of bound poll_queues [1 .. 48]
[85583.880412] null_blk: `-2' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.911753] null_blk: out of bound poll_queues [1 .. 48]
[85583.912300] null_blk: `-1' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85583.943238] null_blk: out of bound poll_queues [1 .. 48]
[85583.943658] null_blk: `0' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1
[85583.977280] blk_queue_max_hw_sectors: set to minimum 8
[85583.978276] null_blk: disk nullb0 created
[85583.978278] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2
[85584.018711] blk_queue_max_hw_sectors: set to minimum 8
[85584.019934] null_blk: disk nullb0 created
[85584.019936] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[85584.060892] blk_queue_max_hw_sectors: set to minimum 8
[85584.062287] null_blk: disk nullb0 created
[85584.062289] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[85584.106371] blk_queue_max_hw_sectors: set to minimum 8
[85584.107962] null_blk: disk nullb0 created
[85584.107966] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[85584.156551] blk_queue_max_hw_sectors: set to minimum 8
[85584.158890] null_blk: disk nullb0 created
[85584.158893] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.201661] null_blk: out of bound poll_queues [1 .. 48]
[85584.202568] null_blk: `64' invalid for parameter `poll_queues'
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.237234] null_blk: `-2' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.266743] null_blk: `-1' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.296964] null_blk: `0' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=1
[85584.327253] blk_queue_max_hw_sectors: set to minimum 8
[85584.328201] null_blk: disk nullb0 created
[85584.328203] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2
[85584.374233] blk_queue_max_hw_sectors: set to minimum 8
[85584.375512] null_blk: disk nullb0 created
[85584.375514] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[85584.423147] blk_queue_max_hw_sectors: set to minimum 8
[85584.424509] null_blk: disk nullb0 created
[85584.424511] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[85584.472375] blk_queue_max_hw_sectors: set to minimum 8
[85584.473479] null_blk: disk nullb0 created
[85584.473481] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[85584.520618] blk_queue_max_hw_sectors: set to minimum 8
[85584.522242] null_blk: disk nullb0 created
[85584.522244] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[85584.566411] blk_queue_max_hw_sectors: set to minimum 8
[85584.568690] null_blk: disk nullb0 created
[85584.568692] null_blk: module loaded
###################################################
queue_mode:
------------------------------------
modprobe null_blk queue_mode=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.611787] null_blk: queue_mode valid values BIO: 0, MQ: 2
[85584.612617] null_blk: `-2' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.640706] null_blk: queue_mode valid values BIO: 0, MQ: 2
[85584.641190] null_blk: `-1' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=0
[85584.671271] blk_queue_max_hw_sectors: set to minimum 8
[85584.671483] null_blk: disk nullb0 created
[85584.671484] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.703325] null_blk: legacy IO path is no longer available
------------------------------------
modprobe null_blk queue_mode=2
[85584.733841] blk_queue_max_hw_sectors: set to minimum 8
[85584.735090] null_blk: disk nullb0 created
[85584.735092] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.773448] null_blk: queue_mode valid values BIO: 0, MQ: 2
[85584.773893] null_blk: `4' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.803290] null_blk: queue_mode valid values BIO: 0, MQ: 2
[85584.803788] null_blk: `8' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.834944] null_blk: queue_mode valid values BIO: 0, MQ: 2
[85584.835448] null_blk: `32' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.866355] null_blk: queue_mode valid values BIO: 0, MQ: 2
[85584.867469] null_blk: `64' invalid for parameter `queue_mode'
###################################################
bs:
------------------------------------
modprobe null_blk bs=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.901123] null_blk: valid range for bs value [512 ... 2147483647]
[85584.902118] null_blk: `-2' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.930962] null_blk: valid range for bs value [512 ... 2147483647]
[85584.931830] null_blk: `-1' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.961771] null_blk: valid range for bs value [512 ... 2147483647]
[85584.963126] null_blk: `0' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85584.995728] null_blk: valid range for bs value [512 ... 2147483647]
[85584.996290] null_blk: `1' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85585.025959] null_blk: valid range for bs value [512 ... 2147483647]
[85585.026930] null_blk: `2' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85585.057637] null_blk: valid range for bs value [512 ... 2147483647]
[85585.058519] null_blk: `4' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85585.102631] null_blk: valid range for bs value [512 ... 2147483647]
[85585.103203] null_blk: `8' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85585.131288] null_blk: valid range for bs value [512 ... 2147483647]
[85585.131978] null_blk: `32' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[85585.162435] null_blk: valid range for bs value [512 ... 2147483647]
[85585.163339] null_blk: `64' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=512
[85585.195460] blk_queue_max_hw_sectors: set to minimum 8
[85585.196431] null_blk: disk nullb0 created
[85585.196432] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1024
[85585.244570] blk_queue_max_hw_sectors: set to minimum 8
[85585.245550] null_blk: disk nullb0 created
[85585.245552] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2048
[85585.291191] blk_queue_max_hw_sectors: set to minimum 8
[85585.292382] null_blk: disk nullb0 created
[85585.292385] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4096
[85585.333643] blk_queue_max_hw_sectors: set to minimum 8
[85585.334973] null_blk: disk nullb0 created
[85585.334975] null_blk: module loaded

-- 
2.29.0

