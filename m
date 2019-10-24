Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E600DCA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 22:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67E020578
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 22:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GFe5WoCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfJXWbg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:31:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34382 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbfJXWbg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 18:31:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so201890pfa.1
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LucpUKm2PlJy8L1gaoh3GeHWChu5Q7OFic+OXdVLGWY=;
        b=GFe5WoCopRCQQTcPcP6Exxr2/6ARc1UTLeYoo9g9CHHKMz07POlt8v4+cGHY762ZgQ
         LUGSkthsNScD5J45tGhuv88FVwSL2b0hCPhGapqoS2aeRo5WTQ5YHKZR646smZ9zSXCx
         uxnxDYMenS15miQP/nAHQDjqOZh8Zzae/xb0I83tSJdAAlpzk7InSumwg49GnaOTa1dY
         aea2k9GJxN1InCee+L7ZoQH1M1zX68MliQKFz/vfs+U9Nc6JiPE63svfG5WTn447EUC5
         g+8LrcaLqQi/U/Sd/HxzCDC9O6n2rqQcTF1jEleCoZP8dx2TSXefkCbhwKLio92xMcJw
         m/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LucpUKm2PlJy8L1gaoh3GeHWChu5Q7OFic+OXdVLGWY=;
        b=Aai8DUzFjD0GmzlZ0/+4Dm52IsG9r9jSgXEkrqx6uRxTFcbZElcLn598rEq2CmQrIq
         PSA0uA5EfZoGrJIb4jSUJ7uV6+G7xRZvWDFootXhZzH5FXDMvSZreSY/mZy5vqYvQYwh
         XwCBWGafjDIvkgxC9AeYU0xYd26CAlhZPhg/AiTz9hQvWZ807PU3Do2Ev6UT5W9g6KwD
         /05YR0kZu4/fkxgSsVoN3c/1E4yP3Ddlzek1thTAkiGgmRhXFEkHVK3Dj6HI/vOy/83k
         cFaNRJi7D9RseAxHJMV2OyI0o/M1JnvxNwNR1Fhq7oot60FM7nUH4nacqs4X4ITIkld3
         688A==
X-Gm-Message-State: APjAAAX53WAkqHQaXTQldFXDyqq6kNvL9zpvSJrNxAAEn/JGPMeVxNyr
        ptr1ufS1GcbpW+aOLG84IY4qPBcWl3nnUA==
X-Google-Smtp-Source: APXvYqzNYqTmUnv2rL5f2/ot2aYcyjiTKUOcbsw+JVqpcYVKEQ/nwy6H92rw5sgvSisvxZN/I5vn0g==
X-Received: by 2002:a63:c1:: with SMTP id 184mr434702pga.224.1571956294433;
        Thu, 24 Oct 2019 15:31:34 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h28sm23388pgn.14.2019.10.24.15.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 15:31:33 -0700 (PDT)
Subject: Re: [RFC 0/2] io_uring: examine request result only after completion
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
 <22fc1057-237b-a9b8-5a57-b7c53166a609@kernel.dk>
 <201931df-ae22-c2fc-a9c7-496ceb87dff7@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90c23805-4b73-4ade-1b54-dc68010b54dd@kernel.dk>
