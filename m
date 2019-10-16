Return-Path: <SRS0=Rbhm=YJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E1ECE59D
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 01:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE8B20873
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 01:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="etSsEh50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbfJPBpF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:45:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46077 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731636AbfJPBpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 21:45:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so13614350pfb.12
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 18:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WvBxsGQecaxmzrfSNUUG3WJS7HFW8ee1ZIKpDQzVjXM=;
        b=etSsEh50qCg+85YKoDQI96RvRD6gEtiCW5gyeC65jADYVX+vvI7w9L5VPik8dmrXbt
         69r/FgXeXyWrXqrfX3lMKUHCeVVxet9djhmNJIZ19UwxBAn/kPK2MnOySHKvGpBZYT+9
         AJ+UXJlQN6g8t+ryCnqoKllj6QurwOXeGpOHpyJaylUHe8c5AmzmH5WCeiReepINpz7Z
         zn2NAQz+7kSIRQ331PlDvBBvrnk1ObafBFZvBMd8pEM/epnI31qNND7InzL+295FtK6i
         BN2uBFND2NXiUkqhcDaBkrCVkljp9eIxefxFJfGl2Ta4Dh7YUFeyTHZeFYRQjCA6G7NX
         a+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WvBxsGQecaxmzrfSNUUG3WJS7HFW8ee1ZIKpDQzVjXM=;
        b=ZIjcruIHQOfwXqJVxxyCQlWcxQ2fQZYSWSQFNri1UnqMPf1my2qr8NBrJIIuakUyMP
         0gK9kUzZ/up0M2HRztbU7lcEYNGK+/Bcp2FqobDgexUdJZelvi654miCVqSl7/wyy09/
         GwEbSerZhZSXphHjmJdlVlEJPGmKEExK05fcjy0Dogbakt8G16lYf7v/x8kxyvyi236b
         wD9mGGZqP7cpkYSv0op/Fbp82h9Kuu/zHj6AlqYyTFlAiZ0UvkvPo8e6D0Vsmt2DdHre
         rnVVQRREn1uI2KXkiwn28NgWUMGtIKRUCNvHIxj49Puwx9ZdYrcYAAtGXAMb/s1AmZxY
         tviQ==
X-Gm-Message-State: APjAAAXcIrjU6nAldgu+GDvC0hFmlen59XDnuo/5qVFs5hhLqmS5d7/q
        sDQJYXheKFjXZd7VZANUOreCKQ==
X-Google-Smtp-Source: APXvYqwNAlUz3Y0EcslBYEOth/70qt9XYMrZNtP4JfvzlUjUNqjO6RQoqrZmDEcKgg68NNXX6HjvYw==
X-Received: by 2002:a17:90a:24e8:: with SMTP id i95mr1880265pje.12.1571190303729;
        Tue, 15 Oct 2019 18:45:03 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c69sm5212831pga.69.2019.10.15.18.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 18:45:02 -0700 (PDT)
Subject: Re: [PATCH V3] io_uring: consider the overflow of sequence for
 timeout req
To:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
Cc:     yi.zhang@huawei.com, houtao1@huawei.com
References: <20191015135929.30912-1-yangerkun@huawei.com>
 <df96c0e3-873f-6a54-9e71-0c57d3b6720d@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a9ba7785-8e69-7c00-95f9-5c91e6315a8f@kernel.dk>
Date:   Tue, 15 Oct 2019 19:45:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <df96c0e3-873f-6a54-9e71-0c57d3b6720d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/15/19 7:35 PM, yangerkun wrote:
> 
> 
> On 2019/10/15 21:59, yangerkun wrote:
>> Now we recalculate the sequence of timeout with 'req->sequence =
>> ctx->cached_sq_head + count - 1', judge the right place to insert
>> for timeout_list by compare the number of request we still expected for
>> completion. But we have not consider about the situation of overflow:
>>
>> 1. ctx->cached_sq_head + count - 1 may overflow. And a bigger count for
>> the new timeout req can have a small req->sequence.
>>
>> 2. cached_sq_head of now may overflow compare with before req. And it
>> will lead the timeout req with small req->sequence.
>>
>> This overflow will lead to the misorder of timeout_list, which can lead
>> to the wrong order of the completion of timeout_list. Fix it by reuse
>> req->submit.sequence to store the count, and change the logic of
>> inserting sort in io_timeout.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>    fs/io_uring.c | 27 +++++++++++++++++++++------
>>    1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 76fdbe84aff5..c9512da06973 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -1884,7 +1884,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
>>    
>>    static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>    {
>> -	unsigned count, req_dist, tail_index;
>> +	unsigned count;
>>    	struct io_ring_ctx *ctx = req->ctx;
>>    	struct list_head *entry;
>>    	struct timespec64 ts;
>> @@ -1907,21 +1907,36 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>    		count = 1;
>>    
>>    	req->sequence = ctx->cached_sq_head + count - 1;
>> +	/* reuse it to store the count */
>> +	req->submit.sequence = count;
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
>> +		/*
>> +		 * Since cached_sq_head + count - 1 can overflow, use type long
>> +		 * long to store it.
>> +		 */
>> +		tmp = (long long)ctx->cached_sq_head + count - 1;
>> +		nxt_sq_head = nxt->sequence - nxt->submit.sequence + 1;
>> +		tmp_nxt = (long long)nxt_sq_head + nxt->submit.sequence - 1;
>> +
>> +		/*
>> +		 * cached_sq_head may overflow, and it will never overflow twice
>> +		 * once there is some timeout req still be valid.
>> +		 */
>> +		if (ctx->cached_sq_head < nxt_sq_head)
>> +			tmp_nxt += UINT_MAX;
> 
> Maybe there is a mistake, it should be tmp. So sorry about this.

I ran it through the basic testing, but I guess it doesn't catch overflow
cases. Maybe we can come up with one? Should be pretty simple to setup a
io_uring, post UINT_MAX - 10 nops (or something like that), then do some
timeout testing.

Just send an incremental patch to fix it.

-- 
Jens Axboe

