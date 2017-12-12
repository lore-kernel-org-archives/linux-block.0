Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 12 Dec 2017 13:40:05 -0800
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, oleg@redhat.com, peterz@infradead.org,
	kernel-team@fb.com, osandov@fb.com, linux-block@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCHSET v2] blk-mq: reimplement timeout handling
Message-ID: <20171212213317.GK3919388@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <b00aeb8b-5a5d-f37a-b593-408f22a1de67@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b00aeb8b-5a5d-f37a-b593-408f22a1de67@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Hello, Jens.

On Tue, Dec 12, 2017 at 01:23:01PM -0700, Jens Axboe wrote:
> I like this a lot, it's a lot less fragile and more intuitive/readable
> than what we have now. And apparently less error prone... I'll do
> some testing with this.

Great.

> BTW, since youadd a few more BLK_MQ_F_BLOCKING checks, I think something
> like the below would be a good cleanup on top of this.
> 
> From: Jens Axboe <axboe@kernel.dk>
> Subject: [PATCH] blk-mq: move hctx lock/unlock into a helper
> 
> Move the RCU vs SRCU logic into lock/unlock helpers, which makes
> the actual functional bits within the locked region much easier
> to read.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Yeah, that's a lot better.  It might also be a good idea to add
lockdep_assert_hctx_locked() for verification and documentation.

Thanks.

-- 
tejun
