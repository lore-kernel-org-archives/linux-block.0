Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DB8C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE552214AF
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RxAagz4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfCLBZd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:25:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCLBZd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 21:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dagOgSvgZM+9PMETxeJFTAMp7l7BXN5fLun4NDDp5EQ=; b=RxAagz4O14zScDaweOtVoevTT
        eQXLsrmjBDvaHrGWIAq+LVW8tl1z4ftpmxXAK3A7XpaBu9WmLEx4xRrYgeggOB/9NZkd2ApgEnGj7
        QkVP3KXBNZoIl+YvOpe/xG3xIM6OpU0V6pbVuaskNumNoH8hcsigfNw3xkfs7Iurenae5JbuGfT5A
        eXXiKVvELszS5ztZdjyV2ctns+ccQs8Els6OXNY8pAZElIP2LdFHPhdHa9MDJw0YufwC+0uH4T6jt
        8wc9R3ZeYIvUc9nbNFlCgMkcc+22jVDDxAxt9SMvzi1XkRyiDaVbUsjiLJvIuXf4cDacxImnNTeyp
        +RtTa94sA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3WAd-0005lr-9t; Tue, 12 Mar 2019 01:25:31 +0000
To:     linux-block <linux-block@vger.kernel.org>, axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: paride/pf.c: blk-mq use-after-free (kernel v5.0)
Message-ID: <30c63b2d-92d2-51be-40f0-62cada110388@infradead.org>
Date:   Mon, 11 Mar 2019 18:25:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[Has this already been addressed/fixed?]


[ 1688.055696] calling  pf_init+0x0/0x1000 [pf] @ 8572
[ 1688.058871] pf: pf version 1.04, major 47, cluster 64, nice 0
[ 1688.064381] pf: No ATAPI disk detected
[ 1688.064783] initcall pf_init+0x0/0x1000 [pf] returned -19 after 8827 usecs
[ 1688.322562] calling  pf_init+0x0/0x1000 [pf] @ 8582
[ 1688.323566] ==================================================================
[ 1688.323621] BUG: KASAN: use-after-free in __cpuhp_state_add_instance_cpuslocked+0x33f/0x430
[ 1688.323669] Write of size 8 at addr ffff888117051810 by task modprobe/8582

[ 1688.323729] CPU: 3 PID: 8582 Comm: modprobe Not tainted 5.0.0mod #2
[ 1688.323767] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[ 1688.323812] Call Trace:
[ 1688.323840]  dump_stack+0x7b/0xb5
[ 1688.323874]  print_address_description+0x6e/0x360
[ 1688.323916]  kasan_report+0x11a/0x198
[ 1688.323948]  ? __cpuhp_state_add_instance_cpuslocked+0x33f/0x430
[ 1688.323993]  ? __cpuhp_state_add_instance_cpuslocked+0x33f/0x430
[ 1688.324035]  __asan_report_store8_noabort+0x17/0x20
[ 1688.324070]  __cpuhp_state_add_instance_cpuslocked+0x33f/0x430
[ 1688.324108]  ? blk_mq_realloc_hw_ctxs+0x409/0xfb0
[ 1688.324142]  ? __might_sleep+0xa1/0x1b0
[ 1688.324178]  ? lockdep_init_map+0x115/0x5e0
[ 1688.324215]  __cpuhp_state_add_instance+0x78/0xf0
[ 1688.324249]  blk_mq_realloc_hw_ctxs+0x409/0xfb0
[ 1688.324279]  ? kasan_unpoison_shadow+0x35/0x50
[ 1688.324311]  ? __kasan_kmalloc.constprop.8+0xa7/0xd0
[ 1688.324362]  blk_mq_init_allocated_queue+0x404/0x1a00
[ 1688.324395]  ? blk_throtl_init+0x431/0x620
[ 1688.324430]  ? blkcg_init_queue+0x102/0x190
[ 1688.324475]  blk_mq_init_queue+0x56/0x80
[ 1688.324507]  blk_mq_init_sq_queue+0x144/0x1a0
[ 1688.324547]  pf_init+0x9f/0x1000 [pf]
[ 1688.324575]  ? 0xffffffffc0a48000
[ 1688.324605]  ? ktime_get+0xba/0x160
[ 1688.324634]  ? 0xffffffffc0a48000
[ 1688.324662]  do_one_initcall+0xab/0x2ad
[ 1688.324692]  ? initcall_blacklisted+0x190/0x190
[ 1688.324723]  ? kasan_unpoison_shadow+0x35/0x50
[ 1688.324759]  ? kasan_unpoison_shadow+0x35/0x50
[ 1688.324788]  ? kasan_unpoison_shadow+0x35/0x50
[ 1688.324819]  ? kasan_poison_shadow+0x2f/0x40
[ 1688.324849]  ? __asan_register_globals+0x5a/0x70
[ 1688.324888]  do_init_module+0x1c7/0x548
[ 1688.324926]  load_module+0x445d/0x5de0
[ 1688.324999]  ? layout_and_allocate+0x2d00/0x2d00
[ 1688.325035]  ? kernel_read+0x90/0x130
[ 1688.325074]  ? kasan_check_write+0x14/0x20
[ 1688.325105]  ? kernel_read_file+0x24a/0x640
[ 1688.325179]  __do_sys_finit_module+0x193/0x1b0
[ 1688.325209]  ? __do_sys_finit_module+0x193/0x1b0
[ 1688.325242]  ? __ia32_sys_init_module+0xa0/0xa0
[ 1688.325275]  ? vfs_statx_fd+0x45/0x80
[ 1688.325306]  ? kasan_check_write+0x14/0x20
[ 1688.325335]  ? fput+0x18/0x130
[ 1688.325363]  ? ksys_mmap_pgoff+0x3d9/0xb50
[ 1688.325416]  __x64_sys_finit_module+0x6e/0xb0
[ 1688.325442]  ? __x64_sys_newfstat+0x4f/0x70
[ 1688.325469]  do_syscall_64+0xaa/0x310
[ 1688.325501]  ? prepare_exit_to_usermode+0x8b/0x150
[ 1688.325536]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1688.325567] RIP: 0033:0x7f17f52bd129
[ 1688.325595] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 0d 2c 00 f7 d8 64 89 01 48
[ 1688.325679] RSP: 002b:00007fff2e723e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[ 1688.325718] RAX: ffffffffffffffda RBX: 00005565f67c0b10 RCX: 00007f17f52bd129
[ 1688.325740] RDX: 0000000000000000 RSI: 00005565f65ae548 RDI: 0000000000000003
[ 1688.325762] RBP: 00005565f65ae548 R08: 0000000000000000 R09: 00005565f67c0400
[ 1688.325783] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000040000
[ 1688.325805] R13: 00005565f67c0c40 R14: 0000000000000000 R15: 00005565f67c0b10

