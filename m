Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1773BC433DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 07:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C6C2071E
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 07:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHZH0A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:26:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3073 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbgHZHZ7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 03:25:59 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id C36BB5EAC1850D2691ED;
        Wed, 26 Aug 2020 15:25:57 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 26 Aug 2020 15:25:57 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 26
 Aug 2020 15:25:56 +0800
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
 <399888c3-71e6-625e-3b0d-025ccbad4fd1@huawei.com>
 <6cef7a24-f19c-a39a-abd8-2f0ea50fb7a2@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <255fa307-f2e8-4eab-bdbf-8b697b215663@huawei.com>
Date:   Wed, 26 Aug 2020 15:25:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6cef7a24-f19c-a39a-abd8-2f0ea50fb7a2@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/26 1:38, Sagi Grimberg wrote:
> 
>>>>> Good, but I'd also won't want to get this without making sure the async
>>>>> quiesce works well on large number of namespaces (the reason why this
>>>>> is proposed in the first place). Not sure who is planning to do that...
>>>>
>>>> That can be added when async quiesce is done.
>>>
>>> Chao, are you looking into that? I'd really hate to find out we have an
>>> issue there post conversion...
>>
>> Now we config CONFIG_TREE_SRCU, the size of TREE_SRCU is too big. I
>> really appreciate the work of Ming.
>>
>> I review the patch, I think the patch may work well now, but do extra
>> works for exception scenario. Percpu_ref is not disigned for
>> serialization which read low cost. If we replace SRCU with percpu_ref,
>> the benefit is save memory for blocking queue, the price is limit future
>> changes or do more extra works.
>>
>> I do not think replace SRCU with percpu_ref is a good idea, because it's
>> hard to predict how much we'll lose.
> 
> Not sure I understand your point, can you clarify what is the poor
> design of percpu_ref and for which use-case?
> .
1.percpu_ref need introduce fail status for hctc_lock to avoid possible
long waits for synchronization, need do some extra work for failed hctx_lock .
Just like this which in the patch:
@@ -2057,11 +2051,14 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
  		struct request *rq, blk_qc_t *cookie)
  {
  	blk_status_t ret;
-	int srcu_idx;

  	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);

-	hctx_lock(hctx, &srcu_idx);
+	/* Insert request to queue in case of being quiesced */
+	if (!hctx_lock(hctx)) {
+		blk_mq_sched_insert_request(rq, false, false, false);
+		return;
+	}

Now is simple, the code can work well. If the logic gets complicated,
it's probably hard to handle.
For example: for some unkown reason, if we may introduce some mechanism(such
as check other flag or state) for dispatch or issue requests, we may need do
more extra works in the branch of failed hctx_lock. perhaps more seriously,
it may hard to be handled in this branch. If we need do like this
in __blk_mq_try_issue_directly.
	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
		run_queue = false;
		bypass_insert = false;
		goto insert;
+	} else if (blk_queue_xxx(q)) {
+		/*do some other things*/
+       }
Of course, there's a good chance it won't happen.


