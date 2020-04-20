Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB6C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 16:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2DA720B1F
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 16:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/+0d9rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDTQnF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbgDTQnE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 12:43:04 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388C7C061A0C
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 09:43:04 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id f7so614322vkl.6
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wfQZpU1iI1W+9vUazFL8ggsPgPoMXhj1yc+iZAGVvU=;
        b=W/+0d9rwb/nWJkvnAmRWlU6TQZcm39G3hJCW0eq+m8LkMuHRjF/LuQ0FrI01XDpGsR
         q8vpSxItKzuEVk/3dJdfK8awZDCrXHT1C9MYqAcoJUrpdAyNUqut4npO8hJImjb/bfNv
         Q4TEPuPqY//QFKOAIP6124jXGPGAqMBMer3ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wfQZpU1iI1W+9vUazFL8ggsPgPoMXhj1yc+iZAGVvU=;
        b=I3/vysOsMaSX5p+LcWq2RjBVw9tmx620/bUXCqtGFvd8rI6BGlXaPogkayAa52rFng
         4N0E+kXxoeI0SYMsDbyfkw6qhvJgXmlLrMHG7g4H1Tnx1TAgxLt+lCa/fUF6o0yipd+T
         lBta1x4MSAUS0bIGw7UBQHa088zrId4or2mcvV3P4UUzN0H4YT586tTsAdM/QO3YFbV1
         TwnpvSSAaQH0eJvoqNbhSCM50M5ZUeUnEJKCfBav+y6K7jBqYOPN4BeaW9d/FQ2JIGtl
         K+CY3j/qWzQux/AUnHd6wZnRRHwJosBS/6PbIAXP4jfCcy+9CKhip419xn9GKEtjkDSz
         23sw==
X-Gm-Message-State: AGi0PuZvLVML4XD62l5gRmTfq1xcxt7SvQpP27/ts2PHp/qu6XGvkwPk
        x5LAKT/O17LTUyHExR0Y/SmV8jE3/0g=
X-Google-Smtp-Source: APiQypKijb97z/uOVrAWcbjdXwl71ojrcYSCw8vhVWsgMOuzqYJyWhvPrQKuAGdYUX9plTl5JgvE4A==
X-Received: by 2002:a1f:3210:: with SMTP id y16mr11847573vky.89.1587400982752;
        Mon, 20 Apr 2020 09:43:02 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id o130sm341280vke.28.2020.04.20.09.43.01
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 09:43:01 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id r7so6452236vso.2
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 09:43:01 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr2547643vsk.106.1587400980801;
 Mon, 20 Apr 2020 09:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200206101833.GA20943@ming.t460p> <20200206211222.83170-1-sqazi@google.com>
 <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org> <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
 <10c64a02-91fe-c2af-4c0c-dc9677f9b223@acm.org> <CAKUOC8X=fzXjt=5qZ+tkq3iKnu7NHhPfT_t0JyzcmZg49ZEq4A@mail.gmail.com>
In-Reply-To: <CAKUOC8X=fzXjt=5qZ+tkq3iKnu7NHhPfT_t0JyzcmZg49ZEq4A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 Apr 2020 09:42:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WgfAgHSuDRXSUWFUV8CB3tPq7HG0+E7q2fRQniiJwa1w@mail.gmail.com>
Message-ID: <CAD=FV=WgfAgHSuDRXSUWFUV8CB3tPq7HG0+E7q2fRQniiJwa1w@mail.gmail.com>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Salman Qazi <sqazi@google.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Fri, Feb 7, 2020 at 12:38 PM Salman Qazi <sqazi@google.com> wrote:
>
> On Fri, Feb 7, 2020 at 12:19 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 2/7/20 10:45 AM, Salman Qazi wrote:
> > > If I were to write this as a for-loop, it will look like this:
> > >
> > > for (i = 0; i == 0 || (run_again && i < 2); i++) {
> > > /* another level of 8 character wide indentation */
> > >      run_again = false;
> > >     /* a bunch of code that possibly sets run_again to true
> > > }
> > >
> > > if (run_again)
> > >      blk_mq_run_hw_queue(hctx, true);
> >
> > That's not what I meant. What I meant is a loop that iterates at most
> > two times and also to break out of the loop if run_again == false.
> >
>
> I picked the most compact variant to demonstrate the problem.  Adding
> breaks isn't
> really helping the readability.
>
> for (i = 0; i < 2; i++) {
>   run_again = false;
> /* bunch of code that possibly sets it to true */
> ...
>  if (!run_again)
>     break;
> }
> if (run_again)
>     blk_mq_run_hw_queue(hctx, true);
>
> When I read this, I initially assume that the loop in general runs
> twice and that this is the common case.  It has the
> same problem with conveying intent.  Perhaps, more importantly, the
> point of using programming constructs is to shorten and simplify the
> code.
> There are still two if-statements in addition to the loop. We haven't
> gained much by introducing the loop.
>
> > BTW, I share your concern about the additional indentation by eight
> > positions. How about avoiding deeper indentation by introducing a new
> > function?
>
> If there was a benefit to introducing the loop, this would be a good
> call.  But the way I see it, the introduction of another
> function is yet another way in which the introduction of the loop
> makes the code less readable.
>
> This is not a hill I want to die on.  If the maintainer agrees with
> you on this point, I will use a loop.

I haven't done a massive amount of analysis of this patch, but since I
noticed it while debugging my own block series I've been keeping track
of it.  Is there any status update here?  We've been carrying this
"FROMLIST" in our Chrome OS trees for a little while, but that's not a
state we want to be in long-term.  If it needs to spin before landing
upstream we should get the spin out and land it.  If it's OK as-is
then it'd be nice to see it in mainline.

From the above I guess Salman was waiting for Jens to weigh in with an
opinion on the prefered bike shed color?

-Doug
