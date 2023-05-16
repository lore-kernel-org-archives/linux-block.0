Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB732C77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 08:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjEPIK7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 04:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjEPIKz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 04:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC73C12
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684224614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxxnRBGw7W4rKJQepfAd0sVrenF01AjD8rT4tj9f8Hc=;
        b=HjP23bJVdooWS84a1a1uIYxyrayNUr1bE8BwICt3cne+avYxFlEJTkmyqpAK+wottoq/wZ
        bwqvpph7GKkK4L/+nWikgjCYGdBvhipO1p2T6C5ILYqc6w6aIb6tXlWRcu3Csh8r0d7K7i
        sKIsNNlHEQt2SQIyJW//anv1RgUIJ7Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-idvXDreJOHO7A33YzDjjYw-1; Tue, 16 May 2023 04:10:10 -0400
X-MC-Unique: idvXDreJOHO7A33YzDjjYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F6BC8026E8;
        Tue, 16 May 2023 08:10:10 +0000 (UTC)
Received: from ovpn-8-19.pek2.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DBFD4078906;
        Tue, 16 May 2023 08:10:05 +0000 (UTC)
Date:   Tue, 16 May 2023 16:10:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com
Subject: Re: [PATCH V2 1/2] blk-mq: don't queue plugged passthrough requests
 into scheduler
Message-ID: <ZGM6WYmCNC7vpDIw@ovpn-8-19.pek2.redhat.com>
References: <20230515144601.52811-1-ming.lei@redhat.com>
 <20230515144601.52811-2-ming.lei@redhat.com>
 <20230516062221.GA7325@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516062221.GA7325@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 16, 2023 at 08:22:21AM +0200, Christoph Hellwig wrote:
> On Mon, May 15, 2023 at 10:46:00PM +0800, Ming Lei wrote:
> > +		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
> > +				pt != blk_rq_is_passthrough(rq)) {
> 
> Can your format this as:
> 
> 		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
> 			   pt != blk_rq_is_passthrough(rq)) {
> 
> for readability?

Do you mean indent for 'pt = blk_rq_is_passthrough(rq)' and keep 'pt' aligned
with 'if' in last line? Otherwise, can't see any difference between the two, :-(

> 
> > +			/*
> > +			 * Both passthrough and flush request don't belong to
> > +			 * scheduler, but flush request won't be added to plug
> > +			 * list, so needn't handle here.
> > +			 */
> >  			rq_list_add_tail(&requeue_lastp, rq);
> 
> This comment confuses the heck out of me.  The check if for passthrough
> vs non-passthrough and doesn't involved flush requests at all.
> 
> I'd prefer to drop it, and instead comment on passthrough requests
> not going to the scheduled below where we actually issue other requests
> to the scheduler.

Any request can be in plug list in theory, we just don't add flush request
to plug, that is why the above comment is added. If you don't like the
words for flush request, I can drop it.

> 
> > +	if (pt) {
> > +		spin_lock(&this_hctx->lock);
> > +		list_splice_tail_init(&list, &this_hctx->dispatch);
> > +		spin_unlock(&this_hctx->lock);
> > +		blk_mq_run_hw_queue(this_hctx, from_sched);
> 
> .. aka here.  But why can't we just use the blk_mq_insert_requests
> for this case anyway?

If the pt request is part of error recovery, it should be issued to
->dispatch list directly, so just for the sake of safety, meantime keep
same behavior with blk_mq_insert_request().

Thanks,
Ming

