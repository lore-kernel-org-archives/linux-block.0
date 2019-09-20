Return-Path: <SRS0=iom0=XP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4624DC49ED7
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001C220820
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 21:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Nzv7OBFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405138AbfITV00 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:26:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38474 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393850AbfITV0Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 17:26:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so5357691pfe.5
        for <linux-block@vger.kernel.org>; Fri, 20 Sep 2019 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zjuTsS8y6xPdok53PRDzUsgWY9abejRHHh893icjvnI=;
        b=Nzv7OBFGBRXIbPeoL7TAdUsyhYRJlgDp92BgPRm5BoXiZv3J5W1TeQmEHkYC7oR6eJ
         FiKRfwTnesEIpp4TCBmHHpvVfBsVFyH7jGE+08Zq2rGcFyhpm9mxuxUcBEKBOhdeHDZY
         uJjvmPz1o0mOuLJsnQdb1aL/9v8ElMzvZKe3Q9kj4cUcv7MLxo98JpJkoEiEQr2mNsbs
         B+mwEloEQmSUIyu4lxAFLT3y4XvYqdzzgftBOhWtxE93fqlydBmk3GYnlSNrKRejk56n
         HHqI+m++qeWnukRCK5cOhtIaDWmFRpJ7W/ftzSbgh0KIZIULCDhJotQqA63/ZY9jwF/f
         UG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zjuTsS8y6xPdok53PRDzUsgWY9abejRHHh893icjvnI=;
        b=HGoo0X3bLTdLK4KeyCwZ9xv3dBbQmT7a/5KMXV56kOOI3Tdjn4vs7HMoYSmXMDp1/M
         YB3DyfiAoGW6vInXI6BHC7VRWT91AphFkfmVOhMeXyCOf6lKaAVWI2EKibe7k7yIJQjO
         8A78RCDBcB8270ef3jYMb6AYkxnxgQ4LTctdcw4Wa7blX2pxqJz9gH+GPev+bsHinJzJ
         LmgVU6lVSfyGwvIe5HikaRSVbxjiWHDbVZX4xKfX32XYhs5rVRkcifJSdD6gnb1tGD2Q
         VOeuFtjZKCHuADE4swA9zcgfYM9MUEiYc4kqtPpUNtLouCHZ2IRdaPSCH/42iV8HckVt
         eedw==
X-Gm-Message-State: APjAAAWcpfzZfVVt1JGDIkCR3ebmTd8jonAAWwFZHqx8CHiWO6kk6wD6
        YayDbV2wxiQm9V3UZx3OK9X4kMkx+cRuhw==
X-Google-Smtp-Source: APXvYqzU50g13QRBXyGe5rUrD9sI+EilMtdk5iJazZtONtBr9CRgF6I1TDN01pAIn4JKthxv2MvdSA==
X-Received: by 2002:a63:2f44:: with SMTP id v65mr16895411pgv.380.1569014783724;
        Fri, 20 Sep 2019 14:26:23 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id b69sm4693099pfb.132.2019.09.20.14.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 14:26:22 -0700 (PDT)
Subject: Re: [PATCH] io_uring: IORING_OP_TIMEOUT support
To:     Andres Freund <andres@anarazel.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f0488dd6-c32b-be96-9bdc-67099f1f56f8@kernel.dk>
 <20190920165348.pjmdnm3mozna3ous@alap3.anarazel.de>
 <838a193a-cb83-c6d5-f251-b113e9faf9d5@kernel.dk>
 <20190920205654.2g7z6znt4r337qrt@alap3.anarazel.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd6ee297-da1b-d82c-d776-1d75a72b35e8@kernel.dk>
