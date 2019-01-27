Return-Path: <SRS0=IU7b=QD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F95CC282C0
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 08:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF10F217D7
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 08:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXN99LNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfA0IFf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jan 2019 03:05:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50776 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfA0IFf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jan 2019 03:05:35 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so16457088iti.0
        for <linux-block@vger.kernel.org>; Sun, 27 Jan 2019 00:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCY77AgyMtg913WtAFKqGCOgFjFD5Pigpv7Q1WqhQT4=;
        b=cXN99LNH77OSXtUFVs5OaJ5tyB8Wf1jNWy3UmreIwoPtp70rQ93GdJ1GcUvs1REM+X
         KksFXl/y6qs6o9ur7FBHe2jZLe0tGDU+0kGkCJykEEubdBPDS2JOapsUZD5HK59zI/tE
         C2wtU8TQQEx3F1gk3leshlZxLIAxio5E0bXPjj1GqugNd9gZsBwSzMpm3O0Stk0oLg9T
         b7vNeMqm2bfYj8TaAH7BepDI1JZc8UNRluqhc/VaU3Crv1k8u0u29OIUM3zWBbW012uD
         7jUb8OuZ42MWHDrRMzM+pwgx/N2sYW3bj62AATMcw5c05qRUotlweK+IsnQ26hFqkU0Z
         CN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCY77AgyMtg913WtAFKqGCOgFjFD5Pigpv7Q1WqhQT4=;
        b=sY1BwCBFZr7g0+YhMbpC68tT43BPSBuE6ucsOGBoaWjKB7PBwmwy6b1AnnqvY3ojqz
         yU/xl6xkk/ym5AbY1l1diosro2ANMSqkio3cm+9+q8Gr2+XlrvNMyF1BWl4hM8zUX51v
         7uHCYN9gPEJJmTda1I5JdKa9F0NtgPnNQ846Pyuq5gVcLnFprGOnnc8I+L816PFciLcm
         X5lwPQcGaCo1g8gGSGQLChmk3aBd7uVI0pYS5MUq8HOOgBld6QPbNlqDG8LCC6wnPI5r
         bvxJACVO9ujlPPZZbLngpgU+CuV7TL3eUlu54DDxfmoaPhdMK/LtC5NM2IkkeLsnpixt
         jlCg==
X-Gm-Message-State: AJcUukc9bPKxrA8N1EkRlIM++dtuCrxFwDCZX3GDAp8o5OIuoaFa6ubI
        saHJToGJ5wUWxEVGfdYirL+ySA/fq5PrbsjQBww+idtxs+dJvQ==
X-Google-Smtp-Source: ALg8bN4A8qDQkcvDHxDISZCun/ynvSunTxh3ifwiyrb2fco7Z39YUNWDQUb2UaUmvTOl26W//QxqnVE0HgvKpKPGk+o=
X-Received: by 2002:a24:6511:: with SMTP id u17mr7939006itb.12.1548576333455;
 Sun, 27 Jan 2019 00:05:33 -0800 (PST)
MIME-Version: 1.0
References: <00000000000027601e05806bf6be@google.com>
In-Reply-To: <00000000000027601e05806bf6be@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 27 Jan 2019 09:05:22 +0100
Message-ID: <CACT4Y+aH2wo8rdaiZJd7s6Ct3b8mDeuvOj8CsvystV9T10+b-g@mail.gmail.com>
Subject: Re: upstream boot error: can't ssh into the instance (2)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+4df6ca820108fd248943@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 27, 2019 at 9:01 AM syzbot
<syzbot+4df6ca820108fd248943@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    7930851ef10c Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1002c77f400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> dashboard link: https://syzkaller.appspot.com/bug?extid=4df6ca820108fd248943
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4df6ca820108fd248943@syzkaller.appspotmail.com


Mainline tree crashes on boot.
+generic_make_request maintainers

