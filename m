Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CCCC433ED
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 07:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AD861176
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 07:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhEFHbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 03:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232271AbhEFHbb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 May 2021 03:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620286233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pnA2oakZVMB0tHC7iNPMtWtX2MTo0i6MiLGDBlu/0U=;
        b=OVxJcx00ChSKJGWPsjtJj7HlSeo5MAzhl/SxfjPFBpsxGZLM0x1C1sWFswt1fYcH4Q3XW3
        u7dqnfg5cnZbotd5T5og1JgQiQGGGk46RsbnSDD497btj4gYudPzCk7enoz5Dh54ueVWU8
        mAc+0NCY+oPDg53rTV9jJb5c3lQJNIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-wTK3uFx6PxSI_L07WJyrBw-1; Thu, 06 May 2021 03:30:32 -0400
X-MC-Unique: wTK3uFx6PxSI_L07WJyrBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03751CC62C;
        Thu,  6 May 2021 07:30:31 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C756D1001901;
        Thu,  6 May 2021 07:30:23 +0000 (UTC)
Date:   Thu, 6 May 2021 15:30:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 2/4] blk-mq: grab rq->refcount before calling ->fn in
 blk_mq_tagset_busy_iter
Message-ID: <YJObCuvdxMZssQvI@T590>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-3-ming.lei@redhat.com>
 <20210506065440.GC328487@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506065440.GC328487@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 07:54:40AM +0100, Christoph Hellwig wrote:
> On Wed, May 05, 2021 at 10:58:53PM +0800, Ming Lei wrote:
> > Grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter(), and
> > this way will prevent the request from being re-used when ->fn is
> > running. The approach is same as what we do during handling timeout.
> > 
> > Fix request UAF related with completion race or queue releasing:
> 
> I guess UAF is supposed to mean use-after-free?  Please just spell that
> out.

OK.

> 
> > +	rq = blk_mq_find_and_get_req(tags, bitnr);
> >  	/*
> >  	 * We can hit rq == NULL here, because the tagging functions
> >  	 * test and set the bit before assigning ->rqs[].
> >  	 */
> > +	if (!rq)
> > +		return true;
> 
> Nit: I'd find this much earier to follow if the blk_mq_find_and_get_req
> and thus assignment to rq was after the block comment.

OK.

> 
> >  	struct blk_mq_tags *tags = iter_data->tags;
> >  	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
> >  	struct request *rq;
> > +	bool ret = true;
> > +	bool iter_static_rqs = !!(iter_data->flags & BT_TAG_ITER_STATIC_RQS);
> >  
> >  	if (!reserved)
> >  		bitnr += tags->nr_reserved_tags;
> > @@ -272,16 +288,19 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >  	 * We can hit rq == NULL here, because the tagging functions
> >  	 * test and set the bit before assigning ->rqs[].
> >  	 */
> > +	if (iter_static_rqs)
> 
> I think this local variable just obsfucates what is going on here.

It has to be one local variable, otherwise sparse may complain since
iter_data->flags may be thought as being changed during the period.


Thanks,
Ming

