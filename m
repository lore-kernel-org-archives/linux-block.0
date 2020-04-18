Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371B5C2D0EF
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 09:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A62221F4
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 09:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgDRJnP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Apr 2020 05:43:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2408 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbgDRJnP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Apr 2020 05:43:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B1A2BF7F916F9408B0D;
        Sat, 18 Apr 2020 17:43:09 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.204) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 17:42:59 +0800
Subject: Re: [RFC] block: fix access of uninitialized pointer address in
 bt_for_each()
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <yi.zhang@huawei.com>, <yuyufen@huawei.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200417125134.45117-1-yukuai3@huawei.com>
 <340bed9b-e14d-5a22-1601-8fb7aad4ce7f@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <ad7e4125-c90f-4dda-6029-940b9dfeb8c4@huawei.com>
Date:   Sat, 18 Apr 2020 17:42:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <340bed9b-e14d-5a22-1601-8fb7aad4ce7f@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.204]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/4/17 22:26, Bart Van Assche wrote:

> I don't think the above changes are sufficient to fix the
> use-after-free. Has it been considered to free the memory that backs
> tags->bitmap_tags only after an RCU grace period has expired? See also
> blk_mq_free_tags().
> 
I try to reporduce the problem:
1. manually sleep before set 'tags->rqs'
@@ -280,6 +280,7 @@ static struct request *blk_mq_rq_ctx_init(struct 
blk_mq_alloc_data *data,
  	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
  	struct request *rq = tags->static_rqs[tag];
  	req_flags_t rq_flags = 0;
+	static int debug_time = 0;

  	if (data->flags & BLK_MQ_REQ_INTERNAL) {
  		rq->tag = -1;
@@ -291,6 +292,15 @@ static struct request *blk_mq_rq_ctx_init(struct 
blk_mq_alloc_data *data,
  		}
  		rq->tag = tag;
  		rq->internal_tag = -1;
+		if (!strcmp(dev_name(data->q->backing_dev_info->dev), "8:0")) {
+			if (debug_time == 0) {
+				printk("This is sda, will sleep 5s, tag(%d)\n", tag);
+				debug_time++;
+				msleep(5000);
+			} else {
+				printk("sda: get tag (%d)\n", tag);
+			}
+		}
  		data->hctx->tags->rqs[rq->tag] = rq;
  	}
2. echo none > /sys/block/sda/queue/scheduler
3. dd if=/dev/zero of=/dev/sda bs=4k count=1 oflag=direct
will sleep 5s
4. dd if=/dev/zero of=/dev/sda bs=4k count=1 oflag=direct
do this before step 3 finish.

Test result:
[   60.585789] This is sda, will sleep 5s, tag(42)
[   61.983732] sda: get tag (117)
[   61.988268] 
==================================================================
[   61.988933] BUG: KASAN: use-after-free in bt_iter+0x29e/0x310
[   61.989446] Read of size 8 at addr ffff88824f5d8c00 by task dd/2659
[   61.989996]
[   61.990136] CPU: 2 PID: 2659 Comm: dd Not tainted 
4.19.90-00001-g9c3fb8226112-dirty #44
[   61.990830] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.12.0-2.fc30 04/01/2014
[   61.991591] Call Trace:
[   61.991819]  dump_stack+0x108/0x15f
[   61.992127]  print_address_description+0xa5/0x372
[   61.992551]  kasan_report.cold+0x236/0x2a8
[   61.992909]  ? bt_iter+0x29e/0x310
[   61.993210]  __asan_report_load8_noabort+0x25/0x30
[   61.993625]  bt_iter+0x29e/0x310
[   61.993917]  blk_mq_queue_tag_busy_iter+0x405/0x910
[   61.994342]  ? __blkdev_issue_zeroout+0x190/0x190
[   61.994759]  ? blk_mq_put_tag+0x1a0/0x1a0
[   61.995111]  ? serial8250_start_tx+0xa10/0xa10
[   61.995501]  ? __blkdev_issue_zeroout+0x190/0x190
[   61.995916]  blk_mq_in_flight+0xda/0x140
[   61.996279]  ? blk_mq_end_request+0x3a0/0x3a0
[   61.996665]  part_in_flight+0x59/0x300
[   61.996994]  part_round_stats+0x332/0x6d0
[   61.997345]  ? blk_mq_get_tag+0x7d5/0xb90
[   61.997702]  ? blk_requeue_request+0x2b0/0x2b0
[   61.998090]  ? vprintk_func+0x6c/0x1a2
[   61.998421]  ? printk+0xb9/0xf1
[   61.998700]  blk_account_io_start+0x408/0x810
[   61.999077]  ? blkg_create+0x622/0x1010
[   61.999413]  ? blk_end_request+0xc0/0xc0
[   61.999763]  ? blk_rq_bio_prep+0xc2/0x330
[   62.000111]  blk_mq_bio_to_request+0x238/0x3c0
[   62.000500]  blk_mq_make_request+0x927/0x1690
[   62.000891]  ? blk_mq_try_issue_directly+0x1a0/0x1a0
[   62.001321]  ? blk_put_request+0x130/0x130
[   62.001683]  generic_make_request+0x53b/0xff0
[   62.002071]  ? direct_make_request+0x360/0x360
[   62.002464]  submit_bio+0xa8/0x3d0
[   62.002763]  ? generic_make_request+0xff0/0xff0
[   62.003153]  ? bio_phys_segments+0xc0/0xc0
[   62.003516]  __blkdev_direct_IO_simple+0x400/0xa90
[   62.003934]  ? blkdev_bio_end_io+0x5f0/0x5f0
[   62.004309]  ? kasan_check_read+0x1d/0x30
[   62.004663]  ? mutex_lock+0xa6/0x110
[   62.004975]  ? __handle_mm_fault+0x19ed/0x36c0
[   62.005366]  ? kasan_check_write+0x20/0x30
[   62.005722]  ? mutex_unlock+0x25/0x70
[   62.006040]  ? __pmd_alloc+0x4d0/0x4d0
[   62.006370]  ? bdput+0x50/0x50
[   62.006645]  ? handle_mm_fault+0x3f8/0x840
[   62.007002]  blkdev_direct_IO+0x93a/0xfc0
[   62.007354]  ? inode_owner_or_capable+0x1e0/0x1e0
[   62.007769]  ? mem_cgroup_oom_trylock+0x1c0/0x1c0
[   62.008175]  ? kasan_alloc_pages+0x3c/0x50
[   62.008534]  ? __blkdev_direct_IO_simple+0xa90/0xa90
[   62.008965]  ? current_time+0xe0/0x180
[   62.009289]  ? timespec64_trunc+0x190/0x190
[   62.009660]  ? generic_update_time+0x1aa/0x330
[   62.010051]  generic_file_direct_write+0x1d1/0x490
[   62.010471]  __generic_file_write_iter+0x2c1/0x680
[   62.010892]  blkdev_write_iter+0x1ed/0x420
[   62.011247]  ? blkdev_close+0xe0/0xe0
[   62.011569]  ? __pte_alloc+0x350/0x350
[   62.011895]  ? vvar_fault+0xcb/0xe0
[   62.012201]  ? _cond_resched+0x25/0x50
[   62.012538]  ? read_iter_zero+0x78/0x1a0
[   62.012884]  __vfs_write+0x495/0x760
[   62.013199]  ? __pmd_alloc+0x4d0/0x4d0
[   62.013537]  ? kernel_read+0x150/0x150
[   62.013867]  ? __fsnotify_inode_delete+0x30/0x30
[   62.014272]  vfs_write+0x17b/0x530
[   62.014570]  ksys_write+0x103/0x270
[   62.014876]  ? __x64_sys_read+0xc0/0xc0
[   62.015218]  ? kasan_check_write+0x20/0x30
[   62.015580]  ? fput+0x29/0x1b0
[   62.015851]  ? filp_close+0x119/0x170
[   62.016171]  __x64_sys_write+0x77/0xc0
[   62.016502]  do_syscall_64+0x106/0x260
[   62.016832]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   62.017274] RIP: 0033:0x7f84f6274130
[   62.017591] Code: 73 01 c3 48 8b 0d 58 ed 2c 00 f7 d8 64 89 01 48 83 
c8 ff c3 66 0f 1f 44 00 00 83 3d b9 45 2d 00 00 75 10 b8 01 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e4
[   62.019186] RSP: 002b:00007ffd43abdcd8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[   62.019833] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f84f6274130
[   62.020460] RDX: 0000000000001000 RSI: 000055976e38b000 RDI: 
0000000000000001
[   62.021090] RBP: 0000000000001000 R08: 000055976e38a030 R09: 
0000000000000077
[   62.021709] R10: 00007f84f6543b38 R11: 0000000000000246 R12: 
000055976e38b000
[   62.022328] R13: 0000000000000000 R14: 0000000000000000 R15: 
000055976e38b000
[   62.022941]
[   62.023080] The buggy address belongs to the page:
[   62.023502] page:ffffea00093d7600 count:0 mapcount:0 
mapping:0000000000000000 index:0x0
[   62.024187] flags: 0x2fffff80000000()
[   62.024523] raw: 002fffff80000000 ffffea00093d7608 ffffea00093d7608 
0000000000000000
[   62.025186] raw: 0000000000000000 0000000000000000 00000000ffffffff 
0000000000000000
[   62.025852] page dumped because: kasan: bad access detected
[   62.026332]
[   62.026469] Memory state around the buggy address:
[   62.026887]  ffff88824f5d8b00: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   62.027513]  ffff88824f5d8b80: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   62.028127] >ffff88824f5d8c00: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   62.028752]                    ^
[   62.029036]  ffff88824f5d8c80: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   62.029657]  ffff88824f5d8d00: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   62.030284] 
==================================================================

