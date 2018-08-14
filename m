Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: fix IO hang in wbt_wait()
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Josef Bacik <jbacik@fb.com>
References: <20180814155749.28912-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dbbb7e90-1f23-9800-2028-837ad927f57c@kernel.dk>
Date: Tue, 14 Aug 2018 11:05:42 -0600
MIME-Version: 1.0
In-Reply-To: <20180814155749.28912-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/14/18 9:57 AM, Ming Lei wrote:
> On wbt invariant is that if one IO is tracked via WBT_TRACKED, rqw->inflight
> should be updated for tracking this IO.
> 
> But commit c1c80384c8f ("block: remove external dependency on wbt_flags")
> forgets to remove the early handling of !rwb_enabled(rwb) inside wbt_wait(),
> then the inflight counter may not be increased in wbt_wait(), but decreased
> in wbt_done() for this kind of IO, so this counter may become negative, then
> wbt_wait() may wait forever.
> 
> This patch fixes the report in the following link:
> 
> 	https://marc.info/?l=linux-block&m=153221542021033&w=2

Looks good to me, thanks for fixing this. Applied.

-- 
Jens Axboe
