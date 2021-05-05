Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5B9C433B4
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 11:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104E1610A7
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 11:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhEELUo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 07:20:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3002 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhEELUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 May 2021 07:20:43 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FZv8x0MP6z6wkQQ;
        Wed,  5 May 2021 19:08:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 13:19:45 +0200
Received: from [10.47.27.165] (10.47.27.165) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 5 May 2021
 12:19:44 +0100
Subject: Re: [PATCH V4 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "David Jeffery" <djeffery@redhat.com>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
 <fb0804e5-bfae-62ac-c3e6-d46a9a33ca53@huawei.com> <YJEzd8IYtw4GXrlT@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fd7a28ae-6f6f-d9a3-a7a3-b9f68970e1b7@huawei.com>
Date:   Wed, 5 May 2021 12:19:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YJEzd8IYtw4GXrlT@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.165]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/05/2021 12:43, Ming Lei wrote:
>>           */
>> -       if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
>> -               return iter_data->fn(hctx, rq, iter_data->data, reserved);
>> +       if (rq) {
>> +               mdelay(50);
>> +               if (rq->q == hctx->queue && rq->mq_hctx == hctx)
>> +   		  return iter_data->fn(hctx, rq, iter_data->data, reserved);
>> +       }
>>          return true;
>>   }
> hammmm, forget to cover bt_iter(), please test the following delta
> patch:
> 
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index a3be267212b9..27815114ee3f 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -206,18 +206,28 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	struct blk_mq_tags *tags = hctx->tags;
>   	bool reserved = iter_data->reserved;
>   	struct request *rq;
> +	unsigned long flags;
> +	bool ret = true;
>   
>   	if (!reserved)
>   		bitnr += tags->nr_reserved_tags;
> -	rq = tags->rqs[bitnr];
>   
> +	spin_lock_irqsave(&tags->lock, flags);
> +	rq = tags->rqs[bitnr];
>   	/*
>   	 * We can hit rq == NULL here, because the tagging functions
>   	 * test and set the bit before assigning ->rqs[].
>   	 */
> -	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
> -		return iter_data->fn(hctx, rq, iter_data->data, reserved);
> -	return true;
> +	if (!rq || !refcount_inc_not_zero(&rq->ref)) {
> +		spin_unlock_irqrestore(&tags->lock, flags);
> +		return true;
> +	}
> +	spin_unlock_irqrestore(&tags->lock, flags);
> +
> +	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
> +		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
> +	blk_mq_put_rq_ref(rq);
> +	return ret;
>   }


This looks to work ok from my testing.

Thanks,
John
