Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D45EC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 08:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2646A214F1
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 08:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foZj2Y8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2646A214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeKNSRv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:17:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55013 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeKNSRv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 13:17:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so14529661wma.4;
        Wed, 14 Nov 2018 00:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVTQmPEslz7jdCeO4jj0XihLYDyKdWTcfs6YfEV7dn8=;
        b=foZj2Y8+vTh6bMhSo/c7f2vbdNYXZrUHa99YicLwM5P0Dm7vrPRAfnT9Tks0zMeUwZ
         tJ8elyeH1ew7YyQs8KyaZv+xI0X8iZG4GWxUBhCrWr7ftVlc5I3jECbkucUrTjZ6bByw
         JmvypdgMSw7tScG2tAV+N5vMeSWAvXqFAbTZP3256SislI8WWbwwmx3J8wr6KM/B7cBO
         ah9rWp+6GzZ0wWjaa60T3qnr1qvAI2vdkgoB48EUmzph98JAY6Ei+4w+VtIGODp4MoFZ
         KZVYtz31VOGVDU5TTmoBDDPcctn4pjRh8zEr0ZR5lC1xqEyaM3F98NBYuIoVh/YpwFWj
         j3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVTQmPEslz7jdCeO4jj0XihLYDyKdWTcfs6YfEV7dn8=;
        b=H6ZoaDC7kYtPqWKjhHzK2at9E6uDuL+Fz21doXEYOdUYnHWzFRCkmnJyrM+kSqWg8Z
         d1fnWxKDyZkoQY4w8qFmx0qzcpoC9a4aq5L82xAkOY3JFhPBD6ACj0GX4blIArEEaQfH
         RG7WhGnzgCyi5DDgr2beErVla35Ju2v5HaTGbFhrMOK9eKOs9OpcImcAGjuB8T2shRLO
         YJtkHVw0ODjrUk7rYpXy1p4KdlUu0hVT40Qei4kMqaTK2u9tG6Bw5x6263r7Nn5wArne
         RJSAg67Aa9ewg4WnbbiVPTK0Ol6F3izeQpbC2TLNDFeWb8V35XJja+TaKEqPSojZU09M
         aSbQ==
X-Gm-Message-State: AGRZ1gKyHidJj439/dU6vQIogsEheYb38xd6IB7NPjKC2NgcP34j5DKv
        s0UMb8G7eosKAJB80vCbjALkkz3gpT/+n8+rZ4uwXaD3
X-Google-Smtp-Source: AJdET5cwjurzFmNlxQ3aUNZ84wdedBEYbQFS6fuq5gkTUxgc0LzGCn6LRXxp4OloByU+H4bWfh0/RywHDrgP1YEXqaY=
X-Received: by 2002:a1c:1f11:: with SMTP id f17mr1045869wmf.56.1542183339668;
 Wed, 14 Nov 2018 00:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20181113214337.20581-1-david@fromorbit.com> <CACVXFVPS8RRYw4g-UjaDFW1Mrx_tv5V6SsSyKeQ9pyBLi2zrFA@mail.gmail.com>
 <20181114080859.GU19305@dastard>
In-Reply-To: <20181114080859.GU19305@dastard>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 14 Nov 2018 16:15:26 +0800
Message-ID: <CACVXFVNCvinW7eDaOtpGTrpiv+6z4Cjn=tsjuHoY8emphF6-1g@mail.gmail.com>
Subject: Re: [PATCH] block: fix 32 bit overflow in __blkdev_issue_discard()
To:     Dave Chinner <david@fromorbit.com>
Cc:     "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 4:09 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Nov 14, 2018 at 10:53:11AM +0800, Ming Lei wrote:
> > On Wed, Nov 14, 2018 at 5:44 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > From: Dave Chinner <dchinner@redhat.com>
> > >
> > > A discard cleanup merged into 4.20-rc2 causes fstests xfs/259 to
> > > fall into an endless loop in the discard code. The test is creating
> > > a device that is exactly 2^32 sectors in size to test mkfs boundary
> > > conditions around the 32 bit sector overflow region.
> > >
> > > mkfs issues a discard for the entire device size by default, and
> > > hence this throws a sector count of 2^32 into
> > > blkdev_issue_discard(). It takes the number of sectors to discard as
> > > a sector_t - a 64 bit value.
> > >
> > > The commit ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
> > > takes this sector count and casts it to a 32 bit value before
> > > comapring it against the maximum allowed discard size the device
> > > has. This truncates away the upper 32 bits, and so if the lower 32
> > > bits of the sector count is zero, it starts issuing discards of
> > > length 0. This causes the code to fall into an endless loop, issuing
> > > a zero length discards over and over again on the same sector.
> > >
> > > Fixes: ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  block/blk-lib.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > > index e8b3bb9bf375..144e156ed341 100644
> > > --- a/block/blk-lib.c
> > > +++ b/block/blk-lib.c
> > > @@ -55,9 +55,12 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> > >                 return -EINVAL;
> > >
> > >         while (nr_sects) {
> > > -               unsigned int req_sects = min_t(unsigned int, nr_sects,
> > > +               sector_t req_sects = min_t(sector_t, nr_sects,
> > >                                 bio_allowed_max_sectors(q));
> >
> > bio_allowed_max_sectors(q) is always < UINT_MAX, and 'sector_t' is only
> > required during the comparison, so another simpler fix might be the following,
> > could you test if it is workable?
> >
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index e8b3bb9bf375..6ef44f99e83f 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -55,7 +55,7 @@ int __blkdev_issue_discard(struct block_device
> > *bdev, sector_t sector,
> >                 return -EINVAL;
> >
> >         while (nr_sects) {
> > -               unsigned int req_sects = min_t(unsigned int, nr_sects,
> > +               unsigned int req_sects = min_t(sector_t, nr_sects,
> >                                 bio_allowed_max_sectors(q));
>
> Rearrange the deck chairs all you like, just make sure you fix your
> regression test suite to exercise obvious boundary conditions like
> this so the next cleanup doesn't break the code again.

Good point, we may add comment on the overflow story.

>
> > >
> > > +               WARN_ON_ONCE(req_sects == 0);
> >
> > The above line isn't necessary given 'nr_sects' can't be zero.
>
> Except it was 0 and it caused the bug I had to fix. So it should
> have a warning on it.

Obviously, it can't be zero except CPU is broken, :-)

Thanks,
Ming Lei
