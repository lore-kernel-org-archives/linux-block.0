Return-Path: <SRS0=UUXI=53=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C45C2BA19
	for <linux-block@archiver.kernel.org>; Sat, 11 Apr 2020 04:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C3420757
	for <linux-block@archiver.kernel.org>; Sat, 11 Apr 2020 04:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O3EvBYAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgDKEEU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Apr 2020 00:04:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46239 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgDKEEU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Apr 2020 00:04:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id q3so1880724pff.13
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2020 21:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nQvMpukNO/jhSN1Dfak56wDogQyph8/YlqBe2s+q9Yo=;
        b=O3EvBYAecnfGImdmby4Qbt1ENjJpYMO1t7rXq9OZY79NJKUbUUBgAlo7wZQaB5UsuU
         9EO+RQSuSYnaJq6jHkcsEOUXBy501G7w0yIDDV3S0+yQ4TXRJB+2eTQAV4EjUze12zrV
         wUBIFFQUQpweYQVW9eFUa1mMMYm/NePxY68LaOfz/uabXINOnymYOWiMnNw1coesnI2P
         02KGPRxFunnFGF47J6a/5Kc2L6vqBh8K0RT+wdXD9anX11YYVcNUhrRBfYmzcIryxxeQ
         s8NGkL80WfxnxrPN0165CZ/gFujs5sZYNcaIn1w2dXNUozVuytKtd9D/ycpKUoutm2nL
         oWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nQvMpukNO/jhSN1Dfak56wDogQyph8/YlqBe2s+q9Yo=;
        b=Vk4+388HcebGqQx9mukmQBjsaxZcfAQdcESADE9e4E+5UlWYT6r5L7mvp67ZQR894W
         OP6YNBO8AyqguauMtF/nS2Z77oAwW9Os+0fUtVTyds/dbpQALQOaf93eRcU4GyHtCL7H
         +0fumX6QsdaN8+HN6WcDfpbKxfifvl/7G0x+RwABbuLMc92hgXrG1wQmIE9vGKjXbL1U
         ZXIgIgezByreLhtdoEEP/KGknogMgQG8uty+yepJRTDI2iE8UMSNsOypmoZ3mSVUKsVq
         Mn+r7nhWnovyVVdgmhW8oDZ3TJVGmWX01Yo7ngeAQE324KOt8TEXshDRtdTUDqeoYllP
         pT8w==
X-Gm-Message-State: AGi0Pua+sH/xJoMTtwEgMb7KIRuQicw73DCIlplmWG0rzDrVT4sCqDFR
        W8WM9nyyEXY0/Bx+ypwwxAq997EcfcpIQg==
X-Google-Smtp-Source: APiQypJfXSCbRhZy/l+M2iD7TFSquu/abK+hhf3qBU/xl1QNKGr9Ok0ZTvvwvi9q5rQEcPfTeQ9jrg==
X-Received: by 2002:a62:2783:: with SMTP id n125mr8598113pfn.133.1586577859189;
        Fri, 10 Apr 2020 21:04:19 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i124sm3064826pfg.14.2020.04.10.21.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 21:04:18 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0d580c9a-be04-0b48-0594-17a0339df1b5@kernel.dk>
 <5b4a4f64-3a39-e1a6-6141-60436bb9249b@kernel.dk>
 <CAHk-=wgJVzsnWk+rODQjsq0vttQFA3yDE_f+YRMV5jtsC5qdsQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9686fd16-126a-4f52-e7c8-832991fb98bb@kernel.dk>
Date:   Fri, 10 Apr 2020 22:04:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgJVzsnWk+rODQjsq0vttQFA3yDE_f+YRMV5jtsC5qdsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/20 10:25 AM, Linus Torvalds wrote:
> On Fri, Apr 10, 2020 at 7:37 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> This one sits on top of the previous, figured that was easier than
>> redoing the other one fully.
> 
> It's actually easier for me if you remove the broken tag when you
> notice things like this (or use the same name for the fix tag and just
> force-update it).
> 
> And then send a "oops, me bad, I updated it" with the new pull data.
> 
> The reason: when I opened this thread, I didn't notice your follow-up
> at first, so I pulled the old tag, and so got the known-broken code.
> 
> And yes, I double-checked and caught it, unpulled and then re-pulled
> the fixed-up tag instead.
> 
> But if the wrong tag had been just overwritten or deleted, the extra
> steps wouldn't have been necessary.
> 
> Not a huge deal, it's not like it took me a lot of effort (it's more
> painful if I have to fix up conflicts twice, although even that isn't
> usually much of a bother since the second time I don't have to really
> analyze them again).
> 
> So just a heads up for "I wish you'd done X instead".

Noted! Since I sent out this pull yesterday and I knew I'd be away from
a keyborad all day today, I had to rush this followup pull this morning.
Normally I probably would have killed the branch and sent a new one.
Thanks for doing the right thing, and just pulling the new tag instead.

> Btw, on the subject of "I wish you had done X": this is not at all
> particular to you, and a lot of people do this, but pull requests tend
> to have the same pattern that we are trying to discourage in patch
> descriptions.
> 
> So in Documentation/process/submitting-patches.rst, we talk about this:
> 
>  "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>   instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>   to do frotz", as if you are giving orders to the codebase to change
>   its behaviour"
> 
> because once it's then accepted into git, the whole "this patch" kind
> of language doesn't really make much sense. It's much better to just
> describe what the change does, than say "this change does X".
> 
> The same is actually true when I merge your pull request, and I take
> the description from your email. Because the same way "This patch does
> X" does not make a regular commit message any more legible, the "This
> pull request does X" does not make sense in the commit message of a
> merge.
> 
> So I end up editing peoples messages a lot (and I occasionally forget
> or miss it).
> 
> Again, this is _not_ a huge deal, and I obviously haven't made a stink
> about it, but I thought I'd mention it since I was on the subject of
> "this causes me extra work".

I like it, I'll word my pull requests imperatively going forward.

-- 
Jens Axboe

