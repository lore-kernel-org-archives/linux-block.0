Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68460C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CCC61244
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhJEPDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhJEPDo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 11:03:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3027EC061753
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 08:01:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z1so6305edb.8
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCRBn6b3qoryRYKrN4/1JLdhAV/hIrIuL5Vq/GngAlY=;
        b=mYs57AFKIU7i2tGt83F0nC59rmMH39ZE/i0lP71h3TsKRyHDKezP9q7FrxkmATPtlf
         dGa0kEDJIDfss8qfgAnlRnyfYvQ2i7mQoH2I3P1abTTtt+OeEy/LCUGj8P5NvKjX05mN
         xnmD4sdB0mtma37jmJXKGdTP/xu9ChYuEBX9+txpvXX0uXxrdPpbd23pNmiG+/8J8FIv
         Ae0Vl22NZITYbOHKF0lnHOpEIpJ0l4aR7hdvwJ6AzlazgpMmFAmyJC6QJ70tekXfKEq7
         91eoo0kkirf4et2kRi+3OckOh4yzKDKhGcpSeA27bU8c5sO570Oz5HcDbIJrP6QLAezc
         V27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCRBn6b3qoryRYKrN4/1JLdhAV/hIrIuL5Vq/GngAlY=;
        b=hxVEc3YL/GRUjvBLOGBElFCcjdE8bnw58Mb721lMnrqpAfGeOpCW+DPHQDgE7g3cIe
         ieYnLuzgoS2OyKnyLEVmgtXZkoFaKwJHPN/Jfw4uxBL4U3oO+3V926C2sN2QIizmpoqM
         nV+Ln7rWbQa2/r8KaEvkOtr9jKCWhUhXGSxXXgPXEDdVwpW6pBsuOumA9dXPxIXKB/WM
         ymVUrdUBPzD3SPg7Bl6kIqabTc0kSXO7Da1I9bCsLvo/wiUuTr3htbn99k2sJijyW4Lu
         X9L34BbWzPfwxr19M9hW2q6pIQ6yormIfJA9xmG9xTkcwA/QorjGTDCYmxtqVZJ8DTZJ
         BRhA==
X-Gm-Message-State: AOAM533xye5n6hbQaOwHGeQ94GEllThpf6J2ap4uixiEjsAPb9YCb+7R
        +LvjTC4IosSXp5PuMre7n+KhQDa65P4jMmR4r75Vvg==
X-Google-Smtp-Source: ABdhPJxAQ/4UsSMxvuXIEURMPvaas9ykcgFi/q1H4N/drfI2wcYk/4KQHSLGIJlx20Qi7odiErbbeE2ik8768PcSvV4=
X-Received: by 2002:a05:6402:450:: with SMTP id p16mr26584475edw.162.1633446111422;
 Tue, 05 Oct 2021 08:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211001181627.394921-1-bgeffon@google.com> <YVtH60zyzq9AhUv2@google.com>
 <CADyq12xk-2Fhnf_rJQ70oC1_98OEBJqwxOt6z=PpJa5V=X3dFQ@mail.gmail.com> <YVtqHv+p3uYkbu5E@google.com>
In-Reply-To: <YVtqHv+p3uYkbu5E@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 5 Oct 2021 11:01:15 -0400
Message-ID: <CADyq12w2sHdeBhAKVP+5GghHMqNZN+h36ydV7gi8QxOcHZ7f7A@mail.gmail.com>
Subject: Re: [PATCH] zram: Allow backing device to be assigned after init
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Minchan,
Thank you for expanding on that. The only situation where there will
be lock contention that is problematic is when we're storing the
backing device the first time, all other times the lock will be held
as a read. Once the backing device has been set it cannot be set again
(it would return -EEXIST). I think no matter what if we're doing
writeback, even with the optimization you're describing, you'd have to
hold the zram->init_lock as read to validate that you have a writeback
device. Does that make sense?

Brian

On Mon, Oct 4, 2021 at 4:55 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Mon, Oct 04, 2021 at 02:40:52PM -0400, Brian Geffon wrote:
> > On Mon, Oct 4, 2021 at 2:29 PM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > On Fri, Oct 01, 2021 at 11:16:27AM -0700, Brian Geffon wrote:
> > > > There does not appear to be a technical reason to not
> > > > allow the zram backing device to be assigned after the
> > > > zram device is initialized.
> > > >
> > > > This change will allow for the backing device to be assigned
> > > > as long as no backing device is already assigned. In that
> > > > event backing_dev would return -EEXIST.
> > > >
> > > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > > ---
> > > >  drivers/block/zram/zram_drv.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > > index fcaf2750f68f..12b4555ee079 100644
> > > > --- a/drivers/block/zram/zram_drv.c
> > > > +++ b/drivers/block/zram/zram_drv.c
> > > > @@ -462,9 +462,9 @@ static ssize_t backing_dev_store(struct device *dev,
> > > >               return -ENOMEM;
> > > >
> > > >       down_write(&zram->init_lock);
> > > > -     if (init_done(zram)) {
> > > > -             pr_info("Can't setup backing device for initialized device\n");
> > > > -             err = -EBUSY;
> > > > +     if (zram->backing_dev) {
> > > > +             pr_info("Backing device is already assigned\n");
> > > > +             err = -EEXIST;
> > > >               goto out;
> > >
> > > Hi Brian,
> > >
> >
> > Hi Minchan,
> >
> > > I am worry about the inconsistency with other interface of current zram
> > > set up. They were supposed to set it up before zram disksize setting
> > > because it makes code more simple/maintainalbe in that we don't need
> > > to check some feature on the fly.
> > >
> > > Let's think about when zram extends the writeback of incompressible
> > > page on demand. The write path will need the backing_dev under
> > > down_read(&zarm->init_lock) or other conditional variable to check
> > > whether the feature is enabled or not on the fly.
> >
> > I don't follow what you mean by that, writeback_store already holds
> > down_read(&zarm->init_lock).
>
> I should have explained a bit more. Sorry about that.
> I am thinking about a feature to deal with incompressible page.
> Let's have an example to handle incompressible page for that.
>
> zram_bvec_rw
>   zram_bvec_write
>     if (comp_len >= huge_class)
>         zs_page_writeback
>             down_read(&zram->init_lock) or some other way
>
> It's just idea for incompressible page but we might intorduce
> the way for other compresible pages, too at some condition.
