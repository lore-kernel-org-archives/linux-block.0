Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CD9C4320A
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 14:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEEC610A8
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 14:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhHLOwy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 10:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbhHLOwv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 10:52:51 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7829C0613D9
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 07:52:26 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bi32so10772490oib.2
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GDmYv7hJX4PL/KMS0FEdgYmGuDsOaSNUuRLd8J0CAMs=;
        b=wFKHfwOcKyh7hN0JZhMbxZ97EoW+HAacl/8QbfDgAew5UGwh7NsVCDrPJ4xGVk3jTA
         djngAUq0ETRJV3jj33OeCX0FJlvn8mjPiDNoUrqGYV+M0R2w1AKIdvagLLDtYDor0054
         KcvOgzBwMr04BYG8W98u6ChZY4mL7XtCBW/weUL2RpOalxj+wEINM6Z58Pr3zd4l6r0c
         iLGLeH0dvumdNaFTRoJTAPiKJ4kgMqCCKNoMMNHjj8bzkcz/7AeBPXDLp7zNQG4qz7rA
         D5xiZ/+c0E6PRmz4oe03hOMgbWLlIRlriua+Z6XH9+/386d/kN9KtRnJjYW8aHqAXMnG
         kW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GDmYv7hJX4PL/KMS0FEdgYmGuDsOaSNUuRLd8J0CAMs=;
        b=Vd9LIn6B8eNzlEoftfZAubxMb4JcEPJUAmEz78kWYtRPsrdB3QpqRpJZilu92wn9+L
         u/aEVVIpPhEFp534CUyzoq+q5CZW8Mud1gsAQoOXmm5ZEg0v9O7kED29C8rX5F2DKqUN
         in1A1MEYq7J6q4ZvYFi2AdIFeAvB1ESizum80BLGRyscWC9xrxJ8CGyE8aFQcTisghXe
         xWvKb+hLlkEF7hBxVQgCim0971SfqfzCGhwEHekljh8ktLEAMvJPO7WfWzyC1ZUwCI0e
         cIGmToStGVGjSb1RIhhuF2Ad721u17VA0UP2Iol0HJEPO58MWJ2HK9rRAR0W+NT8s1z2
         OF4A==
X-Gm-Message-State: AOAM533CJ2ulQCfdjYUr55CWm2cvoukyj/FgK3uJvz6Valjr6qAtMjpD
        CgAdTgNecWUr6nVJQUJ/9bFfX+O6fraLClgB
X-Google-Smtp-Source: ABdhPJzE5vOhU6C/TvtIpSKRSYqo6cQuY7IPne7vtwJ+ViOWzZNok5UlQWdhFWdRjpyFfgVo8yIsRg==
X-Received: by 2002:a05:6808:641:: with SMTP id z1mr12334669oih.108.1628779945982;
        Thu, 12 Aug 2021 07:52:25 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h17sm644489otl.74.2021.08.12.07.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 07:52:25 -0700 (PDT)
Subject: Re: [PATCH 6/6] block: enable use of bio allocation cache
To:     Christoph Hellwig <hch@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20210811193533.766613-1-axboe@kernel.dk>
 <20210811193533.766613-7-axboe@kernel.dk> <YRTH5T6R7PMpWaBF@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba6e8ca0-1220-4051-e599-c693465eb6a5@kernel.dk>
Date:   Thu, 12 Aug 2021 08:52:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRTH5T6R7PMpWaBF@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 1:04 AM, Christoph Hellwig wrote:
> On Wed, Aug 11, 2021 at 01:35:33PM -0600, Jens Axboe wrote:
>> Initialize the bio_set used for IO with per-cpu bio caching enabled,
>> and use the new bio_alloc_kiocb() helper to dip into that cache.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> This seems to be pretty much my patch as-is..

It is, sorry I'll fix the attribution.

-- 
Jens Axboe

