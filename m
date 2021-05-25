Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417C0C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 06:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1426F611C9
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 06:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhEYGwO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 02:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231245AbhEYGwM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 02:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621925442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/uKLLvoPMASzMaCOqoTRFfSF6ArvLTKtQYRqsr2y8Kw=;
        b=A3dAGNuza8uWH6yXjk0nELGDGiqF9Hoduar5sElUo4UcRwWl8l+lW9Z+YHU0T+lp7L0ABC
        wQFYjaw94JOoHRj9h+IRztEoFXkR3N00HYhEHWn5D3gZf5xKRE+2KQqacCYoJLFHLuJVEL
        8zMB9wDxKeLUWFLECZiyvVzThRAdm6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-HFWPHP3SPBOUQmKQ3nrdvw-1; Tue, 25 May 2021 02:50:40 -0400
X-MC-Unique: HFWPHP3SPBOUQmKQ3nrdvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE910107ACFB;
        Tue, 25 May 2021 06:50:39 +0000 (UTC)
Received: from T590 (ovpn-13-203.pek2.redhat.com [10.72.13.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0A2A2ED67;
        Tue, 25 May 2021 06:50:32 +0000 (UTC)
Date:   Tue, 25 May 2021 14:50:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org
Cc:     Zhi Li <yieli@redhat.com>
Subject: BUG: KASAN: use-after-free in bfq_get_queue+0x14d3/0x17c0 on 5.13-rc2
Message-ID: <YKyeM59LgoCNgZ5S@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guys

Zhi Li found one use-after-free issue on 5.13-rc2 kernel:

[  534.528049] BUG: KASAN: use-after-free in bfq_get_queue+0x14d3/0x17c0 
[  534.529038] Read of size 8 at addr ffff88801f034cb0 by task yum/11737 
[  534.529948]  
[  534.530181] CPU: 0 PID: 11737 Comm: yum Kdump: loaded Tainted: G               X --------- ---  5.13.0-0.rc2.19.el9.x86_64+debug #1 
[  534.531765] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011 
[  534.532538] Call Trace: 
[  534.532903]  dump_stack+0xa5/0xe6 
[  534.533389]  print_address_description.constprop.0+0x18/0x130 
[  534.534204]  ? bfq_get_queue+0x14d3/0x17c0 
[  534.534770]  __kasan_report.cold+0x7f/0x114 
[  534.535351]  ? bfq_get_queue+0x430/0x17c0 
[  534.535892]  ? bfq_get_queue+0x14d3/0x17c0 
[  534.536443]  kasan_report+0x38/0x50 
[  534.536920]  bfq_get_queue+0x14d3/0x17c0 
[  534.537456]  ? __lock_release+0x494/0xa40 
[  534.538029]  ? bfq_merge_bfqqs+0x1360/0x1360 
[  534.538599]  ? lock_downgrade+0x110/0x110 
[  534.539158]  bfq_get_bfqq_handle_split+0xeb/0x530 
[  534.539799]  bfq_init_rq+0x2f8/0x12c0 
[  534.540422]  ? __lock_acquired+0x1d2/0x8c0 
[  534.540983]  ? bfq_get_bfqq_handle_split+0x530/0x530 
[  534.541641]  ? do_raw_spin_lock+0x270/0x270 
[  534.542213]  ? mark_held_locks+0x71/0xe0 
[  534.542748]  ? bfq_insert_request+0x135/0x860 
[  534.543385]  bfq_insert_request+0x13d/0x860 
[  534.543946]  ? lock_downgrade+0x110/0x110 
[  534.544492]  bfq_insert_requests+0xfb/0x1e0 
[  534.545139]  ? mark_held_locks+0xa5/0xe0 
[  534.545820]  blk_mq_sched_insert_request+0x2be/0x4b0 
[  534.546547]  ? __blk_mq_sched_bio_merge+0x360/0x360 
[  534.547197]  ? update_io_ticks+0xc1/0x140 
[  534.547836]  blk_mq_submit_bio+0xb5c/0x13e0 
[  534.548522]  ? blk_mq_try_issue_list_directly+0x970/0x970 
[  534.549305]  ? dm_submit_bio+0x1ca/0x540 [dm_mod] 
[  534.550009]  ? __submit_bio_noacct+0x2e3/0xa30 
[  534.550628]  __submit_bio_noacct+0x6b0/0xa30 
[  534.551210]  ? rcu_read_lock_sched_held+0x3f/0x70 
[  534.551847]  ? submit_bio_checks+0xc02/0xf30 
[  534.552413]  ? blk_queue_enter+0x850/0x850 
[  534.552968]  ? __pagevec_release+0x1fb/0x3c0 
[  534.553570]  ? submit_bio_noacct+0x15a/0x5d0 
[  534.554142]  submit_bio_noacct+0x15a/0x5d0 
[  534.554693]  ? __submit_bio_noacct+0xa30/0xa30 
[  534.555288]  ? iomap_readpage+0x490/0x490 
[  534.555884]  submit_bio+0xe4/0x4c0 
[  534.556349]  ? submit_bio_noacct+0x5d0/0x5d0 
[  534.556937]  ? lock_downgrade+0x110/0x110 
[  534.557473]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae 
[  534.558192]  ? do_raw_spin_trylock+0xb5/0x180 
[  534.558785]  iomap_submit_ioend+0x110/0x1e0 
[  534.559356]  xfs_vm_writepages+0x11a/0x190 [xfs] 
[  534.560412]  ? xfs_vm_writepage+0x120/0x120 [xfs] 
[  534.561192]  ? mark_held_locks+0xa5/0xe0 
[  534.561753]  do_writepages+0xde/0x260 
[  534.562258]  ? writeback_set_ratelimit+0x120/0x120 
[  534.562903]  ? inode_switch_wbs+0x3dc/0x630 
[  534.563484]  ? inode_switch_wbs+0x41b/0x630 
[  534.564081]  __filemap_fdatawrite_range+0x24c/0x320 
[  534.564752]  ? dax_unlock_entry+0xd0/0xd0 
[  534.565303]  ? delete_from_page_cache_batch+0x430/0x430 
[  534.566029]  filemap_write_and_wait_range+0x50/0xa0 
[  534.566675]  xfs_setattr_size+0x282/0xd40 [xfs] 
[  534.567392]  ? down_write_nested+0x184/0x3b0 
[  534.567972]  ? xfs_setattr_nonsize+0xe90/0xe90 [xfs] 
[  534.568739]  ? setattr_prepare+0xe5/0x620 
[  534.569296]  ? xfs_vn_setattr_size+0x149/0x360 [xfs] 
[  534.570208]  xfs_vn_setattr+0xf7/0x260 [xfs] 
[  534.571002]  ? xfs_vn_setattr_size+0x360/0x360 [xfs] 
[  534.571968]  notify_change+0x76f/0xde0 
[  534.572510]  ? down_read_killable+0xa0/0xa0 
[  534.573114]  ? do_truncate+0xf0/0x1a0 
[  534.573692]  do_truncate+0xf0/0x1a0 
[  534.574294]  ? file_open_root+0x210/0x210 
[  534.574955]  ? rcu_read_unlock+0x40/0x40 
[  534.575481]  ? f_getown+0x210/0x210 
[  534.575989]  do_sys_ftruncate+0x324/0x560 
[  534.576524]  ? trace_hardirqs_on+0x1c/0x160 
[  534.577104]  do_syscall_64+0x40/0x80 
[  534.577593]  entry_SYSCALL_64_after_hwframe+0x44/0xae 
[  534.578269] RIP: 0033:0x7f8b906756eb 
[  534.578755] Code: 77 05 c3 0f 1f 40 00 48 8b 15 81 97 0c 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 4d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 51 97 0c 00 f7 d8 
[  534.581212] RSP: 002b:00007fff3ba27338 EFLAGS: 00000213 ORIG_RAX: 000000000000004d 
[  534.582213] RAX: ffffffffffffffda RBX: 0000563610627538 RCX: 00007f8b906756eb 
[  534.583138] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000039 
[  534.584066] RBP: 00005636102e10f0 R08: 0000000000000000 R09: 00005636106517f8 
[  534.584994] R10: 0000000000001000 R11: 0000000000000213 R12: 0000000000000000 
[  534.585940] R13: 0000000000000039 R14: 0000000000000039 R15: 0000563610627538 
[  534.586911]  
[  534.587129] Allocated by task 11645: 
[  534.587619]  kasan_save_stack+0x1b/0x40 
[  534.588138]  __kasan_slab_alloc+0x61/0x80 
[  534.588672]  kmem_cache_alloc_node+0x187/0x400 
[  534.589269]  bfq_get_queue+0x34e/0x17c0 
[  534.589787]  bfq_get_bfqq_handle_split+0xeb/0x530 
[  534.590416]  bfq_init_rq+0x2f8/0x12c0 
[  534.590934]  bfq_insert_request+0x13d/0x860 
[  534.591512]  bfq_insert_requests+0xfb/0x1e0 
[  534.592081]  blk_mq_sched_insert_request+0x2be/0x4b0 
[  534.592733]  blk_mq_submit_bio+0xb5c/0x13e0 
[  534.593295]  __submit_bio_noacct+0x6b0/0xa30 
[  534.593888]  submit_bio_noacct+0x15a/0x5d0 
[  534.594461]  submit_bio+0xe4/0x4c0 
[  534.594924]  iomap_submit_ioend+0x110/0x1e0 
[  534.595478]  xfs_vm_writepages+0x11a/0x190 [xfs] 
[  534.596264]  do_writepages+0xde/0x260 
[  534.596857]  __filemap_fdatawrite_range+0x24c/0x320 
[  534.597614]  filemap_write_and_wait_range+0x50/0xa0 
[  534.598271]  xfs_setattr_size+0x282/0xd40 [xfs] 
[  534.598988]  xfs_vn_setattr+0xf7/0x260 [xfs] 
[  534.599662]  notify_change+0x76f/0xde0 
[  534.600286]  do_truncate+0xf0/0x1a0 
[  534.600766]  do_sys_ftruncate+0x324/0x560 
[  534.601350]  do_syscall_64+0x40/0x80 
[  534.601948]  entry_SYSCALL_64_after_hwframe+0x44/0xae 
[  534.602764]  
[  534.603007] The buggy address belongs to the object at ffff88801f034ac0 
[  534.603007]  which belongs to the cache bfq_queue of size 560 
[  534.604629] The buggy address is located 496 bytes inside of 
[  534.604629]  560-byte region [ffff88801f034ac0, ffff88801f034cf0) 
[  534.606165] The buggy address belongs to the page: 
[  534.606815] page:00000000c5564cde refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801f034560 pfn:0x1f034 
[  534.608208] head:00000000c5564cde order:2 compound_mapcount:0 compound_pincount:0 
[  534.609185] flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff) 
[  534.610177] raw: 000fffffc0010200 ffffea000411a300 0000000800000008 ffff88810458edc0 
[  534.611192] raw: ffff88801f034560 0000000080170012 00000001ffffffff 0000000000000000 
[  534.612277] page dumped because: kasan: bad access detected 
[  534.613072]  
[  534.613300] Memory state around the buggy address: 
[  534.613986]  ffff88801f034b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[  534.615005]  ffff88801f034c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[  534.616019] >ffff88801f034c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc 
[  534.617034]                                      ^ 
[  534.617717]  ffff88801f034d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 00 00 
[  534.618736]  ffff88801f034d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

Thanks,
Ming

