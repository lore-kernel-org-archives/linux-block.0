Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 12:06:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/8] blk-mq: remove blk_mq_delay_queue()
Message-ID: <20180409100639.GE11144@lst.de>
References: <20180408094814.28953-1-ming.lei@redhat.com> <20180408094814.28953-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180408094814.28953-6-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 08, 2018 at 05:48:11PM +0800, Ming Lei wrote:
> No driver uses this interface any more, so remove it.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
