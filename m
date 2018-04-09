Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 11:37:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Fix recently introduced races in the timeout
	handling code
Message-ID: <20180409093744.GC10405@lst.de>
References: <20180409052038.5391-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409052038.5391-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This looks sensible, but I'm worried about taking a whole spinlock
for every request completion, including irq disabling.  However it seems
like your new updated pattern would fit use of cmpxchg() very nicely.
