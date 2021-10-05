Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C524C433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E96C611CC
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 17:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbhJERKf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbhJERKe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 13:10:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D305DC06174E
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 10:08:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id dj4so1479849edb.5
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmZwFIW2KfXlgDrSThDZBPcA5NDLU0nbAmB82GN8Bl8=;
        b=cwd/M3Dw7x0KvaDEoTj0xdWcpLJ/ctvrHrFveNeR0VJWpVgRxjfZFLaSI0GKc4dHYZ
         WhYa+nJKIflK7ZNUCl3K4adCtFwIDxeaUwwdz2j7KFk8EDvVnTgI6vVik1bIRE/PWoCk
         YyMOBhBPXM+d7TSkpIsvWiWCasv+Ev3FG2tD5SNNjEmXo8JBb5/ATc1zCFLlXNFTebay
         hicEAji9M8a5Dv2FKJYey0KRFwRmIYd2k+7UMuPQTLwnVP7jvm/KJJQ+3eGVKde6Ox9q
         hmHaZWQXTwzxDGwujGe8T+7fBJPenvhwmXl/Pg0wv+9oS6bRQFbIFbSP5l+do0iY1KdG
         WRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmZwFIW2KfXlgDrSThDZBPcA5NDLU0nbAmB82GN8Bl8=;
        b=2HKHZZcjtH3K2nln24iMK77vwNEekmUdvMH6qoj4IF191BcFBdoWVmfV5NNopy01f8
         IK/OY97ludzCc3oZsiQgFEdoz0HVm63vbxW7g2n1pSYV46juL16EH3pW6c0FL5USw3Tx
         C5M2mkGXBFX/W4rH5c+m/1UkmrBHs7tX3Q12JB8cNGMb/jDqXmC/FMZ70tC/shdOTlNj
         PuI1F7/0Enk4aZUYwIugN9bsRKqUDXdWcrVnwo+5rL522jGLBPT3DKYuvKif5Y+WO6VE
         jgEHh3Pg0nboCy962jzM8b9v3mWopdRIYoZKT+g8to42TjwtQpMYHAFgG2CIVzcFmBpY
         EcOA==
X-Gm-Message-State: AOAM5307Io+hq1fSvvN/SKpiAZLx/32K7zjaNG5GgfitGje5RTnMwmsz
        AkDJu88Gj8JJ7v8iRnDJhslsUeZdz0XMEkf0W0V+fQ==
X-Google-Smtp-Source: ABdhPJyvCdSGZlAggxg9UnK8tglZeqZ/eDcguGsZF1QakdTODaOQcFf3PUZWCFGuJiA3gCgVWiUfSRPTyBhstbtJKXQ=
X-Received: by 2002:a17:906:b098:: with SMTP id x24mr26462982ejy.88.1633453722154;
 Tue, 05 Oct 2021 10:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211001181627.394921-1-bgeffon@google.com> <YVtH60zyzq9AhUv2@google.com>
 <CADyq12xk-2Fhnf_rJQ70oC1_98OEBJqwxOt6z=PpJa5V=X3dFQ@mail.gmail.com>
 <YVtqHv+p3uYkbu5E@google.com> <CADyq12w2sHdeBhAKVP+5GghHMqNZN+h36ydV7gi8QxOcHZ7f7A@mail.gmail.com>
 <CADyq12zNcXAS8+7GwMPsbFNgn-M-7e+mtR=_9PXBTOfX65yoew@mail.gmail.com> <YVx/MynFCQLRcAN2@google.com>
