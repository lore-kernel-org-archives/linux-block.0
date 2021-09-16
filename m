Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5EAC433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 13:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E64611C4
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 13:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbhIPNMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 09:12:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9741 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbhIPNMB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 09:12:01 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H9HVS0xL6zW2Zm;
        Thu, 16 Sep 2021 21:09:36 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 21:10:38 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 16 Sep 2021 21:10:37 +0800
Subject: Re: [patch v8 7/7] nbd: fix uaf in nbd_handle_reply()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-8-yukuai3@huawei.com> <YUM/cNzr6PTXFVAX@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f0a72b72-19c9-f01d-806d-d27f854dea8f@huawei.com>
Date:   Thu, 16 Sep 2021 21:10:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YUM/cNzr6PTXFVAX@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/16 20:58, Ming Lei wrote:
> On Thu, Sep 16, 2021 at 05:33:50PM +0800, Yu Kuai wrote:
>> There is a problem that nbd_handle_reply() might access freed request:
>>
>> 1) At first, a normal io is submitted and completed with scheduler:
>>
>> internel_tag = blk_mq_get_tag -> get tag from sched_tags
>>   blk_mq_rq_ctx_init
>>    sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
>> ...
>> blk_mq_get_driver_tag
>>   __blk_mq_get_driver_tag -> get tag from tags
>>   tags->rq[tag] = sched_tag->static_rq[internel_tag]
>>
>> So, both tags->rq[tag] and sched_tags->rq[internel_tag] are pointing
>> to the request: sched_tags->static_rq[internal_tag]. Even if the
>> io is finished.
>>
>> 2) nbd server send a reply with random tag directly:
>>
>> recv_work
>>   nbd_handle_reply
>>    blk_mq_tag_to_rq(tags, tag)
>>     rq = tags->rq[tag]
>>
>> 3) if the sched_tags->static_rq is freed:
>>
>> blk_mq_sched_free_requests
>>   blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i)
>>    -> step 2) access rq before clearing rq mapping
>>    blk_mq_clear_rq_mapping(set, tags, hctx_idx);
>>    __free_pages() -> rq is freed here
>>
>> 4) Then, nbd continue to use the freed request in nbd_handle_reply
>>
>> Fix the problem by get 'q_usage_counter' before blk_mq_tag_to_rq(),
>> thus request is ensured not to be freed because 'q_usage_counter' is
>> not zero.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/block/nbd.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 69dc5eac9ad3..b3a47fc6237f 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -825,6 +825,7 @@ static void recv_work(struct work_struct *work)
>>   						     work);
>>   	struct nbd_device *nbd = args->nbd;
>>   	struct nbd_config *config = nbd->config;
>> +	struct request_queue *q = nbd->disk->queue;
>>   	struct nbd_sock *nsock;
>>   	struct nbd_cmd *cmd;
>>   	struct request *rq;
>> @@ -835,7 +836,20 @@ static void recv_work(struct work_struct *work)
>>   		if (nbd_read_reply(nbd, args->index, &reply))
>>   			break;
>>   
>> +		/*
>> +		 * Grab .q_usage_counter so request pool won't go away, then no
>> +		 * request use-after-free is possible during nbd_handle_reply().
>> +		 * If queue is frozen, there won't be any inflight requests, we
>> +		 * needn't to handle the incoming garbage message.
>> +		 */
>> +		if (!percpu_ref_tryget(&q->q_usage_counter)) {
>> +			dev_err(disk_to_dev(nbd->disk), "%s: no io inflight\n",
>> +				__func__);
>> +			break;
>> +		}
>> +
>>   		cmd = nbd_handle_reply(nbd, args->index, &reply);
>> +		percpu_ref_put(&q->q_usage_counter);
>>   		if (IS_ERR(cmd))
>>   			break;
> 
> The refcount needs to be grabbed when completing the request because
> the request may be completed from other code path, then the request pool
> will be freed from that code path when the request is referred.

Hi,

The request can't complete concurrently, thus put ref here is safe.

There used to be a commet here that I tried to explain it... It's fine
to me to move it behind anyway.

Thanks,
Kuai
