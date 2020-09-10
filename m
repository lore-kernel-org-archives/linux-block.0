Return-Path: <SRS0=/Scz=CT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0F7C433E2
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 02:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5144720768
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 02:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AS6FC7r4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgIJCA6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:00:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54805 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730131AbgIJBxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Sep 2020 21:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599702820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xkl/3qn93V9jQLcA57G7oLd5+GXv7DnDeZEho2c0oXY=;
        b=AS6FC7r4TIQsNTfbLAFm51aqmbMzgNH4SG2NBV2QmsuK9+WGUBD6swAOkhTTsAsHrhoSoe
        VZj5FP/bmxA6SpII2GqzUKbaeW7VgEAf9snimOMd628AFI9gGlCkltsgpsFiIJwKS50j33
        K5x+ChuPtPLNREEDqfN/KRl9g1r1AU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-xK6ARIEmPUGycx3vj_Y_mw-1; Wed, 09 Sep 2020 21:53:36 -0400
X-MC-Unique: xK6ARIEmPUGycx3vj_Y_mw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 546F91DE05;
        Thu, 10 Sep 2020 01:53:34 +0000 (UTC)
Received: from T590 (ovpn-12-146.pek2.redhat.com [10.72.12.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C912E1002D4E;
        Thu, 10 Sep 2020 01:53:25 +0000 (UTC)
Date:   Thu, 10 Sep 2020 09:53:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200910015321.GA7420@T590>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
 <20200909104116.1674592-3-ming.lei@redhat.com>
 <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 09, 2020 at 09:04:09AM -0700, Keith Busch wrote:
> On Wed, Sep 09, 2020 at 06:41:14PM +0800, Ming Lei wrote:
> >  void blk_mq_quiesce_queue(struct request_queue *q)
> >  {
> > -	struct blk_mq_hw_ctx *hctx;
> > -	unsigned int i;
> > -	bool rcu = false;
> > +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> > +	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
> >  
> > -	__blk_mq_quiesce_queue_nowait(q);
> > +	if (!was_quiesced && blocking)
> > +		percpu_ref_kill(&q->dispatch_counter);
> >  
> > -	queue_for_each_hw_ctx(q, hctx, i) {
> > -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > -			synchronize_srcu(hctx->srcu);
> > -		else
> > -			rcu = true;
> > -	}
> > -	if (rcu)
> > +	if (blocking)
> > +		wait_event(q->mq_quiesce_wq,
> > +				percpu_ref_is_zero(&q->dispatch_counter));
> > +	else
> >  		synchronize_rcu();
> >  }
> 
> In the previous version, you had ensured no thread can unquiesce a queue
> while another is waiting for quiescence. Now that the locking is gone,
> a thread could unquiesce the queue before percpu_ref reaches zero, so
> the wait_event() may never complete on the resurrected percpu_ref.
> 
> I don't think any drivers do such a thing today, but it just looks like
> the implementation leaves open the possibility.

This driver can cause bigger trouble if it unquiesces its queue which is
being quiesced and still not done.

However, we can avoid that by the following delta change:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7669fe815cf9..5632727d71fa 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -225,9 +225,16 @@ static void __blk_mq_quiesce_queue(struct request_queue *q, bool wait)
 	if (!wait)
 		return;
 
+	/*
+	 * In case of F_BLOCKING, if driver unquiesces its queue which is being
+	 * quiesced and still not done, it can cause bigger trouble, and we simply
+	 * return & warn once for avoiding hang here.
+	 */
 	if (blocking)
 		wait_event(q->mq_quiesce_wq,
-				percpu_ref_is_zero(&q->dispatch_counter));
+				percpu_ref_is_zero(&q->dispatch_counter) ||
+				WARN_ON_ONCE(!percpu_ref_is_dying(
+						&q->dispatch_counter)));
 	else
 		synchronize_rcu();
 }

Thanks, 
Ming

