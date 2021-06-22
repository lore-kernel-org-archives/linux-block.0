Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F442C48BE5
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0519A611CE
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhFVHyJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhFVHyJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 03:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624348313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQ5lzBRbQaADouojUKzMXNtn56ZiBfCNpQR+Qfx08lw=;
        b=Aez9IRLgD1bi1gRfeJQ8yDmqRxkyTZ4t7cppGj61CVHC3IaKwoNlRDHRx8huUauHakGvDx
        k68WRWuIcrk/00OQieYzlTk0Tw6I4I1gVNFdxcPxk951T18KMOT3qF5lyTmPEP9AGEAjbC
        VXNF92SHyxFGy6cZKk/ivj6gIGPw1DU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-sTV-giU0O2uee1TMwDsc9w-1; Tue, 22 Jun 2021 03:51:50 -0400
X-MC-Unique: sTV-giU0O2uee1TMwDsc9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11B8A362FD;
        Tue, 22 Jun 2021 07:51:49 +0000 (UTC)
Received: from T590 (ovpn-13-52.pek2.redhat.com [10.72.13.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE39460C9F;
        Tue, 22 Jun 2021 07:51:42 +0000 (UTC)
Date:   Tue, 22 Jun 2021 15:51:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Wang Shanker <shankerwangmiao@gmail.com>
Subject: Re: [PATCH 1/2] block: fix discard request merge
Message-ID: <YNGWioq53qoPlBMi@T590>
References: <20210609004556.46928-1-ming.lei@redhat.com>
 <20210609004556.46928-2-ming.lei@redhat.com>
 <20210622065309.GA29691@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622065309.GA29691@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 08:53:09AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 09, 2021 at 08:45:55AM +0800, Ming Lei wrote:
> > index 4d97fb6dd226..bcdff1879c34 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -559,10 +559,14 @@ static inline unsigned int blk_rq_get_max_segments(struct request *rq)
> >  static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
> >  		unsigned int nr_phys_segs)
> >  {
> > -	if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))
> > +	if (blk_integrity_merge_bio(req->q, req, bio) == false)
> >  		goto no_merge;
> >  
> > -	if (blk_integrity_merge_bio(req->q, req, bio) == false)
> > +	/* discard request merge won't add new segment */
> > +	if (req_op(req) == REQ_OP_DISCARD)
> > +		return 1;
> > +
> > +	if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))
> 
> I'd rather handle this by returning UINT_MAX for discard requests from
> blk_rq_get_max_segments given that bio_attempt_discard_merge is only used
> for the !DISCARD_MERGE case anyway.

This way makes very big req->nr_phys_segments or overflows it, and may break
drivers.

At least it breaks blk_rq_nr_discard_segments(), which looks easy to fix. But we
need to audit every driver to use req->nr_phys_segments directly in case of
discard request.



Thanks,
Ming

