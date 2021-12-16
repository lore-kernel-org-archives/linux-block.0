Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94803C433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 12:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhLPMoX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 07:44:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4299 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhLPMoX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 07:44:23 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JFBbY2DVkz67lmV;
        Thu, 16 Dec 2021 20:42:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 13:44:21 +0100
Received: from [10.47.93.135] (10.47.93.135) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 16 Dec
 2021 12:44:20 +0000
Subject: Re: [PATCH v2] block: reduce kblockd_mod_delayed_work_on() CPU
 consumption
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Dexuan Cui <decui@microsoft.com>, Ming Lei <ming.lei@redhat.com>
References: <0eb94fa3-a1d0-f9b3-fb51-c22eaad225a7@kernel.dk>
 <926c2348-23a1-5b32-1369-3deb3d6d1671@huawei.com>
 <c283fb12-30f5-93bd-06fc-f65c547cc94f@kernel.dk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f78e4f2b-0be1-e3e7-69bb-5b6684aa5960@huawei.com>
Date:   Thu, 16 Dec 2021 12:43:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <c283fb12-30f5-93bd-06fc-f65c547cc94f@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.135]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15/12/2021 15:47, Jens Axboe wrote:
>> 0000000000001ef0 <__blk_mq_delay_run_hw_queue>:
>>       [snip]
>>       2024: a942dfb6 ldp x22, x23, [x29, #40]
>>       2028: 2a1503e0 mov w0, w21
>>       202c: 94000000 bl 0 <__msecs_to_jiffies>
>> kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
>>       2030: aa0003e2 mov x2, x0
>>       2034: 91010261 add x1, x19, #0x40
>>       2038: 2a1403e0 mov w0, w20
>>       203c: 94000000 bl 0 <kblockd_mod_delayed_work_on>
>>
>> I'm not sure if you would want to change so many APIs or if jiffies is
>> sensible to pass or even any performance gain. Additionally Function
>> blk_mq_delay_kick_requeue_list() would not see so much gain in such a
>> change as msec value is not const. Any thoughts? Maybe testing
>> performance would not do much harm.
> In general I totally agree with you, it'd be smarter to flip the
> conversion so it can be done in a more efficient manner.


> At the same
> time, the queue delay running is not at all a fast path, so shouldn't
> really matter in practice.

ok, I just thought that from checking your change that we have a 
frequent msec_to_jiffies(0 [non const]) call in 
__blk_mq_delay_run_hw_queue() -> kblockd_mod_delayed_work_on().

Thanks,
John
