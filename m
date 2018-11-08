Return-Path: <jack@suse.cz>
Date: Thu, 8 Nov 2018 14:25:41 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH 0/16 v3] loop: Fix oops and possible deadlocks
Message-ID: <20181108132541.GD29349@quack2.suse.cz>
References: <20181108130116.12140-1-jack@suse.cz>
 <052375c5-c98e-8bc3-a8b7-2d23882cac36@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <052375c5-c98e-8bc3-a8b7-2d23882cac36@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu 08-11-18 06:21:21, Jens Axboe wrote:
> On 11/8/18 6:01 AM, Jan Kara wrote:
> > Hi,
> > 
> > this patch series fixes oops and possible deadlocks as reported by syzbot [1]
> > [2]. The second patch in the series (from Tetsuo) fixes the oops, the remaining
> > patches are cleaning up the locking in the loop driver so that we can in the
> > end reasonably easily switch to rereading partitions without holding mutex
> > protecting the loop device.
> > 
> > I have tested the patches by creating, deleting, modifying loop devices, and by
> > running loop blktests (as well as creating new ones with the load syzkaller has
> > used to detect the problem). Review is welcome but I think the patches are fine
> > to go as far as I'm concerned! Jens, can you please pick them up?
> 
> I've been waiting for this series - it's a big series for 4.20, though... It
> would suck having to defer this to 4.21 since it's a long standing issue, but
> the risk of a new regression is present as well.
> 
> Are you fine with this going in for 4.21?

Yeah, I'm fine with the delay so that it has time to soak in linux-next.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
