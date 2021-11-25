Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8CFC433FE
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 17:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbhKYRdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 12:33:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43016 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349032AbhKYRbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 12:31:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B605021B36;
        Thu, 25 Nov 2021 17:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637861292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=SRSWNOybIz2djdAipHwdkAzI7zhQKoBLKmWr9LG0YNI=;
        b=Wph24O859Lnygj4J+2LyYE8tlm7p0FQbPeVbz7plxa5LG6atdlVqcsJEBGyADpLbPuG0dx
        HWcHhYbib5cYeS9AO48ozcieOpzNQ9VTfskjtD9ctO3ccbyhNszuQKtyk0uTXvGsBroARA
        A3TX/mYYsR2f8PlJgBXFyByYJSydX3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637861292;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=SRSWNOybIz2djdAipHwdkAzI7zhQKoBLKmWr9LG0YNI=;
        b=ri79cc4927KhoPApBPyP0i1Kl9gB5Q64mlStEXVMUgCYvB+GjY+PSpQlaaDhMTYHi/BmFO
        knzHHr3Ircj2JJBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A40F4A3B94;
        Thu, 25 Nov 2021 17:28:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7FAFD1E14EF; Thu, 25 Nov 2021 18:28:09 +0100 (CET)
Date:   Thu, 25 Nov 2021 18:28:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, fvogdt@suse.de
Subject: Use after free with BFQ and cgroups
Message-ID: <20211125172809.GC19572@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

Our test VMs started crashing recently (seems to be starting with 5.15
kernel). When we enabled KASAN, we were getting reports of bfq_group being
used after being freed like following (the reports differ a bit in where
exactly did BFQ hit the UAF):

[  235.949241] ==================================================================
[  235.950326] BUG: KASAN: use-after-free in __bfq_deactivate_entity+0x9cb/0xa50
[  235.951369] Read of size 8 at addr ffff88800693c0c0 by task runc:[2:INIT]/10544

[  235.953476] CPU: 0 PID: 10544 Comm: runc:[2:INIT] Tainted: G            E     5.15.2-0.g5fb85fd-default #1 openSUSE Tumbleweed (unreleased) f1f3b891c72369aebecd2e43e4641a6358867c70
[  235.955726] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[  235.958007] Call Trace:
[  235.959157]  <IRQ>
[  235.960287]  dump_stack_lvl+0x46/0x5a
[  235.961412]  print_address_description.constprop.0+0x1f/0x140
[  235.962556]  ? __bfq_deactivate_entity+0x9cb/0xa50
[  235.963707]  kasan_report.cold+0x7f/0x11b
[  235.964841]  ? __bfq_deactivate_entity+0x9cb/0xa50
[  235.965970]  __bfq_deactivate_entity+0x9cb/0xa50
[  235.967092]  ? update_curr+0x32f/0x5d0
[  235.968227]  bfq_deactivate_entity+0xa0/0x1d0
[  235.969365]  bfq_del_bfqq_busy+0x28a/0x420
[  235.970481]  ? resched_curr+0x116/0x1d0
[  235.971573]  ? bfq_requeue_bfqq+0x70/0x70
[  235.972657]  ? check_preempt_wakeup+0x52b/0xbc0
[  235.973748]  __bfq_bfqq_expire+0x1a2/0x270
[  235.974822]  bfq_bfqq_expire+0xd16/0x2160
[  235.975893]  ? try_to_wake_up+0x4ee/0x1260
[  235.976965]  ? bfq_end_wr_async_queues+0xe0/0xe0
[  235.978039]  ? _raw_write_unlock_bh+0x60/0x60
[  235.979105]  ? _raw_spin_lock_irq+0x81/0xe0
[  235.980162]  bfq_idle_slice_timer+0x109/0x280
[  235.981199]  ? bfq_dispatch_request+0x4870/0x4870
[  235.982220]  __hrtimer_run_queues+0x37d/0x700
[  235.983242]  ? enqueue_hrtimer+0x1b0/0x1b0
[  235.984278]  ? kvm_clock_get_cycles+0xd/0x10
[  235.985301]  ? ktime_get_update_offsets_now+0x6f/0x280
[  235.986317]  hrtimer_interrupt+0x2c8/0x740
[  235.987321]  __sysvec_apic_timer_interrupt+0xcd/0x260
[  235.988357]  sysvec_apic_timer_interrupt+0x6a/0x90
[  235.989373]  </IRQ>
[  235.990355]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  235.991366] RIP: 0010:do_seccomp+0x4f5/0x1f40
[  235.992376] Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cb 14 00 00 48 8b bd d8 0b 00 00 c6 07 00 0f 1f 40 00 fb 66 0f 1f 44 00 00 <8b> 4c 24 30 85 c9 0f 85 06 07 00 00 8b 54 24 04 85 d2 74 19 4d 85
[  235.994481] RSP: 0018:ffffc900020cfd48 EFLAGS: 00000246
[  235.995546] RAX: dffffc0000000000 RBX: 1ffff92000419fb1 RCX: ffffffffb9a8d89d
[  235.996638] RDX: 1ffff1100080f17b RSI: 0000000000000008 RDI: ffff888008c56040
[  235.997717] RBP: ffff888004078000 R08: 0000000000000001 R09: ffff88800407800f
[  235.998784] R10: ffffed100080f001 R11: 0000000000000001 R12: 00000000ffffffff
[  235.999852] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  236.000906]  ? do_seccomp+0xfed/0x1f40
[  236.001937]  ? do_seccomp+0xfed/0x1f40
[  236.002938]  ? get_nth_filter+0x2e0/0x2e0
[  236.003932]  ? security_task_prctl+0x66/0xd0
[  236.004910]  __do_sys_prctl+0x420/0xd60
[  236.005842]  ? handle_mm_fault+0x196/0x610
[  236.006739]  ? __ia32_compat_sys_getrusage+0x90/0x90
[  236.007611]  ? up_read+0x15/0x90
[  236.008477]  do_syscall_64+0x5c/0x80
[  236.009349]  ? exc_page_fault+0x60/0xc0
[  236.010219]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  236.011094] RIP: 0033:0x561fa9ceec6a
[  236.011976] Code: e8 db 46 f8 ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
[  236.013823] RSP: 002b:000000c000116e38 EFLAGS: 00000216 ORIG_RAX: 000000000000009d
[  236.014778] RAX: ffffffffffffffda RBX: 000000c000028000 RCX: 0000561fa9ceec6a
[  236.015748] RDX: 000000c000116ee0 RSI: 0000000000000002 RDI: 0000000000000016
[  236.016716] RBP: 000000c000116e90 R08: 0000000000000000 R09: 0000000000000000
[  236.017685] R10: 0000000000000000 R11: 0000000000000216 R12: 00000000000000b8
[  236.018645] R13: 00000000000000b7 R14: 0000000000000200 R15: 0000000000000004

