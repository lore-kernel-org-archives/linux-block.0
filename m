Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA0C6FA8B
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 23:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiISXCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISXCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 19:02:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989C843E4E
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 16:01:59 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j10so626914qtv.4
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=xixo44lTcERHPiUV64xTDRqasHw9DlQyVVg8mpJU9es=;
        b=AgcVBHh0Hw9LMN3EKAyNefT6Y8I8kX0c8Hih+eW5gYpAM+bvvfQMe4A3kV5CH89Fzq
         0gQQDRzPET7tFaAMhsDE9ZzQA5NhHbKpj7bed/yRGTBX0hETdK9Gf9pHdAZknnFA9yRj
         SHnp0B0Us1AUQUod4cBI4+D316FWpO/dKexSTqaQPCZiiEpYhLekHLbITzKvDzNJl4Bx
         lo1nvff+zjopDK3RHPeWBq/xC+Q/nZIt05shBR2esadkg7leu8eUMq695diDosIWpat5
         jHEP4W3/hXbE0dfpXOGP/EYHzY8r18TZS+El7G3hVR3IxIxIjOC8B0XkVV9Qvt/Gwyy0
         52DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=xixo44lTcERHPiUV64xTDRqasHw9DlQyVVg8mpJU9es=;
        b=ZTA8u0rElUGi8D273bMgTdh73H034Hu6eCvbNtpGFvZwbZGdUs/98iPQERFHYK+RY/
         x2aXgpHumQQYa+CT+GrYlcDqc8mjYrs2WsKgjD+rQMU4Hj5EbAtnZMxHtqBgVTwRxvn7
         7I0dbGe3IBs6FBE6GVsS0EASJi20SRW2BL82kAFrrd+lvqSK3eiPNbfBwhwyiqqLNGeV
         9kEoUiQO7L7IBNr2yXrPrnCet5RAESwDvHkgO+ktqWUukKC7s9mfSGGI4zcKENEiDpWL
         UzLXEatnPPBlFMYIgPJIwlbZPbIrwBNNAO6fBxjvMHlHdQFiYauvxsbImfaAPZDRPOuW
         qjaA==
X-Gm-Message-State: ACrzQf0sihd3S9wS+9J3WFY6LJPtEMZW2Bg8MStKy9htzhl+DgWXL9ZF
        GjnxXtadJqeJqC9Q89rmDW7qxM9fz8/6aQ==
X-Google-Smtp-Source: AMsMyM4ouUmlUEH1L7eYlmBEN7b4vAmMYcNn5lPDnA9AHYvbCCciVxwIStA540FoBADTcmr54usBmg==
X-Received: by 2002:a05:622a:1015:b0:35c:e915:3b61 with SMTP id d21-20020a05622a101500b0035ce9153b61mr6086559qte.572.1663628518654;
        Mon, 19 Sep 2022 16:01:58 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id cc19-20020a05622a411300b0031e9ab4e4cesm8099175qtb.26.2022.09.19.16.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 16:01:57 -0700 (PDT)
Date:   Mon, 19 Sep 2022 16:01:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Keith Busch <kbusch@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
In-Reply-To: <YyjdiKC0YYUkI+AI@kbusch-mbp>
Message-ID: <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com> <YyjdiKC0YYUkI+AI@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 19 Sep 2022, Keith Busch wrote:
> On Sun, Sep 18, 2022 at 02:10:51PM -0700, Hugh Dickins wrote:
> > I have almost no grasp of all the possible sbitmap races, and their
> > consequences: but using the same !waitqueue_active() check as used
> > elsewhere, fixes the lockup and shows no adverse consequence for me.
> 
>  
> > Fixes: 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > 
> >  lib/sbitmap.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/lib/sbitmap.c
> > +++ b/lib/sbitmap.c
> > @@ -620,7 +620,7 @@ static bool __sbq_wake_up(struct sbitmap
> >  		 * function again to wakeup a new batch on a different 'ws'.
> >  		 */
> >  		if (cur == 0)
> > -			return true;
> > +			return !waitqueue_active(&ws->wait);
> 
> If it's 0, that is supposed to mean another thread is about to make it not zero
> as well as increment the wakestate index. That should be happening after patch
> 48c033314f37 was included, at least.

I believe that the thread about to make wait_cnt not zero (and increment the
wakestate index) is precisely this interrupted thread: the backtrace shows
that it had just done its wakeups, so has not yet reached making wait_cnt
not zero; and I suppose that either its wakeups did not empty the waitqueue
completely, or another waiter got added as soon as it dropped the spinlock.

> 
> Prior to 4acb83417cad, the code would also return 'true' if the count was
> already zero, and this batched code wasn't supposed to behave any different in
> that condition.

In principle yes, but in practice no.  Prior to 4acb83417cad, the swapping
load would run okayish for a few minutes, before freezing up mysteriously
(presumably due to missed wakeups).  The "ish" in "okayish" because the
system time was abnormally high, and occasionally there was an odd message
from systemd about killing its journal or something - 4acb83417cad saved
me from having to investigate that further.

Prior to 4acb83417cad, it never locked up looping on wait_cnt < 0;
after 4acb83417cad, it would lock up on wait_cnt 0 in a few seconds.

But in writing that, and remembering the abnormal systime, I begin to
suspect that it might have often been in a tight loop on wait_cnt < 0,
but the batch accounting sufficiently wrong that it always got rescued
by an unrelated wakeup (shifting wakestate index), before any lockup
ever got observed and reported.  Or something like that.

(And I'm trying to avoid making a fool of myself with the arithmetic:
how quickly would wait_cnt 0 have got decremented to positive before?)

I won't mind Jens deleting that "Fixes: 4acb83417cad" if it's unfair.

> 
> Anyway, I don't think the waitqueue_active criteria of the current waitstate is
> correct either. The next waitstate may have waiters too, so we still may need
> to account for this batch's count in order to wake them.

I cannot usefully comment on that, it's all rather too subtle for me.

But I did wonder if each of those !waitqueue_active()s would be better
replaced just by "false"s: we only get that far into __sbq_wake_up() if
waitqueue_active(), so the !waitqueue_active() case reflects a race:
a possible race, yes, but a race that wants precise accounting at a
few imprecise locations?

Hugh
