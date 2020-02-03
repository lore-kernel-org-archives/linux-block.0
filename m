Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3161C35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 20:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897EB2086A
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 20:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+hJJMEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgBCUZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:25:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41136 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCUZG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 15:25:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so14919587otc.8;
        Mon, 03 Feb 2020 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63jW789sY3VX7ra4EKkFoe9ytZPPkm7N/YVQQ2sxOY8=;
        b=W+hJJMEvibBQG+2lpzi0dxIHmJ4geJ67wEvz/1FJ+pZdxfv+B5J+7vbjefvy9MNDyq
         Ae/32M22wmqs8GKnWhcRLh95ObdACtQ3B/JZJqZV0yr/cl0O5F+G+Kt4zAmwA+h4AO34
         wWX/7yQSfK5XjAE2C3Q/Esgl95vPdtAcegYIYluUMpLbuHoaxbtiIZyL0YT8mergG2wi
         qejT/jl+CRmsDP+SipknbOnSEgL+bPpSVt00D95tVC5uCFfZ0BoZrLyDp/oLzrtY7Oe0
         hRF6TQ7MeJ97OcgT7pHIIbUgzEbWa0MtT60OOhwxIpf2Xsv+AEnNVx8WY+gdhdWLHq7s
         Jc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63jW789sY3VX7ra4EKkFoe9ytZPPkm7N/YVQQ2sxOY8=;
        b=sa1RJdqzUbSpTzL9oah2RW1yf+N2ddLu3EuGxsMa8dBU7Trcg2/d5V2xTJGWlacUsC
         JSqUgrEtY1hFdX7vx9luRapgsBO9ju0pJZHKNdhJyISjX2enGDQtLxy0wnxiUtY57z45
         Lg4acjsDcgyQS6y6VnVrJFBYWtas2mtSYVwGQwGWzbDm/E5tlTqE9q1ETPe7W7jEtz4x
         D3MHROexy4URTUpH95jOFJ63TGXbeNZr1xR4D0omnoSlEGsKCGBTy4edShfrU2hzOAyh
         lJHIcJkKa0pu9FJBRdvs+cWSqiPQpN4eNyCVLJX7KHQJJNQXZgrgQAtSAvWcTeTNrHlS
         nwvw==
X-Gm-Message-State: APjAAAXzRIX+PIRG02YEARWzTIYP+UsQ1E8EnJjEFOReUUlp8IjnnW7k
        QF/E2dTL9rPWigOK9/ha+1IDn4R7qAdk477KuPtVSnItYAA=
X-Google-Smtp-Source: APXvYqz749Gp2eVOjp3OKWbBZmqTr1A+exIdvRSQ0Y1gXfDajC+2fhpFda8/gI0SnpoqPyiVEvpAg6Wc/t8gPPyZmBI=
X-Received: by 2002:a9d:67cc:: with SMTP id c12mr13084936otn.319.1580761505743;
 Mon, 03 Feb 2020 12:25:05 -0800 (PST)
MIME-Version: 1.0
References: <20200203053650.8923-1-xiyou.wangcong@gmail.com> <20200203132638.5a37f2f2@oasis.local.home>
In-Reply-To: <20200203132638.5a37f2f2@oasis.local.home>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 3 Feb 2020 12:24:54 -0800
Message-ID: <CAM_iQpXz+O-GHqotZiGC4FgvgcvNHkFg4QFH8_t4j8pHgvAD2Q@mail.gmail.com>
Subject: Re: [Patch v3] block: introduce block_rq_error tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 3, 2020 at 10:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun,  2 Feb 2020 21:36:50 -0800
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> >  block/blk-core.c             |  4 +++-
> >  include/trace/events/block.h | 41 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 089e890ab208..0c7ad70d06be 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1450,8 +1450,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
> >  #endif
> >
> >       if (unlikely(error && !blk_rq_is_passthrough(req) &&
> > -                  !(req->rq_flags & RQF_QUIET)))
> > +                  !(req->rq_flags & RQF_QUIET))) {
> > +             trace_block_rq_error(req, blk_status_to_errno(error), nr_bytes);
>
> I'm curious to why you don't just pass error into the trace event.
> Looks like blk_status_to_errno() is a function call and that injects
> code at the location of the call. Note, it is not a big deal as I
> believe (haven't looked at the objdump of it), the call may be placed
> in the nop portion of the code, and not hit when the trace point is not
> enabled. But moving the blk_status_to_errno() call to the
> TP_fast_assign() will move it to another section entirely.
>
> I did see trace_blk_rq_complete() does the same thing, so perhaps that
> could just be a clean up change after this on both trace events.

Yes, it is clearly another copy-n-paste of trace_blk_rq_complete().
I trust the current code base as I believe it already passed
your reviews when it was merged. It looks like not the case.

Anyway, I am happy to address all of these in a followup patch.

Thanks.
