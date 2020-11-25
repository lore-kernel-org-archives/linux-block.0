Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C128C56202
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 13:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E0220578
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 13:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgKYNnZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 08:43:25 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36850 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729594AbgKYNnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 08:43:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGWPBin_1606311802;
Received: from 30.0.173.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGWPBin_1606311802)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Nov 2020 21:43:22 +0800
Subject: Re: [PATCH 7/7] blk-iocost: Factor out the base vrate change into a
 separate function
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <f58ff36d7e24716994f2de22be461602fb49b6d5.1606186717.git.baolin.wang@linux.alibaba.com>
 <X75OTmArk6X1pnV6@mtj.duckdns.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <6c1fba15-f03f-e520-d41d-eff0b2ecdab2@linux.alibaba.com>
Date:   Wed, 25 Nov 2020 21:43:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X75OTmArk6X1pnV6@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hello,
> 
> On Tue, Nov 24, 2020 at 11:33:36AM +0800, Baolin Wang wrote:
>> @@ -2320,45 +2358,11 @@ static void ioc_timer_fn(struct timer_list *timer)
>>   	ioc->busy_level = clamp(ioc->busy_level, -1000, 1000);
>>   
>>   	if (ioc->busy_level > 0 || (ioc->busy_level < 0 && !nr_lagging)) {
>> -		u64 vrate = ioc->vtime_base_rate;
>> -		u64 vrate_min = ioc->vrate_min, vrate_max = ioc->vrate_max;
> ...
>> +		trace_iocost_ioc_vrate_adj(ioc, ioc->vtime_base_rate,
>> +					   missed_ppm, rq_wait_pct,
>>   					   nr_lagging, nr_shortages);
>> -
>> -		ioc->vtime_base_rate = vrate;
>> -		ioc_refresh_margins(ioc);
>>   	} else if (ioc->busy_level != prev_busy_level || nr_lagging) {
>>   		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
>>   					   missed_ppm, rq_wait_pct, nr_lagging,
> 
> I think it'd be better to factor out the surrounding if/else block together

OK.

> (as early exit if blocks). Also, how about ioc_adjust_base_vrate()?

Sure, will rename it in next version. Thanks.
