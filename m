Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803E3C433DB
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 02:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB8A22D50
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 02:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbhAFCcs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 21:32:48 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4130 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFCcr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 21:32:47 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4D9YJf3vzWzXpks;
        Wed,  6 Jan 2021 10:31:14 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 6 Jan 2021 10:32:03 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 6 Jan
 2021 10:32:02 +0800
Subject: Re: [PATCH 2/6] nvme-core: introduce complete failed request
To:     Minwoo Im <minwoo.im.dev@gmail.com>
CC:     <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
        <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210105071936.25097-1-lengchao@huawei.com>
 <20210105071936.25097-3-lengchao@huawei.com>
 <20210105191154.GA4426@localhost.localdomain>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <9f760de9-fc05-a831-9258-cdf15d9ecf90@huawei.com>
Date:   Wed, 6 Jan 2021 10:31:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210105191154.GA4426@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/6 3:11, Minwoo Im wrote:
> Hello,
> 
> On 21-01-05 15:19:32, Chao Leng wrote:
>> When a request is queued failed, if the fail status is not
>> BLK_STS_RESOURCE, BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE,
>> the request is need to complete with nvme_complete_rq in queue_rq.
>> So introduce nvme_try_complete_failed_req.
>> The request is needed to complete with NVME_SC_HOST_PATH_ERROR in
>> nvmf_fail_nonready_command and queue_rq.
>> So introduce nvme_complete_failed_req.
>> For details, see the subsequent patches.
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   drivers/nvme/host/nvme.h | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index bfcedfa4b057..1a0bddb9158f 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -649,6 +649,24 @@ void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
>>   extern const struct attribute_group *nvme_ns_id_attr_groups[];
>>   extern const struct block_device_operations nvme_ns_head_ops;
>>   
>> +static inline void nvme_complete_failed_req(struct request *req)
>> +{
>> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
>> +	blk_mq_set_request_complete(req);
>> +	nvme_complete_rq(req);
>> +}
>> +
>> +static inline blk_status_t nvme_try_complete_failed_req(struct request *req,
>> +							blk_status_t ret)
>> +{
>> +	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE ||
>> +	    ret == BLK_STS_ZONE_RESOURCE)
>> +		return ret;
> 
> If it has nothing to do with various conditions, can we have this if
> to switch just like the other function in the same file does:
ok.
> 
> 	switch (ret) {
> 	case BLK_STS_RESOURCE:
> 	case BLK_STS_DEV_RESOURCE:
> 	case BLK_STS_ZONE_RESOURCE:
> 		return ret;
> 	default:
> 		nvme_complete_failed_req(req);
> 		return BLK_STS_OK;
> 	}
> 
>> +
>> +	nvme_complete_failed_req(req);
>> +	return BLK_STS_OK;
>> +}
>> +
> 
> Can we have these two functions along side with nvme_try_complete_req()
> by moving declaration of nvme_coplete_rq() a little bit up ?
This may cause the function declaration disordered.
> 
>>   #ifdef CONFIG_NVME_MULTIPATH
>>   static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>>   {
>> -- 
>> 2.16.4
>>
> 
> Thanks,
> .
> 
