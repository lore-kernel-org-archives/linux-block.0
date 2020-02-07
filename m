Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4641C2BA83
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 20:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDD7222C2
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 20:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0AXpVHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBGUiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:38:11 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35247 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGUiK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Feb 2020 15:38:10 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so700769ild.2
        for <linux-block@vger.kernel.org>; Fri, 07 Feb 2020 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dg4oON5J4q1fP44KHqOQveBtLzhE62D/XRXrye9zUFs=;
        b=H0AXpVHi3OoVTO5fMc/MD/deUKtMKczIoMcgUbYSgxYbrqJgdaHtDiU4YpHoR6SOQo
         ANzA42tykPyEQj6LIC+i+fKdwMEG7htXYQMrFnRkY+U8kTKi4GtgpLOfC/S92/LLUmzT
         H2IWFt8QKHw6JLdIu44Eq2stfN3FbZ4RU/vKyQszPtE2ujYpQfC411+6tlpTBOkEnc8R
         j9qUeuO76mFpi4ryetJraTCoBySQVeOqlGm3JKDYcstbMH+qbtBTGy16AwrE/4fvl8Uw
         prWpNBk8XfObuiJbH75+YPZQ39M85395DyhxR61gWaeBVnfMpFvt6ILxcSw+3YGlVbxu
         xc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dg4oON5J4q1fP44KHqOQveBtLzhE62D/XRXrye9zUFs=;
        b=VfTN9MNO1Iu1W9bhayVwF6fB8Pct3y3bpYXw3Zs5VT3GMuu9J14s5t0sVakhXQgXcS
         3saoObFZvO8emI4gvMe9ntEhR+Kdm09pp9cOMMzlbbW7nD9QR/q3895IBfEbZdye8ayP
         PIYgam/dMRD0lhRIxOW12elyb5wngeCflX6goIJkZ8EyvXgeJrzv/dFHaIlfpn6czVA6
         bm+GXgpEoCWMtNw3D3m/mW3y3oY6zG9N6pZCA0+ggL8UTIxjwRsUEgl7O9XZwYP0xGmN
         UdXCxygZVFmFuy4/u9+Gr+5eH6WT/bV6oJWHdIjdOHJ9Tx4cEUvJo0CMv9iVe+dxotEK
         dR0Q==
X-Gm-Message-State: APjAAAUr0htQGpviSPXrhgBii3twpqfBuJwnySMuPpFDz2cUe9wMFBQr
        kX2g9n4aH/rzUdaoeSAK2Y5t86vAYSFX7h1CBM+4XA==
X-Google-Smtp-Source: APXvYqyTqUEaeiRszM4nM+OgnMVDTccPNheMsyBNPQIZ4n7gi3IrYrOGJJCZk5Op6+0SWXNMyDf3QEdg9TZqFqZVb4E=
X-Received: by 2002:a92:af99:: with SMTP id v25mr1287002ill.289.1581107888526;
 Fri, 07 Feb 2020 12:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20200206101833.GA20943@ming.t460p> <20200206211222.83170-1-sqazi@google.com>
 <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org> <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
 <10c64a02-91fe-c2af-4c0c-dc9677f9b223@acm.org>
In-Reply-To: <10c64a02-91fe-c2af-4c0c-dc9677f9b223@acm.org>
From:   Salman Qazi <sqazi@google.com>
Date:   Fri, 7 Feb 2020 12:37:56 -0800
Message-ID: <CAKUOC8X=fzXjt=5qZ+tkq3iKnu7NHhPfT_t0JyzcmZg49ZEq4A@mail.gmail.com>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 7, 2020 at 12:19 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/7/20 10:45 AM, Salman Qazi wrote:
> > If I were to write this as a for-loop, it will look like this:
> >
> > for (i = 0; i == 0 || (run_again && i < 2); i++) {
> > /* another level of 8 character wide indentation */
> >      run_again = false;
> >     /* a bunch of code that possibly sets run_again to true
> > }
> >
> > if (run_again)
> >      blk_mq_run_hw_queue(hctx, true);
>
> That's not what I meant. What I meant is a loop that iterates at most
> two times and also to break out of the loop if run_again == false.
>

I picked the most compact variant to demonstrate the problem.  Adding
breaks isn't
really helping the readability.

for (i = 0; i < 2; i++) {
  run_again = false;
/* bunch of code that possibly sets it to true */
...
 if (!run_again)
    break;
}
if (run_again)
    blk_mq_run_hw_queue(hctx, true);

When I read this, I initially assume that the loop in general runs
twice and that this is the common case.  It has the
same problem with conveying intent.  Perhaps, more importantly, the
point of using programming constructs is to shorten and simplify the
code.
There are still two if-statements in addition to the loop. We haven't
gained much by introducing the loop.

> BTW, I share your concern about the additional indentation by eight
> positions. How about avoiding deeper indentation by introducing a new
> function?

If there was a benefit to introducing the loop, this would be a good
call.  But the way I see it, the introduction of another
function is yet another way in which the introduction of the loop
makes the code less readable.

This is not a hill I want to die on.  If the maintainer agrees with
you on this point, I will use a loop.
>
> Thanks,
>
> Bart.
