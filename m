Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE5C07E9D
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 23:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiIWXPs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 19:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiIWXPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 19:15:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05F915813
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 16:15:42 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id i15so890579qvp.5
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 16:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=cHKAxGMuxvnZOWi2kVzE6Zjg/2r0BKsDScmdf0kn5Dg=;
        b=hKEfM8QsnAKqVHZgprigLpD1qbmh+qDIPekChNSNaMOykardrQE+y9kVKX0FGmICEc
         YL1wuPKAO0BJKk3bh33DZtxjfWTmR4HG1vVDS6bzMvj0VJEFtLSXpodFwMLccG5sNW2j
         SVN2OT5/o1TVhYup42NhsQzPCcvC1C6/Ns/Mm2Ro4kTe5vFTbS+jfJfIqPrWdsWGRjxn
         cRzHU7W/rUY4oRzfPYlSKZv0yBTcdt+JfodPmnyf0m7jCZWLd+Hh7r/sgfIC5t0DTJz3
         rPmdxQsSDAS0CQHI/OejSsqfQbjLFW5UgyG3sGwbFCkZRzmsfJyOaww7/EWjg3eolmkU
         i/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=cHKAxGMuxvnZOWi2kVzE6Zjg/2r0BKsDScmdf0kn5Dg=;
        b=l8IMF0alb30PPXCn5EJvV5+Ne0+qQ4R3eBWanACbYmny/8oZ+o1/AuKx673P5BJ8zN
         mFYncLmDZaVN1evOo/Mb4w87vBqkjTysGsQqhoo9veVoOCXoNRSsqWhkp3mbM4WLsbpX
         luemrraMQQ+Rruang65NQFRSPzuMEEg5kbJLBLOj7rNsBO6JN70oWGOsfO9HlzxFd0vr
         t68ZiWoOfqJU4k5tMe808zRNk734zI3WmJvJQ8bXUfSPyuJcDDVB9+zBhylBGNAa69+Y
         NFG+rHiQxQEtIu67sL6ltx/1Q3mM/6uVTEUWYE/umSuhl87w8x0TXCtoCiR2MP/RvFfx
         iiuA==
X-Gm-Message-State: ACrzQf3tBiKqxVJtvxdqnwfW8Mfowu7RmRpAKQCUuTW4tzwlw5swevgH
        qIlT6qu/yC3I/T071+gDSeuLIA==
X-Google-Smtp-Source: AMsMyM6eAh9FLvG7sO8rySas8N5LnqZkV0oHyHDFYEywdyu+4WJgqQz9XTPEubZ5SWatsfKIV+yPBA==
X-Received: by 2002:a0c:f50d:0:b0:4ac:72b6:455b with SMTP id j13-20020a0cf50d000000b004ac72b6455bmr8986596qvm.66.1663974941982;
        Fri, 23 Sep 2022 16:15:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8110f000000b0035bbb0fe90bsm6027556qtj.47.2022.09.23.16.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 16:15:41 -0700 (PDT)
Date:   Fri, 23 Sep 2022 16:15:29 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Keith Busch <kbusch@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
In-Reply-To: <391b1763-7146-857-e3b6-dc2a8e797162@google.com>
Message-ID: <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com> <YyjdiKC0YYUkI+AI@kbusch-mbp> <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com> <20220921164012.s7lvklp2qk6occcg@quack3> <20220923144303.fywkmgnkg6eken4x@quack3> <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
 <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com> <391b1763-7146-857-e3b6-dc2a8e797162@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 23 Sep 2022, Hugh Dickins wrote:
> On Fri, 23 Sep 2022, Keith Busch wrote:
> 
> > Does the following fix the observation? Rational being that there's no reason
> > to spin on the current wait state that is already under handling; let
> > subsequent clearings proceed to the next inevitable wait state immediately.
> 
> It's running fine without lockup so far; but doesn't this change merely
> narrow the window?  If this is interrupted in between atomic_try_cmpxchg()
> setting wait_cnt to 0 and sbq_index_atomic_inc() advancing wake_index,
> don't we run the same risk as before, of sbitmap_queue_wake_up() from
> the interrupt handler getting stuck on that wait_cnt 0?

Yes, it ran successfully for 50 minutes, then an interrupt came in
immediately after the cmpxchg, and it locked up just as before.

Easily dealt with by disabling interrupts, no doubt, but I assume it's a
badge of honour not to disable interrupts here (except perhaps in waking).

Some clever way to make the wait_cnt and wake_index adjustments atomic?

Or is this sbitmap_queue_wake_up() interrupting sbitmap_queue_wake_up()
just supposed never to happen, the counts preventing it: but some
misaccounting letting it happen by mistake?

> 
> > 
> > ---
> > diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> > index 624fa7f118d1..47bf7882210b 100644
> > --- a/lib/sbitmap.c
> > +++ b/lib/sbitmap.c
> > @@ -634,6 +634,13 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
> >  
> >  	*nr -= sub;
> >  
> > +	/*
> > +	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> > +	 * callers can see valid wait_cnt in old waitqueue, which can cause
> > +	 * invalid wakeup on the old waitqueue.
> > +	 */
> > +	sbq_index_atomic_inc(&sbq->wake_index);
> > +
> >  	/*
> >  	 * When wait_cnt == 0, we have to be particularly careful as we are
> >  	 * responsible to reset wait_cnt regardless whether we've actually
> > @@ -660,13 +667,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
> >  	 * of atomic_set().
> >  	 */
> >  	smp_mb__before_atomic();
> > -
> > -	/*
> > -	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> > -	 * callers can see valid wait_cnt in old waitqueue, which can cause
> > -	 * invalid wakeup on the old waitqueue.
> > -	 */
> > -	sbq_index_atomic_inc(&sbq->wake_index);
> >  	atomic_set(&ws->wait_cnt, wake_batch);
> >  
> >  	return ret || *nr;
> > --
> 