Date:   Thu, 24 Oct 2019 16:31:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201931df-ae22-c2fc-a9c7-496ceb87dff7@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/19 1:18 PM, Bijan Mottahedeh wrote:
> 
> On 10/24/19 10:09 AM, Jens Axboe wrote:
>> On 10/24/19 3:18 AM, Bijan Mottahedeh wrote:
>>> Running an fio test consistenly crashes the kernel with the trace included
>>> below.  The root cause seems to be the code in __io_submit_sqe() that
>>> checks the result of a request for -EAGAIN in polled mode, without
>>> ensuring first that the request has completed:
>>>
>>> 	if (ctx->flags & IORING_SETUP_IOPOLL) {
>>> 		if (req->result == -EAGAIN)
>>> 			return -EAGAIN;
>> I'm a little confused, because we should be holding the submission
>> reference to the request still at this point. So how is it going away?
>> I must be missing something...
> 
> I don't think the submission reference is going away...
> 
> I *think* the problem has to do with the fact that
> io_complete_rw_iopoll() which sets REQ_F_IOPOLL_COMPLETED is being
> called from interrupt context in my configuration and so there is a
> potential race between updating the request there and checking it in
> __io_submit_sqe().
> 
> My first workaround was to simply poll for REQ_F_IOPOLL_COMPLETED in the
> code snippet above:
> 
>       if (req->result == --EAGAIN) {
> 
>           poll for REQ_F_IOPOLL_COMPLETED
> 
>           return -EAGAIN;
> 
> }
> 
> and that got rid of the problem.

But that will not work at all for a proper poll setup, where you don't
trigger any IRQs... It only happens to work for this case because you're
still triggering interrupts. But even in that case, it's not a real
solution, but I don't think that's the argument here ;-)

I see what the race is now, it's specific to IRQ driven polling. We
really should just disallow that, to be honest, it doesn't make any
sense. But let me think about if we can do a reasonable solution to this
that doesn't involve adding overhead for a proper setup.

>>> The request will be immediately resubmitted in io_sq_wq_submit_work(),
>>> potentially before the the fisrt submission has completed.  This creates
>>> a race where the original completion may set REQ_F_IOPOLL_COMPLETED in
>>> a freed submission request, overwriting the poisoned bits, casusing the
>>> panic below.
>>>
>>> 	do {
>>> 		ret = __io_submit_sqe(ctx, req, s, false);
>>> 		/*
>>> 		 * We can get EAGAIN for polled IO even though
>>> 		 * we're forcing a sync submission from here,
>>> 		 * since we can't wait for request slots on the
>>> 		 * block side.
>>> 		 */
>>> 		if (ret != -EAGAIN)
>>> 			break;
>>> 		cond_resched();
>>> 	} while (1);
>>>
>>> The suggested fix is to move a submitted request to the poll list
>>> unconditionally in polled mode.  The request can then be retried if
>>> necessary once the original submission has indeed completed.
>>>
>>> This bug raises an issue however since REQ_F_IOPOLL_COMPLETED is set
>>> in io_complete_rw_iopoll() from interrupt context.  NVMe polled queues
>>> however are not supposed to generate interrupts so it is not clear what
>>> is the reason for this apparent inconsitency.
>> It's because you're not running with poll queues for NVMe, hence you're
>> throwing a lot of performance away. Load nvme with poll_queues=X (or boot
>> with nvme.poll_queues=X, if built in) to have a set of separate queues
>> for polling. These don't have IRQs enabled, and it'll work much faster
>> for you.
>>
> That's what I did in fact.  I booted with nvme.poll_queues=36 (I figured
> 1 per core but I'm not sure what is a reasonable number).
> 
> I also checked that /sys/block/<nvme>/queue/io_poll = 1.
> 
> What's really odd is that the irq/sec numbers from mpstat and perf show
> equivalent values with/without polling (with/without fio "hipri" option)
> even though I can see from perf top that we are in fact polling in one
> case. I don't if I missing a step or something is off in my config.

Doesn't sound right. io_poll just says if polling is enabled, not if
it's IRQ driven or not. Try this, assuming nvme0n1 is the device in
question:

# cd /sys/kernel/debug/block/nvme0n1
# grep . hctx*/type
hctx0/type:default
hctx1/type:read
hctx2/type:read
hctx3/type:read
hctx4/type:poll
hctx5/type:poll
hctx6/type:poll
hctx7/type:poll

This is just a vm I have, hence just the 8 queues. But this shows a
proper mapping setup - 1 default queue, 3 read, and 4 poll queues.

Is nvme a module on your box? Or is it built-in?

-- 
Jens Axboe

