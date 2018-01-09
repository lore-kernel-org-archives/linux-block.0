Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/8] blk-mq: protect completion path with RCU
To: "tj@kernel.org" <tj@kernel.org>, Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jbacik@fb.com" <jbacik@fb.com>, "jack@suse.cz" <jack@suse.cz>,
 "clm@fb.com" <clm@fb.com>, "kernel-team@fb.com" <kernel-team@fb.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
References: <20180108191542.379478-1-tj@kernel.org>
 <20180108191542.379478-3-tj@kernel.org> <1515514359.2721.9.camel@wdc.com>
 <20180109161914.GM3668920@devbig577.frc2.facebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e385f94b-e60c-e1c5-1a8b-7661bae527ee@kernel.dk>
Date: Tue, 9 Jan 2018 09:22:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180109161914.GM3668920@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 9:19 AM, tj@kernel.org wrote:
> Hello, Bart.
> 
> On Tue, Jan 09, 2018 at 04:12:40PM +0000, Bart Van Assche wrote:
>> I'm concerned about the additional CPU cycles needed for the new blk_mq_map_queue()
>> call, although I know this call is cheap. Would the timeout code really get that
> 
> So, if that is really a concern, let's cache that mapping instead of
> changing synchronization rules for that.
> 
>> much more complicated if the hctx_lock() and hctx_unlock() calls would be changed
>> into rcu_read_lock() and rcu_read_unlock() calls? Would it be sufficient if
>> "if (has_rcu) synchronize_rcu();" would be changed into "synchronize_rcu();" in
>> blk_mq_timeout_work()?
> 
> Code-wise, it won't be too much extra code but I think diverging the
> sync methods between issue and completion paths is more fragile and
> likely to invite confusions and mistakes in the future.  We have the
> normal path (issue&completion) synchronizing against the exception
> path (timeout).  I think it's best to keep the sync constructs aligned
> with that conceptual picture.

Guys, the map call is FINE. We do it at least once per request anyway,
usually multiple times. If it's too expensive, then THAT is what needs
fixing, not adding an arbitrary caching of that mapping. Look at the
actual code:

	return q->queue_hw_ctx[q->mq_map[cpu]];

that's it. It's just a double index.

So let's put this thing to rest right now - the map call is perfectly
fine, especially since the alternatives are either bloating struct
request or making the code less maintainable.

Foot -> down.

-- 
Jens Axboe
