Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF70C433DF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 03:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228522072E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 03:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgG1D3v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:29:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32790 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgG1D3v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 23:29:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id f18so16809541wrs.0
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 20:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7myqsClUVVLv5WyDQfP9pAmnSNXqqcC+JbgkSGf7s8s=;
        b=CH+BAKKN+3FumncZK4fzrisOtcsRwRS2f7NNZ0lFqEXJNx84kiT0mUNfCpkJdTYiVQ
         M78eu22IPu78g9jkEAuZM+TlrnbfW3aZMa1ARd6fy1s9AObMa56IlaMEcHXjor99QFNv
         YmMUQn19Ym+oQTdD9nSbbcT6hfxSp5TKhyelxG0XKjHXi0Iwxt0bm2qDIDu4rkUOw402
         I4gXbqsYn5pssE/jNv0Y4r731lkRaTS53ilmxznFDJfbWaprC/jLbM8c4Gj0e7p668au
         dJy5Kz26gzBUvbJlyB7UBNbhLizMAINGCrTEHSdFNNDuSxpXQFKNzGhAJcnoykfuIhHB
         pFqQ==
X-Gm-Message-State: AOAM532zMhl1VwFy1Fc8+4zwdI0mzLy36O1pl1pSKQA/ulnuDQc+D0cd
        xDHfgSh0Ue3eA6NJARH5y3A=
X-Google-Smtp-Source: ABdhPJxwUPpUnZrE5NLRpGm4WZS+zBVXqLngl5+LubDWnV0xHAjB4+UKCrl9e5Ssc3Tsmjl2xtJ5Hg==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr23062487wrs.368.1595906988919;
        Mon, 27 Jul 2020 20:29:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id k1sm6593984wrw.91.2020.07.27.20.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 20:29:48 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Ming Lin <mlin@kernel.org>, Chao Leng <lengchao@huawei.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728014038.GA1305646@T590>
 <1d119df0-c3af-2dfa-d569-17109733ac80@kernel.dk>
 <20200728021744.GB1305646@T590>
 <5fce2096-2ed2-b396-76a7-5fb8ea97a389@kernel.dk>
 <20200728022802.GC1305646@T590>
 <baede23a-94c1-1494-bcca-964e1396f253@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0af89fcf-3505-acb1-6c91-1fff8e53b146@grimberg.me>
Date:   Mon, 27 Jul 2020 20:29:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <baede23a-94c1-1494-bcca-964e1396f253@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>>> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
>>>>>>> +{
>>>>>>> +	struct blk_mq_hw_ctx *hctx;
>>>>>>> +	unsigned int i;
>>>>>>> +
>>>>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>>>>> +
>>>>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>>>>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
>>>>>>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
>>>>>>> +		if (!hctx->rcu_sync)
>>>>>>> +			continue;
>>>>>>
>>>>>> This approach of quiesce/unquiesce tagset is good abstraction.
>>>>>>
>>>>>> Just one more thing, please allocate a rcu_sync array because hctx is
>>>>>> supposed to not store scratch stuff.
>>>>>
>>>>> I'd be all for not stuffing this in the hctx, but how would that work?
>>>>> The only thing I can think of that would work reliably is batching the
>>>>> queue+wait into units of N. We could potentially have many thousands of
>>>>> queues, and it could get iffy (and/or unreliable) in terms of allocation
>>>>> size. Looks like rcu_synchronize is 48-bytes on my local install, and it
>>>>> doesn't take a lot of devices at current CPU counts to make an alloc
>>>>> covering all of it huge. Let's say 64 threads, and 32 devices, then
>>>>> we're already at 64*32*48 bytes which is an order 5 allocation. Not
>>>>> friendly, and not going to be reliable when you need it. And if we start
>>>>> batching in reasonable counts, then we're _almost_ back to doing a queue
>>>>> or two at the time... 32 * 48 is 1536 bytes, so we could only do two at
>>>>> the time for single page allocations.
>>>>
>>>> We can convert to order 0 allocation by one extra indirect array.
>>>
>>> I guess that could work, and would just be one extra alloc + free if we
>>> still retain the batch. That'd take it to 16 devices (at 32 CPUs) per
>>> round, potentially way less of course if we have more CPUs. So still
>>> somewhat limiting, rather than do all at once.
>>
>> With the approach in blk_mq_alloc_rqs(), each allocated page can be
>> added to one list, so the indirect array can be saved. Then it is
>> possible to allocate for any size queues/devices since every
>> allocation is just for single page in case that it is needed, even no
>> pre-calculation is required.
> 
> As long as we watch the complexity, don't think we need to go overboard
> here in the risk of adding issues for the failure path.

No we don't. I prefer not to do it. And if this turns out to be that bad
we can later convert it to a complicated page vector.

I'll move forward with this approach.
