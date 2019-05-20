Return-Path: <SRS0=zuir=TU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEA0C04AAC
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 14:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE50820657
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 14:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbfETO1G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 10:27:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387745AbfETO1G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 10:27:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F29F7AF0F;
        Mon, 20 May 2019 14:27:04 +0000 (UTC)
Subject: Re: [PATCH] block: improve print_req_error
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20190520141359.30027-1-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ca7034ed-eeaf-bc0f-4c19-3b52f2051d1d@suse.de>
Date:   Mon, 20 May 2019 16:27:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520141359.30027-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/19 4:13 PM, Christoph Hellwig wrote:
> Print the calling function instead of print_req_error as a prefix, and
> print the operation and op_flags separately instrad of the whole field.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 419d600e6637..b1f7e244340e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -167,18 +167,20 @@ int blk_status_to_errno(blk_status_t status)
>   }
>   EXPORT_SYMBOL_GPL(blk_status_to_errno);
>   
> -static void print_req_error(struct request *req, blk_status_t status)
> +static void print_req_error(struct request *req, blk_status_t status,
> +		const char *caller)
>   {
>   	int idx = (__force int)status;
>   
>   	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
>   		return;
>   
> -	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %x\n",
> -				__func__, blk_errors[idx].name,
> -				req->rq_disk ?  req->rq_disk->disk_name : "?",
> -				(unsigned long long)blk_rq_pos(req),
> -				req->cmd_flags);
> +	printk_ratelimited(KERN_ERR
> +		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",
> +		caller, blk_errors[idx].name,
> +		req->rq_disk ?  req->rq_disk->disk_name : "?",
> +		blk_rq_pos(req), req_op(req),
> +		req->cmd_flags & ~REQ_OP_MASK);
>   }
>   
>   static void req_bio_endio(struct request *rq, struct bio *bio,
> @@ -1418,7 +1420,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
>   
>   	if (unlikely(error && !blk_rq_is_passthrough(req) &&
>   		     !(req->rq_flags & RQF_QUIET)))
> -		print_req_error(req, error);
> +		print_req_error(req, error, __func__);
>   
>   	blk_account_io_completion(req, nr_bytes);
>   
> 
Weell ... where's the point of the __func__ argument if there is only 
one place where it's called from?

Can't we just drop it completely?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
