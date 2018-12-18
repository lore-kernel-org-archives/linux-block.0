Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B685DC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 03:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C84E20874
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 03:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeLRDpn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:45:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeLRDpn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 22:45:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0542445CD3;
        Tue, 18 Dec 2018 03:45:43 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6CDB17B57;
        Tue, 18 Dec 2018 03:45:39 +0000 (UTC)
Date:   Mon, 17 Dec 2018 22:45:38 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: Upcoming merge window
Message-ID: <20181218034538.GA15299@redhat.com>
References: <6fe5169f-8032-ac2a-ecb7-f845c56b1d73@kernel.dk>
 <1545088576.185366.443.camel@acm.org>
 <8ae21d8c-81a1-891a-66c4-c94ff8bee20b@kernel.dk>
 <69609425-5f1d-3c4f-3b1c-34f3b156006a@kernel.dk>
 <83df36a6-f36b-43b0-8817-59feff02038e@kernel.dk>
 <0ad2ac54-c1e4-10bb-2129-6ef3e962c43e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad2ac54-c1e4-10bb-2129-6ef3e962c43e@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 18 Dec 2018 03:45:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17 2018 at  7:26pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 12/17/18 5:16 PM, Jens Axboe wrote:
> > On 12/17/18 4:49 PM, Jens Axboe wrote:
> >> On 12/17/18 4:27 PM, Jens Axboe wrote:
> >>> On 12/17/18 4:16 PM, Bart Van Assche wrote:
> >>>> On Mon, 2018-12-17 at 11:28 -0700, Jens Axboe wrote:
> >>>>> As I'm sure you're all aware, the merge window is coming up. This time
> >>>>> it happens to coincide with that is a holiday for most. My plan is to
> >>>>> send in an EARLY pull request to Linus, Thursday at the latest. If you're
> >>>>> sitting on anything that should go in with the initial merge, then I need
> >>>>> to have it ASAP.
> >>>>>
> >>>>> I'll do a later pull about a week in with things that were missed, but
> >>>>> I'm really hoping to make that fixes only. Any driver updates etc should
> >>>>> go in now.
> >>>>
> >>>> Hi Jens,
> >>>>
> >>>> If I run blktests/srp/002 against Linus' master branch then that test passes,
> >>>> no matter how many times I run that test. If I run that test against your
> >>>> for-next branch however (commit 6a252f2772c0) then that test hangs. The output
> >>>> of my list-pending-block-requests script is as follows when the hang occurs:
> >>>
> >>> Ugh, I'll try and run that here again, that test is unfortunately such a pain
> >>> to run and requires me to manually install multipath libs (and remember to
> >>> uninstall before rebooting, or udev fails?).
> >>>
> >>> I'll take a look!
> >>
> >> Looks like what Ming was talking about. CC'ing Ming and Mike. Lots of
> >> kworkers are stuck like this:
> >>
> >> [  252.310187] kworker/2:19    D14072  8147      2 0x80000000
> >> [  252.316803] Workqueue: dio/dm-2 dio_aio_complete_work
> >> [  252.322925] Call Trace:
> >> [  252.326137]  ? __schedule+0x231/0x5f0
> >> [  252.330703]  schedule+0x2a/0x80
> >> [  252.334689]  rwsem_down_write_failed+0x204/0x320
> >> [  252.340330]  ? generic_make_request_checks+0x55/0x370
> >> [  252.346542]  ? call_rwsem_down_write_failed+0x13/0x20
> >> [  252.352669]  call_rwsem_down_write_failed+0x13/0x20
> >> [  252.358601]  down_write+0x1b/0x30
> >> [  252.362781]  __generic_file_fsync+0x3e/0xb0
> >> [  252.367933]  ext4_sync_file+0xcc/0x2e0
> >> [  252.372599]  dio_complete+0x1c4/0x210
> >> [  252.377168]  process_one_work+0x1cb/0x350
> >> [  252.382915]  worker_thread+0x28/0x3c0
> >> [  252.387482]  ? process_one_work+0x350/0x350
> >> [  252.392632]  kthread+0x107/0x120
> >> [  252.396717]  ? kthread_park+0x80/0x80
> >> [  252.401285]  ret_from_fork+0x1f/0x30
> >>
> >> Where did this regression come from? This was passing just fine
> >> recently.
> > 
> > Looks like this is the offending commit:
> > 
> > commit c4576aed8d85d808cd6443bda58393d525207d01
> > Author: Mike Snitzer <snitzer@redhat.com>
> > Date:   Tue Dec 11 09:10:26 2018 -0500
> > 
> >     dm: fix request-based dm's use of dm_wait_for_completion
> 
> Yep confirmed, reverted that on top and it passes. dm-2 has plenty of
> requests that are allocated and pending dispatch, so the md_in_flight()
> will return true. Mike, should it be checking for allocated requests or
> in-flight?

I thought we could just check for allocated (as blk_mq_check_busy() does
now) but clearly that is too broad a scope because I tested your
suggestion and it allows the srp/002 test to pass:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6847f014606b..edbf4bb1b3e8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -812,7 +812,7 @@ static bool blk_mq_check_busy(struct blk_mq_hw_ctx *hctx, struct request *rq,
         * If we find a request, we know the queue is busy. Return false
         * to stop the iteration.
         */
-       if (rq->q == hctx->queue) {
+       if (rq->state == MQ_RQ_IN_FLIGHT && rq->q == hctx->queue) {
                bool *busy = priv;

                *busy = true;

blk_mq_check_busy() was introduced for DM to user as a replacement for
its own inflight accounting it was doing:
  ae879912 blk-mq: provide a helper to check if a queue is busy

So nothing else is currently calling it, but if you'd prefer to rename
the functions to reflect the narrower MQ_RQ_IN_FLIGHT check that is fine
by me (e.g. blk_mq_check_inflight and blk_mq_queue_has_inflight).

Mike
