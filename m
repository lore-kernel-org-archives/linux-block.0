Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFD6C43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B81218DE
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Edz8a3h0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfABSOk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:14:40 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35908 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfABSOk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 13:14:40 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so39751358itj.1
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dgvwnnz+4oq3vAWuKt0IGvAqyDP1YNY6x7sVDvCtFAM=;
        b=Edz8a3h0h6YNqkBw49ujRQhiDkuj5YdsJBXPNJs5lFwyjVq4TFwtjyacNMEBCe5jB/
         V21l8WtjnXsHL77iOToQeS2NWJ9DDRBIyfqltnonidNQHz42989idlzaWNJn+b3xdC2S
         877G0GR7WKJI+n4qZ3HPKbQSU+bkUJqOO/t4iWm3/pD/aLmGm8/HNYyAcmGi7XXl2013
         KD0KckCubv7QnjN58yXnR+aHV2dIr48A/U8srUvMjTPztmL7/r3WQ1ArbSfQl80ROIWn
         +KEJaJjCpVLH/87wTZjURhhifL5ejp+A+8MHwxlR+TkOGvrZqmQ8GNXlronkwY20+kL7
         amzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dgvwnnz+4oq3vAWuKt0IGvAqyDP1YNY6x7sVDvCtFAM=;
        b=MvjW+ypdn8vrz1IUSpJg6N3H3NVgHcb64byJJ7Ua5iYP4/kB5OfmVbKORylJXFvm/i
         I1bPTj3269rEbEIysT+IHCVkJGfpQ7N+YN6DociT9Cth54od3AV3ZTNRybScKXK1fMtC
         9muGY2kJecaf5kpxbu/KOx3JJLHTdsRZLk5dNufmR+i2xmSwJAo0jP5MTAMpYVC5uwXC
         l0/iTF/a7mDay0vBUrFR1rN9C3z3rx1ZOUgJsXuBpSTg8s1hX3zyHP32skO7WLpKYHOz
         WTvTwcPGoAFDBjef2orOQoKEm4uGgBNICgvxcL2CMRQFQna4MJRfv3MQiDFIzJLvbLlG
         datg==
X-Gm-Message-State: AA+aEWbvGMVcK7iubSo8Y/RM53/1wIgowOyHNBS2EVVcEqsrjVoAWNWm
        W15JzrveOAMgZ8pZmtxCN3mQRQ==
X-Google-Smtp-Source: AFSGD/XxQqwAJBj3RnH4DPsSM/rQahNjO0xGVo2Bn4mV9CzE4NSSX947HYvkJqjpe/B0vgEfZTj+gQ==
X-Received: by 2002:a02:4c55:: with SMTP id a82mr30091648jab.29.1546452878850;
        Wed, 02 Jan 2019 10:14:38 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h139sm21870360ith.24.2019.01.02.10.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 10:14:38 -0800 (PST)
Subject: Re: block: only use __set_current_state() for polled IO
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <181e0aa7-34a5-5445-70b2-45770a81659d@kernel.dk>
 <CAHk-=wicNcMhY_YCkT5Nsdcxake8x+sfYUByvbhTzp2v-LWjeA@mail.gmail.com>
 <CAHk-=whcmNjH+3pP_tgKbxe3iNu20eVVxfDyVXrKsNf7HiR0WA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9d2da835-fe54-947a-85da-cedb4423bca0@kernel.dk>
Date:   Wed, 2 Jan 2019 11:14:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whcmNjH+3pP_tgKbxe3iNu20eVVxfDyVXrKsNf7HiR0WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/2/19 11:11 AM, Linus Torvalds wrote:
> On Wed, Jan 2, 2019 at 10:07 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Stop this craziness. The optimization is garbage. If you want to save
>> 15 cycles, get rid of code, don't add new code in an area where the
>> block maintainers have already shown that they can't get it right.
> 
> Side note: that argument is further strengthened by a very simple
> observation: if the code isn't going to sleep, then the whole state
> setting is entirely and utterly pointless.
> 
> So code like this:
> 
> +                       if (is_poll)
> +                               __set_current_state(TASK_UNINTERRUPTIBLE);
> 
> is *FUNDAMENTAL* garbage.
> 
> Seriously, stop playing stupid games. You're doing things wrong.
> 
> I'm doing to revert that buggy commit, and I will not pull any crazy
> code that tries to redo this kind of completely broken code.

Note that the blk-mq hunk is fine, since that's ONLY used for polling.
We should get rid of the state setting there completely though, which is
something we can do now that polling is strictly a non-IRQ type of IO.

The swap part may fall back to non-polled, so better safer than sorry on
that one.

-- 
Jens Axboe

