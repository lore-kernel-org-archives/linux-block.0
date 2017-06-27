Return-Path: <hch@lst.de>
Date: Tue, 27 Jun 2017 17:17:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
	martin.petersen@oracle.com
Subject: Re: [PATCH 3/9] blk-mq: expose write hints through debugfs
Message-ID: <20170627151725.GA28403@lst.de>
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk> <1498491480-16306-4-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498491480-16306-4-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 26, 2017 at 09:37:54AM -0600, Jens Axboe wrote:
> Useful to verify that things are working the way they should.
> Reading the file will return number of kb written with each
> write hint. Writing the file will reset the statistics. No care
> is taken to ensure that we don't race on updates.
> 
> Drivers will write to q->write_hints[] if they handle a given
> write hint.

How about moving the accounting itself to blk-mq as well?  Just noticed
that it's completely generic while looking over the nvme patch.
