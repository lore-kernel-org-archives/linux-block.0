Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC] Block/blk-wbt: do not let background writes block
 sync writes
To: Liu Bo <bo.li.liu@oracle.com>, linux-block@vger.kernel.org
References: <20170826001427.23012-1-bo.li.liu@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b73a59d9-952b-d1f0-aa0a-86ba2b60a52c@kernel.dk>
Date: Sun, 27 Aug 2017 11:14:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170826001427.23012-1-bo.li.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/25/2017 06:14 PM, Liu Bo wrote:
> While using blk-wbt, sometimes sync writes are blocked by background
> writes, for example,
> 
> a) a background write reaches the (background) limit returned by
> get_limit(), so it's added into the rqw->wait (non kswapd's rqw in
> this case) and goes to sleep.
> 
> b) then a sync write gets queued and goes to sleep when finding that
> waitqueue_active() returns true and someone else is already on the
> waiting list.
> 
> Thus, the sync write will get its rq after the background write
> getting rq.
> 
> With this, only background writes will check waitqueue's status and
> sync writes will only be throttled by the (max) limit returned by
> get_limit().

Curious how you ran into this. Is this just speculation, or is it
observed behavior?

I don't think the patch makes sense, conceptually. If you end up in
may_queue(), you are (by definition) in a class of writes that
should be throttled. Skipping the wait line would be unfair.

One modification would be to check the depth, as we assign
different allowances to different types of writes. If the sync
write isn't above it's limit, we should not sleep.

-- 
Jens Axboe
