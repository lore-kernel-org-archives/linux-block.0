Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34157 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdK1JHG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Nov 2017 04:07:06 -0500
Received: by mail-wm0-f52.google.com with SMTP id y82so31009486wmg.1
        for <linux-block@vger.kernel.org>; Tue, 28 Nov 2017 01:07:06 -0800 (PST)
Subject: Re: [PATCH 1/2] block: fail op_is_write() requests to read-only
 partitions
To: Ilya Dryomov <idryomov@gmail.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        Tejun Heo <tj@kernel.org>, David Disseldorp <ddiss@suse.de>
References: <1510253101-10291-1-git-send-email-idryomov@gmail.com>
 <1510253101-10291-2-git-send-email-idryomov@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <867a243b-61fa-c2bc-779f-0dcd3062a1b5@grimberg.me>
Date: Tue, 28 Nov 2017 11:07:02 +0200
MIME-Version: 1.0
In-Reply-To: <1510253101-10291-2-git-send-email-idryomov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> +	if (bio_check_ro(bio)) {

I'd place unlikely statement here, but other than that, looks good to me

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

> +		printk(KERN_ERR
> +		       "generic_make_request: Trying to write "
> +			"to read-only block-device %s (partno %d)\n",
> +			bio_devname(bio, b), bio->bi_partno);
> +		goto end_io;
> +	}
> +
>   	/*
>   	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
>   	 * if queue is not a request based queue.
>   	 */
> -
>   	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_rq_based(q))
>   		goto not_supported;
>   
> 
