Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHv2] blk-mq: Allow blocking queue tag iter callbacks
To: Keith Busch <keith.busch@intel.com>,
 Linux Block <linux-block@vger.kernel.org>
Cc: Bart Van Assche <bart.vanassche@gmail.com>,
 Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20180925163620.11911-1-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <90b9466d-24d5-26ba-7631-c589effa51ac@kernel.dk>
Date: Tue, 25 Sep 2018 20:18:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180925163620.11911-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/25/18 10:36 AM, Keith Busch wrote:
> A recent commit runs tag iterator callbacks under the rcu read lock,
> but existing callbacks do not satisfy the non-blocking requirement.
> The commit intended to prevent an iterator from accessing a queue that's
> being modified. This patch fixes the original issue by taking a queue
> reference instead of reading it, which allows callbacks to make blocking
> calls.

Thanks Keith, queued up for 4.19.

-- 
Jens Axboe
