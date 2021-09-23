Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D583C433FE
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 06:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AFF60FE6
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 06:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbhIWGDm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 02:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbhIWGDl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 02:03:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8B0C061574;
        Wed, 22 Sep 2021 23:02:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y5so866611pll.3;
        Wed, 22 Sep 2021 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zw2o7pLl/QgjsQpgLLuvVSe64sAISOQHw3h2WR6yjQk=;
        b=YmrdbCgZ5+SlGb8KK0B/yBW6+YTD/8AJ0qHvS0dVxY3r6uXN0Z3ErPcTpp8EKWWPmq
         ESDhHDsqzUSDa+DkDYb6M63ddP8jbFKJ8AosUi+95ZHXJo6AF5pFe0GzqG1VXiIwvzvh
         kP2ul/G/A7yBkGlAuP0gvuJmeuBSEXzDu6OqaEh4SPn8K/IChtRG7obUOp6Zod/9L8QV
         wfxpJGYEsa6OwIbWMk4u7HavIfIlVMHraUclb0KVbd9Nzrb77zWWJ78mBWSM2n2m+Xd3
         fzneuNQz4ZjDmkOos4+AOx8GcYkxhHOtXde7xiA8T40BJxbIaJIWStMnGpBc07bu5oF2
         7vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Zw2o7pLl/QgjsQpgLLuvVSe64sAISOQHw3h2WR6yjQk=;
        b=ddxDq7JfOUvPQGjG3B/1vpl+8aNJclCm3gj384jPXQtvFrVZLbUiYOwgBCbCazGcm/
         PxJk+N1+nkDDvctttL0qsq5F5F9sGF9s+eHYu+hz7EDPWMM/h23ULtZhfVqoYYgaI4wD
         ZT4wFbt4HYeIX6aJJBBMf6jeZfYg3Z0glrFyKQ4QGfywMFF/yAOK7/k7pbmGIJbZKSg1
         UhkPr9W1yO651sdy/PRzTQcmuS8i/fsH9KbqGmuBIxXru7txbMwfR4QQQe3yLGLv/cY4
         92EojSSyAu1SS3EntcYm2SgbgFQXznHrMTHDpTNKPDkmPYIaC69/5aesIpMnNuN47Q9g
         I4Dg==
X-Gm-Message-State: AOAM531dYO+kGqflExtzQWoL1wq9C3PX/XgKj3+k3/vv2J5N1CVlUqRf
        d1azhYIBBUAQA28jtyUMSokLMZcTO1E=
X-Google-Smtp-Source: ABdhPJxz2FRBbFGRQOtLBrQopf3ZzXJbnze/j6F0MSm6LmBGV2BUkyZvpfaTHXMzoyqA146c5BWu8g==
X-Received: by 2002:a17:903:244e:b0:13c:802d:92c with SMTP id l14-20020a170903244e00b0013c802d092cmr2317288pls.78.1632376929725;
        Wed, 22 Sep 2021 23:02:09 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a2a:9e3c:d2c:e8bc])
        by smtp.gmail.com with ESMTPSA id s65sm4199790pfc.139.2021.09.22.23.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 23:02:09 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 22 Sep 2021 23:02:07 -0700
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
Subject: Re: [PATCH v3] zram: Introduce an aged idle interface
Message-ID: <YUwYX3LJQEwdrO4E@google.com>
References: <20210917210640.214211-1-bgeffon@google.com>
 <20210921194336.947226-1-bgeffon@google.com>
 <YUvFvsyrp86mbjbY@google.com>
 <CADyq12yaSOdUAE7i9TtFEB-ryDx2kLYCH8eAxrUQGEPizw9ahg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12yaSOdUAE7i9TtFEB-ryDx2kLYCH8eAxrUQGEPizw9ahg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Brian,

On Wed, Sep 22, 2021 at 08:42:44PM -0400, Brian Geffon wrote:
> Hi Minchan,
> Thank you for taking a look. I'm happy to make that change, but I
> personally cannot see why userspace would want to do something like
> idle pages older than "0x3C seconds" or "0o250600 seconds," it just
> seems like a strange way to represent seconds. What do you think?

Kernel communty loves inline reply instead of top posting. ;-)

I am not strong opinion about mutiple base support. The question
just started from "what's the benefit with only 10-base support?"
if we can support multiple bases with almost zero maintainace
overhead.

