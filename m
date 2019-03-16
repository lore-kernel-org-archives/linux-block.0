Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283BFC10F03
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF156218E0
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tmuIeoDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCPQ1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:27:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45504 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCPQ1T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 12:27:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id 125so8487533pgc.12
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2019 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AA4pmMru0+BGpyqIaYKhd0wn45QUEyog2xvsO0lEbmA=;
        b=tmuIeoDdZ6kD/WBqxPlHyrAhWuqWoBo4OGvTShWwMb/v3B5RUicMQJGiBwJilifTeA
         H8AOWCRCH9TEiI2EqOrXXNd1a3zDOY/fkmTs7iuMg2WI2bGL3hLARyO+/cL1R3veW5FE
         XutHY25Vbp0P49t0bcG2w43q78ca1e8QfiqP30cncyCutJX13RUxBzOsZjymLSsnjZcs
         9c0aIyCK3aKJotF6l2CIH5oswsctWZJslpTzOuyzKCxQsXGW6FE26cqY0ratv+Wva6p5
         ftD4MEycGeVmQIDfgI5d2P/U34q+y8Tjt+ysFk5E2d/hY9l9d8/yhWHZG5GT780Cx9OO
         kKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AA4pmMru0+BGpyqIaYKhd0wn45QUEyog2xvsO0lEbmA=;
        b=kHl5U1D5JX9mdt5eKEq4VuhHyh3Jvl7eiaLUlw/4RG87aKUfXPrqjPpCSiCmxMDNFf
         7H95OMNjOKq18+1AxgMyMIlA26bmi3MqqU7Zm2l5gkDoOKXpj0fJYJx5uoBBpXug15qA
         a6aOhGkO3elwFAaJgL3TtNX6pjLy5rrLnvOfFBkwELESnIHgXVdphaNbDvIlvjn4qEMk
         FWobKDj9SBFOnhsEET5SYxgyIM6y93X4XcLS0AGUUNk1+NPBPsbzeow+5MJWVlwyLi+f
         m4YUNCSYlr3qqub+8aCcxzovwYNEootlGQJc+1eEo7vya3SE6aI/fQtA63/ZXp1xYO7k
         8t5A==
X-Gm-Message-State: APjAAAWyO5iCAm3vx0CEHsbh0/AqPGbv6uuBmmPOZgT1WqQepLWXVijA
        1caNOOrL2NsHr8e/Fo57fg8hUqE1I+TxkQ==
X-Google-Smtp-Source: APXvYqxpdI6cUgTaxcmbdzFaq+yC/Iuu9/FOIeAOm4rDebK191/Mmmsoyp/IjcS4p03NZZIzwN7oJQ==
X-Received: by 2002:a17:902:b70c:: with SMTP id d12mr10701196pls.88.1552753638506;
        Sat, 16 Mar 2019 09:27:18 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v22sm11620372pfa.49.2019.03.16.09.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 09:27:17 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: add io_uring_event cache hit information
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190315145938.21516-1-axboe@kernel.dk>
 <20190315145938.21516-4-axboe@kernel.dk>
 <aa0e7a3a-d7dc-2b6e-5a2c-adf99aab27a6@kernel.dk>
 <CAHk-=wg3iyLvh4L2us0WZc18UPKwFtZYA2L5h3OnP01a+T+59w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b294af4d-7df6-b5f3-cf93-3aa958b9ec8b@kernel.dk>
Date:   Sat, 16 Mar 2019 10:27:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg3iyLvh4L2us0WZc18UPKwFtZYA2L5h3OnP01a+T+59w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/15/19 7:34 PM, Linus Torvalds wrote:
> On Fri, Mar 15, 2019 at 9:27 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Linus, curious on your opinion on this one. I had this as part of the
>> original series, but removed it from the pull request due to the
>> mincore etc discussions.
> 
> I'd rather not have new ways to leak cache information, and in fact
> already the IOCB_NOWAIT is a bit questionable for that. But afaik, the
> non-O_DIRECT paths don't even support it to begin with for some
> filesystems.

For the most popular it works fine, though. For buffered async IO it'd
be nice to have it be fully reliable, so we can ensure we punt when we
have to. Currently for writes, we just ignore it and punt to async,
since it doesn't work at all there. The latter should be fixable.

On the hint, I hear ya, that's what I figured. I'll drop the patch for
now.

> Wasn't the whole point of this io_ring that we'd move *away* from
> direct block access and O_DIRECT?
> 
> I'm seeing a lot of stuff that looks like just "more of the same old
> O_DIRECT garbage" that seems to be all about thinking that IO doesn't
> cache.
> 
> Haven't we gotten over that already? It was one of the arguments you
> used for io_ring to begin with.

There are still folks that use it, even if O_DIRECT is nasty. If you
want to get peak performance, there's no way around it. That doesn't
mean that io_uring is in any way centered around O_DIRECT at all, it
isn't. At its core, it's "just" an efficient delivery mechanism for
submissions and completions.

Not sure what "stuff" you are referring to, the patches in this short
series? That's not centered around block devices at all, works just fine
for files. The bvec iterator is what io_uring uses for fixed buffers,
it's not exclusive to block devices at all.

-- 
Jens Axboe

