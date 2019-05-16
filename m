Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C893FC04AB4
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CB2205C9
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEPItS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 04:49:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfEPItS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:49:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE834AEE6;
        Thu, 16 May 2019 08:49:16 +0000 (UTC)
Subject: Re: [PATCH 2/4] block: force an unlimited segment size on queues with
 a virt boundary
To:     Christoph Hellwig <hch@lst.de>, axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
References: <20190516084058.20678-1-hch@lst.de>
 <20190516084058.20678-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9184941a-d2ba-6a92-4253-9716a265f6aa@suse.de>
Date:   Thu, 16 May 2019 10:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516084058.20678-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/19 10:40 AM, Christoph Hellwig wrote:
> We currently fail to update the front/back segment size in the bio when
> deciding to allow an otherwise gappy segement to a device with a
> virt boundary.  The reason why this did not cause problems is that
> devices with a virt boundary fundamentally don't use segments as we
> know it and thus don't care.  Make that assumption formal by forcing
> an unlimited segement size in this case.
> 
> Fixes: f6970f83ef79 ("block: don't check if adjacent bvecs in one bio can be mergeable")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-settings.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 3facc41476be..2ae348c101a0 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -310,6 +310,9 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
>   		       __func__, max_size);
>   	}
>   
> +	/* see blk_queue_virt_boundary() for the explanation */
> +	WARN_ON_ONCE(q->limits.virt_boundary_mask);
> +
>   	q->limits.max_segment_size = max_size;
>   }
>   EXPORT_SYMBOL(blk_queue_max_segment_size);
> @@ -742,6 +745,14 @@ EXPORT_SYMBOL(blk_queue_segment_boundary);
>   void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
>   {
>   	q->limits.virt_boundary_mask = mask;
> +
> +	/*
> +	 * Devices that require a virtual boundary do not support scatter/gather
> +	 * I/O natively, but instead require a descriptor list entry for each
> +	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
> +	 * of that they are not limited by our notion of "segment size".
> +	 */
> +	q->limits.max_segment_size = UINT_MAX;
>   }
>   EXPORT_SYMBOL(blk_queue_virt_boundary);
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
