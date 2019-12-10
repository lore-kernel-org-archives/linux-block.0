Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9868FC43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 03:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600DD20726
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 03:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qd695vco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLJDJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:09:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43474 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfLJDJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 22:09:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so18296380wre.10
        for <linux-block@vger.kernel.org>; Mon, 09 Dec 2019 19:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5/0i0kjyAKWXpTXQLRhwCtJDuSN8InZmsbj8uS7L78=;
        b=qd695vcovor7OsKgY6FH6ZU8mlE3I0+jblNbgbN577iegJBzidixdXkV99dtXLo62i
         esASwTPGaYiK321WuDs66FHcVhyDm2WAEDnEak3nuiEa8R8qzLvIzm4gfmdZ4XtnizH4
         AlagyIxriAWDDhd65OTYMEQOy7qhQCX3/zU+2unHVVztHvJ0oLwlMNY8/458iBTl4tCP
         +IKUbtk/RqMFD2z26k6FR9G05VW0MxKiEmmlEy9s0pQkQ1WVLa90gyYCLVFJra31Uqaq
         32Ib3UoG5+fmg+vHnW1AcIONWTSHm39frQwUc1rLO1l3V5LBb3fHsXBZE9Iw84AAEM/d
         BYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5/0i0kjyAKWXpTXQLRhwCtJDuSN8InZmsbj8uS7L78=;
        b=pScXZROcjJ64C1GiOaWVVnbWGOth2NztbjcCTmzMA2yPUCHHpJR+ABwLPE0Jyi7Rml
         F8as9DDFTQiXg2VSC5Fed6FCoCk81BsJgIOKShV7mIY8jFLd27mhB3axoAmmbjs9/63R
         JA8JfQ4wP6epac1gDz9c2nizNFtAkChOXV/m/c0zzmF4/cTbL6Evjuxh6/OAPiJ+sHvK
         kTyXrog/6ib8hWPFtaggptv+E6eobgbyD9DG9mbquxq/tgdX6p7n5Dhlqgg8nB/W2npn
         R0x8zYndhVs4VOQE6rNETJzUEiEWoWkYpCw0YY9G19wJXm8vQ1JujQKqZ17oVvx66ex4
         avKw==
X-Gm-Message-State: APjAAAUPxPeTOd1aGzq6y0JHXi06fHdflJNUYmpXJGP1BH66b/We6ujo
        QSMCjmdBkjX7zlmLURjQfkJdDkaf1wO3pIHNDQ4=
X-Google-Smtp-Source: APXvYqwco4lEu03iJFdOgZsOyfLDu4INxfT9r5ASmlpJrD5rKAjoQkNfCOvKMqglacSK0XNzxVgZn/8gOL3NGNlCljg=
X-Received: by 2002:adf:e78b:: with SMTP id n11mr277838wrm.10.1575947345208;
 Mon, 09 Dec 2019 19:09:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575899438.git.zaharov@selectel.ru> <7baf0d9f4bf8f3110c630d56ccb5c9da40b668ac.1575899439.git.zaharov@selectel.ru>
In-Reply-To: <7baf0d9f4bf8f3110c630d56ccb5c9da40b668ac.1575899439.git.zaharov@selectel.ru>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 10 Dec 2019 11:08:53 +0800
Message-ID: <CACVXFVOrdsF7Lv3JVhdd37bOBTxJe2+r9vGmw8Qq_DFGDy0Htg@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: add iostat counters for requests splits
To:     Aleksei Zakharov <zaharov@selectel.ru>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 9, 2019 at 10:25 PM Aleksei Zakharov <zaharov@selectel.ru> wrote:
>
> I/O request can be splitted for two or more requests,
> if it's size is greater than queue/max_sectors_kb
> setting.
>
> Knowledge of splits frequency helps to understand workload
> profile better and to make decision to tune queue/max_sectors_kb.

IO split should be one static behavior, so if one bio's sector/size is provided,
it is easy to figure out the split pattern, not sure if it is worth of
adding statistics
in iostat.

That said the IO split analysis can be done simply as post-process of IO trace,
or even it can be done runtime via bcc/bpftrace script without much difficulty.

