Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059D3C433DB
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 06:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36FA2396F
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 06:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbhANG4F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:56:05 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2943 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbhANG4F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 01:56:05 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DGZmX45pzz5Fm4;
        Thu, 14 Jan 2021 14:54:20 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 14 Jan 2021 14:55:22 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 14
 Jan 2021 14:55:21 +0800
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
Date:   Thu, 14 Jan 2021 14:55:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/14 8:19, Sagi Grimberg wrote:
> 
>> When a request is queued failed, blk_status_t is directly returned
>> to the blk-mq. If blk_status_t is not BLK_STS_RESOURCE,
>> BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE, blk-mq call
>> blk_mq_end_request to complete the request with BLK_STS_IOERR.
>> In two scenarios, the request should be retried and may succeed.
>> First, if work with nvme multipath, the request may be retried
>> successfully in another path, because the error is probably related to
>> the path. Second, if work without multipath software, the request may
>> be retried successfully after error recovery.
>> If the request is complete with BLK_STS_IOERR in blk_mq_dispatch_rq_list.
>> The state of request may be changed to MQ_RQ_IN_FLIGHT. If free the
>> request asynchronously such as in nvme_submit_user_cmd, in extreme
>> scenario the request will be repeated freed in tear down.
>> If a non-resource error occurs in queue_rq, should directly call
>> nvme_complete_rq to complete request and set the state of request to
>> MQ_RQ_COMPLETE. nvme_complete_rq will decide to retry, fail over or end
>> the request.
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   drivers/nvme/host/rdma.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index df9f6f4549f1..4a89bf44ecdc 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -2093,7 +2093,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>>   unmap_qe:
>>       ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct nvme_command),
>>                   DMA_TO_DEVICE);
>> -    return ret;
>> +    return nvme_try_complete_failed_req(rq, ret);
> 
> I don't understand this. There are errors that may not be related to
> anything that is pathing related (sw bug, memory leak, mapping error,
> etc, etc) why should we return this one-shot error?
Although fail over retry is not required, if we return the error to
blk-mq, a low probability crash may happen. because blk-mq do not set
the state of request to MQ_RQ_COMPLETE before complete the request,
the request may be freed asynchronously such as in nvme_submit_user_cmd.
If race with error recovery, request double completion may happens.

So we can not return the error to blk-mq if the blk_status_t is not
BLK_STS_RESOURCE, BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE.
> .
