Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2422AC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 02:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD0B6103A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 02:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhHRCCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 22:02:48 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14272 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHRCCq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 22:02:46 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GqB3b3Ps6z87Nn;
        Wed, 18 Aug 2021 10:02:03 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 10:02:10 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 18 Aug 2021 10:02:10 +0800
Subject: Re: [PATCH RFC] blk_mq: clear rq mapping in driver tags before
 freeing rqs in sched tags
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <bvanassche@acm.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, Keith Busch <kbusch@kernel.org>
References: <20210817022306.1622027-1-yukuai3@huawei.com>
 <YRxZ44tu8o1MPruT@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <11ef6a06-4b6f-44d0-af79-f96e16456b55@huawei.com>
Date:   Wed, 18 Aug 2021 10:02:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YRxZ44tu8o1MPruT@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/18 8:52, Ming Lei wrote:
> On Tue, Aug 17, 2021 at 10:23:06AM +0800, Yu Kuai wrote:
>> If ioscheduler is not none, hctx->tags->rq[tag] will point to
>> hctx->sched_tags->static_rq[internel_tag] in blk_mq_get_driver_tag().
>> However, static_rq of sched_tags might be freed through switching
>> elevator or increasing nr_requests. Thus leave a window for some drivers
>> to get the freed request through blk_mq_tag_to_rq(tags, tag).
> 
> I believe I have explained that it is bug of driver which has knowledge
> if the passed tag is valid or not. We are clear that driver need to cover
> race between normal completion and timeout/error handling.
> 
>>
>> It's difficult to fix this uaf from driver side, I'm thinking about
> 
> So far not see any analysis on why the uaf is triggered, care to
> investigate the reason?

Hi, Ming

I'm sorry if I didn't explian the uaf clearly.

1) At first, a normal io is submitted and completed with scheduler:

internel_tag = blk_mq_get_tag -> get tag from sched_tags
  blk_mq_rq_ctx_init
   sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
...
blk_mq_get_driver_tag
  __blk_mq_get_driver_tag -> get tag from tags
  tags->rq[tag] = sched_tag->static_rq[internel_tag]

So, both tags->rq[tag] and sched_tags->rq[internel_tag] are pointing
to the request: sched_tags->static_rq[internal_tag].

2) Then, if the sched_tags->static_rq is freed:

blk_mq_sched_free_requests
  blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i)
   blk_mq_clear_rq_mapping(set, tags, hctx_idx);
    -> sched_tags->rq[internel_tag] is set to null here

After switching elevator, tags->rq[tag] still point to the request
that is just freed.

3) nbd server send a reply with random tag directly:

recv_work
  nbd_read_stat
   blk_mq_tag_to_rq(tags, tag)
    rq = tags->rq[tag] -> rq is freed

Usually, nbd will get tag and send a request to server first, and then
handle the reply. However, if the request is skipped, such uaf problem
can be triggered.

> 
> The request reference has been cleared too in blk_mq_tag_update_depth():
> 
> 	blk_mq_tag_update_depth
> 		blk_mq_free_rqs
> 			blk_mq_clear_rq_mapping
> 

What I'm trying to do is to clear rq mapping in both
hctx->sched_tags->rq and hctx->tags->rq when sched_tags->static_rq
is freed. However, I forgot about the case when tags is shared in
multiple device. Thus what this patch does is clearly wrong...

So, what do you think about adding a new interface to iterate the
request in tags->rq[], find what is pointing to the
sched_tags->static_rq[], and use cmpxchg() to clear them?

Thanks
Kuai
