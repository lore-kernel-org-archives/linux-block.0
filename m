Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D5189BAC
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745054928; cv=none; b=bcQLoR6m8G9EJJXkFP26qBjqEJUTdXKSp3gKaqLbDeLFZCwU4Qz51T8mCrFbzDPUPYIRkF9yRv6sg3/8/jkiaDjTXw+Z10VT0PPdr7WOJL9jFUPC0fUR2A5tZlj++egNdzyyuVYR+Apq+PgCQqwBvToseMkWIMGN2s4PvUVe9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745054928; c=relaxed/simple;
	bh=7iuFP6IZ9CnR4CN/ALm/LA08HhrMvw7pBqcjXBPRpD4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CoZLCHSHQ0e85M/IkRccpobtrVNNEz8rF+quOca0h89ZzOjjidwApNXpxSHDce075/0YKbrLBO+H7pCKSnrf8kMMsAiRWC000fP05TNf1O5U+bZZbnESEF2FFH2Bgx+9LwDWD4iF+LwHpjyhTOBLcUfRR/GJ4TfphPCyA237KAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZfmX05XZmz4f3jcs
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 17:28:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 912631A058E
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 17:28:40 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGDGbANoVbu6Jw--.42103S3;
	Sat, 19 Apr 2025 17:28:40 +0800 (CST)
Subject: Re: [PATCH V2 05/20] block: move sched debugfs register into
 elvevator_register_queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-6-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4dcb34e7-6032-5dfe-14f4-4b86a9a08b46@huaweicloud.com>
Date: Sat, 19 Apr 2025 17:28:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250418163708.442085-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGDGbANoVbu6Jw--.42103S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXryfWr1kZw1DXw18tFyDtrb_yoWrZF1fpa
	n8Wa15Kr10qr4UZFW5Ca17JryfG3929ry7CayfZ34Fkr93Kr1fWF18GFW7XrWxXrZ7CF47
	Ar15Ka9rtF1UKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/19 0:36, Ming Lei Ð´µÀ:
> sched debugfs shares same lifetime with scheduler's kobject, and same
> lock(elevator lock), so move sched debugfs register/unregister into
> elevator_register_queue() and elevator_unregister_queue().
> 
> Then we needn't blk_mq_debugfs_register() for us to register sched
> debugfs any more.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c | 11 -----------
>   block/blk-mq-sched.c   | 11 ++---------
>   block/elevator.c       |  8 ++++++++
>   block/elevator.h       |  3 +++
>   4 files changed, 13 insertions(+), 20 deletions(-)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 31e249a18407..0fa0f8836b7d 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -625,20 +625,9 @@ void blk_mq_debugfs_register(struct request_queue *q)
>   
>   	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
>   
> -	/*
> -	 * blk_mq_init_sched() attempted to do this already, but q->debugfs_dir
> -	 * didn't exist yet (because we don't know what to name the directory
> -	 * until the queue is registered to a gendisk).
> -	 */
> -	if (q->elevator && !q->sched_debugfs_dir)
> -		blk_mq_debugfs_register_sched(q);
> -
> -	/* Similarly, blk_mq_init_hctx() couldn't do this previously. */
>   	queue_for_each_hw_ctx(q, hctx, i) {
>   		if (!hctx->debugfs_dir)
>   			blk_mq_debugfs_register_hctx(q, hctx);
> -		if (q->elevator && !hctx->sched_debugfs_dir)
> -			blk_mq_debugfs_register_sched_hctx(q, hctx);
>   	}
>   
>   	if (q->rq_qos) {
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 2abc5e0704e8..336a15ffecfa 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -434,7 +434,7 @@ static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
>   	return 0;
>   }
>   
> -static void blk_mq_sched_reg_debugfs(struct request_queue *q)
> +void blk_mq_sched_reg_debugfs(struct request_queue *q)
>   {
>   	struct blk_mq_hw_ctx *hctx;
>   	unsigned long i;
> @@ -446,7 +446,7 @@ static void blk_mq_sched_reg_debugfs(struct request_queue *q)
>   	mutex_unlock(&q->debugfs_mutex);
>   }
>   
> -static void blk_mq_sched_unreg_debugfs(struct request_queue *q)
> +void blk_mq_sched_unreg_debugfs(struct request_queue *q)
>   {
>   	struct blk_mq_hw_ctx *hctx;
>   	unsigned long i;
> @@ -503,10 +503,6 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>   			}
>   		}
>   	}
> -
> -	/* sched is initialized, it is ready to export it via debugfs */
> -	blk_mq_sched_reg_debugfs(q);
> -
>   	return 0;
>   
>   err_free_map_and_rqs:
> @@ -544,9 +540,6 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>   	unsigned long i;
>   	unsigned int flags = 0;
>   
> -	/* unexport via debugfs before exiting sched */
> -	blk_mq_sched_unreg_debugfs(q);
> -
>   	queue_for_each_hw_ctx(q, hctx, i) {
>   		if (e->type->ops.exit_hctx && hctx->sched_data) {
>   			e->type->ops.exit_hctx(hctx, i);
> diff --git a/block/elevator.c b/block/elevator.c
> index 5051a98dc08c..d25b9cc6c509 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -472,6 +472,11 @@ int elv_register_queue(struct request_queue *q, bool uevent)
>   		if (uevent)
>   			kobject_uevent(&e->kobj, KOBJ_ADD);
>   
> +		/*
> +		 * Sched is initialized, it is ready to export it via
> +		 * debugfs
> +		 */
> +		blk_mq_sched_reg_debugfs(q);
>   		set_bit(ELEVATOR_FLAG_REGISTERED, &e->flags);
>   	}
>   	return error;
> @@ -486,6 +491,9 @@ void elv_unregister_queue(struct request_queue *q)
>   	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
>   		kobject_uevent(&e->kobj, KOBJ_REMOVE);
>   		kobject_del(&e->kobj);
> +
> +		/* unexport via debugfs before exiting sched */
> +		blk_mq_sched_unreg_debugfs(q);
>   	}
>   }
>   
> diff --git a/block/elevator.h b/block/elevator.h
> index e27af5492cdb..9198676644a9 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -181,4 +181,7 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
>   #define rq_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
>   #define rq_fifo_clear(rq)	list_del_init(&(rq)->queuelist)
>   
> +void blk_mq_sched_reg_debugfs(struct request_queue *q);
> +void blk_mq_sched_unreg_debugfs(struct request_queue *q);
> +
>   #endif /* _ELEVATOR_H */
> 

