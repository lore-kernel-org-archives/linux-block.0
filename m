Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD55BC4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 22:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFFC6115B
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 22:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhHTW7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 18:59:03 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:37591 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbhHTW66 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 18:58:58 -0400
Received: by mail-pj1-f50.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so2033436pjw.2
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 15:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UfKd+5O3rTH7iX1wDFLYofcQCOoKDKQpuaDVSdIq6Yw=;
        b=CMzwnSxkpe65sVO8/kn8N4iRTuM7SGDwufGnTgqMG2jSNMRMIoEb/chvmgjQU0Vtgm
         xe2ENm3Bh7rr9EFIGDUxOcKIRgdzvXe14Hp5DpDbMEgiyLpDsgZ2HEM6LY57m+hucMzv
         cpDszJJxQ0kdxE3TmXN5s6srE3UcHMLyzxXercQ7Adu8HVoc9aSTxt0vldDH1Vt9vJGS
         TsjkNX6scDbfYtmLt2fQ3+CXQ3WPDGqdDOZGu17M5OaYp+Zz2b2Wx3w/JKGlFSE675My
         fyU41sE5gG1jf2hKV8qmqiR2wR3EDiqfehgQRmsetf3+6JYT3VrO/9qX4LGsWBjxMLfg
         H6fw==
X-Gm-Message-State: AOAM531bzlYPVRIOK+h5bh6+/f9QZba/QvgACp2CQH6vTQ4EDFantsl/
        7BtJjF16tt+rICPLZwaBa0iKt5xoN14=
X-Google-Smtp-Source: ABdhPJzv1gaPO+fscrZXoM5ZiC4Q1hczhtyM5Tkc0PCtwXOseGLHK7opeX64dzDsqWA9P29u7/Qotg==
X-Received: by 2002:a17:90a:bb8c:: with SMTP id v12mr7019596pjr.72.1629500299681;
        Fri, 20 Aug 2021 15:58:19 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ddfe:8579:6783:9ed8])
        by smtp.gmail.com with ESMTPSA id o18sm11510745pjp.1.2021.08.20.15.58.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 15:58:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: slab-out-of-bounds access in bio_integrity_alloc()
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <4b6318fb-0008-1747-64d5-b31991324acf@acm.org>
Date:   Fri, 20 Aug 2021 15:58:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

It's been a while since I ran blktests. If I run it against Jens' for-next
branch (39916d4054e7 ("Merge branch 'for-5.15/io_uring' into for-next")) a
slab-out-of-bounds access complaint appears. Is anyone already looking into
this?

Thanks,

Bart.

root[18522]: run blktests srp/001
kernel: null_blk: module loaded
multipathd[18578]: --------start up--------
multipathd[18578]: read /etc/multipath.conf
kernel: rdma_rxe: loaded
multipathd[18578]: failed to increase buffer size
multipathd[18578]: path checkers start up
kernel: enp1s0 speed is unknown, defaulting to 1000
kernel: enp1s0 speed is unknown, defaulting to 1000
kernel: enp1s0 speed is unknown, defaulting to 1000
kernel: infiniband enp1s0_rxe: set active
kernel: enp1s0 speed is unknown, defaulting to 1000
kernel: infiniband enp1s0_rxe: added enp1s0
systemd[1]: Created slice Slice /system/rdma-load-modules.
systemd[1]: Starting Load RDMA modules from /etc/rdma/modules/rdma.conf...
kernel: scsi_debug:sdebug_add_store: dif_storep 524288 bytes @ ffffc900009fc000
kernel: scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
kernel: scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
kernel: scsi host6: scsi_debug: version 0190 [20200710]
                                       dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
