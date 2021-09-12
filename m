Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E046DC433EF
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7F260FC0
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhILWOp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhILWOo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 18:14:44 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414EC061574
        for <linux-block@vger.kernel.org>; Sun, 12 Sep 2021 15:13:30 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id m4so3057184ilj.9
        for <linux-block@vger.kernel.org>; Sun, 12 Sep 2021 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K0BuOqWxW4pa6Tp+f55lnAWIKh2sJ7gwqIYEFVw2u/Q=;
        b=TJ/8NpuRwPPOaHsHtjMjzKTcsyo+WA9FuGtUeLe4SaQ9GTk8TT7j8pyr87IjiPzWjG
         ZplRWEJ9HqxR4qmx9SSgtjzcQ3y0yXrRy39SdSktFNIhnLCLn5Mf5/AqaAe2K5MsQ/35
         gjFuIZhOe8iJhj7z6/rZR+PHg+XomI/KjeBZbJQb3COmItMu05+syN7j98kzMRsDTiMy
         t2HpK7KIr/UB9bvGNqq8ZB/C6S5dFUcVLyUgbGA1bE7uIvafI/+l7yrRTN2ZDcugiHmG
         nXN7yZLal2lLNFe+7BiuhbfSa5AlxrFChR3VilRNNRLF9+OTxT3kTBgT/S5hIqIHSW1K
         co8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K0BuOqWxW4pa6Tp+f55lnAWIKh2sJ7gwqIYEFVw2u/Q=;
        b=cVj/BBRU6kSsiCOPUBr2lyY0BLC3GqiPbbc7d4+ie2spn113TQ0ovTBCajVoPoqn4A
         BWypdt4OwXPADrhA2sI/f607mdxT09pyaYZTASdlVoAhXQ7q0q5yAHrdlopjCLJc3uD7
         x592j3LUv8+DPyEtXQl10pID7UraA5C0BRUn7+x8Z6EmDrip2LGO6Ie+FuzvT+rjHuv7
         MxCk5P3Zld5n7d2rCmBNG2Xnf9rLKOEe5E9gOuybdYLkgj2Cq+D0h3kxA4IxS+lIpvdq
         XV7DEZIHqDucNBrKCLWAUd7w+YPTJRaDuN+8OQTcV0ec+GNmqzHDc0xkkrB1G0mxTDqa
         nMCg==
X-Gm-Message-State: AOAM5310eOb2nRqdpEKKP+x8YRUvxSOJWdDJfKbx7Xqu15L18xuYTfT9
        nTGH6JGyKmLPJfA5dN7oh4C6fQ==
X-Google-Smtp-Source: ABdhPJyESoA7ZOfdfVpt5+mtHny8jXzxkueqZqP7pQDH6Nn+wmmsTK783EIqCO1poydPWU+BC4JkZQ==
X-Received: by 2002:a05:6e02:12a3:: with SMTP id f3mr5707606ilr.54.1631484809339;
        Sun, 12 Sep 2021 15:13:29 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y15sm2122902ilc.32.2021.09.12.15.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 15:13:28 -0700 (PDT)
Subject: Re: [PATCH] block: Optimize bio_init()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210911214734.4692-1-bvanassche@acm.org>
 <c61afcb0-dcee-8c02-d216-58f263093951@kernel.dk>
 <c810ce05-0893-d8c8-f288-0e018b0a08ca@kernel.dk>
 <fe7f7cc7-2403-7ec6-7c1c-abb6ac6a68fa@kernel.dk>
 <c728eac8-3246-2a6d-84bd-a04fa62fbc04@acm.org>
 <200438e7-1a04-ae88-e79c-a4276b9dbb0f@kernel.dk>
 <b81606eb-b2cb-eaf2-b64c-55390f9b5456@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2adf05af-2d05-ad1d-49da-2b87c00b3e46@kernel.dk>
Date:   Sun, 12 Sep 2021 16:13:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b81606eb-b2cb-eaf2-b64c-55390f9b5456@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/12/21 4:01 PM, Bart Van Assche wrote:
> On 9/12/21 06:03, Jens Axboe wrote:
>> On 9/11/21 9:19 PM, Bart Van Assche wrote:
>>> The performance numbers in the patch description come from a
>>> Intel Xeon Gold 6154 CPU. I reran the test today on an old Intel
>>> Core i7-4790 CPU and obtained the opposite result: higher IOPS
>>> without this patch than with this patch although the assembler
>>> code looks to be the same. It seems like how fast "rep stos"
>>> runs depends on the CPU type?
>>
>> It does appear so. Which is a bit frustrating...
> 
> Further measurements have shown that this behavior is specific to
> gcc and also that clang always generates faster code for the version
> of bio_init() in my patch. I have reported this as a bug to the gcc
> project. See also https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102294.

Interesting! Here are some results from my end. First the 3970X again:

gcc-11.1
Elapsed time: 0.980807 s
Elapsed time: 0.452951 s
Elapsed time: 0.949918 s

clang-11.0
Elapsed time: 0.284734 s
Elapsed time: 0.356595 s
Elapsed time: 0.285459 s

And my laptop, which is using:

11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GHz

gcc-11.1
Elapsed time: 0.218427 s
Elapsed time: 0.235000 s
Elapsed time: 0.214217 s

clang-11.0
Elapsed time: 0.217436 s
Elapsed time: 0.170959 s
Elapsed time: 0.149630 s

All compiles done with -O2 -march=native

Now I kind of want to compile the kernel with clang and see how that
goes...

-- 
Jens Axboe

