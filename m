Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933370AbcJFTqD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 15:46:03 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Adam Manzanares <adam.manzanares@hgst.com>
Cc: <axboe@kernel.dk>, <tj@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] block: Add iocontext priority to request
References: <1475694007-11999-1-git-send-email-adam.manzanares@hgst.com>
        <1475694007-11999-3-git-send-email-adam.manzanares@hgst.com>
Date: Thu, 06 Oct 2016 15:46:00 -0400
In-Reply-To: <1475694007-11999-3-git-send-email-adam.manzanares@hgst.com>
        (Adam Manzanares's message of "Wed, 5 Oct 2016 12:00:07 -0700")
Message-ID: <x49d1jdi7lz.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi, Adam,

Adam Manzanares <adam.manzanares@hgst.com> writes:

> Patch adds an association between iocontext ioprio and the ioprio of
> a request. This feature is only enabled if a queue flag is set to
> indicate that requests should have ioprio associated with them. The
> queue flag is exposed as the req_prio queue sysfs entry.
>
> Signed-off-by: Adam Mananzanares <adam.manzanares@hgst.com>

I like the idea of the patch, but I have a few comments.

First, don't add a tunable, there's no need for it.  (And in the future,
if you do add tunables, document them.)  That should make your patch
much smaller.

> @@ -1648,6 +1649,7 @@ out:
>  
>  void init_request_from_bio(struct request *req, struct bio *bio)
>  {
> +	struct io_context *ioc = rq_ioc(bio);

That can return NULL, and you blindly dereference it later.

> @@ -1656,7 +1658,11 @@ void init_request_from_bio(struct request *req, struct bio *bio)
>  
>  	req->errors = 0;
>  	req->__sector = bio->bi_iter.bi_sector;
> -	req->ioprio = bio_prio(bio);
> +	if (blk_queue_req_prio(req->q))
> +		req->ioprio = ioprio_best(bio_prio(bio), ioc->ioprio);
> +	else
> +		req->ioprio = bio_prio(bio);
> +

If the bio actually has an ioprio (only happens for bcache at this
point), you should use it.  Something like this:

        req->ioprio = bio_prio(bio);
        if (!req->ioprio && ioc)
		req->ioprio = ioc->ioprio;

Finally, please re-order your series as Hannes suggested.

Thanks!
Jeff
