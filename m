Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECCCC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 03:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2E02192B
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 03:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfBODOO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:14:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfBODOO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 22:14:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAB80368E7;
        Fri, 15 Feb 2019 03:14:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF39360A9D;
        Fri, 15 Feb 2019 03:14:06 +0000 (UTC)
Date:   Fri, 15 Feb 2019 11:14:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH V2] blk-mq: insert rq with DONTPREP to hctx dispatch list
 when requeue
Message-ID: <20190215031401.GD21045@ming.t460p>
References: <1549936585-1702-1-git-send-email-jianchao.w.wang@oracle.com>
 <20190215020049.GA21045@ming.t460p>
 <07260476-307a-efdc-63aa-95ea0a3e7489@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07260476-307a-efdc-63aa-95ea0a3e7489@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 15 Feb 2019 03:14:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 15, 2019 at 10:34:39AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> Thanks for your kindly response.
> 
> On 2/15/19 10:00 AM, Ming Lei wrote:
> > On Tue, Feb 12, 2019 at 09:56:25AM +0800, Jianchao Wang wrote:
> >> When requeue, if RQF_DONTPREP, rq has contained some driver
> >> specific data, so insert it to hctx dispatch list to avoid any
> >> merge. Take scsi as example, here is the trace event log (no
> >> io scheduler, because RQF_STARTED would prevent merging),
> >>
> >>    kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
> >> scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
> >> scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
> >>    kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
> >> scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
> >> scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
> >>    kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
> >>    kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
> >> scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]
> >>
> >> (32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.
> > 
> > scsi_mq_requeue_cmd() does uninit the request before requeuing, but
> > __scsi_queue_insert doesn't do that.
> 
> Yes.
> scsi layer use both of them.
> 
> > 
> > 
> >> Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
> >> the sdb only contained the part of (32768 + 8), then only that part
> >> was completed. The lucky thing was that scsi_io_completion detected
> >> it and requeued the remaining part. So we didn't get corrupted data.
> >> However, the requeue of (32776 + 8) is not expected.
> >>
> >> Suggested-by: Jens Axboe <axboe@kernel.dk>
> >> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> >> ---
> >> V2:
> >>  - refactor the code based on Jens' suggestion
> >>
> >>  block/blk-mq.c | 12 ++++++++++--
> >>  1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index 8f5b533..9437a5e 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -737,12 +737,20 @@ static void blk_mq_requeue_work(struct work_struct *work)
> >>  	spin_unlock_irq(&q->requeue_lock);
> >>  
> >>  	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
> >> -		if (!(rq->rq_flags & RQF_SOFTBARRIER))
> >> +		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
> >>  			continue;
> >>  
> >>  		rq->rq_flags &= ~RQF_SOFTBARRIER;
> >>  		list_del_init(&rq->queuelist);
> >> -		blk_mq_sched_insert_request(rq, true, false, false);
> >> +		/*
> >> +		 * If RQF_DONTPREP, rq has contained some driver specific
> >> +		 * data, so insert it to hctx dispatch list to avoid any
> >> +		 * merge.
> >> +		 */
> >> +		if (rq->rq_flags & RQF_DONTPREP)
> >> +			blk_mq_request_bypass_insert(rq, false);
> >> +		else
> >> +			blk_mq_sched_insert_request(rq, true, false, false);
> >>  	}
> > 
> > Suppose it is one WRITE request to zone device, this way might break
> > the order.
> 
> I'm not sure about this.
> Since the request is dispatched, it should hold and zone write lock.
> And also mq-deadline doesn't have a .requeue_request, zone write lock
> wouldn't be released during requeue.

You are right, looks I misunderstood the zone write lock, sorry for
the noise.

> 
> IMO, this requeue action is similar with what blk_mq_dispatch_rq_list does.
> The latter one also issues the request to underlying driver and requeue rqs
> on dispatch_list if get BLK_STS_SOURCE or BLK_STS_DEV_SOURCE.
> 
> And in addition, RQF_STARTED is set by io scheduler .dispatch_request and
> it could be stop merging as RQF_NOMERGE_FLAGS contains it. 

Yes, that is correct.

Then another question is:

Why don't always requeue request in this way so that it can be simplified
into one code path?

1) in block legacy code, blk_requeue_request() doesn't insert the
request into scheduler queue, and simply put the request into
q->queue_head.

2) blk_mq_requeue_request() is basically run from completion context for
handling very unusual cases(partial completion, error, timeout, ...),
and there shouldn't have benefit to schedule/merge requeued request.

3) RQF_DONTPREP is like a driver private flag, and read/write by driver
only before this patch.

Thanks,
Ming
