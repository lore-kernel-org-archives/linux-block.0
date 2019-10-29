Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44509CA9EAE
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 19:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FF020862
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 19:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iQbvvfIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfJ2TdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:33:25 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:32997 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJ2TdZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 15:33:25 -0400
Received: by mail-io1-f49.google.com with SMTP id n17so3015479ioa.0
        for <linux-block@vger.kernel.org>; Tue, 29 Oct 2019 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=StbTVtf5cfUUWJiwsyNhiwef4iErPHwHZprLy3XFx3M=;
        b=iQbvvfIJxSCqtQsHQS0r2QyIby8hRoSpjn8ahSLrHlPL3yfpK/l3BDQaZ4Xc47MBP+
         MEgPNtu/NfDbpJcveiAsgQ9+yPn5Bcsb22EJsxbPVcpx5Ol1GLnftQ/VQeFW4wF62N5u
         zoIF9qnQqsrfClq0vRvoVrygEcUmTyIwAMMfPtqwY4px4yU4xaAJe7uYtnbs4mEpMwhu
         XRQxGbbW8X5AdvYt23CK6sCJufZPOA+OkcGDrgyg5o/OCnXlgbYOgUkfsSoqMIk1BE54
         xzMWYF5J5D1NxNYrNaL9+qmAlDN9r7hN/j9zqTvvxfJH8zGJgtvgTvNj2LJR/ormx08m
         0bCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=StbTVtf5cfUUWJiwsyNhiwef4iErPHwHZprLy3XFx3M=;
        b=QPBLGEm1sFBx9nV0ICpttHv08MQKbOJs2smdWEaHwx9juh4Ub6l7GhxXXv4aKMlSk4
         dgrV+Q/GUGsQuApjPKxpi8tm0xgvcBUs9DxzVJl6gGEErctVrK/vzjA0s3m+0ltHn7Uu
         mscq5tJPMAlqY+FWUlFUacbOE2d3v70fhmuaMVDYqLS7NvrZiKCoKfvMvYMpIMZKCm57
         nhyqsAkwUagzGT/AM5USkaacITUQ8Cn3pKh8qarZVNr1Axmu0ZleVTs+aNIaVun4B6IE
         qXJCOTCMLX2vO2q2/loLeBNCvPuOsZzEORPjA3FlnJkccbnkXghovR57YRbEsVXAj179
         awOw==
X-Gm-Message-State: APjAAAUZSp2HntT/1qPQS2/GvxrNb7mE05GqLQjckKKTXu7T5ZTbeVFR
        7abPALF6++XAVjY7D8hF4SDyZsaitTiZ5g==
X-Google-Smtp-Source: APXvYqzqb3fkeXcj6Z4IbqRTTPhyqduccudxmclpWwUtFr1ZX/dXT1Og1Nme4WDHtIhbA8eaQiMdHg==
X-Received: by 2002:a02:1d04:: with SMTP id 4mr1607294jaj.48.1572377603489;
        Tue, 29 Oct 2019 12:33:23 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i79sm570037ild.6.2019.10.29.12.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 12:33:22 -0700 (PDT)
Subject: Re: [RFC 0/2] io_uring: examine request result only after completion
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
 <22fc1057-237b-a9b8-5a57-b7c53166a609@kernel.dk>
 <201931df-ae22-c2fc-a9c7-496ceb87dff7@oracle.com>
 <90c23805-4b73-4ade-1b54-dc68010b54dd@kernel.dk>
 <fa82e9fc-caf7-a94a-ebff-536413e9ecce@oracle.com>
 <b7abb363-d665-b46a-9fb5-d01e7a6ce4d6@kernel.dk>
 <533409a8-6907-44d8-1b90-a10ec3483c2c@kernel.dk>
 <6adb9d2d-93f1-f915-7f20-5faa34b06398@kernel.dk>
 <cdaa2942-5f27-79f8-9933-1b947646f918@oracle.com>
 <34f483d9-2a97-30c3-9937-d3596649356c@oracle.com>
 <47b38d9d-04a3-99f6-c586-e82611d21655@kernel.dk>
 <c7b599e4-cf3d-5390-f6f4-360d4435ea43@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <057bb6f9-29ec-1160-a1b1-00c57b610282@kernel.dk>
