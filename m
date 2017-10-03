Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-throttle: fix possible io stall when upgrade to
 max
To: Joseph Qi <jiangqi903@gmail.com>,
 linux-block <linux-block@vger.kernel.org>
Cc: Shaohua Li <shli@fb.com>, boyu.mt@taobao.com, wenqing.lz@taobao.com,
 qijiang.qj@alibaba-inc.com
References: <526810b1-72e3-859f-aeaa-b5192144c589@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a943b083-541c-60f4-290a-9608f89f76e4@kernel.dk>
Date: Tue, 3 Oct 2017 15:42:21 -0600
MIME-Version: 1.0
In-Reply-To: <526810b1-72e3-859f-aeaa-b5192144c589@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/30/2017 12:38 AM, Joseph Qi wrote:
> From: Joseph Qi <qijiang.qj@alibaba-inc.com>
> 
> There is a case which will lead to io stall. The case is described as
> follows. 
> /test1
>   |-subtest1
> /test2
>   |-subtest2
> And subtest1 and subtest2 each has 32 queued bios already.
> 
> Now upgrade to max. In throtl_upgrade_state, it will try to dispatch
> bios as follows:
> 1) tg=subtest1, do nothing;
> 2) tg=test1, transfer 32 queued bios from subtest1 to test1; no pending
> left, no need to schedule next dispatch;
> 3) tg=subtest2, do nothing;
> 4) tg=test2, transfer 32 queued bios from subtest2 to test2; no pending
> left, no need to schedule next dispatch;
> 5) tg=/, transfer 8 queued bios from test1 to /, 8 queued bios from
> test2 to /, 8 queued bios from test1 to /, and 8 queued bios from test2
> to /; note that test1 and test2 each still has 16 queued bios left;
> 6) tg=/, try to schedule next dispatch, but since disptime is now
> (update in tg_update_disptime, wait=0), pending timer is not scheduled
> in fact;
> 7) In throtl_upgrade_state it totally dispatches 32 queued bios and with
> 32 left. test1 and test2 each has 16 queued bios;
> 8) throtl_pending_timer_fn sees the left over bios, but could do
> nothing, because throtl_select_dispatch returns 0, and test1/test2 has
> no pending tg.
> 
> The blktrace shows the following:
> 8,32   0        0     2.539007641     0  m   N throtl upgrade to max
> 8,32   0        0     2.539072267     0  m   N throtl /test2 dispatch nr_queued=16 read=0 write=16
> 8,32   7        0     2.539077142     0  m   N throtl /test1 dispatch nr_queued=16 read=0 write=16
> 
> So force schedule dispatch if there are pending children.

Applied for 4.14, thanks.

-- 
Jens Axboe
