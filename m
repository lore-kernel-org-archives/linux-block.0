Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block core changes for 4.10
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <6176de36-7f4f-040b-f277-e872cc98eb5e@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e2104bea-8028-dafe-cb64-e376fa7e45fb@kernel.dk>
Date: Tue, 13 Dec 2016 13:19:21 -0700
MIME-Version: 1.0
In-Reply-To: <6176de36-7f4f-040b-f277-e872cc98eb5e@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/11/2016 06:52 PM, Jens Axboe wrote:
> Note that this pull will throw 3 trivial merge conflicts, since we had
> patches that went into mainline after 4.9-rc1 (upon which this branch is
> based), and one that will not show up in block/blk-flush.c. The latter
> is due to a fix that went in for the flush code using an old request
> flag that is now changed to a per-request one. To ensure that this all
> goes smoothly, I just merged 4.9 with this branch and provide that as a
> reference:
> 
>   git://git.kernel.dk/linux-block.git for-4.10/merge
> 
> But really, the only one you to watch for is this line in
> block/blk-flush.c:
> 
>         /* for avoiding double accounting */
> 	rq->cmd_flags &= ~REQ_STARTED;
> 
> which should now be:
> 
>         rq->rq_flags &= ~RQF_STARTED;
> 
> and the three merge conflicts that do show up are trivially resolvable.

Since you have merged trees since that contain block drivers, you are
going to get a new merge conflict. There's one with mmc block now, which
is again just a switch from rq->cmd_flags to rq->rq_flags and using
RQF_foo instead of REQ_foo.

-- 
Jens Axboe
