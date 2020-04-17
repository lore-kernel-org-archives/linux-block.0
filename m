Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2327FC2D0EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 15:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC93621D79
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587137738;
	bh=Dval9ZkbP2smXT0AviNitjoGA8m0oFg4iCZLseezMFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LtIPXpauI/yfaIsDc5pXW3sas4vvcOBF7CljEe9wJX/cOEWLRIZSZ85Q/NLOji9tr
	 dv3Y0wMA3pwdstyW+gs9VtlPZBBT7HrnAGptzVnbzF0/QIG2KQT2a3DQfvIm6rbbp9
	 CZsGmZOlrAjyPnrWvs3D795zWrF1nuP0LJkSybvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgDQPfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728956AbgDQPfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 11:35:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFEEC061A0C;
        Fri, 17 Apr 2020 08:35:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h69so1261511pgc.8;
        Fri, 17 Apr 2020 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2u7CFxnfcfWMFdE418oTd3URsuwKNqPkf1pPDTmN+qM=;
        b=Zv01b7MphwVxL7xBaTjmYojKl5TmfhxIjLNk/b7ubMqPRDzD3Ju213kKg+ehfuYYSC
         3f3t8oF5BpmvNnAiyuj5w72+9SuubT4iBcLJqcwbDFmArOhdCWtZl5s55+fLOqfbFCot
         CPfT/1BV5abBdE7GaQ3D5kCAz0pkKiMKYJHbV8OvQQnNT5igVxpe/EvTWme9wRtNN7DO
         DzBWAMdgmgw//maRaif/kEtyZAuNI39SUW2Gmwcw11kNR7OLEjPxtwj/24gkhVHeF1Vj
         EJpU2xu5bWItdIXxMUS+ZQxmICHaOK8JgvUHdyYkx0FFC91s7NpM4KtZx0DwxC1vua0h
         kPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2u7CFxnfcfWMFdE418oTd3URsuwKNqPkf1pPDTmN+qM=;
        b=JUz+Lc7HOvp0uEO7jKXa4K11X4uTLGS4qudd4P075LYT7iCBrj2Yn7cmKn4RtbTw+h
         XyQ0xQVQchv8JPR71IphTwUtgVjp0XmO2y6rGHVRP4B3pQold8fI/KzN78QhUb505Jgk
         vFyLIt6dSqBGpwLhmBEY4uTks7xVk6fOET0ouAdptdWRokgsOcId2ah91LBDqFooASaF
         1kqVfsEoLWWYp8iTZoh1zUbsj7fitVqxrEvo9PKrjsD5XdQsMwxU0Ok4fTi/HCTppoXi
         xdKcEc/DM+rW2mOZKtvRHJB+OlpsmZeUBayPKJXRiOJrDccZgpJrLt6y4CGfIvlMbOIn
         nMAw==
X-Gm-Message-State: AGi0PuZ2c+GInZB6u1bv5ZdeO0FwzDE7cZ8WI4OLQibLY4A4l/AjzcJC
        piwW9uXJDdhhFSaHtHJdLY7Utqn/
X-Google-Smtp-Source: APiQypL1Mv/tnH3sPHFVVIS3vVa46We6xBPi0OMFh3Dgi0WKemwQKdQH6UYDrS14q4x+HYk/7S6VbA==
X-Received: by 2002:a63:894a:: with SMTP id v71mr3750537pgd.314.1587137736078;
        Fri, 17 Apr 2020 08:35:36 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id gv7sm2401249pjb.16.2020.04.17.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:35:35 -0700 (PDT)
Date:   Fri, 17 Apr 2020 08:35:33 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Justin Gottula <justin@jgottula.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: fix writeback_store returning zero in most
 situations
Message-ID: <20200417153533.GB178621@google.com>
References: <CAKuMfTUPzPjuNk+T_GQMCKoB9ssh2arr6xRiu6VODwwB0PMdZw@mail.gmail.com>
 <20200416214649.GA60148@google.com>
 <CAKuMfTVpaetB0qQ_hm8cSowtZN8HUKXdADWhKXC=4eKd1i5oSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKuMfTVpaetB0qQ_hm8cSowtZN8HUKXdADWhKXC=4eKd1i5oSw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Justin,

