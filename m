Return-Path: <hch@lst.de>
Date: Fri, 26 May 2017 08:01:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH 01/19] block: Avoid that blk_exit_rl() triggers a
	use-after-free
Message-ID: <20170526060139.GA18424@lst.de>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com> <20170525184327.23570-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525184327.23570-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
