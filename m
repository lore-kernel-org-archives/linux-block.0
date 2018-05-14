Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <20180509140248.GF28388@thunk.org>
References: <201805080545.HAF30756.QJOFOHFtSVMFLO@I-love.SAKURA.ne.jp>
 <20180507235142.GC999@thunk.org> <201805080028.w480SH3m013943@www262.sakura.ne.jp>
 <20180508035626.GF999@thunk.org> <CACT4Y+ZZqUHgBduxGoSo5GuEBp8jTD=_mqq1wnyoA_hWVrD+jQ@mail.gmail.com>
 <20180509140248.GF28388@thunk.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 May 2018 09:41:25 +0200
Message-ID: <CACT4Y+Z=82ys3riS1XFxe-SMsHCdwaz4BdQ5RQF1adxGMp7LEA@mail.gmail.com>
Subject: Re: [PATCH] loop: add recursion validation to LOOP_CHANGE_FD
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Jens Axboe <axboe@kernel.dk>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, May 9, 2018 at 4:02 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Wed, May 09, 2018 at 10:49:54AM +0200, Dmitry Vyukov wrote:
>> Hi Ted,
>>
>> Did you follow all instructions (commit, config, compiler, etc)?
>> syzbot does not have any special magic, it just executes the described
>> steps and then collects the kernel crash output it sees.
>
> No, I didn't.  Unfortunately, I don't have the time to repro it on
> exactly the config, commit, compiler.  And debugging tons of Syzkaller
> commits is not on my OKR list, and I have lots of P0/P1 bugs and
> projects that are competing for my attention.
>
> I tried repro'ing it using the standard compiler, and using -rc4 as a
> base.  If it doesn't repro there, using my standard kernel config ---
> and it requires root, and in my judgement it's *highly* unlikely to
> happen in real life --- then it becomes a P2 or P3 bug, it's not worth
> my time to build a kernel using exactly the commit, config, and
> compiler that Syzkaller specified.  Someday, you or I or someone else
> will build at tool that builds the kernel in a GCE VM, using the
> specified config and a compiler, and which minimizes the amount of
> human toil needed to do the sort of investigation you seem to want to
> dump on upstream developers.
>
> There's a *reason* why many upstream developers have been asking for
> improvements in the syzkaller tool to reduce toil.  If it's fair for
> you to ask for us to do work, then it's also fair for us to ask you to
> do work.  And if the answer is "sorry, I don't have the time; other
> things are higher priority", that's a fair answer coming from both
> sides.


Hi Ted,

I am working on syzbot/syzkaller all of my time. Repro script is on my
plate: https://github.com/google/syzkaller/issues/563. I will do it.
Not because somebody asks me, but because I am interested in making
kernel more correct, stable and secure.
