Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
To: tytso@mit.edu
Cc: axboe@kernel.dk, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: add recursion validation to LOOP_CHANGE_FD
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180504021717.9246-1-tytso@mit.edu>
	<201805072016.GAC48495.VSJQFtFHLFMOOO@I-love.SAKURA.ne.jp>
	<20180507131007.GZ29205@thunk.org>
	<201805072221.AGH57860.MOSHJOtOQFLFFV@I-love.SAKURA.ne.jp>
	<20180507153352.GB999@thunk.org>
In-Reply-To: <20180507153352.GB999@thunk.org>
Message-Id: <201805080545.HAF30756.QJOFOHFtSVMFLO@I-love.SAKURA.ne.jp>
Date: Tue, 8 May 2018 05:45:21 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Theodore Y. Ts'o wrote:
> On Mon, May 07, 2018 at 10:21:04PM +0900, Tetsuo Handa wrote:
> > > I don't understand your concern; where are we going to out_putf when
> > > error == 0?
> 
> Ah, now I see it, thanks.  I'll send a revised patch.
> 
> > By the way, are you aware that current "/* Avoid recursion */" loop is not thread safe?
> 
> Actually, it is safe.  While the child loop device has an open file on
> the parent, lo_refcnt is elevated, which prevents loop_clr_fd from
> actually set setting lo_state to Lo_rundown and clearing
> lo_backing_file

If you think it is safe, please explain that the crash referenced in a patch
at https://groups.google.com/d/msg/syzkaller-bugs/2Rw8-OM6IbM/PzdobV8kAgAJ is
no longer possible. syzbot is hitting crashes there.