Date:   Fri, 20 Sep 2019 15:26:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920205654.2g7z6znt4r337qrt@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/19 2:56 PM, Andres Freund wrote:
> Hi,
> 
> On 2019-09-20 14:18:07 -0600, Jens Axboe wrote:
>> On 9/20/19 10:53 AM, Andres Freund wrote:
>>> Hi,
>>>
>>> On 2019-09-17 10:03:58 -0600, Jens Axboe wrote:
>>>> There's been a few requests for functionality similar to io_getevents()
>>>> and epoll_wait(), where the user can specify a timeout for waiting on
>>>> events. I deliberately did not add support for this through the system
>>>> call initially to avoid overloading the args, but I can see that the use
>>>> cases for this are valid.
>>>
>>>> This adds support for IORING_OP_TIMEOUT. If a user wants to get woken
>>>> when waiting for events, simply submit one of these timeout commands
>>>> with your wait call. This ensures that the application sleeping on the
>>>> CQ ring waiting for events will get woken. The timeout command is passed
>>>> in a pointer to a struct timespec. Timeouts are relative.
>>>
>>> Hm. This interface wouldn't allow to to reliably use a timeout waiting for
>>> io_uring_enter(..., min_complete > 1, ING_ENTER_GETEVENTS, ...)
>>> right?
>>
>> I've got a (unpublished as of yet) version that allows you to wait for N
>> events, and canceling the timer it met. So that does allow you to reliably
>> wait for N events.
> 
> Cool.
> 
> I'm not quite sure how to parse "canceling the timer it met".

s/it/if

> I assume you mean that one could ask for min_complete, and
> IORING_OP_TIMEOUT would interrupt that wait, even if fewer than
> min_complete have been collected?  It'd probably be good to return 0
> instead of EINTR if at least one event is ready, otherwise it does seem
> to make sense.

Right, what I mean is if you ask for a timeout for N events, if N events
pass before the timeout expires, then the timeout essentially does
nothing. You'd still get a completion event, as with all SQEs, but it
would not timeout and it'd happen right after that Nth event.

The wait part always returns 0 if we have events, a potential error is
only returned if the CQ ring is empty. That's the same as what we have
now.

But sounds like we are in violent agreement. I'll post a new patch for
this soonish.

>>> I can easily imagine usecases where I'd want to submit a bunch of ios
>>> and wait for all of their completion to minimize unnecessary context
>>> switches, as all IOs are required to continue. But with a relatively
>>> small timeout, to allow switching to do other work etc.
>>
>> The question is if it's worth it to add support for "wait for these N
>> exact events", or whether "wait for N events" is enough. The application
>> needs to read those completions anyway, and could then decide to loop
>> if it's still missing some events. Downside is that it may mean more
>> calls to wait, but since the io_uring is rarely shared, it might be
>> just fine.
> 
> I think "wait for N events" is sufficient. I'm not even sure how one
> could safely use "wait for these N exact events", or what precisely it
> would mean.  All the usecases for min_complete that I can think of
> basically just want to avoid unnecessary userspace transitions if not
> enough work has been done to have a chance to finish its task - but if
> there's plenty results other than the just submitted ones in the queue
> that's also ok.

OK, that's exactly my thinking as well.

You could wait for specific events, but you'd have to tag the events
somehow to do that. I'd rather not add functionality like that unless
absolutely necessary, especially since this kind of functionality could
just be added to liburing if needed (or coded in the application
itself).

>> , but since the io_uring is rarely shared, it might be just fine.
> 
> FWIW, I think we might want to share it between (forked) processes in
> postgres, but I'm not sure yet (as in, in my current rough prototype I'm
> not yet doing so). Without that it's a lot harder to really benefit from
> the queue ordering operations, and sharing also allows to order queue
> flushes to later parts of the journal, making it more likely that
> connections COMMITing earlier also finish earlier.
> 
> Another, fairly crucial, reason is that being able to finish io requests
> started by other backends would make it far easier to avoid deadlock
> risk between postgres connections / background processes. Otherwise it's
> fairly easy to encounter situations where backend A issues a few
> prefetch requests and then blocks on some lock held by process B, and B
> needs the one of the prefetchted buffers from A to finish IO. There's
> more complex workarounds for this, but ...

Sharing is fine, as long as you mutually exclude reading the SQ and CQ
rings, of course. And if it makes it easier to do for queue ordering,
then by all means you should do that.

-- 
Jens Axboe

