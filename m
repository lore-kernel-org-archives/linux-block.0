Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF4FC77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 01:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjEQB0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 21:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjEQB0L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 21:26:11 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7532A1A7
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 18:26:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QLb633BZ7z4f3jR3
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 09:26:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77IrLWRkml9oJg--.54651S3;
        Wed, 17 May 2023 09:26:05 +0800 (CST)
Subject: Re: [PATCH] block: BFQ: Add several invariant checks
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230516223853.1385255-1-bvanassche@acm.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <47edc92d-129d-10d2-8a2e-9870d8748be4@huaweicloud.com>
Date:   Wed, 17 May 2023 09:26:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230516223853.1385255-1-bvanassche@acm.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77IrLWRkml9oJg--.54651S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AryxWFyfCrW5Ar4DCF17ZFb_yoW8Cr43pa
        95tr13Gr15Jr4a9r4Uta1DZwn3Ga1fKrnFgry8X3yjqr93ZFsIq3ZIyFyFqF40qr97ur43
        ZF1Yg397XF1jya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2023/05/17 6:38, Bart Van Assche Ð´µÀ:
> If anything goes wrong with the counters that track the number of
> requests, I/O locks up. Make such scenarios easier to debug by adding
> invariant checks for the request counters. Additionally, check that
> BFQ queues are empty before these are freed.

Is there any real problems related to those counters?

Thanks,
Kuai
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/bfq-iosched.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 3164e3177965..c5727afad159 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5403,6 +5403,9 @@ void bfq_put_queue(struct bfq_queue *bfqq)
>   	if (bfqq->bfqd->last_completed_rq_bfqq == bfqq)
>   		bfqq->bfqd->last_completed_rq_bfqq = NULL;
>   
> +	WARN_ON_ONCE(!list_empty(&bfqq->fifo));
> +	WARN_ON_ONCE(!RB_EMPTY_ROOT(&bfqq->sort_list));
> +
>   	kmem_cache_free(bfq_pool, bfqq);
>   	bfqg_and_blkg_put(bfqg);
>   }
> @@ -7135,6 +7138,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
>   {
>   	struct bfq_data *bfqd = e->elevator_data;
>   	struct bfq_queue *bfqq, *n;
> +	unsigned int actuator;
>   
>   	hrtimer_cancel(&bfqd->idle_slice_timer);
>   
> @@ -7143,6 +7147,11 @@ static void bfq_exit_queue(struct elevator_queue *e)
>   		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
>   	spin_unlock_irq(&bfqd->lock);
>   
> +	for (actuator = 0; actuator < bfqd->num_actuators; actuator++)
> +		WARN_ON_ONCE(bfqd->rq_in_driver[actuator]);
> +	WARN_ON_ONCE(bfqd->tot_rq_in_driver);
> +	WARN_ON_ONCE(bfqq->dispatched);
> +
>   	hrtimer_cancel(&bfqd->idle_slice_timer);
>   
>   	/* release oom-queue reference to root group */
> 
> .
> 

