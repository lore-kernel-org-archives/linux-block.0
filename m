Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E79AC4338F
	for <linux-block@archiver.kernel.org>; Sun, 22 Aug 2021 03:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9386128C
	for <linux-block@archiver.kernel.org>; Sun, 22 Aug 2021 03:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhHVDMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Aug 2021 23:12:51 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:37864 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhHVDMt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Aug 2021 23:12:49 -0400
Received: by mail-pl1-f179.google.com with SMTP id n12so8202718plf.4
        for <linux-block@vger.kernel.org>; Sat, 21 Aug 2021 20:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qMCpuWaEfNTQUh5eND1Sa7DeXSQ2On1WwMKMv4ql/AU=;
        b=uEAtFcG/1bxlPdvibRMltQ5TVGC9qat7TRh0riFB0NLB67VzUCweIov0ikp24BLKYX
         6MNX+2MpgoppqwX7yl5b10FSah6PTYwg1i2suwnhBgaNkRrdhmIgQOuutJnNGDpLEdMO
         Scy13juAdADIqAjVkVsrNdv4ALkeFkKFTJHNXTduiq3eD4LxDz7IJRlBxldcVu8JaLYj
         UL4GKHzkU8RTozfD0LERFIwG1Hhe1cJr6jCA/ovH9UhmTCeX+ECBudbhSskUPuKEui0w
         u8TJewrlnxX35OBIaFhdlXSWPgwQ+ywLGW3IpYyGPQxgXrZ1dHMzTidweIACTsk4i2Ud
         vKHQ==
X-Gm-Message-State: AOAM533w5mrET+AXG4adVBzyhZcN5L1ik4GfFF5teYYiXtID56QZ7+GA
        s4rANV71FSOOqQDk/r8PbBQ5yexShxc=
X-Google-Smtp-Source: ABdhPJyPTkZ6wwQJrONGqAr9A7kfGALtIJTa/bezSizxnr+fL8V1LUnT42f+NyTdAYC/ZQgXmZ5nmA==
X-Received: by 2002:a17:90b:3ec5:: with SMTP id rm5mr12867091pjb.110.1629601929075;
        Sat, 21 Aug 2021 20:12:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:5c14:c983:6add:f6c9? ([2601:647:4000:d7:5c14:c983:6add:f6c9])
        by smtp.gmail.com with ESMTPSA id nl9sm15419937pjb.33.2021.08.21.20.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 20:12:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Use-after-free related to dm_put_table_device()
Message-ID: <a5057305-9864-df8c-0657-ff33c85dc4f6@acm.org>
Date:   Sat, 21 Aug 2021 20:12:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

If I run blktests nvmeof-mp/012 then a KASAN use-after-free complaint
appears. Since I haven't seen this warning with previous kernel versions,
I think this is a regression. Given the presence of bd_unlink_disk_holder()
in the call trace, can you take a look Christoph?

Thanks,

Bart.

