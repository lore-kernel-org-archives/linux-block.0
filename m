Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76A0C63798
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 14:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B9C2083E
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 14:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgKYOPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 09:15:51 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45643 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729109AbgKYOPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 09:15:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGWQ0Kg_1606313739;
Received: from 30.0.173.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGWQ0Kg_1606313739)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Nov 2020 22:15:39 +0800
Subject: Re: [PATCH 4/7] blk-iocost: Add a flag to indicate if need update hwi
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <beb9ab5875427431b58e1001e481b7a43e9188eb.1606186717.git.baolin.wang@linux.alibaba.com>
 <X75KuGR1MTovojZp@mtj.duckdns.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <d0488a26-bff3-bd92-b5c7-74131161d55e@linux.alibaba.com>
Date:   Wed, 25 Nov 2020 22:15:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X75KuGR1MTovojZp@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hello,
> 
> On Tue, Nov 24, 2020 at 11:33:33AM +0800, Baolin Wang wrote:
>> @@ -1445,7 +1447,8 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
>>   	 * after the above debt payment.
>>   	 */
>>   	ctx.vbudget = vbudget;
>> -	current_hweight(iocg, NULL, &ctx.hw_inuse);
>> +	if (need_update_hwi)
>> +		current_hweight(iocg, NULL, &ctx.hw_inuse);
> 
> So, if you look at the implementation of current_hweight(), it's
> 
> 1. If nothing has changed, read out the cached values.
> 2. If something has changed, recalculate.

Yes, correct.

> 
> and the "something changed" test is single memory read (most likely L1 hot
> at this point) and testing for equality. IOW, the change you're suggesting
> isn't much of an optimization. Maybe the compiler can do a somewhat better
> job of arranging the code and it's a register load than memory load but
> given that it's already a relatively cold wait path, this is unlikely to
> make any actual difference. And that's how current_hweight() is meant to be
> used.

What I want to avoid is the 'atomic_read(&ioc->hweight_gen)' in 
current_hweight(), cause this is not a register load and is always a 
memory load. But introducing a flag can be cached and more light than a 
memory load.

But after thinking more, I think we can just move the 
"current_hweight(iocg, NULL, &ctx.hw_inuse);" to the correct place 
without introducing new flag to optimize the code. How do you think the 
below code?

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index bbe86d1..db29200 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1413,7 +1413,7 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, 
bool pay_debt,

         lockdep_assert_held(&iocg->waitq.lock);

-       current_hweight(iocg, &hwa, NULL);
+       current_hweight(iocg, &hwa, &ctx.hw_inuse);
         vbudget = now->vnow - atomic64_read(&iocg->vtime);

         /* pay off debt */
@@ -1428,6 +1428,11 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, 
bool pay_debt,
                 atomic64_add(vpay, &iocg->done_vtime);
                 iocg_pay_debt(iocg, abs_vpay, now);
                 vbudget -= vpay;
+               /*
+                * As paying off debt restores hw_inuse, it must be read 
after
+                * the above debt payment.
+                */
+               current_hweight(iocg, NULL, &ctx.hw_inuse);
         }

         if (iocg->abs_vdebt || iocg->delay)
@@ -1446,11 +1451,9 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, 
bool pay_debt,

         /*
          * Wake up the ones which are due and see how much vtime we'll 
need for
-        * the next one. As paying off debt restores hw_inuse, it must 
be read
-        * after the above debt payment.
+        * the next one.
          */
         ctx.vbudget = vbudget;
-       current_hweight(iocg, NULL, &ctx.hw_inuse);

         __wake_up_locked_key(&iocg->waitq, TASK_NORMAL, &ctx);

> 
> So, I'm not sure this is an improvement. It increases complication without
> actually gaining anything.
> 
> Thanks.
> 
