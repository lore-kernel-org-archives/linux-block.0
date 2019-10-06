Return-Path: <SRS0=GTOX=X7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507CEC4360C
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 15:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F30E2084B
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 15:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PW8wM3Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfJFPKu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:10:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37077 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfJFPKu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Oct 2019 11:10:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so4859713pgi.4
        for <linux-block@vger.kernel.org>; Sun, 06 Oct 2019 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VTB9f6IJy2LcNGekMROwzyeVfJPn/MtObPoZYk1R6VI=;
        b=PW8wM3Hy0t8VZowK6hzfE48qrkONH+JMKXfZfPJjkBLUzTULr+VVkAacREOmFUo3x0
         p8N9Az4r3ac35DKsDojmHWRLRmSuMgnr8rTouGatXrgbYWaOCd4tubJD4ddXCSyZcV8Z
         6q5hagOxroO8TRTh6fbN1jaVFrTJhwirsMns8AYZ9GS++TmLaKaX8E/W8k7hRPTf8cIo
         40Cdhk2o+sQ/duUZSO+f1phXbkk1OzcpeYqVIR7WBXSLW29l9tD83QhDe9FOyxqMNLtq
         JzDy8owRJb13Eb1eC+goJWliRmNDoM1hNM7jc8sbxT8GZryM0h8NZ68UO8cB5+dCkNhk
         GSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VTB9f6IJy2LcNGekMROwzyeVfJPn/MtObPoZYk1R6VI=;
        b=uE1ZsibMDgSjwUiUmHqteBnltb3SnBads5inligN4SKXAYddvHTXHOXf1f/EUbzxq1
         7Sibnf8eoeUvEHkDk7IyQNMRHejPkq9VpXSxFJY/GnjV3y5FFvw/mYo4xodCRtClpmun
         akJZCRVat4l8V2MeKve7MaUMqcf40RsEmKs+aSnfnGbn0mjxJ7CS6uesptya3K1MrxBL
         D9/yvubBUWm3zgQhn+1qo47rU6zyHygn6Uf/tq8tilR8rusqEyrnqPCuYJFY0ZAcy8VQ
         V4O9GJZqC3zo+E+FT1xaGTDZUjpPKT0FOrfoAGpZFzqmQETR2bb6VAFvORy1bo7mKe4h
         Tq4w==
X-Gm-Message-State: APjAAAWroskTA1MtRdmCWbCap/YLQkJIrntA7SrLKhYAXYoq2IRscsac
        9NvpmqsAKYEK2NhC6Xj5dIUcR8pxED8hFg==
X-Google-Smtp-Source: APXvYqxeZ3Nj2fUCCZBvNXjvzFmT0u238LTioNIfASlo4T2KNN36YwvPS0g5RHIcsnQO8xJXZELDDQ==
X-Received: by 2002:a63:1d0:: with SMTP id 199mr26294702pgb.329.1570374647054;
        Sun, 06 Oct 2019 08:10:47 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f6sm13178892pfq.169.2019.10.06.08.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 08:10:46 -0700 (PDT)
Subject: Re: packet writing support
To:     Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>,
        linux-block@vger.kernel.org
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
 <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
 <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
Date:   Sun, 6 Oct 2019 09:10:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/19 1:31 AM, Mischa Baars wrote:
> Hi Jens,
> 
> On Sat, 2019-10-05 at 09:50 -0600, Jens Axboe wrote:
>> On 10/5/19 4:12 AM, Mischa Baars wrote:
>>> Advised by the linux-next mailing list to repost this message on the linux-block mailing list:
>>>
>>> Hi,
>>>
>>> If I'm correct, packet writing support is going to be removed from the
>>> Linux kernel. Is there any particular reason for
>>> this, as far as you people know? Both DVD-writers and Blueray-writers are
>>> still being sold to date.
>>
>> The reasons are mostly that it's ancient technology and my doubt was
>> that nobody used it, and it's completely unmaintained code as well.
>>
> 
> How can it be ancient technology when CD-, DVD- and Blueray-writers
> are being sold by the thousands at this very moment? Floppy disk
> drives on the other hand were invented in 1967. This is the ancient
> technology you're looking for.

It's a suboptimal solution to the fact that devices were put to market
that required > page sized writes at the time. Hence pktcdvd sits in
between and ensures that we write out blocks that are big enough. If the
kernel supported > page size block sizes on file systems, pktdvd would
be superflous.

And please stops bringing up floppy, it's totally irrelevant to this
conversation.

>>> I'm currently working on quite a large project. I would be dependent
>>> solely on USB to store my backup files, when the packet writing support
>>> is removed. Actually I'm quite uncomfortable with that idea, because
>>> USB is rewritable. Any serious attempt to do damage to my project will
>>> result a permanent loss of code. Personally I would do anything to keep
>>> packet writing support in the kernel.
>>
>> If there are folks using the code (successfully), it's not going away.
>> But I can't quite tell from your email if you're just planning to use
>> it, or if you are using it already and it's working great for you?
>>
> 
> Yes, I've written the the code myself, thank you. It's prototype
> hardware and it's not intended as an open source software project. It
> is therefore not going to be released to the general public. When it's
> finished, and it isn't at the moment, it's hopefully going to be part
> of your future processors.

Let's keep this very simple:

1) Have you used the pktcdvd code at all? How much?
2) If yes to the first question, has it been stable?

> I did however find a enormous lot of bugs (in the kernel, the
> compiler, and in latex) since the project start, that deserve the
> attention of the opensource community. The bugs will come available to
> you in time. We can work on a better kernel and compiler together.

So bugs in pktcdvd? Or others parts?

>>> I'd hoped you could remove normal floppy disc support instead. That
>>> seems the more logical course of action. Floppy disc drives aren't
>>> being sold anymore for quite some years now.
>>
>> It's not really a case of quid pro quo, if someone gets removed,
>> something else can stay. I'd argue that the floppy driver is probably
>> used by orders of magnitude more people than the packet writing code,
>> and as such that makes it much more important to maintain.
>>
> 
> Who are you talking about? Are you asking to be removed? I'm afraid I
> don't quite understand.

I'm saying that you are comparing apples to oranges. The floppy driver
might be older tech, but it's much more used than pktcdvd. It's not the
case that we must pick one over the other, in terms of what stays and
what goes.

-- 
Jens Axboe

