Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDB6C433C1
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38D86196F
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 08:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhC2IIz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 04:08:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15372 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhC2IIY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 04:08:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F84sR26S4z9sLf;
        Mon, 29 Mar 2021 16:06:19 +0800 (CST)
Received: from [10.174.179.174] (10.174.179.174) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 16:08:21 +0800
Subject: Re: [RFC PATCH] block: protect bi_status with spinlock
To:     Keith Busch <kbusch@kernel.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <hch@lst.de>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>
References: <20210329022337.3992955-1-yuyufen@huawei.com>
 <20210329030246.GA15392@redsun51.ssa.fujisawa.hgst.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <e6ec05a8-1db5-6cb2-aa76-987ce6f1852c@huawei.com>
Date:   Mon, 29 Mar 2021 16:08:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20210329030246.GA15392@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/3/29 11:02, Keith Busch wrote:
> On Sun, Mar 28, 2021 at 10:23:37PM -0400, Yufen Yu wrote:
>>   static struct bio *__bio_chain_endio(struct bio *bio)
>>   {
>>   	struct bio *parent = bio->bi_private;
>> +	unsigned long flags;
>>   
>> +	spin_lock_irqsave(&parent->bi_lock, flags);
>>   	if (!parent->bi_status)
>>   		parent->bi_status = bio->bi_status;
>> +	spin_unlock_irqrestore(&parent->bi_lock, flags);
> 
> 
> I don't see a spin_lock_init() on this new lock, though a spinlock seems
> overkill here. If you need an atomic update, you could do:
> 
> 	cmpxchg(&parent->bi_status, 0, bio->bi_status);
> 
> But I don't even think that's necessary. There really is no need to set
> parent->bi_status if bio->bi_status is 0, so something like this should
> be fine:
> 
>    	if (bio->bi_status && !parent->bi_status)
>    		parent->bi_status = bio->bi_status;
> .
>

Yeah, this is more smart. Thanks a lot for your suggestion.
I will send v2.

Thanks,
Yufen

