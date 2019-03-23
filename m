Return-Path: <SRS0=7zlQ=R2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE5C43381
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD18218B0
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 12:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfCWMa5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:30:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbfCWMa4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Mar 2019 08:30:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8CF16E9D0C66107CD9EB;
        Sat, 23 Mar 2019 20:30:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Sat, 23 Mar 2019
 20:30:53 +0800
Subject: Re: [PATCH 1/2] blk-mq: convert hctx.nr_active to refcount_t
To:     Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
CC:     <dwindsor@gmail.com>, <linux-block@vger.kernel.org>
References: <20190322144818.987-1-yuyufen@huawei.com>
 <20190322144818.987-2-yuyufen@huawei.com>
 <20190322150116.GZ6058@hirez.programming.kicks-ass.net>
 <20190322150429.GO6521@hirez.programming.kicks-ass.net>
 <43a089cb-8124-b159-6263-b986f8ef8781@kernel.dk>
From:   yuyufen <yuyufen@huawei.com>
Message-ID: <6c9a6509-22de-2c77-ccf0-0895d4acd960@huawei.com>
Date:   Sat, 23 Mar 2019 20:30:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <43a089cb-8124-b159-6263-b986f8ef8781@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi


On 2019/3/22 23:21, Jens Axboe wrote:
> On 3/22/19 9:04 AM, Peter Zijlstra wrote:
>> On Fri, Mar 22, 2019 at 04:01:16PM +0100, Peter Zijlstra wrote:
>>> On Fri, Mar 22, 2019 at 10:48:17PM +0800, Yufen Yu wrote:
>>>> @@ -2710,7 +2710,7 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
>>>>   		return NULL;
>>>>   	}
>>>>   
>>>> -	atomic_set(&hctx->nr_active, 0);
>>>> +	refcount_set(&hctx->nr_active, 0);
>>>>   	hctx->numa_node = node;
>>>>   	hctx->queue_num = hctx_idx;
>>>>   
>>> That looks bogus, refcount_t cannot inc-from-zero.
>> I also don't see a single dec_and_test in that patch, which leads me to
>> believe nr_active is not in fact a refcount.
> It isn't a refcount at all, it's just a count of how many queues are
> active in a shared tag map scenario.
>

Sorry for the noise. And thanks a lot for review. I think I have no idea 
for the difference
between count and refcount. So I think it can covert 'atomic' to 
'refcount' anywhere
no matter if it is really needed. After all , 'refcount' has advantages 
to check overflow and underflow.

Elena Reshetova have clearly summarized which atomic_t should be covert 
to refcount_t [1], which was worth me to learn.
" atomic_t variables are currently used to implement reference
counters with the following properties:
  - counter is initialized to 1 using atomic_set()
  - a resource is freed upon counter reaching zero
  - once counter reaches zero, its further
    increments aren't allowed
  - counter schema uses basic atomic operations
    (set, inc, inc_not_zero, dec_and_test, etc.)
Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows
and underflows. "

[1] https://lore.kernel.org/patchwork/patch/826782/

Yufen
Thanks

