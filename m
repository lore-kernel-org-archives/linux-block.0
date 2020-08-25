Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B6C433E1
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 09:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB332071E
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 09:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgHYJmI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:42:08 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:53316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728377AbgHYJmI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 05:42:08 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 9F502DA7BE07D36FD03D;
        Tue, 25 Aug 2020 17:42:05 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 25 Aug 2020 17:42:05 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Tue, 25
 Aug 2020 17:42:04 +0800
Subject: Re: [PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200820030248.2809559-1-ming.lei@redhat.com>
 <856f6108-2227-67e8-e913-fdef296a2d26@grimberg.me>
 <20200822133954.GC3189453@T590>
 <619a8d4f-267f-5e21-09bd-16b45af69480@grimberg.me>
 <20200824104052.GA3210443@T590>
 <44160549-0273-b8e6-1599-d54ce84eb47f@grimberg.me>
 <20200825023212.GA3233087@T590>
 <a7b87988-4757-b718-511e-3fdf122325c9@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <399888c3-71e6-625e-3b0d-025ccbad4fd1@huawei.com>
Date:   Tue, 25 Aug 2020 17:41:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a7b87988-4757-b718-511e-3fdf122325c9@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/25 13:24, Sagi Grimberg wrote:
> 
>>>>> Anyways, I think that for now we should place them together.
>>>>
>>>> Then it may hurt non-blocking.
>>>>
>>>> Each hctx has only one run-work, if the hctx is blocked, no other request
>>>> may be queued to hctx any more. That is basically sync run queue, so I
>>>> am not sure good enough perf can be expected on blocking.
>>>
>>> I don't think that you should assume that a blocking driver will block
>>> normally, it will only rarely block (very rarely).
>>
>> If nvme-tcp only blocks rarely, just wondering why not switch to non-blocking
>> which can be done simply with one driver specific wq work? Then nvme-tcp
>> can be aligned with other nvme drivers.
> 
> It used to be this way (and also is that way today in some cases), but
> some latency recent optimizations revealed that sending the request to
> the wire from queue_rq (when some conditions are met) instead of
> incurring a context switch is a win in most cases where latency matters.
> 
> Once we call sendpage from queue_rq, we might_sleep, hence we must be
> blocking. But in practice, sendpage with MSG_DONTWAIT will rarely
> actually sleep.
> 
>>>> So it may not be worth of putting the added .dispatch_counter together
>>>> with .q_usage_counter.
>>>
>>> I happen to think it would. Not sure why you resist so much given how
>>> request_queue is arranged currently.
>>
>> The reason is same with 073196787727("blk-mq: Reduce blk_mq_hw_ctx size").
> 
> percpu_ref probably is a quarter of the size of srcu, not sure anyone
> would have bothered to do that for percpu_ref. You're really
> exaggerating I think...
> 
>> non-blocking is the preferred style for blk-mq driver, so we can just
>> focus on non-blocking wrt. performance improvement as I mentioned blocking
>> has big problem of sync run queue.
>>
>> It may be contradictory for improving both, for example, if the
>> added .dispatch_counter is put with .q_usage_cunter together, it will
>> be fetched to L1 unnecessarily which is definitely not good for
>> non-blocking.
> 
> I'll cease asking you for this, but your resistance is really unclear to me. We can measure what is the penalty/gain later by realigning some
> items.
> 
> Let's stop wasting our time here...
> 
>>>>>>> Also maybe a better name is needed here since it's just
>>>>>>> for blocking hctxs.
>>>>>>>
>>>>>>>> +    wait_queue_head_t    mq_quiesce_wq;
>>>>>>>> +
>>>>>>>>          struct dentry        *debugfs_dir;
>>>>>>>>      #ifdef CONFIG_BLK_DEBUG_FS
>>>>>>>>
>>>>>>>
>>>>>>> What I think is needed here is at a minimum test quiesce/unquiesce loops
>>>>>>> during I/O. code auditing is not enough, there may be driver assumptions
>>>>>>> broken with this change (although I hope there shouldn't be).
>>>>>>
>>>>>> We have elevator switch / updating nr_request stress test, and both relies
>>>>>> on quiesce/unquiesce, and I did run such test with this patch.
>>>>>
>>>>> You have a blktest for this? If not, I strongly suggest that one is
>>>>> added to validate the change also moving forward.
>>>>
>>>> There are lots of blktest tests doing that, such as block/005,
>>>> block/016, block/021, ...
>>>
>>> Good, but I'd also won't want to get this without making sure the async
>>> quiesce works well on large number of namespaces (the reason why this
>>> is proposed in the first place). Not sure who is planning to do that...
>>
>> That can be added when async quiesce is done.
> 
> Chao, are you looking into that? I'd really hate to find out we have an
> issue there post conversion...

Now we config CONFIG_TREE_SRCU, the size of TREE_SRCU is too big. I
really appreciate the work of Ming.

I review the patch, I think the patch may work well now, but do extra
works for exception scenario. Percpu_ref is not disigned for
serialization which read low cost. If we replace SRCU with percpu_ref,
the benefit is save memory for blocking queue, the price is limit future
changes or do more extra works.

I do not think replace SRCU with percpu_ref is a good idea, because it's
hard to predict how much we'll lose.
