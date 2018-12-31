Return-Path: <SRS0=5hX+=PI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C1C43387
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 20:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B4F2081B
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 20:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KxZ+t54T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeLaUGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Dec 2018 15:06:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45813 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeLaUGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Dec 2018 15:06:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so12924291plm.12
        for <linux-block@vger.kernel.org>; Mon, 31 Dec 2018 12:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BAfZiu83AM8Zqnit+YyiXVnrAP6l+CBLSeBmAwLDEP0=;
        b=KxZ+t54TkQW91OA6+Cdj8hK0XdP4LZLCeUQ380COpsxcplVzd74SxcHzgEBZc8ONB4
         /CU+PUBqj5m6XmI8ylRoJrb85YE6hGBvkMXyVdRbrz6W9k5JXU5Y9ggvbv49HVLY+GUN
         ceyXLoz+pR73JzVHvj4LaxkggZqd5OWNM815hozZzS3WXxxIZ714Wvm+eVhU8KPeYruL
         2M4m/rBq+ZMSLmx3rTsK02PA3GcaxVOashiO/xEMbsL9qnNCJ6nNTJrd6NILyoAw8rEK
         iPFoquPv/GK36CThfRk66WIfMGgt31Qt4WYlaETQFlWhevlEBNvPn6zeYRqSflYzP5Hb
         dr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BAfZiu83AM8Zqnit+YyiXVnrAP6l+CBLSeBmAwLDEP0=;
        b=h1D81a4+i9JnoL3uVNoKeRAQMM0GvTRjdjLWPuo1nz2wilvrT/ssl9Zs5Kh21Gsb5V
         QDbQECCA/xZ2RXl9BH/qc+7FjVGfrszkiwGciNI5Yq/ZR9eu8o30ceGomeA+eDHUGjj3
         QIgE5RsTFycNWZD86NwNAsUl4KPkROyU/00lAkyx27AfmPmUsSynINjQE3qJX+M+nBzD
         E78K0Kksblesfm9LXSCl3zV3mW04B8azSULjCIGIv4x3SDlgxXd3KDwtLSkS23xtEmoT
         /QShsvCZA5s1I+YYsuunvVbc5dRgBHpe2XbRWNJqlv6+i3HV59ekBs89Fce+6J4FEk59
         T+nA==
X-Gm-Message-State: AJcUukfQ2Ca3mKlnAnmMXrIxJsFarOAqDHP4kZorPk+ATaXxOXItt8iE
        zECv/9lUzr0ksMdUIxB8dw/CBI+tyz76aQ==
X-Google-Smtp-Source: ALg8bN65vqTR6ULDJ/+bMp2k4LcHH9W/q9HomEqzB0M+I/mRV9I5RLrzKS89Ds7VEs7imZd12pFy8Q==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15mr37140912plr.245.1546286772549;
        Mon, 31 Dec 2018 12:06:12 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f6sm71066055pfg.188.2018.12.31.12.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 12:06:10 -0800 (PST)
Subject: Re: [GIT PULL] Block changes for 4.21-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <84df20e9-00af-37e5-c37f-ad7ff2437073@kernel.dk>
 <CAHk-=wjKZ-AmcVQEUFLuS1uSjyHLo2Z1tYq8asOCTziF8MbAuQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <908c846c-8634-899a-b575-afb3e32144c6@kernel.dk>
Date:   Mon, 31 Dec 2018 13:06:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjKZ-AmcVQEUFLuS1uSjyHLo2Z1tYq8asOCTziF8MbAuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/28/18 2:48 PM, Linus Torvalds wrote:
> On Thu, Dec 20, 2018 at 8:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Jens Axboe (108):
>>       block: avoid ordered task state change for polled IO
> 
> This one seems *very* questionable.
> 
> The commit message is misleading:
> 
>     For the core poll helper, the task state setting don't need to imply any
>     atomics, as it's the current task itself that is being modified and
>     we're not going to sleep.
> 
>     For IRQ driven, the wakeup path have the necessary barriers to not need
>     us using the heavy handed version of the task state setting.
> 
> What? Barriers on one side have *no* meaning or point if the *other*
> side doesn't have any barriers.  That's completely magical thinking.
> 
> But it's also not at all the case that such barriers even exist. The
> wakup side does:
> 
>                         struct task_struct *waiter = dio->submit.waiter;
>                         WRITE_ONCE(dio->submit.waiter, NULL);
>                         blk_wake_io_task(waiter);
> 
> and here the sleeping side now does:
> 
>                         __set_current_state(TASK_UNINTERRUPTIBLE);
> 
>                         if (!READ_ONCE(dio->submit.waiter))
>                                 break;
> 
> which is entirely unordered. So just what protects against this:
> 
>   Sleeper:              Waker (different cpu)
> 
>   read submit.waker
>   (sees non-NULL)
> 
>                         WRITE_ONCE(dio->submit.waiter, NULL);
>                         blk_wake_io_task(waiter);
> 
>   write TASK_UNINTERRUPTIBLE
>   io_schedule()
> 
> and now the sleeper sleeps forever, because there will be nobody who
> ever wakes it up (the wakeup happened before the write of
> TASK_UNINTERRUPTIBLE).
> 
> Notice how it does not matter AT ALL what barriers that other CPU is
> doing when waking things up. The problem is the sleeping CPU having
> reordered the check for "oh, there's a waiter", and "tell people I'm
> going to sleep".
> 
> Those memory barriers matter. You can't just remove them randomly and
> claim they don't.
> 
> Why would you even remove it in the first place?
> 
> Guys, if you don't understand memory ordering, then you have
> absolutely no business using __set_current_state(). And talking about
> barriers on the other side of the equation clearly shows that you
> don't seem to understand memory ordering.
> 
> Barriers are only *ever* meaningful if they exist on both sides
> (although sometimes said barriers can be implicit: an address
> dependency or similar in RCU, now that we've decided to not care abotu
> the crazy alpha read-barrier-depends)
> 
> Maybe I'm  missing something, but this really looks like a completely
> invalid "optimization" to me.  And it's entirely bogus too. If that
> memory barrier matters, you're almost certainly doing something wrong
> (most likely benchmarking something pointless).

I think what went wrong here is that the patch morphed through
multiple iterations, and I agree the IRQ side does not look correct.
The polled part is fine.

Sorry for the late reply, in and out this time of year. I'll get
something posted and queued up for the later pull I was planning
for this merge window, for the other stragglers.


-- 
Jens Axboe

