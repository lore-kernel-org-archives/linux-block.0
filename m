Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62C6C433EF
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 09:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbiAGJPs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jan 2022 04:15:48 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30261 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346393AbiAGJPq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jan 2022 04:15:46 -0500
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JVcxn0rHpzbjtb;
        Fri,  7 Jan 2022 17:15:09 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 17:15:44 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 17:15:44 +0800
Subject: Re: [PATCH 0/5 v2] bfq: Avoid use-after-free when moving processes
 between cgroups
To:     Jan Kara <jack@suse.cz>, <linux-block@vger.kernel.org>
CC:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220105143037.20542-1-jack@suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <527c2294-9a53-872a-330a-f337506cd08b@huawei.com>
Date:   Fri, 7 Jan 2022 17:15:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220105143037.20542-1-jack@suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2022/01/05 22:36, Jan Kara Ð´µÀ:
> Hello,
> 
> here is the second version of my patches to fix use-after-free issues in BFQ
> when processes with merged queues get moved to different cgroups. The patches
> have survived some beating in my test VM but so far I fail to reproduce the
> original KASAN reports so testing from people who can reproduce them is most
> welcome. Thanks!
> 
> Changes since v1:
> * Added fix for bfq_put_cooperator()
> * Added fix to handle move between cgroups in bfq_merge_bio()
> 
> 								Honza
> Previous versions:
> Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
> .
> 

Hi,

I repoduced the problem again with this patchset...

