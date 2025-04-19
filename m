Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51B6134AC
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745054300; cv=none; b=BrVjRP/02Q0u8Lf3g9+/87dB39AnMvVpP5pD5oXnWzZ5jWTg4aWPSVq0WmkDubCe6NKu0ifWRj93MDpiN+sK5K7vUoG3kMHeZQ2JI6DgDPIF/r9vyUSynQqm19fdGb1mr+6gxTSxGxbKy2bEKYdUQooHFQ/sHH0uT8n5/o4kAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745054300; c=relaxed/simple;
	bh=tkukT9BwOaMpTMOuhQLTpX9pJl6ZlZVRNB52O4U2Plg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LGsv0nJ1dXTY0hvpj7SVtJXrbZh4E6SJOCjoJ6TPKnoKdap/9TkjdH16V0BfLlRvYYRFpWjxaqzVWG4Sb2LRZWdOKMHLtTdYW8VW+aEeUa7dsnhCtw5aZcv0rv6s+5B08HuRJUrLXdifLi+fW4DJ2b3zQb8PTXdK0QTdCTPKqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZfmJ13SSmz4f3jZd
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 17:17:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EA5AE1A058E
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 17:18:11 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl9SagNoNgW6Jw--.31838S3;
	Sat, 19 Apr 2025 17:18:11 +0800 (CST)
Subject: Re: [PATCH V2 04/20] block: add two helpers for
 registering/un-registering sched debugfs
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-5-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <93f4c2c5-180c-cd5a-3b59-b2c63dee602f@huaweicloud.com>
Date: Sat, 19 Apr 2025 17:18:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250418163708.442085-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl9SagNoNgW6Jw--.31838S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1xGFWfJFWDtFWftr43Wrg_yoW5tF48pa
	1DWa13tr1Fqr48ZFW3Cw47Xr93G392gFW7XrWfJF1F9w1DKr1SgF48tay7ZrWxWrWkAr42
	yF15K3sIgr1UtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	veHDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/19 0:36, Ming Lei Ð´µÀ:
> Add blk_mq_sched_reg_debugfs()/blk_mq_sched_unreg_debugfs() to clean up
> sched init/exit code a bit.
> 
> Register & unregister debugfs for sched & sched_hctx order is changed a
> bit, but it is safe because sched & sched_hctx is guaranteed to be ready
> when exporting via debugfs.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-sched.c | 45 +++++++++++++++++++++++++++++---------------
>   1 file changed, 30 insertions(+), 15 deletions(-)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 9b81771774ef..2abc5e0704e8 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -434,6 +434,30 @@ static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
>   	return 0;
>   }
>   
> +static void blk_mq_sched_reg_debugfs(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	mutex_lock(&q->debugfs_mutex);
> +	blk_mq_debugfs_register_sched(q);
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		blk_mq_debugfs_register_sched_hctx(q, hctx);
> +	mutex_unlock(&q->debugfs_mutex);
> +}
> +
> +static void blk_mq_sched_unreg_debugfs(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	mutex_lock(&q->debugfs_mutex);
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		blk_mq_debugfs_unregister_sched_hctx(hctx);
> +	blk_mq_debugfs_unregister_sched(q);
> +	mutex_unlock(&q->debugfs_mutex);
> +}
> +
>   /* caller must have a reference to @e, will grab another one if successful */
>   int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>   {
> @@ -467,10 +491,6 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>   	if (ret)
>   		goto err_free_map_and_rqs;
>   
> -	mutex_lock(&q->debugfs_mutex);
> -	blk_mq_debugfs_register_sched(q);
> -	mutex_unlock(&q->debugfs_mutex);
> -
>   	queue_for_each_hw_ctx(q, hctx, i) {
>   		if (e->ops.init_hctx) {
>   			ret = e->ops.init_hctx(hctx, i);
> @@ -482,11 +502,11 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>   				return ret;
>   			}
>   		}
> -		mutex_lock(&q->debugfs_mutex);
> -		blk_mq_debugfs_register_sched_hctx(q, hctx);
> -		mutex_unlock(&q->debugfs_mutex);
>   	}
>   
> +	/* sched is initialized, it is ready to export it via debugfs */
> +	blk_mq_sched_reg_debugfs(q);
> +
>   	return 0;
>   
>   err_free_map_and_rqs:
> @@ -524,11 +544,10 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>   	unsigned long i;
>   	unsigned int flags = 0;
>   
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		mutex_lock(&q->debugfs_mutex);
> -		blk_mq_debugfs_unregister_sched_hctx(hctx);
> -		mutex_unlock(&q->debugfs_mutex);
> +	/* unexport via debugfs before exiting sched */
> +	blk_mq_sched_unreg_debugfs(q);
>   
> +	queue_for_each_hw_ctx(q, hctx, i) {
>   		if (e->type->ops.exit_hctx && hctx->sched_data) {
>   			e->type->ops.exit_hctx(hctx, i);
>   			hctx->sched_data = NULL;
> @@ -536,10 +555,6 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>   		flags = hctx->flags;
>   	}
>   
> -	mutex_lock(&q->debugfs_mutex);
> -	blk_mq_debugfs_unregister_sched(q);
> -	mutex_unlock(&q->debugfs_mutex);
> -
>   	if (e->type->ops.exit_sched)
>   		e->type->ops.exit_sched(e);
>   	blk_mq_sched_tags_teardown(q, flags);
> 

