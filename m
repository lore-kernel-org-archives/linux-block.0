Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC588C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 02:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A5B206DF
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 02:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfCKC3I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Mar 2019 22:29:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfCKC3I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Mar 2019 22:29:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B259FC0AC355;
        Mon, 11 Mar 2019 02:29:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5003A87C01;
        Mon, 11 Mar 2019 02:29:01 +0000 (UTC)
Date:   Mon, 11 Mar 2019 10:28:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: block: bfq: BUG: KASAN: use-after-free in bfq_bfqq_expire
Message-ID: <20190311022856.GB16849@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 11 Mar 2019 02:29:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The following KASAN warning is found when running some random workloads
on the latest linus tree:

[ 3322.073327] ==================================================================
[ 3322.074886] BUG: KASAN: use-after-free in bfq_bfqq_expire+0x8ae/0x925
[ 3322.075800] Write of size 4 at addr ffff88816457e810 by task swapper/3/0
[ 3322.076736]
[ 3322.076969] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.0.0_6cdc577a18a6_master+ #1
[ 3322.078035] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[ 3322.079230] Call Trace:
[ 3322.079602]  <IRQ>
[ 3322.079911]  dump_stack+0x9a/0xe6
[ 3322.080408]  ? bfq_bfqq_expire+0x8ae/0x925
[ 3322.080994]  print_address_description+0x6e/0x239
[ 3322.081671]  ? bfq_bfqq_expire+0x8ae/0x925
[ 3322.082251]  ? bfq_bfqq_expire+0x8ae/0x925
[ 3322.082849]  kasan_report+0x146/0x18b
[ 3322.083390]  ? rcu_read_lock_sched_held+0x25/0x63
[ 3322.084057]  ? bfq_bfqq_expire+0x8ae/0x925
[ 3322.084663]  bfq_bfqq_expire+0x8ae/0x925
[ 3322.085235]  bfq_idle_slice_timer+0xc4/0xe2
[ 3322.085853]  __hrtimer_run_queues+0x3b4/0x563
[ 3322.086502]  ? bfq_dispatch_request+0xfe5/0xfe5
[ 3322.087159]  ? hrtimer_cancel+0x1b/0x1b
[ 3322.087732]  ? kvm_clock_read+0x14/0x23
[ 3322.088283]  ? ktime_get_update_offsets_now+0x126/0x1d4
[ 3322.089049]  hrtimer_interrupt+0x1a9/0x335
[ 3322.089678]  smp_apic_timer_interrupt+0x19d/0x2ab
[ 3322.090341]  apic_timer_interrupt+0xf/0x20
[ 3322.090936]  </IRQ>
[ 3322.091251] RIP: 0010:native_safe_halt+0x2/0x3
[ 3322.091898] Code: 63 02 df f0 83 44 24 fc 00 48 89 df e8 13 d1 7c ff 48 8b 03 a8 08 74 0b 65 81 25 65 cc 45 7e ff ff ff 7f 5b 5d 41 5c c3 fb f4 <c3> f4 c3 0f 1f 44 00 00 41 56 41 55 41 54 55 53 e8 f4 36 5d ff e8
[ 3322.094474] RSP: 0018:ffff888107fafdc0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[ 3322.095535] RAX: 1ffff11020ff4900 RBX: 0000000000000000 RCX: ffffffff8115cc60
[ 3322.096539] RDX: 1ffffffff05df159 RSI: 0000000000000007 RDI: ffff888107fa4d5c
[ 3322.097542] RBP: 0000000000000000 R08: dffffc0000000000 R09: 0000000000000001
[ 3322.098529] R10: ffffed102db3fc90 R11: ffffed102db3fc8f R12: 1ffff11020ff5fbf
[ 3322.099516] R13: 0000000000000003 R14: ffff888107fa4040 R15: 0000000000000000
[ 3322.100529]  ? lockdep_hardirqs_on+0x26e/0x27b
[ 3322.101171]  default_idle+0xd9/0x1a8
[ 3322.101698]  do_idle+0x162/0x2b2
[ 3322.102165]  ? arch_cpu_idle_exit+0x28/0x28
[ 3322.102767]  ? schedule_idle+0x3b/0x44
[ 3322.103323]  cpu_startup_entry+0x1d/0x1f
[ 3322.103807]  start_secondary+0x270/0x2ad
[ 3322.104323]  ? set_cpu_sibling_map+0x8a3/0x8a3
[ 3322.104999]  secondary_startup_64+0xa4/0xb0
[ 3322.105636]
[ 3322.105865] Allocated by task 22687:
[ 3322.106380]  kmem_cache_alloc_node+0x187/0x2a8
[ 3322.107014]  bfq_get_queue+0x22a/0x503
[ 3322.107552]  bfq_get_bfqq_handle_split+0xa6/0x1ce
[ 3322.108195]  bfq_init_rq+0x3ec/0xc3d
[ 3322.108707]  bfq_insert_requests+0x14d/0x14c3
[ 3322.109319]  blk_mq_sched_insert_request+0x1ae/0x299
[ 3322.109953]  blk_mq_make_request+0x83d/0x887
[ 3322.110574]  generic_make_request+0x3f5/0x68b
[ 3322.111097]  submit_bio+0x1f2/0x239
[ 3322.111529]  submit_bh_wbc+0x2c1/0x2d2
[ 3322.112024]  ll_rw_block+0xc4/0xe5
[ 3322.112514]  ext4_bread+0x9d/0x12b
[ 3322.112998]  __ext4_read_dirblock+0x36/0x3b8
[ 3322.113559]  htree_dirblock_to_tree+0xa5/0x282
[ 3322.114094]  ext4_htree_fill_tree+0x1bc/0x483
[ 3322.114625]  ext4_readdir+0x4f4/0xe6e
[ 3322.115071]  iterate_dir+0x11f/0x204
[ 3322.115532]  __se_sys_getdents+0x117/0x1ce
[ 3322.116109]  do_syscall_64+0xa1/0x245
[ 3322.116636]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3322.117338]
[ 3322.117571] Freed by task 0:
[ 3322.117979]  kmem_cache_free+0x139/0x28e
[ 3322.118458]  bfq_bfqq_expire+0x89d/0x925
[ 3322.118920]  bfq_idle_slice_timer+0xc4/0xe2
[ 3322.119430]  __hrtimer_run_queues+0x3b4/0x563
[ 3322.119956]  hrtimer_interrupt+0x1a9/0x335
[ 3322.120506]  smp_apic_timer_interrupt+0x19d/0x2ab
[ 3322.121069]
[ 3322.121267] The buggy address belongs to the object at ffff88816457e648
[ 3322.121267]  which belongs to the cache bfq_queue of size 464
[ 3322.122902] The buggy address is located 456 bytes inside of
[ 3322.122902]  464-byte region [ffff88816457e648, ffff88816457e818)
[ 3322.124268] The buggy address belongs to the page:
[ 3322.124891] page:ffffea0005915f00 count:1 mapcount:0 mapping:ffff88807f9e3bc0 index:0x0 compound_mapcount: 0
[ 3322.126101] flags: 0x57ffffc0010200(slab|head)
[ 3322.126605] raw: 0057ffffc0010200 ffffea0005824b08 ffffea0005af4008 ffff88807f9e3bc0
[ 3322.127645] raw: 0000000000000000 0000000000140014 00000001ffffffff 0000000000000000
[ 3322.128673] page dumped because: kasan: bad access detected
[ 3322.129333]
[ 3322.129534] Memory state around the buggy address:
[ 3322.130107]  ffff88816457e700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 3322.130953]  ffff88816457e780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 3322.131829] >ffff88816457e800: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 3322.132816]                          ^
[ 3322.133260]  ffff88816457e880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 3322.134091]  ffff88816457e900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fb
[ 3322.134946] ==================================================================


Thanks,
Ming
