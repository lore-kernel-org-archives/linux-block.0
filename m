Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708D1C3F68F
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DEE2073D
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 13:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=selectel-ru.20150623.gappssmtp.com header.i=@selectel-ru.20150623.gappssmtp.com header.b="sHld6U2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfLJNj2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:39:28 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39146 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLJNj2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 08:39:28 -0500
Received: by mail-qt1-f193.google.com with SMTP id i12so1615880qtp.6
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2019 05:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selectel-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sO7OAJOIDkiHk4kr3wn56uXDPrSjh6Zwe88NUw86E3E=;
        b=sHld6U2fu5pqBti7ihORAb6qcwZLN8InRWg4XPG7wkqmGBBFPjpQ3gf3+IkEAaTgPo
         K60yS5OWFKVppG4OOwGjohrpgZDYLGpd3TY7Pkbv5436YG0QEenm9/YTD5EHFdkyLhit
         8LnqWHDZFzFBaDxsV1bxUWzMKO3Mmypcn4b0If2FhU3cC6sDjO8CmaiY0SS137AFMT8/
         1QgADyzvC2OmQX2cLxP8iHsBmxuzmXGC4yFETQp59Z0YOcdoT6CPAiypmyQzbleQujLR
         zFEMgc4nUXSROsJMntnaUrSwhnk66+SAoawMC5wAAiJ2TaLsRp0A6XsMyni44aiXbXtU
         OlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sO7OAJOIDkiHk4kr3wn56uXDPrSjh6Zwe88NUw86E3E=;
        b=jZivKfyB/iErU9S2NOD16D2WUDtkDFmh+W1Zn1FU9j/4rA0I0Kvid7UHKsD+QTyS6c
         BnrvRKiJoVR/9C9m7+Bd7msP4GTsaw83H8pSPSWVpwDiFgWf+RSpk9jQSl7Svn7laVju
         2wlBYHfvhp2Zwo8d7Ir4LftrQpoT/rUatW5pYl3LcvUZo1hu5GvL33r37I+cXZ11H4bT
         +KI/LRhUpQ9nS8lGYokKQRaFZXqfrFRJf/MfURBZKwe+SOs2om6ENzLpViG9AX9HtKhd
         /PRELuQEP63Yq84E7JR0Z0T17tGb60FAGFu0ywkZfhXOn+8yO25hS83/UvbWO5VEN6lV
         t8BQ==
X-Gm-Message-State: APjAAAX2NowTD/E4wOjkiijtEJl87kFs/zx8IP+4tSCppS6wcfjEphvF
        shP2laK8waPsulRq13DiV8zqykhNt811YaIZE2eQ/Q==
X-Google-Smtp-Source: APXvYqylmdHm6q9LC4xUEVY/pIafIWt6ss9TIyz2FugSn2DqlCv6ChDyGyTXZUnMHe8MvC/qM9C1iMoNDl4oGFyQl2E=
X-Received: by 2002:ac8:4585:: with SMTP id l5mr14262267qtn.200.1575985167029;
 Tue, 10 Dec 2019 05:39:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575899438.git.zaharov@selectel.ru> <7baf0d9f4bf8f3110c630d56ccb5c9da40b668ac.1575899439.git.zaharov@selectel.ru>
 <CACVXFVOrdsF7Lv3JVhdd37bOBTxJe2+r9vGmw8Qq_DFGDy0Htg@mail.gmail.com>
In-Reply-To: <CACVXFVOrdsF7Lv3JVhdd37bOBTxJe2+r9vGmw8Qq_DFGDy0Htg@mail.gmail.com>
From:   Aleksei Zakharov <zaharov@selectel.ru>
Date:   Tue, 10 Dec 2019 16:39:15 +0300
Message-ID: <CAJYOGF_wb+HoW7C69dUoYB8zUBpbBtNnq9y2=Yz5Vc_7YkAHWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: add iostat counters for requests splits
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

=D0=B2=D1=82, 10 =D0=B4=D0=B5=D0=BA. 2019 =D0=B3. =D0=B2 06:09, Ming Lei <t=
om.leiming@gmail.com>:
>
> On Mon, Dec 9, 2019 at 10:25 PM Aleksei Zakharov <zaharov@selectel.ru> wr=
ote:
> >
> > I/O request can be splitted for two or more requests,
> > if it's size is greater than queue/max_sectors_kb
> > setting.
> >
> > Knowledge of splits frequency helps to understand workload
> > profile better and to make decision to tune queue/max_sectors_kb.
>
> IO split should be one static behavior, so if one bio's sector/size is pr=
ovided,
> it is easy to figure out the split pattern, not sure if it is worth of
> adding statistics
> in iostat.
>
> That said the IO split analysis can be done simply as post-process of IO =
trace,
> or even it can be done runtime via bcc/bpftrace script without much diffi=
culty.
Yes, you're right, it can be done via bpftrace. But iostat is just well-kno=
wn
and overall used tool. It's better to have most of stats with default tool,
than have a lot of tools for different parts of one subsystem layer, IMO.

