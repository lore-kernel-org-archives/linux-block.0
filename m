Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <201806080231.w582VIRn021009@www262.sakura.ne.jp>
References: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
 <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com> <201806080231.w582VIRn021009@www262.sakura.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 16:45:29 +0200
Message-ID: <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
Subject: Re: general protection fault in wb_workfn (2)
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 8, 2018 at 4:31 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Dmitry Vyukov wrote:
>> On Tue, Jun 5, 2018 at 3:45 PM, Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> > Dmitry, can you assign VM resources for a git tree for this bug? This bug wants to fight
>> > against https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches ...
>>
>> Hi Tetsuo,
>>
>> Most of the reasons for not doing it still stand. A syzkaller instance
>> will produce not just this bug, it will produce hundreds of different
>> bugs. Then the question is: what to do with these bugs? Report all to
>> mailing lists?
>
> Is it possible to add linux-next.git tree as a target for fuzzing? If yes,
> we can try debug patches easily, in addition to find bugs earlier than now.

syzbot tested linux-next and mmotm initially, but they were removed at
the request of kernel developers. See:
https://groups.google.com/d/msg/syzkaller/0H0LHW_ayR8/dsK5qGB_AQAJ
and:
https://groups.google.com/d/msg/syzkaller-bugs/FeAgni6Atlk/U0JGoR0AAwAJ
Indeed, linux-next produces around 50 assorted one-off unexplainable
bug reports.


>> I think the solution here is just to run syzkaller instance locally.
>> It's just a program anybody can run it on any kernel with any custom
>> patches. Moreover for local instance it's also possible to limit set
>> of tested syscalls to increase probability of hitting this bug and at
>> the same time filter out most of other bugs.
>
> If this bug is reproducible with VM resources individual developer can afford...
>
> Since my Linux development environment is VMware guests on a Windows PC, I can't
> run VM instance which needs KVM acceleration. Also, due to security policy, I can't
> utilize external VM resources available on the Internet, as well as I can't use ssh
> and git protocols. Speak of this bug, even with a lot of VM instances, syzbot can
> reproduce this bug only once or twice per a day. Thus, the question for me boils
> down to, whether I can reproduce this bug using one VMware guest instance with 4GB
> of memory. Effectively, I don't have access to environments for running syzkaller
> instance...

Well, I don't know what to say, it does require some resources.

>> Do we have any idea about the guilty subsystem? You mentioned
>> bdi_unregister, why? What would be the set of syscalls to concentrate
>> on?
>> I will do a custom run when I get around to it, if nobody else beats me to it.
>
> Because bdi_unregister() does "bdi->dev = NULL;" which wb_workfn() is hitting
> NULL pointer dereference.

Right, wb_workfn is not a generic function, it's fs-specific function.

Trying to reproduce this locally now.
