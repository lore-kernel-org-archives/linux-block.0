Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526E5C352A3
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 22:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634C217F4
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 22:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txT4jK1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBMWIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:08:17 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42501 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMWIR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 17:08:17 -0500
Received: by mail-io1-f67.google.com with SMTP id z1so7738884iom.9
        for <linux-block@vger.kernel.org>; Thu, 13 Feb 2020 14:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvTmvGfvJmOv7sMbAjwocI81PqYWLyNw6wRoKoHV6qg=;
        b=txT4jK1J0pBtT9kg3vVsCO4+fPlEEgl0mw/PQqXHnDzVPHf1XFGMXXGWSOkx36QT+M
         VpDhUw85bVIZAXgTqTvaEkxT48Z8Ur8OA2/wpwNXs6gXisBx2OlaYnAJBEFD9B//46qP
         t/oHlKKxqFBmo9MBOeYDZDgAE3p14qbAeZ+dlEVwugWXswqi914wl6jAMHuAR0eTPAi6
         y2eJbwjJolAzw2xqxyimpS0RmJ3n9f6jKJ+20Q4ytQasqPlrw6fasVslAvVjRc/uCcvM
         FauQ1mtCSUfKUPi83ludoUvB9+x1qfE9UyUxicbj//+lSrh9DMaC/nCAo/wZ26XukEI5
         5yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvTmvGfvJmOv7sMbAjwocI81PqYWLyNw6wRoKoHV6qg=;
        b=tjs32zZpdceCWAsHU/U0xdFH8QV94wQQ05vIFm8LQ8RnNyxOB7uKAbwzmQ33SdsGsP
         u7P9irPFWt2vR0+hL43C6MQKbNx+B6FNht2YKK2QuxHFrWNWcUxpEzu3Cp36YmrcY3wE
         c9oTBQJYaynHaoFKIXqFJmXaQXa4HgHiuaL1wj8T/AlktT7Ycex8A5+3t8pdkK3FsQI9
         wsujdPy7oTileMA8U8KlDhESvxzhY9biN3dCqrpiN5pP0Z6o/4nemdANFdoK2njI9erC
         6oEAd2q0q99Vpa0ZsFN6X1nYjCEWY/rrGab8YHE4xkAa2TIGrFae6dIcmaBdmJZIPLb5
         tHSw==
X-Gm-Message-State: APjAAAXQX0erRSL4bfGb0UPLzMTuNsiA3kwM2FKiE+z0srpWRbhkMXQz
        W26j+92IJNbe2h2ID0ur0ajNYgqroyd2NSimWQqk5g==
X-Google-Smtp-Source: APXvYqzouCBHWn9pG6B4NKVnpMkjX7h2J2/kCFDH8mqr1st4quO6paJ726ZTIeLIe6O9RURzpeKV7WvozsevHmVpHHE=
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr94717jac.126.1581631696132;
 Thu, 13 Feb 2020 14:08:16 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p> <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
