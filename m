Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v5] blk-mq: reimplement timeout handling
To: Tejun Heo <tj@kernel.org>, jack@suse.cz, clm@fb.com, jbacik@fb.com
Cc: kernel-team@fb.com, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, peterz@infradead.org,
 jianchao.w.wang@oracle.com, Bart.VanAssche@wdc.com,
 linux-block@vger.kernel.org
References: <20180109162953.1211451-1-tj@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <275130f6-b970-f746-14e0-1b064304822b@kernel.dk>
Date: Tue, 9 Jan 2018 09:53:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180109162953.1211451-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 9:29 AM, Tejun Heo wrote:
> Hello,
> 
> Changes from [v4]
> 
> - Comments added.  Patch description updated.
> 
> Changes from [v3]
> 
> - Rebased on top of for-4.16/block.
> 
> - Integrated Jens's hctx_[un]lock() factoring patch and refreshed the
>   patches accordingly.
> 
> - Added comment explaining the use of hctx_lock() instead of
>   rcu_read_lock() in completion path.
> 
> Changes from [v2]
> 
> - Possible extended looping around seqcount and u64_stat_sync fixed.
> 
> - Misplaced MQ_RQ_IDLE state setting fixed.
> 
> - RQF_MQ_TIMEOUT_EXPIRED added to prevent firing the same timeout
>   multiple times.
> 
> - s/queue_rq_src/srcu/ patch added.
> 
> - Other misc changes.
> 
> Changes from [v1]
> 
> - BLK_EH_RESET_TIMER handling fixed.
> 
> - s/request->gstate_seqc/request->gstate_seq/
> 
> - READ_ONCE() added to blk_mq_rq_udpate_state().
> 
> - Removed left over blk_clear_rq_complete() invocation from
>   blk_mq_rq_timed_out().
> 
> Currently, blk-mq timeout path synchronizes against the usual
> issue/completion path using a complex scheme involving atomic
> bitflags, REQ_ATOM_*, memory barriers and subtle memory coherence
> rules.  Unfortunatley, it contains quite a few holes.
> 
> It's pretty easy to make blk_mq_check_expired() terminate a later
> instance of a request.  If we induce 5 sec delay before
> time_after_eq() test in blk_mq_check_expired(), shorten the timeout to
> 2s, and issue back-to-back large IOs, blk-mq starts timing out
> requests spuriously pretty quickly.  Nothing actually timed out.  It
> just made the call on a recycle instance of a request and then
> terminated a later instance long after the original instance finished.
> The scenario isn't theoretical either.
> 
> This patchset replaces the broken synchronization mechanism with a RCU
> and generation number based one.  Please read the patch description of
> the second path for more details.

Applied for 4.16, and added a patch to silence that false positive
srcu_idx for hctx_unlock() that got reported.

This grows the request a bit, which sucks, but probably unavoidable.
There's some room for improvement with a hole or two, however.

-- 
Jens Axboe