In-Reply-To: <YVx/MynFCQLRcAN2@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 5 Oct 2021 13:08:06 -0400
Message-ID: <CADyq12y1iXsJqD_CsL5SS5f+6A=t_EChatrkyVdJQNLrAwhvvw@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 12:37 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, Oct 05, 2021 at 11:18:38AM -0400, Brian Geffon wrote:
> > > On Mon, Oct 4, 2021 at 4:55 PM Minchan Kim <minchan@kernel.org> wrote:
> > > >
> > > > On Mon, Oct 04, 2021 at 02:40:52PM -0400, Brian Geffon wrote:
> > > > > On Mon, Oct 4, 2021 at 2:29 PM Minchan Kim <minchan@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Oct 01, 2021 at 11:16:27AM -0700, Brian Geffon wrote:
> > > > > > > There does not appear to be a technical reason to not
> > > > > > > allow the zram backing device to be assigned after the
> > > > > > > zram device is initialized.
> > > > > > >
> > > > > > > This change will allow for the backing device to be assigned
> > > > > > > as long as no backing device is already assigned. In that
> > > > > > > event backing_dev would return -EEXIST.
> > > > > > >
> > > > > > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > > > > > ---
> > > > > > >  drivers/block/zram/zram_drv.c | 6 +++---
> > > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > > > > > index fcaf2750f68f..12b4555ee079 100644
> > > > > > > --- a/drivers/block/zram/zram_drv.c
> > > > > > > +++ b/drivers/block/zram/zram_drv.c
> > > > > > > @@ -462,9 +462,9 @@ static ssize_t backing_dev_store(struct device *dev,
> > > > > > >               return -ENOMEM;
> > > > > > >
> > > > > > >       down_write(&zram->init_lock);
> > > > > > > -     if (init_done(zram)) {
> > > > > > > -             pr_info("Can't setup backing device for initialized device\n");
> > > > > > > -             err = -EBUSY;
> > > > > > > +     if (zram->backing_dev) {
> > > > > > > +             pr_info("Backing device is already assigned\n");
> > > > > > > +             err = -EEXIST;
> > > > > > >               goto out;
> > > > > >
> > > > > > Hi Brian,
> > > > > >
> > > > >
> > > > > Hi Minchan,
> > > > >
> > > > > > I am worry about the inconsistency with other interface of current zram
> > > > > > set up. They were supposed to set it up before zram disksize setting
> > > > > > because it makes code more simple/maintainalbe in that we don't need
> > > > > > to check some feature on the fly.
> > > > > >
> > > > > > Let's think about when zram extends the writeback of incompressible
> > > > > > page on demand. The write path will need the backing_dev under
> > > > > > down_read(&zarm->init_lock) or other conditional variable to check
> > > > > > whether the feature is enabled or not on the fly.
> > > > >
> > > > > I don't follow what you mean by that, writeback_store already holds
> > > > > down_read(&zarm->init_lock).
> > > >
> > > > I should have explained a bit more. Sorry about that.
> > > > I am thinking about a feature to deal with incompressible page.
> > > > Let's have an example to handle incompressible page for that.
> > > >
> > > > zram_bvec_rw
> > > >   zram_bvec_write
> > > >     if (comp_len >= huge_class)
> > > >         zs_page_writeback
> > > >             down_read(&zram->init_lock) or some other way
> > > >
> > > > It's just idea for incompressible page but we might intorduce
> > > > the way for other compresible pages, too at some condition.
> >
> > (sorry for the top post before)
> >
> > Hi Minchan,
> > I guess the point I was trying to make was that so long as we allow a
> > reset operation we'll need to be taking the init lock in read mode
> > before doing any writeback. Does that seem right?
>
> It's true and it introduced many lock dependency problems before.
> We actually had the lock in the rw path but we removed the lock
> so without strong reason, I'd like to avoid the lock in the rw path.

Hi Minchan,
Thank you very much for taking the time to explain! We can drop this patch.

Brian

>
> commit 08eee69fcf6b
> Author: Minchan Kim <minchan@kernel.org>
> Date:   Thu Feb 12 15:00:45 2015 -0800
>
>     zram: remove init_lock in zram_make_request
>
>     Admin could reset zram during I/O operation going on so we have used
>     zram->init_lock as read-side lock in I/O path to prevent sudden zram
>     meta freeing.
>
>     However, the init_lock is really troublesome.  We can't do call
>     zram_meta_alloc under init_lock due to lockdep splat because
>     zram_rw_page is one of the function under reclaim path and hold it as
>     read_lock while other places in process context hold it as write_lock.
>     So, we have used allocation out of the lock to avoid lockdep warn but
>     it's not good for readability and fainally, I met another lockdep splat
>     between init_lock and cpu_hotplug from kmem_cache_destroy during working
>     zsmalloc compaction.  :(
>
>     Yes, the ideal is to remove horrible init_lock of zram in rw path.  This
>     patch removes it in rw path and instead, add atomic refcount for meta
>     lifetime management and completion to free meta in process context.
>     It's important to free meta in process context because some of resource
>     destruction needs mutex lock, which could be held if we releases the
>     resource in reclaim context so it's deadlock, again.
>
>     As a bonus, we could remove init_done check in rw path because
>     zram_meta_get will do a role for it, instead.
