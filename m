Return-Path: <hch@lst.de>
Date: Fri, 11 May 2018 14:35:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180511123519.GA14123@lst.de>
References: <20180510175607.27937-1-bart.vanassche@wdc.com> <73f77c62-25ca-0915-6f5b-452d60258f05@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <73f77c62-25ca-0915-6f5b-452d60258f05@oracle.com>
List-ID: <linux-block@vger.kernel.org>

> It should be due to union blk_deadline_and_state. 
> +union blk_deadline_and_state {
> +	struct {
> +		uint32_t generation:30;
> +		uint32_t state:2;
> +		uint32_t deadline;
> +	};
> +	unsigned long legacy_deadline;
> +	uint64_t das;
> +};

Yikes.  Or we just move it into a separate field.  This patch already
shrinks struct request a lot, so I'd rather do that to keep it simple.
