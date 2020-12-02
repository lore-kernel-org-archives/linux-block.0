Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D77C64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 08:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FFF206E3
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 08:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbgLBIuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 03:50:11 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49025 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387880AbgLBIuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 03:50:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UHJGIJ5_1606898967;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UHJGIJ5_1606898967)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Dec 2020 16:49:28 +0800
Subject: Re: [PATCH] block: fix inflight statistics of part0
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20201126094833.61309-1-jefflexu@linux.alibaba.com>
 <20201202082941.GA23319@infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <ef7fcad0-f682-cf81-658c-d29c7cea7aa6@linux.alibaba.com>
Date:   Wed, 2 Dec 2020 16:49:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202082941.GA23319@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/2/20 4:29 PM, Christoph Hellwig wrote:
> On Thu, Nov 26, 2020 at 05:48:33PM +0800, Jeffle Xu wrote:
>> The inflight of partition 0 doesn't include inflight IOs to all
>> sub-partitions, since currently mq calculates inflight of specific
>> partition by simply camparing the value of the partition pointer.
>>
>> Thus the following case is possible:
>>
>> $ cat /sys/block/vda/inflight
>> ?? ?? ?? ??0 ?? ?? ?? ??0
>> $ cat /sys/block/vda/vda1/inflight
>> ?? ?? ?? ??0 ?? ?? ??128
>>
>> Partition 0 should be specially handled since it represents the whole
>> disk.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But can you resend with your information on the old kernels, and maybe
> even with a Fixes tag?
> 

Thanks, I will send a v2 version later.

-- 
Thanks,
Jeffle
