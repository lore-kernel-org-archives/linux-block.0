Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B12C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 01:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350482AbhLXBaK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 20:30:10 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30101 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350813AbhLXBaI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 20:30:08 -0500
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JKqCy5fs8z1DK6P;
        Fri, 24 Dec 2021 09:26:54 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 09:30:05 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 09:30:05 +0800
Subject: Re: [PATCH 0/3] bfq: Avoid use-after-free when moving processes
 between cgroups
To:     Jan Kara <jack@suse.cz>, <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
References: <20211223171425.3551-1-jack@suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a9a22745-6fc4-22c0-ddbc-be0e82f07876@huawei.com>
Date:   Fri, 24 Dec 2021 09:30:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211223171425.3551-1-jack@suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2021/12/24 1:31, Jan Kara Ð´µÀ:
> Hello,
> 
> these three patches fix use-after-free issues in BFQ when processes with merged
> queues get moved to different cgroups. The patches have survived some beating
> in my test VM but so far I fail to reproduce the original KASAN reports so
> testing from people who can reproduce them is most welcome. Thanks!

Hi,

Unfortunately, this patchset can't fix the UAF, just to mark
split_coop in patch 3 seems not enough.

Here is the result:

[  548.440184] 
==============================================================
[  548.441680] BUG: KASAN: use-after-free in 
__bfq_deactivate_entity+0x21/0x290
[  548.443155] Read of size 1 at addr ffff8881723e00b0 by task rmmod/13984
[  548.444109]
[  548.444321] CPU: 30 PID: 13984 Comm: rmmod Tainted: G        W 
  5.16.0-rc5-next-2026