>
> This patch adds three counters to /sys/class/block/$dev/stat
> and /proc/diskstats: number of reads, writes and discards
> splitted.
>
> There's also counter for flush requests, but it is ignored,
> because flush cannot be splitted.
> ---
>  Documentation/ABI/testing/procfs-diskstats |  3 +++
>  Documentation/ABI/testing/sysfs-block      |  5 ++++-
>  Documentation/admin-guide/iostats.rst      | 10 ++++++++++
>  block/bio.c                                |  2 ++
>  block/blk-core.c                           |  2 ++
>  block/genhd.c                              |  8 ++++++--
>  block/partition-generic.c                  |  8 ++++++--
>  include/linux/genhd.h                      |  1 +
>  8 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/ABI/testing/procfs-diskstats b/Documentation/ABI/testing/procfs-diskstats
> index 70dcaf2481f4..e1473e93d901 100644
> --- a/Documentation/ABI/testing/procfs-diskstats
> +++ b/Documentation/ABI/testing/procfs-diskstats
> @@ -33,5 +33,8 @@ Description:
>
>                 19 - flush requests completed successfully
>                 20 - time spent flushing
> +               21 - reads splitted
> +               22 - writes splitted
> +               23 - discards splitted
>
>                 For more details refer to Documentation/admin-guide/iostats.rst
> diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
> index ed8c14f161ee..ffbac0e72508 100644
> --- a/Documentation/ABI/testing/sysfs-block
> +++ b/Documentation/ABI/testing/sysfs-block
> @@ -3,7 +3,7 @@ Date:           February 2008
>  Contact:       Jerome Marchand <jmarchan@redhat.com>
>  Description:
>                 The /sys/block/<disk>/stat files displays the I/O
> -               statistics of disk <disk>. They contain 11 fields:
> +               statistics of disk <disk>. They contain 20 fields:
>                  1 - reads completed successfully
>                  2 - reads merged
>                  3 - sectors read
> @@ -21,6 +21,9 @@ Description:
>                 15 - time spent discarding (ms)
>                 16 - flush requests completed
>                 17 - time spent flushing (ms)
> +               18 - reads splitted
> +               19 - writes splitted
> +               20 - discrads splitted
>                 For more details refer Documentation/admin-guide/iostats.rst
>
>
> diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
> index 4f0462af3ca7..7f3f374b82b7 100644
> --- a/Documentation/admin-guide/iostats.rst
> +++ b/Documentation/admin-guide/iostats.rst
> @@ -130,6 +130,16 @@ Field 16 -- # of flush requests completed
>  Field 17 -- # of milliseconds spent flushing
>      This is the total number of milliseconds spent by all flush requests.
>
> +Field 18 -- # of reads splitted, field 19 -- # of writes splitted
> +    This is the total number of requests splitted before queue.
> +
> +    The maximum size of I/O is limited by queue/max_sectors_kb.
> +    If size of I/O is greater than this limit, it will be splitted
> +    as many times as needed to keep I/O size withing the limit.
> +
> +Field 20 -- # of discrads Splitted
> +    See description of fileds 18 and 19.
> +
>  To avoid introducing performance bottlenecks, no locks are held while
>  modifying these counters.  This implies that minor inaccuracies may be
>  introduced when changes collide, so (for instance) adding up all the
> diff --git a/block/bio.c b/block/bio.c
> index 8f0ed6228fc5..c8a051e128f8 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1855,6 +1855,8 @@ struct bio *bio_split(struct bio *bio, int sectors,
>         if (bio_flagged(bio, BIO_TRACE_COMPLETION))
>                 bio_set_flag(split, BIO_TRACE_COMPLETION);
>
> +       bio_set_flag(split, BIO_SPLITTED);
> +
>         return split;
>  }
>  EXPORT_SYMBOL(bio_split);
> diff --git a/block/blk-core.c b/block/blk-core.c
> index f0d82227a2fc..776d28b9a5bf 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1379,6 +1379,8 @@ void blk_account_io_start(struct request *rq, bool new_io)
>                 }
>                 part_inc_in_flight(rq->q, part, rw);
>                 rq->part = part;
> +               if (bio_flagged(rq->bio, BIO_SPLITTED))
> +                       part_stat_inc(part, splits[rw]);

It is the only use of BIO_SPLITTED, and it should have been done as one rq flag,
then extra change in bio struct can be avoided.  If the bio is
splitted can be easily
figured out in blk_mq_make_request(),  then you may pass that info to
blk_mq_bio_to_request().

Thanks,
Ming
