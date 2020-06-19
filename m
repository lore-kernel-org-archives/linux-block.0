Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D46C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 17:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAAA207FC
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 17:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoATyPGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgFSRky (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:40:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54744 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730934AbgFSRkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 13:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592588451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SSpbTMXzbufsXH9rLr9CGShczMzOHa1HOXBaPDsWskY=;
        b=OoATyPGLiTw5xA/C+IVa9zr9t6CyzcINFbcJuBETxP6tMkXynzU5H8L9ABvR9+XeLaSXKq
        kdvy7pAbb2i40KKoelDlIbPdUuTjEKi1Sj9okBoAp9wFB1/hurqLaONCaoUdcBo5uN3CsT
        3JhC2JyqdxrB9MprWMp+fVXW5pom2yk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-vwSGpqWLNw6k3V1hYXsTWA-1; Fri, 19 Jun 2020 13:40:49 -0400
X-MC-Unique: vwSGpqWLNw6k3V1hYXsTWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43BF9872FED;
        Fri, 19 Jun 2020 17:40:48 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 308EB19D7B;
        Fri, 19 Jun 2020 17:40:42 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:40:41 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org, axboe@kernel.dk,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: dm-rq: don't call blk_mq_queue_stopped in dm_stop_queue()
Message-ID: <20200619174040.GA24968@redhat.com>
References: <20200619084214.337449-1-ming.lei@redhat.com>
 <20200619094250.GA18410@redhat.com>
 <20200619101142.GA339442@T590>
 <20200619160657.GA24520@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619160657.GA24520@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 19 2020 at 12:06pm -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Fri, Jun 19 2020 at  6:11am -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Hi Mike,
> > 
> > On Fri, Jun 19, 2020 at 05:42:50AM -0400, Mike Snitzer wrote:
> > > Hi Ming,
> > > 
> > > Thanks for the patch!  But I'm having a hard time understanding what
> > > you've written in the patch header,
> > > 
> > > On Fri, Jun 19 2020 at  4:42am -0400,
> > > Ming Lei <ming.lei@redhat.com> wrote:
> > > 
> > > > dm-rq won't stop queue, meantime blk-mq won't stop one queue too, so
> > > > remove the check.
> > > 
> > > It'd be helpful if you could unpack this with more detail before going on
> > > to explain why using blk_queue_quiesced, despite dm-rq using
> > > blk_mq_queue_stopped, would also be ineffective.
> > > 
> > > SO:
> > > 
> > > > dm-rq won't stop queue
> > > 
> > > 1) why won't dm-rq stop the queue?  Do you mean it won't reliably
> > >    _always_ stop the queue because of the blk_mq_queue_stopped() check?
> > 
> > device mapper doesn't call blk_mq_stop_hw_queue or blk_mq_stop_hw_queues.
> > 
> > > 
> > > > meantime blk-mq won't stop one queue too, so remove the check.
> > > 
> > > 2) Meaning?: blk_mq_queue_stopped() will return true even if only one hw
> > > queue is stopped, given blk-mq must stop all hw queues a positive return
> > > from this blk_mq_queue_stopped() check is incorrectly assuming it meanss
> > > all hw queues are stopped.
> > 
> > blk-mq won't call blk_mq_stop_hw_queue or blk_mq_stop_hw_queues for
> > dm-rq's queue too, so dm-rq's hw queue won't be stopped.
> > 
> > BTW blk_mq_stop_hw_queue or blk_mq_stop_hw_queues are supposed to be
> > used for throttling queue.
> 
> I'm going to look at actually stopping the queue (using one of these
> interfaces).  I didn't realize I wasn't actually stopping the queue.
> The intent was to do so.
> 
> In speaking with Jens yesterday about freeze vs stop: it is clear that
> dm-rq needs to still be able to allocate new requests, but _not_ call
> the queue_rq to issue the requests, while "stopped" (due to dm-mpath
> potentially deferring retries of failed requests because of path failure
> while quiescing the queue during DM device suspend).  But that freezing
> the queue goes too far because it won't allow such request allocation.

