Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V3] blk-mq: fix race between complete and
 BLK_EH_RESET_TIMER
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 Bart Van Assche <bart.vanassche@wdc.com>, Tejun Heo <tj@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 stable@vger.kernel.org
References: <20180412115956.16207-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4008f36d-c2c4-25b9-4af5-8efbe9d452c0@kernel.dk>
Date: Fri, 13 Apr 2018 21:06:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180412115956.16207-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/12/18 5:59 AM, Ming Lei wrote:
> The normal request completion can be done before or during handling
> BLK_EH_RESET_TIMER, and this race may cause the request to never be
> completed since driver's .timeout() may always return
> BLK_EH_RESET_TIMER.
> 
> This issue can't be fixed completely by driver, since the normal
> completion can be done between returning .timeout() and handling
> BLK_EH_RESET_TIMER.
> 
> This patch fixes the race by introducing rq state of
> MQ_RQ_COMPLETE_IN_RESET, and reading/writing rq's state by holding
> queue lock, which can be per-request actually, but just not necessary
> to introduce one lock for so unusual event.
> 
> Also when .timeout() returns BLK_EH_HANDLED, sync with normal
> completion path before completing this timed-out rq finally for
> avoiding this rq's state touched by normal completion.

I like this approach since it keeps the cost outside of the fast
path. And it's fine to reuse the queue lock for this, instead of
adding a special lock for something we consider a rare occurrence.

>From a quick look this looks sane, but I'll take a closer look
tomrrow and add some testing too.

-- 
Jens Axboe
