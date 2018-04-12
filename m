Return-Path: <hch@lst.de>
Date: Thu, 12 Apr 2018 15:23:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5] blk-mq: Avoid that a completion can be ignored for
	BLK_EH_RESET_TIMER
Message-ID: <20180412132329.GC5476@lst.de>
References: <20180410210157.30477-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410210157.30477-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

In addition to all the arguments in the changelog the diffstat is
a pretty clear indicator that a straight forward state machine is
exactly what we want.
