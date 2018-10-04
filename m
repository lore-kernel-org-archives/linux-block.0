Return-Path: <jack@suse.cz>
Date: Thu, 4 Oct 2018 12:15:56 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/14] loop: Fix oops and possible deadlocks
Message-ID: <20181004101556.GE11529@quack2.suse.cz>
References: <20180927113652.5422-1-jack@suse.cz>
 <9aa37417-990d-84bf-5a6e-88bcca1c106a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9aa37417-990d-84bf-5a6e-88bcca1c106a@i-love.sakura.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Thu 27-09-18 23:47:01, Tetsuo Handa wrote:
> Possible changes folded into this series.

Thanks for having a look. But please comment on individual patches at
appropriate places instead of sending this patch where everything is just
mixed together. It is much easier to find out what we are talking about
that way.

>   (1) (I guess) no need to use _nested version.

I just preserved the current status as I didn't want to dig into that hole.
Even if you're right, that would be a separate change. Not something these
patches should deal with.

>   (2) Use mutex_lock_killable() where possible.

Where exactly? I've only noticed you've changed loop_probe() where I think
the change is just bogus. That gets called on device insertion and you have
nowhere to deliver the signal in that case.

>   (3) Move fput() to after mutex_unlock().

Again, independent change. I've just preserved the current situation. But
probably worth including in this series as a separate patch. Care to send a
follow up patch with proper changelog etc.?

>   (4) Don't return 0 upon invalid loop_control_ioctl().

Good catch, I'll fix that up.

>   (5) No need to mutex_lock()/mutex_unlock() on each loop device at
>       unregister_transfer_cb() callback.

Another independent optimization. Will you send a follow up patch? I can
write the patch (and the one above) but I don't want to steal the credit
from you...

>   (6) No need to mutex_unlock()+mutex_lock() when calling __loop_clr_fd().

This is deliberate so that we get rid of the weird "__loop_clr_fd()
releases mutex it did not acquire". This is not performance critical path
by any means so better keep the locking simple.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
