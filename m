Return-Path: <hch@lst.de>
Date: Fri, 29 Jun 2018 10:32:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block: Document how blk_update_request() handles
	RQF_SPECIAL_PAYLOAD requests
Message-ID: <20180629083230.GA15870@lst.de>
References: <20180627200905.15226-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180627200905.15226-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 27, 2018 at 01:09:05PM -0700, Bart Van Assche wrote:
> The payload of struct request is stored in the request.bio chain if
> the RQF_SPECIAL_PAYLOAD flag is not set and in request.special_vec if
> RQF_SPECIAL_PAYLOAD has been set. However, blk_update_request()
> iterates over req->bio whether or not RQF_SPECIAL_PAYLOAD has been
> set. Additionally, the RQF_SPECIAL_PAYLOAD flag is ignored by
> blk_rq_bytes() which means that the value returned by that function
> is incorrect if the RQF_SPECIAL_PAYLOAD flag has been set. It is not
> clear to me whether this is an oversight or whether this happened on
> purpose. Anyway, document that it is known that both functions ignore
> RQF_SPECIAL_PAYLOAD. See also commit f9d03f96b988 ("block: improve
> handling of the magic discard payload").
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
