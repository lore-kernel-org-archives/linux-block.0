Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1F2C433E6
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 01:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E26238D7
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 01:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbhAVBvA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 20:51:00 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2985 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbhAVBu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 20:50:59 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DMMcq65NyzR65r;
        Fri, 22 Jan 2021 09:49:15 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 09:50:17 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 22
 Jan 2021 09:50:16 +0800
Subject: Re: [PATCH v3 3/5] nvme-fabrics: avoid double request completion for
 nvmf_fail_nonready_command
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC:     <axboe@kernel.dk>, <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <kbusch@kernel.org>
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-4-lengchao@huawei.com>
 <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
 <20210121090012.GA27342@lst.de>
 <467a43b0-82cc-69b7-460a-413ddc8cf574@suse.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <3bcd337b-3ab3-03ab-f9e6-a461cd8ee127@huawei.com>
Date:   Fri, 22 Jan 2021 09:50:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <467a43b0-82cc-69b7-460a-413ddc8cf574@suse.de>
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



On 2021/1/21 17:27, Hannes Reinecke wrote:
> On 1/21/21 10:00 AM, Christoph Hellwig wrote:
>> On Thu, Jan 21, 2021 at 09:58:37AM +0100, Hannes Reinecke wrote:
>>> On 1/21/21 8:03 AM, Chao Leng wrote:
>>>> When reconnect, the request may be completed with NVME_SC_HOST_PATH_ERROR
>>>> in nvmf_fail_nonready_command. The state of request will be changed to
>>>> MQ_RQ_IN_FLIGHT before call nvme_complete_rq. If free the request
>>>> asynchronously such as in nvme_submit_user_cmd, in extreme scenario
>>>> the request may be completed again in tear down process.
>>>> nvmf_fail_nonready_command do not need calling blk_mq_start_request
>>>> before complete the request. nvmf_fail_nonready_command should set
>>>> the state of request to MQ_RQ_COMPLETE before complete the request.
>>>>
>>>
>>> So what you are saying is that there is a race condition between
>>> blk_mq_start_request()
>>> and
>>> nvme_complete_request()
>>
>> Between those to a teardown that cancels all requests can come in.
>>
> Doesn't nvme_complete_request() insulate against a double completion?
nvme_complete_request can not insulate against double completion.
Setting the state of request to MQ_RQ_COMPLETE avoid double completion.
tear down(nvme_cancel_request) check the state of the request, if the
state is MQ_RQ_COMPLETE, it will skip completion.
> I seem to remember we've gone through great lengths ensuring that.
> 
> And if this is just about setting the correct error code on completion I'd really prefer to stick with the current code. Moving that into a helper is fine, but I'd rather not introduce our own code modifying request state.
> 
> If there really is a race condition this feels like a more generic problem; calling blk_mq_start_request() followed by blk_mq_end_request() is a quite common pattern, and from my impression the recommended way.
> So if there is an issue it would need to be addressed for all drivers, not just some nvme-specific way.
Currently, it is not safe for nvme. The probability is very low.
I am not sure whether similar occurs in other scenarios.
> Plus I'd like to have Jens' opinion here.
> 
> Cheers,
> 
> Hannes
