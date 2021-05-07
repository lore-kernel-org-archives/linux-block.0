Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A9FC433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 02:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6760260FEF
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 02:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhEGCHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 22:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231288AbhEGCHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 May 2021 22:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620353211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KqUwpk3ud3G0RouqIlRZJZ246ebqOfDtqjFmEkjH1gs=;
        b=REZwotTlAFMDIGD04+BMT1bORjFJ9sBBvhQo45S3YkFa3XRw6muu8+MykAvYdMNhUfP6/Q
        9QNvhGOPFxj8rMNQApkteEmSlX+sf2f531Gep7AZbjpBvVIo8hwm534vRPrrRH1gdmvyXa
        NianY73oJTg+Q/xeJ88E5u4P8FZ6anE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-toAKeOwJOnmiEfrUldPXeg-1; Thu, 06 May 2021 22:06:50 -0400
X-MC-Unique: toAKeOwJOnmiEfrUldPXeg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B751A1006C94;
        Fri,  7 May 2021 02:06:48 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15B2E60871;
        Fri,  7 May 2021 02:06:37 +0000 (UTC)
Date:   Fri, 7 May 2021 10:06:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YJSgqS4YtQkNSiKr@T590>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <423139b7-cb64-64dd-08f0-86f5b2681e70@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423139b7-cb64-64dd-08f0-86f5b2681e70@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 06:11:59PM -0700, Bart Van Assche wrote:
> On 5/5/21 7:58 AM, Ming Lei wrote:
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 4a40d409f5dd..8b239dcce85f 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -203,9 +203,14 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
> >   		unsigned int bitnr)
> >   {
> >   	struct request *rq = tags->rqs[bitnr];
> > +	unsigned long flags;
> > -	if (!rq || !refcount_inc_not_zero(&rq->ref))
> > +	spin_lock_irqsave(&tags->lock, flags);
> > +	if (!rq || !refcount_inc_not_zero(&rq->ref)) {
> > +		spin_unlock_irqrestore(&tags->lock, flags);
> >   		return NULL;
> > +	}
> > +	spin_unlock_irqrestore(&tags->lock, flags);
> >   	return rq;
> >   }
> 
> Shouldn't the 'rq = tags->rqs[bitnr]' assignment be protected by tags->lock
> too? Otherwise a request pointer could be read before the request pointer
> clearing happens and the refcount_inc_not_zero() call could happen after the
> request clearing.

Right, will fix it.

-- 
Ming

