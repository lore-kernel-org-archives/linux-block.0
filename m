Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B9C43444
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EDF20645
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rRrH8TQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbfAOQzi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:55:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34429 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbfAOQzh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 11:55:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so1599181pfg.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jan 2019 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ze4bAj+Nuy3S2uragiLBlzirMPoVEPScDM5+5nQvM9Y=;
        b=rRrH8TQ1wEZoZOuk7GUNU0OGwe03KeY3igkI9053ZrK1JZOphsKdUH3m5JgUAfVxet
         B3Eqv46rkVLDBg1JZydwv/3Yti9tQEczBIz+loBAnzQf4pvmjzdGMEUxfON3WgYTPCFu
         KPwAq26XUayX+ej9C7OagljU0QbQScNB16dcMJqJ04prLKajv0li2hE3i8p6UD4nUsds
         OgFXqmJ92bEL1otQwcC1QjVVQUWrbQ2jb/E63Y5ts+XTlE/xO3wmOQk1P8UnZPj4j4D0
         ycPu1P46Q0vou7diuSw4Z7gtkK6fu5VCzALCj096WwWOa5oOjpZjg5Tk/vKcz5qb8XmK
         OB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ze4bAj+Nuy3S2uragiLBlzirMPoVEPScDM5+5nQvM9Y=;
        b=fB5VbzE4TLJYFlpGONNsDukWePqN/3yeFeMAHSj2Zl5jh1JGK7Uy0jvlztTlrY0FXF
         +vTx+XhDdDjf+BnXnPqDp8uzzfmit0pBEwD7X/R1w0RZHONcDOwQc/NheQ2otLt90eK5
         axrIMNmqnGlLF0iT7ds+9+pRfknKv+vu7Fbj5dRjHfCCRd0fwwefz9p+9oHp1tFhoDrD
         +Ra3NUbOx7vK5MSY1I5wqKib+S84oVoHXrfPeJNUY/YMQ+PW2PywBtIAjTzTGkPla/dT
         qVsSAqhDYwnNpuXL2RYzgAT91xw5UMl5AyKwTKwCmIXCu2SQGiyskCfoOj2DNZwumpY8
         QXmQ==
X-Gm-Message-State: AJcUukdTO9ieHXERwzw7ET6wRzRytT+vFzNVJJqQNeYXY0EvpUhupEcV
        lpmIvZ9dCgm5rr0KhuqK0oNL6A==
X-Google-Smtp-Source: ALg8bN480JXegH0QHHd7t2Op1tzPHQHIR26bAO1ZZpofdf0+SDjTjov2s2r2emlXsHSZkMaxlUPKBA==
X-Received: by 2002:a63:184a:: with SMTP id 10mr4545065pgy.81.1547571335571;
        Tue, 15 Jan 2019 08:55:35 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o1sm5315470pgn.63.2019.01.15.08.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 08:55:34 -0800 (PST)
Subject: Re: [PATCH 05/16] Add io_uring IO interface
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-6-axboe@kernel.dk> <20190115095134.6286b7d6@lwn.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5e1fe0b7-7998-d15d-267b-4dbbc01b0b53@kernel.dk>
Date:   Tue, 15 Jan 2019 09:55:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115095134.6286b7d6@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/15/19 9:51 AM, Jonathan Corbet wrote:
> On Mon, 14 Jan 2019 19:55:20 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> So the [0/16] cover letter seems to have gone astray this time?

It did go out, but I forgot to add a Subject line to it...

https://marc.info/?l=linux-block&m=154752095709422&w=2


>> The submission queue (SQ) and completion queue (CQ) rings are shared
>> between the application and the kernel. This eliminates the need to
>> copy data back and forth to submit and complete IO.
>>
>> IO submissions use the io_uring_sqe data structure, and completions
>> are generated in the form of io_uring_sqe data structures. The SQ
>> ring is an index into the io_uring_sqe array, which makes it possible
>> to submit a batch of IOs without them being contiguous in the ring.
>> The CQ ring is always contiguous, as completion events are inherently
>> unordered and can point to any io_uring_iocb.
>>
>> Two new system calls are added for this:
>>
>> io_uring_setup(entries, iovecs, params)
>> 	Sets up a context for doing async IO. On success, returns a file
>> 	descriptor that the application can mmap to gain access to the
>> 	SQ ring, CQ ring, and io_uring_iocbs.
> 
> Looking at the code, it would appear that the "iovecs" parameter doesn't
> actually exist.

Indeed, need to update that commit message. and io_uring_iocbs should
now be io_uring_sqes.

The iovec/file registration is done through io_uring_register(2).

>> io_uring_enter(fd, to_submit, min_complete, flags)
>> 	Initiates IO against the rings mapped to this fd, or waits for
>> 	them to complete, or both The behavior is controlled by the
>> 	parameters passed in. If 'min_complete' is non-zero, then we'll
>> 	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
>> 	kernel will wait for 'min_complete' events, if they aren't
>> 	already available.
> 
> I feel like I'm missing something here.  Rather than have the
> IORING_ENTER_GETEVENTS flag, why not just wait if min_complete > 0 ?

For polled IO, it's useful to be able to check if we have events that
can be readily reaped. If min_complete > 0, then you're asking the
interface to wait/poll for these events. IORING_ENTER_GETEVENTS +
min_complete == 0 is a valid combination to just reap events that are
already completed.

-- 
Jens Axboe

