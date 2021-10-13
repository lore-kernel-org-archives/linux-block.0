Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07541C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4566113D
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJMQgG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbhJMQf7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:35:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E67C061753
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:33:54 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r9so344515ile.5
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLPfPhdwhZ9OXQBzUpdrrhybZne9QryrMckKwVROE+Q=;
        b=oLolT3r7/8w1fx6pvKyJeYGe0ysMrJYJwROZFbWV3b1D9HMXflnHGVRRx6nlpaYUaA
         AlQYvN8ew1tQEXoeBurT8+sMdvS3l8pPRg05+9Cc46SsgEuDiajLN5At40cRRzYy10yi
         XNXUtV36Ryr7flBS8SZWyOmDUUGbwwiwJkJu0XxUd12ukM5X6gQX7fWRSqzNLPt8vhqP
         LFOJmXlSLkbZZ9IxzmMimOHlfDGX9hsUIfcpmd0pllL1tHEXvIxpX/sLRa4SlE0qmDyv
         0J3pEne2MDJijPX4w1e4FE0vb+tOV/qIEmO3dWIsnA6H4vERdfUf7QZfgzqQfEH21v2x
         52Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLPfPhdwhZ9OXQBzUpdrrhybZne9QryrMckKwVROE+Q=;
        b=S+gxYvcTLcn5ggrTytUlFZe77H/r46umgC7spTOsOmG9baTQ6jAOYNSXOppL/HdDzN
         TQVmZnPzPXGp3YA8XQy6FLWy2u7V+yj7XYi4OCe1+9/6bUK1mXtRaIg4abwxNQREnJEw
         H7dTLYN3vdrl5TwP+M6h4U+1fOYiVgDTtf9FOVhoilP+Z+v25ixUZ/wsU1h+o+1YpMmr
         aCy3znPldV+x4rEJx/66YFeahBrDhx4cJD24mpZu2cgDVcrNZYcL1O6LeHN35XFGZrMN
         JWw2mE8mJI2mgX3sLNFYMRqEF+enazGy55aWnUpZkCqYqNK48L0cTKWNlGr+MQ3uhNEV
         uL9w==
X-Gm-Message-State: AOAM5330Dj4BUNAO7Rg5Uq1GttwDSkixF9h1pGdoa9zUo+9A31nTiGbQ
        qAUauwweY1gYE0ToVx/cgdwa+WR9K3/Y1w==
X-Google-Smtp-Source: ABdhPJyhkqAUtIhUs3t6WxJZtussiI5yFhHJk78C1rC7FcESYtQh/cCbwSdevCxrRTJpJjCD1YT2UQ==
X-Received: by 2002:a05:6e02:164e:: with SMTP id v14mr39476ilu.320.1634142833650;
        Wed, 13 Oct 2021 09:33:53 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o1sm9896ilj.41.2021.10.13.09.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 09:33:53 -0700 (PDT)
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk> <YWaGB/798mw3kt9O@infradead.org>
 <03bccee7-de50-0118-994d-4c1a23ce384a@kernel.dk>
 <YWb4SqWFQinePqzj@infradead.org>
 <e3b138c8-49bd-2dba-b7a0-878d5c857167@kernel.dk>
 <YWcAK5D+M6406e7w@infradead.org>
 <9456daa7-bf40-ee85-65b5-a58b9e704706@kernel.dk>
 <YWcFmHnnk1dGigO9@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <31678b19-30d0-c103-da88-e1b3fa073dd1@kernel.dk>
Date:   Wed, 13 Oct 2021 10:33:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWcFmHnnk1dGigO9@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 10:13 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 10:04:36AM -0600, Jens Axboe wrote:
>> On 10/13/21 9:50 AM, Christoph Hellwig wrote:
>>> On Wed, Oct 13, 2021 at 09:42:23AM -0600, Jens Axboe wrote:
>>>> Something like this?
>>>
>>> Something like that.  Although without making the new function inline
>>> this will generate an indirect call.
>>
>> It will, but I don't see how we can have it both ways...
> 
> Last time I played with these optimization gcc did inline function
> pointers passed to __always_inline function into the calling
> function.  That is you can keep the source level abstraction but get the
> code generation as if it was open coded.

Gotcha, so place nvme_complete_batch() in the nvme.h header. That might
work, let me give it a whirl.

-- 
Jens Axboe

