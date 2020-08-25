Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F8C433E1
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 05:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A8C2073A
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 05:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHYFYM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:24:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38894 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgHYFYL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 01:24:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id l191so3905694pgd.5
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 22:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BI74gP/+mUJfTJKavSTjwh0vRGz8oqChT1poDuZGrfg=;
        b=NZgH4s67WvaHQajtTzCJy6xCFRfM7w+chgMXfWT2+oK7Qx6dIrIdw9B0I8MgDuTP7B
         T/0OJEmLsqb2c+fcx7k0d7myRSU1oidlsoYB10NoH2B1leZ7heKSaT6LMGV53mg7EluP
         hP8ZTWtsk0xv38suYX21xG6guFsFQecoVOXR/tfmGMCp8edBzeFHul26iZUg3agpZRcm
         cQlQJxlRp7CNdnv/rXe9yg4CyJ8ghk2ubkn6QKhlOpfOg4mrb9V5AvNVF1kWWiBxGZd7
         OxHICXR/JFva/6lm7KsrjEZT7z7AZSz45PQaiuNUx12+43wpSbVQDvTuerQUeBasSBP0
         YH+A==
X-Gm-Message-State: AOAM5310OJziEpDx6yo5xjYf2O2zvopEQZprG2i7hwLTX2gSjWvTZ4UQ
        xevS4Vx0vwQutXNMzqDw6ZA=
X-Google-Smtp-Source: ABdhPJwKODX+1OACQhDKTzh4fp3dmp2WBfoOjkLJYGFJCy0TNQYiZXdLVc96ywEgCp0qdrhIvcPrNA==
X-Received: by 2002:a17:902:eb03:: with SMTP id l3mr3860794plb.296.1598333050113;
        Mon, 24 Aug 2020 22:24:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d? ([2601:647:4802:9070:cda6:bf68:c972:645d])
        by smtp.gmail.com with ESMTPSA id w199sm8083727pfc.191.2020.08.24.22.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 22:24:09 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20200820030248.2809559-1-ming.lei@redhat.com>
 <856f6108-2227-67e8-e913-fdef296a2d26@grimberg.me>
 <20200822133954.GC3189453@T590>
 <619a8d4f-267f-5e21-09bd-16b45af69480@grimberg.me>
 <20200824104052.GA3210443@T590>
 <44160549-0273-b8e6-1599-d54ce84eb47f@grimberg.me>
 <20200825023212.GA3233087@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a7b87988-4757-b718-511e-3fdf122325c9@grimberg.me>
Date:   Mon, 24 Aug 2020 22:24:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825023212.GA3233087@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> Anyways, I think that for now we should place them together.
>>>
>>> Then it may hurt non-blocking.
>>>
>>> Each hctx has only one run-work, if the hctx is blocked, no other request
>>> may be queued to hctx any more. That is basically sync run queue, so I
>>> am not sure good enough perf can be expected on blocking.
>>
>> I don't think that you should assume that a blocking driver will block
>> normally, it will only rarely block (very rarely).
> 
> If nvme-tcp only blocks rarely, just wondering why not switch to non-blocking
> which can be done simply with one driver specific wq work? Then nvme-tcp
> can be aligned with other nvme drivers.

It used to be this way (and also is that way today in some cases), but
some latency recent optimizations revealed that sending the request to
the wire from queue_rq (when some conditions are met) instead of
incurring a context switch is a win in most cases where latency matters.

Once we call sendpage from queue_rq, we might_sleep, hence we must be
blocking. But in practice, sendpage with MSG_DONTWAIT will rarely
actually sleep.

>>> So it may not be worth of putting the added .dispatch_counter together
>>> with .q_usage_counter.
>>
>> I happen to think it would. Not sure why you resist so much given how
>> request_queue is arranged currently.
> 
> The reason is same with 073196787727("blk-mq: Reduce blk_mq_hw_ctx size").

percpu_ref probably is a quarter of the size of srcu, not sure anyone
would have bothered to do that for percpu_ref. You're really
exaggerating I think...

> non-blocking is the preferred style for blk-mq driver, so we can just
> focus on non-blocking wrt. performance improvement as I mentioned blocking
> has big problem of sync run queue.
> 
> It may be contradictory for improving both, for example, if the
> added .dispatch_counter is put with .q_usage_cunter together, it will
> be fetched to L1 unnecessarily which is definitely not good for
> non-blocking.

I'll cease asking you for this, but your resistance is really unclear to 
me. We can measure what is the penalty/gain later by realigning some
items.

Let's stop wasting our time here...

>>>>>> Also maybe a better name is needed here since it's just
>>>>>> for blocking hctxs.
>>>>>>
>>>>>>> +	wait_queue_head_t	mq_quiesce_wq;
>>>>>>> +
>>>>>>>      	struct dentry		*debugfs_dir;
>>>>>>>      #ifdef CONFIG_BLK_DEBUG_FS
>>>>>>>
>>>>>>
>>>>>> What I think is needed here is at a minimum test quiesce/unquiesce loops
>>>>>> during I/O. code auditing is not enough, there may be driver assumptions
>>>>>> broken with this change (although I hope there shouldn't be).
>>>>>
>>>>> We have elevator switch / updating nr_request stress test, and both relies
>>>>> on quiesce/unquiesce, and I did run such test with this patch.
>>>>
>>>> You have a blktest for this? If not, I strongly suggest that one is
>>>> added to validate the change also moving forward.
>>>
>>> There are lots of blktest tests doing that, such as block/005,
>>> block/016, block/021, ...
>>
>> Good, but I'd also won't want to get this without making sure the async
>> quiesce works well on large number of namespaces (the reason why this
>> is proposed in the first place). Not sure who is planning to do that...
> 
> That can be added when async quiesce is done.

Chao, are you looking into that? I'd really hate to find out we have an
issue there post conversion...
