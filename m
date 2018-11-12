Return-Path: <jack@suse.cz>
Date: Mon, 12 Nov 2018 11:15:02 +0100
From: Jan Kara <jack@suse.cz>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH 0/16 v3] loop: Fix oops and possible deadlocks
Message-ID: <20181112101502.GA7175@quack2.suse.cz>
References: <20181108130116.12140-1-jack@suse.cz>
 <20181108212811.GH1080@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181108212811.GH1080@thunk.org>
List-ID: <linux-block@vger.kernel.org>

On Thu 08-11-18 16:28:11, Theodore Y. Ts'o wrote:
> On Thu, Nov 08, 2018 at 02:01:00PM +0100, Jan Kara wrote:
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
> > 
> > Changes since v1:
> > * Added patch moving fput() calls in loop_change_fd() from under loop_ctl_mutex
> > * Fixed bug in loop_control_ioctl() where it failed to return error properly
> > 
> > Changes since v2:
> > * Rebase on top of 4.20-rc1
> > * Add patch to stop fooling lockdep about loop_ctl_mutex
> > 
> > 								Honza
> 
> Thanks for working on fixing up the Loop driver to fix these races!
> 
> Is it worth adding some Cc: stable@kernel.org lines?  Figuring out
> which Fixes they should apply to might be tricky, and from my
> experience because of some of the recent loop work, backporting to
> older stable kernels is not necessarily going to be trivial.  But
> since Dmitry also runs Syzkaller on stable kernels, it'd be great if
> we could get them backported without relying on Sasha's AUTOSTABLE.

That's a fair request but generally I've found this too intrusive for
stable.  The patch 2/16 should be relatively easy to backport and closes
the possible use-after-free which is the nasties of the problems (but also
so rare that I was never able to hit it in my testing and syzbot hit it
only couple of times todate). So there CC to stable might make sense.  The
rest fixes possible deadlocks and they are possible to trigger only by root
bashing reconfiguration of loop devices - IMO not worth the hassle for
stable.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