[   71.004788] BUG: KASAN: use-after-free in 
__bfq_deactivate_entity+0x21/0x290
[   71.006328] Read of size 1 at addr ffff88817a3dc0b0 by task rmmod/801
[   71.007723]
[   71.008068] CPU: 7 PID: 801 Comm: rmmod Tainted: G        W 
5.16.0-rc5-next-2021127
[   71.009995] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-4
[   71.012274] Call Trace:
[   71.012603]  <TASK>
[   71.012886]  dump_stack_lvl+0x34/0x44
[   71.013379]  print_address_description.constprop.0.cold+0xab/0x36b
[   71.014182]  ? __bfq_deactivate_entity+0x21/0x290
[   71.014795]  ? __bfq_deactivate_entity+0x21/0x290
[   71.015398]  kasan_report.cold+0x83/0xdf
[   71.015904]  ? _raw_read_lock_bh+0x20/0x40
[   71.016433]  ? __bfq_deactivate_entity+0x21/0x290
[   71.017033]  __bfq_deactivate_entity+0x21/0x290
[   71.017617]  bfq_pd_offline+0xc1/0x110
[   71.018105]  blkcg_deactivate_policy+0x14b/0x210
[   71.018699]  bfq_exit_queue+0xe5/0x100
[   71.019189]  blk_mq_exit_sched+0x113/0x140
[   71.019720]  elevator_exit+0x30/0x50
[   71.020186]  blk_release_queue+0xa8/0x160
[   71.020702]  kobject_put+0xd4/0x270
[   71.021158]  disk_release+0xc5/0xf0
[   71.021609]  device_release+0x56/0xe0
[   71.022086]  kobject_put+0xd4/0x270
[   71.022546]  null_del_dev.part.0+0xe6/0x220 [null_blk]
[   71.023228]  null_exit+0x62/0xa6 [null_blk]
[   71.023792]  __x64_sys_delete_module+0x20a/0x2f0
[   71.024387]  ? __ia32_sys_delete_module+0x2f0/0x2f0
[   71.025008]  ? fpregs_assert_state_consistent+0x55/0x60
[   71.025674]  ? exit_to_user_mode_prepare+0x39/0x1e0
[   71.026304]  do_syscall_64+0x35/0x80
[   71.026763]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   71.027410] RIP: 0033:0x7fddec6bdfc7
[   71.027869] Code: 73 01 c3 48 8b 0d c1 de 2b 00 f7 d8 64 89 01 48 83 
c8 ff c3 66 2e 0f 1f 8
[   71.030206] RSP: 002b:00007fff9486bc08 EFLAGS: 00000206 ORIG_RAX: 
00000000000000b0
[   71.031160] RAX: ffffffffffffffda RBX: 00007fff9486bc68 RCX: 
00007fddec6bdfc7
[   71.032058] RDX: 000000000000000a RSI: 0000000000000800 RDI: 
000055fc863ac258
[   71.032962] RBP: 000055fc863ac1f0 R08: 00007fff9486ab81 R09: 
0000000000000000
[   71.033861] R10: 00007fddec730260 R11: 0000000000000206 R12: 
00007fff9486be30
[   71.034758] R13: 00007fff9486c45b R14: 000055fc863ab010 R15: 
000055fc863ac1f0
[   71.035659]  </TASK>
[   71.035946]
[   71.036149] Allocated by task 620:
[   71.036585]  kasan_save_stack+0x1e/0x40
[   71.037076]  __kasan_kmalloc+0x81/0xa0
[   71.037558]  bfq_pd_alloc+0x72/0x110
[   71.038015]  blkg_alloc+0x252/0x2c0
[   71.038467]  blkg_create+0x38e/0x560
[   71.038927]  bio_associate_blkg_from_css+0x3bc/0x490
[   71.039563]  bio_associate_blkg+0x3b/0x90
[   71.040076]  mpage_alloc+0x7c/0xe0
[   71.040516]  do_mpage_readpage+0xb42/0xff0
[   71.041040]  mpage_readahead+0x1fd/0x3f0
[   71.041544]  read_pages+0x144/0x770
[   71.041994]  page_cache_ra_unbounded+0x2d2/0x380
[   71.042586]  filemap_get_pages+0x1bc/0xaf0
[   71.043115]  filemap_read+0x1bf/0x5a0
[   71.043585]  aio_read+0x1ca/0x2f0
[   71.044014]  io_submit_one+0x874/0x11c0
[   71.044511]  __x64_sys_io_submit+0xfa/0x250
[   71.045048]  do_syscall_64+0x35/0x80
[   71.045513]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   71.046161]
[   71.046361] Freed by task 0:
[   71.046735]  kasan_save_stack+0x1e/0x40
[   71.047230]  kasan_set_track+0x21/0x30
[   71.047709]  kasan_set_free_info+0x20/0x30
[   71.048235]  __kasan_slab_free+0x103/0x180
[   71.048757]  kfree+0x9a/0x4b0
[   71.049144]  blkg_free.part.0+0x4a/0x90
[   71.049635]  rcu_do_batch+0x2e1/0x760
[   71.050111]  rcu_core+0x367/0x530
[   71.050536]  __do_softirq+0x119/0x3ba
[   71.051007]
[   71.051210] The buggy address belongs to the object at ffff88817a3dc000
[   71.051210]  which belongs to the cache kmalloc-2k of size 2048
[   71.052766] The buggy address is located 176 bytes inside of
[   71.052766]  2048-byte region [ffff88817a3dc000, ffff88817a3dc800)
[   71.054240] The buggy address belongs to the page:
[   71.054843] page:00000000ce62c7c2 refcount:1 mapcount:0 
mapping:0000000000000000 index:0x08
[   71.056021] head:00000000ce62c7c2 order:3 compound_mapcount:0 
compound_pincount:0
[   71.056961] flags: 
0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[   71.057894] raw: 0017ffffc0010200 dead000000000100 dead000000000122 
ffff888100042f00
[   71.058866] raw: 0000000000000000 0000000080080008 00000001ffffffff 
0000000000000000
[   71.059840] page dumped because: kasan: bad access detected
[   71.060543]
[   71.060742] Memory state around the buggy address:
[   71.061349]  ffff88817a3dbf80: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   71.062256]  ffff88817a3dc000: fa fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   71.063163] >ffff88817a3dc080: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   71.064129]                                      ^
[   71.064734]  ffff88817a3dc100: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   71.065639]  ffff88817a3dc180: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   71.066544] 
==================================================================

Here is the caller of  __bfq_deactivate_entity:
(gdb) list *(bfq_pd_offline+0xc1)
0xffffffff81c504f1 is in bfq_pd_offline (block/bfq-cgroup.c:942).
937                      * entities to the idle tree. It happens if, in some
938                      * of the calls to bfq_bfqq_move() performed by
939                      * bfq_reparent_active_queues(), the queue to 
move is
940                      * empty and gets expired.
941                      */
942                     bfq_flush_idle_tree(st);
943             }
944
945             __bfq_deactivate_entity(entity, false);
