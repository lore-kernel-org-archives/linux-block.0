Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f170.google.com ([209.85.215.170]:40300 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388855AbeKGASx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Nov 2018 19:18:53 -0500
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
References: <20181105102301.9752-1-jthumshirn@suse.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <a97f3d77-d23b-b418-abce-2d93ed725bdb@acm.org>
Date: Tue, 6 Nov 2018 06:53:16 -0800
MIME-Version: 1.0
In-Reply-To: <20181105102301.9752-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/5/18 2:23 AM, Johannes Thumshirn wrote:
> @@ -169,7 +169,7 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
>   static inline bool __bvec_gap_to_prev(struct request_queue *q,
>   		struct bio_vec *bprv, unsigned int offset)
>   {
> -	return offset ||
> +	return (offset & queue_virt_boundary(q)) ||
>   		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
>   }

How about changing that expression into the following to make it easier 
for the compiler to optimize this code?

(offset | (bprv->bv_offset + bprv->bv_len)) & queue_virt_boundary(q)

Thanks,

Bart.
