Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F56CC433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 05:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A9C23884
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 05:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhAUDhu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:37:50 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2553 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbhAUBgU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 20:36:20 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DLlJ952nyzW39r;
        Thu, 21 Jan 2021 09:32:41 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 21 Jan 2021 09:34:31 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 21
 Jan 2021 09:34:30 +0800
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
 <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
 <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
 <4ff22d33-12fa-1f70-3606-54821f314c45@grimberg.me>
 <0b5c8e31-8dc2-994a-1710-1b1be07549c9@huawei.com>
 <2ed5391c-fe43-f512-adf0-214effd5d599@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <6bfca033-8fda-4ace-c05f-285fccb070fd@huawei.com>
Date:   Thu, 21 Jan 2021 09:34:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2ed5391c-fe43-f512-adf0-214effd5d599@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/21 5:35, Sagi Grimberg wrote:
> 
> is not something we should be handling in nvme. block drivers
>>>>> should be able to fail queue_rq, and this all should live in the
>>>>> block layer.
>>>> Of course, it is also an idea to repair the block drivers directly.
>>>> However, block layer is unaware of nvme native multipathing,
>>>
>>> Nor it should be
>>>
>>>> will cause the request return error which should be avoided.
>>>
>>> Not sure I understand..
>>> requests should failover for path related errors,
>>> what queue_rq errors are expected to be failed over from your
>>> perspective?
>> Although fail over for only path related errors is the best choice, it's
>> almost impossible to achieve.
>> The probability of non-path-related errors is very low. Although these
>> errors do not require fail over retry, the cost of fail over retry
>> is complete the request with error delay a bit long time(retry several
>> times). It's not the best choice, but I think it's acceptable, because
>> HBA driver does not have path-related error codes but only general error
>> codes. It is difficult to identify whether the general error codes are
>> path-related.
> 
> If we have a SW bug or breakage that can happen occasionally, this can
> result in a constant failover rather than a simple failure. This is just
> not a good approach IMO.
> 
>>>> The scenario: use two HBAs for nvme native multipath, and then one HBA
>>>> fault,
>>>
>>> What is the specific error the driver sees?
>> The path related error code is closely related to HBA driver
>> implementation. In general it is EIO. I don't think it's a good idea to
>> assume what general error code the driver returns in the event of a path
>> error.
> 
> But assuming every error is a path error a good idea?
Of course not, according to the old code logic, assuming !ENOMEM && !EAGIAN
for HBA drivers is a path error. I think it might be reasonable.
> 
>>>> the blk_status_t of queue_rq is BLK_STS_IOERR, blk-mq will call
>>>> blk_mq_end_request to complete the request which bypass name native
>>>> multipath. We expect the request fail over to normal HBA, but the request
>>>> is directly completed with BLK_STS_IOERR.
>>>> The two scenarios can be fixed by directly completing the request in queue_rq.
>>> Well, certainly this one-shot always return 0 and complete the command
>>> with HOST_PATH error is not a good approach IMO
>> So what's the better option? Just complete the request with host path
>> error for non-ENOMEM and EAGAIN returned by the HBA driver?
> 
> Well, the correct thing to do here would be to clone the bio and
> failover if the end_io error status is BLK_STS_IOERR. That sucks
> because it adds overhead, but this proposal doesn't sit well. it
> looks wrong to me.
> 
> Alternatively, a more creative idea would be to encode the error
> status somehow in the cookie returned from submit_bio, but that
> also feels like a small(er) hack.
If HBA drivers return !ENOMEM && !EAGIAN, queue_rq Directly call
nvme_complete_rq with NVME_SC_HOST_PATH_ERROR like
nvmf_fail_nonready_command. nvme_complete_rq will decide to retry,
fail over or end the request. This may not be the best, but there seems
to be no better choice.
I will try to send the patch v2.
