Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 10 Apr 2018 07:20:28 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Message-ID: <20180410142028.GM3126663@devbig577.frc2.facebook.com>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410013455.7448-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Mon, Apr 09, 2018 at 06:34:55PM -0700, Bart Van Assche wrote:
> Since the request state can be updated from two different contexts,
> namely regular completion and request timeout, this race cannot be
> fixed with RCU synchronization only. Fix this race as follows:

Well, it can be and the patches have been posted months ago.  It just
needed a repro case to confirm the fix, which we now seem to have.

Switching to another model might be better but let's please do that
with the right rationales.  A good portion of this seems to be built
on misunderstandings.

Thanks.

-- 
tejun
