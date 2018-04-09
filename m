Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH] blk-mq: Fix recently introduced races in the timeout
 handling code
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Israel Rukshin <israelr@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
References: <20180409052038.5391-1-bart.vanassche@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3f0d4950-4ef1-a24f-0ad1-b274aa885f73@grimberg.me>
Date: Mon, 9 Apr 2018 11:37:15 +0300
MIME-Version: 1.0
In-Reply-To: <20180409052038.5391-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> If a completion occurs after blk_mq_rq_timed_out() has reset
> rq->aborted_gstate and the request is again in flight when the timeout
> expires then a request will be completed twice: a first time by the
> timeout handler and a second time when the regular completion occurs.
> 
> Additionally, the blk-mq timeout handling code ignores completions that
> occur after blk_mq_check_expired() has been called and before
> blk_mq_rq_timed_out() has reset rq->aborted_gstate. If a block driver
> timeout handler always returns BLK_EH_RESET_TIMER then the result will
> be that the request never terminates.

OK, now I understand how we can complete twice. Israel, can you verify
this patch solves your double completion problem?

Given that it is, the change log of your patches should be modified to
the original bug report it solves.

Thread starts here:
http://lists.infradead.org/pipermail/linux-nvme/2018-February/015848.html
