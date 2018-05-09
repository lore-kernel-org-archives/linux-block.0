Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <20180508035626.GF999@thunk.org>
References: <201805080545.HAF30756.QJOFOHFtSVMFLO@I-love.SAKURA.ne.jp>
 <20180507235142.GC999@thunk.org> <201805080028.w480SH3m013943@www262.sakura.ne.jp>
 <20180508035626.GF999@thunk.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 9 May 2018 10:49:54 +0200
Message-ID: <CACT4Y+ZZqUHgBduxGoSo5GuEBp8jTD=_mqq1wnyoA_hWVrD+jQ@mail.gmail.com>
Subject: Re: [PATCH] loop: add recursion validation to LOOP_CHANGE_FD
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Jens Axboe <axboe@kernel.dk>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, May 8, 2018 at 5:56 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Tue, May 08, 2018 at 09:28:17AM +0900, Tetsuo Handa wrote:
>> The thread I mean is:
>>
>>   general protection fault in lo_ioctl (2)
>>   https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
>>
>> Are you sure that your patch solves this problem as well?
>
> Well, I can't be sure, since there's not enough information in that
> particular syzkaller report to definitively pin down the root cause.
>
> And while I can't reproduce the crash using the syzkaller repro with
> the patch; I can't reproduce the crash *without* the patch, either.

Hi Ted,

Did you follow all instructions (commit, config, compiler, etc)?
syzbot does not have any special magic, it just executes the described
steps and then collects the kernel crash output it sees.


> This is what Syzkaller has to say, but of course, in its own
> documentation's words, "It's only a dumb bot".  :-)e

Well, not anymore. Now it's just a "bot":
https://github.com/google/syzkaller/commit/8180779d1d06e1cdf27882f50e7f72650f95797d
Too many people took "dumb bot" too seriously ;)


> That being said, triggering the problem which it is so concerned about
> requires root privilieges, so I would not consider it high priority to
> track down --- especially given that we don't have a reliable
> reproducer for it.
>
>
>                                     - Ted
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
>
> Reported-and-tested-by:
> syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         170785a9cc72 loop: add recursion validation to LOOP_CHANGE..
> git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/loop-fix
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
>
> Note: testing is done by a robot and is best-effort only.
>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180508035626.GF999%40thunk.org.
> For more options, visit https://groups.google.com/d/optout.
