Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098D5C4338F
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 06:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA8861029
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 06:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhHEGPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhHEGPK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 02:15:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9EAC061765
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 23:14:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so7084407pjh.3
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i6mWaO/wUGdEW9gvkXWgFJF9mbF+VdCY/5LPjLCc9NU=;
        b=c+ZCEY3vx0JoEEkly4B+yH783EoLPj2EwYrygKXT1FvpCx3i+bBnta9dXFmf/pX0co
         JSTvK4C1DuQEYw4MLp0Hl/6bILqXgQQh/5XYde3fexKC68DJ9UEblL+hwZUE95SKN9Lr
         Lz9FwbPGjPepcbpQeaLZfmNQ4DYykVtnZMEOOLi0g58B+IkKxIQOoldn/lI8Y9e2qZhj
         l76CqINFTuWjiafxYv4yVe5oWyu/q2Bbp7oCFuzPm1xSv0e/v1cbe5jf+KFh9OymEmhM
         3baNJKfwlZC9kbJf6BopL5VlULFDexbhqyt9XwqgFCra/ugttI87e+O5qfkyxKfxe5Xl
         yFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i6mWaO/wUGdEW9gvkXWgFJF9mbF+VdCY/5LPjLCc9NU=;
        b=IldZuOdhFOKb5WNSLxjtptn6nPvD5vQUJhdPlBLRrU6PcF2ICNcOwxrq6JBSD1U2+E
         JzbxtPMoto/rByV+SZf7WZMjhmUA75mtnKMWc5W+Z6zpvWGNz+7IBhYwqJmeggdBBkTG
         kzpU5vdm5Bm6MNt7GcajMdVsVro+RDsDBJ49ZZ9kPZM8cbXSezBvFlQjBxO0vLEgxoOg
         hYhu9FiSMVui55gY/M2cu9CBgWtCfdJRA4tIu4nUaaBtWhiwy/L8PlIXikrTYYvgySEk
         Nw8hwhtNEYPb+i0P/J3pE6OG15kKKtxtkuaj+UJFd7cZ0pgS7QQKQvaMQNR5fsygI1LN
         tM4A==
X-Gm-Message-State: AOAM532bEJV9BC9xP/9ubc+ph2Hi3WYTJvL+r+WAl1A8hMMv+6LXJflU
        7gXAzWhI2hO8ShPrFp/NS0I=
X-Google-Smtp-Source: ABdhPJxKhZnJJjptEZDkR+pMfKt8H6+LkmjtZj+q1gx3EAc7+sZth6qnhCOShZjIJmHpYmaPSJLNDg==
X-Received: by 2002:a62:dd83:0:b029:30f:d69:895f with SMTP id w125-20020a62dd830000b029030f0d69895fmr3244502pff.17.1628144096403;
        Wed, 04 Aug 2021 23:14:56 -0700 (PDT)
Received: from [192.168.50.71] (ip70-175-137-120.oc.oc.cox.net. [70.175.137.120])
        by smtp.gmail.com with ESMTPSA id 198sm5083332pfu.32.2021.08.04.23.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 23:14:56 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] loop: Add the default_queue_depth kernel module
 parameter
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
References: <20210803182304.365053-1-bvanassche@acm.org>
 <20210803182304.365053-4-bvanassche@acm.org> <YQouvmh3rTDz2WIE@kroah.com>
From:   Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Message-ID: <2971a1f5-08c1-a6e2-3125-abfc2e13d63d@gmail.com>
Date:   Wed, 4 Aug 2021 23:14:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQouvmh3rTDz2WIE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org




On 8/3/2021 11:07 PM, Greg KH wrote:
> On Tue, Aug 03, 2021 at 11:23:04AM -0700, Bart Van Assche wrote:
>> Recent versions of Android use the zram driver on top of the loop driver.
>> There is a mismatch between the default loop driver queue depth (128) and
>> the queue depth of the storage device in my test setup (32). That mismatch
>> results in write latencies that are higher than necessary. Address this
>> issue by making the default loop driver queue depth configurable. Compared
>> to configuring the queue depth by writing into the nr_requests sysfs
>> attribute, this approach does not involve calling synchronize_rcu() to
>> modify the queue depth.
>>
>> Reviewed-by: Ming Lei<ming.lei@redhat.com>
>> Cc: Tetsuo Handa<penguin-kernel@I-love.SAKURA.ne.jp>
>> Cc: Christoph Hellwig<hch@lst.de>
>> Cc: Martijn Coenen<maco@android.com>
>> Cc: Jaegeuk Kim<jaegeuk@kernel.org>
>> Signed-off-by: Bart Van Assche<bvanassche@acm.org>

If I remember correct I've sent patch based on the similar concept that 
is not entirely different than this one.


-- 
-ck
