Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48548C2BA19
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1207F2087E
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6IN3r34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgDYDo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:44:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22475 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726038AbgDYDo0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 23:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587786264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euwtWhGl6jOFMhAUsmhgMf+9jmZAsVAB9oH+pdyWvDM=;
        b=T6IN3r34r0inAujGnO64TeZt8iKN4oERWPu6jM6MyuCz5jTHmsmdq6ArxS4/Oo43kqCrRM
        lVPA1r884EuOhRj8hkCmr2yyhjJ3n8yOHaKRznuf1vRm2R3YC606MPuz0hVwg/5KM9hNsE
        MG6e6kZQz/BjU2Yg0amw1IcjE+28iT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-9P6YY28VMx-IiPQ951uIWg-1; Fri, 24 Apr 2020 23:44:20 -0400
X-MC-Unique: 9P6YY28VMx-IiPQ951uIWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F9ED872FE0;
        Sat, 25 Apr 2020 03:44:19 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3AE25C1D2;
        Sat, 25 Apr 2020 03:44:11 +0000 (UTC)
Date:   Sat, 25 Apr 2020 11:44:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 08/11] block: add blk_end_flush_machinery
Message-ID: <20200425034405.GG477579@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-9-ming.lei@redhat.com>
 <20200424104136.GE28156@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424104136.GE28156@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 12:41:36PM +0200, Christoph Hellwig wrote:
> On Fri, Apr 24, 2020 at 06:23:48PM +0800, Ming Lei wrote:
> > +/* complete requests which just requires one flush command */
> > +static void blk_complete_flush_requests(struct blk_flush_queue *fq,
> > +		struct list_head *flush_list)
> > +{
> > +	struct block_device *bdev;
> > +	struct request *rq;
> > +	int error = -ENXIO;
> > +
> > +	if (list_empty(flush_list))
> > +		return;
> > +
> > +	rq = list_first_entry(flush_list, struct request, queuelist);
> > +
> > +	/* Send flush via one active hctx so we can move on */
> > +	bdev = bdget_disk(rq->rq_disk, 0);
> > +	if (bdev) {
> > +		error = blkdev_issue_flush(bdev, GFP_KERNEL, NULL);
> > +		bdput(bdev);
> > +	}
> 
> FYI, we don't really need the bdev to send a bio anymore, this could just
> do:
> 
> 	bio = bio_alloc(GFP_KERNEL, 0); // XXX: shouldn't this be GFP_NOIO??

Error handling.

> 	bio->bi_disk = rq->rq_disk;
> 	bio->bi_partno = 0;
> 	bio_associate_blkg(bio); // XXX: actually, shouldn't this come from rq?
> 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
> 	error = submit_bio_wait(bio);
> 	bio_put(bio);

Yeah, that is another way, however I prefer to blkdev_issue_flush
because it takes less code and we do have the API of blkdev_issue_flush.


Thanks,
Ming

