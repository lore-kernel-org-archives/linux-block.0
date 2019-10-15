Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5F0C10F14
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 13:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DB72064B
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 13:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfJONEm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:04:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728607AbfJONEm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 09:04:42 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 15CFF983C83FF4E43AD6;
        Tue, 15 Oct 2019 21:04:36 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 21:04:29 +0800
Subject: Re: [PATCH V2] io_uring: consider the overflow of sequence for
 timeout req
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>
References: <20191014115156.43151-1-yangerkun@huawei.com>
 <b5143060-81b5-c6de-f5f9-f8d9a2186fdc@kernel.dk>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <f659f557-7321-c050-c1a1-4a552bdd482d@huawei.com>
Date:   Tue, 15 Oct 2019 21:04:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b5143060-81b5-c6de-f5f9-f8d9a2186fdc@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/10/15 4:10, Jens Axboe wrote:
> On 10/14/19 5:51 AM, yangerkun wrote:
>> The sequence for timeout req may overflow, and it will lead to wrong
>> order of timeout req list. And we should consider two situation:
>>
>> 1. ctx->cached_sq_head + count - 1 may overflow;
>> 2. cached_sq_head of now may overflow compare with before
>> cached_sq_head.
>>
>> Fix the wrong logic by add record of count and use type long long to
>> record the overflow.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>    fs/io_uring.c | 31 +++++++++++++++++++++++++------
>>    1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 76fdbe84aff5..c8dbf85c1c91 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -288,6 +288,7 @@ struct io_poll_iocb {
>>    struct io_timeout {
>>    	struct file			*file;
>>    	struct hrtimer			timer;
>> +	unsigned			count;
>>    };
> 
> Can we reuse io_kiocb->submit->sequence for this? Unfortunately doing it
> the way that you did, which does make the most logical sense, means that
> struct io_kiocb will now spill into a 4th cacheline.
> 
> Or maybe fold ->sequence and ->submit.sequence to reclaim that space?

Yeah, prefer to reuse ->submit.sequence to dump the count. I have never 
thought about the cacheline before. Thanks a lot!

> 
>> @@ -1907,21 +1908,39 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>    		count = 1;
>>    
>>    	req->sequence = ctx->cached_sq_head + count - 1;
>> +	req->timeout.count = count;
>>    	req->flags |= REQ_F_TIMEOUT;
>>    
>>    	/*
>>    	 * Insertion sort, ensuring the first entry in the list is always
>>    	 * the one we need first.
>>    	 */
>> -	tail_index = ctx->cached_cq_tail - ctx->rings->sq_dropped;
>> -	req_dist = req->sequence - tail_index;
>>    	spin_lock_irq(&ctx->completion_lock);
>>    	list_for_each_prev(entry, &ctx->timeout_list) {
>>    		struct io_kiocb *nxt = list_entry(entry, struct io_kiocb, list);
>> -		unsigned dist;
>> +		unsigned nxt_sq_head;
>> +		long long tmp, tmp_nxt;
>>    
>> -		dist = nxt->sequence - tail_index;
>> -		if (req_dist >= dist)
>> +		/* count bigger than before should break directly. */
>> +		if (count >= nxt->timeout.count)
>> +			break;
> 
> Took me a bit, but I guess that's true. It's an optimization, maybe it'd be
> cleaner if we just stuck to the sequence checking?

It's a good idea and thanks for you suggestion! I will resend the patch 
soon!

Thanks,
Kun.

> 

