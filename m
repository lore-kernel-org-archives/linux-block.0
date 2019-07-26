Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AD5C7618B
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 07:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79F0229F9
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 07:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfGZHfW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:35:22 -0400
Received: from verein.lst.de ([213.95.11.211]:42235 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGZHfV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 03:35:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46A7E68B02; Fri, 26 Jul 2019 09:35:18 +0200 (CEST)
Date:   Fri, 26 Jul 2019 09:35:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux@roeck-us.net, James.Bottomley@HansenPartnership.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix max segment size handling in
 blk_queue_virt_boundary
Message-ID: <20190726073518.GA23993@lst.de>
References: <20190724162656.3967-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724162656.3967-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, can you take a look?  This fixes a boot regression hitting
various people.

On Wed, Jul 24, 2019 at 06:26:56PM +0200, Christoph Hellwig wrote:
> We should only set the max segment size to unlimited if we actually
> have a virt boundary.  Otherwise we accidentally clear that limit
> when called from the SCSI midlayer, which always calls
> blk_queue_virt_boundary, even if that mask is 0.
> 
> Fixes: 7ad388d8e4c7 ("scsi: core: add a host / host template field for the virt boundary")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 2ae348c101a0..2c1831207a8f 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -752,7 +752,8 @@ void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
>  	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
>  	 * of that they are not limited by our notion of "segment size".
>  	 */
> -	q->limits.max_segment_size = UINT_MAX;
> +	if (mask)
> +		q->limits.max_segment_size = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_queue_virt_boundary);
>  
> -- 
> 2.20.1
---end quoted text---
