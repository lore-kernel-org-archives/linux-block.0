Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B7CC433B4
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 10:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96C161164
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 10:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhEDKQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 May 2021 06:16:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2991 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhEDKQz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 May 2021 06:16:55 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FZFns1XS9z6xhY7;
        Tue,  4 May 2021 18:05:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 12:15:58 +0200
Received: from [10.47.95.108] (10.47.95.108) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 4 May 2021
 11:15:58 +0100
Subject: Re: [PATCH V4 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        David Jeffery <djeffery@redhat.com>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fb0804e5-bfae-62ac-c3e6-d46a9a33ca53@huawei.com>
Date:   Tue, 4 May 2021 11:15:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210429023458.3044317-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.108]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29/04/2021 03:34, Ming Lei wrote:
> Hi Jens,
> 
> This patchset fixes the request UAF issue by one simple approach,
> without clearing ->rqs[] in fast path.
> 
> 1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
> and release it after calling ->fn, so ->fn won't be called for one
> request if its queue is frozen, done in 2st patch
> 
> 2) clearing any stale request referred in ->rqs[] before freeing the
> request pool, one per-tags spinlock is added for protecting
> grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
> in bt_tags_iter() is avoided, done in 3rd patch.
> 

I had a go at testing this. Without any modifications for testing, it 
looks ok.

However I also tested by adding an artificial delay in bt_iter() - 
otherwise it may not be realistic to trigger some UAF issues in sane 
timeframes.

So I made this change:

--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -215,8 +215,11 @@ static bool bt_iter(struct sbitmap *bitmap, 
unsigned int bitnr, void *data)
          * We can hit rq == NULL here, because the tagging functions
          * test and set the bit before assigning ->rqs[].
          */
-       if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
-               return iter_data->fn(hctx, rq, iter_data->data, reserved);
+       if (rq) {
+               mdelay(50);
+               if (rq->q == hctx->queue && rq->mq_hctx == hctx)
+   		  return iter_data->fn(hctx, rq, iter_data->data, reserved);
+       }
         return true;
  }


And I could trigger this pretty quickly:

[  129.318623] 
==================================================================
[  129.325870] BUG: KASAN: use-after-free in bt_iter+0xa0/0x120
[  129.331548] Read of size 8 at addr ffff0010cc62a200 by task fio/1610

[  129.339384] CPU: 33 PID: 1610 Comm: fio Not tainted 
5.12.0-rc4-47861-g2edb78df2141 #1140
[  129.339395] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon 
D05 IT21 Nemo 2.0 RC0 04/18/2018
[  129.339403] Call trace:
[  129.339408]  dump_backtrace+0x0/0x2d0
[  129.339430]  show_stack+0x18/0x68
[  129.339441]  dump_stack+0x100/0x16c
[  129.339455]  print_address_description.constprop.13+0x68/0x30c
[  129.339468]  kasan_report+0x1d8/0x240
[  129.339479]  __asan_load8+0x9c/0xd8
[  129.339488]  bt_iter+0xa0/0x120
[  129.339496]  blk_mq_queue_tag_busy_iter+0x2d8/0x540
[  129.339506]  blk_mq_in_flight+0x80/0xb8
[  129.339516]  part_stat_show+0xcc/0x210
[  129.339528]  dev_attr_show+0x44/0x90
[  129.339542]  sysfs_kf_seq_show+0x128/0x1c8
[  129.339554]  kernfs_seq_show+0xa0/0xb8
[  129.339563]  seq_read_iter+0x210/0x660
[  129.339575]  kernfs_fop_read_iter+0x208/0x2b0
[  129.339585]  new_sync_read+0x1ec/0x2d0
[  129.339596]  vfs_read+0x188/0x248
[  129.339605]  ksys_read+0xc8/0x178
[  129.339615]  __arm64_sys_read+0x44/0x58
[  129.339625]  el0_svc_common.constprop.1+0xc4/0x190
[  129.339639]  do_el0_svc+0x90/0xa0
[  129.339648]  el0_svc+0x24/0x38
[  129.339659]  el0_sync_handler+0x90/0xb8
[  129.339670]  el0_sync+0x154/0x180

