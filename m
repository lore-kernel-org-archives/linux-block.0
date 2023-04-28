Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D909C77B61
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 05:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbjD1Fr0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Apr 2023 01:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjD1FrZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 01:47:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B5C1FD3
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 22:47:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D530B68D0A; Fri, 28 Apr 2023 07:47:21 +0200 (CEST)
Date:   Fri, 28 Apr 2023 07:47:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 5/9] block: mq-deadline: Simplify
 deadline_skip_seq_writes()
Message-ID: <20230428054721.GF8549@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-6-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424203329.2369688-6-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 24, 2023 at 01:33:25PM -0700, Bart Van Assche wrote:
> Make the deadline_skip_seq_writes() code shorter without changing its
> functionality.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index a016cafa54b3..6276afede9cd 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -304,14 +304,11 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>  						struct request *rq)
>  {
>  	sector_t pos = blk_rq_pos(rq);
> -	sector_t skipped_sectors = 0;
>  
> -	while (rq) {
> -		if (blk_rq_pos(rq) != pos + skipped_sectors)
> -			break;
> -		skipped_sectors += blk_rq_sectors(rq);
> +	do {
> +		pos += blk_rq_sectors(rq);
>  		rq = deadline_latter_request(rq);
> -	}
> +	} while (rq && blk_rq_pos(rq) == pos);

Looks good, although I'd maybe rename pos to next_pos for clarity.

Reviewed-by: Christoph Hellwig <hch@lst.de>