Seems I'm damned if I do (stop) or damned if I don't (new reports of
requests completing after DM device suspend's
blk_mq_quiesce_queue()+dm_wait_for_completion()).

I'm left at something of a loss about what to do!  Bart? Jens? Ming?

Looking closer at the git history, commit 7b17c2f7292ba takes center
stage:

commit 7b17c2f7292ba1f3f98dae3f7077f9e569653276
Author: Bart Van Assche <bart.vanassche@sandisk.com>
Date:   Fri Oct 28 17:22:16 2016 -0700

    dm: Fix a race condition related to stopping and starting queues

    Ensure that all ongoing dm_mq_queue_rq() and dm_mq_requeue_request()
    calls have stopped before setting the "queue stopped" flag. This
    allows to remove the "queue stopped" test from dm_mq_queue_rq() and
    dm_mq_requeue_request(). This patch fixes a race condition because
    dm_mq_queue_rq() is called without holding the queue lock and hence
    BLK_MQ_S_STOPPED can be set at any time while dm_mq_queue_rq() is
    in progress. This patch prevents that the following hang occurs
    sporadically when using dm-mq:

    INFO: task systemd-udevd:10111 blocked for more than 480 seconds.
    Call Trace:
     [<ffffffff8161f397>] schedule+0x37/0x90
     [<ffffffff816239ef>] schedule_timeout+0x27f/0x470
     [<ffffffff8161e76f>] io_schedule_timeout+0x9f/0x110
     [<ffffffff8161fb36>] bit_wait_io+0x16/0x60
     [<ffffffff8161f929>] __wait_on_bit_lock+0x49/0xa0
     [<ffffffff8114fe69>] __lock_page+0xb9/0xc0
     [<ffffffff81165d90>] truncate_inode_pages_range+0x3e0/0x760
     [<ffffffff81166120>] truncate_inode_pages+0x10/0x20
     [<ffffffff81212a20>] kill_bdev+0x30/0x40
     [<ffffffff81213d41>] __blkdev_put+0x71/0x360
     [<ffffffff81214079>] blkdev_put+0x49/0x170
     [<ffffffff812141c0>] blkdev_close+0x20/0x30
     [<ffffffff811d48e8>] __fput+0xe8/0x1f0
     [<ffffffff811d4a29>] ____fput+0x9/0x10
     [<ffffffff810842d3>] task_work_run+0x83/0xb0
     [<ffffffff8106606e>] do_exit+0x3ee/0xc40
     [<ffffffff8106694b>] do_group_exit+0x4b/0xc0
     [<ffffffff81073d9a>] get_signal+0x2ca/0x940
     [<ffffffff8101bf43>] do_signal+0x23/0x660
     [<ffffffff810022b3>] exit_to_usermode_loop+0x73/0xb0
     [<ffffffff81002cb0>] syscall_return_slowpath+0xb0/0xc0
     [<ffffffff81624e33>] entry_SYSCALL_64_fastpath+0xa6/0xa8

    Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
    Acked-by: Mike Snitzer <snitzer@redhat.com>
    Reviewed-by: Hannes Reinecke <hare@suse.com>
    Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 09c958b6f038..8b92e066bb69 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -102,7 +102,7 @@ static void dm_mq_stop_queue(struct request_queue *q)
        if (blk_mq_queue_stopped(q))
                return;

-       blk_mq_stop_hw_queues(q);
+       blk_mq_quiesce_queue(q);
 }

 void dm_stop_queue(struct request_queue *q)
@@ -880,17 +880,6 @@ static int dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
                dm_put_live_table(md, srcu_idx);
        }

-       /*
-        * On suspend dm_stop_queue() handles stopping the blk-mq
-        * request_queue BUT: even though the hw_queues are marked
-        * BLK_MQ_S_STOPPED at that point there is still a race that
-        * is allowing block/blk-mq.c to call ->queue_rq against a
-        * hctx that it really shouldn't.  The following check guards
-        * against this rarity (albeit _not_ race-free).
-        */
-       if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
-               return BLK_MQ_RQ_QUEUE_BUSY;
-
        if (ti->type->busy && ti->type->busy(ti))
                return BLK_MQ_RQ_QUEUE_BUSY;


