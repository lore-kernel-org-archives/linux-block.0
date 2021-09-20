Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B7DC4332F
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B9260F46
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346004AbhIUCR1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbhIUBsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 21:48:18 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA0C04983A
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 14:30:22 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r26so26745606oij.2
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qBGf2RxdhMVJ9ELb5q3Rnbf1pGunp9HuS2pZq9lZ+k=;
        b=Txim1HEdFX3kooa4u2VUlvVTbqhBKnGZXNnAOJ8Y7I7FTyK1jzLQHGNLTFXvMqDqcV
         qc4PvxrVl8ZztYq9D0K7ASe/bwxdeHMTBfu/Ee6YzByjJxT56OS10K7/7/UgQcm1gZYj
         dTJzOw4aJqwZkS69gxuHKg4XFXbsncrkiblYbt+ZsxgV3YGNxUuXd5JTjDyMqA4WcHuX
         KGtLcPS11r/oZmK/E+NPTiY7ihAykTBT0fJUEH3Dyj9mT7ZoPAl782E1g1gSMqfx857v
         wmXpsCa//X9KoLZQz3/NKsQPG3/bgc5aZKwm/kYugPl73rgU6jzMtFOsTu22m8dsC+zK
         KgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qBGf2RxdhMVJ9ELb5q3Rnbf1pGunp9HuS2pZq9lZ+k=;
        b=GiWcDihGsgiGTD13xTgfOeeSaubgKCxTC6XryTPviOZrJXvjP2mG8pLNfM8A49n0j3
         W/LDYtm8fuCuOdUO9ynOdlCh78TznpZ2HmbSY1GH+yjNX+ZiE/kUi8TK0eeWKfvo7yAf
         pJselphKytokRVlYZeZ8uF807OflGSc1FjwE4Hw7Mztk2mMVULdbTYDSm3/7vemtK1m1
         F2ou1H5BoqtkiMTPyxqlRlLCalXhJDhodliRIaHobZpts/Xpys+Q2Zr4Ucmlnu7z8Sig
         BnwraYAWEr7nAQwwwoVfYQ+u4wghRSdrHDYpF323xqSlRq5M2caUH32PLrMCNikhC+Gd
         FgEA==
X-Gm-Message-State: AOAM5325osWTE8z/tNYrokTMPgGFf7kHIHPmL1o0prWYuaUglOBegmBW
        TT3MQGCtD9vqB86ymO6fgXQbeXEdjasHJH8ZHQurVA==
X-Google-Smtp-Source: ABdhPJwW0yn7WSbY2KJXuduv0Kh6DBTWYhyvEYlj8ObHH6kpg8wcsoq1FGaI1T/Y9KtI//Xio/ZA4DUBx52SeP+uHuo=
X-Received: by 2002:a05:6808:6c2:: with SMTP id m2mr941032oih.63.1632173421950;
 Mon, 20 Sep 2021 14:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210917210640.214211-1-bgeffon@google.com> <YUj5zkRN+N404nbe@google.com>
In-Reply-To: <YUj5zkRN+N404nbe@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 20 Sep 2021 17:29:45 -0400
Message-ID: <CADyq12wwWE7qe1ik+Qges5KHScnbt+mpMXuNzrrM+aC27PvhHA@mail.gmail.com>
Subject: Re: [PATCH] zram: Introduce an aged idle interface
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

On Mon, Sep 20, 2021 at 5:15 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Sep 17, 2021 at 02:06:40PM -0700, Brian Geffon wrote:
> > This change introduces a new sysfs file for the zram idle interface.
> > The current idle interface has only a single mode "all." This is
> > severely limiting in that it requires that you have the foresight
> > to know that you'll want to have pages idle at some point in the future
> > and forces the user to mark everything as idle.
> >
> > This new proposed file idle_aged takes a single integer argument which
> > represents the age of the pages (in seconds since access) to mark as idle.
> > Because it requires accessed tracking it is only enabled when
> > CONFIG_ZRAM_MEMORY_TRACKING is enabled. There are a few
> > reasons why  this is being proposed as a new file rather than extending
> > the existing file. The first reason is that it wouldn't allow more code
> > sharing as this change already refactors the existing code to do so.
> > Secondly, having a standalone file allows a caller to quickly check if this
> > idle_aged interface is supported. Finally, it simplifies the parsing
> > logic because now you only need to parse an int rather than more complex
> > logic which would need to parse things like "aged 50."
>
> I am not convinced with create new sysfs node to support the aged time.
> The reason I used the "all" was to have the room to support the aged
> time as you suggested for the future. IOW, If the value is not "all" but
> "only numeric", we could take it as "aged" value.
>
> And then, we can write up in the doc "The age-based idle" supported by
> kernel version 5.XX with CONFIG_ZRAM_MEMORY_TRACKING.
> I understand the separate interface will make code simple but not sure
> it's worth to create another sysfs knob.
>
> Any thoughts?

Sure, Sergey had similar feedback on that. I'll mail a new patch that
uses the existing knob but attempts to parse the input as an integer.

