Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142084414
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751505323; cv=none; b=Uv/z5MDGde7fEWkDANKf5br1IOfvizU9C1RkBkWJ/fE0gt1B/vQKB/3nsgq+Kw8P2CS6d5HkipHcoRFLJDoB5meCo+HaEaosBkzRV2xoDGkQWvrlIza5NytY8VqXpMAUoS/tpg5Keu29ykOQTM2cBCAjPwGg8z1ULBnXz2OLmPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751505323; c=relaxed/simple;
	bh=WWB7cAuBhfJKVyLwOUAanSZrcvGf/Lj9g7CoSJsJLe8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YUDcl+AD1BW7YfslL9jyhfLzq317uI+8tIqMKAAyxOycr+UnCYXpwaWS73PKrGkPlcSueE7afxittqDIjPv8ZtFh80lG7OzdGgaXuC7hValLC+hJ4pojT3ja9RM6IRdhW/+uSmDOPsh5RC5jbiFBtcFX7LXOCBKBWPxww0C9mBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bXf2V2146zKHMmk
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 09:15:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AE8F51A119D
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 09:15:12 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP3 (Coremail) with SMTP id _Ch0CgDnSCae2WVogG_nAQ--.64632S3;
	Thu, 03 Jul 2025 09:15:12 +0800 (CST)
Subject: Re: [PATCH 2/8] block: Do not run frozen queues
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250702203845.3844510-1-bvanassche@acm.org>
 <20250702203845.3844510-3-bvanassche@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <699f9f38-009f-c5da-dfd3-60531e16c1ce@huaweicloud.com>
Date: Thu, 3 Jul 2025 09:15:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250702203845.3844510-3-bvanassche@acm.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnSCae2WVogG_nAQ--.64632S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kurW7ZrWkZFWxuw4kJFb_yoW8Cr17pF
	Z3ta13C348XFW0y3W7ta17Jry3WrsxKrZrurZ3AFy5Jw1qg342vr18K39YvFWIvrs3A3y3
	Zr4UJa9xuw1kZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/07/03 4:38, Bart Van Assche Ð´µÀ:
> If a request queue is frozen there are no requests pending and hence it
> is not necessary to run a request queue.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7919607c1aeb..91b9fc1a7ddb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2298,16 +2298,16 @@ static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hctx)
>   	bool need_run;
>   
>   	/*
> -	 * When queue is quiesced, we may be switching io scheduler, or
> -	 * updating nr_hw_queues, or other things, and we can't run queue
> -	 * any more, even blk_mq_hctx_has_pending() can't be called safely.
> -	 *
> -	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
> -	 * quiesced.
> +	 * The request queue is frozen when the e.g. the I/O scheduler is
> +	 * changed and also when nr_hw_queues is updated. Neither running the
> +	 * queue nor calling blk_mq_hctx_has_pending() is safe during these
> +	 * operations. Hence, check whether the queue is frozen before checking
> +	 * whether any requests are pending.
>   	 */
>   	__blk_mq_run_dispatch_ops(hctx->queue, false,
> -		need_run = !blk_queue_quiesced(hctx->queue) &&
> -		blk_mq_hctx_has_pending(hctx));
> +		need_run = !blk_queue_frozen(hctx->queue) &&
> +			   !blk_queue_quiesced(hctx->queue) &&
> +			   blk_mq_hctx_has_pending(hctx));

Just a question, blk_mq_quiesce_queue also calls synchronize_rcu() to
wait for inflight dispatch work to be done, is it safe in following
patches? I think it's not, dispatch work can be running while there is
no request pending, menas queue can be frozen with active dispatch work.

Thanks,
Kuai

>   	return need_run;
>   }
>   
> 
> 
> .
> 

