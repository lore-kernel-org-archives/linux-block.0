Return-Path: <hch@lst.de>
Date: Sun, 28 Oct 2018 16:48:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, tom.leiming@gmail.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] block: fix the DISCARD request merge
Message-ID: <20181028154835.GA3061@lst.de>
References: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Oct 27, 2018 at 07:52:14PM +0800, Jianchao Wang wrote:
> +enum elv_merge blk_try_req_merge(struct request *req, struct request *next)
> +{
> +	if (blk_discard_mergable(req))
> +		return ELEVATOR_DISCARD_MERGE;
> +	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
> +		return ELEVATOR_BACK_MERGE;
> +
> +	return ELEVATOR_NO_MERGE;

The empty line here look a little odd, but if that is the only thing
I can nitpick about it must be great, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