>
> >
> > This patch adds three counters to /sys/class/block/$dev/stat
> > and /proc/diskstats: number of reads, writes and discards
> > splitted.
> >
> > There's also counter for flush requests, but it is ignored,
> > because flush cannot be splitted.
> > ---
> >  Documentation/ABI/testing/procfs-diskstats |  3 +++
> >  Documentation/ABI/testing/sysfs-block      |  5 ++++-
> >  Documentation/admin-guide/iostats.rst      | 10 ++++++++++
> >  block/bio.c                                |  2 ++
> >  block/blk-core.c                           |  2 ++
> >  block/genhd.c                              |  8 ++++++--
> >  block/partition-generic.c                  |  8 ++++++--
> >  include/linux/genhd.h                      |  1 +
> >  8 files changed, 34 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/procfs-diskstats b/Documentation=
/ABI/testing/procfs-diskstats
> > index 70dcaf2481f4..e1473e93d901 100644
> > --- a/Documentation/ABI/testing/procfs-diskstats
> > +++ b/Documentation/ABI/testing/procfs-diskstats
> > @@ -33,5 +33,8 @@ Description:
> >
> >                 19 - flush requests completed successfully
> >                 20 - time spent flushing
> > +               21 - reads splitted
> > +               22 - writes splitted
> > +               23 - discards splitted
> >
> >                 For more details refer to Documentation/admin-guide/ios=
tats.rst
> > diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/=
testing/sysfs-block
> > index ed8c14f161ee..ffbac0e72508 100644
> > --- a/Documentation/ABI/testing/sysfs-block
> > +++ b/Documentation/ABI/testing/sysfs-block
> > @@ -3,7 +3,7 @@ Date:           February 2008
> >  Contact:       Jerome Marchand <jmarchan@redhat.com>
> >  Description:
> >                 The /sys/block/<disk>/stat files displays the I/O
> > -               statistics of disk <disk>. They contain 11 fields:
> > +               statistics of disk <disk>. They contain 20 fields:
> >                  1 - reads completed successfully
> >                  2 - reads merged
> >                  3 - sectors read
> > @@ -21,6 +21,9 @@ Description:
> >                 15 - time spent discarding (ms)
> >                 16 - flush requests completed
> >                 17 - time spent flushing (ms)
> > +               18 - reads splitted
> > +               19 - writes splitted
> > +               20 - discrads splitted
> >                 For more details refer Documentation/admin-guide/iostat=
s.rst
> >
> >
> > diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admi=
n-guide/iostats.rst
> > index 4f0462af3ca7..7f3f374b82b7 100644
> > --- a/Documentation/admin-guide/iostats.rst
> > +++ b/Documentation/admin-guide/iostats.rst
> > @@ -130,6 +130,16 @@ Field 16 -- # of flush requests completed
> >  Field 17 -- # of milliseconds spent flushing
> >      This is the total number of milliseconds spent by all flush reques=
ts.
> >
> > +Field 18 -- # of reads splitted, field 19 -- # of writes splitted
> > +    This is the total number of requests splitted before queue.
> > +
> > +    The maximum size of I/O is limited by queue/max_sectors_kb.
> > +    If size of I/O is greater than this limit, it will be splitted
> > +    as many times as needed to keep I/O size withing the limit.
> > +
> > +Field 20 -- # of discrads Splitted
> > +    See description of fileds 18 and 19.
> > +
> >  To avoid introducing performance bottlenecks, no locks are held while
> >  modifying these counters.  This implies that minor inaccuracies may be
> >  introduced when changes collide, so (for instance) adding up all the
> > diff --git a/block/bio.c b/block/bio.c
> > index 8f0ed6228fc5..c8a051e128f8 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1855,6 +1855,8 @@ struct bio *bio_split(struct bio *bio, int sector=
s,
> >         if (bio_flagged(bio, BIO_TRACE_COMPLETION))
> >                 bio_set_flag(split, BIO_TRACE_COMPLETION);
> >
> > +       bio_set_flag(split, BIO_SPLITTED);
> > +
> >         return split;
> >  }
> >  EXPORT_SYMBOL(bio_split);
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index f0d82227a2fc..776d28b9a5bf 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1379,6 +1379,8 @@ void blk_account_io_start(struct request *rq, boo=
l new_io)
> >                 }
> >                 part_inc_in_flight(rq->q, part, rw);
> >                 rq->part =3D part;
> > +               if (bio_flagged(rq->bio, BIO_SPLITTED))
> > +                       part_stat_inc(part, splits[rw]);
>
> It is the only use of BIO_SPLITTED, and it should have been done as one r=
q flag,
> then extra change in bio struct can be avoided.  If the bio is
> splitted can be easily
> figured out in blk_mq_make_request(),  then you may pass that info to
> blk_mq_bio_to_request().
Thanks for pointing that out!
I'll rethink this patch.
>
> Thanks,
> Ming



--=20
Best Regards,
Aleksei Zakharov
System administrator

www.selectel.com