Date:   Tue, 29 Oct 2019 13:33:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c7b599e4-cf3d-5390-f6f4-360d4435ea43@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/19 1:31 PM, Bijan Mottahedeh wrote:
> 
> On 10/29/19 12:27 PM, Jens Axboe wrote:
>> On 10/29/19 1:23 PM, Bijan Mottahedeh wrote:
>>> On 10/29/19 12:17 PM, Bijan Mottahedeh wrote:
>>>> On 10/25/19 7:21 AM, Jens Axboe wrote:
>>>>> On 10/25/19 8:18 AM, Jens Axboe wrote:
>>>>>> On 10/25/19 8:07 AM, Jens Axboe wrote:
>>>>>>> On 10/25/19 7:46 AM, Bijan Mottahedeh wrote:
>>>>>>>> On 10/24/19 3:31 PM, Jens Axboe wrote:
>>>>>>>>> On 10/24/19 1:18 PM, Bijan Mottahedeh wrote:
>>>>>>>>>> On 10/24/19 10:09 AM, Jens Axboe wrote:
>>>>>>>>>>> On 10/24/19 3:18 AM, Bijan Mottahedeh wrote:
>>>>>>>>>>>> Running an fio test consistenly crashes the kernel with the
>>>>>>>>>>>> trace included
>>>>>>>>>>>> below.  The root cause seems to be the code in
>>>>>>>>>>>> __io_submit_sqe() that
>>>>>>>>>>>> checks the result of a request for -EAGAIN in polled mode,
>>>>>>>>>>>> without
>>>>>>>>>>>> ensuring first that the request has completed:
>>>>>>>>>>>>
>>>>>>>>>>>>        if (ctx->flags & IORING_SETUP_IOPOLL) {
>>>>>>>>>>>>            if (req->result == -EAGAIN)
>>>>>>>>>>>>                return -EAGAIN;
>>>>>>>>>>> I'm a little confused, because we should be holding the submission
>>>>>>>>>>> reference to the request still at this point. So how is it
>>>>>>>>>>> going away?
>>>>>>>>>>> I must be missing something...
>>>>>>>>>> I don't think the submission reference is going away...
>>>>>>>>>>
>>>>>>>>>> I *think* the problem has to do with the fact that
>>>>>>>>>> io_complete_rw_iopoll() which sets REQ_F_IOPOLL_COMPLETED is being
>>>>>>>>>> called from interrupt context in my configuration and so there is a
>>>>>>>>>> potential race between updating the request there and checking
>>>>>>>>>> it in
>>>>>>>>>> __io_submit_sqe().
>>>>>>>>>>
>>>>>>>>>> My first workaround was to simply poll for
>>>>>>>>>> REQ_F_IOPOLL_COMPLETED in the
>>>>>>>>>> code snippet above:
>>>>>>>>>>
>>>>>>>>>>              if (req->result == --EAGAIN) {
>>>>>>>>>>
>>>>>>>>>>                  poll for REQ_F_IOPOLL_COMPLETED
>>>>>>>>>>
>>>>>>>>>>                  return -EAGAIN;
>>>>>>>>>>
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> and that got rid of the problem.
>>>>>>>>> But that will not work at all for a proper poll setup, where you
>>>>>>>>> don't
>>>>>>>>> trigger any IRQs... It only happens to work for this case because
>>>>>>>>> you're
>>>>>>>>> still triggering interrupts. But even in that case, it's not a real
>>>>>>>>> solution, but I don't think that's the argument here ;-)
>>>>>>>> Sure.
>>>>>>>>
>>>>>>>> I'm just curious though as how it would break the poll case because
>>>>>>>> io_complete_rw_iopoll() would still be called though through polling,
>>>>>>>> REQ_F_IOPOLL_COMPLETED would be set, and so io_iopoll_complete()
>>>>>>>> should be able to reliably check req->result.
>>>>>>> It'd break the poll case because the task doing the submission is
>>>>>>> generally also the one that finds and reaps completion. Hence if you
>>>>>>> block that task just polling on that completion bit, you are
>>>>>>> preventing
>>>>>>> that very task from going and reaping completions. The condition would
>>>>>>> never become true, and you are now looping forever.
>>>>>>>
>>>>>>>> The same poll test seemed to run ok with nvme interrupts not being
>>>>>>>> triggered. Anyway, no argument that it's not needed!
>>>>>>> A few reasons why it would make progress:
>>>>>>>
>>>>>>> - You eventually trigger a timeout on the nvme side, as blk-mq
>>>>>>> finds the
>>>>>>>         request hasn't been completed by an IRQ. But that's a 30
>>>>>>> second ordeal
>>>>>>>         before that event occurs.
>>>>>>>
>>>>>>> - There was still interrupts enabled.
>>>>>>>
>>>>>>> - You have two threads, one doing submission and one doing
>>>>>>> completions.
>>>>>>>         Maybe using SQPOLL? If that's the case, then yes, it'd still
>>>>>>> work as
>>>>>>>         you have separate threads for submission and completion.
>>>>>>>
>>>>>>> For the "generic" case of just using one thread and IRQs disabled,
>>>>>>> it'd
>>>>>>> deadlock.
>>>>>>>
>>>>>>>>> I see what the race is now, it's specific to IRQ driven polling. We
>>>>>>>>> really should just disallow that, to be honest, it doesn't make any
>>>>>>>>> sense. But let me think about if we can do a reasonable solution
>>>>>>>>> to this
>>>>>>>>> that doesn't involve adding overhead for a proper setup.
>>>>>>>> It's a nonsensical config in a way and so disallowing it would make
>>>>>>>> the most sense.
>>>>>>> Definitely. The nvme driver should not set .poll() if it doesn't have
>>>>>>> non-irq poll queues. Something like this:
>>>>>> Actually, we already disable polling if we don't have specific poll
>>>>>> queues:
>>>>>>
>>>>>>              if (set->nr_maps > HCTX_TYPE_POLL &&
>>>>>>                  set->map[HCTX_TYPE_POLL].nr_queues)
>>>>>>                      blk_queue_flag_set(QUEUE_FLAG_POLL, q);
>>>>>>
>>>>>> Did you see any timeouts in your tests? I wonder if the use-after-free
>>>>>> triggered when the timeout found the request while you had the
>>>>>> busy-spin
>>>>>> logic we discussed previously.
>>>>> Ah, but we still have fops->iopoll() set for that case. So we just won't
>>>>> poll for it, it'll get completed by IRQ. So I do think we need to handle
>>>>> this case in io_uring. I'll get back to you.
>>>>>
>>>> I ran the same test on linux-next-20191029 in polled mode and got the
>>>> same free-after-user panic:
>>>>
>>>> - I booted with nvme.poll_queues set and verified that all queues
>>>> except default where of type poll
>>>>
>>>> - I added three assertions to verify the following:
>>>>
>>>>        - nvme_timeout() is not called
>>>>
>>>>        - io_complete_rw_iopoll() is not called from interrupt context
>>>>
>>>>        - io_sq_offload_start() is not called with IORING_SETUP_SQPOLL set
>>>>
>>>> Is it possible that the race is there also in polled mode since a
>>>> request submitted by one thread could conceivably be polled for and
>>>> completed by a different thread, e.g. in
>>>> io_uring_enter()->io_iopoll_check()?
>>>>
>>>> --bijan
>>>>
>>>>
>>> I also tested my RFC again with 1 thread and with queue depths of 1 to
>>> 1024 in multiples of 8 and didn't see any hangs.
>>>
>>> Just to be clear, the busy-spin logic discussed before was only a
>>> workaround an not in the RFC.
>> What is your exact test case?
>>
> See original cover letter.  I can reproduce the failure with numjobs
> between 8 and 32.

And how many poll queues are you using?

-- 
Jens Axboe

