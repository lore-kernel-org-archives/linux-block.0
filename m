Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA3FC6369E
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A9120C56
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgLCBrj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:47:39 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41732 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbgLCBri (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 20:47:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UHMt5k4_1606960015;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UHMt5k4_1606960015)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Dec 2020 09:46:56 +0800
Subject: Re: [PATCH v2] block: fix inflight statistics of part0
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org
References: <20201202111145.36000-1-jefflexu@linux.alibaba.com>
 <4317c6c9-886f-c921-70c1-ccc12ba6ae79@linux.alibaba.com>
 <20201202112050.GA2201@infradead.org>
 <699798e0-6b38-105f-aacc-938f3ecd6ce4@kernel.dk>
 <20201202190515.GA19811@infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <a0142c31-6ef3-a35c-f4cb-34dbf98a1194@linux.alibaba.com>
Date:   Thu, 3 Dec 2020 09:46:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202190515.GA19811@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/3/20 3:05 AM, Christoph Hellwig wrote:
> On Wed, Dec 02, 2020 at 09:48:03AM -0700, Jens Axboe wrote:
>> On 12/2/20 4:20 AM, Christoph Hellwig wrote:
>>> On Wed, Dec 02, 2020 at 07:17:55PM +0800, JeffleXu wrote:
>>>>> Fixes: bf0ddaba65dd ("blk-mq: fix sysfs inflight counter")
>>>>> Fixes: f299b7c7a9de ("blk-mq: provide internal in-flight variant")
>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>>> ---
>>>>> v2: update the commit log, adding 'Fixes' tag
>>>>
>>>> Forgot to add 'stable' tag.
>>>
>>> The fixes tags take care of that automatically.
>>>
>>> Note that this patch will cause a merge conflict with my work in
>>> linux-next, but the resolution is pretty trivial.
>>
>> Might be better to handle on the stable side, and just apply this to
>> 5.11. It's not a new regression.
> 
> If you apply it to for-5.11/block it won't compile.  It'll need a quick
> s/partno/bd_partno/ there.
> 

Fine. I will resend a new version later on the code base of for-5.11/block.

-- 
Thanks,
Jeffle
