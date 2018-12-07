Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C3C64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 20:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5C620700
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 20:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5C620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLGUUe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:20:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeLGUUd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 15:20:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3289F3002E08;
        Fri,  7 Dec 2018 20:20:33 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4133600C4;
        Fri,  7 Dec 2018 20:20:30 +0000 (UTC)
Date:   Fri, 7 Dec 2018 15:20:30 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Eric Wheeler <dm-devel@lists.ewheeler.net>, dm-devel@redhat.com
Subject: Re: dm crypt: fix lost ioprio when queuing crypto bios from task
 with ioprio
Message-ID: <20181207202029.GA21823@redhat.com>
References: <20181206221507.5423-1-snitzer@redhat.com>
 <20181207194319.GA1690@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207194319.GA1690@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 07 Dec 2018 20:20:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 07 2018 at  2:43pm -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Dec 06, 2018 at 05:15:07PM -0500, Mike Snitzer wrote:
> > From: Eric Wheeler <dm-devel@lists.ewheeler.net>
> > 
> > Since dm-crypt queues writes (and sometimes reads) to a different kernel
> > thread (workqueue), the bios will dispatch from tasks with different
> > io_context->ioprio settings than the submitting task, thus giving
> > incorrect ioprio hints to the io scheduler.
> > 
> > By assigning the ioprio to the bio before queuing to a workqueue, the
> > original submitting task's io_context->ioprio setting can be retained
> > through the life of the bio.  We only set the bio's ioprio in dm-crypt
> > if not already set (by somewhere else, higher in the stack).
> 
> The scheme looks a little odd to me.  Instead of requring a driver
> call why don't we just make sure bios always have the submitting
> tasks priority set and then make sure the lower layers can rely on it?

The original patch from Eric was from 2 years ago when
__bio_clone_fast() didn't even copy over the ioprio from the src bio:
https://patchwork.kernel.org/patch/9474535/

So the 2 hunks from that original patch that did the copying of the
ioprio (__bio_clone_fast and clone_init) are no longer needed.

Leaving only these changes as in doubt:

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 509fb20f7f86..ce8f03f52433 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2916,10 +2916,16 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
                io->ctx.r.req = (struct skcipher_request *)(io + 1);

        if (bio_data_dir(io->base_bio) == READ) {
-               if (kcryptd_io_read(io, GFP_NOWAIT))
+               if (kcryptd_io_read(io, GFP_NOWAIT)) {
+                       if (!ioprio_valid(bio_prio(io->base_bio)))
+                               bio_set_prio_from_current(io->base_bio);
                        kcryptd_queue_read(io);
-       } else
+               }
+       } else {
+               if (!ioprio_valid(bio_prio(io->base_bio)))
+                       bio_set_prio_from_current(io->base_bio);
                kcryptd_queue_crypt(io);
+       }

        return DM_MAPIO_SUBMITTED;
 }

I need to look closer at _why_ io->base_bio wouldn't have inherited the
submitting task's ioprio....

Looks like the 2yr old need for the above was simply due to
__bio_clone_fast() not copying over the ioprio.  Because crypt_io_init()
assigns the cloned bio, that DM core sent crypt_map(), to io->base_bio.
Since io->base_bio is a clone it will have been assigned the original
bio's ioprio.  Leaving only remaining question being whether that
original bio had its ioprio previously set?

In this case, bcache appears to be only caller of bio_set_prio(), so for
the bcache on dm-crypt case Eric cares about dm-crypt _should_ inherit
bcache's ioprio.

Long story short: you're correct (driver shouldn't need to do this) and
thankfully it looks like latest upstream code should work fine -- though
I've not tested it to verify.

Eric, it has been a long time since you had a need for these ioprio
changes, to benefit bcache stacked on dm-crypt, but if you still have an
issue with ioprio not being set (or not being from submitting task)
please let us know.

Thanks,
Mike
