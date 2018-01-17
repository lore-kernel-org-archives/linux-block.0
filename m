Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx.ewheeler.net ([66.155.3.69]:38166 "EHLO mail.ewheeler.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752368AbeAQS6Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jan 2018 13:58:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.ewheeler.net (Postfix) with ESMTP id AA22EA0674
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2018 18:53:09 +0000 (UTC)
Received: from mail.ewheeler.net ([127.0.0.1])
        by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wdWSHoQWR3Mc for <linux-block@vger.kernel.org>;
        Wed, 17 Jan 2018 18:53:09 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.ewheeler.net (Postfix) with ESMTPSA id 2BBA6A066F
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2018 18:53:09 +0000 (UTC)
Date: Wed, 17 Jan 2018 18:53:04 +0000 (UTC)
From: Eric Wheeler <linux-block@lists.ewheeler.net>
To: linux-block@vger.kernel.org
Subject: WARNING: bi_status >= ARRAY_SIZE(blk_errors): bi_status=201
Message-ID: <alpine.LRH.2.11.1801171850040.10175@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello all,

We are getting the following on 4.14.13:

[33418.520838] bi_status >= ARRAY_SIZE(blk_errors): bi_status=201

The line above is our debug output showing the value of "idx" in 
block/blk-core.c:174 blk_status_to_errno where the WARN_ON is located.

Why would bi_status have a value of 201?

-Eric

[33418.523591] ------------[ cut here ]------------
[33418.526319] WARNING: CPU: 2 PID: 8484 at block/blk-core.c:174 blk_status_to_errno+0x41/0x50
[33418.529326] Modules linked in: btrfs xor zstd_decompress zstd_compress xxhash raid6_pq dm_crypt binfmt_misc dm_snapshot lz4 lz4_compress zram drbd lru_cache ebtable_filter ebtables ip6table_filter ip6_tables iptable_nat nf_nat_ipv4 nf_nat xt_connbytes xt_DSCP iptable_mangle ipt_REJECT nf_reject_ipv4 xt_limit nf_log_ipv4 nf_log_common xt_LOG nf_conntrack_ipv4 nf_defrag_ipv4 xt_comment xt_owner mpt3sas raid_class scsi_transport_sas mptctl mptbase xt_recent xt_conntrack nf_conntrack xt_set iptable_filter ip_set_hash_net ip_set nfnetlink netconsole dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c 8021q garp mrp bridge stp llc sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass bcache crct10dif_pclmul crc32_pclmul iTCO_wdt iTCO_vendor_support ghash_clmulni_intel
[33418.553475]  mxm_wmi dcdbas pcspkr sg ipmi_si lpc_ich ipmi_devintf mfd_core ipmi_msghandler wmi mei_me mei shpchp acpi_power_meter nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 mbcache jbd2 mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm igb crc32c_intel ptp drm pps_core dca megaraid_sas i2c_algo_bit i2c_core dm_mirror dm_region_hash dm_log dm_mod dax bonding
[33418.568770] CPU: 2 PID: 8484 Comm: kworker/2:0 Not tainted 4.14.13 #66
[33418.573012] Hardware name: Dell Inc. PowerEdge R730xd/0599V5, BIOS 2.7.0 12/005/2017
[33418.577148] Workqueue: bcache bch_data_insert_keys [bcache]
[33418.581315] task: ffff977748e54380 task.stack: ffffa42a0fd58000
[33418.585623] RIP: 0010:blk_status_to_errno+0x41/0x50
[33418.589742] RSP: 0018:ffffa42a0fd5bd70 EFLAGS: 00010246
[33418.594016] RAX: 0000000000000032 RBX: ffff977721daa800 RCX: 0000000000000000
[33418.598305] RDX: 0000000000000000 RSI: ffff9777bfc96938 RDI: ffff9777bfc96938
[33418.602638] RBP: ffff9776e6a25a40 R08: 0000000000000001 R09: 0000000000006d9a
[33418.606801] R10: 000000000000006c R11: ffffa42a06e1c160 R12: ffff9775c22e1300
[33418.611008] R13: 0000000000000015 R14: 0000000000000000 R15: ffff977734664cf0
[33418.615231] FS:  0000000000000000(0000) GS:ffff9777bfc80000(0000) knlGS:0000000000000000
[33418.619818] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[33418.624355] CR2: ffffffffff600400 CR3: 0000000a2800a006 CR4: 00000000001626e0
[33418.628596] Call Trace:
[33418.632290]  drbd_request_endio+0x5d/0x290 [drbd]
[33418.636713]  clone_endio+0x8e/0x130 [dm_mod]
[33418.640879]  clone_endio+0x8e/0x130 [dm_mod]
[33418.646070]  clone_endio+0x8e/0x130 [dm_mod]
[33418.651681]  bio_complete+0x74/0xd0 [bcache]
[33418.657139]  search_free+0xe/0x40 [bcache]
[33418.663005]  cached_dev_write_complete+0x2c/0x60 [bcache]
[33418.668419]  process_one_work+0x141/0x340
[33418.673814]  worker_thread+0x47/0x3e0
[33418.679164]  kthread+0xfc/0x130
[33418.684400]  ? rescuer_thread+0x380/0x380
[33418.689763]  ? kthread_park+0x60/0x60
[33418.694955]  ? do_syscall_64+0x61/0x1a0
[33418.700193]  ? SyS_exit_group+0x10/0x10
[33418.705528]  ret_from_fork+0x1f/0x30
[33418.710839] Code: 8b 80 40 ba c7 ba c3 80 3d cc 55 e8 00 00 74 06 b8 fb ff ff ff c3 48 c7 c7 c8 3b e8 ba 31 c0 c6 05 b4 55 e8 00 01 e8 bc 87 da ff <0f> ff eb e1 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 
[33418.722086] ---[ end trace dc46edef7ad4baac ]---


--
Eric Wheeler
