Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A2FCA9EAE
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 01:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BA32086A
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 01:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rTOpwaIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfJ3BC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:02:29 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:42163 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfJ3BC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 21:02:29 -0400
Received: by mail-pg1-f170.google.com with SMTP id f14so271177pgi.9
        for <linux-block@vger.kernel.org>; Tue, 29 Oct 2019 18:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rxQe1bTFGWNTOWZUF5fuYN19NfjCJZz8OvnKl9JcMhg=;
        b=rTOpwaIhAORtnjf+p1gWoATEgT9QlYihowcXU5V6hEcpmuxWYIbdhtK1ub+bTNcsT2
         gMh/tvcbBXqaiJMT/huRykXB2Am79j0kdPeFUWUjFrTpaiLrGTObUfNA3uR1gUQGUVrO
         V1tsbCJzAwvglFecFKr2tIksHnLADGqLxaiV9YcWJhDYUIVK0/+eY7+vRwOXXK9ZfinN
         WG94fZhh9a3p/ZYfKaioLbbbeuy0u2Ss4ZDsJQOTmq4xyLYoisFvs/ccA4r6RPqEwBBc
         0QeVpnh2Xsqh7NG8geQ4nhwTPgKAj0QZbOA/LLNOHIdDkAmVrg40jDZ2q5Tw4tsVz2GN
         kMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rxQe1bTFGWNTOWZUF5fuYN19NfjCJZz8OvnKl9JcMhg=;
        b=NZ2pT2L4KT+MlA0CUsdlAFl5axpIhIT8QsMh7sadisilGI6d3EoNJGF64Wv2+IacIh
         9W98slqyp0zmnkjPeDkcywJUomLUouNcGRc9+q89vurA1bzfJ25XoRFc0BZGT1377Tlb
         y2CtusFig0Lt8uo610IprkABT78OcugHf+yDzm/cxYVSf4HZyiR7n0AXIXOsWZCWPVEQ
         n/dcGzCd49U42yWJtQRGmnFoO+2hgpE76dK5G2zPpsgLxRGx+MM13ytcc+Uyc9QXnl8S
         Zy39w+zjHCA7v1SieMpNYbG5xgrJH3vwOyvn6I5oBMcDtKTvgBEAqYZtwlq+uDj6QAgm
         8Ddg==
X-Gm-Message-State: APjAAAW8y0McYI4AkALNZRzzewcv+2gKlmTCdTi/0Sg2KXvc/rL+QYTl
        kyIHqoZkxbX3lFJ6DEztkMHI7tbUvwIrqg==
X-Google-Smtp-Source: APXvYqww2cV612l+p0yqxONt0vmX0pfnf8zU8uMbSij9/+v1ySbnZgNv7piKqnIy0o03KoXFFlD8Nw==
X-Received: by 2002:a63:1513:: with SMTP id v19mr28443937pgl.11.1572397346762;
        Tue, 29 Oct 2019 18:02:26 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id ck20sm290863pjb.5.2019.10.29.18.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 18:02:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
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
 <057bb6f9-29ec-1160-a1b1-00c57b610282@kernel.dk>
 <5d79122d-afcd-9340-df67-d81e1d94dd80@oracle.com>
 <e7d6ec39-1a1b-b4da-3944-8a1492c2c37e@kernel.dk>
 <3b71fff1-5b5e-3d33-b701-c7e1b3c9d8b9@oracle.com>
 <e334c317-e40a-f670-1d6e-220ddff05d64@kernel.dk>
