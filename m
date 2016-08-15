Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57994 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006AbcHOSNb (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 15 Aug 2016 14:13:31 -0400
Date: Mon, 15 Aug 2016 20:13:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix secure erase
Message-ID: <20160815181328.GA9696@lst.de>
References: <20160811140533.GA16543@lst.de> <1471270071-28921-1-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471270071-28921-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -366,7 +366,10 @@ void elv_dispatch_sort(struct request_queue *q, struct request *rq)
>  	list_for_each_prev(entry, &q->queue_head) {
>  		struct request *pos = list_entry_rq(entry);
>  
> -		if ((req_op(rq) == REQ_OP_DISCARD) != (req_op(pos) == REQ_OP_DISCARD))
> +		if ((req_op(rq) == REQ_OP_DISCARD ||
> +		     req_op(rq) == REQ_OP_SECURE_ERASE) !=
> +		    (req_op(pos) == REQ_OP_DISCARD ||
> +		     req_op(pos) == REQ_OP_SECURE_ERASE))
>  			break;

This really should be a:

	if (req_op(rq) != req_op(pos))

I'l lleave it up to Jens if he wants that in this patch or not, otherwise
I'll send an incremental patch.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
