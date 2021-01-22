Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC3BC433DB
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 01:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F9022B43
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 01:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbhAVBsy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 20:48:54 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4146 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAVBsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 20:48:47 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DMMZH3x9lzXtNt;
        Fri, 22 Jan 2021 09:47:03 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 09:48:04 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 22
 Jan 2021 09:48:03 +0800
Subject: Re: [PATCH v3 3/5] nvme-fabrics: avoid double request completion for
 nvmf_fail_nonready_command
To:     Hannes Reinecke <hare@suse.de>, <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <sagi@grimberg.me>, <axboe@fb.com>, <kbusch@kernel.org>,
        <hch@lst.de>
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-4-lengchao@huawei.com>
 <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <a100b5dd-d38b-3158-d000-b84920a4e274@huawei.com>
Date:   Fri, 22 Jan 2021 09:48:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/21 16:58, Hannes Reinecke wrote:
> On 1/21/21 8:03 AM, Chao Leng wrote:
>> When reconnect, the request may be completed with NVME_SC_HOST_PATH_ERROR
>> in nvmf_fail_nonready_command. The state of request will be changed to
>> MQ_RQ_IN_FLIGHT before call nvme_complete_rq. If free the request
>> asynchronously such as in nvme_submit_user_cmd, in extreme scenario
>> the request may be completed again in tear down process.
>> nvmf_fail_nonready_command do not need calling blk_mq_start_request
>> before complete the request. nvmf_fail_nonready_command should set
>> the state of request to MQ_RQ_COMPLETE before complete the request.
>>
> 
> So what you are saying is that there is a race condition between
> blk_mq_start_request()
> and
> nvme_complete_request()
Yes. The race is:
process1:error recovery->tear down->quiesce queue(wait dispatch done)
process2:dispatch->queue_rq->nvmf_fail_nonready_command->
     nvme_complete_rq(if the request is freed asynchronously, wake
	nvme_submit_user_cmd( for example) but have no chance to run).
process1:continue ->cancle suspend request, check the state is not
     MQ_RQ_IDLE and MQ_RQ_COMPLETE, complete(free) the request.
process3: nvme_submit_user_cmd now has chance to run, and the free the
     request again.
Test Injection Method: inject a msleep before call blk_mq_free_request
in nvme_submit_user_cmd.
> 
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   drivers/nvme/host/fabrics.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 72ac00173500..874e4320e214 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -553,9 +553,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
>>           !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>>           return BLK_STS_RESOURCE;
>> -    nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
>> -    blk_mq_start_request(rq);
>> -    nvme_complete_rq(rq);
>> +    nvme_complete_failed_req(rq);
>>       return BLK_STS_OK;
>>   }
>>   EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
>> I'd rather have 'nvme_complete_failed_req()' accept the status as 
> argument, like
> 
> nvme_complete_failed_request(rq, NVME_SC_HOST_PATH_ERROR)
> 
> that way it's obvious what is happening, and the status isn't hidden in the function.
Ok, good idea. Thank you for your suggestion.
> 
> Cheers,
> 
> Hannes
