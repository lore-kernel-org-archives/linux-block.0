Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0095BC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1D660EB1
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhJRJdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:33:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3997 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhJRJdO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:33:14 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HXs2k4gW6z687SH;
        Mon, 18 Oct 2021 17:26:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 11:30:56 +0200
Received: from [10.47.85.98] (10.47.85.98) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 10:30:55 +0100
Subject: Re: [PATCH] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
To:     Ming Lei <ming.lei@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        "hare@suse.de" <hare@suse.de>
References: <1634114459-143003-1-git-send-email-john.garry@huawei.com>
 <YWalYoOZmpkmAZNK@T590> <79266509-f327-9de3-d22e-0e9fe00387ee@huawei.com>
 <YWay/n+BJTLm1Alb@T590> <9f3c4d57-6b77-5345-0d4c-275962214b2a@huawei.com>
 <YWbtRm22vohvY0Ca@T590> <7e142559-1c96-8d84-081a-378c1f6d1306@huawei.com>
 <1065f517-c94b-5a47-34f6-52015b3ef907@huawei.com> <YW05XGjO8KfYp9xp@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0e5edb01-08a3-3c97-35e4-97587c864657@huawei.com>
Date:   Mon, 18 Oct 2021 10:33:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YW05XGjO8KfYp9xp@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.85.98]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/10/2021 10:07, Ming Lei wrote:
> On Mon, Oct 18, 2021 at 09:08:57AM +0100, John Garry wrote:
>> On 13/10/2021 16:13, John Garry wrote:
>>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>>> index 72a2724a4eee..2a2ad6dfcc33 100644
>>>> --- a/block/blk-mq-tag.c
>>>> +++ b/block/blk-mq-tag.c
>>>> @@ -232,8 +232,9 @@ static bool bt_iter(struct sbitmap *bitmap,
>>>> unsigned int bitnr, void *data)
>>>>        if (!rq)
>>>>            return true;
>>>> -    if (rq->q == hctx->queue && rq->mq_hctx == hctx)
>>>> -        ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
>>>> +    if (rq->q == hctx->queue && (rq->mq_hctx == hctx ||
>>>> +                blk_mq_is_shared_tags(hctx->flags)))
>>>> +        ret = iter_data->fn(rq->mq_hctx, rq, iter_data->data, reserved);
>>>>        blk_mq_put_rq_ref(rq);
>>>>        return ret;
>>>>    }
>>>> @@ -460,6 +461,9 @@ void blk_mq_queue_tag_busy_iter(struct
>>>> request_queue *q, busy_iter_fn *fn,
>>>>            if (tags->nr_reserved_tags)
>>>>                bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
>>>>            bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
>>>> +
>>>> +        if (blk_mq_is_shared_tags(hctx->flags))
>>>> +            break;
>>>>        }
>>>>        blk_queue_exit(q);
>>>>    }
>>>>
>>> I suppose that is ok, and means that we iter once.
>>>
>>> However, I have to ask, where is the big user of
>>> blk_mq_queue_tag_busy_iter() coming from? I saw this from Kashyap's
>>> mail:
>>>
>>>   > 1.31%     1.31%  kworker/57:1H-k  [kernel.vmlinux]
>>>   >       native_queued_spin_lock_slowpath
>>>   >       ret_from_fork
>>>   >       kthread
>>>   >       worker_thread
>>>   >       process_one_work
>>>   >       blk_mq_timeout_work
>>>   >       blk_mq_queue_tag_busy_iter
>>>   >       bt_iter
>>>   >       blk_mq_find_and_get_req
>>>   >       _raw_spin_lock_irqsave
>>>   >       native_queued_spin_lock_slowpath
>>>
>>> How or why blk_mq_timeout_work()?
>> Just some update: I tried hisi_sas with 10x SAS SSDs, megaraid sas with 1x
>> SATA HDD (that's all I have), and null blk with lots of devices, and I still
>> can't see high usage of blk_mq_queue_tag_busy_iter().
> It should be triggered easily in case of heavy io accounting:
> 
> while true; do cat /proc/diskstats; done
> 

Let me check that.

> 
>> So how about we get this patch processed (to fix blk_mq_tagset_busy_iter()),
>> as it is independent of blk_mq_queue_tag_busy_iter()? And then wait for some
>> update or some more info from Kashyap regarding blk_mq_queue_tag_busy_iter()
> Looks fine:
> 
> Reviewed-by: Ming Lei<ming.lei@redhat.com>

Thanks, I'll just send a v2 with your tag for clarity, as there has been 
much discussion here.

John
