Return-Path: <hch@lst.de>
Date: Tue, 10 Apr 2018 16:50:16 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"maxg@mellanox.com" <maxg@mellanox.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
	handling
Message-ID: <20180410145016.GA25019@lst.de>
References: <20180410013455.7448-1-bart.vanassche@wdc.com> <20180410095537.GA19266@lst.de> <f4bb15dff9dca995a9965204124caf2742798801.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f4bb15dff9dca995a9965204124caf2742798801.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 10, 2018 at 01:26:39PM +0000, Bart Van Assche wrote:
> Can you explain why you think that using cmpxchg() is safe in this context?
> The regular completion path and the timeout code can both execute e.g. the
> following code concurrently:
> 
> 	blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE);
> 
> That's why I think that we need an atomic compare and exchange instead of
> cmpxchg(). What I found in the Intel Software Developer Manual seems to
> confirm that:

The Linux cmpxchg() helper is supposed to always be atomic, you only
need atomic_cmpxchg and friends if you want to operate on an atomic_t.
(same for the _long variant).

In fact if you look at the x86 implementation of the cmpxchg() macro
you'll see that it will use the lock prefix if the kernel has been
built with CONFIG_SMP enabled.
