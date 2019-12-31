Return-Path: <SRS0=i4wP=2V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF6CC2D0C8
	for <linux-block@archiver.kernel.org>; Tue, 31 Dec 2019 03:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4F3206DB
	for <linux-block@archiver.kernel.org>; Tue, 31 Dec 2019 03:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OHsnDVpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfLaDyB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Dec 2019 22:54:01 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37455 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLaDyB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Dec 2019 22:54:01 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so694743pjb.2
        for <linux-block@vger.kernel.org>; Mon, 30 Dec 2019 19:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a2Sz5MUvm0ruA+okaCyH8nK0J3zr4ur/Es2NKIaR6m4=;
        b=OHsnDVpHzCP0CsgRmecrr1xazsDKticziqj1BOxFEZkbVtMVb7zqet0v6+KVlH6u/G
         cXIFOfnwjuWxIfToYkxH8nkaFdB3ISL5kwYgtuFHFv0Nc26Fj9d08kIskMJ2AxNLunQo
         uGCtPj44Hu65xTAH0TOAXxTjfEXjAkqmW1HqXlin1psWmGyWVd5WwYoa5wOHXs4Pxg/Q
         6lnR1GixohMtZCOdQ32eG3EKmer/LgSnSeoOCUn7zpZRmHeLsI+9hC5NrFbLHcAQrLhy
         ey8HPcgakok3pUEDXyRYAXyHJPfLBsIwBLfwQel4cffTnaSv7JDT7Un2jT46u6GyT/AU
         k7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a2Sz5MUvm0ruA+okaCyH8nK0J3zr4ur/Es2NKIaR6m4=;
        b=QfgbHjXnPrOZZ3JI3z96+Hk7QGsl45TueOU53LbC/air+wVc8kL+E6u5OqNn6g4vKO
         N13LYUYY8EJIWkm73Hu1/hIQ++n1XQwqCkZut+KYzs+NYP8u2MnxE6p2IYwOrBfQ7Jh1
         B/6sM6fNYCu6r+726hsnjWpt+6EmIy7eFyhjL/jDBshaweCkowfe2QAeJUDVe8YnM7yK
         JEvfwOdZBxw1FaO/ZvDBqiVJ3Cm1efEj1MplvjPcKgzTISs4RtXbc/G7jSeQw8uWMVqe
         iCxhgCKYXA3oLixgbh/xBftihS9xkl7jwxKePVmxrLGTW4ZdaBkLJmurj61fj1XmEU15
         81WA==
X-Gm-Message-State: APjAAAWpNWJiqf5Mf+ql6RR/J0eld4U4Sb4Hpe346uoW15UaYKL4Vz8k
        q9hki79VTWyu36OkE5Y6kFt0YtGXNoMZJQ==
X-Google-Smtp-Source: APXvYqx8uhrks7spVZSshzZOt+oYK4BD0yZCdJ7d8FExcfvJY952TPdm8rEZqcIV8JyorxzFUiyc5A==
X-Received: by 2002:a17:90a:8814:: with SMTP id s20mr3668854pjn.136.1577764440309;
        Mon, 30 Dec 2019 19:54:00 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:e060:716d:87c4:d549? ([2605:e000:100e:8c61:e060:716d:87c4:d549])
        by smtp.gmail.com with ESMTPSA id c14sm1090117pjr.24.2019.12.30.19.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 19:53:59 -0800 (PST)
Subject: Re: [PATCH 4/4] blk-mq: allocate tags in batches
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20191230181442.4460-1-axboe@kernel.dk>
 <20191230181442.4460-5-axboe@kernel.dk> <20191231021834.GA20062@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4587c4e6-a25f-9a68-ee6f-e0eb6da2e327@kernel.dk>
Date:   Mon, 30 Dec 2019 20:53:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191231021834.GA20062@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/30/19 7:18 PM, Ming Lei wrote:
>> +static int blk_mq_get_tag_batch(struct blk_mq_alloc_data *data)
>> +{
>> +	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
>> +	struct sbitmap_queue *bt = &tags->bitmap_tags;
>> +	struct blk_mq_ctx *ctx = data->ctx;
>> +	int tag, cpu;
>> +
>> +	if (!ctx)
>> +		return -1;
>> +
>> +	preempt_disable();
>> +
>> +	/* bad luck if we got preempted coming in here, should be rare */
>> +	cpu = smp_processor_id();
>> +	if (unlikely(ctx->cpu != cpu)) {
>> +		ctx = data->ctx = __blk_mq_get_ctx(data->q, cpu);
>> +		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags, ctx);
> 
> When blk_mq_get_tag_batch is called for getting driver tag, rq->mq_hctx
> has been bound to the current request in blk_mq_rq_ctx_init(), so looks
> we shouldn't change hctx here.

->ctx is also NULL for that case, so it gets skipped. Probably needs a
comment...

I'll need to check if all cases are covered, the batched tags should be
exclusive to the non-reserved, regular tags. Or just the scheduler tags,
if a scheduler is attached. Not sure it makes a lot of sense to handle
the scheduler case as well (and have two sets of batches, driver tags
and scheduler tags), but if it does, we could extend it for that and
just bail if we're not on the right ctx anymore. In all honesty, I wrote
that above code without ever checking that it happens. It most certainly
could, but I'd consider it a very low risk. So might be better to simply
just return -1 for that case and ignore it.

-- 
Jens Axboe

