Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB60BC433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 22:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60D42065C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 22:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgG2WnE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:43:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36346 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgG2WnD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 18:43:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so4482309wmi.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 15:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MWjF3HbsC/pVq1Z8mpgu7GI/fnhsgxEX3i7QRsdx17c=;
        b=h4I/bPcTgfd2e7RnCsmF9+GbypZzPVWxfxllazcULKl6g/Pv53M1m7xESBPfw6+Wlr
         ZhgpYA/KB3/ifMTaNUlGB4Is82KV2qNWtHdOuYCjO7eSk2umi3qDR6PY/60FMi4pm2nZ
         zFKC/hGKTff5rT8upsQ0Csj+2Tp/Wp5XB7KTpD1L8L6HyWDd8KHh4ykG5aJLMpEV+95F
         roLm91cRTiVkEPHEx7cgUBvzZjTf1HVcQmZMXrN/Op3tiCCfEa4MI0TV0hgdQ5TWnQqn
         kUkYiwQhAxwiA9gZpEtqQLvKHK+WvhZTwZJWPXqIg1fDmnZhfpbITbcHwRK1YndZoAbz
         1bmA==
X-Gm-Message-State: AOAM533xg0iM/RAdAbk1hBWcJtCI1jHZXnDpIjuJ5E2ymdZFncQyHMP6
        i9YZIGc49Tr6NRJcdGFAQhs=
X-Google-Smtp-Source: ABdhPJzVLpvDifn1j2N4OTLjsOvIoWtha3wdFxOumkZSmLcm8Y7gwXjP6AWCXcY3GtuPvNTJFptqjQ==
X-Received: by 2002:a1c:5982:: with SMTP id n124mr10692128wmb.77.1596062555026;
        Wed, 29 Jul 2020 15:42:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:11db:a722:81b1:7143? ([2601:647:4802:9070:11db:a722:81b1:7143])
        by smtp.gmail.com with ESMTPSA id z127sm7148424wme.44.2020.07.29.15.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 15:42:34 -0700 (PDT)
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
 <20200729161229.GA3136267@dhcp-10-100-145-180.wdl.wdc.com>
 <20200729221646.GA1706771@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b45fe77d-b09f-3649-8167-37ae13611093@grimberg.me>
Date:   Wed, 29 Jul 2020 15:42:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729221646.GA1706771@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>   void blk_mq_quiesce_queue(struct request_queue *q)
>>>   {
>>> -	struct blk_mq_hw_ctx *hctx;
>>> -	unsigned int i;
>>> -	bool rcu = false;
>>> -
>>>   	blk_mq_quiesce_queue_nowait(q);
>>>   
>>> -	queue_for_each_hw_ctx(q, hctx, i) {
>>> -		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>> -			synchronize_srcu(hctx->srcu);
>>> -		else
>>> -			rcu = true;
>>> -	}
>>> -	if (rcu)
>>> +	if (q->tag_set->flags & BLK_MQ_F_BLOCKING) {
>>> +		percpu_ref_kill(&q->dispatch_counter);
>>> +		wait_event(q->mq_quiesce_wq,
>>> +				percpu_ref_is_zero(&q->dispatch_counter));
>>> +	} else
>>>   		synchronize_rcu();
>>>   }
>>
>>
>>
>>> +static void hctx_lock(struct blk_mq_hw_ctx *hctx)
>>>   {
>>> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
>>> -		/* shut up gcc false positive */
>>> -		*srcu_idx = 0;
>>> +	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
>>>   		rcu_read_lock();
>>> -	} else
>>> -		*srcu_idx = srcu_read_lock(hctx->srcu);
>>> +	else
>>> +		percpu_ref_get(&hctx->queue->dispatch_counter);
>>>   }
>>
>> percpu_ref_get() will always succeed, even after quiesce kills it.
>> Isn't it possible that 'percpu_ref_is_zero(&q->dispatch_counter))' may
>> never reach 0? We only need to ensure that dispatchers will observe
>> blk_queue_quiesced(). That doesn't require that there are no current
>> dispatchers.
> 
> IMO it shouldn't be one issue in reality, because:
> 
> - when dispatch can't make progress, the submission side will finally
>    stop because we either run queue from submission side or request
>    completion
>   
> - submission side stops because we always have very limited requests
> 
> - completion side stops because requests queued to device is limited
> too

I don't think that any requests should pass after the kill was called,
otherwise how can we safely quiesce if requests can come in after
it?

> 
> We still can handle this case by not dispatch in case that percpu_ref_tryget()

You meant tryget_live right?

> returns false, which will change the usage into the following way:
> 
>          if (hctx_lock(hctx)) {
>          	blk_mq_sched_dispatch_requests(hctx);
>          	hctx_unlock(hctx);
> 		}
> 
> And __blk_mq_try_issue_directly() needs a bit special treatment because
> the request has to be inserted to queue after queue becomes quiesced.

Agreed.
