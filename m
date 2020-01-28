Return-Path: <SRS0=qLSf=3R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB83C2D0DB
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 23:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACC122522
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 23:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cBzUHJYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA1Xh2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:37:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53296 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1Xh2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jan 2020 18:37:28 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so1753505pjc.3
        for <linux-block@vger.kernel.org>; Tue, 28 Jan 2020 15:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xKAhy3A4dE2QHEVS0uad2IKGhlFRTFTG3+VTqkIiltY=;
        b=cBzUHJYt+8cdkivef8GJN9X2J18TeQEcdUUrr9tEY4+9LwTrC0a8iXRSVHBCsIBixd
         uVueWBDlTa55rNIrjazeWrdtYbR7rzeXtdNCUPHmCDhje+S2S+ydKS6/OcZNZoE/Y8Hp
         MLOqkU7wDxB87jrvLPyMswZUPlc65kwkvFx8zlN+bDqc2ZZOOPbYulQSkB4+e7RMzNe1
         +tVDERyBsmCowacK8uZYlEkvenPVgTvo7J1/lth1aSQGjVFeDbjGTdX4m4YbsGFYrsc+
         fYkVJfHr9jHfEDnIV+8PALKWz/LwQWYqKRP/acCkxOv5Z68CxlMbXzPf68mLvsvNnEvp
         Z2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xKAhy3A4dE2QHEVS0uad2IKGhlFRTFTG3+VTqkIiltY=;
        b=KKXIxPZ93LVm9Xr8a9Fmplq26dBsUIs26kULa0kt7LN3e643/+HSXekkMbNzhq3haG
         7Y5Nm2ZnIRQaQSL6QvLURUkkgrT3uV176XBsLkpl2IVblZgqvLgzosorQPmN673f1mLP
         9jcThWsFa+ZZM+EIx5ewiIzhikR9HgapD+RKkox0GUi/dUycvd8IX1K8Mk2v4WZxcS7A
         G7TFL/TlJnjy8EPbRRnzeask/m9BsVnikAxKtXJnTOf0JLU8mu+67hH0wVjTXzJyrcAG
         tbP4FevWfPSY6WypWn0wZqDCObuhsUnPxkF/E/cERhGynlLSHMeClPfDKzqgjEhW/i4h
         Lfcw==
X-Gm-Message-State: APjAAAWJ/y+XZYEMp3yenufhs9MDWIdwYdeHFdLWeyv3/+ySDyyUk2iP
        yUqtx5jMbZU83sXvOAUCZDm+wA==
X-Google-Smtp-Source: APXvYqyqguibddvCm+2R2iLt0GLAVUjJTpehWxazQ4xjnj3e1Sdvela/fhn86CSmXbDHnJpN6Ap6sw==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr23958463plf.50.1580254647178;
        Tue, 28 Jan 2020 15:37:27 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g8sm145956pfh.43.2020.01.28.15.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 15:37:26 -0800 (PST)
Subject: Re: [RFC 2/2] io_uring: acquire ctx->uring_lock before calling
 io_issue_sqe()
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@gmail.com>
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
 <9b359dde-3bb6-5886-264b-4bee90be9e25@kernel.dk>
 <8f7986c7-e5b4-8f24-1c71-666c01b16c8b@kernel.dk>
 <1397cd55-37a6-4e14-91ac-eb3c35e7d962@kernel.dk>
 <b43835cd-3bd6-705e-df51-923bbec78c67@oracle.com>
 <18346d15-d89d-9d28-1ef8-77574d44dce7@kernel.dk>
 <229bd8ea-cd65-c77a-ad58-2a79f3bd0c5b@oracle.com>
 <a316d3fe-4162-8274-a74a-2d13a4caf011@kernel.dk>
 <f56a8767-c754-b2e9-bfea-1ced197a05d7@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f3f8b48-2e50-d0bb-b912-6d03961b2d6a@kernel.dk>
