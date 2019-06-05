Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16470C282CE
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 01:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DB8206DF
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 01:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFEB1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFEB1r (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jun 2019 21:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46047307CDF0;
        Wed,  5 Jun 2019 01:27:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 977085C207;
        Wed,  5 Jun 2019 01:27:34 +0000 (UTC)
Subject: Re: [PATCH] block: free sched's request pool in blk_cleanup_queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <rong.a.chen@intel.com>
References: <20190604130802.17076-1-ming.lei@redhat.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <ffae2084-3a2a-5e46-5809-ff9d8bc3741e@redhat.com>
Date:   Wed, 5 Jun 2019 09:27:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604130802.17076-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 05 Jun 2019 01:27:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tested-by: Yi Zhang <yi.zhang@redhat.com>

This patch fixed bellow issue which triggered by blktests block/006, thanks.

Kernel 5.2.0-rc3 on an x86_64

[  567.066143] run blktests block/006 at 2019-06-05 03:18:04
[  567.089457] null: module loaded
[  593.937235] BUG: unable to handle page fault for address: 
ffffffffc0738110
[  593.938442] #PF: supervisor read access in kernel mode
[  593.939230] #PF: error_code(0x0000) - not-present page
[  593.940011] PGD 11760f067 P4D 11760f067 PUD 117611067 PMD 12b61f067 PTE 0
[  593.941048] Oops: 0000 [#1] SMP PTI
[  593.941607] CPU: 0 PID: 1106 Comm: kworker/0:0 Not tainted 5.2.0-rc3 #1
[  593.942607] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  593.943511] Workqueue: events __blk_release_queue
[  593.944240] RIP: 0010:blk_mq_free_rqs+0x21/0xd0
[  593.944930] Code: c6 e8 83 f0 ff ff eb 9f 90 0f 1f 44 00 00 41 56 41 
55 41 54 55 48 89 f5 53 48 83 be 90 00 00 00 00 74 56 48 8b 47 38 49 89 
fd <48> 83 78 50 00 74 48 8b 06 85 c0 74 42 41 89 d6 31 db 48 8b 85 98
[  593.947773] RSP: 0018:ffffa21300e7fde8 EFLAGS: 00010286
[  593.948562] RAX: ffffffffc07380c0 RBX: 0000000000000000 RCX: 
0000000000002ab8
[  593.949737] RDX: 0000000000000000 RSI: ffff9296971089c0 RDI: 
ffff9296975fb438
[  593.950811] RBP: ffff9296971089c0 R08: 000000000002f0e0 R09: 
ffffffffb6427890
[  593.951878] R10: ffffd41084a3fd80 R11: 0000000000000001 R12: 
ffff9296a91e58b0
[  593.952947] R13: ffff9296975fb438 R14: ffff9296ab5b2600 R15: 
ffff9296a91e6080
[  593.954011] FS:  0000000000000000(0000) GS:ffff9296bba00000(0000) 
knlGS:0000000000000000
[  593.955252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  593.956147] CR2: ffffffffc0738110 CR3: 000000011760a003 CR4: 
00000000003606f0
[  593.957249] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  593.958354] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  593.959452] Call Trace:
[  593.959877]  blk_mq_sched_tags_teardown+0x40/0x70
[  593.960628]  blk_mq_exit_sched+0x88/0xa0
[  593.961246]  elevator_exit+0x30/0x50
[  593.961817]  __blk_release_queue+0x5c/0x100
[  593.962497]  process_one_work+0x1a1/0x3a0
[  593.963138]  worker_thread+0x30/0x380
[  593.963714]  ? pwq_unbound_release_workfn+0xd0/0xd0
[  593.964479]  kthread+0x112/0x130
[  593.964992]  ? __kthread_parkme+0x70/0x70
[  593.965641]  ret_from_fork+0x35/0x40
[  593.966215] Modules linked in: sunrpc snd_hda_codec_generic 
ledtrig_audio snd_hda_intel snd_hda_codec nfit snd_hda_core libnvdimm 
snd_hwdep snd_seq crct10dif_pclmul snd_seq_device crc32_pclmul snd_pcm 
ghash_clmulni_intel snd_timer snd pcspkr joydev virtio_balloon i2c_piix4 
soundcore ip_tables xfs libcrc32c qxl drm_kms_helper ata_generic 
syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ata_piix libata 
virtio_net net_failover crc32c_intel serio_raw virtio_blk virtio_console 
failover dm_mirror dm_region_hash dm_log dm_mod [last unloaded: null_blk]
[  593.973735] CR2: ffffffffc0738110
[  593.974270] ---[ end trace 782d8ae6cfec57e7 ]---
[  593.974983] RIP: 0010:blk_mq_free_rqs+0x21/0xd0
[  593.975691] Code: c6 e8 83 f0 ff ff eb 9f 90 0f 1f 44 00 00 41 56 41 
55 41 54 55 48 89 f5 53 48 83 be 90 00 00 00 00 74 56 48 8b 47 38 49 89 
fd <48> 83 78 50 00 74 48 8b 06 85 c0 74 42 41 89 d6 31 db 48 8b 85 98
[  593.978548] RSP: 0018:ffffa21300e7fde8 EFLAGS: 00010286
[  593.979466] RAX: ffffffffc07380c0 RBX: 0000000000000000 RCX: 
0000000000002ab8
[  593.980578] RDX: 0000000000000000 RSI: ffff9296971089c0 RDI: 
ffff9296975fb438
[  593.981677] RBP: ffff9296971089c0 R08: 000000000002f0e0 R09: 
ffffffffb6427890
[  593.982780] R10: ffffd41084a3fd80 R11: 0000000000000001 R12: 
ffff9296a91e58b0
[  593.983883] R13: ffff9296975fb438 R14: ffff9296ab5b2600 R15: 
ffff9296a91e6080
[  593.984982] FS:  0000000000000000(0000) GS:ffff9296bba00000(0000) 
knlGS:0000000000000000
[  593.986239] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  593.987138] CR2: ffffffffc0738110 CR3: 000000011760a003 CR4: 
00000000003606f0
[  593.988241] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  593.989344] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  593.990447] Kernel panic - not syncing: Fatal exception
[  593.992292] Kernel Offset: 0x35000000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  593.994147] ---[ end Kernel panic - not syncing: Fatal exception ]---

