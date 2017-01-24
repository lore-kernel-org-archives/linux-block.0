Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750833AbdAXNWG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:22:06 -0500
Subject: Re: [PATCH 16/16] block: don't assign cmd_flags in
 __blk_rq_prep_clone
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1485185361-29786-1-git-send-email-hch@lst.de>
 <1485185361-29786-17-git-send-email-hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c3a9c8cf-ab8f-bf56-0a42-ffeada70242d@suse.de>
Date: Tue, 24 Jan 2017 14:22:03 +0100
MIME-Version: 1.0
In-Reply-To: <1485185361-29786-17-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 04:29 PM, Christoph Hellwig wrote:
> These days we have the proper flags set since request allocation time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fe5cc98..93a9e0b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2983,7 +2983,6 @@ EXPORT_SYMBOL_GPL(blk_rq_unprep_clone);
>  static void __blk_rq_prep_clone(struct request *dst, struct request *src)
>  {
>  	dst->cpu = src->cpu;
> -	dst->cmd_flags = src->cmd_flags | REQ_NOMERGE;
>  	dst->cmd_type = src->cmd_type;
>  	dst->__sector = blk_rq_pos(src);
>  	dst->__data_len = blk_rq_bytes(src);
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
