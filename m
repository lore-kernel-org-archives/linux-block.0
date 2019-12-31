Return-Path: <SRS0=i4wP=2V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EE0C2D0C8
	for <linux-block@archiver.kernel.org>; Tue, 31 Dec 2019 04:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93332072A
	for <linux-block@archiver.kernel.org>; Tue, 31 Dec 2019 04:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1kQ611mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfLaELr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Dec 2019 23:11:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35023 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfLaELr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Dec 2019 23:11:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so15463571plt.2
        for <linux-block@vger.kernel.org>; Mon, 30 Dec 2019 20:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=msq1NFeb08a678QkxdWKULQm++wizk0iesaBQKdJl1M=;
        b=1kQ611mX60laOVau/YrDRiVECCmKbxL1A/RmF52AzmrFjpFKj+YpaVlzVeo53pOMtC
         pDeDRTfAyXYX/dCGKAh8s2l6XXvjbTF+rw7MchoK2FpokYaUXUJMWn7sWv9z0LcTkSdY
         4806x1WZcWgFw/J6S25/UE/ZURc98YR1p+dLXiWVynhGxHNL3zmCpXl1zr81klvjrD5Z
         W/8XCpgnODUEHhWaFjz1mIP7rhVPwFWxLhDwTTYKrEzO0vuLN83qvqHaJa3MoQFT6Wsl
         YvapmE3nM03I66kHKwltmMBLUn25ml48izbEuY1rrOdJ8yEUAqxytoNWsccSne0Q0PFa
         6/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=msq1NFeb08a678QkxdWKULQm++wizk0iesaBQKdJl1M=;
        b=pIUXvY5QsS2p4gr3Leoi8Bs5Xe2bjZdMUjLwU6eddsQLNJ8xtOTP00ALMVNiiEVyOF
         GueBNsLO+naH5Bn3dfmSBpzx3tSWjsYtMWO12y3TG/FXawzqrl3OdtPep0c/VNmodMCz
         FAm1GV4gBAoDAIHVXMgbiYQxyuQTWdRgpo9T0nv1gYNyLt2YTmjCcj+GmTFYnKVWuIFi
         HVyT98UUNKcHNilCufIt/KfdjFvw9v+TaOPuOKFtzpwKPiBVQvXcJ+yxZjxbvCKVBkww
         m8MEccKa9xDaUKbdaHt6O130Us1ihbKABRp2+wBpGpaswNWT2AxaRw0aO7ZED72NIss1
         BeDg==
X-Gm-Message-State: APjAAAUJZEEj+zyX1i5UJyMF4r4R1xh0PlhZJNuXbKVd2Y1njP9+dYQp
        PsV5ooA0a1BqswxWeqdoEI4y9F+wK6NYNA==
X-Google-Smtp-Source: APXvYqwl9vPp0tDY7OWvqhlTdKh/8A9O++vHML+VHxnMqarMAgfQIKC+PxpbKu2amvqF5VfaRIibEQ==
X-Received: by 2002:a17:902:8501:: with SMTP id bj1mr73827295plb.84.1577765506079;
        Mon, 30 Dec 2019 20:11:46 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:e060:716d:87c4:d549? ([2605:e000:100e:8c61:e060:716d:87c4:d549])
        by smtp.gmail.com with ESMTPSA id v143sm45560462pfc.71.2019.12.30.20.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 20:11:45 -0800 (PST)
Subject: Re: [PATCH 4/4] blk-mq: allocate tags in batches
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20191230181442.4460-1-axboe@kernel.dk>
 <20191230181442.4460-5-axboe@kernel.dk> <20191231021834.GA20062@ming.t460p>
 <4587c4e6-a25f-9a68-ee6f-e0eb6da2e327@kernel.dk>
Message-ID: <45bf02af-55c1-f266-b4e4-cb2a27ac1af1@kernel.dk>
Date:   Mon, 30 Dec 2019 21:11:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4587c4e6-a25f-9a68-ee6f-e0eb6da2e327@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/30/19 8:53 PM, Jens Axboe wrote:
> On 12/30/19 7:18 PM, Ming Lei wrote:
>>> +static int blk_mq_get_tag_batch(struct blk_mq_alloc_data *data)
>>> +{
>>> +	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
>>> +	struct sbitmap_queue *bt = &tags->bitmap_tags;
>>> +	struct blk_mq_ctx *ctx = data->ctx;
>>> +	int tag, cpu;
>>> +
>>> +	if (!ctx)
>>> +		return -1;
>>> +
>>> +	preempt_disable();
>>> +
>>> +	/* bad luck if we got preempted coming in here, should be rare */
>>> +	cpu = smp_processor_id();
>>> +	if (unlikely(ctx->cpu != cpu)) {
>>> +		ctx = data->ctx = __blk_mq_get_ctx(data->q, cpu);
>>> +		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags, ctx);
>>
>> When blk_mq_get_tag_batch is called for getting driver tag, rq->mq_hctx
>> has been bound to the current request in blk_mq_rq_ctx_init(), so looks
>> we shouldn't change hctx here.
> 
> ->ctx is also NULL for that case, so it gets skipped. Probably needs a
> comment...
> 
> I'll need to check if all cases are covered, the batched tags should be
> exclusive to the non-reserved, regular tags. Or just the scheduler tags,
> if a scheduler is attached. Not sure it makes a lot of sense to handle
> the scheduler case as well (and have two sets of batches, driver tags
> and scheduler tags), but if it does, we could extend it for that and
> just bail if we're not on the right ctx anymore. In all honesty, I wrote
> that above code without ever checking that it happens. It most certainly
> could, but I'd consider it a very low risk. So might be better to simply
> just return -1 for that case and ignore it.

Something like this should it clearer and get rid of that special rare
case of having been preempted on to a different CPU since we got the
ctx assignment.

We could also just not care, I added the lock grab later on since we
need it for flushing out batches. But we don't really need it on the
allocation side if we just have preemption disabled, and we don't
allocate requests from irq context. The lock is cheap enough since we're
in that cacheline anyway, and it should never be contended.

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.6/block-test&id=d33686a37ca1e902271588b40e80d4b5f82640ce

-- 
Jens Axboe