>
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >  Documentation/admin-guide/blockdev/zram.rst | 11 ++-
> >  drivers/block/zram/zram_drv.c               | 75 +++++++++++++++++----
> >  2 files changed, 70 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
> > index 700329d25f57..ecd1c4916a1c 100644
> > --- a/Documentation/admin-guide/blockdev/zram.rst
> > +++ b/Documentation/admin-guide/blockdev/zram.rst
> > @@ -209,6 +209,8 @@ compact                   WO      trigger memory compaction
> >  debug_stat           RO      this file is used for zram debugging purposes
> >  backing_dev          RW      set up backend storage for zram to write out
> >  idle                 WO      mark allocated slot as idle
> > +idle_aged              WO      mark allocated slot older than 'age' seconds
> > +                                as idle (see later)
> >  ======================  ======  ===============================================
> >
> >
> > @@ -325,8 +327,13 @@ as idle::
> >
> >       echo all > /sys/block/zramX/idle
> >
> > -From now on, any pages on zram are idle pages. The idle mark
> > -will be removed until someone requests access of the block.
> > +Alternatively if the config option CONFIG_ZRAM_MEMORY_TRACKING is enabled
> > +the idle_aged interface can be used to mark only pages older than 'age'
> > +seconds as idle::
> > +
> > +        echo 86400 > /sys/block/zramX/idle_aged
> > +
> > +The idle mark will be removed until someone requests access of the block.
> >  IOW, unless there is access request, those pages are still idle pages.
> >
> >  Admin can request writeback of those idle pages at right timing via::
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index fcaf2750f68f..a371dc0edf9d 100644
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
> > @@ -314,16 +308,63 @@ static ssize_t idle_store(struct device *dev,
> >                */
> >               zram_slot_lock(zram, index);
> >               if (zram_allocated(zram, index) &&
> > -                             !zram_test_flag(zram, index, ZRAM_UNDER_WB))
> > -                     zram_set_flag(zram, index, ZRAM_IDLE);
> > +                             !zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> > +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> > +                     is_idle = (!cutoff || cutoff >= zram->table[index].ac_time);
>
> I am not sure it's a good idea to compare those ktime_t directly
> without using the ktime API(e.g., ktime_after or ktime_before).
> Maybe, we can get age_sec ktime_t directly as a argument and then
> use the ktime API with ktime_get_boottime to compare them.

I will make this change in the next version of the patch.

>
> > +#endif
> > +                     if (is_idle)
> > +                             zram_set_flag(zram, index, ZRAM_IDLE);
> > +             }
> >               zram_slot_unlock(zram, index);
> >       }
> > +}
> > +
> > +static ssize_t idle_store(struct device *dev,
> > +             struct device_attribute *attr, const char *buf, size_t len)
> > +{
> > +     struct zram *zram = dev_to_zram(dev);
> > +
> > +     if (!sysfs_streq(buf, "all"))
> > +             return -EINVAL;
> > +
> > +     down_read(&zram->init_lock);
> > +     if (!init_done(zram)) {
> > +             up_read(&zram->init_lock);
> > +             return -EINVAL;
> > +     }
> >
> > +     /* Mark everything as idle */
> > +     mark_idle(zram, 0);
> >       up_read(&zram->init_lock);
> >
> >       return len;
> >  }
> >
> > +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> > +static ssize_t idle_aged_store(struct device *dev,
> > +             struct device_attribute *attr, const char *buf, size_t len)
> > +{
> > +     struct zram *zram = dev_to_zram(dev);
> > +     ktime_t cutoff_time;
> > +     u64 age_sec;
> > +     ssize_t rv = -EINVAL;
> > +
> > +     down_read(&zram->init_lock);
> > +     if (!init_done(zram))
> > +             goto out;
> > +
> > +     if (kstrtoull(buf, 10, &age_sec))
> > +             goto out;
> > +
> > +     rv = len;
> > +     cutoff_time = ktime_sub(ktime_get_boottime(), ns_to_ktime(age_sec * NSEC_PER_SEC));
> > +     mark_idle(zram, cutoff_time);
> > +out:
> > +     up_read(&zram->init_lock);
> > +     return rv;
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_ZRAM_WRITEBACK
> >  static ssize_t writeback_limit_enable_store(struct device *dev,
> >               struct device_attribute *attr, const char *buf, size_t len)
> > @@ -1840,6 +1881,9 @@ static DEVICE_ATTR_WO(reset);
> >  static DEVICE_ATTR_WO(mem_limit);
> >  static DEVICE_ATTR_WO(mem_used_max);
> >  static DEVICE_ATTR_WO(idle);
> > +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> > +static DEVICE_ATTR_WO(idle_aged);
> > +#endif
> >  static DEVICE_ATTR_RW(max_comp_streams);
> >  static DEVICE_ATTR_RW(comp_algorithm);
> >  #ifdef CONFIG_ZRAM_WRITEBACK
> > @@ -1857,6 +1901,9 @@ static struct attribute *zram_disk_attrs[] = {
> >       &dev_attr_mem_limit.attr,
> >       &dev_attr_mem_used_max.attr,
> >       &dev_attr_idle.attr,
> > +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> > +     &dev_attr_idle_aged.attr,
> > +#endif
> >       &dev_attr_max_comp_streams.attr,
> >       &dev_attr_comp_algorithm.attr,
> >  #ifdef CONFIG_ZRAM_WRITEBACK
> > --
> > 2.33.0.464.g1972c5931b-goog
> >

Thank you for looking,
Brian