[    7.485069] ==================================================================
[    7.486411] BUG: KASAN: use-after-free in generic_make_request+0x14dd/0x1810
[    7.487539] Read of size 2 at addr ffff8880a39618d4 by task swapper/0/1
[    7.488689]
[    7.488970] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc3+ #45
[    7.490025] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 01/01/2011
[    7.491484] Call Trace:
[    7.491484]  dump_stack+0x1db/0x2d0
[    7.491484]  ? dump_stack_print_info.cold+0x20/0x20
[    7.491484]  ? generic_make_request+0x14dd/0x1810
[    7.491484]  print_address_description.cold+0x7c/0x20d
[    7.491484]  ? generic_make_request+0x14dd/0x1810
[    7.491484]  ? generic_make_request+0x14dd/0x1810
[    7.491484]  kasan_report.cold+0x1b/0x40
[    7.491484]  ? generic_make_request+0x14dd/0x1810
[    7.491484]  __asan_report_load2_noabort+0x14/0x20
[    7.491484]  generic_make_request+0x14dd/0x1810
[    7.491484]  ? rcu_dynticks_curr_cpu_in_eqs+0xa2/0x170
[    7.491484]  ? blk_queue_enter+0x1200/0x1200
[    7.491484]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[    7.491484]  ? check_preemption_disabled+0x48/0x290
[    7.491484]  ? guard_bio_eod+0x1cc/0x630
[    7.491484]  ? find_held_lock+0x35/0x120
[    7.491484]  ? guard_bio_eod+0x1cc/0x630
[    7.491484]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[    7.491484]  submit_bio+0xba/0x480
[    7.491484]  ? submit_bio+0xba/0x480
[    7.491484]  ? rcu_read_unlock_special+0x380/0x380
[    7.491484]  ? generic_make_request+0x1810/0x1810
[    7.491484]  ? __bio_add_page+0x11e/0x280
[    7.491484]  ? __sanitizer_cov_trace_cmp8+0x18/0x20
[    7.491484]  ? guard_bio_eod+0x293/0x630
[    7.491484]  submit_bh_wbc+0x5f7/0x7f0
[    7.491484]  block_read_full_page+0x946/0xfe0
[    7.491484]  ? check_disk_change+0x140/0x140
[    7.491484]  ? __bread_gfp+0x300/0x300
[    7.491484]  ? __inc_numa_state+0x49/0xe0
[    7.491484]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[    7.491484]  ? alloc_page_interleave+0x91/0x1c0
[    7.491484]  ? alloc_pages_current+0x10f/0x210
[    7.491484]  ? __page_cache_alloc+0x19c/0x620
[    7.491484]  ? __filemap_set_wb_err+0x3f0/0x3f0
[    7.491484]  blkdev_readpage+0x1d/0x30
[    7.491484]  do_read_cache_page+0x796/0x16a0
[    7.491484]  ? blkdev_writepages+0x30/0x30
[    7.491484]  ? grab_cache_page_write_begin+0xb0/0xb0
[    7.491484]  ? mark_held_locks+0xb1/0x100
[    7.491484]  ? mark_held_locks+0x100/0x100
[    7.491484]  ? depot_save_stack+0x1de/0x460
[    7.491484]  ? trace_hardirqs_off_caller+0x300/0x300
[    7.491484]  ? do_raw_spin_trylock+0x270/0x270
[    7.491484]  ? __lock_is_held+0xb6/0x140
[    7.491484]  ? add_lock_to_list.isra.0+0x450/0x450
[    7.491484]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[    7.491484]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[    7.491484]  ? check_preemption_disabled+0x48/0x290
[    7.491484]  ? add_lock_to_list.isra.0+0x450/0x450
[    7.491484]  ? __lock_is_held+0xb6/0x140
[    7.491484]  ? __sanitizer_cov_trace_cmp4+0x16/0x20
[    7.491484]  ? widen_string+0xe0/0x2e0
[    7.491484]  ? blkdev_writepages+0x30/0x30
[    7.491484]  read_cache_page+0x5e/0x70
[    7.491484]  read_dev_sector+0x12c/0x510
[    7.491484]  ? __delete_partition+0x210/0x210
[    7.491484]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20
[    7.491484]  ? format_decode+0x227/0xb00
[    7.491484]  ? enable_ptr_key_workfn+0x30/0x30
[    7.491484]  ? adfspart_check_ADFS+0x9c0/0x9c0
[    7.491484]  adfspart_check_ICS+0x153/0xfb0
[    7.491484]  ? memcpy+0x46/0x50
[    7.491484]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[    7.491484]  ? adfspart_check_ADFS+0x9c0/0x9c0
[    7.491484]  ? pointer+0x930/0x930
[    7.491484]  ? snprintf+0xbb/0xf0
[    7.491484]  ? vsprintf+0x40/0x40
[    7.491484]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[    7.491484]  ? adfspart_check_ADFS+0x9c0/0x9c0
[    7.491484]  check_partition+0x3be/0x6d0
[    7.491484]  ? __sanitizer_cov_trace_cmp8+0x18/0x20
[    7.491484]  rescan_partitions+0x187/0x970
[    7.491484]  ? up_write+0x7b/0x230
[    7.491484]  ? set_init_blocksize+0x1ac/0x260
[    7.491484]  __blkdev_get+0xda1/0x1560
[    7.491484]  ? blkdev_get_block+0xc0/0xc0
[    7.491484]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[    7.491484]  blkdev_get+0xc1/0xae0
[    7.491484]  ? unlock_new_inode+0xfa/0x140
[    7.491484]  ? bdget+0xfe/0x600
[    7.491484]  ? bdget+0x600/0x600
[    7.491484]  ? refcount_dec_and_test_checked+0x1b/0x20
[    7.491484]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20
[    7.491484]  ? kobject_put+0x84/0xe0
[    7.491484]  ? put_device+0x25/0x30
[    7.491484]  __device_add_disk+0xe5e/0x13c0
[    7.491484]  ? blk_alloc_devt+0x2e0/0x2e0
[    7.491484]  ? sprintf+0xc0/0x100
[    7.491484]  ? scnprintf+0x140/0x140
[    7.491484]  ? disk_expand_part_tbl+0x3d0/0x3d0
[    7.491484]  ? lockdep_init_map+0x10c/0x5b0
[    7.491484]  device_add_disk+0x2b/0x40
[    7.491484]  brd_init+0x2e9/0x3fa
[    7.491484]  ? ramdisk_size+0x2a/0x2a
[    7.491484]  ? ramdisk_size+0x2a/0x2a
[    7.491484]  ? ramdisk_size+0x2a/0x2a
[    7.491484]  do_one_initcall+0x129/0x937
[    7.491484]  ? perf_trace_initcall_level+0x750/0x750
[    7.491484]  ? rcu_read_lock_sched_held+0x110/0x130
[    7.491484]  ? trace_initcall_level+0x2d5/0x321
[    7.491484]  ? arch_local_irq_restore+0x56/0x56
[    7.491484]  ? down_write_nested+0x130/0x130
[    7.491484]  ? down_read+0x120/0x120
[    7.491484]  ? kasan_unpoison_shadow+0x35/0x50
[    7.491484]  kernel_init_freeable+0x4d5/0x5c4
[    7.491484]  ? rest_init+0x37b/0x37b
[    7.491484]  kernel_init+0x12/0x1c5
[    7.491484]  ret_from_fork+0x3a/0x50
[    7.491484]
[    7.491484] Allocated by task 1:
[    7.491484]  save_stack+0x45/0xd0
[    7.491484]  __kasan_kmalloc.constprop.0+0xcf/0xe0
[    7.491484]  kasan_slab_alloc+0xf/0x20
[    7.491484]  kmem_cache_alloc+0x12d/0x710
[    7.491484]  mempool_alloc_slab+0x47/0x60
[    7.491484]  mempool_alloc+0x19f/0x500
[    7.491484]  bio_alloc_bioset+0x3c1/0x720
[    7.491484]  submit_bh_wbc+0x133/0x7f0
[    7.491484]  block_read_full_page+0x946/0xfe0
[    7.491484]  blkdev_readpage+0x1d/0x30
[    7.491484]  do_read_cache_page+0x796/0x16a0
[    7.491484]  read_cache_page+0x5e/0x70
[    7.491484]  read_dev_sector+0x12c/0x510
[    7.491484]  adfspart_check_ICS+0x153/0xfb0
[    7.491484]  check_partition+0x3be/0x6d0
[    7.491484]  rescan_partitions+0x187/0x970
[    7.491484]  __blkdev_get+0xda1/0x1560
[    7.491484]  blkdev_get+0xc1/0xae0
[    7.491484]  __device_add_disk+0xe5e/0x13c0
[    7.491484]  device_add_disk+0x2b/0x40
[    7.491484]  brd_init+0x2e9/0x3fa
[    7.491484]  do_one_initcall+0x129/0x937
[    7.491484]  kernel_init_freeable+0x4d5/0x5c4
[    7.491484]  kernel_init+0x12/0x1c5
[    7.491484]  ret_from_fork+0x3a/0x50
[    7.491484]
[    7.491484] Freed by task 1:
[    7.491484]  save_stack+0x45/0xd0
[    7.491484]  __kasan_slab_free+0x102/0x150
[    7.491484]  kasan_slab_free+0xe/0x10
[    7.491484]  kmem_cache_free+0x86/0x260
[    7.491484]  mempool_free_slab+0x1e/0x30
[    7.491484]  mempool_free+0xed/0x380
[    7.491484]  bio_free+0x324/0x570
[    7.491484]  bio_put+0x17a/0x1f0
[    7.491484]  end_bio_bh_io_sync+0xfb/0x140
[    7.491484]  bio_endio+0x840/0xfb0
[    7.491484]  brd_make_request+0x686/0x95a
[    7.491484]  generic_make_request+0x92b/0x1810
[    7.491484]  submit_bio+0xba/0x480
[    7.491484]  submit_bh_wbc+0x5f7/0x7f0
[    7.491484]  block_read_full_page+0x946/0xfe0
[    7.491484]  blkdev_readpage+0x1d/0x30
[    7.491484]  do_read_cache_page+0x796/0x16a0
[    7.491484]  read_cache_page+0x5e/0x70
[    7.491484]  read_dev_sector+0x12c/0x510
[    7.491484]  adfspart_check_ICS+0x153/0xfb0
[    7.491484]  check_partition+0x3be/0x6d0
[    7.491484]  rescan_partitions+0x187/0x970
[    7.491484]  __blkdev_get+0xda1/0x1560
[    7.491484]  blkdev_get+0xc1/0xae0
[    7.491484]  __device_add_disk+0xe5e/0x13c0
[    7.491484]  device_add_disk+0x2b/0x40
[    7.491484]  brd_init+0x2e9/0x3fa
[    7.491484]  do_one_initcall+0x129/0x937
[    7.491484]  kernel_init_freeable+0x4d5/0x5c4
[    7.491484]  kernel_init+0x12/0x1c5
[    7.491484]  ret_from_fork+0x3a/0x50
[    7.491484]
[    7.491484] The buggy address belongs to the object at ffff8880a39618c0
[    7.491484]  which belongs to the cache bio-0 of size 200
[    7.491484] The buggy address is located 20 bytes inside of
[    7.491484]  200-byte region [ffff8880a39618c0, ffff8880a3961988)
[    7.491484] The buggy address belongs to the page:
[    7.491484] page:ffffea00028e5840 count:1 mapcount:0
mapping:ffff88821bb1ea80 index:0x0
[    7.491484] flags: 0x1fffc0000000200(slab)
[    7.491484] raw: 01fffc0000000200 ffffea00028e8008 ffff88812c3cf648
ffff88821bb1ea80
[    7.491484] raw: 0000000000000000 ffff8880a3961000 000000010000000c
0000000000000000
[    7.491484] page dumped because: kasan: bad access detected
[    7.491484]
[    7.491484] Memory state around the buggy address:
[    7.491484]  ffff8880a3961780: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[    7.491484]  ffff8880a3961800: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[    7.491484] >ffff8880a3961880: fc fc fc fc fc fc fc fc fb fb fb fb
fb fb fb fb
[    7.491484]                                                  ^
[    7.491484]  ffff8880a3961900: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    7.491484]  ffff8880a3961980: fb fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[    7.491484] ==================================================================


> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000027601e05806bf6be%40google.com.
> For more options, visit https://groups.google.com/d/optout.
