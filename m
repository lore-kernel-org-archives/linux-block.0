Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57408C433E1
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 06:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413752078B
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 06:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgHTGn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:43:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgHTGn3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 02:43:29 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 75BECF5247D362C1A653;
        Thu, 20 Aug 2020 14:43:25 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 14:43:21 +0800
Subject: Re: [PATCH 3/3] nvme-core: fix crash when nvme_enable_aen timeout
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC:     <linux-block@vger.kernel.org>, <kbusch@kernel.org>, <axboe@fb.com>,
        <hch@lst.de>
References: <20200820035413.1790-1-lengchao@huawei.com>
 <fc1efcce-99d9-05cf-5f32-9c454e3b0efe@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <820d5867-3e44-a009-d6b5-ea1a3fecd037@huawei.com>
Date:   Thu, 20 Aug 2020 14:43:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fc1efcce-99d9-05cf-5f32-9c454e3b0efe@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/20 12:30, Sagi Grimberg wrote:
> 
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 74f76aa78b02..f4c347fe925a 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1422,21 +1422,25 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>>       (NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
>>        NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
>> -static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>> +static int nvme_enable_aen(struct nvme_ctrl *ctrl)
>>   {
>>       u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
>>       int status;
>>       if (!supported_aens)
>> -        return;
>> +        return 0;
>>       status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
>>               NULL, 0, &result);
>> -    if (status)
>> +    if (status) {
>>           dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
>>                supported_aens);
>> +        if (status < 0)
>> +            return status;
> 
> Why do you need to check status < 0, you need to fail it regardless.

agree.
Just want to keep the old logic. I guess the old logic: if supported_aens
is true, the result of set features can ignore.

If there is no objection to doing so, I will resend the patch later.
