Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD912C04E53
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 08:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE7A2089E
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 08:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfEOIUK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 May 2019 04:20:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfEOIUJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 04:20:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A5583001C60;
        Wed, 15 May 2019 08:20:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0932C5D6A6;
        Wed, 15 May 2019 08:19:59 +0000 (UTC)
Date:   Wed, 15 May 2019 16:19:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 02/10] block: force an unlimited segment size on queues
 with a virt boundary
Message-ID: <20190515081954.GB23052@ming.t460p>
References: <20190513063754.1520-1-hch@lst.de>
 <20190513063754.1520-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513063754.1520-3-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 15 May 2019 08:20:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 13, 2019 at 08:37:46AM +0200, Christoph Hellwig wrote:
> We currently fail to update the front/back segment size in the bio when
> deciding to allow an otherwise gappy segement to a device with a
> virt boundary.  The reason why this did not cause problems is that
> devices with a virt boundary fundamentally don't use segments as we
> know it and thus don't care.  Make that assumption formal by forcing
> an unlimited segement size in this case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 3facc41476be..2ae348c101a0 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -310,6 +310,9 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
>  		       __func__, max_size);
>  	}
>  
> +	/* see blk_queue_virt_boundary() for the explanation */
> +	WARN_ON_ONCE(q->limits.virt_boundary_mask);
> +
>  	q->limits.max_segment_size = max_size;
>  }
>  EXPORT_SYMBOL(blk_queue_max_segment_size);
> @@ -742,6 +745,14 @@ EXPORT_SYMBOL(blk_queue_segment_boundary);
>  void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
>  {
>  	q->limits.virt_boundary_mask = mask;
> +
> +	/*
> +	 * Devices that require a virtual boundary do not support scatter/gather
> +	 * I/O natively, but instead require a descriptor list entry for each
> +	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
> +	 * of that they are not limited by our notion of "segment size".
> +	 */
> +	q->limits.max_segment_size = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_queue_virt_boundary);

All drivers which set virt boundary do not set max segment size, and
guess the DMA controller may partition data in unit of (virt_boundary +
1), so in theory this patch is correct.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming
