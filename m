Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871B8C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 22:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDJWOW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDJWOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 18:14:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38134131
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 15:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/+mnfT4lUfN7sqkplUcqFCirTkz0FKqODbOsAYEm90OeMvgZ6+a0HPYD2ja0fffiyz9BGibkcjko8Q5TDvapXdSm32cvRl432J8rtdItfTyO5YozWpiSKdaAVWQsYqzHMNBCbQYTe0AhZCoEZT9s2sVPOZhAxzqThw3za1Ppx0pRfUJpDpGgsKnCf01RQEKN8MEzSVQycH3Y6/I1fITCj1OY+c1xFbb/PQDxVup20DjA/sYme6vef6tzcgRNr0lOyWDbzFjZaerFOQWtV40CGnIXpCy8XWdCjKpveI+AciBnNwChgptB+l0v2MT0VdfNmGR+K22tXE4+qwf3J/SXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB6Xq6lmaJnoUw4R2FYymGlDDuwSDEgXQ7ZwbAX2AsA=;
 b=H3l7EF7YjvrPSmRICmWGvyohEHEu1sQbhB43+kRPq7mFOWuApxD1QVGmnuKtWytBWhyURTUO+aYxiOjOBLYTEkRBkFGxJfQUXx+J9Jfg7adOX46zOfNF6clSyjBl9G3CapYhIteqEieeH68B6S4W5kmexImcArD+CSMhOz216rhI5pdNF3tQ1nCBEcjJMchH6N/Eg6fNY0NE/J/b2UOwbonGGDxrTybhMvdvTL5BPYMqDaUrSW60jcAEmtxAvG6fVOKmEaA/iEZoDXSmDp0RjujjY71P2sBiRnd1ey1waEWUfJeJCbWoL1pK4ioXlUx/RVRxtW1sQflPtk8fHAplzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB6Xq6lmaJnoUw4R2FYymGlDDuwSDEgXQ7ZwbAX2AsA=;
 b=dP0p0DDoKx4yY/c9TaHvuBSb2PpjX4uFnw88nTYkIqgfG2mN6u5nBiv2UaXEdibA3/mU/KUO5aryisyOFsGL6587TeFSVvPSde33Fr+1PvaCEX20IsSSLF9iWVGxGQqf+DC/G8qbD/Y/xD1aKJ7TjOBrcXjQzLvcvSBmCgj9y1rOLghkLMfLYsJnqh4vd39cBV/+G/KXtlUWh0bQ+mHWv1HJUw74tgKRyW8Ssj9x5+XKQaIUI33SfCfsmk+NVxzDWkbMoFwrUdwkJfvbDkQhRsm8BownSWIE0B+Lt4tIifK1Usch7yoqOHPAnO+IFAEJlK2lext9AkJ2Bu7AMJh0+A==
Received: from BN9P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::30)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 22:14:12 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::9) by BN9P223CA0025.outlook.office365.com
 (2603:10b6:408:10b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Mon, 10 Apr 2023 22:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 22:14:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Apr 2023
 15:14:00 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Apr
 2023 15:13:59 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V3 0/1] null_blk: add modparam checks
Date:   Mon, 10 Apr 2023 15:13:52 -0700
Message-ID: <20230410221353.76261-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab526a0-d6c9-4af4-8cdf-08db3a10ea45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4w9pooipgWgqVTERKMUBkKpzvYRqMnu2VD3Uo6DSTvs5zBmtTXWTq9S68YaHYq9dyLcYxW3MsAtgktRV1L/4XgNWFVDJ4JPjX81jYvF1zapdhfQjxHHsvmkE5HfLZNbUycGwK12BV1oGliwWI/CKbWNF8dgGfAgwReiXplZ+2hD/XJWwO1VdMqzrxrOQydwZqLAj+qUcReHS5Z60Es0n5tXyeOyUrQL/cXZjNQlbqHzybhO/+NC16I7WIHjABdUwEITM9yl7A1uUJmBd23D66GHLQE3MRDulBLTpLJQd6/P5myJfIkHL+yMVQhWF/M1uSvea65ugsAGbJflhwGdHNb5YQkOwvf1hAVGICpdfv46lsD75gkM46PAayLPESEppVne3gcphVYyJD8s3lY8k51rSC7JVSPOb5fbwpndjI7gO5o4BCw+ylrX79ObB6lVMneLpUQZV+CVxqYsYmlh/+hm6VoCRb+xtCysihsKF6IZEE5zyrm2EQvINqDbz7M935ZwUlSLI+rJJpFKhvaQNv9v7GsvH8d4u9fQFcfp4orJ4O+DukCDc9qOBLwVPMQ1pPsgL+1CgsaTvgOEp5eje1a+3+hur9HIDMOMTjmYYZTndVgLsZMCvdYlNBKGH4xxZ1R3vDsmXTGZewhsKCl1Ry+5VX5/m1p/G0ZL792tIEHR9YXFPNAOK1kKr7q88jxs1Eq/bjMiz1vFAOBeh+bD1dn1AZw1649DCMqGv4CBnkoLOp3F6bl/sZyP5QH4zW+so
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(8936002)(6666004)(7696005)(40480700001)(30864003)(40460700003)(5660300002)(70206006)(8676002)(70586007)(4326008)(6916009)(478600001)(83380400001)(316002)(82310400005)(36860700001)(82740400003)(356005)(7636003)(54906003)(2906002)(1076003)(2616005)(186003)(45080400002)(426003)(47076005)(336012)(41300700001)(36756003)(16526019)(26005)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 22:14:12.5340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab526a0-d6c9-4af4-8cdf-08db3a10ea45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
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

v3:-
*Allow power of 2 check for the bs mod param.

*Modify NULL_PARAM() in a way it can now take is_power_of_2 arg
 that is passed to null_param_store_int() and if it is set.
 null_param_store_int() now check if new value is of power_of_2.
