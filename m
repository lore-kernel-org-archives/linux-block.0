Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F70619D8AC
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745053304; cv=none; b=HZxNIVlOrd+xwb/V5TnKKKHy+vO5VdMwJdgxdZ4cgsLLKFqzhcLp/4xGndGohhEaf5WfLlFpvhCg83wWNEBVWEKhsZMZmhOCl3PJOe+HnIaGDdfVXH03e7IzcO2xKV0n7N01pNVooyCO7MHheRWRLrWKdgx3FgNJE7s7eJqn8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745053304; c=relaxed/simple;
	bh=eltpGH2h3Gx9suOx1o6Flhk5+aqdx0YQeGUEYOpHkzw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I43jgOzqhgPnrg6ym27EMZ5mcy7aPYcrZuTIhArlqXGA1C5emh3RemES873wdn19CPWaE2FGJcnb3IjFpYLPUc2yQZgi+rmaFVkZDxDzHTQ76Em6GRZJXPXpdLbGzVq/C97E98pG1gAV0rwuHE3P3yUYR5JZQ0/lVMaw+/OSMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zflwn6ktcz4f3jXg
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 17:01:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BAD2B1A058E
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 17:01:37 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXul5wZgNolui4Jw--.30448S3;
	Sat, 19 Apr 2025 17:01:37 +0800 (CST)
Subject: Re: [PATCH V2 03/20] block: don't call freeze queue in
 elevator_switch() and elevator_disable()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-4-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e884f679-4308-a16e-cc90-83cdc6cf25ee@huaweicloud.com>
Date: Sat, 19 Apr 2025 17:01:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250418163708.442085-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul5wZgNolui4Jw--.30448S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4DtFW8Jr4fZF4kXw4fXwb_yoW8Zr1rpr
	Z5GanrKr10qr4UZa4UAwsrX342g39Ygry3urWfA34Y9F9xKa1fW3WUGF15uF40yr4kJFsa
	vry8tFZ2ka48ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFB
	T5DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/19 0:36, Ming Lei Ð´µÀ:
> Both elevator_switch() and elevator_disable() are called from sysfs
> store and updating nr_hw_queue code paths only.
> 
> And in the two code paths, queue has been frozen already, so don't call
> freeze queue in the two functions.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/elevator.c b/block/elevator.c
> index b4d08026b02c..5051a98dc08c 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -615,12 +615,11 @@ void elevator_init_mq(struct request_queue *q)
>    */
>   int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
>   {
> -	unsigned int memflags;
>   	int ret;
>   
> +	WARN_ON_ONCE(q->mq_freeze_depth == 0);
>   	lockdep_assert_held(&q->elevator_lock);
>   
> -	memflags = blk_mq_freeze_queue(q);
>   	blk_mq_quiesce_queue(q);
>   
>   	if (q->elevator) {
> @@ -641,7 +640,6 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
>   
>   out_unfreeze:
>   	blk_mq_unquiesce_queue(q);
> -	blk_mq_unfreeze_queue(q, memflags);
>   
>   	if (ret) {
>   		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
> @@ -653,11 +651,9 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
>   
>   void elevator_disable(struct request_queue *q)
>   {
> -	unsigned int memflags;
> -
> +	WARN_ON_ONCE(q->mq_freeze_depth == 0);
>   	lockdep_assert_held(&q->elevator_lock);
>   
> -	memflags = blk_mq_freeze_queue(q);
>   	blk_mq_quiesce_queue(q);
>   
>   	elv_unregister_queue(q);
> @@ -668,7 +664,6 @@ void elevator_disable(struct request_queue *q)
>   	blk_add_trace_msg(q, "elv switch: none");
>   
>   	blk_mq_unquiesce_queue(q);
> -	blk_mq_unfreeze_queue(q, memflags);
>   }
>   
>   /*
> 

