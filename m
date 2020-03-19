Return-Path: <SRS0=6FHI=5E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB700C4332B
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 01:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B911D20767
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 01:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCSBm5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:42:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbgCSBm5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 21:42:57 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D2B13D9740C94B40F8FC;
        Thu, 19 Mar 2020 09:42:51 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 19 Mar 2020
 09:42:45 +0800
Subject: Re: [PATCH] block, bfq: fix use-after-free in
 bfq_idle_slice_timer_body
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>, renxudong <renxudong1@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>
References: <6c0d0b36-751b-a63a-418b-888a88ce58f4@huawei.com>
 <C69604D5-CBB7-4A5F-AD73-7A9C0B6B3360@linaro.org>
 <0a6e190a-3393-53f9-b127-d57d67cdcdc8@huawei.com>
 <4171EF13-7956-44DA-A5BF-0245E4926436@linaro.org>
 <241f9766-bfe6-485a-331c-fdc693738ffc@huawei.com>
 <A7FFF605-BAA8-42C1-B648-1D5BA17D1286@linaro.org>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <d4769184-c049-2a2d-0ad4-907bea0e3c6b@huawei.com>
Date:   Thu, 19 Mar 2020 09:42:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <A7FFF605-BAA8-42C1-B648-1D5BA17D1286@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2020/3/18 19:07, Paolo Valente wrote:
> 
> 
>> Il giorno 18 mar 2020, alle ore 10:52, Zhiqiang Liu <liuzhiqiang26@huawei.com> ha scritto:
>>
>>
>>
>> On 2020/3/18 16:45, Paolo Valente wrote:
>>>
>>>
>>>>>> 	spin_lock_irqsave(&bfqd->lock, flags);
>>>>>> -	bfq_clear_bfqq_wait_request(bfqq);
>>>>>> -
>>>>>> 	if (bfqq != bfqd->in_service_queue) {
>>>>>> 		spin_unlock_irqrestore(&bfqd->lock, flags);
>>>>>> 		return;
>>>>>> 	}
>>>>>>
>>>>>> +	bfq_clear_bfqq_wait_request(bfqq);
>>>>>> +
>>>>>
>>>>> Please add a comment on why you (correctly) clear this flag only if bfqq is in service.
>>>>>
>>>>> For the rest, seems ok to me.
>>>>>
>>>>> Thank you very much for spotting and fixing this bug,
>>>>> Paolo
>>>>>
>>>> Thanks for your reply.
>>>> Considering that the bfqq may be in race, we should firstly check whether bfqq is in service before
>>>> doing something on it.
>>>>
>>>
>>> The comment you propose is correct, but the correctness issue I raised
>>> is essentially the opposite.  Sorry for not being clear.
>>>
>>> Let me put it the other way round: why is it still correct that, if
>>> bfqq is not the queue in service, then that flag is not cleared at all?
>>> IOW, why is it not a problem that that flag remains untouched is bfqq
>>> is not in service?
>>>
>>> Thanks,
>>> Paolo
>>>
>> Thanks for your patient.
>> As you comment in bfq_idle_slice_timer, there are two race situations as follows,
>> a) bfqq is null
>>   bfq_idle_slice_timer will not call bfq_idle_slice_timer_body ->no problem
>> b) bfqq are not in service
>>   1) bfqq is freed
>>      it will cause use-after-free problem before calling bfq_clear_bfqq_wait_request
>>      in bfq_idle_slice_timer_body. -> use-after-free problem as analyzed in the patch.
>>   2) bfqq is not freed
>>      it means in_service_queue has been set to a new bfqq. The old bfqq has been expired
>>      through __bfq_bfqq_expire func. Then the wait_request flags of old bfqq will be cleared
>>      in __bfq_bfqd_reset_in_service func. -> it is no a problem to re-clear the wait_request
>>      flags before checking whether bfqq is in service.
> 
> Great, this item 2 is exactly what I meant.  We need a comment
> because, even if now this stuff is clear to you, imagine somebody
> else getting to your modified piece of code after reading hundreds of
> lines of code, about a non-trivial state machine as BFQ ...  :)
> 
> Thanks,
> Paolo
> 
Ok, I will add the following comment in the v3 patch.

Considering that the bfqq may be in race, we should firstly check whether bfqq is in service
before doing something on it. If the bfqq in race is not in service, it means the bfqq has
been expired through __bfq_bfqq_expire func, and wait_request flags has been cleared in
__bfq_bfqd_reset_in_service func.

>>
>> In one word, the old bfqq in race has already cleared the wait_request flag when switching in_service_queue.
>>
>> Thanks,
>> Zhiqiang Liu
>>
>>>>>>
>>>>>
>>>>>
>>>>> .
>>>
>>>
>>> .
>>>
>>
> 
> 
> .
> 

