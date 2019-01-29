Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C25C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697B521473
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RZfXjXYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfA2SOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:14:48 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39459 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfA2SOs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 13:14:48 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so17074520iob.6
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M25vN8BIGQT3TARxuCxQO7arlkxkaFFQsyuTQJHmrqo=;
        b=RZfXjXYAh4lS6NskupdV6Ksj8btwSRsvcTpIH+8wACjIAUtdhQSB9QhrUGyiLT0JgW
         luBmVdkxneDDJyC4jvXfVC21k2/7euO9qRTrSnM6dIKF5SHROLd2y0WDoO7WDSn1SMd7
         5WuEDSy9AjAruVCiaC27gNO5gFm+nQnI9sNGCVzz42O2ElKXGkGqvXfaJPDsgBlm83j4
         huwipfJuI1TBZhbKL+B5Ga0iGI+j8gl/129tTPiSHdkhft0IafnJ1AaH5mydmQDcY/+L
         ogg7nyaFYnUyxballdhiRXSoT8fFCLwiQnUcxm8TaBYV3E4hH0LeK3vkojMe3SSrf8IW
         +kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M25vN8BIGQT3TARxuCxQO7arlkxkaFFQsyuTQJHmrqo=;
        b=AUO3c1Dxw03+yrHUvGBbFoU2VOsmVUCleN8tOdtrsHwD5mzLBtBnCXJQ4vPgaukJgq
         7zCB2q9uQcvnIOSIVcTrZQdGbF6edA7ImR706GvMia8POmV9vV/QdpeoB+fzu4gMwkaq
         V0gfkC/4QyiOvcm3VYxjIhaf+k8M5xTAVyjSgevVqMYlw9igFPIJOYyHQdKMG3TgpQXP
         MArycbykFJqdD/7jmOkEWM33hvCfcbMl2XrtCoNadfoIsNoCZeaJ0jHwPwQ5CRA0C9QI
         O5I+SQrhb4pE+Zq41CG9BkPbNnQlWC3+PpOx/Eo+33v3oAHiIjd20NVWlbIrUPVFJe1y
         Y22A==
X-Gm-Message-State: AHQUAubcXeHYvOb6cCsZytWC7D3didvQ1bQUETJuFoHcKYVr3MgfpNu2
        1iSvbifx905znhOdnwjqdiWrjg==
X-Google-Smtp-Source: AHgI3IaGmaEX5tZz5DG38NHsL8KCBLb5UHm55b/+cZVZx8YzFxMPjN9rXwech68K5lAgyMnzKZQDUg==
X-Received: by 2002:a6b:3fd7:: with SMTP id m206mr990972ioa.210.1548785687354;
        Tue, 29 Jan 2019 10:14:47 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k2sm1900506itk.35.2019.01.29.10.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:14:46 -0800 (PST)
Subject: Re: [PATCH 10/18] io_uring: batch io_kiocb allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-11-axboe@kernel.dk> <20190129172624.GB15347@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9e99b94e-dcd1-4c4d-1dc9-384b29f31528@kernel.dk>
Date:   Tue, 29 Jan 2019 11:14:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129172624.GB15347@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 10:26 AM, Christoph Hellwig wrote:
>> -static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
>> +static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>> +				   struct io_submit_state *state)
>>  {
>> +	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN;
> 
> No actually in this patch, but why do we do GFP_ATOMIC allocations
> here?  We aren't in irq context or under a spinlock.

Just to avoid dipping into more expensive allocs. Probably not a big
deal, I'll remove the atomic.

> 
>> +	if (!state)
>> +		req = kmem_cache_alloc(req_cachep, gfp);
> 
> Add a
> 		if (!req)
> 			goto out;
> 
> plus the missing braces here..
> 
>> +	else if (!state->free_reqs) {
>> +		size_t sz;
>> +		int ret;
>> +
>> +		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
>> +		ret = kmem_cache_alloc_bulk(req_cachep, gfp, sz,
>> +						state->reqs);
>> +		if (ret <= 0)
>> +			goto out;
>> +		state->free_reqs = ret - 1;
>> +		state->cur_req = 1;
>> +		req = state->reqs[0];
>> +	} else {
>> +		req = state->reqs[state->cur_req];
>> +		state->free_reqs--;
>> +		state->cur_req++;
>> +	}
>> +
>>  	if (req) {
>>  		req->ctx = ctx;
>>  		req->flags = 0;
>>  		return req;
>>  	}
> 
> ... and we don't need this conditional, which would otherwise also
> be in the fast path.

Good idea, done.

-- 
Jens Axboe

