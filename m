Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21785C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 20:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BBB61002
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 20:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbhHDUMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbhHDUM3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 16:12:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B62C0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 13:12:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f42so6499710lfv.7
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sahklOmuEWNKGHdHX0TfbNlW0MEZnmzRkOffEEIf8Zg=;
        b=RBNOcGPiP0Tn2LCxIxQy3MCJV4xnMx2Bve+Q5ATjwz8evRElxC7yfTfdMiL2NXb2Iv
         Ffx4IWqpeE13/vv/zz8Vlc0A1isK2sj4QhG0E+5tSga50RWMCXvu5U5ABqhbaIQyTtuB
         RFVNLsQvbKmyRfVvkpKzIEGVm48rk5eJ5LI2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sahklOmuEWNKGHdHX0TfbNlW0MEZnmzRkOffEEIf8Zg=;
        b=sxwr0KlEkBRH5VgNd6PYHlO+ijMCBUZZZHRx73ygVT0MvaihwsycQeM7UqZaIEMyXK
         7ejXIwXubhLvob2aNeCCtLTilEvIUS4zJQPYqvNcEy7h6ZlcRiG21L0ci/CFc9OiRu9s
         OcfFTPCIOG0DOMXG71cna0NQdtgoYxMfssita7p6cq16Bi1e/zftLrXF37voWdx9yBca
         SbBh2RwkPKwsOiWhn2crEAFn2sdFnNa7beKnW99L7sWGm9tTmmP6xi0DdEN0YlYihupy
         Qnx/lhQUB2ukDpENoK9isIz/BQSVgRjxO0qhY4H1mC4A3enaor+GqN2tjAvABsA26xgV
         bvHw==
X-Gm-Message-State: AOAM53322fpBLq8RfoSaI5Rkqw8szxk8411TVHU9SCmIZLgkvd8ylNwt
        X21Xl1Lrj6KKJCztjdeXs1t/kjwucYOzYZdov68=
X-Google-Smtp-Source: ABdhPJwcrtOiMn+N/mGkRhSTAuNdXLf/wGPmcNgOlvYWNIJsfMmMshIKfZ62cjMx2/F5FbXL4T5SPQ==
X-Received: by 2002:a05:6512:3b91:: with SMTP id g17mr712602lfv.77.1628107933533;
        Wed, 04 Aug 2021 13:12:13 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id n15sm97718lfi.18.2021.08.04.13.12.13
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 13:12:13 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id f42so6499671lfv.7
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 13:12:13 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr670782ljh.61.1628107480111;
 Wed, 04 Aug 2021 13:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <1628086770.5rn8p04n6j.none.ref@localhost> <1628086770.5rn8p04n6j.none@localhost>
 <CAHk-=wiLr55zHUWNzmp3DeoO0DUaYp7vAzQB5KUCni5FpwC7Uw@mail.gmail.com> <1628105897.vb3ko0vb06.none@localhost>
In-Reply-To: <1628105897.vb3ko0vb06.none@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Aug 2021 13:04:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioi2+dfni1Sx2_Js_WmcgHKtzPUSDkhZ4uo0P6Qe0z+A@mail.gmail.com>
Message-ID: <CAHk-=wioi2+dfni1Sx2_Js_WmcgHKtzPUSDkhZ4uo0P6Qe0z+A@mail.gmail.com>
Subject: Re: [REGRESSION?] Simultaneous writes to a reader-less, non-full pipe
 can hang
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     acrichton@mozilla.com, Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        keyrings@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 4, 2021 at 12:48 PM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> I agree that if this only affects programs which intentionally adjust
> the pipe buffer size, then it is not a huge issue. The problem,
> admittedly buried very close to the bottom of my email, is that the
> kernel will silently provide one-page pipe buffers if the user has
> exceeded 16384 (by default) pipe buffer pages allocated.

That's a good point.

That "fall back to a single buffer" case is meant to make things
hobble along if the user has exhausted the pipe buffers, but you're
right that we might want to make that minimum be two buffers.

I didn't test this, but the obvious fix seems to be just increasing
the '1' to '2'.

  @@ -781,8 +784,8 @@ struct pipe_inode_info *alloc_pipe_info(void)
          user_bufs = account_pipe_buffers(user, 0, pipe_bufs);

          if (too_many_pipe_buffers_soft(user_bufs) &&
pipe_is_unprivileged_user()) {
  -               user_bufs = account_pipe_buffers(user, pipe_bufs, 1);
  -               pipe_bufs = 1;
  +               user_bufs = account_pipe_buffers(user, pipe_bufs, 2);
  +               pipe_bufs = 2;
          }

          if (too_many_pipe_buffers_hard(user_bufs) &&
pipe_is_unprivileged_user())

although a real patch would need a comment about how a single buffer
is problematic, and probably make the '2' be a #define to not just
repeat the same magic constant silently.

IOW, something like

  /*
   * The general pipe use case needs at least two buffers: one
   * for data yet to be read, and one for new data
   */
  #define DEF_MIN_PIPE_BUFFERS 2

to go with the existing PIPE_DEF_BUFFERS (although the
DEF_MIN_PIPE_BUFFERS use would only be in fs/pipe.c, so I guess it
doesn't actually need to be exposed to anybody else in the pipe.h
header file).

I'd take that patch with some proper testing and a commit message.

Hint hint ;)

                Linus