And I try to fix the problem by setting tag->reqs to NULL in 
blk_mq_free_rqs(), and use rcu to avoid concurrency between 
bt_for_each() and blk_mq_free_rqs(). （The rcu implementation is from 
https://lore.kernel.org/linux-block/71fb9eff-43eb-24aa-fb67-be56a3a97983@kernel.dk/）

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 256fa1ccc2bd..c3ae8455e4eb 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -605,12 +605,22 @@ struct blk_flush_queue 
*blk_alloc_flush_queue(struct request_queue *q,
  	return NULL;
  }

+static void blk_fq_rcu_free(struct work_struct *work)
+{
+	struct blk_flush_queue *fq = container_of(to_rcu_work(work),
+							struct blk_flush_queue,
+							rcu_work);
+
+	kfree(fq->flush_rq);
+	kfree(fq);
+}
+
  void blk_free_flush_queue(struct blk_flush_queue *fq)
  {
  	/* bio based request queue hasn't flush queue */
  	if (!fq)
  		return;

-	kfree(fq->flush_rq);
-	kfree(fq);
+	INIT_RCU_WORK(&fq->rcu_work, blk_fq_rcu_free);
+	queue_rcu_work(system_wq, &fq->rcu_work);
  }
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 41317c50a446..f744dd144f06 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -229,6 +229,8 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned 
int bitnr, void *data)
  	if (!reserved)
  		bitnr += tags->nr_reserved_tags;
  	rq = tags->rqs[bitnr];
