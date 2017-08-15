Return-Path: <ming.lei@redhat.com>
Date: Tue, 15 Aug 2017 10:46:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Max Gurtovoy <maxg@mellanox.com>,
	Ming Lei <minlei@redhat.com>
Subject: Re: [PATCH] blk-mq: Fix queue usage on failed request allocation
Message-ID: <20170815024618.GA6137@ming.t460p>
References: <1502743211-14992-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502743211-14992-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 14, 2017 at 04:40:11PM -0400, Keith Busch wrote:
> blk_mq_get_request() does not release the callers queue usage counter
> when allocation fails. The caller still needs to account for its own
> queue usage when it is unable to allocate a request.
> 
> Fixes: 1ad43c0078b7 ("blk-mq: don't leak preempt counter/q_usage_counter when allocating rq failed")
> 
> Reported-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