*Change valid range of the submit_queues from INT_MAX to
 CONFIG_NR_CPUS * 2.
*Change valid range of hw_queue_depth max to 65536.

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

 drivers/block/null_blk/main.c | 89 ++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 44 deletions(-)

linux-block (nullb-mod-parm-v3) # 
linux-block (nullb-mod-parm-v3) # sh test-mod-param.sh 
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
-rw-r--r--. 1 root root 1.1M Apr 10 14:01 /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=2
[84288.546050] null_blk: disk nullb0 created
[84288.546073] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[84288.841123] null_blk: disk nullb0 created
[84288.841157] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[84289.143633] null_blk: disk nullb0 created
[84289.143664] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16
[84289.442807] null_blk: disk nullb0 created
[84289.442834] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[84289.736331] null_blk: disk nullb0 created
[84289.736368] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
[84290.031237] ------------[ cut here ]------------
[84290.031241] WARNING: CPU: 17 PID: 68372 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[84290.031251] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[84290.031320] CPU: 17 PID: 68372 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[84290.031323] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[84290.031325] RIP: 0010:group_cpus_evenly+0x26e/0x280
[84290.031330] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[84290.031332] RSP: 0018:ffffc90000a97cb8 EFLAGS: 00010287
[84290.031335] RAX: 0000000080000000 RBX: 0000000000000040 RCX: 0000000000000000
[84290.031337] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[84290.031339] RBP: ffff88810439f1f8 R08: ffff88810439f848 R09: ffff8887e7ab0000
[84290.031340] R10: ffff88810439f848 R11: 0000000000000000 R12: ffff8887e7ab0000
[84290.031342] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[84290.031345] FS:  00007f4c89d67b80(0000) GS:ffff8897df640000(0000) knlGS:0000000000000000
[84290.031376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[84290.031377] CR2: 00007f4c89906800 CR3: 000000176f776000 CR4: 0000000000350ee0
[84290.031381] DR0: ffffffff84366424 DR1: ffffffff84366425 DR2: ffffffff84366426
[84290.031383] DR3: ffffffff84366427 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[84290.031384] Call Trace:
[84290.031387]  <TASK>
[84290.031390]  blk_mq_map_queues+0x16/0xc0
[84290.031396]  null_map_queues+0xa5/0xe0 [null_blk]
[84290.031407]  blk_mq_alloc_tag_set+0x14d/0x3f0
[84290.031412]  ? __kmalloc+0xbc/0x130
[84290.031418]  null_add_dev.part.0+0x601/0x700 [null_blk]
[84290.031428]  null_init+0x109/0xff0 [null_blk]
[84290.031438]  ? __pfx_init_module+0x10/0x10 [null_blk]
[84290.031447]  do_one_initcall+0x44/0x220
[84290.031453]  ? kmalloc_trace+0x25/0x90
[84290.031456]  do_init_module+0x4c/0x210
[84290.031462]  __do_sys_finit_module+0xb4/0x130
[84290.031469]  do_syscall_64+0x3b/0x90
[84290.031474]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[84290.031478] RIP: 0033:0x7f4c8992c15d
[84290.031481] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[84290.031483] RSP: 002b:00007ffc91bdbcb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[84290.031486] RAX: ffffffffffffffda RBX: 00005645a07c0b90 RCX: 00007f4c8992c15d
[84290.031488] RDX: 0000000000000000 RSI: 00005645a07c0f00 RDI: 0000000000000003
[84290.031489] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[84290.031490] R10: 0000000000000003 R11: 0000000000000246 R12: 00005645a07c0f00
[84290.031492] R13: 00005645a07c0cc0 R14: 00005645a07c0b90 R15: 00005645a07c0f20
[84290.031501]  </TASK>
[84290.031501] ---[ end trace 0000000000000000 ]---
[84290.034730] null_blk: disk nullb0 created
[84290.034732] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=128
[84290.326972] ------------[ cut here ]------------
[84290.327006] WARNING: CPU: 14 PID: 68379 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[84290.327022] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[84290.327074] CPU: 14 PID: 68379 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[84290.327078] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[84290.327080] RIP: 0010:group_cpus_evenly+0x26e/0x280
[84290.327085] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[84290.327087] RSP: 0018:ffffc90000a97cb8 EFLAGS: 00010283
[84290.327090] RAX: 0000000080000000 RBX: 0000000000000080 RCX: 0000000000000000
[84290.327092] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[84290.327094] RBP: ffff888235d4f650 R08: ffff888235d4f5e8 R09: ffff888687860000
[84290.327095] R10: ffff888235d4f5e8 R11: 0000000000000000 R12: ffff888687860000
[84290.327097] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[84290.327100] FS:  00007f3e3e833b80(0000) GS:ffff8897df580000(0000) knlGS:0000000000000000
[84290.327103] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[84290.327105] CR2: 00007f3e3e306800 CR3: 000000011bd6a000 CR4: 0000000000350ee0
[84290.327121] DR0: ffffffff84366418 DR1: ffffffff84366419 DR2: ffffffff8436641a
[84290.327122] DR3: ffffffff8436641b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[84290.327124] Call Trace:
[84290.327127]  <TASK>
[84290.327130]  blk_mq_map_queues+0x16/0xc0
[84290.327136]  null_map_queues+0xa5/0xe0 [null_blk]
[84290.327148]  blk_mq_alloc_tag_set+0x14d/0x3f0
[84290.327153]  ? __kmalloc+0xbc/0x130
[84290.327159]  null_add_dev.part.0+0x601/0x700 [null_blk]
[84290.327170]  null_init+0x109/0xff0 [null_blk]
[84290.327179]  ? __pfx_init_module+0x10/0x10 [null_blk]
[84290.327189]  do_one_initcall+0x44/0x220
[84290.327195]  ? kmalloc_trace+0x25/0x90
[84290.327199]  do_init_module+0x4c/0x210
[84290.327213]  __do_sys_finit_module+0xb4/0x130
[84290.327218]  do_syscall_64+0x3b/0x90
[84290.327222]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[84290.327224] RIP: 0033:0x7f3e3e32c15d
[84290.327226] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[84290.327227] RSP: 002b:00007ffe4e3e3d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[84290.327229] RAX: ffffffffffffffda RBX: 0000561421dc6b90 RCX: 00007f3e3e32c15d
[84290.327229] RDX: 0000000000000000 RSI: 0000561421dc6f00 RDI: 0000000000000003
[84290.327230] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[84290.327231] R10: 0000000000000003 R11: 0000000000000246 R12: 0000561421dc6f00
[84290.327232] R13: 0000561421dc6cc0 R14: 0000561421dc6b90 R15: 0000561421dc6f20
[84290.327233]  </TASK>
[84290.327234] ---[ end trace 0000000000000000 ]---
[84290.332326] null_blk: disk nullb0 created
[84290.332330] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=256
[84290.625626] ------------[ cut here ]------------
[84290.625628] WARNING: CPU: 14 PID: 68386 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[84290.625635] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[84290.625667] CPU: 14 PID: 68386 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[84290.625669] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[84290.625670] RIP: 0010:group_cpus_evenly+0x26e/0x280
[84290.625672] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[84290.625674] RSP: 0018:ffffc90000ddbcb8 EFLAGS: 00010287
[84290.625676] RAX: 0000000080000000 RBX: 0000000000000100 RCX: 0000000000000000
[84290.625677] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[84290.625678] RBP: ffff8881057ab170 R08: ffff8881057abaf0 R09: ffff888746500000
[84290.625679] R10: ffff8881057abaf0 R11: 0000000000000000 R12: ffff888746500000
[84290.625680] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[84290.625682] FS:  00007f2782816b80(0000) GS:ffff8897df580000(0000) knlGS:0000000000000000
[84290.625684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[84290.625685] CR2: 00007f2782306800 CR3: 0000000fb1f78000 CR4: 0000000000350ee0
[84290.625687] DR0: ffffffff84366418 DR1: ffffffff84366419 DR2: ffffffff8436641a
[84290.625707] DR3: ffffffff8436641b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[84290.625708] Call Trace:
[84290.625709]  <TASK>
[84290.625711]  blk_mq_map_queues+0x16/0xc0
[84290.625715]  null_map_queues+0xa5/0xe0 [null_blk]
[84290.625723]  blk_mq_alloc_tag_set+0x14d/0x3f0
[84290.625726]  ? __kmalloc+0xbc/0x130
[84290.625730]  null_add_dev.part.0+0x601/0x700 [null_blk]
[84290.625735]  null_init+0x109/0xff0 [null_blk]
[84290.625740]  ? __pfx_init_module+0x10/0x10 [null_blk]
[84290.625745]  do_one_initcall+0x44/0x220
[84290.625748]  ? kmalloc_trace+0x25/0x90
[84290.625750]  do_init_module+0x4c/0x210
[84290.625754]  __do_sys_finit_module+0xb4/0x130
[84290.625757]  do_syscall_64+0x3b/0x90
[84290.625761]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[84290.625763] RIP: 0033:0x7f278232c15d
[84290.625765] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[84290.625766] RSP: 002b:00007fff862fe9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[84290.625767] RAX: ffffffffffffffda RBX: 000055860924eb90 RCX: 00007f278232c15d
[84290.625768] RDX: 0000000000000000 RSI: 000055860924ef00 RDI: 0000000000000003
[84290.625769] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[84290.625770] R10: 0000000000000003 R11: 0000000000000246 R12: 000055860924ef00
[84290.625770] R13: 000055860924ecc0 R14: 000055860924eb90 R15: 000055860924ef20
[84290.625772]  </TASK>
[84290.625773] ---[ end trace 0000000000000000 ]---
[84290.634739] null_blk: disk nullb0 created
[84290.634742] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=512
[84290.931565] ------------[ cut here ]------------
[84290.931568] WARNING: CPU: 14 PID: 68393 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[84290.931576] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[84290.931607] CPU: 14 PID: 68393 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[84290.931610] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[84290.931611] RIP: 0010:group_cpus_evenly+0x26e/0x280
[84290.931613] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[84290.931614] RSP: 0018:ffffc90000e13cb8 EFLAGS: 00010287
[84290.931615] RAX: 0000000080000000 RBX: 0000000000000200 RCX: 0000000000000000
[84290.931617] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[84290.931617] RBP: ffff8886fce81608 R08: ffff8886fce81648 R09: ffff889681080000
[84290.931618] R10: ffff8886fce81648 R11: 0000000000000000 R12: ffff889681080000
[84290.931619] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[84290.931621] FS:  00007f4ee50f1b80(0000) GS:ffff8897df580000(0000) knlGS:0000000000000000
[84290.931622] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[84290.931623] CR2: 00007ffe42b71ff8 CR3: 0000000c0a296000 CR4: 0000000000350ee0
[84290.931625] DR0: ffffffff84366418 DR1: ffffffff84366419 DR2: ffffffff8436641a
[84290.931626] DR3: ffffffff8436641b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[84290.931627] Call Trace:
[84290.931647]  <TASK>
[84290.931648]  blk_mq_map_queues+0x16/0xc0
[84290.931652]  null_map_queues+0xa5/0xe0 [null_blk]
[84290.931658]  blk_mq_alloc_tag_set+0x14d/0x3f0
[84290.931661]  ? __kmalloc+0xbc/0x130
[84290.931665]  null_add_dev.part.0+0x601/0x700 [null_blk]
[84290.931670]  null_init+0x109/0xff0 [null_blk]
[84290.931675]  ? __pfx_init_module+0x10/0x10 [null_blk]
[84290.931679]  do_one_initcall+0x44/0x220
[84290.931683]  ? kmalloc_trace+0x25/0x90
[84290.931685]  do_init_module+0x4c/0x210
[84290.931689]  __do_sys_finit_module+0xb4/0x130
[84290.931692]  do_syscall_64+0x3b/0x90
[84290.931696]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[84290.931699] RIP: 0033:0x7f4ee4d1115d
[84290.931700] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[84290.931701] RSP: 002b:00007ffe42b74ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[84290.931703] RAX: ffffffffffffffda RBX: 0000557075450b90 RCX: 00007f4ee4d1115d
[84290.931703] RDX: 0000000000000000 RSI: 0000557075450f00 RDI: 0000000000000003
[84290.931704] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[84290.931705] R10: 0000000000000003 R11: 0000000000000246 R12: 0000557075450f00
[84290.931706] R13: 0000557075450cc0 R14: 0000557075450b90 R15: 0000557075450f20
[84290.931708]  </TASK>
[84290.931708] ---[ end trace 0000000000000000 ]---
[84290.949137] null_blk: disk nullb0 created
[84290.949142] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=1024
[84291.249158] ------------[ cut here ]------------
[84291.249161] WARNING: CPU: 14 PID: 68400 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[84291.249168] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[84291.249196] CPU: 14 PID: 68400 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[84291.249198] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[84291.249200] RIP: 0010:group_cpus_evenly+0x26e/0x280
[84291.249202] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[84291.249209] RSP: 0018:ffffc90000e13cb8 EFLAGS: 00010287
[84291.249211] RAX: 0000000080000000 RBX: 0000000000000400 RCX: 0000000000000000
[84291.249212] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[84291.249214] RBP: ffff8887287f3998 R08: ffff8887287f3660 R09: ffff888302900000
[84291.249215] R10: ffff8887287f3660 R11: 0000000000000000 R12: ffff888302900000
[84291.249216] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[84291.249218] FS:  00007f013f3c9b80(0000) GS:ffff8897df580000(0000) knlGS:0000000000000000
[84291.249219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[84291.249220] CR2: 00007f013ef06800 CR3: 000000021abe2000 CR4: 0000000000350ee0
[84291.249222] DR0: ffffffff84366418 DR1: ffffffff84366419 DR2: ffffffff8436641a
[84291.249223] DR3: ffffffff8436641b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[84291.249224] Call Trace:
[84291.249226]  <TASK>
[84291.249227]  blk_mq_map_queues+0x16/0xc0
[84291.249262]  null_map_queues+0xa5/0xe0 [null_blk]
[84291.249268]  blk_mq_alloc_tag_set+0x14d/0x3f0
[84291.249272]  ? __kmalloc+0xbc/0x130
[84291.249276]  null_add_dev.part.0+0x601/0x700 [null_blk]
[84291.249281]  null_init+0x109/0xff0 [null_blk]
[84291.249286]  ? __pfx_init_module+0x10/0x10 [null_blk]
[84291.249291]  do_one_initcall+0x44/0x220
[84291.249295]  ? kmalloc_trace+0x25/0x90
[84291.249296]  do_init_module+0x4c/0x210
[84291.249300]  __do_sys_finit_module+0xb4/0x130
[84291.249303]  do_syscall_64+0x3b/0x90
[84291.249307]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[84291.249310] RIP: 0033:0x7f013ef2c15d
[84291.249311] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[84291.249312] RSP: 002b:00007ffdbda67428 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[84291.249314] RAX: ffffffffffffffda RBX: 0000559f772edb90 RCX: 00007f013ef2c15d
[84291.249314] RDX: 0000000000000000 RSI: 0000559f772edf00 RDI: 0000000000000003
[84291.249315] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[84291.249316] R10: 0000000000000003 R11: 0000000000000246 R12: 0000559f772edf00
[84291.249317] R13: 0000559f772edcc0 R14: 0000559f772edb90 R15: 0000559f772edf20
[84291.249318]  </TASK>
[84291.249319] ---[ end trace 0000000000000000 ]---
[84291.286868] null_blk: disk nullb0 created
[84291.286873] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2048
[84291.600650] ------------[ cut here ]------------
[84291.600653] WARNING: CPU: 14 PID: 68407 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[84291.600660] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[84291.600687] CPU: 14 PID: 68407 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[84291.600689] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[84291.600690] RIP: 0010:group_cpus_evenly+0x26e/0x280
[84291.600692] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[84291.600693] RSP: 0018:ffffc90000e13cb8 EFLAGS: 00010287
[84291.600695] RAX: 0000000080000000 RBX: 0000000000000800 RCX: 0000000000000000
[84291.600696] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[84291.600701] RBP: ffff8882d5d07958 R08: ffff8882d5d07bc0 R09: ffff88836e400000
[84291.600702] R10: ffff8882d5d07bc0 R11: 0000000000000000 R12: ffff88836e400000
[84291.600703] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[84291.600705] FS:  00007fbb729aeb80(0000) GS:ffff8897df580000(0000) knlGS:0000000000000000
[84291.600706] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[84291.600707] CR2: 00007fbb72506800 CR3: 00000001d9f84000 CR4: 0000000000350ee0
[84291.600709] DR0: ffffffff84366418 DR1: ffffffff84366419 DR2: ffffffff8436641a
[84291.600710] DR3: ffffffff8436641b DR6: 00000000ffff0ff0 DR7: 0000000000000600
[84291.600710] Call Trace:
[84291.600713]  <TASK>
[84291.600714]  blk_mq_map_queues+0x16/0xc0
[84291.600739]  null_map_queues+0xa5/0xe0 [null_blk]
[84291.600753]  blk_mq_alloc_tag_set+0x14d/0x3f0
[84291.600757]  ? __kmalloc+0xbc/0x130
[84291.600761]  null_add_dev.part.0+0x601/0x700 [null_blk]
[84291.600766]  null_init+0x109/0xff0 [null_blk]
[84291.600771]  ? __pfx_init_module+0x10/0x10 [null_blk]
[84291.600775]  do_one_initcall+0x44/0x220
[84291.600779]  ? kmalloc_trace+0x25/0x90
[84291.600781]  do_init_module+0x4c/0x210
[84291.600785]  __do_sys_finit_module+0xb4/0x130
[84291.600788]  do_syscall_64+0x3b/0x90
[84291.600792]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[84291.600794] RIP: 0033:0x7fbb7252c15d
[84291.600796] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[84291.600797] RSP: 002b:00007fff5b4c93a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[84291.600798] RAX: ffffffffffffffda RBX: 0000564b7f547b90 RCX: 00007fbb7252c15d
[84291.600799] RDX: 0000000000000000 RSI: 0000564b7f547f00 RDI: 0000000000000003
[84291.600800] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[84291.600801] R10: 0000000000000003 R11: 0000000000000246 R12: 0000564b7f547f00
[84291.600801] R13: 0000564b7f547cc0 R14: 0000564b7f547b90 R15: 0000564b7f547f20
[84291.600803]  </TASK>
[84291.600804] ---[ end trace 0000000000000000 ]---
[84291.666608] null_blk: disk nullb0 created
[84291.666613] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4096
[84292.008987] ------------[ cut here ]------------
[84292.008992] WARNING: CPU: 15 PID: 68414 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[84292.008999] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[84292.009027] CPU: 15 PID: 68414 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[84292.009029] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[84292.009030] RIP: 0010:group_cpus_evenly+0x26e/0x280
[84292.009033] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[84292.009034] RSP: 0018:ffffc90000e13cb8 EFLAGS: 00010287
[84292.009036] RAX: 0000000080000000 RBX: 0000000000001000 RCX: 0000000000000000
[84292.009037] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[84292.009038] RBP: ffff888722822b40 R08: ffff888722822fd0 R09: ffff889180000000
[84292.009039] R10: ffff888722822fd0 R11: 0000000000000000 R12: ffff889180000000
[84292.009039] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[84292.009041] FS:  00007f15913a3b80(0000) GS:ffff8897df5c0000(0000) knlGS:0000000000000000
[84292.009051] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[84292.009052] CR2: 00007f1590f06800 CR3: 00000001d9f84000 CR4: 0000000000350ee0
[84292.009054] DR0: ffffffff8436641c DR1: ffffffff8436641d DR2: ffffffff8436641e
[84292.009055] DR3: ffffffff8436641f DR6: 00000000ffff0ff0 DR7: 0000000000000600
[84292.009056] Call Trace:
[84292.009058]  <TASK>
[84292.009059]  blk_mq_map_queues+0x16/0xc0
[84292.009063]  null_map_queues+0xa5/0xe0 [null_blk]
[84292.009069]  blk_mq_alloc_tag_set+0x14d/0x3f0
[84292.009072]  ? __kmalloc+0xbc/0x130
[84292.009104]  null_add_dev.part.0+0x601/0x700 [null_blk]
[84292.009109]  null_init+0x109/0xff0 [null_blk]
[84292.009114]  ? __pfx_init_module+0x10/0x10 [null_blk]
[84292.009118]  do_one_initcall+0x44/0x220
[84292.009122]  ? kmalloc_trace+0x25/0x90
[84292.009124]  do_init_module+0x4c/0x210
[84292.009127]  __do_sys_finit_module+0xb4/0x130
[84292.009130]  do_syscall_64+0x3b/0x90
[84292.009134]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[84292.009137] RIP: 0033:0x7f1590f2c15d
[84292.009139] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[84292.009140] RSP: 002b:00007fff7cd8a0e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[84292.009141] RAX: ffffffffffffffda RBX: 000056075841ab90 RCX: 00007f1590f2c15d
[84292.009142] RDX: 0000000000000000 RSI: 000056075841af00 RDI: 0000000000000003
[84292.009143] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[84292.009143] R10: 0000000000000003 R11: 0000000000000246 R12: 000056075841af00
[84292.009144] R13: 000056075841acc0 R14: 000056075841ab90 R15: 000056075841af20
[84292.009146]  </TASK>
[84292.009146] ---[ end trace 0000000000000000 ]---
[84292.129399] null_blk: disk nullb0 created
[84292.129404] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8192
[84292.759375] null_blk: disk nullb0 created
[84292.759380] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16384
[84293.730375] null_blk: disk nullb0 created
[84293.730380] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32768
[84295.385840] null_blk: disk nullb0 created
[84295.385845] null_blk: module loaded
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
[84300.806218] null_blk: `2147483648' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Numerical result out of range
[84301.093801] null_blk: `4294967296' invalid for parameter `poll_queues'
###################################################
hw_queue_depth:
------------------------------------
modprobe null_blk hw_queue_depth=-2
[84301.380170] blk-mq: reduced tag depth to 10240
[84301.381868] null_blk: disk nullb0 created
[84301.381871] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=-1
[84301.425387] blk-mq: reduced tag depth to 10240
[84301.428142] null_blk: disk nullb0 created
[84301.428145] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
------------------------------------
modprobe null_blk hw_queue_depth=1
[84301.504891] null_blk: disk nullb0 created
[84301.504896] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=2
[84301.553761] null_blk: disk nullb0 created
[84301.553763] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=4
[84301.599738] null_blk: disk nullb0 created
[84301.599742] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=8
[84301.647959] null_blk: disk nullb0 created
[84301.647961] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=32
[84301.697777] null_blk: disk nullb0 created
[84301.697780] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=64
[84301.741620] null_blk: disk nullb0 created
[84301.741662] null_blk: module loaded
###################################################
max_sectors:
------------------------------------
modprobe null_blk max_sectors=-2
[84301.781007] null_blk: invalid max sectors
[84301.781011] null_blk: defaults max sectors to 2560
[84301.782430] null_blk: disk nullb0 created
[84301.782432] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=-1
[84301.821129] null_blk: invalid max sectors
[84301.821132] null_blk: defaults max sectors to 2560
[84301.822513] null_blk: disk nullb0 created
[84301.822516] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=0
[84301.866332] null_blk: disk nullb0 created
[84301.866336] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=1
[84301.909461] blk_queue_max_hw_sectors: set to minimum 8
[84301.910520] null_blk: disk nullb0 created
[84301.910521] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=2
[84301.968764] blk_queue_max_hw_sectors: set to minimum 8
[84301.970640] null_blk: disk nullb0 created
[84301.970643] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=4
[84302.016555] blk_queue_max_hw_sectors: set to minimum 8
[84302.017888] null_blk: disk nullb0 created
[84302.017890] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=8
[84302.060618] null_blk: disk nullb0 created
[84302.060623] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=32
[84302.115868] null_blk: disk nullb0 created
[84302.115870] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=64
[84302.169225] null_blk: disk nullb0 created
[84302.169228] null_blk: module loaded
###################################################
gb:
------------------------------------
modprobe null_blk gb=-2
[84302.221403] null_blk: disk nullb0 created
[84302.221406] null_blk: module loaded
------------------------------------
modprobe null_blk gb=-1
[84302.282922] null_blk: disk nullb0 created
[84302.282925] null_blk: module loaded
------------------------------------
modprobe null_blk gb=0
[84302.327444] null_blk: disk nullb0 created
[84302.327446] null_blk: module loaded
------------------------------------
modprobe null_blk gb=1
[84302.375347] null_blk: disk nullb0 created
[84302.375352] null_blk: module loaded
------------------------------------
modprobe null_blk gb=2
[84302.434298] null_blk: disk nullb0 created
[84302.434302] null_blk: module loaded
------------------------------------
modprobe null_blk gb=4
[84302.480493] null_blk: disk nullb0 created
[84302.480496] null_blk: module loaded
------------------------------------
modprobe null_blk gb=8
[84302.521223] null_blk: disk nullb0 created
[84302.521228] null_blk: module loaded
------------------------------------
modprobe null_blk gb=32
[84302.569732] null_blk: disk nullb0 created
[84302.569735] null_blk: module loaded
------------------------------------
modprobe null_blk gb=64
[84302.613758] null_blk: disk nullb0 created
[84302.613761] null_blk: module loaded
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
[84302.729634] null_blk: disk nullb0 created
[84302.729637] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=1
[84302.776186] null_blk: disk nullb0 created
[84302.776218] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2
[84302.823402] null_blk: disk nullb0 created
[84302.823406] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[84302.876357] null_blk: disk nullb0 created
[84302.876360] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[84302.923946] null_blk: disk nullb0 created
[84302.923950] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[84302.969841] null_blk: disk nullb0 created
[84302.969845] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
[84303.016731] ------------[ cut here ]------------
[84303.016734] WARNING: CPU: 15 PID: 68690 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
[84303.016745] Modules linked in: null_blk(O+) xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uinput ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs intel_rapl_msr intel_rapl_common kvm_amd ccp ppdev kvm parport_pc parport irqbypass i2c_piix4 pcspkr joydev zram ip_tables bochs crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel drm_kms_helper drm_ttm_helper ttm ghash_clmulni_intel nvme virtio_net sha512_ssse3 nvme_core net_failover ata_generic serio_raw drm virtio_blk nvme_common failover pata_acpi qemu_fw_cfg fuse [last unloaded: null_blk(O)]
[84303.016801] CPU: 15 PID: 68690 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc5lblk+ #4
[84303.016805] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[84303.016807] RIP: 0010:group_cpus_evenly+0x26e/0x280
[84303.016811] Code: b3 ff 48 8b 7c 24 08 e8 a0 d1 5d 00 48 8b 3c 24 e8 97 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 04 8e 8f ff eb ac <0f> 0b eb a8 e8 c9 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
[84303.016814] RSP: 0018:ffffc90000ff3cb8 EFLAGS: 00010287
[84303.016816] RAX: 0000000080000000 RBX: 0000000000000040 RCX: 0000000000000000
[84303.016818] RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
[84303.016820] RBP: ffff888764ef5960 R08: ffff888764ef52a8 R09: ffff888d15d40000
[84303.016822] R10: ffff888764ef52a8 R11: 0000000000000000 R12: ffff888d15d40000
[84303.016823] R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
[84303.016827] FS:  00007f6d88b36b80(0000) GS:ffff8897df5c0000(0000) knlGS:0000000000000000
[84303.016829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[84303.016831] CR2: 00007f6d88706800 CR3: 000000010856a000 CR4: 0000000000350ee0
[84303.016835] DR0: ffffffff8436641c DR1: ffffffff8436641d DR2: ffffffff8436641e
[84303.016837] DR3: ffffffff8436641f DR6: 00000000ffff0ff0 DR7: 0000000000000600
[84303.016838] Call Trace:
[84303.016841]  <TASK>
[84303.016852]  blk_mq_map_queues+0x16/0xc0
[84303.016887]  null_map_queues+0xa5/0xe0 [null_blk]
[84303.016900]  blk_mq_alloc_tag_set+0x14d/0x3f0
[84303.016905]  ? __kmalloc+0xbc/0x130
[84303.016910]  null_add_dev.part.0+0x601/0x700 [null_blk]
[84303.016921]  null_init+0x109/0xff0 [null_blk]
[84303.016930]  ? __pfx_init_module+0x10/0x10 [null_blk]
[84303.016940]  do_one_initcall+0x44/0x220
[84303.016949]  ? kmalloc_trace+0x25/0x90
[84303.016953]  do_init_module+0x4c/0x210
[84303.016983]  __do_sys_finit_module+0xb4/0x130
[84303.016990]  do_syscall_64+0x3b/0x90
[84303.016996]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[84303.017000] RIP: 0033:0x7f6d8872c15d
[84303.017003] Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
[84303.017005] RSP: 002b:00007fff2bb71b58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[84303.017008] RAX: ffffffffffffffda RBX: 0000557f88cc4b90 RCX: 00007f6d8872c15d
[84303.017028] RDX: 0000000000000000 RSI: 0000557f88cc4f00 RDI: 0000000000000003
[84303.017029] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
[84303.017030] R10: 0000000000000003 R11: 0000000000000246 R12: 0000557f88cc4f00
[84303.017032] R13: 0000557f88cc4cc0 R14: 0000557f88cc4b90 R15: 0000557f88cc4f20
[84303.017035]  </TASK>
[84303.017036] ---[ end trace 0000000000000000 ]---
[84303.020772] null_blk: disk nullb0 created
[84303.020774] null_blk: module loaded
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=-2
[84303.062497] null_blk: disk nullb0 created
[84303.062501] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=-1
[84303.110655] null_blk: disk nullb0 created
[84303.110658] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=0
[84303.161507] null_blk: disk nullb0 created
[84303.161510] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1
[84303.202788] null_blk: disk nullb0 created
[84303.202791] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2
[84303.257937] null_blk: disk nullb0 created
[84303.257940] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[84303.301380] null_blk: disk nullb0 created
[84303.301383] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[84303.344782] null_blk: disk nullb0 created
[84303.344787] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[84303.390319] null_blk: disk nullb0 created
[84303.390322] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[84303.443584] null_blk: disk nullb0 created
[84303.443587] null_blk: module loaded
###################################################
queue_mode:
------------------------------------
modprobe null_blk queue_mode=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84303.492554] null_blk: `-2' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84303.527924] null_blk: `-1' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=0
[84303.554894] null_blk: disk nullb0 created
[84303.554896] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84303.602029] null_blk: legacy IO path is no longer available
------------------------------------
modprobe null_blk queue_mode=2
[84303.639278] null_blk: disk nullb0 created
[84303.639282] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84303.690917] null_blk: `4' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84303.723266] null_blk: `8' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84303.755929] null_blk: `32' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84303.789364] null_blk: `64' invalid for parameter `queue_mode'
###################################################
bs:
------------------------------------
modprobe null_blk bs=-2
[84303.831844] null_blk: invalid block size
[84303.831847] null_blk: defaults block size to 4096
[84303.833387] null_blk: disk nullb0 created
[84303.833390] null_blk: module loaded
------------------------------------
modprobe null_blk bs=-1
[84303.897333] null_blk: invalid block size
[84303.897337] null_blk: defaults block size to 4096
[84303.899015] null_blk: disk nullb0 created
[84303.899017] null_blk: module loaded
------------------------------------
modprobe null_blk bs=0
[84303.957024] null_blk: disk nullb0 created
[84303.957028] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1
[84304.003499] null_blk: disk nullb0 created
[84304.003503] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2
[84304.054432] null_blk: disk nullb0 created
[84304.054434] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4
[84304.103425] null_blk: disk nullb0 created
[84304.103428] null_blk: module loaded
------------------------------------
modprobe null_blk bs=8
[84304.154212] null_blk: disk nullb0 created
[84304.154215] null_blk: module loaded
------------------------------------
modprobe null_blk bs=32
[84304.209678] null_blk: disk nullb0 created
[84304.209682] null_blk: module loaded
------------------------------------
modprobe null_blk bs=64
[84304.249885] null_blk: disk nullb0 created
[84304.249889] null_blk: module loaded
------------------------------------
modprobe null_blk bs=512
[84304.298134] null_blk: disk nullb0 created
[84304.298138] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1024
[84304.349519] null_blk: disk nullb0 created
[84304.349521] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2048
[84304.391509] null_blk: disk nullb0 created
[84304.391512] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4096
[84304.434945] null_blk: disk nullb0 created
[84304.434947] null_blk: module loaded
Switched to branch 'nullb-mod-parm-v3'
commit 05c1289ee762c0d9d1bf22de59101b2f7636925d (HEAD -> nullb-mod-parm-v3)
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
-rw-r--r--. 1 root root 1.2M Apr 10 14:01 /lib/modules/6.3.0-rc5lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=2
[84307.486886] null_blk: disk nullb0 created
[84307.486890] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[84307.780742] null_blk: disk nullb0 created
[84307.780747] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[84308.085812] null_blk: disk nullb0 created
[84308.085825] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16
[84308.378936] null_blk: disk nullb0 created
[84308.378941] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[84308.670406] null_blk: disk nullb0 created
[84308.670410] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84308.959305] null_blk: `64' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=128
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84309.244491] null_blk: `128' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=256
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84309.533128] null_blk: `256' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=512
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84309.819159] null_blk: `512' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1024
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84310.107475] null_blk: `1024' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2048
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84310.391636] null_blk: `2048' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4096
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84310.683737] null_blk: `4096' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=8192
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84310.967823] null_blk: `8192' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=16384
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84311.256863] null_blk: `16384' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=32768
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84311.539889] null_blk: `32768' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=65536
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84311.824812] null_blk: `65536' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=131072
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84312.123046] null_blk: `131072' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=262144
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84312.415262] null_blk: `262144' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=524288
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84312.709451] null_blk: `524288' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1048576
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84312.994839] null_blk: `1048576' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2097152
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84313.279520] null_blk: `2097152' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4194304
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84313.561943] null_blk: `4194304' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=8388608
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84313.851951] null_blk: `8388608' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=16777216
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84314.135294] null_blk: `16777216' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=33554432
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84314.420552] null_blk: `33554432' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=67108864
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84314.700117] null_blk: `67108864' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=134217728
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84314.992190] null_blk: `134217728' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=268435456
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84315.274415] null_blk: `268435456' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=536870912
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84315.564177] null_blk: `536870912' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1073741824
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84315.849428] null_blk: `1073741824' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84316.133567] null_blk: `2147483648' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84316.416791] null_blk: `4294967296' invalid for parameter `poll_queues'
###################################################
hw_queue_depth:
------------------------------------
modprobe null_blk hw_queue_depth=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84316.700830] null_blk: `-2' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84316.728856] null_blk: `-1' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84316.755657] null_blk: `0' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=1
[84316.788156] null_blk: disk nullb0 created
[84316.788160] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=2
[84316.836501] null_blk: disk nullb0 created
[84316.836504] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=4
[84316.876409] null_blk: disk nullb0 created
[84316.876412] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=8
[84316.915877] null_blk: disk nullb0 created
[84316.915880] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=32
[84316.973129] null_blk: disk nullb0 created
[84316.973132] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=64
[84317.020723] null_blk: disk nullb0 created
[84317.020725] null_blk: module loaded
###################################################
max_sectors:
------------------------------------
modprobe null_blk max_sectors=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84317.065071] null_blk: `-2' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84317.102186] null_blk: `-1' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84317.133126] null_blk: `0' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=1
[84317.168131] blk_queue_max_hw_sectors: set to minimum 8
[84317.169322] null_blk: disk nullb0 created
[84317.169324] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=2
[84317.222472] blk_queue_max_hw_sectors: set to minimum 8
[84317.223553] null_blk: disk nullb0 created
[84317.223555] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=4
[84317.265570] blk_queue_max_hw_sectors: set to minimum 8
[84317.267161] null_blk: disk nullb0 created
[84317.267164] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=8
[84317.307583] null_blk: disk nullb0 created
[84317.307587] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=32
[84317.353199] null_blk: disk nullb0 created
[84317.353202] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=64
[84317.404759] null_blk: disk nullb0 created
[84317.404764] null_blk: module loaded
###################################################
gb:
------------------------------------
modprobe null_blk gb=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84317.446733] null_blk: `-2' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84317.472834] null_blk: `-1' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84317.504403] null_blk: `0' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=1
[84317.543209] null_blk: disk nullb0 created
[84317.543213] null_blk: module loaded
------------------------------------
modprobe null_blk gb=2
[84317.586970] null_blk: disk nullb0 created
[84317.586973] null_blk: module loaded
------------------------------------
modprobe null_blk gb=4
[84317.633121] null_blk: disk nullb0 created
[84317.633126] null_blk: module loaded
------------------------------------
modprobe null_blk gb=8
[84317.685040] null_blk: disk nullb0 created
[84317.685044] null_blk: module loaded
------------------------------------
modprobe null_blk gb=32
[84317.729931] null_blk: disk nullb0 created
[84317.729933] null_blk: module loaded
------------------------------------
modprobe null_blk gb=64
[84317.773148] null_blk: disk nullb0 created
[84317.773152] null_blk: module loaded
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84317.830420] null_blk: `-2' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84317.860687] null_blk: `-1' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84317.892218] null_blk: `0' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1
[84317.919966] null_blk: disk nullb0 created
[84317.919968] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2
[84317.972261] null_blk: disk nullb0 created
[84317.972264] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[84318.031996] null_blk: disk nullb0 created
[84318.031999] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[84318.084307] null_blk: disk nullb0 created
[84318.084309] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[84318.146777] null_blk: disk nullb0 created
[84318.146782] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.190099] null_blk: `64' invalid for parameter `poll_queues'
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.218243] null_blk: `-2' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.244873] null_blk: `-1' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.278411] null_blk: `0' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=1
[84318.313896] null_blk: disk nullb0 created
[84318.313899] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2
[84318.351074] null_blk: disk nullb0 created
[84318.351078] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[84318.397613] null_blk: disk nullb0 created
[84318.397617] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[84318.444678] null_blk: disk nullb0 created
[84318.444681] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[84318.486504] null_blk: disk nullb0 created
[84318.486507] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[84318.531518] null_blk: disk nullb0 created
[84318.531521] null_blk: module loaded
###################################################
queue_mode:
------------------------------------
modprobe null_blk queue_mode=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.576463] null_blk: `-2' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.604958] null_blk: `-1' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=0
[84318.638120] null_blk: disk nullb0 created
[84318.638125] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.670207] null_blk: legacy IO path is no longer available
------------------------------------
modprobe null_blk queue_mode=2
[84318.696075] null_blk: disk nullb0 created
[84318.696080] null_blk: module loaded
------------------------------------
modprobe null_blk queue_mode=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.736466] null_blk: `4' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.768566] null_blk: `8' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.796589] null_blk: `32' invalid for parameter `queue_mode'
------------------------------------
modprobe null_blk queue_mode=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.825481] null_blk: `64' invalid for parameter `queue_mode'
###################################################
bs:
------------------------------------
modprobe null_blk bs=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.860362] null_blk: `-2' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.903215] null_blk: `-1' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.937469] null_blk: `0' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84318.967708] null_blk: `1' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84319.000726] null_blk: `2' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84319.032855] null_blk: `4' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84319.063602] null_blk: `8' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84319.091393] null_blk: `32' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[84319.117055] null_blk: `64' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=512
[84319.157199] null_blk: disk nullb0 created
[84319.157202] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1024
[84319.210266] null_blk: disk nullb0 created
[84319.210271] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2048
[84319.267244] null_blk: disk nullb0 created
[84319.267247] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4096
[84319.323218] null_blk: disk nullb0 created
[84319.323221] null_blk: module loaded


-- 
2.29.0