+//	if (!strcmp(dev_name(hctx->queue->backing_dev_info->dev), "8:0"))
+//		printk("tags->rqs[%d]: %p",bitnr, rq);

  	/*
  	 * We can hit rq == NULL here, because the tagging functions
@@ -249,7 +251,9 @@ static void bt_for_each(struct blk_mq_hw_ctx *hctx, 
struct sbitmap_queue *bt,
  		.reserved = reserved,
  	};

+	rcu_read_lock();
  	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
+	rcu_read_unlock();
  }

  struct bt_tags_iter_data {
@@ -290,8 +294,11 @@ static void bt_tags_for_each(struct blk_mq_tags 
*tags, struct sbitmap_queue *bt,
  		.reserved = reserved,
  	};

-	if (tags->rqs)
+	if (tags->rqs) {
+		rcu_read_lock();
  		sbitmap_for_each_set(&bt->sb, bt_tags_iter, &iter_data);
+		rcu_read_unlock();
+	}
  }

  static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8a7c3d841661..2c2dd578a27a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c

@@ -1932,12 +1942,38 @@ static blk_qc_t blk_mq_make_request(struct 
request_queue *q, struct bio *bio)
  	return cookie;
  }

+struct rq_page_list {
+	struct rcu_work rcu_work;
+	struct list_head list;
+	bool on_stack;
+};
+
+static void blk_mq_rcu_free_pages(struct work_struct *work)
+{
+	struct rq_page_list *rpl = container_of(to_rcu_work(work),
+						struct rq_page_list, rcu_work);
+	struct page *page;
+
+	while (!list_empty(&rpl->list)) {
+		page = list_first_entry(&rpl->list, struct page, lru);
+		list_del_init(&page->lru);
+		/*
+		 * Remove kmemleak object previously allocated in
+		 * blk_mq_init_rq_map().
+		 */
+		kmemleak_free(page_address(page));
+		__free_pages(page, page->private);
+	}
+	if (!rpl->on_stack)
+		kfree(rpl);
+}
+
  void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
  		     unsigned int hctx_idx)
  {
-	struct page *page;
+	struct rq_page_list *rpl;

-	if (tags->rqs && set->ops->exit_request) {
+	if (tags->rqs) {
  		int i;

  		for (i = 0; i < tags->nr_tags; i++) {
@@ -1945,20 +1981,38 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, 
struct blk_mq_tags *tags,

  			if (!rq)
  				continue;
-			set->ops->exit_request(set, rq, hctx_idx);
+			if (set->ops->exit_request)
+				set->ops->exit_request(set, rq, hctx_idx);
  			tags->static_rqs[i] = NULL;
+			if (set->tags[hctx_idx]->rqs[rq->tag] == rq)
+				set->tags[hctx_idx]->rqs[rq->tag] = NULL;
  		}
  	}

-	while (!list_empty(&tags->page_list)) {
-		page = list_first_entry(&tags->page_list, struct page, lru);
-		list_del_init(&page->lru);
+	if (list_empty(&tags->page_list))
+		return;
+
+	rpl = kmalloc(sizeof(*rpl), GFP_NOIO);
+	if (rpl) {
+		INIT_LIST_HEAD(&rpl->list);
+		list_splice_init(&tags->page_list, &rpl->list);
+
+		/* Punt to RCU free, so we don't race with tag iteration */
+		INIT_RCU_WORK(&rpl->rcu_work, blk_mq_rcu_free_pages);
+		rpl->on_stack = false;
+		queue_rcu_work(system_wq, &rpl->rcu_work);
+	} else {
+		struct rq_page_list stack_rpl;
+
  		/*
-		 * Remove kmemleak object previously allocated in
-		 * blk_mq_init_rq_map().
+		 * Fail alloc, punt to on-stack, we just have to synchronize
+		 * RCU first to ensure readers are done.
  		 */
-		kmemleak_free(page_address(page));
-		__free_pages(page, page->private);
+		INIT_LIST_HEAD(&stack_rpl.list);
+		list_splice_init(&tags->page_list, &stack_rpl.list);
+		stack_rpl.on_stack = true;
+		synchronize_rcu();
+		blk_mq_rcu_free_pages(&stack_rpl.rcu_work.work);
  	}
  }

diff --git a/block/blk.h b/block/blk.h
index 1a5b67b57e6b..8378074ad51e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -35,6 +35,8 @@ struct blk_flush_queue {
  	 */
  	struct request		*orig_rq;
  	spinlock_t		mq_flush_lock;
+
+	struct rcu_work		rcu_work;
  };

  extern struct kmem_cache *blk_requestq_cachep;
-- 

Thanks!
Yu Kuai

