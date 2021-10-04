Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA5C433EF
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 18:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE106140D
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 18:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbhJDSnV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhJDSnU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Oct 2021 14:43:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92726C061745
        for <linux-block@vger.kernel.org>; Mon,  4 Oct 2021 11:41:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id p13so40517061edw.0
        for <linux-block@vger.kernel.org>; Mon, 04 Oct 2021 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56z64RfaxhBPHKBxrKpIeCmw/JUaEkC5bctLSO4zbPw=;
        b=TeduhA16QD2I64VEL8/9gJBRrib/Wz2GZLhomm/YNweUBFDosOQiR+aEnQJnaC/TEW
         rWsreaFR7KDYuJkO4zUwgtEpOzn0aWtEK98XFefnumwNRlaJWh40mZStymnEvzxnk88j
         zDo4oOfjR9VHkw/c9lvbymAKvxfNTxpPsFq1WjxD2EJQn7uAHEXlvxUE0ZDh8ArzT3S3
         IN7GxnAFJHJscNHTl/7O5IHo/wjzjI6qPDHcjl38P3ERDrNyZmRb+PV0I2QJFQEEbjmb
         Rl2RjOVG0xNzpAGCG8S4/Ttiouc5c/C40giJRPxQDoKP3cpZSlQL13Qvzm3tYuWW3oDN
         pVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56z64RfaxhBPHKBxrKpIeCmw/JUaEkC5bctLSO4zbPw=;
        b=my8nPcSQL/oC7w4jpu5wLQ5B9o1RoVJ+y9jGqUpv7R4DSXDU4MRoLfgkz9CJ0qZwgy
         WQKkYwoor1i4fCz7Npzpt35W9Bgb3Fp/tzIE6Iey4gFH22Y4mfX2IFwoPo7GhRtszTyZ
         liJz4zDOlM09KnGsA+zGDH//0nNXsjCelQPUySBB9vJJsPPTlZ5ryMuvhmrRQrTIGkuR
         4SrBdAHPc1Fuh3FsNJPauEALocq568B/OVW/6KpcB0idVkZqUXERcA4E5CvslCXRtrfK
         XLi+M+rsnBt8Rt6Riosvxzmhz6Z+yXEhecdR0PdB8W1egDgc2BjjSB7vSrvmFrcCIiuP
         /uXA==
X-Gm-Message-State: AOAM530thlAHgF2FsfpMAO6ExePAU2BHZYa9DoF3ctkDtsMYakYKlZnS
        dEJ7aLZ83F8fX7c8Njfarz3i+VtFoo/OxnfLivfu/A==
X-Google-Smtp-Source: ABdhPJz2rknpyNQ8MGXFJG1LnJpKskoos7OkxWt2/J14Md3TpbhY+emzD05svJEHbtaRNGKVB9WKg4SX3f/nTp+xnhM=
X-Received: by 2002:a17:906:b098:: with SMTP id x24mr19388219ejy.88.1633372888755;
 Mon, 04 Oct 2021 11:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211001181627.394921-1-bgeffon@google.com> <YVtH60zyzq9AhUv2@google.com>
In-Reply-To: <YVtH60zyzq9AhUv2@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 4 Oct 2021 14:40:52 -0400
Message-ID: <CADyq12xk-2Fhnf_rJQ70oC1_98OEBJqwxOt6z=PpJa5V=X3dFQ@mail.gmail.com>
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

On Mon, Oct 4, 2021 at 2:29 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Oct 01, 2021 at 11:16:27AM -0700, Brian Geffon wrote:
> > There does not appear to be a technical reason to not
> > allow the zram backing device to be assigned after the
> > zram device is initialized.
> >
> > This change will allow for the backing device to be assigned
> > as long as no backing device is already assigned. In that
> > event backing_dev would return -EEXIST.
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >  drivers/block/zram/zram_drv.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index fcaf2750f68f..12b4555ee079 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -462,9 +462,9 @@ static ssize_t backing_dev_store(struct device *dev,
> >               return -ENOMEM;
> >
> >       down_write(&zram->init_lock);
> > -     if (init_done(zram)) {
> > -             pr_info("Can't setup backing device for initialized device\n");
> > -             err = -EBUSY;
> > +     if (zram->backing_dev) {
> > +             pr_info("Backing device is already assigned\n");
> > +             err = -EEXIST;
> >               goto out;
>
> Hi Brian,
>

Hi Minchan,

> I am worry about the inconsistency with other interface of current zram
> set up. They were supposed to set it up before zram disksize setting
> because it makes code more simple/maintainalbe in that we don't need
> to check some feature on the fly.
>
> Let's think about when zram extends the writeback of incompressible
> page on demand. The write path will need the backing_dev under
> down_read(&zarm->init_lock) or other conditional variable to check
> whether the feature is enabled or not on the fly.

I don't follow what you mean by that, writeback_store already holds
down_read(&zarm->init_lock).

Brian
