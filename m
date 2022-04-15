Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7244C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 05:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349385AbiDOFJX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351881AbiDOFGY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 01:06:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DB109E
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 21:59:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BC99F68B05; Fri, 15 Apr 2022 06:59:27 +0200 (CEST)
Date:   Fri, 15 Apr 2022 06:59:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] block: don't print I/O error warning for dead disks
Message-ID: <20220415045927.GA22669@lst.de>
References: <20220323163815.1526998-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323163815.1526998-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Wed, Mar 23, 2022 at 05:38:15PM +0100, Christoph Hellwig wrote:
> When a disk has been marked dead, don't print warnings for I/O errors
> as they are very much expected.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8e659dc5fcf37..5b6a7c9d0d992 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -794,7 +794,8 @@ bool blk_update_request(struct request *req, blk_status_t error,
>  #endif
>  
>  	if (unlikely(error && !blk_rq_is_passthrough(req) &&
> -		     !(req->rq_flags & RQF_QUIET))) {
> +		     !(req->rq_flags & RQF_QUIET)) &&
> +		     !test_bit(GD_DEAD, &req->q->disk->state)) {
>  		blk_print_req_error(req, error);
>  		trace_block_rq_error(req, error, nr_bytes);
>  	}
> -- 
> 2.30.2
---end quoted text---
