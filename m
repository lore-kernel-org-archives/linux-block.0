Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB20FC55191
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DE720776
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 20:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uAeBnTv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDWUN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgDWUN5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 16:13:57 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C228C09B043
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 13:13:57 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m18so8378089otq.9
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2rUn6OEE/SyUFvNfSs4xf0M3jM82iEbBd70o6oUd2c=;
        b=uAeBnTv9ZhEDHEM0R2gYPziVyPUzWcc2FZmKHluszWUeQZ+mlcnJNqx+toFeod+rG2
         5CtqzTIfz4EdeBuiId/090yid1X5A7Wl4mg8teizN+JkxYqU446/EKbttIrGvbCXSLY4
         tH4L7LN6h0n0BjbA9qqt2ovfOmTZDTphMD5L7tzI1e1nqOT7l1c2ZP4jBOKHerk8o+2u
         7Wcz5PX5oyRcYAec+aWyToiXprU9h0QgmqHWNfVR00m4ilAJ7k574PeLLCBKbD6wtKJ3
         Spw5vgab2z50d/5me4yy3csoIGoeL7v0BZdJIhy3gXOsc842o2ssePflinAKaP6Acq4y
         7kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2rUn6OEE/SyUFvNfSs4xf0M3jM82iEbBd70o6oUd2c=;
        b=eN3OfGXqMUwmv1YzeFC6PdbTWcNBSXEAu3q21wTmA6HUne+fn/7NgEpqoJ5z1rSPl7
         N63l5QV7oTg/84aruWlhcfITR5Uncy/828BhyF5R4nqY2IK/lOmTqsk/+tT3egB+gDSa
         FnPSv8MwdPDf+YK2pXcN7JGyiHg1PIT2kA4bkLToo3cxFJz/pf/zDNuAaVUVQCpRilMF
         q+cP+EeKv4dZwKnGeAV2ZqY4FIaExeOp5Xkxrf2VsIn0M1lOV9bfLYIojbtM/TfcGM14
         gB5URAQah9rbg4Sdaa65BGXIU+6tauTmM92j1ZvA0qXL1QplBOZznUJC/xedF4wl/FV+
         0lFA==
X-Gm-Message-State: AGi0PuYOnwBzMKh/zVkswtrb0uVYmyDKK16xLS2Anb4M2h9lXH8nPoli
        Exxg+rJNGsmQb2DaAky70LnuLbfm1X0rFrnwmF0N4A==
X-Google-Smtp-Source: APiQypJ5t6fji8Z2rpOwfgYmXZuKaiHhYHNgNK+IwyP9bjp4jWKiR46a48ICy6o3dAe/KAxDyKi5qjmcOvKfU/4ihq0=
X-Received: by 2002:a05:6830:23b5:: with SMTP id m21mr5146009ots.63.1587672836590;
 Thu, 23 Apr 2020 13:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200206101833.GA20943@ming.t460p> <20200206211222.83170-1-sqazi@google.com>
 <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org> <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
 <10c64a02-91fe-c2af-4c0c-dc9677f9b223@acm.org> <CAKUOC8X=fzXjt=5qZ+tkq3iKnu7NHhPfT_t0JyzcmZg49ZEq4A@mail.gmail.com>
 <CAD=FV=WgfAgHSuDRXSUWFUV8CB3tPq7HG0+E7q2fRQniiJwa1w@mail.gmail.com>
In-Reply-To: <CAD=FV=WgfAgHSuDRXSUWFUV8CB3tPq7HG0+E7q2fRQniiJwa1w@mail.gmail.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Thu, 23 Apr 2020 13:13:45 -0700
Message-ID: <CAJmaN=m4sPCUjS1oy3yOavjN2wcwhMWvZE9sVehySuhibTmABQ@mail.gmail.com>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Doug Anderson <dianders@chromium.org>
Cc:     Salman Qazi <sqazi@google.com>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, Bart, Ming, any update here?  Or is this already applied (I didn't check)?

Thanks,
Jesse


On Mon, Apr 20, 2020 at 9:43 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Feb 7, 2020 at 12:38 PM Salman Qazi <sqazi@google.com> wrote:
> >
> > On Fri, Feb 7, 2020 at 12:19 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On 2/7/20 10:45 AM, Salman Qazi wrote:
> > > > If I were to write this as a for-loop, it will look like this:
> > > >
> > > > for (i = 0; i == 0 || (run_again && i < 2); i++) {
> > > > /* another level of 8 character wide indentation */
> > > >      run_again = false;
> > > >     /* a bunch of code that possibly sets run_again to true
> > > > }
> > > >
> > > > if (run_again)
> > > >      blk_mq_run_hw_queue(hctx, true);
> > >
> > > That's not what I meant. What I meant is a loop that iterates at most
> > > two times and also to break out of the loop if run_again == false.
> > >
> >
> > I picked the most compact variant to demonstrate the problem.  Adding
> > breaks isn't
> > really helping the readability.
> >
> > for (i = 0; i < 2; i++) {
> >   run_again = false;
> > /* bunch of code that possibly sets it to true */
> > ...
> >  if (!run_again)
> >     break;
> > }
> > if (run_again)
> >     blk_mq_run_hw_queue(hctx, true);
> >
> > When I read this, I initially assume that the loop in general runs
> > twice and that this is the common case.  It has the
> > same problem with conveying intent.  Perhaps, more importantly, the
> > point of using programming constructs is to shorten and simplify the
> > code.
> > There are still two if-statements in addition to the loop. We haven't
> > gained much by introducing the loop.
> >
> > > BTW, I share your concern about the additional indentation by eight
> > > positions. How about avoiding deeper indentation by introducing a new
> > > function?
> >
> > If there was a benefit to introducing the loop, this would be a good
> > call.  But the way I see it, the introduction of another
> > function is yet another way in which the introduction of the loop
> > makes the code less readable.
> >
> > This is not a hill I want to die on.  If the maintainer agrees with
> > you on this point, I will use a loop.
>
> I haven't done a massive amount of analysis of this patch, but since I
> noticed it while debugging my own block series I've been keeping track
> of it.  Is there any status update here?  We've been carrying this
> "FROMLIST" in our Chrome OS trees for a little while, but that's not a
> state we want to be in long-term.  If it needs to spin before landing
> upstream we should get the spin out and land it.  If it's OK as-is
> then it'd be nice to see it in mainline.
>
> From the above I guess Salman was waiting for Jens to weigh in with an
> opinion on the prefered bike shed color?
>
> -Doug