Message-ID: <07d23273-09e2-1a63-3f18-4d19af298a44@kernel.dk>
Date:   Tue, 29 Oct 2019 19:02:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e334c317-e40a-f670-1d6e-220ddff05d64@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/19 1:52 PM, Jens Axboe wrote:
> On 10/29/19 1:51 PM, Bijan Mottahedeh wrote:
>>
>> On 10/29/19 12:46 PM, Jens Axboe wrote:
>>> On 10/29/19 1:40 PM, Bijan Mottahedeh wrote:
>>>> On 10/29/19 12:33 PM, Jens Axboe wrote:
>>>>> On 10/29/19 1:31 PM, Bijan Mottahedeh wrote:
>>>>>> On 10/29/19 12:27 PM, Jens Axboe wrote:
>>>>>>> On 10/29/19 1:23 PM, Bijan Mottahedeh wrote:
>>>>>>>> On 10/29/19 12:17 PM, Bijan Mottahedeh wrote:
>>>>>>>>> On 10/25/19 7:21 AM, Jens Axboe wrote:
>>>>>>>>>> On 10/25/19 8:18 AM, Jens Axboe wrote:
>>>>>>>>>>> On 10/25/19 8:07 AM, Jens Axboe wrote:
>>>>>>>>>>>> On 10/25/19 7:46 AM, Bijan Mottahedeh wrote:
>>>>>>>>>>>>> On 10/24/19 3:31 PM, Jens Axboe wrote:
>>>>>>>>>>>>>> On 10/24/19 1:18 PM, Bijan Mottahedeh wrote:
>>>>>>>>>>>>>>> On 10/24/19 10:09 AM, Jens Axboe wrote:
>>>>>>>>>>>>>>>> On 10/24/19 3:18 AM, Bijan Mottahedeh wrote:
>>>>>>>>>>>>>>>>> Running an fio test consistenly crashes the kernel with the
>>>>>>>>>>>>>>>>> trace included
>>>>>>>>>>>>>>>>> below.  The root cause seems to be the code in
>>>>>>>>>>>>>>>>> __io_submit_sqe() that
>>>>>>>>>>>>>>>>> checks the result of a request for -EAGAIN in polled mode,
>>>>>>>>>>>>>>>>> without
>>>>>>>>>>>>>>>>> ensuring first that the request has completed:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>             if (ctx->flags & IORING_SETUP_IOPOLL) {
>>>>>>>>>>>>>>>>>                 if (req->result == -EAGAIN)
>>>>>>>>>>>>>>>>>                     return -EAGAIN;
>>>>>>>>>>>>>>>> I'm a little confused, because we should be holding the submission
>>>>>>>>>>>>>>>> reference to the request still at this point. So how is it
>>>>>>>>>>>>>>>> going away?
>>>>>>>>>>>>>>>> I must be missing something...
>>>>>>>>>>>>>>> I don't think the submission reference is going away...
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I *think* the problem has to do with the fact that
>>>>>>>>>>>>>>> io_complete_rw_iopoll() which sets REQ_F_IOPOLL_COMPLETED is being
>>>>>>>>>>>>>>> called from interrupt context in my configuration and so there is a
>>>>>>>>>>>>>>> potential race between updating the request there and checking
>>>>>>>>>>>>>>> it in
>>>>>>>>>>>>>>> __io_submit_sqe().
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> My first workaround was to simply poll for
>>>>>>>>>>>>>>> REQ_F_IOPOLL_COMPLETED in the
>>>>>>>>>>>>>>> code snippet above:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>                   if (req->result == --EAGAIN) {
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>                       poll for REQ_F_IOPOLL_COMPLETED
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>                       return -EAGAIN;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> }
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> and that got rid of the problem.
>>>>>>>>>>>>>> But that will not work at all for a proper poll setup, where you
>>>>>>>>>>>>>> don't
>>>>>>>>>>>>>> trigger any IRQs... It only happens to work for this case because
>>>>>>>>>>>>>> you're
>>>>>>>>>>>>>> still triggering interrupts. But even in that case, it's not a real
>>>>>>>>>>>>>> solution, but I don't think that's the argument here ;-)
>>>>>>>>>>>>> Sure.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm just curious though as how it would break the poll case because
>>>>>>>>>>>>> io_complete_rw_iopoll() would still be called though through polling,
>>>>>>>>>>>>> REQ_F_IOPOLL_COMPLETED would be set, and so io_iopoll_complete()
>>>>>>>>>>>>> should be able to reliably check req->result.
>>>>>>>>>>>> It'd break the poll case because the task doing the submission is
>>>>>>>>>>>> generally also the one that finds and reaps completion. Hence if you
>>>>>>>>>>>> block that task just polling on that completion bit, you are
>>>>>>>>>>>> preventing
>>>>>>>>>>>> that very task from going and reaping completions. The condition would
>>>>>>>>>>>> never become true, and you are now looping forever.
>>>>>>>>>>>>
>>>>>>>>>>>>> The same poll test seemed to run ok with nvme interrupts not being
>>>>>>>>>>>>> triggered. Anyway, no argument that it's not needed!
>>>>>>>>>>>> A few reasons why it would make progress:
>>>>>>>>>>>>
>>>>>>>>>>>> - You eventually trigger a timeout on the nvme side, as blk-mq
>>>>>>>>>>>> finds the
>>>>>>>>>>>>              request hasn't been completed by an IRQ. But that's a 30
>>>>>>>>>>>> second ordeal
>>>>>>>>>>>>              before that event occurs.
>>>>>>>>>>>>
>>>>>>>>>>>> - There was still interrupts enabled.
>>>>>>>>>>>>
>>>>>>>>>>>> - You have two threads, one doing submission and one doing
>>>>>>>>>>>> completions.
>>>>>>>>>>>>              Maybe using SQPOLL? If that's the case, then yes, it'd still
>>>>>>>>>>>> work as
>>>>>>>>>>>>              you have separate threads for submission and completion.
>>>>>>>>>>>>
>>>>>>>>>>>> For the "generic" case of just using one thread and IRQs disabled,
>>>>>>>>>>>> it'd
>>>>>>>>>>>> deadlock.
>>>>>>>>>>>>
>>>>>>>>>>>>>> I see what the race is now, it's specific to IRQ driven polling. We
>>>>>>>>>>>>>> really should just disallow that, to be honest, it doesn't make any
>>>>>>>>>>>>>> sense. But let me think about if we can do a reasonable solution
>>>>>>>>>>>>>> to this
>>>>>>>>>>>>>> that doesn't involve adding overhead for a proper setup.
>>>>>>>>>>>>> It's a nonsensical config in a way and so disallowing it would make
>>>>>>>>>>>>> the most sense.
>>>>>>>>>>>> Definitely. The nvme driver should not set .poll() if it doesn't have
>>>>>>>>>>>> non-irq poll queues. Something like this:
>>>>>>>>>>> Actually, we already disable polling if we don't have specific poll
>>>>>>>>>>> queues:
>>>>>>>>>>>
>>>>>>>>>>>                   if (set->nr_maps > HCTX_TYPE_POLL &&
>>>>>>>>>>>                       set->map[HCTX_TYPE_POLL].nr_queues)
>>>>>>>>>>>                           blk_queue_flag_set(QUEUE_FLAG_POLL, q);
>>>>>>>>>>>
>>>>>>>>>>> Did you see any timeouts in your tests? I wonder if the use-after-free
>>>>>>>>>>> triggered when the timeout found the request while you had the
>>>>>>>>>>> busy-spin
>>>>>>>>>>> logic we discussed previously.
>>>>>>>>>> Ah, but we still have fops->iopoll() set for that case. So we just won't
>>>>>>>>>> poll for it, it'll get completed by IRQ. So I do think we need to handle
>>>>>>>>>> this case in io_uring. I'll get back to you.
>>>>>>>>>>
>>>>>>>>> I ran the same test on linux-next-20191029 in polled mode and got the
>>>>>>>>> same free-after-user panic:
>>>>>>>>>
>>>>>>>>> - I booted with nvme.poll_queues set and verified that all queues
>>>>>>>>> except default where of type poll
>>>>>>>>>
>>>>>>>>> - I added three assertions to verify the following:
>>>>>>>>>
>>>>>>>>>             - nvme_timeout() is not called
>>>>>>>>>
>>>>>>>>>             - io_complete_rw_iopoll() is not called from interrupt context
>>>>>>>>>
>>>>>>>>>             - io_sq_offload_start() is not called with IORING_SETUP_SQPOLL set
>>>>>>>>>
>>>>>>>>> Is it possible that the race is there also in polled mode since a
>>>>>>>>> request submitted by one thread could conceivably be polled for and
>>>>>>>>> completed by a different thread, e.g. in
>>>>>>>>> io_uring_enter()->io_iopoll_check()?
>>>>>>>>>
>>>>>>>>> --bijan
>>>>>>>>>
>>>>>>>>>
>>>>>>>> I also tested my RFC again with 1 thread and with queue depths of 1 to
>>>>>>>> 1024 in multiples of 8 and didn't see any hangs.
>>>>>>>>
>>>>>>>> Just to be clear, the busy-spin logic discussed before was only a
>>>>>>>> workaround an not in the RFC.
>>>>>>> What is your exact test case?
>>>>>>>
>>>>>> See original cover letter.  I can reproduce the failure with numjobs
>>>>>> between 8 and 32.
>>>>> And how many poll queues are you using?
>>>>>
>>>> 30
>>> And how many threads/cores in the box? Trying to get a sense for how
>>> many CPUs share a single poll queue, if any.
>>>
>> Thread(s) per core:    2
>> Core(s) per socket:    8
>> Socket(s):             2
> 
> OK, so 2*8*2 == 32 threads, hence some threads will share a poll queue.

