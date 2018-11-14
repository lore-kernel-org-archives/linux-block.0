Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D07C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 07:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BDA223DD
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 07:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BDA223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeKNSA3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:00:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbeKNSA3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 13:00:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21E563001585;
        Wed, 14 Nov 2018 07:58:22 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2CB06013F;
        Wed, 14 Nov 2018 07:58:14 +0000 (UTC)
Date:   Wed, 14 Nov 2018 15:58:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] SCSI: fix queue cleanup race before queue is
 initialized done
Message-ID: <20181114075808.GA20550@ming.t460p>
References: <20181114043512.19627-1-ming.lei@redhat.com>
 <31e77713-c974-1d6a-89a6-7c09b8190ef1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31e77713-c974-1d6a-89a6-7c09b8190ef1@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 14 Nov 2018 07:58:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 01:41:46PM +0800, jianchao.wang wrote:
> 
> 
> On 11/14/18 12:35 PM, Ming Lei wrote:
> > c2856ae2f315d ("blk-mq: quiesce queue before freeing queue") has
> > already fixed this race, however the implied synchronize_rcu()
> > in blk_mq_quiesce_queue() can slow down LUN probe a lot, so caused
> > performance regression.
> > 
> > Then 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
> > tried to only quiesce queue for avoiding unnecessary synchronize_rcu()
> > in case that queue isn't initialized done.
> > 
> > However, turns out we still need to quiesce the queue in case that
> > queue isn't initialized done. Because when one SCSI command is
> > completed, the user is waken up immediately, then the scsi device
> > can be removed, meantime the run queue in scsi_end_request() can
> > be still in-progress, so kernel panic is triggered.
> > 
> > In Red Hat QE lab, there are several reports about this kind of kernel
> > panic triggered during kernel booting.
> > 
> > Fixes: 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
> > Cc: Andrew Jones <drjones@redhat.com>
> > Cc: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: linux-scsi@vger.kernel.org
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
> > Cc: stable <stable@vger.kernel.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-core.c        |  6 +++---
> >  drivers/scsi/scsi_lib.c | 36 ++++++++++++++++++++++++++++++------
> >  2 files changed, 33 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index ce12515f9b9b..cf7742a677c4 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -798,9 +798,9 @@ void blk_cleanup_queue(struct request_queue *q)
> >  	 * dispatch may still be in-progress since we dispatch requests
> >  	 * from more than one contexts.
> >  	 *
> > -	 * No need to quiesce queue if it isn't initialized yet since
> > -	 * blk_freeze_queue() should be enough for cases of passthrough
> > -	 * request.
> > +	 * We rely on driver to deal with the race in case that queue
> > +	 * initialization isn't done.
> > +	 *
> >  	 */
> >  	if (q->mq_ops && blk_queue_init_done(q))
> >  		blk_mq_quiesce_queue(q);
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index c7fccbb8f554..7ec7a8a2d000 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -697,13 +697,37 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
> >  		 */
> >  		scsi_mq_uninit_cmd(cmd);
> >  
> > -		__blk_mq_end_request(req, error);
> > +		/*
> > +		 * When block queue initialization isn't done, the request
> > +		 * queue won't be quiesced in blk_cleanup_queue() for avoiding
> > +		 * slowing down LUN probe, so queue still may be run even though
> > +		 * its resource is cleaned up, this way can cause kernel panic.
> > +		 *
> > +		 * Workaround this issue by freeing request after running the
> > +		 * queue when queue initialization isn't done, so the queue's
> > +		 * usage counter can be held during running queue.
> > +		 *
> > +		 * This way is safe because sdev->device_busy has been decreased
> > +		 * already, and scsi_queue_rq() may guarantee the forward-progress.
> > +		 *
> > +		 */
> > +		if (blk_queue_init_done(q)) {
> > +			__blk_mq_end_request(req, error);
> > +
> > +			if (scsi_target(sdev)->single_lun ||
> > +					!list_empty(&sdev->host->starved_list))
> > +				kblockd_schedule_work(&sdev->requeue_work);
> > +			else
> > +				blk_mq_run_hw_queues(q, true);
> > +		} else {
> >  
> > -		if (scsi_target(sdev)->single_lun ||
> > -		    !list_empty(&sdev->host->starved_list))
> > -			kblockd_schedule_work(&sdev->requeue_work);
> > -		else
> > -			blk_mq_run_hw_queues(q, true);
> > +			if (scsi_target(sdev)->single_lun ||
> > +					!list_empty(&sdev->host->starved_list))
> > +				kblockd_schedule_work(&sdev->requeue_work);
> > +			else
> > +				blk_mq_run_hw_queues(q, true);
> > +			__blk_mq_end_request(req, error);
> > +		}
> >  	} else {
> >  		unsigned long flags;
> >  
> > 
> 
> Why not get a q_usage_counter during this ?
> 
> Something like，

Yeah, it is basically the approach in my mind first, but I thought
queue_enter/exit need to be exported, looks it is simpler to get/put
.q_usage_counter directly.

Will do it in V2.

Thanks,
Ming
