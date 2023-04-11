Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDDCC7619A
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 06:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjDKGih (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 02:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjDKGif (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 02:38:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB75E42
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 23:38:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EDBD268BFE; Tue, 11 Apr 2023 08:38:12 +0200 (CEST)
Date:   Tue, 11 Apr 2023 08:38:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v2 02/12] block: Send flush requests to the I/O
 scheduler
Message-ID: <20230411063812.GA19616@lst.de>
References: <20230407235822.1672286-1-bvanassche@acm.org> <20230407235822.1672286-3-bvanassche@acm.org> <af4aeeea-79b2-8b0d-df8b-63f5ae6752d7@kernel.org> <f81541f6-2fba-3d62-bd63-6b00b5cf5f5d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f81541f6-2fba-3d62-bd63-6b00b5cf5f5d@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 10, 2023 at 05:15:44PM -0700, Bart Van Assche wrote:
> Subject: [PATCH] block: Send flush requests to the I/O scheduler
>
> Send flush requests to the I/O scheduler such that I/O scheduler policies
> are applied to writes with the FUA flag set. Separate the I/O scheduler
> members from the flush members in struct request since with this patch
> applied a request may pass through both an I/O scheduler and the flush
> machinery.
>
> This change affects the statistics of I/O schedulers that track I/O
> statistics (BFQ and mq-deadline).

This looks reasonably to me, as these special cases are nasty.
But we'll need very careful testing, including performance testing
to ensure this doesn't regress.

> +		blk_mq_sched_insert_request(rq, /*at_head=*/false,
> +					    /*run_queue=*/true, /*async=*/true);

And place drop these silly comments.  If you want to do something about
this rather suboptimal interface convert the three booleans to a flags
argument with properly named flags.

> -	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
> -		return true;
> -
> -	return false;
> +	return req_op(rq) == REQ_OP_FLUSH || blk_rq_is_passthrough(rq);

This just seem like an arbitrary reformatting.  While I also prefer
your new version, I don't think it belongs into this patch.
