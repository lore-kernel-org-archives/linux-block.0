Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: don't time out requests again that are in the
 timeout handler
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180614115845.27094-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d3176eee-2025-f401-63e6-d3b68d9108a9@kernel.dk>
Date: Thu, 14 Jun 2018 08:42:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180614115845.27094-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/14/18 5:58 AM, Christoph Hellwig wrote:
> We can currently call the timeout handler again on a request that has
> already been handed over to the timeout handler.  Prevent that with a new
> flag.

Applied, thanks.

-- 
Jens Axboe
