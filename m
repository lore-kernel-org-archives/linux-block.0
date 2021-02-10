Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AEFC433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359EE64D87
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhBJOoM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 09:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhBJOoG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 09:44:06 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A31FC06174A
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 06:43:25 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id s24so2100241iob.6
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 06:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UBVWu7Q18E8hxWkUCeiIwi5X9j3a0gfj0DZFPTw18LM=;
        b=gCPMN0NCXBIajb4vmFEm30gI51mciPn7gSX9VBYMHY+Y4YGdqZ+vdo49qrdKBvlNj7
         SELHw87WcukrcFpePjNJ8qFzvIUHA+srT3Nl+nyckp/ER6JkRHLvmXZfPGPRSq9FXf5y
         TPSU0cks01gkMmoZcefN/fChZoVlmmOid2N3/sEbsT+arIWJFqYi/s/fBCRGSZPluTuG
         dB5tonvIr5LrD4oNFJJ2vrmxVxpwFqSDpB9jl8MZZpZi7VqOcSYqFgayDzpgqYx6a5/g
         x/hrtaQ2fDmjgU5n2UtkHoWGfNvRXJHvKHAHnYD/oy82n8Lr4Yp07us8roO6xrBewdJX
         M7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UBVWu7Q18E8hxWkUCeiIwi5X9j3a0gfj0DZFPTw18LM=;
        b=iTC5KmduUEUABdu0eljzmJPe6oE2ITXufLMHO3DZmeSbeIqrERn9ctjsLri1aRu28i
         AiL2Mb7ZJdXVcBciRa73A4aL6PdmhExzBdyardf+MgeWnpOAfz07WlyrQmXHiPoTVB1o
         4Bg4706IQZfVTgsF1C0JmADYBvRo0sQ04E83D5sgd0wjoH0zSKmKF2fDYOlU+t3UtvDZ
         Gcw4Kxic/TQu/FZPp/5DxIZHZldFU96aEr0MWTTRNbe294bRI3kqZX+M0VOOSZKSBmPY
         XiuC6hSOd2c6Do2WSE9YFlJ8F8BWDb3bqelFZNQAcJCzmmm9BXvZEQSXcyc9m4hvRLjg
         Y4oA==
X-Gm-Message-State: AOAM532AjLNpCz919POr0CPs7eTJQW7u/reuWnWhimvrMxm6HIWWPAfn
        b+sidC+1BZ4MZA6Qr4vhDzpy+w==
X-Google-Smtp-Source: ABdhPJwckORcPOBUwD0PsCK0O7CnAPa7U/bF0ZSMR0B7ctVtWv5JegPdxOU7CodQMuWQV6sQuC1IVw==
X-Received: by 2002:a05:6638:450:: with SMTP id r16mr3716920jap.33.1612968204586;
        Wed, 10 Feb 2021 06:43:24 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m4sm1031588iow.1.2021.02.10.06.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 06:43:24 -0800 (PST)
Subject: Re: [PATCH v3 0/3] blk-mq: Don't complete in IRQ, use llist_head
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4007ad55-ed6d-a081-8571-36b146bca5ed@kernel.dk>
Date:   Wed, 10 Feb 2021 07:43:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210123201027.3262800-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/23/21 1:10 PM, Sebastian Andrzej Siewior wrote:
> Patch 2+3 were applied and then dropped by Jens due to a NOHZ+softirq
> related warning [0]. Turns out a successful wakeup via
> set_nr_if_polling() will not process any softirqs and the CPU may go
> back to idle. This is addressed by patch #1.
> 
> smpcfd_dying_cpu() will also invoke SMP-functions calls via
> flush_smp_call_function_queue() but the block layer shouldn't queue
> anything because the CPU isn't online anymore.
> The two caller of flush_smp_call_function_from_idle() look fine with
> opening interrupts from within do_softirq().

Applied, thanks.

-- 
Jens Axboe