[ 1688.325848] Allocated by task 8572:
[ 1688.325864]  save_stack+0x43/0xd0
[ 1688.325879]  __kasan_kmalloc.constprop.8+0xa7/0xd0
[ 1688.325896]  kasan_kmalloc+0x9/0x10
[ 1688.325912]  blk_mq_realloc_hw_ctxs+0x18b/0xfb0
[ 1688.325929]  blk_mq_init_allocated_queue+0x404/0x1a00
[ 1688.325948]  blk_mq_init_queue+0x56/0x80
[ 1688.325964]  blk_mq_init_sq_queue+0x144/0x1a0
[ 1688.325983]  pf_init+0x9f/0x1000 [pf]
[ 1688.325998]  do_one_initcall+0xab/0x2ad
[ 1688.326013]  do_init_module+0x1c7/0x548
[ 1688.326028]  load_module+0x445d/0x5de0
[ 1688.326043]  __do_sys_finit_module+0x193/0x1b0
[ 1688.326059]  __x64_sys_finit_module+0x6e/0xb0
[ 1688.326075]  do_syscall_64+0xaa/0x310
[ 1688.326097]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[ 1688.326142] Freed by task 2217:
[ 1688.326160]  save_stack+0x43/0xd0
[ 1688.326174]  __kasan_slab_free+0x137/0x190
[ 1688.326191]  kasan_slab_free+0xe/0x10
[ 1688.326206]  kfree+0xb0/0x1b0
[ 1688.326220]  blk_mq_hw_sysfs_release+0x6f/0x90
[ 1688.326237]  kobject_put+0x153/0x420
[ 1688.326252]  blk_mq_release+0xbc/0x160
[ 1688.326267]  __blk_release_queue+0x178/0x320
[ 1688.326284]  process_one_work+0x9fb/0x1710
[ 1688.326299]  worker_thread+0x85/0xee0
[ 1688.326315]  kthread+0x349/0x410
[ 1688.326329]  ret_from_fork+0x35/0x40

[ 1688.326353] The buggy address belongs to the object at ffff888117051588
                which belongs to the cache kmalloc-1k of size 1024
[ 1688.326388] The buggy address is located 648 bytes inside of
                1024-byte region [ffff888117051588, ffff888117051988)
[ 1688.326421] The buggy address belongs to the page:
[ 1688.326439] page:ffffea00045c1400 count:1 mapcount:0 mapping:ffff888107c16940 index:0x0 compound_mapcount: 0
[ 1688.326469] flags: 0x17ffffc0010200(slab|head)
[ 1688.326488] raw: 0017ffffc0010200 ffffea0004502408 ffffea00042c6408 ffff888107c16940
[ 1688.326512] raw: 0000000000000000 0000000000170017 00000001ffffffff 0000000000000000
[ 1688.326535] page dumped because: kasan: bad access detected

[ 1688.326562] Memory state around the buggy address:
[ 1688.326579]  ffff888117051700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1688.326602]  ffff888117051780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1688.326624] >ffff888117051800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1688.326646]                          ^
[ 1688.326660]  ffff888117051880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1688.326684]  ffff888117051900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1688.326705] ==================================================================
[ 1688.326726] Disabling lock debugging due to kernel taint
[ 1688.328731] pf: pf version 1.04, major 47, cluster 64, nice 0
[ 1688.336493] pf: No ATAPI disk detected
[ 1688.336730] initcall pf_init+0x0/0x1000 [pf] returned -19 after 13791 usecs

-- 
~Randy
