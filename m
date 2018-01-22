Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42606 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeAVQdi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jan 2018 11:33:38 -0500
Subject: Re: [PATCH TRIVIAL] bsg: use pr_debug instead of hand crafted macros
To: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20180122075348.6974-1-jthumshirn@suse.de>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <8ecbf7d2-b056-cd93-ebf3-b4eaf22f7abe@wdc.com>
Date: Mon, 22 Jan 2018 08:33:37 -0800
MIME-Version: 1.0
In-Reply-To: <20180122075348.6974-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/21/18 23:53, Johannes Thumshirn wrote:
> -	dprintk("map hdr %llx/%u %llx/%u\n", (unsigned long long) hdr->dout_xferp,
> +	pr_debug("map hdr %llx/%u %llx/%u\n",
> +		 (unsigned long long) hdr->dout_xferp,
>   		hdr->dout_xfer_len, (unsigned long long) hdr->din_xferp,
>   		hdr->din_xfer_len);

Should the indentation of the arguments have been adjusted?

> @@ -299,7 +292,7 @@ static void bsg_rq_end_io(struct request *rq, blk_status_t status)
>   	struct bsg_device *bd = bc->bd;
>   	unsigned long flags;
>   
> -	dprintk("%s: finished rq %p bc %p, bio %p\n",
> +	pr_debug("%s: finished rq %p bc %p, bio %p\n",
>   		bd->name, rq, bc, bc->bio);

Same question here ...

Thanks,

Bart.
