Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D32E36F4
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287621; cv=none; b=sDxlUT1ssRUPozz0IgkXBKJ0aRDuY7bZ1jXkmUPIzbAYCtcOtArttMpEakp4TG/0v/GcQCr8KzpvIS2zW3BcBXJsfIPBFMV+jRf2o3wuxaom1URVdiFtlRoaGisBXiMjXwZebiLFYlkLZmrs3agOlAg2c6CchfHiQTEd98tu94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287621; c=relaxed/simple;
	bh=6mnJ+7Q9WbjQDwZzgiCd0osP2ylraq/FvBJtr+Jf8Sw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X/4b6799Vwnw97Uqt5DFU85k8ilm8rgriTTjPq9cMHnWvkMbdXtIBVyNLOAA4s/V3eyrsJof51aFhpxrfFOakByUHbNEvhf9Bf/jVTvdUJvoNfbUW7O7jjV7cdV/iK4ZMzUl+ohg0il8IrpvDdz0NrWFlqEtvLeNQmTbxq/R8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bwR0J0MY5zYQts9
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 14:06:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B10AA1A1CFA
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 14:06:54 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXkxP9TZBo9M4OCg--.65022S3;
	Mon, 04 Aug 2025 14:06:54 +0800 (CST)
Subject: Re: [PATCH 1/5] blk-mq: Move flush queue allocation into
 blk_mq_init_hctx()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-2-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <75912c06-a380-f6e8-e36e-2428b176939d@huaweicloud.com>
Date: Mon, 4 Aug 2025 14:06:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250801114440.722286-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXkxP9TZBo9M4OCg--.65022S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy8ZFyktw4DKr4xXr1UJrb_yoW5Zw1DpF
	WUJay5KrWSqr1DuFWDJ39rJ34aqwsxKr92krsayFWFvw129r1ftr4xGry8ZFyIkr4kCFs7
	Gr4DK398Zr1Fq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/01 19:44, Ming Lei Ð´µÀ:
> Move flush queue allocation into blk_mq_init_hctx() and its release into
> blk_mq_exit_hctx(), and prepare for replacing tags->lock with SRCU to
> draining inflight request walking. blk_mq_exit_hctx() is the last chance
> for us to get valid `tag_set` reference, and we need to add one SRCU to
> `tag_set` for freeing flush request via call_srcu().
> 
> It is safe to move flush queue & request release into blk_mq_exit_hctx(),
> because blk_mq_clear_flush_rq_mapping() clears the flush request
> reference int driver tags inflight request table, meantime inflight
> request walking is drained.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-sysfs.c |  1 -
>   block/blk-mq.c       | 20 +++++++++++++-------
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 24656980f443..c8dfed6c1c96 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -34,7 +34,6 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
>   	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
>   						  kobj);
>   
> -	blk_free_flush_queue(hctx->fq);
>   	sbitmap_free(&hctx->ctx_map);
>   	free_cpumask_var(hctx->cpumask);
>   	kfree(hctx->ctxs);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9692fa4c3ef2..c6a1366dbe77 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3939,6 +3939,9 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>   	if (set->ops->exit_hctx)
>   		set->ops->exit_hctx(hctx, hctx_idx);
>   
> +	blk_free_flush_queue(hctx->fq);
> +	hctx->fq = NULL;
> +
>   	xa_erase(&q->hctx_table, hctx_idx);
>   
>   	spin_lock(&q->unused_hctx_lock);
> @@ -3964,13 +3967,19 @@ static int blk_mq_init_hctx(struct request_queue *q,
>   		struct blk_mq_tag_set *set,
>   		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
>   {
> +	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
> +
> +	hctx->fq = blk_alloc_flush_queue(hctx->numa_node, set->cmd_size, gfp);
> +	if (!hctx->fq)
> +		goto fail;
> +
>   	hctx->queue_num = hctx_idx;
>   
>   	hctx->tags = set->tags[hctx_idx];
>   
>   	if (set->ops->init_hctx &&
>   	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
> -		goto fail;
> +		goto fail_free_fq;
>   
>   	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
>   				hctx->numa_node))
> @@ -3987,6 +3996,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
>    exit_hctx:
>   	if (set->ops->exit_hctx)
>   		set->ops->exit_hctx(hctx, hctx_idx);
> + fail_free_fq:
> +	blk_free_flush_queue(hctx->fq);
> +	hctx->fq = NULL;
>    fail:
>   	return -1;
>   }
> @@ -4038,16 +4050,10 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
>   	init_waitqueue_func_entry(&hctx->dispatch_wait, blk_mq_dispatch_wake);
>   	INIT_LIST_HEAD(&hctx->dispatch_wait.entry);
>   
> -	hctx->fq = blk_alloc_flush_queue(hctx->numa_node, set->cmd_size, gfp);
> -	if (!hctx->fq)
> -		goto free_bitmap;
> -
>   	blk_mq_hctx_kobj_init(hctx);
>   
>   	return hctx;
>   
> - free_bitmap:
> -	sbitmap_free(&hctx->ctx_map);
>    free_ctxs:
>   	kfree(hctx->ctxs);
>    free_cpumask:
> 

