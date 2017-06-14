Return-Path: <BATV+a531e2bbbc8af89517f3+5043+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 14 Jun 2017 13:32:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
Message-ID: <20170614203221.GD7022@infradead.org>
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
 <1497467134-6323-12-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497467134-6323-12-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

> +static unsigned int nvme_get_write_stream(struct nvme_ns *ns,
> +					  struct request *req)
> +{
> +	unsigned int streamid = 0;
> +
> +	if (req_op(req) != REQ_OP_WRITE || !blk_stream_valid(req->cmd_flags) ||
> +	    !ns->nr_streams)
> +		return 0;

Might make more sense to do this check in the caller?

> +
> +	if (req->cmd_flags & REQ_WRITE_SHORT)
> +		streamid = 1;
> +	else if (req->cmd_flags & REQ_WRITE_MEDIUM)
> +		streamid = 2;
> +	else if (req->cmd_flags & REQ_WRITE_LONG)
> +		streamid = 3;
> +	else if (req->cmd_flags & REQ_WRITE_EXTREME)
> +		streamid = 4;
> +
> +	if (streamid < BLK_MAX_STREAM)

Can happen per the index above.

> +		req->q->stream_writes[streamid] += blk_rq_bytes(req) >> 9;
> +
> +	return (streamid % (ns->nr_streams + 1));

Should we do smarted collapsing?  e.g. short + medium and long + extreme
for two?  What for three?  Does one extra stream make sense in this
scheme?

> +	dev_info(ctrl->device, "streams: msl=%u, nssa=%u, nsso=%u, sws=%u "
> +				"sgs=%u, nsa=%u, nso=%u\n", s.msl, s.nssa,
> +				s.nsso, s.sws, s.sgs, s.nsa, s.nso);

Way to chatty.

> +	if (ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES)
> +		dev_info(ctrl->dev, "supports directives\n");

Same.  Use nvme-cli for that sort of info.

>  	ctrl->npss = id->npss;
>  	prev_apsta = ctrl->apsta;
>  	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
> @@ -2060,6 +2201,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  		goto out_free_id;
>  	}
>  
> +	if (ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES)
> +		nvme_config_streams(ns);

This sets aside four streams on any device that supports them, and
will probably kill performance on them unless you have a workload
that actually uses those streams.  I think they need to be allocated
lazily.