kernel: scsi 6:0:0:0: Direct-Access     Linux    scsi_debug       0190 PQ: 0 ANSI: 7
kernel: sd 6:0:0:0: Power-on or device reset occurred
kernel: sd 6:0:0:0: Attached scsi generic sg1 type 0
kernel: sd 6:0:0:0: [sda] Enabling DIF Type 3 protection
kernel: sd 6:0:0:0: [sda] 65536 512-byte logical blocks: (33.6 MB/32.0 MiB)
kernel: Loading iSCSI transport class v2.0-870.
kernel: sd 6:0:0:0: [sda] Write Protect is off
kernel: sd 6:0:0:0: [sda] Mode Sense: 73 00 10 08
kernel: sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
kernel: sd 6:0:0:0: [sda] Optimal transfer size 524288 bytes
systemd-modules-load[18598]: Inserted module 'ib_iser'
kernel: iscsi: registered transport (iser)
systemd-modules-load[18598]: Inserted module 'rdma_ucm'
systemd-modules-load[18598]: Failed to find module 'xprtrdma'
systemd-modules-load[18598]: Failed to find module 'svcrdma'
systemd[1]: Finished Load RDMA modules from /etc/rdma/modules/rdma.conf.
systemd[1]: Reached target RDMA Hardware.
kernel: sd 6:0:0:0: [sda] Enabling DIX T10-DIF-TYPE3-CRC protection
kernel: sd 6:0:0:0: [sda] DIF application tag size 6
kernel: sd 6:0:0:0: [sda] Attached SCSI disk
kernel: enp1s0 speed is unknown, defaulting to 1000
kernel: Rounding down aligned max_sectors from 4294967295 to 4294967288
kernel: ib_srpt:srpt_add_one: ib_srpt device = 000000001ddc3fdc
kernel: ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(enp1s0_rxe): use_srq = 0; ret = 0
kernel: ib_srpt:srpt_add_one: ib_srpt Target login info: id_ext=505400fffe867464,ioc_guid=505400fffe867464,pkey=ffff,service_id=505400fffe867464
kernel: enp1s0 speed is unknown, defaulting to 1000
kernel: ib_srpt:srpt_add_one: ib_srpt added enp1s0_rxe.
kernel: ==================================================================
kernel: BUG: KASAN: slab-out-of-bounds in bio_integrity_alloc+0x53/0x1c0
kernel: Read of size 8 at addr ffff8881a9dcf8c0 by task dd/18670
kernel:
kernel: CPU: 14 PID: 18670 Comm: dd Tainted: G            E     5.14.0-rc5-dbg+ #25
kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
kernel: Call Trace:
kernel:  show_stack+0x52/0x58
kernel:  dump_stack_lvl+0x49/0x5e
kernel:  print_address_description.constprop.0+0x24/0x150
kernel:  ? bio_integrity_alloc+0x53/0x1c0
kernel:  kasan_report.cold+0x82/0xdb
kernel:  ? bio_integrity_alloc+0x53/0x1c0
kernel:  __asan_load8+0x69/0x90
kernel:  bio_integrity_alloc+0x53/0x1c0
kernel:  bio_integrity_prep+0x1a4/0x3e0
kernel:  ? __lock_release+0x142/0x270
kernel:  blk_mq_submit_bio+0x151/0xa80
kernel:  ? blk_queue_enter+0x62a/0x720
kernel:  ? blk_mq_try_issue_list_directly+0x4b0/0x4b0
kernel:  ? blk_queue_enter+0x642/0x720
kernel:  ? bio_release_pages+0x40/0x40
kernel:  submit_bio_noacct+0x236/0x310
kernel:  ? __submit_bio_noacct+0x5d0/0x5d0
kernel:  ? __this_cpu_preempt_check+0x13/0x20
kernel:  submit_bio+0x9c/0x210
kernel:  ? submit_bio_noacct+0x310/0x310
kernel:  ? lock_release+0xbd/0x1e0
kernel:  __blkdev_direct_IO_simple+0x307/0x4d0
kernel:  ? blkdev_bio_end_io+0x1e0/0x1e0
kernel:  ? ktime_get_coarse_real_ts64+0xf7/0x100
kernel:  ? __this_cpu_preempt_check+0x13/0x20
kernel:  ? __this_cpu_preempt_check+0x13/0x20
kernel:  ? blkdev_get_whole+0x130/0x130
kernel:  ? __kasan_check_read+0x11/0x20
kernel:  blkdev_direct_IO+0xa4/0xb0
kernel:  generic_file_direct_write+0x10d/0x2a0
kernel:  __generic_file_write_iter+0x120/0x2b0
kernel:  blkdev_write_iter+0x172/0x280
kernel:  ? block_ioctl+0xa0/0xa0
kernel:  ? __this_cpu_preempt_check+0x13/0x20
kernel:  ? iov_iter_init+0x70/0x90
kernel:  new_sync_write+0x287/0x390
kernel:  ? new_sync_read+0x380/0x380
kernel:  ? __fsnotify_parent+0x3a9/0x4c0
kernel:  ? rw_verify_area+0x9e/0x140
kernel:  vfs_write+0x3b1/0x4f0
kernel:  ksys_write+0xbd/0x150
kernel:  ? __ia32_sys_read+0x50/0x50
kernel:  ? __this_cpu_preempt_check+0x13/0x20
kernel:  ? lockdep_hardirqs_on+0x7e/0x100
kernel:  ? syscall_enter_from_user_mode+0x25/0x80
kernel:  __x64_sys_write+0x42/0x50
kernel:  do_syscall_64+0x35/0xb0
kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
kernel: RIP: 0033:0x7f3cd07d1367
kernel: Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
kernel: RSP: 002b:00007ffe6dde70b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
kernel: RAX: ffffffffffffffda RBX: 0000000000100000 RCX: 00007f3cd07d1367
kernel: RDX: 0000000000100000 RSI: 00007f3cd0306000 RDI: 0000000000000001
kernel: RBP: 00007f3cd0306000 R08: 00007f3cd0306000 R09: 0000000000000000
kernel: R10: 00007f3cd06f5138 R11: 0000000000000246 R12: 0000000000000000
kernel: R13: 0000000000000000 R14: 0000000000000020 R15: 00007f3cd0306000
kernel:
kernel: Allocated by task 5444:
kernel:  kasan_save_stack+0x23/0x50
kernel:  __kasan_slab_alloc+0x68/0x80
kernel:  kmem_cache_alloc+0x144/0x380
kernel:  bdev_alloc_inode+0x1a/0x40
kernel:  alloc_inode+0x34/0x100
kernel:  new_inode+0x22/0x160
kernel:  bdev_alloc+0x22/0x160
kernel:  __alloc_disk_node+0x8a/0x2a0
kernel:  sd_probe+0xb3/0x6b0
kernel:  really_probe+0x32d/0x5f0
kernel:  __driver_probe_device+0x145/0x1e0
kernel:  driver_probe_device+0x4e/0x110
kernel:  __device_attach_driver+0xf6/0x160
kernel:  bus_for_each_drv+0xe6/0x130
kernel:  __device_attach_async_helper+0xf5/0x120
kernel:  async_run_entry_fn+0x63/0x240
kernel:  process_one_work+0x56a/0xab0
kernel:  worker_thread+0x2e7/0x700
kernel:  kthread+0x1f6/0x220
kernel:  ret_from_fork+0x1f/0x30
kernel:
kernel: The buggy address belongs to the object at ffff8881a9dcef00
                                      which belongs to the cache bdev_cache of size 2184
