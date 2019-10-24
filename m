Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45506CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A7E205F4
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 18:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504014AbfJXSMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:12:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55466 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504015AbfJXSMS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 14:12:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id D34CA28DA9A
Subject: Re: [PATCH] blk-mq: remove needless goto from blk_mq_get_driver_tag
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20191022174108.15554-1-andrealmeid@collabora.com>
 <2a8a99a6-4b39-e459-988a-ba9502919044@acm.org>
 <f3e19c37-2430-81d5-ed5b-bc15d93e93c2@kernel.dk>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <9f8cd2a8-a0b7-00e0-3d2e-16d1372d5989@collabora.com>
Date:   Thu, 24 Oct 2019 15:10:50 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f3e19c37-2430-81d5-ed5b-bc15d93e93c2@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/19 12:32 AM, Jens Axboe wrote:
> On 10/23/19 7:34 PM, Bart Van Assche wrote:
>> On 2019-10-22 10:41, André Almeida wrote:
>>> The only usage of the label "done" is when (rq->tag != -1) at the
>>> begging of the function. Rather than jumping to label, we can just
>>> remove this label and execute the code at the "if". Besides that,
>>> the code that would be executed after the label "done" is the return of
>>> the logical expression (rq->tag != -1) but since we are already inside
>>> the if, we now that this is true. Remove the label and replace the goto
>>> with the proper result of the label.
>>>
>>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>>> ---
>>> Hello,
>>>
>>> I've used `blktest` to check if this change add any regression. I have
>>> used `./check block` and I got the same results with and without this
>>> patch (a bunch of "passed" and three "not run" because of the virtual
>>> scsi capabilities). Please let me know if there would be a better way to
>>> test changes at block stack.
>>>
>>> This commit was rebase at linux-block/for-5.5/block.
>>>
>>> Thanks,
>>> 	André
>>> ---
>>>   block/blk-mq.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 8538dc415499..1e067b78ab97 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1036,7 +1036,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
>>>   	bool shared;
>>>   
>>>   	if (rq->tag != -1)
>>> -		goto done;
>>> +		return true;
>>>   
>>>   	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
>>>   		data.flags |= BLK_MQ_REQ_RESERVED;
>>> @@ -1051,7 +1051,6 @@ bool blk_mq_get_driver_tag(struct request *rq)
>>>   		data.hctx->tags->rqs[rq->tag] = rq;
>>>   	}
>>>   
>>> -done:
>>>   	return rq->tag != -1;
>>>   }
>>
>> Do we really need code changes like the above? I'm not aware of any text
>> in the Documentation/ directory that forbids the use of goto statements.

goto are allowed, but the coding style document[1] provides some
rationale for using goto, including that "If there is no cleanup needed
then just return directly". Seems like this code used to do some stuff
in the the past, but since 8ab6bb9ee8d0 "blk-mq: cleanup
blk_mq_get_driver_tag()" it is just a return.

> 
> Agree, it looks fine as-is. It's also a fast path, so I'd never get rid
> of that without looking at the generated code.
> 

You can have a look at the generated code for x86, here's the
original[2] and here is the modified[3]. The only improvement at the
assembly is that we get rid of this duplicated cmp instruction:

    2736:   83 f8 ff                cmp    eax,0xffffffff
    2739:   75 4b                   jne    2786
    ...
    2786:   83 f8 ff                cmp    eax,0xffffffff
    2789:   0f 95 c0                setne  al

Thanks,
	André

[1]
https://www.kernel.org/doc/html/latest/process/coding-style.html#centralized-exiting-of-functions

[2] https://pastebin.com/5eV8c2mK

[3] https://pastebin.com/Gwf2Z9FA