> 
> Brian
> 
> On Wed, Sep 22, 2021 at 8:09 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Tue, Sep 21, 2021 at 12:43:36PM -0700, Brian Geffon wrote:
> > > This change introduces an aged idle interface to the existing
> > > idle sysfs file for zram.
> > >
> > > When CONFIG_ZRAM_MEMORY_TRACKING is enabled the idle file
> > > now also accepts an integer argument. This integer is the
> > > age (in seconds) of pages to mark as idle. The idle file
> > > still supports 'all' as it always has. This new approach
> > > allows for much more control over which pages get marked
> > > as idle.
> > >
> > >   v2 -> v3:
> > >       - Correct unused variable warning when
> > >         CONFIG_ZRAM_MEMORY_TRACKING is not enabled.
> > >   v1 -> v2:
> > >       - Switch to using existing idle file.
> > >       - Dont compare ktime directly.
> > >
> > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > ---
> > >  Documentation/admin-guide/blockdev/zram.rst |  8 +++
> > >  drivers/block/zram/zram_drv.c               | 60 +++++++++++++++------
> > >  2 files changed, 52 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
> > > index 700329d25f57..8c8a92e5c00c 100644
> > > --- a/Documentation/admin-guide/blockdev/zram.rst
> > > +++ b/Documentation/admin-guide/blockdev/zram.rst
> > > @@ -328,6 +328,14 @@ as idle::
> > >  From now on, any pages on zram are idle pages. The idle mark
> > >  will be removed until someone requests access of the block.
> > >  IOW, unless there is access request, those pages are still idle pages.
> > > +Additionally, when CONFIG_ZRAM_MEMORY_TRACKING is enabled pages can be
> > > +marked as idle based on how long (in seconds) it's been since they were
> > > +last accessed, in seconds::
> > > +
> > > +        echo 86400 > /sys/block/zramX/idle
> > > +
> > > +In this example all pages which haven't been accessed in more than 86400
> > > +seconds (one day) will be marked idle.
> > >
> > >  Admin can request writeback of those idle pages at right timing via::
> > >
> > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > index fcaf2750f68f..2af5cdb8da1a 100644
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -291,22 +291,16 @@ static ssize_t mem_used_max_store(struct device *dev,
> > >       return len;
> > >  }
> > >
> > > -static ssize_t idle_store(struct device *dev,
> > > -             struct device_attribute *attr, const char *buf, size_t len)
> > > +/*
> > > + * Mark all pages which are older than or equal to cutoff as IDLE.
> > > + * Callers should hold the zram init lock in read mode
> > > + **/
> > > +static void mark_idle(struct zram *zram, ktime_t cutoff)
> > >  {
> > > -     struct zram *zram = dev_to_zram(dev);
> > > +     int is_idle = 1;
> > >       unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
> > >       int index;
> > >
> > > -     if (!sysfs_streq(buf, "all"))
> > > -             return -EINVAL;
> > > -
> > > -     down_read(&zram->init_lock);
> > > -     if (!init_done(zram)) {
> > > -             up_read(&zram->init_lock);
> > > -             return -EINVAL;
> > > -     }
> > > -
> > >       for (index = 0; index < nr_pages; index++) {
> > >               /*
> > >                * Do not mark ZRAM_UNDER_WB slot as ZRAM_IDLE to close race.
> > > @@ -314,14 +308,48 @@ static ssize_t idle_store(struct device *dev,
> > >                */
> > >               zram_slot_lock(zram, index);
> > >               if (zram_allocated(zram, index) &&
> > > -                             !zram_test_flag(zram, index, ZRAM_UNDER_WB))
> > > -                     zram_set_flag(zram, index, ZRAM_IDLE);
> > > +                             !zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> > > +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> > > +                     is_idle = (!cutoff || ktime_after(cutoff, zram->table[index].ac_time));
> > > +#endif
> > > +                     if (is_idle)
> > > +                             zram_set_flag(zram, index, ZRAM_IDLE);
> > > +             }
> > >               zram_slot_unlock(zram, index);
> > >       }
> > > +}
> > >
> > > -     up_read(&zram->init_lock);
> > > +static ssize_t idle_store(struct device *dev,
> > > +             struct device_attribute *attr, const char *buf, size_t len)
> > > +{
> > > +     struct zram *zram = dev_to_zram(dev);
> > > +     ktime_t cutoff_time = 0;
> > > +     ssize_t rv = -EINVAL;
> > >
> > > -     return len;
> > > +     if (!sysfs_streq(buf, "all")) {
> > > +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> > > +             u64 age_sec;
> > > +             /* If it did not parse as 'all' try to treat it as an integer */
> > > +             if (!kstrtoull(buf, 10, &age_sec))
> >
> > nit:
> > Do we need such limit base which work with only 10 base?
> > Passing 0 would give more flexibility.
> >
> > Otherwise, looks good to me.
> >
> > Thanks, Brian.
> >
> > > +                     cutoff_time = ktime_sub(ktime_get_boottime(),
> > > +                                     ns_to_ktime(age_sec * NSEC_PER_SEC));
> > > +             else
> > > +#endif
> > > +                     goto out;
> > > +     }
> > > +
> > > +     down_read(&zram->init_lock);
> > > +     if (!init_done(zram))
> > > +             goto out_unlock;
> > > +
> > > +     /* A age_sec of 0 marks everything as idle, this is the "all" behavior */
> > > +     mark_idle(zram, cutoff_time);
> > > +     rv = len;
> > > +
> > > +out_unlock:
> > > +     up_read(&zram->init_lock);
> > > +out:
> > > +     return rv;
> > >  }
> > >
> > >  #ifdef CONFIG_ZRAM_WRITEBACK
> > > --
> > > 2.33.0.464.g1972c5931b-goog
> > >