kernel: The buggy address is located 312 bytes to the right of
                                      2184-byte region [ffff8881a9dcef00, ffff8881a9dcf788)
kernel: The buggy address belongs to the page:
kernel: page:00000000c0f25dd8 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8881a9dcd340 pfn:0x1a9dc8
kernel: head:00000000c0f25dd8 order:3 compound_mapcount:0 compound_pincount:0
kernel: memcg:ffff888190302401
kernel: flags: 0x1000000000010200(slab|head|node=0|zone=2)
kernel: raw: 1000000000010200 0000000000000000 dead000000000122 ffff888100053340
kernel: raw: ffff8881a9dcd340 00000000800d0003 00000001ffffffff ffff888190302401
kernel: page dumped because: kasan: bad access detected
kernel:
kernel: Memory state around the buggy address:
kernel:  ffff8881a9dcf780: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
kernel:  ffff8881a9dcf800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
kernel: >ffff8881a9dcf880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
kernel:                                            ^
kernel:  ffff8881a9dcf900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
kernel:  ffff8881a9dcf980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
kernel: ==================================================================


(gdb) disas /s bio_integrity_alloc
Dump of assembler code for function bio_integrity_alloc:
block/bio-integrity.c:
51      {
    0xffffffff81833170 <+0>:     call   0xffffffff810a1630 <__fentry__>

52              struct bio_integrity_payload *bip;
53              struct bio_set *bs = bio->bi_pool;
    0xffffffff81833175 <+5>:     push   %rbp
    0xffffffff81833176 <+6>:     mov    %rsp,%rbp
    0xffffffff81833179 <+9>:     push   %r15
    0xffffffff8183317b <+11>:    mov    %esi,%r15d
    0xffffffff8183317e <+14>:    push   %r14
    0xffffffff81833180 <+16>:    push   %r13
    0xffffffff81833182 <+18>:    mov    %edx,%r13d
    0xffffffff81833185 <+21>:    push   %r12
    0xffffffff81833187 <+23>:    push   %rbx
    0xffffffff81833188 <+24>:    mov    %rdi,%rbx
    0xffffffff8183318b <+27>:    add    $0x78,%rdi

51      {
    0xffffffff8183318f <+31>:    sub    $0x18,%rsp

52              struct bio_integrity_payload *bip;
53              struct bio_set *bs = bio->bi_pool;
    0xffffffff81833193 <+35>:    call   0xffffffff814ccdf0 <__asan_load8>
    0xffffffff81833198 <+40>:    mov    0x78(%rbx),%r14

54              unsigned inline_vecs;
55
56              if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
57                      return ERR_PTR(-EOPNOTSUPP);
58
59              if (!bs || !mempool_initialized(&bs->bio_integrity_pool)) {
    0xffffffff8183319c <+44>:    test   %r14,%r14
    0xffffffff8183319f <+47>:    je     0xffffffff8183327b <bio_integrity_alloc+267>

./include/linux/mempool.h:
30              return pool->elements != NULL;
    0xffffffff818331a5 <+53>:    lea    0x1d0(%r14),%rax
    0xffffffff818331ac <+60>:    lea    0x188(%r14),%r12
    0xffffffff818331b3 <+67>:    mov    %rax,%rdi
    0xffffffff818331b6 <+70>:    mov    %rax,-0x30(%rbp)
    0xffffffff818331ba <+74>:    mov    %r12,-0x38(%rbp)
    0xffffffff818331be <+78>:    call   0xffffffff814ccdf0 <__asan_load8>

block/bio-integrity.c:
59              if (!bs || !mempool_initialized(&bs->bio_integrity_pool)) {
    0xffffffff818331c3 <+83>:    cmpq   $0x0,0x1d0(%r14)
    0xffffffff818331cb <+91>:    je     0xffffffff8183327b <bio_integrity_alloc+267>

60                      bip = kmalloc(struct_size(bip, bip_inline_vecs, nr_vecs), gfp_mask);
61                      inline_vecs = nr_vecs;
62              } else {
63                      bip = mempool_alloc(&bs->bio_integrity_pool, gfp_mask);
    0xffffffff818331d1 <+97>:    mov    %r12,%rdi
    0xffffffff818331d4 <+100>:   mov    %r15d,%esi
    0xffffffff818331d7 <+103>:   call   0xffffffff813db3f0 <mempool_alloc>

64                      inline_vecs = BIO_INLINE_VECS;
65              }
66
67              if (unlikely(!bip))
    0xffffffff818331dc <+108>:   test   %rax,%rax

63                      bip = mempool_alloc(&bs->bio_integrity_pool, gfp_mask);
    0xffffffff818331df <+111>:   mov    %rax,%r12

64                      inline_vecs = BIO_INLINE_VECS;
65              }
66
