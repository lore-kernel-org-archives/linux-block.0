Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D3C4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 16:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7E06108C
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 16:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhHLQkD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhHLQkC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 12:40:02 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D9DC061756
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 09:39:37 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so8562936oti.0
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oc7AsSC8FMlC5aYCamMtXfCw/2PnaPBOswPZvo9sqig=;
        b=ru8tup9NQ4fbtr8r4VVkusn7ZkPn6CWbWFNDTcYz8Bdlt+MADL0Zic5HRH7Ue7QTfY
         7Upv4fKS1u1OJFnvHzspMc6vAM41G3ulec8zTaWHdR/HCwdpMVd3Idzqi7zlgv25DBMZ
         kyX6vBB/VWvDggTOef6Uq5U7qTdDjf7OOras7VFD6XIUqz9swab4eBQzjuhAc+eZAJ8p
         b0jMI3ADq/qPIIpu/ppfyAuEzdeG05M4qkEMFPCfmpwtcVyeBaDYZzDYNR0qq3+AZnnm
         C7MOPjx1EynlvxVdi4Xm1/4kOqI9EQhpvb+aTqUf7LgBmJJK3xrPR8ifanTxEcz85RMo
         DsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oc7AsSC8FMlC5aYCamMtXfCw/2PnaPBOswPZvo9sqig=;
        b=gxs/drUKkxt7FFoPqSAA3Y5YfmFxjm84/egfnVas07bVTtzxrD7u51xi0/AEKIqLGP
         2Pob+vsTtrNEsWN2bQ9TuTkSFmjpL+Re5cYqVks0JqSx2y2wgSHDbP3oQGRh9xop7yWg
         fk06O0DpaHqSCyx6uVbQA7IeVT/MM/wlJhzW9+XKVZ0pPSsXIuEDeAX48PjAlEiL2TYw
         QhK20yCyck4LYrmk3s3CNjggph+oTGxZOLNcVYgtSjLwPWAJRiWH9Hxzt5TOjwYkbtTI
         1smpZXgSmov5BM1t7A49JqG5gwxpdwNV/AH4V4RM5JpZ5WLVkk+QovuQzYxpgRainb25
         imKg==
X-Gm-Message-State: AOAM532cndz6P9P5C94iyL2FmNIg90LRATYWNNI5BMP0AewUHBYzaJWQ
        RqjfekDNUF+43lMbyCik0y14maRgwyhNtsXk
X-Google-Smtp-Source: ABdhPJwummIxPlevoZPgEzD5Bc40kmov5ywaH410V1XXkWZUnzaIabolbpjAFK1AKAQmcdMQS0eaYQ==
X-Received: by 2002:a9d:65d0:: with SMTP id z16mr4128805oth.196.1628786376403;
        Thu, 12 Aug 2021 09:39:36 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n5sm711377oij.56.2021.08.12.09.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:39:36 -0700 (PDT)
Subject: Re: [PATCH 3/6] bio: add allocation cache abstraction
To:     Christoph Hellwig <hch@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210812154149.1061502-1-axboe@kernel.dk>
 <20210812154149.1061502-4-axboe@kernel.dk> <YRVNCubDmQSUslSd@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <667e9fb6-d02f-a5c5-ff9e-f67af35ec1c5@kernel.dk>
Date:   Thu, 12 Aug 2021 10:39:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRVNCubDmQSUslSd@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 10:32 AM, Christoph Hellwig wrote:
> [adding Thomas for a cpu hotplug questions]
> 
>> +static void bio_alloc_cache_destroy(struct bio_set *bs)
>> +{
>> +	int cpu;
>> +
>> +	if (!bs->cache)
>> +		return;
>> +
>> +	preempt_disable();
>> +	cpuhp_state_remove_instance_nocalls(CPUHP_BIO_DEAD, &bs->cpuhp_dead);
>> +	for_each_possible_cpu(cpu) {
>> +		struct bio_alloc_cache *cache;
>> +
>> +		cache = per_cpu_ptr(bs->cache, cpu);
>> +		bio_alloc_cache_prune(cache, -1U);
>> +	}
>> +	preempt_enable();
> 
> If I understand the cpu hotplug state machine we should not get any new
> cpu down callbacks after cpuhp_state_remove_instance_nocalls returned,
> so what do we need the preempt disable here for?

I don't think we strictly need it. I can kill it.

>> +	/*
>> +	 * Hot un-plug notifier for the per-cpu cache, if used
>> +	 */
>> +	struct hlist_node cpuhp_dead;
> 
> Nit, even if we don't need the cpu up notifaction the node actually
> provides both.  So I'd reword the comment drop the _dead from the
> member name.

Right, but we only sign up for the down call.

-- 
Jens Axboe

