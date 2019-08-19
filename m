Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37162C3A59F
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 09:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4142087E
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 09:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="wA2NJI4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfHSJ0T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:26:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38925 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfHSJ0T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 05:26:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id x4so1083866ljj.6
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKVW5yULDoWPsPDFlzL5ik05cdljwhyET2JhsabbZbk=;
        b=wA2NJI4eovu2KpJ16T8gEf1zOYXo4yJ2Y4xCKZyg1F0xC15FaVXCqI5Wua5J882DvI
         IykJke3OhdZlJwz4Y9+xJqoOHTBlGxM2hzvh5IU5CkHmyf2ecDt5N3dtwiv2IJe4ztrY
         xari8RXm+Jz8+I2kYOBEzNkyCoZOaihUeuk+QEIMe9eu90E8/Dikt6uObUgDip3Vdt+/
         Y6yeHs3U5dXuUo3xknHjxlhJYDqviVSrrMbInCzoKb8KJFxrOsuwcGeaIBrpcg7yuzHD
         w9GESdLzZr43tmaKiFOhA4pjW3ViiEZPbrpcm0S5AWy7vHRM/eSRUhgjL4zuW8BVunM0
         dfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKVW5yULDoWPsPDFlzL5ik05cdljwhyET2JhsabbZbk=;
        b=Ub8ejfYufVJvdS+2rN5/mkkeRpZJfqhnnDf/XUwrKwhW2M52d7oPYbbAEJIG892vJz
         SjGSU0+cXm2i89WIPmWgFa6UoANCe8N8jieGHFwaUuWDT45qTth8gtNpygfQcE5Wtg/V
         nQSDp1u2rp+xcJqsNMpmEMgQzQEv0El9QwbWOkQFiB/m4d1fOjmdwj1L2tMIcIewpJ8z
         lTVPrgNJbDxS+dbAE2QNRj1qrAF9Cxx9oqkJE7GBR9KjtX8mnetVQ22UPqxRJlLS+e0t
         QgfOoFzo1UKIbdefxTf8+tq+HuRLWuyWZI4MjYad1bdYMBFzxLTdjodWy7y9RKTNw4s+
         ImXg==
X-Gm-Message-State: APjAAAWXdWk9Dx0+aApE6RVRzpHnL2sbmWD1gR1sXJZPFAedV/o7+Xg0
        z1CdANE/BL4VYAUhC8uh5UHn0kVkMRcMkkw4+D551g==
X-Google-Smtp-Source: APXvYqyHzxFkzDLL9gmE3yy1IAWY1PDNlXP0qVZjADqg4l/veyTO/ljjPuJg/ffd+peUxBo/21B+5u9ysoGXKEhHGJU=
X-Received: by 2002:a05:651c:153:: with SMTP id c19mr2118768ljd.152.1566206777474;
 Mon, 19 Aug 2019 02:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190814103244.92518-1-maco@android.com> <20190814113348.GA525@ming.t460p>
 <CAB0TPYFzgm7pJvXfYYER6qqHM3J8dU7WXWv8ct51e2CGctydzw@mail.gmail.com>
In-Reply-To: <CAB0TPYFzgm7pJvXfYYER6qqHM3J8dU7WXWv8ct51e2CGctydzw@mail.gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 19 Aug 2019 11:26:06 +0200
Message-ID: <CAB0TPYEfGYWcUNAZCNAJDAKCUDp+XdiUstS+cDkfeeJe7q8xEw@mail.gmail.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 19, 2019 at 11:06 AM Martijn Coenen <maco@android.com> wrote:
> One idea to fix is to call blk_queue_logical_block_size() as part of
> LOOP_SET_FD, to match the block size of the backing fs in case the
> backing file is opened with O_DIRECT; you could argue that if the
> backing file is opened with O_DIRECT, this is what the user wanted
> anyway. This would allow us to get rid of the latter two ioctl's and
> already save quite some time.

Basically:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ab7ca5989097a..ad3db72fbd729 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -994,6 +994,12 @@ static int loop_set_fd(struct loop_device *lo,
fmode_t mode,
        if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
                blk_queue_write_cache(lo->lo_queue, true, false);

+       if(io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
+               /* In case of direct I/O, match underlying block size */
+               blk_queue_logical_block_size(lo->lo_queue,
+                               bdev_logical_block_size(inode->i_sb->s_bdev));
+       }
+
        loop_update_rotational(lo);
        loop_update_dio(lo);

>
> Thanks,
> Martijn
>
> >
> > Something like the following patch:
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index a7461f482467..8791f9242583 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -1015,6 +1015,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> >          */
> >         bdgrab(bdev);
> >         mutex_unlock(&loop_ctl_mutex);
> > +
> > +       percpu_ref_switch_to_percpu(&lo->lo_queue->q_usage_counter);
> > +
> >         if (partscan)
> >                 loop_reread_partitions(lo, bdev);
> >         if (claimed_bdev)
> > @@ -1171,6 +1174,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
> >         lo->lo_state = Lo_unbound;
> >         mutex_unlock(&loop_ctl_mutex);
> >
> > +       percpu_ref_switch_to_atomic(&lo->lo_queue->q_usage_counter, NULL);
> > +
> >         /*
> >          * Need not hold loop_ctl_mutex to fput backing file.
> >          * Calling fput holding loop_ctl_mutex triggers a circular
> > @@ -2003,6 +2008,12 @@ static int loop_add(struct loop_device **l, int i)
> >         }
> >         lo->lo_queue->queuedata = lo;
> >
> > +       /*
> > +        * cheat block layer for not switching to q_usage_counter's
> > +        * percpu mode before loop becomes Lo_bound
> > +        */
> > +       blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, lo->lo_queue);
> > +
> >         blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
> >
> >         /*
> >
> >
> > thanks,
> > Ming