[  548.445549] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-4
[  548.447348] Call Trace:
[  548.447682]  <TASK>
[  548.447967]  dump_stack_lvl+0x34/0x44
[  548.448470]  print_address_description.constprop.0.cold+0xab/0x36b
[  548.449303]  ? __bfq_deactivate_entity+0x21/0x290
[  548.449929]  ? __bfq_deactivate_entity+0x21/0x290
[  548.450565]  kasan_report.cold+0x83/0xdf
[  548.451114]  ? _raw_read_lock_bh+0x20/0x40
[  548.451658]  ? __bfq_deactivate_entity+0x21/0x290
[  548.452296]  __bfq_deactivate_entity+0x21/0x290
[  548.452917]  bfq_pd_offline+0xc1/0x110
[  548.453436]  blkcg_deactivate_policy+0x14b/0x210
[  548.454058]  bfq_exit_queue+0xe5/0x100
[  548.454573]  blk_mq_exit_sched+0x113/0x140
[  548.455162]  elevator_exit+0x30/0x50
[  548.455645]  blk_release_queue+0xa8/0x160
[  548.456191]  kobject_put+0xd4/0x270
[  548.456657]  disk_release+0xc5/0xf0
[  548.457140]  device_release+0x56/0xe0
[  548.457634]  kobject_put+0xd4/0x270
[  548.458113]  null_del_dev.part.0+0xe6/0x220 [null_blk]
[  548.458810]  null_exit+0x62/0xa6 [null_blk]
[  548.459404]  __x64_sys_delete_module+0x20a/0x2f0
[  548.460046]  ? __ia32_sys_delete_module+0x2f0/0x2f0
[  548.460716]  ? fpregs_assert_state_consistent+0x55/0x60
[  548.461436]  ? exit_to_user_mode_prepare+0x39/0x1e0
[  548.462116]  do_syscall_64+0x35/0x80
[  548.462603]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  548.463292] RIP: 0033:0x7fdabfb0efc7
[  548.463777] Code: 73 01 c3 48 8b 0d c1 de 2b 00 f7 d8 64 89 01 48 83 
c8 ff c3 66 2e 0f 1f 8
[  548.466251] RSP: 002b:00007ffd678e61d8 EFLAGS: 00000206 ORIG_RAX: 
00000000000000b0
[  548.467286] RAX: ffffffffffffffda RBX: 00007ffd678e6238 RCX: 
00007fdabfb0efc7
[  548.468237] RDX: 000000000000000a RSI: 0000000000000800 RDI: 
000055b176bb1258
[  548.469187] RBP: 000055b176bb11f0 R08: 00007ffd678e5151 R09: 
0000000000000000
[  548.470130] R10: 00007fdabfb81260 R11: 0000000000000206 R12: 
00007ffd678e6400
[  548.471083] R13: 00007ffd678e845b R14: 000055b176bb0010 R15: 
000055b176bb11f0
[  548.472051]  </TASK>
[  548.472351]
[  548.472569] Allocated by task 13874:
[  548.473066]  kasan_save_stack+0x1e/0x40
[  548.473579]  __kasan_kmalloc+0x81/0xa0
[  548.474082]  bfq_pd_alloc+0x72/0x110
[  548.474551]  blkg_alloc+0x252/0x2c0
[  548.475034]  blkg_create+0x38e/0x560
[  548.475508]  bio_associate_blkg_from_css+0x3bc/0x490
[  548.476169]  bio_associate_blkg+0x3b/0x90
[  548.476701]  submit_bh_wbc+0x18c/0x320
[  548.477207]  ll_rw_block+0x126/0x130
[  548.477681]  __block_write_begin_int+0x6fc/0xee0
[  548.478299]  block_write_begin+0x44/0x190
[  548.478830]  generic_perform_write+0x159/0x300
[  548.479441]  __generic_file_write_iter+0x162/0x250
[  548.480086]  blkdev_write_iter+0x21a/0x300
[  548.480628]  aio_write+0x218/0x400
[  548.481084]  io_submit_one+0x855/0x11c0
[  548.481587]  __x64_sys_io_submit+0xfa/0x250
[  548.482140]  do_syscall_64+0x35/0x80
[  548.482615]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  548.483298]
[  548.483502] Freed by task 13855:
[  548.483929]  kasan_save_stack+0x1e/0x40
[  548.484439]  kasan_set_track+0x21/0x30
[  548.484940]  kasan_set_free_info+0x20/0x30
[  548.485486]  __kasan_slab_free+0x103/0x180
[  548.486032]  kfree+0x9a/0x4b0
[  548.486425]  blkg_free.part.0+0x4a/0x90
[  548.486931]  rcu_do_batch+0x2e1/0x760
[  548.487440]  rcu_core+0x367/0x530
[  548.487879]  __do_softirq+0x119/0x3ba

How do you think about this:

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1ce1a99a7160..14c1d1c3811e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2626,6 +2626,11 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct 
bfq_queue *new_bfqq)
         while ((__bfqq = new_bfqq->new_bfqq)) {
                 if (__bfqq == bfqq)
                         return NULL;
+               if (__bfqq->entity.parent != bfqq->entity.parent) {
+                       if (bfq_bfqq_coop(__bfqq))
+                               bfq_mark_bfqq_split_coop(__bfqq);
+                       return NULL;
+               }
                 new_bfqq = __bfqq;
         }

@@ -2825,8 +2830,16 @@ bfq_setup_cooperator(struct bfq_data *bfqd, 
struct bfq_queue *bfqq,
         if (bfq_too_late_for_merging(bfqq))
                 return NULL;

-       if (bfqq->new_bfqq)
-               return bfqq->new_bfqq;
+       if (bfqq->new_bfqq) {
+               struct bfq_queue *new_bfqq = bfqq->new_bfqq;
+
+               if(bfqq->entity.parent == new_bfqq->entity.parent)
+                       return new_bfqq;
+
+               if(bfq_bfqq_coop(new_bfqq))
+                       bfq_mark_bfqq_split_coop(new_bfqq);
+               return NULL;
+       }

Thanks,
Kuai
> 
> 								Honza
> .
> 