On Thu, Apr 16, 2020 at 05:45:31PM -0700, Justin Gottula wrote:
> On Thu, Apr 16, 2020 at 2:47 PM Minchan Kim <minchan@kernel.org> wrote:
> > I couldn't remember why I wanted to do continue even though we knew
> > the write was failure from the beginning.
> >
> > Couldn't we just bail out whenever we encounter the error?
> > Sergey, Justin, what do you think?
> >
> > IMO, it would be more consistent with other error handling.
> 
> As far as being consistent with the rest of the error handling in the
> loop, I think there's a reasonable distinction that can be drawn between
> some of the error cases and others. With some, breaking out immediately is
> obviously the correct action; but with others, it's not as clear-cut.
> 
> For the zram->wb_limit_enable && !zram->bd_wb_limit case, breaking out of
> the loop and immediately returning makes complete sense: once we've hit
> the writeback limit, there's nothing that could happen in future loop
> iterations that could cause us to somehow _not_ be at the limit anymore.
> So there's no reason to continue the loop.
> 
> Similarly, for the alloc_block_bdev(zram) failure case, breaking out of
> the loop and immediately returning also makes complete sense: if we've
> already run out of blocks on the backing device, then continuing to loop
> isn't going to result in is somehow ending up with more backing device
> blocks available. So there's no reason to continue the loop in that case
> either.
> 
> With the zram_bvec_read and submit_bio_wait failure cases, though, it's
> not nearly as clear that a failure on the current slot _automatically_
> guarantees that all future slots would also have errors. For example, in
> the zram_bvec_read failure case, it's entirely possible that the
> decompression code in the currently-used compression backend might have
> had a problem with the current buffer; but that doesn't necessarily seem
> like a clear-cut indication that the same decompression error would
> definitely happen on later iterations of the loop: in fact, many of the
> later slots could very well be ZRAM_HUGE or ZRAM_SAME, and so they would
> avoid that type of error entirely. And in the submit_bio_wait failure
> case, it's also conceivable that the backing device may have had some sort
> of write error with the current block and data buffer, but that the same
> error might not happen again on future iterations of the loop when writing
> a different buffer to potentially an entirely different block. (Especially
> if the backing device happens to be using some kind of complicated driver,
> like one of the weirder LVM/device-mapper backends or a network block
> device.)
> 
> So, at least when it comes to "are these particular failure cases the kind
> where it would certainly make no sense to continue with future loop
> iterations because we would definitely have the same failures then too",
> there's a reasonable argument that the zram_bvec_read and submit_bio_wait
> error cases don't necessarily fit that logic and so potentially shouldn't
> immediately break and return.
> 
> A couple of other considerations came to mind while thinking about this:
> 
> 1. From the standpoint of the user, what should they reasonably be
> expecting to happen when writing "huge"/"idle" to the writeback file? A
> best-effort attempt at doing all possible block writebacks (of the
> requested type) that can possibly be successfully accomplished? Or,
> writeback of only as many blocks as can be done until a (possibly
> transient or not-applicable-to-all-blocks) error pops up, and then
> stopping at that point? I tend to think that the former makes a bit more
> sense, but I don't know for sure if it's the definite Right Answer.

I agree it should be best effort.

> 
> 2. There is a bit of a predicament with the keep-going-even-if-an-error-
> happened approach. There could be multiple submit_bio_wait failures (e.g.
> due to a few blocks that couldn't be written-back due to transient write
> errors on the backing device), each with their own error return value; but
> we can only return one error code from writeback_store. So how do we even
> communicate a multiple-errors-happened situation to the user properly? My
> patch, as originally written, would give the user an errno corresponding
> to the last submit_bio_wait failure to happen; but of course that leaves
> out any other error codes that may have also come up on prior write
> attempts that failed (and those failures could have been for different
> reasons). And then also, it's entirely possible that submit_bio_wait may
> return -EIO or -ENOSPC or -ENOMEM, which would be ambiguous with the other
> meanings of those error codes from the writeback_store function itself
> (-EIO for WB limit, -ENOSPC for no free blocks on backing device, -ENOMEM
> if couldn't allocate the temporary page).

Indeed.

What I wanted by my suggestion was that user could find the error
as soon as something popped up so they could judge what they could
as well as consistency of code structuring. But based on your comment,
they couldn't since several errors are overloaded here. In that case,
it makes my trial void. Another thought is if we could change writeback
work asynchronously(and sync right before returning to the user), it also
will make my trial void. So, yes, your suggestion is much sane.

Could you resend it with dealing with zram_bvec_read failure?
And change footer with following
Fixes: 3b82a051c101 ("zram: fix error return codes not being returned in writeback_store")
Cc: stable@vger.kernel.org
