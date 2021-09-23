Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8976BC433FE
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 00:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AC061050
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 00:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhIWAow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 20:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbhIWAov (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 20:44:51 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35641C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 17:43:21 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t189so7254792oie.7
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YzPGdIXUc/n+UBh3Q3cyORP7gAvTv0HxiAeEJD2X/M=;
        b=o9cAfzvPlxeahlg+EGKgy1FyV3/N+o2QmQ1HklIF0pZG+dic83eqjqpr1UCsFGjUZY
         g2heg7E3OCpWc/asmqQY5rFyZ+ysANmmp0qK+qHKeXBojcc/pLy4pa51DlWNv/vPYpem
         7vnxm2RaEpXfZpdIyYC91I7XXpUY2APoDdzLWnIhgeLnNfoatSJvRCwvq/t1VT00KkHk
         9bOnggMze/BZaZ8oPUf69pu2nIgREXa3ZXmAHqQsGBZjmoBUi5c2CmK0LjLflvv/gDRF
         fSg+yMyHXwOcnHjvvp0EbRlr3lMHsw2lQQVYlB5ERGMSVXFTVQ/bqHM8JeJHdYm/W/Hr
         RdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YzPGdIXUc/n+UBh3Q3cyORP7gAvTv0HxiAeEJD2X/M=;
        b=34r37Pzu3MtQSyk8BM/w+NZbewIZRcADNd3onXU7YNWIbbkpFtKpTvFoUW/Ol/x6hR
         iIXMvT6IZX7FcRc02isk4Eo9t8Nn+wqUmP1G2iiWwL/iMRAOvtT84b9pDXBW/6XQ09BB
         JVE02P1BlS3aF4jd/MuW1juC1XOSGk1h2AUH7RbeeT2lVF0HFOEBYhSY3hVYOZ11DMc9
         6iHVwmrPp/ttC6bmB0MSRPQDgWpyb6f4HqZlwS/DmyPPiuLHMnDWfsd5iGuUNr1BHndV
         k2q+CHgGqSffZtjgKkzF69TYHMnx6vj0j2f7Qzd9Ty34BiQI8T+H+LjE4zige2jEeiiB
         ytIw==
X-Gm-Message-State: AOAM531viWeQThO+fhJXdGpkXniZeMp/9th4I6SoExrUHdDhwea5K2VU
        mWosZMwxRqqt96ueTCmdeMk9Gafv06GJWu9Pfwse2g==
X-Google-Smtp-Source: ABdhPJxOK+CVcYZjH4ildch2fjdVvtzb7hwaN4QxvcaP1yaHV+0zUJ+RxGnAcxkjCSbUISAVEIo7hPbbn2VKH3Xhx4E=
X-Received: by 2002:aca:af56:: with SMTP id y83mr1656895oie.170.1632357800207;
 Wed, 22 Sep 2021 17:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210917210640.214211-1-bgeffon@google.com> <20210921194336.947226-1-bgeffon@google.com>
 <YUvFvsyrp86mbjbY@google.com>
In-Reply-To: <YUvFvsyrp86mbjbY@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 22 Sep 2021 20:42:44 -0400
Message-ID: <CADyq12yaSOdUAE7i9TtFEB-ryDx2kLYCH8eAxrUQGEPizw9ahg@mail.gmail.com>
Subject: Re: [PATCH v3] zram: Introduce an aged idle interface
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
Thank you for taking a look. I'm happy to make that change, but I
personally cannot see why userspace would want to do something like
idle pages older than "0x3C seconds" or "0o250600 seconds," it just
seems like a strange way to represent seconds. What do you think?

Brian

On Wed, Sep 22, 2021 at 8:09 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, Sep 21, 2021 at 12:43:36PM -0700, Brian Geffon wrote:
> > This change introduces an aged idle interface to the existing
> > idle sysfs file for zram.
> >
> > When CONFIG_ZRAM_MEMORY_TRACKING is enabled the idle file
> > now also accepts an integer argument. This integer is the
> > age (in seconds) of pages to mark as idle. The idle file
> > still supports 'all' as it always has. This new approach
> > allows for much more control over which pages get marked
> > as idle.
> >
> >   v2 -> v3:
> >       - Correct unused variable warning when
> >         CONFIG_ZRAM_MEMORY_TRACKING is not enabled.
> >   v1 -> v2:
> >       - Switch to using existing idle file.
> >       - Dont compare ktime directly.
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >  Documentation/admin-guide/blockdev/zram.rst |  8 +++
> >  drivers/block/zram/zram_drv.c               | 60 +++++++++++++++------
> >  2 files changed, 52 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
> > index 700329d25f57..8c8a92e5c00c 100644
> > --- a/Documentation/admin-guide/blockdev/zram.rst
> > +++ b/Documentation/admin-guide/blockdev/zram.rst
> > @@ -328,6 +328,14 @@ as idle::
> >  From now on, any pages on zram are idle pages. The idle mark
> >  will be removed until someone requests access of the block.
> >  IOW, unless there is access request, those pages are still idle pages.
> > +Additionally, when CONFIG_ZRAM_MEMORY_TRACKING is enabled pages can be
> > +marked as idle based on how long (in seconds) it's been since they were
> > +last accessed, in seconds::
> > +
> > +        echo 86400 > /sys/block/zramX/idle
> > +
> > +In this example all pages which haven't been accessed in more than 86400
> > +seconds (one day) will be marked idle.
> >
> >  Admin can request writeback of those idle pages at right timing via::
> >
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index fcaf2750f68f..2af5cdb8da1a 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -291,22 +291,16 @@ static ssize_t mem_used_max_store(struct device *dev,
> >       return len;
> >  }
> >
> > -static ssize_t idle_store(struct device *dev,
> > -             struct device_attribute *attr, const char *buf, size_t len)
> > +/*
> > + * Mark all pages which are older than or equal to cutoff as IDLE.
> > + * Callers should hold the zram init lock in read mode
> > + **/
> > +static void mark_idle(struct zram *zram, ktime_t cutoff)
> >  {
> > -     struct zram *zram = dev_to_zram(dev);
> > +     int is_idle = 1;
> >       unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
> >       int index;
> >
> > -     if (!sysfs_streq(buf, "all"))
> > -             return -EINVAL;
> > -
> > -     down_read(&zram->init_lock);
> > -     if (!init_done(zram)) {
> > -             up_read(&zram->init_lock);
> > -             return -EINVAL;
> > -     }
> > -
> >       for (index = 0; index < nr_pages; index++) {
> >               /*
> >                * Do not mark ZRAM_UNDER_WB slot as ZRAM_IDLE to close race.
> > @@ -314,14 +308,48 @@ static ssize_t idle_store(struct device *dev,
> >                */
> >               zram_slot_lock(zram, index);
> >               if (zram_allocated(zram, index) &&
> > -                             !zram_test_flag(zram, index, ZRAM_UNDER_WB))
> > -                     zram_set_flag(zram, index, ZRAM_IDLE);
> > +                             !zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> > +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> > +                     is_idle = (!cutoff || ktime_after(cutoff, zram->table[index].ac_time));
> > +#endif
> > +                     if (is_idle)
> > +                             zram_set_flag(zram, index, ZRAM_IDLE);
> > +             }
> >               zram_slot_unlock(zram, index);
> >       }
> > +}
> >
> > -     up_read(&zram->init_lock);
> > +static ssize_t idle_store(struct device *dev,
> > +             struct device_attribute *attr, const char *buf, size_t len)
> > +{
> > +     struct zram *zram = dev_to_zram(dev);
> > +     ktime_t cutoff_time = 0;
> > +     ssize_t rv = -EINVAL;
> >
> > -     return len;
> > +     if (!sysfs_streq(buf, "all")) {
> > +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> > +             u64 age_sec;
> > +             /* If it did not parse as 'all' try to treat it as an integer */
> > +             if (!kstrtoull(buf, 10, &age_sec))
>
> nit:
> Do we need such limit base which work with only 10 base?
> Passing 0 would give more flexibility.
>
> Otherwise, looks good to me.
>
> Thanks, Brian.
>
> > +                     cutoff_time = ktime_sub(ktime_get_boottime(),
> > +                                     ns_to_ktime(age_sec * NSEC_PER_SEC));
> > +             else
> > +#endif
> > +                     goto out;
> > +     }
> > +
> > +     down_read(&zram->init_lock);
> > +     if (!init_done(zram))
> > +             goto out_unlock;
> > +
> > +     /* A age_sec of 0 marks everything as idle, this is the "all" behavior */
> > +     mark_idle(zram, cutoff_time);
> > +     rv = len;
> > +
> > +out_unlock:
> > +     up_read(&zram->init_lock);
> > +out:
> > +     return rv;
> >  }
> >
> >  #ifdef CONFIG_ZRAM_WRITEBACK
> > --
> > 2.33.0.464.g1972c5931b-goog
> >