On 6/4/19 9:08 PM, Ming Lei wrote:
> In theory, IO scheduler belongs to request queue, and the request pool
> of sched tags belongs to the request queue too.
>
> However, the current tags allocation interfaces are re-used for both
> driver tags and sched tags, and driver tags is definitely host wide,
> and doesn't belong to any request queue, same with its request pool.
> So we need tagset instance for freeing request of sched tags.
>
> Meantime, blk_mq_free_tag_set() often follows blk_cleanup_queue() in case
> of non-BLK_MQ_F_TAG_SHARED, this way requires that request pool of sched
> tags to be freed before calling blk_mq_free_tag_set().
>
> Commit 47cdee29ef9d94e ("block: move blk_exit_queue into __blk_release_queue")
> moves blk_exit_queue into __blk_release_queue for simplying the fast
> path in generic_make_request(), then causes oops during freeing requests
> of sched tags in __blk_release_queue().
>
> Fix the above issue by move freeing request pool of sched tags into
> blk_cleanup_queue(), this way is safe becasue queue has been frozen and no any
> in-queue requests at that time. Freeing sched tags has to be kept in queue's
> release handler becasue there might be un-completed dispatch activity
> which might refer to sched tags.
>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 47cdee29ef9d94e485eb08f962c74943023a5271 ("block: move blk_exit_queue into __blk_release_queue")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-core.c     | 13 +++++++++++++
>   block/blk-mq-sched.c | 30 +++++++++++++++++++++++++++---
>   block/blk-mq-sched.h |  1 +
>   block/blk-sysfs.c    |  2 +-
>   block/blk.h          | 10 +++++++++-
>   block/elevator.c     |  2 +-
>   6 files changed, 52 insertions(+), 6 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ee1b35fe8572..8340f69670d8 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -320,6 +320,19 @@ void blk_cleanup_queue(struct request_queue *q)
>   	if (queue_is_mq(q))
>   		blk_mq_exit_queue(q);
>   
> +	/*
> +	 * In theory, request pool of sched_tags belongs to request queue.
> +	 * However, the current implementation requires tag_set for freeing
> +	 * requests, so free the pool now.
> +	 *
> +	 * Queue has become frozen, there can't be any in-queue requests, so
> +	 * it is safe to free requests now.
> +	 */
> +	mutex_lock(&q->sysfs_lock);
> +	if (q->elevator)
> +		blk_mq_sched_free_requests(q);
> +	mutex_unlock(&q->sysfs_lock);
> +
>   	percpu_ref_exit(&q->q_usage_counter);
>   
>   	/* @q is and will stay empty, shutdown and put */
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 74c6bb871f7e..500cb04901cc 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -475,14 +475,18 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
>   	return ret;
>   }
>   
> +/* called in queue's release handler, tagset has gone away */
>   static void blk_mq_sched_tags_teardown(struct request_queue *q)
>   {
> -	struct blk_mq_tag_set *set = q->tag_set;
>   	struct blk_mq_hw_ctx *hctx;
>   	int i;
>   
> -	queue_for_each_hw_ctx(q, hctx, i)
> -		blk_mq_sched_free_tags(set, hctx, i);
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		if (hctx->sched_tags) {
> +			blk_mq_free_rq_map(hctx->sched_tags);
> +			hctx->sched_tags = NULL;
> +		}
> +	}
>   }
>   
>   int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
> @@ -523,6 +527,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>   			ret = e->ops.init_hctx(hctx, i);
>   			if (ret) {
>   				eq = q->elevator;
> +				blk_mq_sched_free_requests(q);
>   				blk_mq_exit_sched(q, eq);
>   				kobject_put(&eq->kobj);
>   				return ret;
> @@ -534,11 +539,30 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>   	return 0;
>   
>   err:
> +	blk_mq_sched_free_requests(q);
>   	blk_mq_sched_tags_teardown(q);
>   	q->elevator = NULL;
>   	return ret;
>   }
>   
> +/*
> + * called in either blk_queue_cleanup or elevator_switch, tagset
> + * is required for freeing requests
> + */
> +void blk_mq_sched_free_requests(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	int i;
> +
> +	lockdep_assert_held(&q->sysfs_lock);
> +	WARN_ON(!q->elevator);
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		if (hctx->sched_tags)
> +			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);
> +	}
> +}
> +
>   void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>   {
>   	struct blk_mq_hw_ctx *hctx;
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index c7bdb52367ac..3cf92cbbd8ac 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -28,6 +28,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
>   
>   int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
>   void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
> +void blk_mq_sched_free_requests(struct request_queue *q);
>   
>   static inline bool
>   blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 75b5281cc577..977c659dcd18 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -850,7 +850,7 @@ static void blk_exit_queue(struct request_queue *q)
>   	 */
>   	if (q->elevator) {
>   		ioc_clear_queue(q);
> -		elevator_exit(q, q->elevator);
> +		__elevator_exit(q, q->elevator);
>   		q->elevator = NULL;
>   	}
>   
> diff --git a/block/blk.h b/block/blk.h
> index 91b3581b7c7a..7814aa207153 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -6,6 +6,7 @@
>   #include <linux/blk-mq.h>
>   #include <xen/xen.h>
>   #include "blk-mq.h"
> +#include "blk-mq-sched.h"
>   
>   /* Max future timer expiry for timeouts */
>   #define BLK_MAX_TIMEOUT		(5 * HZ)
> @@ -176,10 +177,17 @@ void blk_insert_flush(struct request *rq);
>   int elevator_init_mq(struct request_queue *q);
>   int elevator_switch_mq(struct request_queue *q,
>   			      struct elevator_type *new_e);
> -void elevator_exit(struct request_queue *, struct elevator_queue *);
> +void __elevator_exit(struct request_queue *, struct elevator_queue *);
>   int elv_register_queue(struct request_queue *q);
>   void elv_unregister_queue(struct request_queue *q);
>   
> +static inline void elevator_exit(struct request_queue *q,
> +		struct elevator_queue *e)
> +{
> +	blk_mq_sched_free_requests(q);
> +	__elevator_exit(q, e);
> +}
> +
>   struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
>   
>   #ifdef CONFIG_FAIL_IO_TIMEOUT
> diff --git a/block/elevator.c b/block/elevator.c
> index ec55d5fc0b3e..2f17d66d0e61 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -178,7 +178,7 @@ static void elevator_release(struct kobject *kobj)
>   	kfree(e);
>   }
>   
> -void elevator_exit(struct request_queue *q, struct elevator_queue *e)
> +void __elevator_exit(struct request_queue *q, struct elevator_queue *e)
>   {
>   	mutex_lock(&e->sysfs_lock);
>   	if (e->type->ops.exit_sched)
