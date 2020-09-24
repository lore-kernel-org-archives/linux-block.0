Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1945BC4363D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03352395C
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 17:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYPCEzSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgIXRXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXRXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 13:23:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8117AC0613CE;
        Thu, 24 Sep 2020 10:23:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so174784wmj.5;
        Thu, 24 Sep 2020 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwm0I/73CXEvcdqNhEVW2sgbHemmAHk97ySVunbKesM=;
        b=JYPCEzSQhqij3wlFWVns8cy3+02op6BPaj7M+SB/4NKMMYuel93ZsT7tCYMaSWlhPk
         w+3PLjDRqgvziZJHPBDoFbr/P7t/46yWvIFOV6XBP6KaQvByVnL5B3YSyaR9e7xW4aki
         TMFg7v66aau+lvQs7NVrnaUtuPcP8IIsjmIbmwURI4MUVVDI0aK3Dp1UMc61mqks30sp
         LklJGXF+2mhm6H1T53VN3yfGij/VIo0pWRMjHEChXN7UIwyGsFjGwmGCzMcXYk1NQBVC
         xexJerd1ooUn2jGI3xs0qrdCZ9y4QI/6rYmUsg+VgOUps4NeansAuO+Gg2zXJcBIZxLd
         G66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwm0I/73CXEvcdqNhEVW2sgbHemmAHk97ySVunbKesM=;
        b=dPUlGg+dQrMRDIZ99BOI38yRytadJLhih+0M8+ng7k8qGoyaYRZ8UZ4Qx3jhrRc+5l
         quaFy0/ENEIR0CEX784+cBqw/AEsxtNfADVzycy29t02Jj5ZjbhbSxmYcUJRd6d9o40r
         oUJcgtKoEeAnKI260eQybvAdzo4LOoUGI1SJFoSmui17W1ODT+a2LQ+mVr6dj9yJeORT
         M/gQfyS9qHseOfnuoDX8RcF9uFEJc/8vqH0oE4l7DT23MmnRYK0QXqNc6+47C1YF1rMp
         ODFnDBKcF5bo/TIdLiUC295BNM984lJ4phVZ9wbUQGqvFtRTA2aDsakAlkd5eZaXViaL
         q2xA==
X-Gm-Message-State: AOAM532qiYWmhUnxNnKT9EFZm7/2X9kR3ADdDhUTA83rSqxf3GFkjNfp
        cZqTUQCWPdUnJmPl0KCWx90jCPj7gTHY0NXJrEY=
X-Google-Smtp-Source: ABdhPJz6ZUHRrBm5HG3ihrgDUKoeFb0W6lklPaGT74Ne9oXT5BMJoHWSv1PT2PrZ8ymsZfgaxwwo3fjWvR5fq5Yq3Yg=
X-Received: by 2002:a1c:7f8b:: with SMTP id a133mr207595wmd.155.1600968182008;
 Thu, 24 Sep 2020 10:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200924062620epcas5p2f0468a1f41d4177ce15727c519bfbad5@epcas5p2.samsung.com>
 <20200924062136.47019-1-joshi.k@samsung.com> <CY4PR04MB375112089B44648B524EC7E6E7390@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB375112089B44648B524EC7E6E7390@CY4PR04MB3751.namprd04.prod.outlook.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Thu, 24 Sep 2020 22:52:36 +0530
Message-ID: <CA+1E3rL5yBCS4VH1v7pR8Q_88SQoC-oCYWSMRurRzV5AiETrcA@mail.gmail.com>
Subject: Re: [PATCH] null_blk: synchronization fix for zoned device
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "selvakuma.s1@samsung.com" <selvakuma.s1@samsung.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the review. I'll apply this feedback in V2.

