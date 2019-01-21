Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCACC2F421
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 16:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E456A20879
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 16:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfAUQCG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:02:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbfAUQCG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 11:02:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0316E1326B7;
        Mon, 21 Jan 2019 16:02:06 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E1A1608DD;
        Mon, 21 Jan 2019 16:02:05 +0000 (UTC)
Date:   Mon, 21 Jan 2019 11:02:04 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     dm-devel@redhat.com, NeilBrown <neilb@suse.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] dm: fix missing bio_split() pattern code in
 __split_and_process_bio()
Message-ID: <20190121160204.GA32117@redhat.com>
References: <20190119180506.1300-1-snitzer@redhat.com>
 <20190119180506.1300-4-snitzer@redhat.com>
 <20190121032153.GA24610@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121032153.GA24610@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 21 Jan 2019 16:02:06 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 20 2019 at 10:21P -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> On Sat, Jan 19, 2019 at 01:05:05PM -0500, Mike Snitzer wrote:
> > Use the same BIO_QUEUE_ENTERED pattern that was established by commit
> > cd4a4ae4683dc ("block: don't use blocking queue entered for recursive
> > bio submits") by setting BIO_QUEUE_ENTERED after bio_split() and before
> > recursing via generic_make_request().
> > 
> > Also add trace_block_split() because it provides useful context about
> > bio splits in blktrace.
> > 
> > Depends-on: cd4a4ae4683dc ("block: don't use blocking queue entered for recursive bio submits")
> > Fixes: 18a25da84354 ("dm: ensure bio submission follows a depth-first tree walk")
> > Cc: stable@vger.kernel.org # 4.16+
> > Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > ---
> >  drivers/md/dm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index fbadda68e23b..6e29c2d99b99 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1654,7 +1654,9 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
> >  						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
> >  				part_stat_unlock();
> >  
> > +				bio_set_flag(bio, BIO_QUEUE_ENTERED);
> >  				bio_chain(b, bio);
> > +				trace_block_split(md->queue, b, bio->bi_iter.bi_sector);
> >  				ret = generic_make_request(bio);
> >  				break;
> >  			}
> 
> In theory, BIO_QUEUE_ENTERED is only required when __split_and_process_bio() is
> called from generic_make_request(). However, it may be called from dm_wq_work(),
> this way might cause trouble on operation to q->q_usage_counter.

Good point, I've tweaked this patch to clear BIO_QUEUE_ENTERED in
dm_make_request().

And to Neil's point: yes, these changes really do need to made
common since it appears all bio_split() callers do go on to call
generic_make_request().

Anyway, here is the updated patch that is now staged in linux-next:

From: Mike Snitzer <snitzer@redhat.com>
Date: Fri, 18 Jan 2019 01:21:11 -0500
Subject: [PATCH v2] dm: fix missing bio_split() pattern code in __split_and_process_bio()

Use the same BIO_QUEUE_ENTERED pattern that was established by commit
cd4a4ae4683dc ("block: don't use blocking queue entered for recursive
bio submits") by setting BIO_QUEUE_ENTERED after bio_split() and before
recursing via generic_make_request().

Also add trace_block_split() because it provides useful context about
bio splits in blktrace.

Depends-on: cd4a4ae4683dc ("block: don't use blocking queue entered for recursive bio submits")
Fixes: 18a25da84354 ("dm: ensure bio submission follows a depth-first tree walk")
Cc: stable@vger.kernel.org # 4.16+
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fbadda68e23b..25884f833a32 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1654,7 +1654,9 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
 				part_stat_unlock();
 
+				bio_set_flag(bio, BIO_QUEUE_ENTERED);
 				bio_chain(b, bio);
+				trace_block_split(md->queue, b, bio->bi_iter.bi_sector);
 				ret = generic_make_request(bio);
 				break;
 			}
@@ -1734,6 +1736,13 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 
 	map = dm_get_live_table(md, &srcu_idx);
 
+	/*
+	 * Clear the bio-reentered-generic_make_request() flag,
+	 * will be set again as needed if bio needs to be split.
+	 */
+	if (bio_flagged(bio, BIO_QUEUE_ENTERED))
+		bio_clear_flag(bio, BIO_QUEUE_ENTERED);
+
 	/* if we're suspended, we have to queue this io for later */
 	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
 		dm_put_live_table(md, srcu_idx);
-- 
2.15.0

