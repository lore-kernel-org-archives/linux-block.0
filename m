Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55251C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 16:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A308611C5
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 16:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhJEQjB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhJEQjA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 12:39:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51027C061749;
        Tue,  5 Oct 2021 09:37:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m5so14827pfk.7;
        Tue, 05 Oct 2021 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fXysKaZsmwoRw6MaIqdbIRHQReHtGv62HbEcBZHPs4c=;
        b=kpe+FEAvACw7nP9VlOvmhMJwEXjlFoLqOQHfNvj2s0AEQIxFLERjn2blqd3uBsmL0w
         4eCB09IAK3dUIFQBnEVT/IhzOppmIaAuZptGjBi5/WoV8UHefIMQkooxwOdAIHAG2udz
         kAEK2iVaFa0pdIjwNhonagi4ZhSIhBIwVt1JmYEsfc4tRklsfq81xnwOQvQPlISwJze8
         tGs7LtGYilmtNQzpBvwAn60t9OkMG3d3Vu0XWkuR1HvZ0hVtFGAM9fn8YmVpA4GfTgjF
         qoZwmsX4d/9JyWUoTl7YqkfF4I9BMDN/UKybDyKeQ3fUWO/Ikd9UsbO1J2YzWBctPEe3
         wCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fXysKaZsmwoRw6MaIqdbIRHQReHtGv62HbEcBZHPs4c=;
        b=Vxr691lgSAnyyFJOFxV8gCnAxAtAzEhA0gD4/n/aMSTnE2mmHQhQtyvhe9Xd3JYiQc
         wP56aJoNrMgIxTMp++faz7grU+4UP5yhWEL8WnIzIqFbx4jtEr4FUrI37la7G9nWYIK7
         epITZfvOTGrdyZ/0T+vGBKWQZRiILjtLFOzPS8wjgse7i/ztajVOZ2IkDmjK2kxLQRvu
         fjTf6kNkI1BkZTxCUfCJoiHtihxs28K+cJVwMJJOOdsqfTnv9OZML6JEn6p5KtlxOcOl
         9gQqS/cexF2/Rclizrs0aEFXvCR5xBAIv/BqdKEgtBtTc7yhycWQf3FprEFCCtxHCa+V
         HeIg==
X-Gm-Message-State: AOAM533OW4nmIqZx8JHp4ouympRNQrjUKyqxo3kZAW3zXN1J5YR5/av4
        bAyj43pSxR2dA0s7goPWehpwL3kKbD8=
X-Google-Smtp-Source: ABdhPJzSVT20EZ1jVhhFc87d6KXxpNZuMI3lrXD572U83esAb81vvt+FSF0QZQsGTYktMz08S/PLKw==
X-Received: by 2002:a63:490d:: with SMTP id w13mr16706649pga.481.1633451829725;
        Tue, 05 Oct 2021 09:37:09 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:1aa2:5fb9:bbf2:7f64])
        by smtp.gmail.com with ESMTPSA id n185sm19195262pfn.171.2021.10.05.09.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:37:09 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 5 Oct 2021 09:37:07 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH] zram: Allow backing device to be assigned after init
Message-ID: <YVx/MynFCQLRcAN2@google.com>
References: <20211001181627.394921-1-bgeffon@google.com>
 <YVtH60zyzq9AhUv2@google.com>
 <CADyq12xk-2Fhnf_rJQ70oC1_98OEBJqwxOt6z=PpJa5V=X3dFQ@mail.gmail.com>
 <YVtqHv+p3uYkbu5E@google.com>
 <CADyq12w2sHdeBhAKVP+5GghHMqNZN+h36ydV7gi8QxOcHZ7f7A@mail.gmail.com>
 <CADyq12zNcXAS8+7GwMPsbFNgn-M-7e+mtR=_9PXBTOfX65yoew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12zNcXAS8+7GwMPsbFNgn-M-7e+mtR=_9PXBTOfX65yoew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 05, 2021 at 11:18:38AM -0400, Brian Geffon wrote:
