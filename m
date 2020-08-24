Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A9C433DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AAC20738
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 21:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHXVeK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:34:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42498 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 17:34:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id g1so1492312pgm.9
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 14:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ETIc5uiwZOHIWMR5ZmbncsNV8aJaWv5oMgspdnRmzo=;
        b=fDCX5cdhugVqSqgETZ/vaT4aqBklFe+slsPRTKabrzY0Tec4EVn1Mp3rRif7INmM+4
         nFCmJ6tWMOrYR1iCpzt5ZW5+raerGUHOCaKuld/6lRZg5PW+jVvYPdX3ef/ArUQtbHXV
         qG4o3KTaQDEKmsFZ9nQgY6Cka/ekn8pdUQ5NJzJdhBdrCDoK4V0+Md4VTvkB0iwCxb2a
         sEwhrAS+bv0Uqa8dcX9Cl9veikPT6rSp2dXgmDIYPmWnuYZHMBdnMPWEI6FpbmQbuWFH
         GgskkTcQJhYzjyn1o1lqKURd+JS6kjBcfLW0BpBdpTFmj027UyEme24n7FSUe52p58Y8
         TITQ==
X-Gm-Message-State: AOAM530HifKVHcmmFrUPMfkbu5wVwr9TUcr7pQCOB1cjebQbvb7jQ9k8
        t8sy8Brho+RQb42+Z6sCsqs=
X-Google-Smtp-Source: ABdhPJwaCtk6q7/3ItxGfTLXiza98zdHXweAMxPZ9W4TiyU2dhQxqUCOmUSNBdkc1fMB876gCFl3jg==
X-Received: by 2002:a62:64d5:: with SMTP id y204mr5306605pfb.83.1598304848712;
        Mon, 24 Aug 2020 14:34:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d? ([2601:647:4802:9070:cda6:bf68:c972:645d])
        by smtp.gmail.com with ESMTPSA id m4sm12381116pfh.129.2020.08.24.14.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 14:34:08 -0700 (PDT)
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <44160549-0273-b8e6-1599-d54ce84eb47f@grimberg.me>
Date:   Mon, 24 Aug 2020 14:34:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824104052.GA3210443@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> I'd think it'd be an improvement, yes.
> 
> Please see the reason why it is put back of hctx in
> 073196787727("blk-mq: Reduce blk_mq_hw_ctx size").

I know why it is there, just was saying that having an additional
pointer is fine. But the discussion is moot.

>>> .q_usage_counter should have been put in the 1st cacheline of
>>> request queue. If it is moved to the 1st cacheline of request queue,
>>> we shouldn't put 'dispatch_counter' there, because it may hurt other
>>> non-blocking drivers.
>>
>> q_usage_counter currently there, and the two will always be taken
>> together, and there are several other stuff that we can remove from
>> that cacheline without hurting performance for anything.
>>
>> And when q_usage_counter is moved to the first cacheline, then I'd
>> expect that the dispatch_counter also moves to the front (maybe not
>> the first if it is on the expense of other hot members, but definitely
>> it should be treated as a hot member).
>>
>> Anyways, I think that for now we should place them together.
> 
> Then it may hurt non-blocking.
> 
> Each hctx has only one run-work, if the hctx is blocked, no other request
> may be queued to hctx any more. That is basically sync run queue, so I
> am not sure good enough perf can be expected on blocking.

I don't think that you should assume that a blocking driver will block
normally, it will only rarely block (very rarely).

> So it may not be worth of putting the added .dispatch_counter together
> with .q_usage_counter.

I happen to think it would. Not sure why you resist so much given how
request_queue is arranged currently.

>>>> Also maybe a better name is needed here since it's just
>>>> for blocking hctxs.
>>>>
>>>>> +	wait_queue_head_t	mq_quiesce_wq;
>>>>> +
>>>>>     	struct dentry		*debugfs_dir;
>>>>>     #ifdef CONFIG_BLK_DEBUG_FS
>>>>>
>>>>
>>>> What I think is needed here is at a minimum test quiesce/unquiesce loops
>>>> during I/O. code auditing is not enough, there may be driver assumptions
>>>> broken with this change (although I hope there shouldn't be).
>>>
>>> We have elevator switch / updating nr_request stress test, and both relies
>>> on quiesce/unquiesce, and I did run such test with this patch.
>>
>> You have a blktest for this? If not, I strongly suggest that one is
>> added to validate the change also moving forward.
> 
> There are lots of blktest tests doing that, such as block/005,
> block/016, block/021, ...

Good, but I'd also won't want to get this without making sure the async
quiesce works well on large number of namespaces (the reason why this
is proposed in the first place). Not sure who is planning to do that...
