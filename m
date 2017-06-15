Return-Path: <BATV+bef0da5e94eb3b03931e+5044+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 15 Jun 2017 01:16:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 02/11] blk-mq: expose stream write stats through debugfs
Message-ID: <20170615081615.GB10599@infradead.org>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-3-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497498312-17704-3-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 14, 2017 at 09:45:03PM -0600, Jens Axboe wrote:
> Useful to verify that things are working the way they should.
> Reading the file will return number of kb written to each
> stream. Writing the file will reset the statistics. No care
> is taken to ensure that we don't race on updates.
> 
> Drivers will write to q->stream_writes[] if they handle a stream.

What's blk-mq specific about this?  Seems like this either should
be generic block or nvme specific, but probably not blk-mq.  And
of course the name should change with the rest of the names now.
