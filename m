Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261EAC433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 23:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87E3207DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 23:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598052576;
	bh=LnKkunu6YU/iC8MnKHB0BOyiQ/t1K1tKn6ii9ijXXd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=byUAzSDtQ0BzO3AA9N3aLgfAayR3PPnGuXD6ENg7SL2xbJH5jeUaI+pxxZD2n4e2R
	 6GqOjEKNcoZf/6bfa+B4TGjWtqSkZNRPotQ5L3P7g4Z8+sDWNMPLhTmgthbutYQiLr
	 42WbyqUQHXkVZkzOzDCdb9As8URIHy4Swt/KPIbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHUX3f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgHUX3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 19:29:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB20C061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 16:29:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so3642723ljd.0
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRBt1fqVMElORp4VyzaO5q+l10Cmqkp/HTd2rr7hp/U=;
        b=QUKLAtr/tmuZ9nEKBJcWeHR5pXGTfBsot+kIsSed2eX3dDYH+V3fUgGy61qS+AH+pG
         KKCvnr6/j8c0qTcDuKBUf+Raw8kSQnKuoOsWWNa7yxst265tgotg2HAIgME6dq2fwYR2
         NBnd4eK5Ib3jdoCwLQukV/wH4RjNNrNYF1cFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRBt1fqVMElORp4VyzaO5q+l10Cmqkp/HTd2rr7hp/U=;
        b=Eje/XOMjwLpIK90H8ZYpebFGmcGEbBg9OUsQEOpLG5HTnzBkbZP7P0CpTwDr+PAs2r
         T3+20huhtNs2Y+ahb1DBTbk3mFLHfdvmrwuYa/UbQhSKKXZJekwCwVRQBuKq4Ae/ba+O
         cTH0RKLWV7ILRLUQhUxha7jORmw41LDE9DPHJAWXzFLVU/DPhlfCoPq2p4j9eIS6NiET
         DglZ+5UncLm/J1QFLmSIZPZGivFZp4UxYCvWydxIp0+9bJX6icKKuyh9DrKvmrxh+zkB
         mfx7tddguTWIa+BSTWJharK0E3PRhta3Dn804OuXlBCzx/ACFFcFDCO7mmYxwGHKESIK
         pjJg==
X-Gm-Message-State: AOAM533praTsoakcU5P1/bGaMhFIbJp3bygiYRyfGdWYounAV0gJau45
        L7m0rIwB6e2gDa4yGnLPbyBWnRfOP54lAg==
X-Google-Smtp-Source: ABdhPJy4waH1rUYd6sCFWbRXHAJW8zj3Eq6svzceMx7i+EjD28kvSvaTifTu1y/2KjG5uSSBF7SB2A==
X-Received: by 2002:a2e:80d8:: with SMTP id r24mr2439890ljg.305.1598052570920;
        Fri, 21 Aug 2020 16:29:30 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y9sm658473ljm.89.2020.08.21.16.29.29
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 16:29:30 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id t6so3593669ljk.9
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 16:29:29 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr2380149lju.102.1598052569489;
 Fri, 21 Aug 2020 16:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <2e213354-a1f8-cdb6-0f3c-24473a2a2ef8@kernel.dk>
 <CAHk-=wiFwUUEpCQ2FDWxBFb3XSxu=+yODHGfLPncvTQa9BeP9w@mail.gmail.com>
 <22fc2c2f-1ab9-6c57-df94-4768a64644e9@kernel.dk> <CAHk-=wg=CkBbPHVOjoaFWoACzm+7jWhBBzwmsw7y0EYcmseh0Q@mail.gmail.com>
 <7a221d34-6651-ba92-f074-c785fab70460@kernel.dk>
In-Reply-To: <7a221d34-6651-ba92-f074-c785fab70460@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 16:29:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgw1GQ3FOcLUgj1ZDG2RaACZFuC0CB9MHSTaFSVEdEPdg@mail.gmail.com>
Message-ID: <CAHk-=wgw1GQ3FOcLUgj1ZDG2RaACZFuC0CB9MHSTaFSVEdEPdg@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.9-rc2
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 21, 2020 at 4:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> The tree is totally warning clean right now on build, but that's usually
> not the case, and missing a single warning isn't that hard.

Actually, my tree is generally entirely warning-free and has been for
years, because I absolutely hate warnings.

You're not the only person I haven't pulled from because I saw a
single warning. This is the second one just this release window.  I'm
not singling you out. A warning to me is simply a hard "No".

Because I know very well that if there is even a single warning,
people will then ignore the other warnings.

So there is no such thing as a harmless warning - it doesn't matter
_what_ it warns about, it's a bad thing, because even one bogus
warning will then mean that people ignore warnings that _aren't_
bogus, and it goes all downhill from there.

So the reason I notice is exactly because I keep my build tree 100%
clean. I do allmodconfig builds that are entirely clean, and I check
it after each and every pull I do, and each patch series I apply.
Mistakes can happen, but I try _very_ hard to keep my tree clean.

Now, that said, I'll miss warnings too, because I don't do
cross-builds for other architectures, and I really only do a couple of
fairly basic configurations.

But perhaps more importantly - I don't build with a lot of different
compilers. I do in fact test two different compilers (both gcc and
clang), but I use two different configurations, so it's not really
overlapping testing, it's more that these days I make sure the clang
build is warning free at least for the core kernel too.

So "warning free" is always relative to some compiler base (and some
config base). But the baseline should absolutely be "zero warnings".

Generally, new warnings in my tree is because of a compiler upgrade or
similar congifuration issues.

And it's sadly the "different compilers" thing that then means that
*my* clean tree might not then necessarily be clean for others. It's
also why I can't just enable "-Werror" to make it harder to miss.

But I've been tempted. Many times. There's been a couple of times I've
added that "-Werror" to the Makefile, only to never commit it.

But if you have warnings that you see due to different compilers or
configurations, holler. We'll get them fixed.

                     Linus
