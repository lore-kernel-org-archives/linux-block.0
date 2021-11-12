Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EE7C433EF
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 08:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493A060F51
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 08:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhKLIk0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 03:40:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232841AbhKLIkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 03:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636706255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eEABwCigTqrwv09O1J18ECGwGn8XA91lIXAbLCHB8oM=;
        b=QMvqL3HHSsTIK3FTz15Yl0t6GvQdvKIj8MigiFWII8vFUOaWV6hr3fzuG51h29g5oApbUm
        DqPmfHlrXygZ8zF/dhkPHcvBCv7VNqKEljwavDhV/uTJSgR0hHLrzhD/hJvL7vye+WcmR7
        FFXPk1RQ4B0Q673LtYy9Jnor6ypHCCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-eZjJDwDgPqme7NfTnzxFuA-1; Fri, 12 Nov 2021 03:37:31 -0500
X-MC-Unique: eZjJDwDgPqme7NfTnzxFuA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A58721030C22;
        Fri, 12 Nov 2021 08:37:30 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2660B19D9D;
        Fri, 12 Nov 2021 08:37:23 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:37:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after
 submit_bio_checks() is done
Message-ID: <YY4nv5eQUTOF5Wfv@T590>
References: <20211112081137.406930-1-ming.lei@redhat.com>
 <20211112082140.GA30681@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112082140.GA30681@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 12, 2021 at 09:21:40AM +0100, Christoph Hellwig wrote:
> On Fri, Nov 12, 2021 at 04:11:37PM +0800, Ming Lei wrote:
> > @@ -2564,13 +2564,15 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
> >  			if (blk_mq_attempt_bio_merge(q, bio, nsegs,
> >  						same_queue_rq))
> >  				return NULL;
> > +			if (bio->bi_opf != rq->cmd_flags)
> > +				goto fallback;
> 
> I think this deserves a comment, as this means a read prealloc

OK.

> can only be used for reads, and no fua can be set if the preallocating
> I/O didn't use fua, etc.
> 
> What are the pitfalls of just chanigng cmd_flags?

Then we need to check cmd_flags carefully, such as hctx->type has to
be same, flush & passthrough flags has to be same, that said all
->cmd_flags used for allocating rqs have to be same with the following
bio->bi_opf.

In usual cases, I guess all IOs submitted from same plug batch should be
same type. If not, we can switch to change cmd_flags.


Thanks,
Ming

