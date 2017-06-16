Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdFPSJo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 14:09:44 -0400
Date: Fri, 16 Jun 2017 11:09:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
Message-ID: <20170616180942.GD27996@infradead.org>
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
 <1497633883-21230-12-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497633883-21230-12-git-send-email-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> We default to allocating 4 streams per name space, but it is
> configurable with the 'streams_per_ns' module option.

What's your strategy for multi-namespace devices?  You won't even get
your 4 streams for a handful namespaces with devices today or the near
future.  Should we cut down the number of streams per namespace?  Or
just not set aside streams for namespace exclusive use?  Or so far
you simply don't care about the multi-ns case?

> +static void nvme_write_hint_work(struct work_struct *work)
> +{
	struct nvme_ns *ns = container_of(work, struct nvme_ns, write_hint_work);

nasty 81 character line :)

> +	nr_streams = streams_per_ns;
> +	if (nr_streams > ns->ctrl->nssa)
> +		nr_streams = ns->ctrl->nssa;

min() ?

> +static enum rw_hint nvme_get_write_stream(struct nvme_ns *ns,
> +					   struct request *req)
> +{
> +	enum rw_hint streamid = req->cmd_flags & REQ_WRITE_LIFE_MASK;
> +
> +	if (req_op(req) != REQ_OP_WRITE ||
> +	    !(ns->ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES))
> +		return WRITE_LIFE_NONE;

How about moving this to the caller?

> +	/*
> +	 * If we support streams and this request is a write with a valid
> +	 * hint, then flag it as such. If we haven't allocated streams on
> +	 * this ns before, do so lazily.
> +	 */
> +	stream = nvme_get_write_stream(ns, req);
> +	if (stream != WRITE_LIFE_NONE) {
> +		if (ns->nr_streams) {
> +			control |= NVME_RW_DTYPE_STREAMS;
> +			dsmgmt |= (stream << 16);
> +		} else
> +			nvme_configure_streams(ns);
> +	}

.. and instead pass control and dsmgmt to nvme_get_write_stream by
reference to isolate the functionality there.  And move the
nvme_configure_streams call into it as well.


Last but not least this will need some tweaks in the deallocate
code due to:

"If the host issues a Dataset Management command to deallocate logical
 blocks that are associated with a stream, it should specify a starting
 LBA and length that is aligned to and in multiples of the Stream
 Granularity Size"
