Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31ACC432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 12:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43812168B
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 12:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XiacqyPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395411AbfIXM5E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:57:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37700 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395362AbfIXM5E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 08:57:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so1923812wmc.2
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1/DmXObQknZjFIbC4/FOj1i5Dz2QAyjy3j/eh6BNk5s=;
        b=XiacqyPgYS48I6IRB9K+JhnZYkEq732MHOHnhOfzSTR5vG7l8Mo/ZexrYR2Qgk8iHj
         bcQIZnA0gCHyaa7oP7FI7LFWqc5wx7hTpuvsJrepzfoVHjUn7jufVHBKv+XXVOMImTVT
         7P+b4x1ofQWV8125NAsAQq1Mmt7lg2GhesP/3JMCMIwCV+JGt+lRxmg/l2hSR+RlD0VC
         gKhUClZ/paJLp6YxUZWWP6huo+WhT3vsH1IeI7QRZexG/SSI8YNOmZEiK+OtqtHAAF2H
         RAhUpf1hm+PyF0pxymoDrL2UCA/vzF95G//f+oB8vXNnUaYc8C6jjaNinJ9CPPRwaKLh
         buJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1/DmXObQknZjFIbC4/FOj1i5Dz2QAyjy3j/eh6BNk5s=;
        b=lfsOG4voZ0QmLlrfqfBR1DmXRyGnjUvIWqq2IQ25Wi47tyOhXI/w6V1+X12XIdmZXR
         bGZpU3xGb8ME6Stm4Aosqj8tO/cQ+jE1o0Y0nEcFXCStw//AeO1yCaVEPYEnAMQXBTfa
         yaV/vcwbFiupKuZfEZNbCO+w9wVaZbLjalAHHw/HV1+FdcNWLc9p6/GNoTweOMRYlV2M
         ZJtuEMOR5uM+WuCgokg4xrrbvQToY0cxmHyhXjRjoPSSYsIc+bJjFhTNJcAm72yF62uq
         omQ/0IlRrnWjiVv4GpLfqdogxhYGXl/8LpNpBKm6eW0m5q7bMRdOBqsOMyo4/muxgzDs
         9ZGg==
X-Gm-Message-State: APjAAAVHwPxttC56YZsrPuDVdyFsiY3m6mglhB5wSHunEZOvDa/T4XDt
        F0XbVDEgtwyxutct0iy7yInmsA==
X-Google-Smtp-Source: APXvYqyYtGWsIxqioTJASjcFy5Zzc9hLD7p/PurtVzfonnBcrSKOcToB8kiSL8jhJi56p+ZmwyY8pQ==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr1646256wma.43.1569329822656;
        Tue, 24 Sep 2019 05:57:02 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id v11sm1820463wml.30.2019.09.24.05.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 05:57:01 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Peter Zijlstra <peterz@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
 <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
 <20190924114300.GM2332@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b66cc383-ceca-b7dd-b3a3-eb998e865cea@kernel.dk>
Date:   Tue, 24 Sep 2019 14:57:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924114300.GM2332@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/19 5:43 AM, Peter Zijlstra wrote:
> On Tue, Sep 24, 2019 at 02:11:29PM +0300, Pavel Begunkov wrote:
> 
>> @@ -2717,15 +2757,18 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>>   			return ret;
>>   	}
>>   
>> +	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
>> +	prepare_to_wait_exclusive(&ctx->wait, &iowq.wq, TASK_INTERRUPTIBLE);
>> +	do {
>> +		if (io_should_wake(&iowq))
>> +			break;
>> +		schedule();
>> +		if (signal_pending(current))
>> +			break;
>> +		set_current_state(TASK_INTERRUPTIBLE);
>> +	} while (1);
>> +	finish_wait(&ctx->wait, &iowq.wq);
> 
> It it likely OK, but for paranoia, I'd prefer this form:
> 
> 	for (;;) {
> 		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq, TASK_INTERRUPTIBLE);
> 		if (io_should_wake(&iowq))
> 			break;
> 		schedule();
> 		if (signal_pending(current))
> 			break;
> 	}
> 	finish_wait(&ctx->wait, &iowq.wq);
> 
> The thing is, if we ever succeed with io_wake_function() (that CPU
> observes io_should_wake()), but when waking here, we do not observe
> is_wake_function() and go sleep again, we might never wake up if we
> don't put ourselves back on the wait-list again.

Might be paranoia indeed, but especially after this change, we don't
expect to make frequent roundtrips there. So better safe than sorry,
I'll make the change.

-- 
Jens Axboe

