Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC9DC433FE
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 20:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA4D61357
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 20:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhJDU4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 16:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhJDU4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Oct 2021 16:56:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F69CC061745;
        Mon,  4 Oct 2021 13:54:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23-20020a17090a591700b001976d2db364so803199pji.2;
        Mon, 04 Oct 2021 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kZJWM4F6Z6unu/rs+8fm9uleDQhYGGgncRQjKQf/aDk=;
        b=VWSK07yHbpdJGE2T9j6a20cM1d6NclHBP9VWgpxpQVBKyrqPP+X9QuK0NWKLKwBFZP
         hIzkqSNpOh88uOkBFgCQh5FDc0tPCOiJZpU7XbluN9peyZ90NjAu+9M6+96g+BGlybbX
         fHAB8cuFj0j4eOL7GjaQkNtxDiRJ5dghYWoxFhGMU33+jQkyreqHyG6dmMTvIfaYu8lY
         RbVRFQO80ucTXL2Vlu3n96jeQfwtj4sLcuJb0oKO7xr4MIYuN7hRYSAHbpWHFFYwc2U7
         kV7RQPl06tqo+8wljn+b6zD3aO55ziRIXg8+TTnrSch8bq0dfYC7S/3/5lkL3FwO9I98
         9XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kZJWM4F6Z6unu/rs+8fm9uleDQhYGGgncRQjKQf/aDk=;
        b=pFpn8MtIKOSDhsByuHiLcaVjXt3wIIB27rBPH9VuGaBWWrtN6Ck+dmafZ6Bi6gSEej
         WElrolo8LDttB38jn6SaONXjodHuzuoILuLvgOSPsSLLfRhxZO6aWNhZg+tnZQX8HyBK
         GRHewGRuPAnyDJ9RRrczdMlhLMnr1RZWj2SCcslAwZ6eFWUGblLA6ZohqdtJ70+oXq0H
         eOCuRMFyfxG85rnrqQMFOYoVD5xsI3xZuW2t1rGlyYndjkAwIy0txJvgtVslYt+EPTfU
         k1nHw+f9zpXUujn81xG79uznL0Ihnyo7mNrLhMroI8O25Acf5TS5n1EKm/M8XudUUz5C
         vHJg==
X-Gm-Message-State: AOAM531965giF2VQW+4JtTgIJgT4dZocMo/GPob1YnT7PF/JfUfo4GYT
        3mt/4AaIXSvD1rev7/TU7UlSTcPcB8Q=
X-Google-Smtp-Source: ABdhPJyhKXQQOv4O2I8Q2nIpCs8vrjSKNrTVCZHyKhMRjpWm+JvPOdgiWJEm9Z0ToGlZ1m0MjdP8gw==
X-Received: by 2002:a17:902:6b01:b0:13e:50bb:790f with SMTP id o1-20020a1709026b0100b0013e50bb790fmr1626001plk.42.1633380896502;
        Mon, 04 Oct 2021 13:54:56 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:db55:938c:e15a:4670])
        by smtp.gmail.com with ESMTPSA id d60sm11539860pjk.49.2021.10.04.13.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 13:54:56 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 4 Oct 2021 13:54:54 -0700
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
Message-ID: <YVtqHv+p3uYkbu5E@google.com>
References: <20211001181627.394921-1-bgeffon@google.com>
 <YVtH60zyzq9AhUv2@google.com>
 <CADyq12xk-2Fhnf_rJQ70oC1_98OEBJqwxOt6z=PpJa5V=X3dFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12xk-2Fhnf_rJQ70oC1_98OEBJqwxOt6z=PpJa5V=X3dFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 04, 2021 at 02:40:52PM -0400, Brian Geffon wrote:
> On Mon, Oct 4, 2021 at 2:29 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Fri, Oct 01, 2021 at 11:16:27AM -0700, Brian Geffon wrote:
> > > There does not appear to be a technical reason to not
> > > allow the zram backing device to be assigned after the
> > > zram device is initialized.
> > >
> > > This change will allow for the backing device to be assigned
> > > as long as no backing device is already assigned. In that
> > > event backing_dev would return -EEXIST.
> > >
> > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > ---
> > >  drivers/block/zram/zram_drv.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > index fcaf2750f68f..12b4555ee079 100644
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -462,9 +462,9 @@ static ssize_t backing_dev_store(struct device *dev,
> > >               return -ENOMEM;
> > >
> > >       down_write(&zram->init_lock);
> > > -     if (init_done(zram)) {
> > > -             pr_info("Can't setup backing device for initialized device\n");
> > > -             err = -EBUSY;
> > > +     if (zram->backing_dev) {
> > > +             pr_info("Backing device is already assigned\n");
> > > +             err = -EEXIST;
> > >               goto out;
> >
> > Hi Brian,
> >
> 
> Hi Minchan,
> 
> > I am worry about the inconsistency with other interface of current zram
> > set up. They were supposed to set it up before zram disksize setting
> > because it makes code more simple/maintainalbe in that we don't need
> > to check some feature on the fly.
> >
> > Let's think about when zram extends the writeback of incompressible
> > page on demand. The write path will need the backing_dev under
> > down_read(&zarm->init_lock) or other conditional variable to check
> > whether the feature is enabled or not on the fly.
> 
> I don't follow what you mean by that, writeback_store already holds
> down_read(&zarm->init_lock).

I should have explained a bit more. Sorry about that.
I am thinking about a feature to deal with incompressible page.
Let's have an example to handle incompressible page for that.

zram_bvec_rw
  zram_bvec_write
    if (comp_len >= huge_class)
        zs_page_writeback
            down_read(&zram->init_lock) or some other way

It's just idea for incompressible page but we might intorduce
the way for other compresible pages, too at some condition.