In-Reply-To: <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
From:   Salman Qazi <sqazi@google.com>
Date:   Thu, 13 Feb 2020 14:08:04 -0800
Message-ID: <CAKUOC8U9+x4SDji-v=1PEoHmcTQ40fU0sOt34+2v5qpfKwVbVQ@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 13, 2020 at 11:21 AM Salman Qazi <sqazi@google.com> wrote:
>
> On Thu, Feb 13, 2020 at 9:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 2/13/20 12:26 AM, Ming Lei wrote:
> > > The approach used in blk_execute_rq() can be borrowed for workaround the
> > > issue, such as:
> > >
> > > diff --git a/block/bio.c b/block/bio.c
> > > index 94d697217887..c9ce19a86de7 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -17,6 +17,7 @@
> > >   #include <linux/cgroup.h>
> > >   #include <linux/blk-cgroup.h>
> > >   #include <linux/highmem.h>
> > > +#include <linux/sched/sysctl.h>
> > >
> > >   #include <trace/events/block.h>
> > >   #include "blk.h"
> > > @@ -1019,12 +1020,19 @@ static void submit_bio_wait_endio(struct bio *bio)
> > >   int submit_bio_wait(struct bio *bio)
> > >   {
> > >       DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
> > > +     unsigned long hang_check;
> > >
> > >       bio->bi_private = &done;
> > >       bio->bi_end_io = submit_bio_wait_endio;
> > >       bio->bi_opf |= REQ_SYNC;
> > >       submit_bio(bio);
> > > -     wait_for_completion_io(&done);
> > > +
> > > +     /* Prevent hang_check timer from firing at us during very long I/O */
> > > +     hang_check = sysctl_hung_task_timeout_secs;
> > > +     if (hang_check)
> > > +             while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));
> > > +     else
> > > +             wait_for_completion_io(&done);
> > >
> > >       return blk_status_to_errno(bio->bi_status);
> > >   }
> >
> > Instead of suppressing the hung task complaints, has it been considered
> > to use the bio splitting mechanism to make discard bios smaller? Block
> > drivers may set a limit by calling blk_queue_max_discard_segments().
> >  From block/blk-settings.c:
> >
> > /**
> >   * blk_queue_max_discard_segments - set max segments for discard
> >   * requests
> >   * @q:  the request queue for the device
> >   * @max_segments:  max number of segments
> >   *
> >   * Description:
> >   *    Enables a low level driver to set an upper limit on the number of
> >   *    segments in a discard request.
> >   **/
> > void blk_queue_max_discard_segments(struct request_queue *q,
> >                 unsigned short max_segments)
> > {
> >         q->limits.max_discard_segments = max_segments;
> > }
> > EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);
> >
>
> AFAICT, This is not actually sufficient, because the issuer of the bio
> is waiting for the entire bio, regardless of how it is split later.
> But, also there isn't a good mapping between the size of the secure
> discard and how long it will take.  If given the geometry of a flash
> device, it is not hard to construct a scenario where a relatively
> small secure discard (few thousand sectors) will take a very long time
> (multiple seconds).
>
> Having said that, I don't like neutering the hung task timer either.

In fact, it's worse than that.  Today, I was able to construct a case
of a 4K discard on a particular device that took 100 seconds.  I did
this
by arranging to write a single copy of page 0 for every erase unit of
the device, and wrote random LBAs to the rest of the erase unit.  I
suspect the
slow speed comes from the need to copy almost the entire device to
erase all the stale copies of page 0.

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <assert.h>
#include <unistd.h>
#include <linux/fs.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

char page[8192];

int main(int argc, char **argv)
{
        unsigned long start;
        int fd;
        int i;
        char *page_aligned = (char *)(((unsigned long)page + 4095) & ~4095UL);
        unsigned long range[2];
        fd = open(argv[1], O_RDWR | O_DIRECT);
        assert(fd >= 0);
        range[0] = 0;
        assert(ioctl(fd, BLKGETSIZE64, &range[1]) >= 0);
        for (i = 0; i < range[1]; i += 4096) {
                /* paranoia: incase there is any deduping */
                page_aligned[0] = i;
                /*
                 * Almost always write randomly
                 */
                if (i % (4*1024*1024) != 0)
                        assert(pwrite(fd, page_aligned, 4096,
                              (lrand48() % range[1]) & ~4095UL) == 4096);
                else
                        /* except, once per erase block, write page 0 */
                        assert(pwrite(fd, page_aligned, 4096, 0) == 4096);
        }
        start = time(NULL);

        /* discard exactly one page */
        range[1] = 4096;
        printf("Starting discard %lu!\n", start);
        assert(ioctl(fd, BLKSECDISCARD, &range) >= 0);
        printf("Finished discard.  Took %lu!\n", time(NULL) - start);
        close(fd);
}


>
> > Thanks,
> >
> > Bart.
