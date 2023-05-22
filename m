Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A37C7EE23
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 02:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjEVC0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 22:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEVC0e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 22:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A42A2
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 19:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A7B161072
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 02:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD05C433D2;
        Mon, 22 May 2023 02:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684722392;
        bh=QCPgf3+GEi7wCY43ZVmjDgn26XaO5jVI0ESLddqLu24=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QPbSRWpYzysNaVaaOEVKGUsvuM5EPzj4z8taVqzFheG3jiST4L7PeOjvIJN7+dVEx
         9AZsRG3rivaGL7Q56b+kNKOrgbM4W2bjfPrI/2RM6ox0A0IyCntdb06MsiFRuPW/1p
         GP8lJ+mLsVYTaLvbozCz7gc52q8itnGEoOImPVcJ5yikblDZ4Ac0Bf1Y/uTYMFu05B
         m0p07LeAOvuo2klzqve7ZrSDKBENZM5RmaEbNCPWyXfmv3z+MlVD6QtG2bzg2EDvVH
         rjnUVUIkBy6H7zsF66LJFDY1+E0PLIMx2+6EPcvfVo5dEzolAvbsu6TFqe7tpbS4o7
         PmElrlf1+pDKw==
Message-ID: <eeca88b5-0e3e-097d-d7c0-774e85909af3@kernel.org>
Date:   Mon, 22 May 2023 11:26:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Tian Lan <tilan7663@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Tian Lan <tian.lan@twosigma.com>
References: <20230522004328.760024-1-tilan7663@gmail.com>
 <694813ca-690d-4852-0066-cee6833ad8c4@kernel.org>
 <ZGrEJRrZcjYtlMpV@ovpn-8-16.pek2.redhat.com>
 <c8d2e8dc-285d-9675-d915-be3b5b6d6248@kernel.org>
 <ZGrQxHyu4GhZ2hx2@ovpn-8-16.pek2.redhat.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZGrQxHyu4GhZ2hx2@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/22/23 11:17, Ming Lei wrote:
> On Mon, May 22, 2023 at 10:29:05AM +0900, Damien Le Moal wrote:
>> On 5/22/23 10:23, Ming Lei wrote:
>>> On Mon, May 22, 2023 at 10:15:22AM +0900, Damien Le Moal wrote:
>>>> On 5/22/23 09:43, Tian Lan wrote:
>>>>> From: Tian Lan <tian.lan@twosigma.com>
>>>>>
>>>>> If multiple CPUs are sharing the same hardware queue, it can
>>>>> cause leak in the active queue counter tracking when __blk_mq_tag_busy()
>>>>> is executed simultaneously.
>>>>>
>>>>> Fixes: ee78ec1077d3 ("blk-mq: blk_mq_tag_busy is no need to return a value")
>>>>> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
>>>>> ---
>>>>>  block/blk-mq-tag.c | 10 ++++++----
>>>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>>>> index d6af9d431dc6..07372032238a 100644
>>>>> --- a/block/blk-mq-tag.c
>>>>> +++ b/block/blk-mq-tag.c
>>>>> @@ -42,13 +42,15 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>>>>>  	if (blk_mq_is_shared_tags(hctx->flags)) {
>>>>>  		struct request_queue *q = hctx->queue;
>>>>>  
>>>>> -		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
>>>>> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
>>>>> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
>>>>
>>>> This is weird. test_and_set_bit() returns the bit old value, so shouldn't this be:
>>>>
>>>> 		if (test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
>>>> 			return;
>>>>
>>>> ?
>>>
>>> It is one micro optimization since test_and_set_bit is much heavier than
>>> test_bit, so test_and_set_bit() is just needed in the 1st time.
>>
>> But having the 2 calls test_bit + test_and_set_bit creates a race, doesn't it ?
>> What if another cpu clears the bit between these 2 calls ?
> 
> If test_bit() returns 0, there isn't such race since both sides are atomic OP.
> 
> If test_bit() returns 1:
> 
> 1) __blk_mq_tag_busy() vs. __blk_mq_tag_busy()
> - both does nothing
> 
> 2) __blk_mq_tag_busy() vs. __blk_mq_tag_idle()
> - hctx_may_queue() is always following __blk_mq_tag_busy()
> - hctx_may_queue() returns true in case that this flag is cleared
> - current __blk_mq_tag_busy() does nothing, the following allocation
> works fine given hctx_may_queue() returns true
> - new __blk_mq_tag_busy() will setup everything as fine

OK. Thanks. It would be nice to update the function comment (which is not very
clear due to grammar issues) to document this unusual use of the bit functions,
including the fact that it is an optimization to avoid dirtying cache lines.

> 
> 
> Thanks,
> Ming
> 

-- 
Damien Le Moal
Western Digital Research

