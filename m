Return-Path: <tytso@thunk.org>
Date: Mon, 7 May 2018 19:51:42 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: axboe@kernel.dk, syzkaller-bugs@googlegroups.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: add recursion validation to LOOP_CHANGE_FD
Message-ID: <20180507235142.GC999@thunk.org>
References: <20180504021717.9246-1-tytso@mit.edu>
 <201805072016.GAC48495.VSJQFtFHLFMOOO@I-love.SAKURA.ne.jp>
 <20180507131007.GZ29205@thunk.org>
 <201805072221.AGH57860.MOSHJOtOQFLFFV@I-love.SAKURA.ne.jp>
 <20180507153352.GB999@thunk.org>
 <201805080545.HAF30756.QJOFOHFtSVMFLO@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201805080545.HAF30756.QJOFOHFtSVMFLO@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 08, 2018 at 05:45:21AM +0900, Tetsuo Handa wrote:
> > 
> > > By the way, are you aware that current "/* Avoid recursion */" loop is not thread safe?
> > 
> > Actually, it is safe.  While the child loop device has an open file on
> > the parent, lo_refcnt is elevated, which prevents loop_clr_fd from
> > actually set setting lo_state to Lo_rundown and clearing
> > lo_backing_file
> 
> If you think it is safe, please explain that the crash referenced in a patch
> at https://groups.google.com/d/msg/syzkaller-bugs/2Rw8-OM6IbM/PzdobV8kAgAJ is
> no longer possible. syzbot is hitting crashes there.

Huh?  You were worried about a race where loop_change_fd could race
with loop_clr_fd causing a NULL dereference of lo_backing_file.

The mail thread you are referencing is a deadlock problem with
loop_reread_partitions() and lo_release().  This is unreleated to the
possible race you were concerned about in loop_change_fd().

						- Ted
