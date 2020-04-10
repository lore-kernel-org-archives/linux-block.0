Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475BFC2BA2B
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3142082D
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586539551;
	bh=gMsgf+mPrscPDjPeT64seFb1C+LIp4FQZIXDNhOZKxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FFIGI7IqSOEh42ansofHqAicldg/T3YRluBzf6IktASlpJG4oeGgIGMuGp3sZpEDe
	 PwpDlJ35cRPSXhngsqiBw2XbHOynA1HWGjoTKIobELbChtMZzTMgrhM1/DrfkZh7UQ
	 fcL9UPdTQUxr3pK+w7Zpvq6T+N8PjPEF54sxsI1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDJRZt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:25:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44020 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJRZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 13:25:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id h25so2608000lja.10
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2020 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63z8uesHw50wncbdPpJePfwpQBMo6/HeDdjArBZqF5E=;
        b=a5CsMlVrxIFDHgrwAIZU/oCwKV8m9AibR7bKK3oL4RHsXeOPq5i51mhEufjjkuUmDD
         /i3vtU9SPvc/ZSZMvg2voxsX5Eub4yc+nS0ds6DqQaTLkDBJQrL3H6tgVlAWSEFF2Dww
         SSIXPcTf88y9nI+crYoOtxSs5PukbaMH5g5pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63z8uesHw50wncbdPpJePfwpQBMo6/HeDdjArBZqF5E=;
        b=qwjL8doNJ6qffTch0JB8WLt7+KAds1KpwDUmZ2rNowA3pqZrzjn7+mdKcUSAXvlf7z
         JPh0TpGuewAMD9ociUWrrR++Aj5y167qx/2XrmlaYuk9uPGhYiUeUR8RJ5Lch6gQB6/p
         oVWVQpqM/f2uDP1PpWHwlVKKFCpjWjeBFJgsgu1pD5ysbH50sZNAPVxD3V/Mllz3vIFr
         52qi7zXrfJ4syU6wwsd/ycY0ZzNzoz2YNUsZWbQQyJVUp0b6kZcqAg750LpFkzdpVJ7M
         7i1EIEfp3pTILTX1xbhVkQ1+klSX9FM3539upAglRzOBW/Unew7bUN04xdb5mj81rona
         Qoqw==
X-Gm-Message-State: AGi0Pua1HNb58RcfSZe1qghPcHcp09AbuLgOlKlfl637J8PqbDxpXapX
        497vdJz/aOGEogmo6BysCIkRkah4S5Y=
X-Google-Smtp-Source: APiQypK4RTtNFT9NQgQCAq/5htg9nnPGGnAe/memQelqay5b4kkdrEeBZ+LQ/2HuU6qHLa57ggWZiw==
X-Received: by 2002:a2e:5048:: with SMTP id v8mr3257937ljd.99.1586539547818;
        Fri, 10 Apr 2020 10:25:47 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id g5sm1407634ljl.106.2020.04.10.10.25.46
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:25:46 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id r7so2590794ljg.13
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2020 10:25:46 -0700 (PDT)
X-Received: by 2002:a2e:b619:: with SMTP id r25mr3651937ljn.150.1586539545949;
 Fri, 10 Apr 2020 10:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <0d580c9a-be04-0b48-0594-17a0339df1b5@kernel.dk> <5b4a4f64-3a39-e1a6-6141-60436bb9249b@kernel.dk>
In-Reply-To: <5b4a4f64-3a39-e1a6-6141-60436bb9249b@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Apr 2020 10:25:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJVzsnWk+rODQjsq0vttQFA3yDE_f+YRMV5jtsC5qdsQ@mail.gmail.com>
Message-ID: <CAHk-=wgJVzsnWk+rODQjsq0vttQFA3yDE_f+YRMV5jtsC5qdsQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.7-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 10, 2020 at 7:37 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> This one sits on top of the previous, figured that was easier than
> redoing the other one fully.

It's actually easier for me if you remove the broken tag when you
notice things like this (or use the same name for the fix tag and just
force-update it).

And then send a "oops, me bad, I updated it" with the new pull data.

The reason: when I opened this thread, I didn't notice your follow-up
at first, so I pulled the old tag, and so got the known-broken code.

And yes, I double-checked and caught it, unpulled and then re-pulled
the fixed-up tag instead.

But if the wrong tag had been just overwritten or deleted, the extra
steps wouldn't have been necessary.

Not a huge deal, it's not like it took me a lot of effort (it's more
painful if I have to fix up conflicts twice, although even that isn't
usually much of a bother since the second time I don't have to really
analyze them again).

So just a heads up for "I wish you'd done X instead".

Btw, on the subject of "I wish you had done X": this is not at all
particular to you, and a lot of people do this, but pull requests tend
to have the same pattern that we are trying to discourage in patch
descriptions.

So in Documentation/process/submitting-patches.rst, we talk about this:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour"

because once it's then accepted into git, the whole "this patch" kind
of language doesn't really make much sense. It's much better to just
describe what the change does, than say "this change does X".

The same is actually true when I merge your pull request, and I take
the description from your email. Because the same way "This patch does
X" does not make a regular commit message any more legible, the "This
pull request does X" does not make sense in the commit message of a
merge.

So I end up editing peoples messages a lot (and I occasionally forget
or miss it).

Again, this is _not_ a huge deal, and I obviously haven't made a stink
about it, but I thought I'd mention it since I was on the subject of
"this causes me extra work".

           Linus
