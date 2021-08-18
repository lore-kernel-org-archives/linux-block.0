Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D669C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 03:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C32861051
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 03:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhHRDO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 23:14:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17034 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhHRDO3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 23:14:29 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GqCZ91cxjzbfN0;
        Wed, 18 Aug 2021 11:10:09 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 11:13:47 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 18 Aug 2021 11:13:47 +0800
Subject: Re: [PATCH RFC] blk_mq: clear rq mapping in driver tags before
 freeing rqs in sched tags
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <bvanassche@acm.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, Keith Busch <kbusch@kernel.org>
References: <20210817022306.1622027-1-yukuai3@huawei.com>
 <YRxZ44tu8o1MPruT@T590> <11ef6a06-4b6f-44d0-af79-f96e16456b55@huawei.com>
 <YRx0QE8T4RJONlA8@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <abddd629-fe96-ae95-2ac3-da1b431db37e@huawei.com>
Date:   Wed, 18 Aug 2021 11:13:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YRx0QE8T4RJONlA8@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/18 10:45, Ming Lei wrote:

> Please take a look at blk_mq_clear_rq_mapping():
> 
> 	//drv_tags points to set->tags[] which is shared in host wide
> 	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
> 	...
> 
> 	//tags points to sched_tags
> 	list_for_each_entry(page, &tags->page_list, lru) {
> 		unsigned long start = (unsigned long)page_address(page);
> 		unsigned long end = start + order_to_size(page->private);
> 		int i;
> 
> 		/* clear drv_tags->rq[i] in case it is from this sched tags*/
> 		for (i = 0; i < set->queue_depth; i++) {
> 			struct request *rq = drv_tags->rqs[i];
> 			unsigned long rq_addr = (unsigned long)rq;
> 
> 			if (rq_addr >= start && rq_addr < end) {
> 				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
> 				cmpxchg(&drv_tags->rqs[i], rq, NULL);
> 			}
> 		}
> 	}
> 
> So we do clear tags->rq[] instead of sched_tag->rq[].

Thanks for the correction, I misunderstand the code, my bad...

> 
>>
>> After switching elevator, tags->rq[tag] still point to the request
>> that is just freed.
> 
> No.
> 
>>
>> 3) nbd server send a reply with random tag directly:
>>
>> recv_work
>>   nbd_read_stat
>>    blk_mq_tag_to_rq(tags, tag)
>>     rq = tags->rq[tag] -> rq is freed
>>
>> Usually, nbd will get tag and send a request to server first, and then
>> handle the reply. However, if the request is skipped, such uaf problem
>> can be triggered.
> 
> When or how is such reply with random tag replied to nbd client? Is it
> possible for nbd client to detect such un-expected/bad situation?

We see that the random tag replied to nbd client in our syzkaller test,
I guess it will not happen in the common case.

nbd_read_stat() is trying to get a valid request from the tag and
complete the request since the server send such reply to client.

There is a way that I can think of to detect the situation that server
reply to client without client's request:

1) get tag from the reply message

2) check that the tag is really set in bitmap of nbd->tag_set.tags[]
If the client didn't send the request message, the driver_tag is not
accquired yet, thus this check can detect this situation.

3) call blk_mq_tag_to_dile to get the request

> What if blk_mq_tag_to_rq() is just called before/when we clear tags->rq[]?

The concurrent scenario is still possible currently.

Thanks
Kuai
