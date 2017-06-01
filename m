Return-Path: <hch@lst.de>
Date: Thu, 1 Jun 2017 08:09:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 05/12] blk-mq: Initialize a request before assigning
	a tag
Message-ID: <20170601060919.GG16248@lst.de>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com> <20170531225246.26261-6-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531225246.26261-6-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, blk_mq_rq_ctx_init should be marked static, but I'll send a separate
patch for that.
