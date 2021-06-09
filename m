Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333EDC4743D
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 00:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179D3613AD
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 00:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhFIA5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235214AbhFIA5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 20:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623200146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ap6qT933NyTFtcF48S45ZFlWQJW2FoD24uRszMZiO4k=;
        b=Zg3Dp/nGm81HJAWJoQ0IKaeCiVyxiBYkK31jUJ1F19aMTnLu55qQ9ZyV5pWezU5ppTgyln
        XCRRjUPcqSgP/htjOt+PoohobG8olcXQ7KVwvjj+8NeH4pV8i9gO3e+5j07v4eSrLnWlYO
        wFLk39UE1bdn+Uvp5B/nHSsqeBlc1e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-I7GVjIfnOkeWvmG0LY2bGQ-1; Tue, 08 Jun 2021 20:55:45 -0400
X-MC-Unique: I7GVjIfnOkeWvmG0LY2bGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FB6B180FD66;
        Wed,  9 Jun 2021 00:55:44 +0000 (UTC)
Received: from T590 (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92EDC19C45;
        Wed,  9 Jun 2021 00:55:35 +0000 (UTC)
Date:   Wed, 9 Jun 2021 08:55:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH V2 1/2] block: fix race between adding/removing rq qos
 and normal IO
Message-ID: <YMARgunQC12Mp6VH@T590>
References: <20210608071903.431195-1-ming.lei@redhat.com>
 <20210608071903.431195-2-ming.lei@redhat.com>
 <897fbf4d-569d-afae-c20d-745c8e2965d2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897fbf4d-569d-afae-c20d-745c8e2965d2@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 08, 2021 at 08:04:00AM -0700, Bart Van Assche wrote:
> On 6/8/21 12:19 AM, Ming Lei wrote:
> >  static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
> >  {
> > +	/*
> > +	 * No IO can be in-flight when adding rqos, so freeze queue, which
> > +	 * is fine since we only support rq_qos for blk-mq queue
> > +	 */
> > +	blk_mq_freeze_queue(q);
> >  	rqos->next = q->rq_qos;
> >  	q->rq_qos = rqos;
> > +	blk_mq_unfreeze_queue(q);
> >  
> >  	if (rqos->ops->debugfs_attrs)
> >  		blk_mq_debugfs_register_rqos(rqos);
> > @@ -110,12 +117,18 @@ static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
> >  {
> >  	struct rq_qos **cur;
> >  
> > +	/*
> > +	 * No IO can be in-flight when removing rqos, so freeze queue,
> > +	 * which is fine since we only support rq_qos for blk-mq queue
> > +	 */
> > +	blk_mq_freeze_queue(q);
> >  	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
> >  		if (*cur == rqos) {
> >  			*cur = rqos->next;
> >  			break;
> >  		}
> >  	}
> > +	blk_mq_unfreeze_queue(q);
> >  
> >  	blk_mq_debugfs_unregister_rqos(rqos);
> >  }
> 
> Although this patch looks like an improvement to me, I think we also
> need protection against concurrent rq_qos_add() and rq_qos_del() calls,
> e.g. via a mutex.

Fine, one spinlock should be enough, will do it in V3.


Thanks,
Ming