root[15974]: run blktests nvmeof-mp/012
unknown: run blktests nvmeof-mp/012 at 2021-08-21 19:41:59
kernel: null_blk: module loaded
[ ... ]
kernel: nvme nvme0: Removing ctrl: NQN "nvme-test"
multipathd[16007]: BUG: orphaning path nvme0n1 that holds hwe of mpathaeq
kernel: ==================================================================
kernel: BUG: KASAN: use-after-free in sysfs_remove_link+0x20/0x60
kernel: Read of size 8 at addr ffff88811baecc30 by task multipathd/16017
kernel:
kernel: CPU: 3 PID: 16017 Comm: multipathd Not tainted 5.14.0-rc5-dbg+ #8
kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
kernel: Call Trace:
kernel:  show_stack+0x52/0x58
kernel:  dump_stack_lvl+0x5b/0x82
kernel:  print_address_description.constprop.0+0x22/0xb0
kernel:  kasan_report+0xca/0x110
kernel:  __asan_load8+0x69/0x90
kernel:  sysfs_remove_link+0x20/0x60
kernel:  bd_unlink_disk_holder+0xf6/0x170
kernel:  dm_put_table_device+0x99/0x180 [dm_mod]
kernel:  dm_put_device+0xe6/0x180 [dm_mod]
kernel:  free_priority_group+0x110/0x150 [dm_multipath]
kernel:  free_multipath+0xe1/0x160 [dm_multipath]
kernel:  multipath_dtr+0x39/0x40 [dm_multipath]
kernel:  dm_table_destroy+0xa7/0x200 [dm_mod]
kernel:  __dm_destroy+0x22e/0x320 [dm_mod]
kernel:  dm_destroy+0x13/0x20 [dm_mod]
kernel:  dev_remove+0x156/0x1d0 [dm_mod]
kernel:  ctl_ioctl+0x2a7/0x4e0 [dm_mod]
kernel:  dm_ctl_ioctl+0xe/0x20 [dm_mod]
kernel:  __x64_sys_ioctl+0xc2/0xe0
kernel:  do_syscall_64+0x35/0xb0
kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
kernel: RIP: 0033:0x7f178a84decb
kernel: Code: ff ff ff 85 c0 79 8b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6d 1f 0d 00 f7 d8 64 89 01 48
kernel: RSP: 002b:00007f178a1e9598 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
kernel: RAX: ffffffffffffffda RBX: 00007f178aa428f8 RCX: 00007f178a84decb
kernel: RDX: 00007f177801b900 RSI: 00000000c138fd04 RDI: 0000000000000004
kernel: RBP: 00007f178a1e9650 R08: 00007f178a1e7310 R09: 00007f178ab197d0
kernel: R10: 0000000000000001 R11: 0000000000000206 R12: 00007f178aa918a2
kernel: R13: 00007f178aa918a2 R14: 00007f178aa918a2 R15: 00007f178aa918a2
kernel:
kernel: Allocated by task 7160:
kernel:  kasan_save_stack+0x23/0x50
kernel:  __kasan_kmalloc+0x83/0xa0
kernel:  kmem_cache_alloc_trace+0x1b0/0x2d0
kernel:  kobject_create_and_add+0x32/0x80
kernel:  register_disk+0x119/0x320
kernel:  device_add_disk+0xb8/0x2c0
kernel:  nvme_alloc_ns+0x4eb/0x8b0 [nvme_core]
kernel:  nvme_validate_or_alloc_ns+0x155/0x1c0 [nvme_core]
kernel:  nvme_scan_ns_list+0x1c5/0x450 [nvme_core]
kernel:  nvme_scan_work+0xeb/0x1d0 [nvme_core]
kernel:  process_one_work+0x582/0xad0
kernel:  worker_thread+0x8f/0x5c0
kernel:  kthread+0x1fc/0x230
kernel:  ret_from_fork+0x1f/0x30
kernel:
kernel: Freed by task 16259:
kernel:  kasan_save_stack+0x23/0x50
kernel:  kasan_set_track+0x20/0x30
kernel:  kasan_set_free_info+0x24/0x40
kernel:  __kasan_slab_free+0xf2/0x130
kernel:  slab_free_freelist_hook+0xb4/0x1b0
kernel:  kfree+0xdc/0x490
kernel:  dynamic_kobj_release+0x13/0x50
kernel:  kobject_cleanup+0x7f/0x1c0
kernel:  kobject_put+0x76/0x90
kernel:  del_gendisk+0x1a2/0x340
kernel:  nvme_ns_remove.part.0+0x15d/0x3c0 [nvme_core]
kernel:  nvme_ns_remove+0x2e/0x40 [nvme_core]
kernel:  nvme_remove_namespaces+0x19d/0x200 [nvme_core]
kernel:  nvme_do_delete_ctrl+0x73/0xa6 [nvme_core]
kernel:  nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
kernel:  dev_attr_store+0x3e/0x60
kernel:  sysfs_kf_write+0x87/0xa0
kernel:  kernfs_fop_write_iter+0x1cb/0x270
kernel:  new_sync_write+0x26b/0x380
kernel:  vfs_write+0x3b5/0x4f0
kernel:  ksys_write+0xd9/0x180
kernel:  __x64_sys_write+0x43/0x50
kernel:  do_syscall_64+0x35/0xb0
kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
kernel:
kernel: The buggy address belongs to the object at ffff88811baecc00
         which belongs to the cache kmalloc-64 of size 64
kernel: The buggy address is located 48 bytes inside of
         64-byte region [ffff88811baecc00, ffff88811baecc40)
kernel: The buggy address belongs to the page:
kernel: page:00000000e5179bbf refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88811baecf80 pfn:0x11baec
kernel: flags: 0x2000000000000200(slab|node=0|zone=2)
kernel: raw: 2000000000000200 ffffea0004051f48 ffffea00044e9588 ffff888100042640
kernel: raw: ffff88811baecf80 000000000020001b 00000001ffffffff 0000000000000000
kernel: page dumped because: kasan: bad access detected
kernel:
kernel: Memory state around the buggy address:
kernel:  ffff88811baecb00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
kernel:  ffff88811baecb80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
kernel: >ffff88811baecc00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
kernel:                                      ^
kernel:  ffff88811baecc80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
kernel:  ffff88811baecd00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
kernel: ==================================================================
