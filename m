Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E32FA3744
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 02:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiKACXT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 22:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKACXT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 22:23:19 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23572ADF
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 19:23:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g129so12271311pgc.7
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 19:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TPJSfKgUoXX526BXTxa2tP38ArUCqPS5TY4sJ/egLU=;
        b=03Ezfm67N+RdmFmQWi/Rh8WcSGs3I6+ZPFduRUzitDfURTwhwL9aIn8helvwWIW6sm
         W+9v3YnQIgDh4FMVE6Ev+Qr5fLplxjqywpckDLi71SE2Ssj7BbwbW9oFzc2uuVEq6JgK
         X4C83ZYAVz0T4+mTGzNzEZXTrOHpiYa8QOYdoW1MoeV7mDvQoHocgbEjOIQS0do7ivyX
         vn/fRzNGC27Mc9budhd1bAWo6jF3xcmrmqpzK0s7M9M1BEvNAPGEeaQBGeHLOMpUweeU
         EjWZrSm2SdgfWK/YlCqbKsZGE1qwFXVdhAQWZMxzT+lYgkSljuLtCG5vOIaxta68/pfB
         cACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TPJSfKgUoXX526BXTxa2tP38ArUCqPS5TY4sJ/egLU=;
        b=AdIe4i9hVNOqaUmPBDzfJzcBeO7/kDofE0Nwy/M+xIONem/UjhBfTAYa8feLUgo4IY
         WPYaokMeD7mIGfGwMbodJr6GgiXopZm0+5AzP1dOLs1q+dHQKT75vnB4EVe7HjVYqhWe
         UdPEJRyLKL1rnQTeKHhwP9+E8trsG2t57lODjJHSXp3xBY5De8ZSMaDXlZbMxUh3RzAm
         ggjrw8WHqZBJapSmS2de6voSFB/0iFsYvwLrbPHyRf021RNxq1rragKwXnsRljB6u9cJ
         vI/MaRXVqvtaN0nQkp8kM5WZ6Lr+L678epus/gcDBjVLMCHpiZDNORo8yTpP9A/fe+oq
         Sw9g==
X-Gm-Message-State: ACrzQf2R0mwisELcMuL2X5I8bvmUmHD+Luuz106o5geyDoYZAEFRRXuU
        ThzdGfxYuJnCjLVh8z8dnETZwXln2TnqOC7B
X-Google-Smtp-Source: AMsMyM7DeZI1VezTxK3eRv47KgMHOLWHUCx7IfURaEW85/J1nSg0sliyjX2ILlvsjqo+slpYyvObkQ==
X-Received: by 2002:a63:f74a:0:b0:46f:18bd:816f with SMTP id f10-20020a63f74a000000b0046f18bd816fmr15035791pgk.172.1667269397367;
        Mon, 31 Oct 2022 19:23:17 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d10-20020aa797aa000000b00561dcfa700asm5297865pfq.107.2022.10.31.19.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 19:23:16 -0700 (PDT)
Message-ID: <9d8b8db6-d890-5040-4fe9-5b89ec2d6649@kernel.dk>
Date:   Mon, 31 Oct 2022 20:23:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: UAF in blk_add_rq_to_plug()?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org
References: <Y2BIad98er4QsbZY@ZenIV>
 <1a46585b-878b-a3b7-3090-36bddba86dbd@kernel.dk> <Y2BbvIdYGM/4L66H@ZenIV>
 <8ae6352c-7880-b51c-004c-06835858a349@kernel.dk>
 <67fa977f-a490-4201-f56b-1e20d37c3863@kernel.dk> <Y2BuNekc14t35SpO@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y2BuNekc14t35SpO@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/22 6:54 PM, Al Viro wrote:
> On Mon, Oct 31, 2022 at 06:06:34PM -0600, Jens Axboe wrote:
> 
>>>> Am I missing something subtle here?  It's been a long time since
>>>> I've read through that area - as the matter of fact, I'm trying
>>>> to refresh my memories of the bio_submit()-related code paths
>>>> at the moment...
>>>
>>> With blk-mq, which all drivers are these days, the request memory is
>>> statically allocated when the driver is setup. I'm not denying that you
>>> could very well have issued AND completed the request which 'last'
>>> points to by the time we dereference it, but that won't be a UAF unless
>>> the device has also been quiesced and removed in between. Which I guess
>>> could indeed be a possibility since it is by definition on a different
>>> queue (->multiple_queues would be true, however, but that's also what
>>> would be required to reach that far into that statement).
>>>
>>> This is different from the older days of a request being literally freed
>>> when it completes, which is what I initially reacted to.
> 
> Got it (and my memories of struct request lifetime rules had been stale,
> indeed).  
> 
>>> As mentioned in the original reply, I do think we should just clear
>>> 'last' as you suggest. But it's not something we've seen on the FB fleet
>>> of servers, even with the majority of hosts running this code (and on
>>> VMs).
>>
>> Forgot to ask - do you want to send a patch for that, or do you just
>> want me to cook one up with a reported-by for you?
> 
> You mean, try and put together a commit message for that one-liner? ;-)

Right, thanks for doing that! Queued it up for 6.1.

-- 
Jens Axboe


