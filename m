Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74767462
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745053068; cv=none; b=nEwwK6gqJwsSG3ZBaLHkla2H3ZjKQ/az5tszR2hVT9bu+yZI0u7wbHZ8rxwGbpx6lXqObG7a5u0Y9mO8s+kyX9Klea4JKZg/CRE5XeqBIFygb7k2z4GVOlQMpUERh/AN8C2CSa4LdBfzb+za0MnNgnSK8iArBk1Xj1uDJSMeYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745053068; c=relaxed/simple;
	bh=B2iZLl7U7MvrQm1lhSSkmo2y7QZgNp9D5b0SXJUQeg0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=og0pjsW5b7jeX3nzvmSm+iIZBW45HZQ26twwGhrQqxYIaOvPnuDCt8HKyBjYou/rZt6csytSddooyeKL70nKLXlHGu/GGYlY4NGnfU3XzCI6x+u5zPRADWXOA28VfJilN8grzfGG0ERlePYyOrjEMJ5R2nXlZB0+GVXZJ27mAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZflrL3SLTz4f3jtP
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 16:57:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EA4E31A1BB1
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 16:57:40 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2CBZQNoDKS4Jw--.31843S3;
	Sat, 19 Apr 2025 16:57:39 +0800 (CST)
Subject: Re: [PATCH V2 01/20] block: move blk_mq_add_queue_tag_set() after
 blk_mq_map_swqueue()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-2-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6d5a0068-4be8-62d3-f1f0-118671e29956@huaweicloud.com>
Date: Sat, 19 Apr 2025 16:57:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250418163708.442085-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2CBZQNoDKS4Jw--.31843S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryfGF1rCF4kXw4DAFW5KFg_yoW8Gr1UpF
	WxJ3W2k34xtF4UX3y0qa1fWFy5tws8Wr13Gwsaqrn8u3sFgrs2vr1IqF4DXr4vvrWkCFsx
	tr1xJFWkKa4DWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Upyx
	iUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/19 0:36, Ming Lei Ð´µÀ:
> Move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue(), and publish
> this request queue to tagset after everything is setup.
> 
> This way is safe because BLK_MQ_F_TAG_QUEUE_SHARED isn't used by
> blk_mq_map_swqueue(), and this flag is mainly checked in fast IO code
> path.
> 
> Prepare for removing ->elevator_lock from blk_mq_map_swqueue() which
> is supposed to be called when elevator switch isn't possible.

I think you mean *is* possible? Or to protect against switching
elevator concurrently?
> 
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-block/567cb7ab-23d6-4cee-a915-c8cdac903ddd@linux.ibm.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e0fe12f1320f..7cda919fafba 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4561,8 +4561,8 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   	q->nr_requests = set->queue_depth;
>   
>   	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
> -	blk_mq_add_queue_tag_set(set, q);
>   	blk_mq_map_swqueue(q);
> +	blk_mq_add_queue_tag_set(set, q);
>   	return 0;
>   
>   err_hctxs:
> 

