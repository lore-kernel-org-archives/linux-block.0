Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Message-Id: <201805080028.w480SH3m013943@www262.sakura.ne.jp>
Subject: Re: [PATCH] loop: add recursion validation to
 =?ISO-2022-JP?B?TE9PUF9DSEFOR0VfRkQ=?=
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: axboe@kernel.dk, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Date: Tue, 08 May 2018 09:28:17 +0900
References: <201805080545.HAF30756.QJOFOHFtSVMFLO@I-love.SAKURA.ne.jp> <20180507235142.GC999@thunk.org>
In-Reply-To: <20180507235142.GC999@thunk.org>
Content-Type: text/plain; charset="ISO-2022-JP"
List-ID: <linux-block@vger.kernel.org>

> On Tue, May 08, 2018 at 05:45:21AM +0900, Tetsuo Handa wrote:
> > > 
> > > > By the way, are you aware that current "/* Avoid recursion */" loop is not thread safe?
> > > 
> > > Actually, it is safe.  While the child loop device has an open file on
> > > the parent, lo_refcnt is elevated, which prevents loop_clr_fd from
> > > actually set setting lo_state to Lo_rundown and clearing
> > > lo_backing_file
> > 
> > If you think it is safe, please explain that the crash referenced in a patch
> > at https://groups.google.com/d/msg/syzkaller-bugs/2Rw8-OM6IbM/PzdobV8kAgAJ is
> > no longer possible. syzbot is hitting crashes there.
> 
> Huh?  You were worried about a race where loop_change_fd could race
> with loop_clr_fd causing a NULL dereference of lo_backing_file.
> 
> The mail thread you are referencing is a deadlock problem with
> loop_reread_partitions() and lo_release().  This is unreleated to the
> possible race you were concerned about in loop_change_fd().

The thread I mean is:

  general protection fault in lo_ioctl (2)
  https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3

Are you sure that your patch solves this problem as well?