OK, so I still don't quite see where the issue is. Your setup has more
than one CPU per poll queue, and I can reproduce the issue quite easily
here with a similar setup. Below are some things that are given:

1) If we fail to submit the IO, io_complete_rw_iopoll() is ultimately
   invoked _from_ the submission path. This means that the result is
   readily available by the time we go and check:

   if (req->result == -EAGAIN)

   in __io_submit_sqe(). This is a submission time failure, not
   something that should be happening from a completion path after the
   IO has been submitted successfully.

2) If the succeed in submitting the request, given that we have other
   tasks polling, the request can complete any time. It can very well be
   complete by the time we call io_iopoll_req_issued(), and this is
   perfectly fine. We know the request isn't going away, as we're
   holding a reference to it. kiocb has the same lifetime, as it's
   embedded in the io_kiocb request. Note that this isn't the same
   io_ring_ctx at all, some other task with its own io_ring_ctx just
   happens to find our request when doing polling on the same queue
   itself.

We would definitely get in trouble if we submitted the request
successfully, but returned -EAGAIN because we thought we didn't.

In my testing, what I seem to see is double completions on the block
layer side, and double issues. I can't quite get that to match up with
anything...

I'll keep digging, hopefully I'll get some deeper understanding of what
exactly the issue is shortly. I was hoping I'd get that by writing my
thoughts in this email, but alas that didn't happen yet.

-- 
Jens Axboe

