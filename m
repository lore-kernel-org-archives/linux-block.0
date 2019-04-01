Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6EFC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 02:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C3420879
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 02:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfDACGf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfDACGf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 22:06:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 451AE3086214;
        Mon,  1 Apr 2019 02:06:35 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD22A60185;
        Mon,  1 Apr 2019 02:06:27 +0000 (UTC)
Date:   Mon, 1 Apr 2019 10:06:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/5] blk-mq: re-organize blk_mq_exit_hctx() into two parts
Message-ID: <20190401020622.GC30776@ming.t460p>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <20190331030954.22320-2-ming.lei@redhat.com>
 <f36610c3-efb1-f364-48af-3d365bbb0144@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36610c3-efb1-f364-48af-3d365bbb0144@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 01 Apr 2019 02:06:35 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 01, 2019 at 09:40:32AM +0800, Dongli Zhang wrote:
> 
> 
> On 3/31/19 11:09 AM, Ming Lei wrote:
> > This patch re-organizes blk_mq_exit_hctx() into two parts, and
> > one part is for exit hctx, and another part is for free hw queue.
> > 
> > No function change, just prepare for fixing hctx lifetime issue.
> > 
> > Cc: James Smart <james.smart@broadcom.com>
> > Cc: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: linux-scsi@vger.kernel.org,
> > Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> > Cc: Christoph Hellwig <hch@lst.de>,
> > Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> > Cc: jianchao wang <jianchao.w.wang@oracle.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 70b210a308c4..53265ce45238 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2229,6 +2229,16 @@ static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
> >  					    &hctx->cpuhp_dead);
> >  }
> >  
> > +static void blk_mq_free_hctx(struct request_queue *q,
> > +		struct blk_mq_hw_ctx *hctx)
> > +{
> > +	if (hctx->flags & BLK_MQ_F_BLOCKING)
> > +		cleanup_srcu_struct(hctx->srcu);
> > +
> > +	blk_free_flush_queue(hctx->fq);
> > +	sbitmap_free(&hctx->ctx_map);
> > +}
> > +
> >  /* hctx->ctxs will be freed in queue's release handler */
> >  static void blk_mq_exit_hctx(struct request_queue *q,
> >  		struct blk_mq_tag_set *set,
> > @@ -2243,12 +2253,7 @@ static void blk_mq_exit_hctx(struct request_queue *q,
> >  	if (set->ops->exit_hctx)
> >  		set->ops->exit_hctx(hctx, hctx_idx);
> >  
> > -	if (hctx->flags & BLK_MQ_F_BLOCKING)
> > -		cleanup_srcu_struct(hctx->srcu);
> > -
> >  	blk_mq_remove_cpuhp(hctx);
> > -	blk_free_flush_queue(hctx->fq);
> > -	sbitmap_free(&hctx->ctx_map);
> >  }
> >  
> >  static void blk_mq_exit_hw_queues(struct request_queue *q,
> > @@ -2262,6 +2267,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
> >  			break;
> >  		blk_mq_debugfs_unregister_hctx(hctx);
> >  		blk_mq_exit_hctx(q, set, hctx, i);
> > +		blk_mq_free_hctx(q, hctx);
> 
> Assuming if this direction is still followed, how about blk_mq_realloc_hw_ctxs()
> which is another caller of blk_mq_exit_hctx(), while part of blk_mq_exit_hctx()
> is extracted and encapsulated into blk_mq_free_hctx()?
> 
> Additional blk_mq_free_hctx() is missing?

Good catch!

Another two blk_mq_exit_hctx() is called just before kobject_put(&hctx->kobj), then
we can simply move blk_mq_free_hctx() into hctx's release handler(blk_mq_hw_sysfs_release),
then thing is simplified too.

Thanks,
Ming
