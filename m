Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D356C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 14:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11542081C
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 14:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg8YVYyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11542081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLIOpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:45:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36331 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeLIOpP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 09:45:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so6185025lfg.3;
        Sun, 09 Dec 2018 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8rvZRrhr8S716ZEGYPUCY0jiZKk7w2IaFybvj3M1Hs=;
        b=mg8YVYySiNGg1bOcpz/lX4nZMO9CbQlYreW7llCvr0CGeZ0oBpe3LZrVxAibM6IGoH
         sWJdixdtPsrRDE8Mt7ib+TwtoeTqpCALrwbl4MW+Zfo2m3TrDVSavSOJijyuciIln3in
         EUXmtf5j68blDGr/0QaRIlQh2r0tNMVuZJYZPhlKuVPW3yNqS1dFBb0P4z9RdlXy6F+F
         9pJGlERIqvC/+cNdSAa/KviPjgb1dbTCSGiBvmzUsp2lCKHxcn4mqbsDRNAQtjRyS9XU
         NBsM7a8J+iEN81UnsMcemfZ0hfseJCQCbTgs1eqlA0JbHe/wW4nZb+t2pJcRG/BfeUDi
         gERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8rvZRrhr8S716ZEGYPUCY0jiZKk7w2IaFybvj3M1Hs=;
        b=PnqDbbN1snYVyVH5zIWimOm7+vFv+qPh2ENGWCkzSVy+sWLz2P64plNIRe2dB7dusi
         edMNwqM4lvneBjsIHaLQKO6aPdmX7eW99LVwHJ4931WXl9N3zacKEQd5zznEUfTacR7/
         LqT6rA8OG59fkXizCP76r0A2yeaV/InhswlY/T9D8eyGu62MK2s1b6QC/Dx5GhU+6zHZ
         0alIQISvaiA1sjXwwvc/aU3LfEGDMapcAE3oi4DjZjo+1KFI4/HZrbWfey+x2JYMbjbp
         hqWhUqbqDYrZ3Ao/lbC2Ju1NSVCnnrhm5VfM+7eGPs45yNKQGM8LNvy0h5CQwyaFhhPG
         iNEg==
X-Gm-Message-State: AA+aEWaA5GlhDPFaFKwQ9Ggz9VgQpYdWqx3R02a4+JkijVWVNvpIAlSm
        bDAqTAtkx6Cne7F23b6wqvY1RscZQF3Mjd2/0Ss=
X-Google-Smtp-Source: AFSGD/X+FLPMJ+7YEXtQdCWnvQF8H4oOeOba+ik7SqKRJaTIUcXdrakMPXGcPqgvAk1/9IyvU7dtQS+ZOtJftrkVO2o=
X-Received: by 2002:a19:1a14:: with SMTP id a20mr4610304lfa.1.1544366712444;
 Sun, 09 Dec 2018 06:45:12 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181130093318eucas1p24feb8e649c8f244ce149a7f87e43c828@eucas1p2.samsung.com>
 <1543570361-3168-1-git-send-email-huijin.park@samsung.com> <20181130195607.GA27411@vader>
In-Reply-To: <20181130195607.GA27411@vader>
From:   Huijin Park <bbanghj.park@gmail.com>
Date:   Sun, 9 Dec 2018 23:44:59 +0900
Message-ID: <CAMy0x0kYs7-oK7__GK0uqaNdAwyH_y3RG+misbyKc2f=cgDeAA@mail.gmail.com>
Subject: Re: [PATCH,1/2] genhd: avoid overflow of sectors in disk_stats
To:     osandov@osandov.com
Cc:     huijin.park@samsung.com, adilger.kernel@dilger.ca,
        michaelcallahan@fb.com, osandov@fb.com, js07.lee@samsung.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar Sandoval,

On Sat, Dec 1, 2018 at 4:56 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Fri, Nov 30, 2018 at 04:32:40AM -0500, Huijin Park wrote:
> > From: "huijin.park" <huijin.park@samsung.com>
> >
> > This patch changes the 'sectors' type to an u64.
> > In 32 bit system, the 'sectors' can accumulate up to about 2TiB.
> > If a 32 bit system makes i/o over 2TiB while running,
> > the 'sectors' will overflow.
> > As a result, the part_stat_read(sectors), the diskstats in proc and
> > the (lifetime|session)_write_kbytes in sysfs return invalid statistic.
>
> What about parsers which expect it to be an unsigned long? E.g., iostat:
> https://github.com/sysstat/sysstat/blob/v12.1.1/rd_stats.c#L736
>
> At least with glibc, scanf seems to truncate sanely, but this appears to
> be undefined.

The glibc APIs such as scanf and strtoul set return value and errno
to ULONG_MAX and ERANGE in overflow case.
I think ULONG_MAX and ERANGE are better than reset to zero because
of overflow. At least, application can notice overflow with errno.
Besides nowadays, a 32 bit is not enough size to show
an i/o accumulated size.
I met a problem like below. So I suggested this patch.

sh-3.2# mount | grep p19
/dev/mmcblk0p19 on /ext4_dir type ext4 (rw,relatime,data=ordered)
sh-3.2# cat /sys/fs/ext4/mmcblk0p19/session_write_kbytes
2147467268
sh-3.2# cat /sys/fs/ext4/mmcblk0p19/lifetime_write_kbytes
2147568561
sh-3.2# dd if=/dev/zero of=/ext4_dir/temp.bin bs=1M count=20 oflag=sync
20+0 records in
20+0 records out
20971520 bytes (21 MB) copied,
0.621939 s, 33.7 MB/s
sh-3.2# cat /sys/fs/ext4/mmcblk0p19/session_write_kbytes
4524
sh-3.2# cat /sys/fs/ext4/mmcblk0p19/lifetime_write_kbytes
105817

>
> > Signed-off-by: huijin.park <huijin.park@samsung.com>
> > ---
> >  block/genhd.c         |    6 +++---
> >  include/linux/genhd.h |    2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 0145bcb..7518dcd 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -1343,10 +1343,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
> >               part_stat_unlock();
> >               part_in_flight(gp->queue, hd, inflight);
> >               seq_printf(seqf, "%4d %7d %s "
> > -                        "%lu %lu %lu %u "
> > -                        "%lu %lu %lu %u "
> > +                        "%lu %lu %llu %u "
> > +                        "%lu %lu %llu %u "
> >                          "%u %u %u "
> > -                        "%lu %lu %lu %u\n",
> > +                        "%lu %lu %llu %u\n",
> >                          MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
> >                          disk_name(gp, hd->partno, buf),
> >                          part_stat_read(hd, ios[STAT_READ]),
> > diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> > index 0c5ee17..5bf86f9 100644
> > --- a/include/linux/genhd.h
> > +++ b/include/linux/genhd.h
> > @@ -84,7 +84,7 @@ struct partition {
> >
> >  struct disk_stats {
> >       u64 nsecs[NR_STAT_GROUPS];
> > -     unsigned long sectors[NR_STAT_GROUPS];
> > +     u64 sectors[NR_STAT_GROUPS];
> >       unsigned long ios[NR_STAT_GROUPS];
> >       unsigned long merges[NR_STAT_GROUPS];
> >       unsigned long io_ticks;
> > --
> > 1.7.9.5
> >

Thanks,
Huijin