[  129.341162] Allocated by task 1613:
[  129.344644]  stack_trace_save+0x94/0xc8
[  129.344662]  kasan_save_stack+0x28/0x58
[  129.344670]  __kasan_slab_alloc+0x88/0xa8
[  129.344679]  slab_post_alloc_hook+0x58/0x2a0
[  129.344691]  kmem_cache_alloc+0x19c/0x2c0
[  129.344699]  io_submit_one+0x138/0x1580
[  129.344710]  __arm64_sys_io_submit+0x120/0x310
[  129.344721]  el0_svc_common.constprop.1+0xc4/0x190
[  129.344731]  do_el0_svc+0x90/0xa0
[  129.344741]  el0_svc+0x24/0x38
[  129.344750]  el0_sync_handler+0x90/0xb8
[  129.344760]  el0_sync+0x154/0x180

[  129.346250] Freed by task 496:
[  129.349297]  stack_trace_save+0x94/0xc8
[  129.349307]  kasan_save_stack+0x28/0x58
[  129.349315]  kasan_set_track+0x28/0x40
[  129.349323]  kasan_set_free_info+0x28/0x50
[  129.349332]  __kasan_slab_free+0xd0/0x130
[  129.349340]  slab_free_freelist_hook+0x70/0x178
[  129.349352]  kmem_cache_free+0x94/0x400
[  129.349359]  aio_complete_rw+0x4f8/0x7f8
[  129.349369]  blkdev_bio_end_io+0xe0/0x1e8
[  129.349380]  bio_endio+0x1d4/0x1f0
[  129.349392]  blk_update_request+0x388/0x6b8
[  129.349401]  scsi_end_request+0x54/0x320
[  129.349411]  scsi_io_completion+0xec/0x700
[  129.349420]  scsi_finish_command+0x168/0x1e8
[  129.349432]  scsi_softirq_done+0x140/0x1b8
[  129.349441]  blk_mq_complete_request+0x4c/0x60
[  129.349449]  scsi_mq_done+0x68/0x88
[  129.349457]  sas_scsi_task_done+0xe0/0x118
[  129.349470]  slot_complete_v2_hw+0x23c/0x620
[  129.349483]  cq_thread_v2_hw+0x10c/0x388
[  129.349493]  irq_thread_fn+0x48/0xd8
[  129.349503]  irq_thread+0x1d4/0x2f8
[  129.349511]  kthread+0x224/0x230
[  129.349521]  ret_from_fork+0x10/0x30

[  129.351012] The buggy address belongs to the object at ffff0010cc62a200
  which belongs to the cache aio_kiocb of size 176
[  129.363351] The buggy address is located 0 bytes inside of
  176-byte region [ffff0010cc62a200, ffff0010cc62a2b0)
[  129.374909] The buggy address belongs to the page:
[  129.379693] page:0000000026f8d4c3 refcount:1 mapcount:0 
mapping:0000000000000000 index:0x0 pfn:0x10cc62a
[  129.379704] head:0000000026f8d4c3 order:1 compound_mapcount:0
[  129.379710] flags: 0xbfffc0000010200(slab|head)
[  129.379727] raw: 0bfffc0000010200 dead000000000100 dead000000000122 
ffff04100630f780
[  129.379736] raw: 0000000000000000 0000000000200020 00000001ffffffff 
0000000000000000
[  129.379742] page dumped because: kasan: bad access detected

[  129.381229] Memory state around the buggy address:
[  129.386012]  ffff0010cc62a100: fa fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  129.393228]  ffff0010cc62a180: fb fb fb fb fb fb fc fc fc fc fc fc fc 
fc fc fc
[  129.400443] >ffff0010cc62a200: fa fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  129.407657] ^
[  129.410878]  ffff0010cc62a280: fb fb fb fb fb fb fc fc fc fc fc fc fc 
fc fc fc
[  129.418092]  ffff0010cc62a300: fa fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  129.425306] 
==================================================================
[  129.432520] Disabling lock debugging due to kernel taint
root@ubuntu:/home/john#

My script simply kicks off fio running some data on the disk on which / 
is mounted, and then continually changes IO sched from 
none->mq-deadline->none for that same disk.

I have not had a chance to try to identify the issue.

I would also have added a delay in bt_tags_iter() for testing also, but 
since I got a UAF, above, I didn't try that yet.

Thanks,
John
