Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07B5D8FB
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TBGRd53ZSz4f3lg7
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 17:28:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A52861A0EB5
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 17:28:19 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHaQwUBqFl8gdrAg--.30247S2;
	Fri, 12 Jan 2024 17:28:17 +0800 (CST)
Subject: Re: [PATCH] blk-mq: fix IO hang from sbitmap wakeup race
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: David Jeffery <djeffery@redhat.com>,
 Gabriel Krisman Bertazi <krisman@suse.de>, Jan Kara <jack@suse.cz>,
 Changhui Zhong <czhong@redhat.com>
References: <20240111155448.4097173-1-ming.lei@redhat.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <89d7ce62-9539-ba26-09fa-81875a69ce3f@huaweicloud.com>
Date: Fri, 12 Jan 2024 17:27:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240111155448.4097173-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHaQwUBqFl8gdrAg--.30247S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1kGFy7WrW3Gr1DAr1DWrg_yoWrXr4DpF
	W7KFs8C3s7trWIq3yfAa13ZF1agw4kGr43Grs3Kw1ruF129F1fZr1vkF45Cw1vyFZ8C39r
	AanYyFZ3Kr1DG3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 1/11/2024 11:54 PM, Ming Lei wrote:
> In blk_mq_mark_tag_wait(), __add_wait_queue() may be re-ordered
> with the following blk_mq_get_driver_tag() in case of getting driver
> tag failure.
> 
> Then in __sbitmap_queue_wake_up(), waitqueue_active() may not observe
> the added waiter in blk_mq_mark_tag_wait() and wake up nothing, meantime
> blk_mq_mark_tag_wait() can't get driver tag successfully.
> 
> This issue can be reproduced by running the following test in loop, and
> fio hang can be observed in < 30min when running it on my test VM
> in laptop.
> 
> 	modprobe -r scsi_debug
> 	modprobe scsi_debug delay=0 dev_size_mb=4096 max_queue=1 host_max_queue=1 submit_queues=4
> 	dev=`ls -d /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/* | head -1 | xargs basename`
> 	fio --filename=/dev/"$dev" --direct=1 --rw=randrw --bs=4k --iodepth=1 \
>        		--runtime=100 --numjobs=40 --time_based --name=test \
>         	--ioengine=libaio
> 
> Fix the issue by adding one explicit barrier in blk_mq_mark_tag_wait(), which
> is just fine in case of running out of tag.
> 
> Apply the same pattern in blk_mq_get_tag() which should have same risk.
> 
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> BTW, Changhui is planning to upstream the test case to blktests.
> 
>  block/blk-mq-tag.c | 19 +++++++++++++++++++
>  block/blk-mq.c     | 16 ++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index cc57e2dd9a0b..29f77cae8eb2 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -179,6 +179,25 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  
>  		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
>  
> +		/*
> +		 * Add one explicit barrier since __blk_mq_get_tag() may not
> +		 * imply barrier in case of failure.
> +		 *
> +		 * Order adding us to wait queue and the following allocating
> +		 * tag in  __blk_mq_get_tag().
> +		 *
> +		 * The pair is the one implied in sbitmap_queue_wake_up()
> +		 * which orders clearing sbitmap tag bits and
> +		 * waitqueue_active() in __sbitmap_queue_wake_up(), since
> +		 * waitqueue_active() is lockless
> +		 *
> +		 * Otherwise, re-order of adding wait queue and getting tag
> +		 * may cause __sbitmap_queue_wake_up() to wake up nothing
> +		 * because the waitqueue_active() may not observe us in wait
> +		 * queue.
> +		 */
> +		smp_mb();
> +
Hi Ming, thanks for the fix. I'm not sure if we should explicitly imply
a memory barrier here as prepare_to_wait variants normally imply a general
memory barrier (see section "SLEEP AND WAKE-UP FUNCTIONS " in [1]).
Wish this helps!

[1] https://www.kernel.org/doc/Documentation/memory-barriers.txt


>  		tag = __blk_mq_get_tag(data, bt);
>  		if (tag != BLK_MQ_NO_TAG)
>  			break;
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index fb29ff5cc281..54545a4792bf 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1847,6 +1847,22 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
>  	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
>  	__add_wait_queue(wq, wait);
>  
> +	/*
> +	 * Add one explicit barrier since blk_mq_get_driver_tag() may
> +	 * not imply barrier in case of failure.
> +	 *
> +	 * Order adding us to wait queue and allocating driver tag.
> +	 *
> +	 * The pair is the one implied in sbitmap_queue_wake_up() which
> +	 * orders clearing sbitmap tag bits and waitqueue_active() in
> +	 * __sbitmap_queue_wake_up(), since waitqueue_active() is lockless
> +	 *
> +	 * Otherwise, re-order of adding wait queue and getting driver tag
> +	 * may cause __sbitmap_queue_wake_up() to wake up nothing because
> +	 * the waitqueue_active() may not observe us in wait queue.
> +	 */
> +	smp_mb();
> +
>  	/*
>  	 * It's possible that a tag was freed in the window between the
>  	 * allocation failure and adding the hardware queue to the wait
> 

