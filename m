Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45393 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbcFIWnS (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 18:43:18 -0400
Subject: Re: [PATCH 1/2] block: better packing for struct request
To: Christoph Hellwig <hch@lst.de>, axboe@fb.com
References: <1465480836-32093-1-git-send-email-hch@lst.de>
 <1465480836-32093-2-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Mike Christie <mchristi@redhat.com>
Message-ID: <5759F104.8090505@redhat.com>
Date: Thu, 9 Jun 2016 17:43:16 -0500
MIME-Version: 1.0
In-Reply-To: <1465480836-32093-2-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/09/2016 09:00 AM, Christoph Hellwig wrote:
> Keep the 32-bit CPU and cmd_type flags together to avoid holes on 64-bit
> architectures.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blkdev.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 0c9f879..9746d22 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -96,12 +96,11 @@ struct request {
>  	struct request_queue *q;
>  	struct blk_mq_ctx *mq_ctx;
>  
> -	u64 cmd_flags;
> +	int cpu;
>  	unsigned cmd_type;
> +	u64 cmd_flags;
>  	unsigned long atomic_flags;
>  
> -	int cpu;
> -
>  	/* the following two fields are internal, NEVER access directly */
>  	unsigned int __data_len;	/* total data len */
>  	sector_t __sector;		/* sector cursor */
> 

Looks ok to me.

Reviewed-by: Mike Christie <mchristi@redhat.com>
