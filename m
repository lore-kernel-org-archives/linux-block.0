Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D42EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CCB61185
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhIOImf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:42:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9047 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhIOImf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 04:42:35 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H8YZ55vVwzW2gX;
        Wed, 15 Sep 2021 16:40:13 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:41:12 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:41:11 +0800
Subject: Re: [PATCH v6 6/6] nbd: fix uaf in nbd_handle_reply()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210915081537.1684327-1-yukuai3@huawei.com>
 <20210915081537.1684327-7-yukuai3@huawei.com> <YUGuykbPt+Oxt2nk@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f4d74d86-b303-0bdf-59c9-32bb2354a2c1@huawei.com>
Date:   Wed, 15 Sep 2021 16:41:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YUGuykbPt+Oxt2nk@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/15 16:28, Ming Lei wrote:
> On Wed, Sep 15, 2021 at 04:15:37PM +0800, Yu Kuai wrote:
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
>>   block/blk-core.c    |  1 +
>>   drivers/block/nbd.c | 19 ++++++++++++++++++-
>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 5454db2fa263..2008e6903166 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -489,6 +489,7 @@ void blk_queue_exit(struct request_queue *q)
>>   {
>>   	percpu_ref_put(&q->q_usage_counter);
>>   }
>> +EXPORT_SYMBOL(blk_queue_exit);
>>   
>>   static void blk_queue_usage_counter_release(struct percpu_ref *ref)
>>   {
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 9a7bbf8ebe74..f065afcc7586 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -824,6 +824,7 @@ static void recv_work(struct work_struct *work)
>>   						     work);
>>   	struct nbd_device *nbd = args->nbd;
>>   	struct nbd_config *config = nbd->config;
>> +	struct request_queue *q = nbd->disk->queue;
>>   	struct nbd_sock *nsock;
>>   	struct nbd_cmd *cmd;
>>   	struct request *rq;
>> @@ -834,13 +835,29 @@ static void recv_work(struct work_struct *work)
>>   		if (nbd_read_reply(nbd, args->index, &reply))
>>   			break;
>>   
>> +		/*
>> +		 * Get q_usage_counter can prevent accessing freed request
>> +		 * through blk_mq_tag_to_rq() in nbd_handle_reply(). If
>> +		 * q_usage_counter is zero, then no request is inflight, which
>> +		 * means something is wrong since we expect to find a request to
>> +		 * complete here.
>> +		 */
>> +		if (!percpu_ref_tryget(&q->q_usage_counter)) {
>> +			dev_err(disk_to_dev(nbd->disk), "%s: no io inflight\n",
>> +				__func__);
>> +			break;
>> +		}
>> +
>>   		cmd = nbd_handle_reply(nbd, args->index, &reply);
>> -		if (IS_ERR(cmd))
>> +		if (IS_ERR(cmd)) {
>> +			blk_queue_exit(q);
>>   			break;
>> +		}
>>   
>>   		rq = blk_mq_rq_from_pdu(cmd);
>>   		if (likely(!blk_should_fake_timeout(rq->q)))
>>   			blk_mq_complete_request(rq);
>> +		blk_queue_exit(q);
> 
> You can simply call percpu_ref_put() directly just like what scsi_end_request()
> is doing.
> 

Thanks for the adivce, will do that in next iteration. (hopefully the
last)

Best regards,
Kuai
