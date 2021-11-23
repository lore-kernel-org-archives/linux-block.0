Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535C4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhKWQ5L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhKWQ5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:57:07 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C260BC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:53:59 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z26so28733846iod.10
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BzNq5SHhSRzsQiQB+oN2proCHVIIz5kklX0K2XZEMj4=;
        b=eawGZeo335wZr2D4M7qqmLiXfp/wiT3LnG3vQUBlU6t/q0yDb2YKEUAbRnOqobIwKH
         dQU+sreqe/xCsqYRLObTtC5h1lXa0s6GLepNQp6Aysx0gorw581b6bAgwIStSqg510IU
         9GV3voiWLTYQ0f/dZDtwNM8WeZNAMExkt8Fs5FNbB0rES57k2DFPjcOAPewWD4Vd2nQj
         2fb6g0UwoClpRN4fv2JQSDvANCbQC89/h2oSICJASOYdx7R23em9mHF0CuMKnxcE6dRn
         fQj4H7L5S4NlHvntF/FcbgfBJTqllByiUhiQ4Sg16MHUJSeq+ALNCIz6TV+YjIUBTvbV
         T/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BzNq5SHhSRzsQiQB+oN2proCHVIIz5kklX0K2XZEMj4=;
        b=OgNkabgJI9Gcp/uqJTC9RR8A/bvrt6IfPWOpF7kJ020FJ+9wquGaP0swNVb2IRRF6m
         Rtxb17ElyvLdIuwU6nAKdIUNYb2w82ntJeaE1bTBrqPJsrllOI3VdPPUFudHF3ApiBrY
         H2KKm6ejftBEeW9462lG9iPGow6W7b/RyByjbVRPPxbefBOR5kP0jmAjjqIkXJm5LfrG
         1CstqvZjTEUdiSpw61ILvxUUZIeRiD50AMBQ/FK1mKMORQ/nDE/frW3iGzQnIWCssnRl
         Mbirx+H5ohiGjPU6Z/StjA3B8YUPCMMK5zMY84kFqqw7sKnU1lG0Vmbf2ftnBNgCiUZA
         Zceg==
X-Gm-Message-State: AOAM532KRD6+d+4DFYCFhVR4QhnyaPviGcHxYc+pnEGpI1UR9aIZLtcE
        F+NXqM+LNI7iZj6WhX9K2C+XQ3DgqCTW94i6
X-Google-Smtp-Source: ABdhPJzcRvjeFwNfFHPIzLDmk562NqUE/lECts15x4Mh83BvYyGsuwbDdtgVK6fmLFb2VBSHuvYF+w==
X-Received: by 2002:a05:6602:2d04:: with SMTP id c4mr7754694iow.56.1637686438861;
        Tue, 23 Nov 2021 08:53:58 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm8225121iow.9.2021.11.23.08.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:53:58 -0800 (PST)
Subject: Re: [PATCH 1/3] block: move io_context creation into where it's
 needed
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-2-axboe@kernel.dk> <YZ0ZUJGilOzhF2k5@infradead.org>
 <56538fd1-ca28-386b-36ba-493399af1803@kernel.dk>
Message-ID: <a2b73453-c38c-c951-58cf-b8b3ee3fefb7@kernel.dk>
Date:   Tue, 23 Nov 2021 09:53:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <56538fd1-ca28-386b-36ba-493399af1803@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 9:46 AM, Jens Axboe wrote:
> On 11/23/21 9:39 AM, Christoph Hellwig wrote:
>>> +	/* create task io_context, if we don't have one already */
>>> +	if (unlikely(!current->io_context))
>>> +		create_task_io_context(current, GFP_ATOMIC, rq->q->node);
>>
>> Wouldn't it be nicer to have an interface that hides the check
>> and the somewhat pointless current argument?  And name that with a
>> blk_ prefix?
> 
> Yeah, we can do that.
> 
>>> +
>>> +	blk_mq_sched_assign_ioc(rq);
>>
>> But thinking about this a little more:
>>
>> struct io_context has two uses, one is the unsigned short ioprio,
>> and the other is the whole bfq mess.
>>
>> Can't we just split the ioprio out (we'll find a hole somewhere
>> in task_struct) and then just allocate the io_context in
>> blk_mq_sched_assign_ioc, which would also avoid the pointless
>> ioc_lookup_icq on a newly allocated io_context.  I'd also really
>> expect blk_mq_sched_assign_ioc to be implemented in blk-ioc.c.
> 
> It would be nice to decouple ioprio from the io_context, and just
> leave the io_context for BFQ essentially.
> 
> I'll give it a shot.

Actually may not be that trivial - if a thread is cloned with CLONE_IO,
then it shares the io_context, and hence also the io priority. That will
auto-propagate if one linked task changes it, and putting it in the
task_struct would break that.

So I don't think we can do that - which is a shame, as it would be a
nice cleanup.

-- 
Jens Axboe

