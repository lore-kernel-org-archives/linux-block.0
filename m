Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E25C48BE5
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 08:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB92611C1
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 08:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUIoV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 04:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhFUIoU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 04:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624264926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5sbzr9XPq1LgidDaQqIaLaDJS9KPyp6a/zru6azg0dE=;
        b=Wrwf0KXG65iqyMj8PHErL3dGxaMk+IWLpmNY0IzWKx1hLtrfxRUbiImFjAixgqVzhGcrFc
        XXkDvwljd1LMeLtOsYB01tgV/6AK6Twk1WpIwJULFJ2iN9nEKI3Xli4FMg3yF1fGkR6hD4
        1vZH9LZ7Se3TaaYqdB0H957XPiTArjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-RrT0RfK4MNml5i07-kcRMQ-1; Mon, 21 Jun 2021 04:42:05 -0400
X-MC-Unique: RrT0RfK4MNml5i07-kcRMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1A9B800C60;
        Mon, 21 Jun 2021 08:42:03 +0000 (UTC)
Received: from T590 (ovpn-13-237.pek2.redhat.com [10.72.13.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 514791ABD4;
        Mon, 21 Jun 2021 08:41:50 +0000 (UTC)
Date:   Mon, 21 Jun 2021 16:41:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH V2 2/3] block: add ->poll_bio to
 block_device_operations
Message-ID: <YNBQvSR3glgt59J9@T590>
References: <20210617103549.930311-1-ming.lei@redhat.com>
 <20210617103549.930311-3-ming.lei@redhat.com>
 <20210621072502.GC6651@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621072502.GC6651@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 09:25:02AM +0200, Christoph Hellwig wrote:
> > +	struct gendisk *disk = bio->bi_bdev->bd_disk;
> > +	struct request_queue *q = disk->queue;
> >  	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> >  	int ret;
> >  
> > -	if (cookie == BLK_QC_T_NONE || !blk_queue_poll(q))
> > +	if ((queue_is_mq(q) && cookie == BLK_QC_T_NONE) ||
> > +			!blk_queue_poll(q))
> >  		return 0;
> 
> How does polling for a bio without a cookie make sense even when
> polling bio based?

It isn't necessary to use bio->bi_cookie, that is why I doesn't use it,
which actually provides one free 32bit in bio for bio based driver.

> 
> But if we come up for a good rationale for this I'd really
> split the conditions to make them more readable:
> 
> 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> 		return 0;
> 	if (queue_is_mq(q) && cookie == BLK_QC_T_NONE)
> 		return 0;

OK.

> 
> > +	if (!queue_is_mq(q)) {
> > +		if (disk->fops->poll_bio) {
> > +			ret = disk->fops->poll_bio(bio, flags);
> > +		} else {
> > +			WARN_ON_ONCE(1);
> > +			ret = 0;
> > +		}
> > +	} else {
> >  		ret = blk_mq_poll(q, cookie, flags);
> 
> I'd go for someting like:
> 
> 	if (queue_is_mq(q))
> 		ret = blk_mq_poll(q, cookie, flags);
> 	else if (disk->fops->poll_bio)
> 		ret = disk->fops->poll_bio(bio, flags);
> 	else
> 		WARN_ON_ONCE(1);
> 
> with ret initialized to 0 at declaration time.

Fine.

> 
> >  struct block_device_operations {
> >  	void (*submit_bio)(struct bio *bio);
> > +	/* ->poll_bio is for bio driver only */
> 
> I'd drop the comment, this is already nicely documented in add_disk
> together with the actual check.  We also don't note this for submit_bio
> here.

OK.



thanks,
Ming