On Thu, Sep 24, 2020 at 2:13 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/09/24 15:26, Kanchan Joshi wrote:
> > Parallel write,read,zone-mgmt operations accessing/altering zone state
> > and write-pointer may get into race. Avoid the situation by using a new
> > spinlock for zoned device.
> > Concurrent zone-appends (on a zone) returning same write-pointer issue
> > is also avoided using this lock.
> >
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > ---
> >  drivers/block/null_blk.h       |  1 +
> >  drivers/block/null_blk_zoned.c | 84 +++++++++++++++++++++++-----------
> >  2 files changed, 58 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
> > index daed4a9c3436..b3f4d62e7c38 100644
> > --- a/drivers/block/null_blk.h
> > +++ b/drivers/block/null_blk.h
> > @@ -44,6 +44,7 @@ struct nullb_device {
> >       unsigned int nr_zones;
> >       struct blk_zone *zones;
> >       sector_t zone_size_sects;
> > +     spinlock_t zlock;
>
> Could you change that to "zone_lock" to be consistent with the other zone
> related field names which all spell out "zone" ?
>
> >
> >       unsigned long size; /* device size in MB */
> >       unsigned long completion_nsec; /* time in ns to complete a request */
> > diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
> > index 3d25c9ad2383..04fbf267703a 100644
> > --- a/drivers/block/null_blk_zoned.c
> > +++ b/drivers/block/null_blk_zoned.c
> > @@ -45,6 +45,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
> >       if (!dev->zones)
> >               return -ENOMEM;
> >
> > +     spin_lock_init(&dev->zlock);
> >       if (dev->zone_nr_conv >= dev->nr_zones) {
> >               dev->zone_nr_conv = dev->nr_zones - 1;
> >               pr_info("changed the number of conventional zones to %u",
> > @@ -124,6 +125,7 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
> >       nr_zones = min(nr_zones, dev->nr_zones - first_zone);
> >       trace_nullb_report_zones(nullb, nr_zones);
> >
> > +     spin_lock_irq(&dev->zlock);
> >       for (i = 0; i < nr_zones; i++) {
> >               /*
> >                * Stacked DM target drivers will remap the zone information by
> > @@ -134,10 +136,13 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
> >               memcpy(&zone, &dev->zones[first_zone + i],
> >                      sizeof(struct blk_zone));
> >               error = cb(&zone, i, data);
>
> The cb() here may sleep etc. So you cannot have the zone lock around it. Taking
> the lock around the memcpy only is enough.
>
> > -             if (error)
> > +             if (error) {
> > +                     spin_unlock_irq(&dev->zlock);
> >                       return error;
> > +             }
> >       }
> >
> > +     spin_unlock_irq(&dev->zlock);
> >       return nr_zones;
> >  }
> >
> > @@ -147,16 +152,24 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
> >       struct nullb_device *dev = nullb->dev;
> >       struct blk_zone *zone = &dev->zones[null_zone_no(dev, sector)];
> >       unsigned int nr_sectors = len >> SECTOR_SHIFT;
> > +     size_t ret = 0;
>
> Please call that valid_len or something more representative of the value.
>
> >
> > +     spin_lock_irq(&dev->zlock);
> >       /* Read must be below the write pointer position */
> >       if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL ||
> > -         sector + nr_sectors <= zone->wp)
> > -             return len;
> > +         sector + nr_sectors <= zone->wp) {
> > +             ret = len;
> > +             goto out_unlock;
> > +     }
> >
> >       if (sector > zone->wp)
> > -             return 0;
> > +             goto out_unlock;
> > +
> > +     ret = (zone->wp - sector) << SECTOR_SHIFT;
> >
> > -     return (zone->wp - sector) << SECTOR_SHIFT;
> > +out_unlock:
> > +     spin_unlock_irq(&dev->zlock);
> > +     return ret;
> >  }
> >
> >  static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
> > @@ -165,17 +178,19 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
> >       struct nullb_device *dev = cmd->nq->dev;
> >       unsigned int zno = null_zone_no(dev, sector);
> >       struct blk_zone *zone = &dev->zones[zno];
> > -     blk_status_t ret;
> > +     blk_status_t ret = BLK_STS_OK;
> >
> >       trace_nullb_zone_op(cmd, zno, zone->cond);
> >
> >       if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
> >               return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
> >
> > +     spin_lock_irq(&dev->zlock);
> >       switch (zone->cond) {
> >       case BLK_ZONE_COND_FULL:
> >               /* Cannot write to a full zone */
> > -             return BLK_STS_IOERR;
> > +             ret = BLK_STS_IOERR;
> > +             break;
> >       case BLK_ZONE_COND_EMPTY:
> >       case BLK_ZONE_COND_IMP_OPEN:
> >       case BLK_ZONE_COND_EXP_OPEN:
> > @@ -193,27 +208,33 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
> >                       else
> >                               cmd->rq->__sector = sector;
> >               } else if (sector != zone->wp) {
> > -                     return BLK_STS_IOERR;
> > +                     ret = BLK_STS_IOERR;
> > +                     break;
> >               }
> >
> > -             if (zone->wp + nr_sectors > zone->start + zone->capacity)
> > -                     return BLK_STS_IOERR;
> > +             if (zone->wp + nr_sectors > zone->start + zone->capacity) {
> > +                     ret = BLK_STS_IOERR;
> > +                     break;
> > +             }
> >
> >               if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
> >                       zone->cond = BLK_ZONE_COND_IMP_OPEN;
> >
> >               ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
> >               if (ret != BLK_STS_OK)
> > -                     return ret;
> > +                     break;
> >
> >               zone->wp += nr_sectors;
> >               if (zone->wp == zone->start + zone->capacity)
> >                       zone->cond = BLK_ZONE_COND_FULL;
> > -             return BLK_STS_OK;
> > +             break;
> >       default:
> >               /* Invalid zone condition */
> > -             return BLK_STS_IOERR;
> > +             ret = BLK_STS_IOERR;
> >       }
> > +
> > +     spin_unlock_irq(&dev->zlock);
> > +     return ret;
> >  }
> >
> >  static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
> > @@ -223,7 +244,9 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
> >       unsigned int zone_no = null_zone_no(dev, sector);
> >       struct blk_zone *zone = &dev->zones[zone_no];
> >       size_t i;
> > +     blk_status_t ret = BLK_STS_OK;
> >
> > +     spin_lock_irq(&dev->zlock);
> >       switch (op) {
> >       case REQ_OP_ZONE_RESET_ALL:
> >               for (i = 0; i < dev->nr_zones; i++) {
> > @@ -234,25 +257,29 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
> >               }
> >               break;
> >       case REQ_OP_ZONE_RESET:
> > -             if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
> > -                     return BLK_STS_IOERR;
> > +             if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
> > +                     ret = BLK_STS_IOERR;
> > +                     break;
> > +             }
> >
> >               zone->cond = BLK_ZONE_COND_EMPTY;
> >               zone->wp = zone->start;
> >               break;
> >       case REQ_OP_ZONE_OPEN:
> > -             if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
> > -                     return BLK_STS_IOERR;
> > -             if (zone->cond == BLK_ZONE_COND_FULL)
> > -                     return BLK_STS_IOERR;
> > +             if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL ||
> > +                             zone->cond == BLK_ZONE_COND_FULL) {
> > +                     ret = BLK_STS_IOERR;
> > +                     break;
> > +             }
> >
> >               zone->cond = BLK_ZONE_COND_EXP_OPEN;
> >               break;
> >       case REQ_OP_ZONE_CLOSE:
> > -             if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
> > -                     return BLK_STS_IOERR;
> > -             if (zone->cond == BLK_ZONE_COND_FULL)
> > -                     return BLK_STS_IOERR;
> > +             if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL ||
> > +                             zone->cond == BLK_ZONE_COND_FULL) {
> > +                     ret = BLK_STS_IOERR;
> > +                     break;
> > +             }
> >
> >               if (zone->wp == zone->start)
> >                       zone->cond = BLK_ZONE_COND_EMPTY;
> > @@ -260,18 +287,21 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
> >                       zone->cond = BLK_ZONE_COND_CLOSED;
> >               break;
> >       case REQ_OP_ZONE_FINISH:
> > -             if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
> > -                     return BLK_STS_IOERR;
> > +             if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
> > +                     ret = BLK_STS_IOERR;
> > +                     break;
> > +             }
> >
> >               zone->cond = BLK_ZONE_COND_FULL;
> >               zone->wp = zone->start + zone->len;
> >               break;
> >       default:
> > -             return BLK_STS_NOTSUPP;
> > +             ret = BLK_STS_NOTSUPP;
> >       }
> >
> > +     spin_unlock_irq(&dev->zlock);
> >       trace_nullb_zone_op(cmd, zone_no, zone->cond);
> > -     return BLK_STS_OK;
> > +     return ret;
> >  }
>
> I think you can avoid all of these changes by taking the lock around the calls
> to null_zone_mgmt() and null_zone_write() in null_process_zoned_cmd(). That will
> make the patch a lot smaller and simplify maintenance. And even, I think that
> taking the lock on entry to null_process_zoned_cmd() and unlocking on return
> should even be simpler since that would cover reads too (valid read len). Only
> report zones would need special treatment.
>
> >
> >  blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
> >
>
> I think we also need this to have a Cc: stable and a "Fixes" tag too.
>
> --
> Damien Le Moal
> Western Digital Research



-- 
Joshi
