Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Feb 2016 12:14:04 -0500
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling
 and cgroups support
Message-ID: <20160217171404.GW3741@mtj.duckdns.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
 <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
 <20160211222824.GD3741@mtj.duckdns.org>
 <87934440-FAA0-4B2D-897F-AD78EAF5F54E@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87934440-FAA0-4B2D-897F-AD78EAF5F54E@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Feb 17, 2016 at 10:07:16AM +0100, Paolo Valente wrote:
> > * How's writeback handled?
> 
> If I understood correctly your question, then the answer is that
> there is no special/automatic handling of writeback queues. Thus,
> unless the user explicitly inserts flushing threads in some groups
> and plays with the weights of these groups, these threads will just
> get the default weight, and thus the default treatment for queues in
> the root group. IOW, no privileges. The motivation is that these
> threads serve asynchronous requests, i.e., requests that do not
> cause any delay to the processes that issue them. Therefore, apart
> from higher-level considerations on vm page-flushing pressure, there
> is basically no point in privileging writeback I/O with respect to
> other types of possibly time-sensitive I/O.

So, under cgroup v2, writeback traffic is associated correctly with
the cgroup which caused it.  It's not about privileging writeback IOs
but ensuring that they're correctly attributed and proportinally
controlled according to the configuration.  It seemed that this was
working with bfq but it'd be great if you can test and confirm it.
Please read the writeback section in Documentation/cgroup-v2.txt.

> > * I was testing on the v2 hierarchy with two top-level cgroups one
> >  hosting sequential workload and the other completely random.  While
> >  they eventually converged to a reasonable state, starting up the
> >  sequential workload while the random workload was running was
> >  extremely slow.  It crawled for quite a while.
>
> This is definitely a bug. Could you please (maybe privately?) send
> me the exact commands/script you have used?

Oh I see.  I did something like the following.

1. mkdir cgroup-v2
2. mount -t cgroup2 none cgroup-v2
3. cd cgroup-v2; mkdir asdf fdsa
4. echo +memory +io > cgroup.subtree_control
5. echo 16M > asdf/memory.high; echo 16M > fdsa/memory.high

A-1. echo $$ > asdf/cgroup.procs
A-2. test-rawio.c $DEV 8 16

B-1. echo $$ > fdsa/cgroup.procs
B-2. dd if=/dev/zero of=$TESTFILE_ON_DEV bs=1M

> > * And "echo 100 > io.weight" hung the writing process.
>
> I’m not sure I understood exactly which process you are referring
> to, but I guess I will probably understand it from the commands I
> have asked you to share.

Oh, I ran "echo 100 > asdf/io.weight" after running the above test and
the echoing process just got stuck in the kernel.  I haven't really
investigated it but it seemed pretty easy to reproduce.  If you can't
reproduce it easily, please let me know.  I'll try to dig in.

Thanks.

-- 
tejun