> > On Mon, Oct 4, 2021 at 4:55 PM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > On Mon, Oct 04, 2021 at 02:40:52PM -0400, Brian Geffon wrote:
> > > > On Mon, Oct 4, 2021 at 2:29 PM Minchan Kim <minchan@kernel.org> wrote:
> > > > >
> > > > > On Fri, Oct 01, 2021 at 11:16:27AM -0700, Brian Geffon wrote:
> > > > > > There does not appear to be a technical reason to not
> > > > > > allow the zram backing device to be assigned after the
> > > > > > zram device is initialized.
> > > > > >
> > > > > > This change will allow for the backing device to be assigned
> > > > > > as long as no backing device is already assigned. In that
> > > > > > event backing_dev would return -EEXIST.
> > > > > >
> > > > > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > > > > ---
> > > > > >  drivers/block/zram/zram_drv.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > > > > index fcaf2750f68f..12b4555ee079 100644
> > > > > > --- a/drivers/block/zram/zram_drv.c
> > > > > > +++ b/drivers/block/zram/zram_drv.c
> > > > > > @@ -462,9 +462,9 @@ static ssize_t backing_dev_store(struct device *dev,
> > > > > >               return -ENOMEM;
> > > > > >
> > > > > >       down_write(&zram->init_lock);
> > > > > > -     if (init_done(zram)) {
> > > > > > -             pr_info("Can't setup backing device for initialized device\n");
> > > > > > -             err = -EBUSY;
> > > > > > +     if (zram->backing_dev) {
> > > > > > +             pr_info("Backing device is already assigned\n");
> > > > > > +             err = -EEXIST;
> > > > > >               goto out;
> > > > >
> > > > > Hi Brian,
> > > > >
> > > >
> > > > Hi Minchan,
> > > >
> > > > > I am worry about the inconsistency with other interface of current zram
> > > > > set up. They were supposed to set it up before zram disksize setting
> > > > > because it makes code more simple/maintainalbe in that we don't need
> > > > > to check some feature on the fly.
> > > > >
> > > > > Let's think about when zram extends the writeback of incompressible
> > > > > page on demand. The write path will need the backing_dev under
> > > > > down_read(&zarm->init_lock) or other conditional variable to check
> > > > > whether the feature is enabled or not on the fly.
> > > >
> > > > I don't follow what you mean by that, writeback_store already holds
> > > > down_read(&zarm->init_lock).
> > >
> > > I should have explained a bit more. Sorry about that.
> > > I am thinking about a feature to deal with incompressible page.
> > > Let's have an example to handle incompressible page for that.
> > >
> > > zram_bvec_rw
> > >   zram_bvec_write
> > >     if (comp_len >= huge_class)
> > >         zs_page_writeback
> > >             down_read(&zram->init_lock) or some other way
> > >
> > > It's just idea for incompressible page but we might intorduce
> > > the way for other compresible pages, too at some condition.
> 
> (sorry for the top post before)
> 
> Hi Minchan,
> I guess the point I was trying to make was that so long as we allow a
> reset operation we'll need to be taking the init lock in read mode
> before doing any writeback. Does that seem right?

It's true and it introduced many lock dependency problems before.
We actually had the lock in the rw path but we removed the lock
so without strong reason, I'd like to avoid the lock in the rw path.

commit 08eee69fcf6b
Author: Minchan Kim <minchan@kernel.org>
Date:   Thu Feb 12 15:00:45 2015 -0800

    zram: remove init_lock in zram_make_request

    Admin could reset zram during I/O operation going on so we have used
    zram->init_lock as read-side lock in I/O path to prevent sudden zram
    meta freeing.

    However, the init_lock is really troublesome.  We can't do call
    zram_meta_alloc under init_lock due to lockdep splat because
    zram_rw_page is one of the function under reclaim path and hold it as
    read_lock while other places in process context hold it as write_lock.
    So, we have used allocation out of the lock to avoid lockdep warn but
    it's not good for readability and fainally, I met another lockdep splat
    between init_lock and cpu_hotplug from kmem_cache_destroy during working
    zsmalloc compaction.  :(

    Yes, the ideal is to remove horrible init_lock of zram in rw path.  This
    patch removes it in rw path and instead, add atomic refcount for meta
    lifetime management and completion to free meta in process context.
    It's important to free meta in process context because some of resource
    destruction needs mutex lock, which could be held if we releases the
    resource in reclaim context so it's deadlock, again.

    As a bonus, we could remove init_done check in rw path because
    zram_meta_get will do a role for it, instead.
