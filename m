Return-Path: <shli@kernel.org>
Date: Thu, 7 Sep 2017 14:52:36 -0700
From: Shaohua Li <shli@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	FB Kernel Team <kernel-team@fb.com>, Jens Axboe <axboe@kernel.dk>,
	Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V2 3/3] block/loop: suppress discard IO error message
Message-ID: <20170907215236.wty5hwudyn52znme@kernel.org>
References: <cover.1504742003.git.shli@fb.com>
 <93626ad390557b27c872bb8325485c9d56cc4e06.1504742003.git.shli@fb.com>
 <CACVXFVO3UaHn32E+kNjRkUHUwn3d=goWA9HFNXqgYHNr+7ZbxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVO3UaHn32E+kNjRkUHUwn3d=goWA9HFNXqgYHNr+7ZbxA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 07, 2017 at 05:16:21PM +0800, Ming Lei wrote:
> On Thu, Sep 7, 2017 at 8:13 AM, Shaohua Li <shli@kernel.org> wrote:
> > From: Shaohua Li <shli@fb.com>
> >
> > We don't know if fallocate really supports FALLOC_FL_PUNCH_HOLE till
> > fallocate is called. If it doesn't support, loop will return -EOPNOTSUPP
> > and we see a lot of error message printed by blk_update_request. Failure
> > for discard IO isn't a big problem, so we just return 0 in loop which
> > will suppress the IO error message.
> 
> Setting RQF_QUIET for discard IO should be more clean for suppressing error,
> and upper layer can get the failure notification too.

Hmm, forgot why I didn't do this, did consider it before. Probably because
nobody check the return value of discard request. Probably we should skip the
error message for all discard IO in block layer.

I'll repost a patch to fix this issue.

Thanks,
Shaohua