[  236.020558] Allocated by task 485:
[  236.021511]  kasan_save_stack+0x1b/0x40
[  236.022460]  __kasan_kmalloc+0xa4/0xd0
[  236.023410]  bfq_pd_alloc+0xa8/0x170
[  236.024351]  blkg_alloc+0x397/0x540
[  236.025287]  blkg_create+0x66b/0xcd0
[  236.026219]  bio_associate_blkg_from_css+0x43c/0xb20
[  236.027161]  bio_associate_blkg+0x66/0x100
[  236.028098]  submit_extent_page+0x744/0x1380 [btrfs]
[  236.029126]  __extent_writepage_io+0x605/0xaa0 [btrfs]
[  236.030113]  __extent_writepage+0x360/0x740 [btrfs]
[  236.031093]  extent_write_cache_pages+0x5a7/0xa50 [btrfs]
[  236.032084]  extent_writepages+0xcb/0x1a0 [btrfs]
[  236.033063]  do_writepages+0x188/0x720
[  236.033997]  filemap_fdatawrite_wbc+0x19f/0x2b0
[  236.034929]  filemap_fdatawrite_range+0x99/0xd0
[  236.035855]  btrfs_fdatawrite_range+0x46/0xf0 [btrfs]
[  236.036833]  start_ordered_ops.constprop.0+0xb6/0x110 [btrfs]
[  236.037803]  btrfs_sync_file+0x1bf/0xe70 [btrfs]
[  236.038747]  __x64_sys_fsync+0x51/0x80
[  236.039622]  do_syscall_64+0x5c/0x80
[  236.040468]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[  236.042137] Freed by task 10561:
[  236.042966]  kasan_save_stack+0x1b/0x40
[  236.043802]  kasan_set_track+0x1c/0x30
[  236.044628]  kasan_set_free_info+0x20/0x30
[  236.045437]  __kasan_slab_free+0x10b/0x140
[  236.046256]  slab_free_freelist_hook+0x8e/0x180
[  236.047081]  kfree+0xc7/0x400
[  236.047907]  blkg_free.part.0+0x78/0xf0
[  236.048736]  rcu_do_batch+0x365/0x1280
[  236.049558]  rcu_core+0x493/0x8d0
[  236.050376]  __do_softirq+0x18e/0x544

After some poking, looking into crashdumps, and applying some debug patches
the following seems to be happening: We have a process P in blkcg G. Now
G is taken offline so bfq_group is cleaned up in bfq_pd_offline() but P
still holds reference to G from its bfq_queue. Then P submits IO, G gets
inserted into service tree despite being already offline. IO completes, P
exits, bfq_queue pointing to G gets destroyed, the last reference to G is
dropped, G gets freed although is it still inserted in the service tree.
Eventually someone trips over the freed memory.

Now I was looking into how to best fix this. There are several
possibilities and I'm not sure which one to pick so that's why I'm writing
to you. bfq_pd_offline() is walking all entities in service trees and
trying to get rid of references to bfq_group (by reparenting entities).
Is this guaranteed to see all entities that point to G? From the scenario
I'm observing it seems this can miss entities pointing to G - e.g. if they
are in idle tree, we will just remove them from the idle tree but we won't
change entity->parent so they still point to G. This can be seen as one
culprit of the bug.

Or alternatively, should we e.g. add __bfq_deactivate_entity() to
bfq_put_queue() when that function is dropping last queue in a bfq_group?

Or should we just reparent bfq queues that have already dead parent on
activation?

What's your opinion?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