Date:   Tue, 28 Jan 2020 16:37:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f56a8767-c754-b2e9-bfea-1ced197a05d7@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/20 1:34 PM, Bijan Mottahedeh wrote:
> On 1/16/2020 1:26 PM, Jens Axboe wrote:
>> On 1/16/20 2:04 PM, Bijan Mottahedeh wrote:
>>> On 1/16/2020 12:02 PM, Jens Axboe wrote:
>>>> On 1/16/20 12:08 PM, Bijan Mottahedeh wrote:
>>>>> On 1/16/2020 8:22 AM, Jens Axboe wrote:
>>>>>> On 1/15/20 9:42 PM, Jens Axboe wrote:
>>>>>>> On 1/15/20 9:34 PM, Jens Axboe wrote:
>>>>>>>> On 1/15/20 7:37 PM, Bijan Mottahedeh wrote:
>>>>>>>>> io_issue_sqe() calls io_iopoll_req_issued() which manipulates poll_list,
>>>>>>>>> so acquire ctx->uring_lock beforehand similar to other instances of
>>>>>>>>> calling io_issue_sqe().
>>>>>>>> Is the below not enough?
>>>>>>> This should be better, we have two that set ->in_async, and only one
>>>>>>> doesn't hold the mutex.
>>>>>>>
>>>>>>> If this works for you, can you resend patch 2 with that? Also add a:
>>>>>>>
>>>>>>> Fixes: 8a4955ff1cca ("io_uring: sqthread should grab ctx->uring_lock for submissions")
>>>>>>>
>>>>>>> to it as well. Thanks!
>>>>>> I tested and queued this up:
>>>>>>
>>>>>> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.5&id=11ba820bf163e224bf5dd44e545a66a44a5b1d7a
>>>>>>
>>>>>> Please let me know if this works, it sits on top of the ->result patch you
>>>>>> sent in.
>>>>>>
>>>>> That works, thanks.
>>>>>
>>>>> I'm however still seeing a use-after-free error in the request
>>>>> completion path in nvme_unmap_data().  It happens only when testing with
>>>>> large block sizes in fio, typically > 128k, e.g. bs=256k will always hit it.
>>>>>
>>>>> This is the error:
>>>>>
>>>>> DMA-API: nvme 0000:00:04.0: device driver tries to free DMA memory it
>>>>> has not allocated [device address=0x6b6b6b6b6b6b6b6b] [size=1802201963
>>>>> bytes]
>>>>>
>>>>> and this warning occasionally:
>>>>>
>>>>> WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
>>>>>
>>>>> It seems like a request might be issued multiple times but I can't see
>>>>> anything in io_uring code that would account for it.
>>>> Both of them indicate reuse, and I agree I don't think it's io_uring. It
>>>> really feels like an issue with nvme when a poll queue is shared, but I
>>>> haven't been able to pin point what it is yet.
>>>>
>>>> The 128K is interesting, that would seem to indicate that it's related to
>>>> splitting of the IO (which would create > 1 IO per submitted IO).
>>>>
>>> Where does the split take place?  I had suspected that it might be
>>> related to the submit_bio() loop in __blkdev_direct_IO() but I don't
>>> think I saw multiple submit_bio() calls or maybe I missed something.
>> See the path from blk_mq_make_request() -> __blk_queue_split() ->
>> blk_bio_segment_split(). The bio is built and submitted, then split if
>> it violates any size constraints. The splits are submitted through
>> generic_make_request(), so that might be why you didn't see multiple
>> submit_bio() calls.
>>
> 
> I think the problem is in __blkdev_direct_IO() and not related to 
> request size:
> 
>                          qc = submit_bio(bio);
> 
>                          if (polled)
>                                  WRITE_ONCE(iocb->ki_cookie, qc);
> 
> 
> The first call to submit_bio() when dio->is_sync is not set won't have 
> acquired a bio ref through bio_get() and so the bio/dio could be freed 
> when ki_cookie is set.
> 
> With the specific io_uring test, this happens because 
> blk_mq_make_request()->blk_mq_get_request() fails and so terminates the 
> request.
> 
> As for the fix for polled io (!is_sync) case, I'm wondering if 
> dio->multi_bio is really necessary in __blkdev_direct_IO(). Can we call 
> bio_get() unconditionally after the call to bio_alloc_bioset(), set 
> dio->ref = 1, and increment it for additional submit bio calls?  Would 
> it make sense to do away with multi_bio?

It's not ideal, but not sure I see a better way to fix it. You see the
case on failure, which we could check for (don't write cookie if it's
invalid). But this won't fix the case where the IO complete fast, or
even immediately.

Hence I think you're right, there's really no way around doing the bio
ref counting, even for the sync case. Care to cook up a patch we can
take a look at? I can run some high performance sync testing too, so we
can see how badly it might hurt.

> Also, I'm not clear on how is_sync + mult_bio case is supposed to work.  
> __blkdev_direct_IO() polls for *a* completion in the request's hctx and 
> not *the* request completion itself, so what does that tell us for 
> multi_bio + is_sync? Is the polling supposed to guarantee that all 
> constituent bios for a mult_bio request have completed before return?

The polling really just ignores that, it doesn't take multi requests
into account. We just poll for the first part of it.

-- 
Jens Axboe

