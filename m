Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D2C433E0
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 12:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D171423358
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 12:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbhAGMIr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jan 2021 07:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbhAGMIq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Jan 2021 07:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610021240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJa8qx6gYzbEB00ZM6yjGefsfTJDQemlWtjIpm1BNYE=;
        b=bWYZL1E4WhZfxBra+hQT9FQxJ1AQNalaTP15Yg4CMDaZRJDMigWOcz1TBAgZHS5327PDeM
        ixjTl/LXizHfwLxz4qntG7j3864Dcn66G/b5MXkVffKOrBHua+sA9bPEBfS+dWkcQgkVwS
        ouTNWqcspm7jnmq/hjhAYFh+VFhB5yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-mp6Bnoi1Mi-Gj2uLtJnYIg-1; Thu, 07 Jan 2021 07:07:19 -0500
X-MC-Unique: mp6Bnoi1Mi-Gj2uLtJnYIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 155E4107ACE4;
        Thu,  7 Jan 2021 12:07:18 +0000 (UTC)
Received: from T590 (ovpn-12-95.pek2.redhat.com [10.72.12.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E036D60916;
        Thu,  7 Jan 2021 12:06:54 +0000 (UTC)
Date:   Thu, 7 Jan 2021 20:06:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: Improve performance of non-mq IO schedulers
 with multiple HW queues
Message-ID: <20210107120647.GA3915822@T590>
References: <20210106102428.551-1-jack@suse.cz>
 <20210106102428.551-3-jack@suse.cz>
 <20210107061918.GA3897511@T590>
 <20210107111815.GB12990@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107111815.GB12990@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 07, 2021 at 12:18:15PM +0100, Jan Kara wrote:
> On Thu 07-01-21 14:19:18, Ming Lei wrote:
> > On Wed, Jan 06, 2021 at 11:24:28AM +0100, Jan Kara wrote:
> > > +/* Check if there are requests queued in hctx lists. */
> > > +static bool blk_mq_hctx_has_queued_rq(struct blk_mq_hw_ctx *hctx)
> > > +{
> > > +	return !list_empty_careful(&hctx->dispatch) ||
> > > +		sbitmap_any_bit_set(&hctx->ctx_map);
> > > +}
> > > +
> > 
> > blk_mq_hctx_mark_pending() is only called in case of none scheduler, so
> > looks not necessary to check hctx->ctx_map in blk_mq_hctx_has_queued_rq()
> > which is supposed to be used when real io scheduler is attached to MQ queue.
> 
> Yes, I know. I just wanted to make the code less fragile... In particular I
> was somewhat uneasy that we'd rely on the implicit behavior that
> blk_mq_get_sqsched_hctx() can return non-NULL only if sbitmap_any_bit_set()
> is not needed. But maybe we could structure the code like:

BTW, I mentioned the point because sbitmap_any_bit_set(hctx->ctx_map) may take
some CPU cycle in case that nr_cpu_ids is big.

> 
> 	sq_hctx = NULL;
> 	if (blk_mq_has_sqsched(q))
> 		sq_hctx = blk_mq_get_sq_hctx(q);
> 	queue_for_each_hw_ctx(q, hctx, i) {
> 		...
> 		if (!sq_hctx || sq_hctx == hctx ||
> 		    !list_empty_careful(&hctx->dispatch))
> 			... run ...
> 	}
> 
> Because then it is kind of obvious that sq_hctx is set only if there's IO
> scheduler for the queue and thus ctx_map is unused. What do you think?

IMO, the above is more readable and efficient.

Thanks,
Ming

