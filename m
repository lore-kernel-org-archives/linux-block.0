Return-Path: <tytso@thunk.org>
Date: Mon, 7 May 2018 11:33:52 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: axboe@kernel.dk, syzkaller-bugs@googlegroups.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: add recursion validation to LOOP_CHANGE_FD
Message-ID: <20180507153352.GB999@thunk.org>
References: <20180504021717.9246-1-tytso@mit.edu>
 <201805072016.GAC48495.VSJQFtFHLFMOOO@I-love.SAKURA.ne.jp>
 <20180507131007.GZ29205@thunk.org>
 <201805072221.AGH57860.MOSHJOtOQFLFFV@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201805072221.AGH57860.MOSHJOtOQFLFFV@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 07, 2018 at 10:21:04PM +0900, Tetsuo Handa wrote:
> > I don't understand your concern; where are we going to out_putf when
> > error == 0?

Ah, now I see it, thanks.  I'll send a revised patch.

> By the way, are you aware that current "/* Avoid recursion */" loop is not thread safe?

Actually, it is safe.  While the child loop device has an open file on
the parent, lo_refcnt is elevated, which prevents loop_clr_fd from
actually set setting lo_state to Lo_rundown and clearing
lo_backing_file

						- Ted
