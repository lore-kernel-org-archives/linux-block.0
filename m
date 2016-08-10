Return-Path: <roman.penyaev@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <20160810035542.GE25053@mtj.duckdns.org>
References: <20160808113908.5445-1-roman.penyaev@profitbricks.com> <20160810035542.GE25053@mtj.duckdns.org>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Wed, 10 Aug 2016 10:42:09 +0200
Message-ID: <CAJrWOzCWfMN7qKipgWn2P0dfycu4y5DQysD+7Q1UANgXBgw0+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] blk-mq: fix hang caused by freeze/unfreeze sequence
To: Tejun Heo <tj@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi,

On Wed, Aug 10, 2016 at 5:55 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Mon, Aug 08, 2016 at 01:39:08PM +0200, Roman Pen wrote:
>> Long time ago there was a similar fix proposed by Akinobu Mita[1],
>> but it seems that time everyone decided to fix this subtle race in
>> percpu-refcount and Tejun Heo[2] did an attempt (as I can see that
>> patchset was not applied).
>
> So, I probably forgot about it while waiting for confirmation of fix.
> Can you please verify that the patchset fixes the issue?  I can apply
> the patchset right away.

I have not checked your patchset but according to my understanding
it should not fix *this* issue.  What happens here is a wrong order
of invocation of percpu_ref_reinit() and percpu_ref_kill().  So what
was observed is the following:

 CPU#0               CPU#1
 ----------------    -----------------
 percpu_ref_kill()



                     percpu_ref_kill() << atomic reference does
 percpu_ref_reinit()                   << not guarantee the order




                     blk_mq_freeze_queue_wait() !! HANG HERE

                     percpu_ref_reinit()



blk_mq_freeze_queue_wait() on CPU#1 expects percpu-refcount to be
switched to ATOMIC mode (killed), but that does not happen, because
CPU#2 was faster and has been switched percpu-refcount to PERCPU
mode.

This race happens inside blk-mq, because invocation of kill/reinit
is controlled by the reference counter, which does not guarantee the
order of the following functions calls (kill/reinit).

So the fix is the same as originally proposed by Akinobu Mita, but
the issue is different.

But of course I can run tests on top of your series, just to verify
that everything goes smoothly and internally percpu-refcount members
are consistent.

--
Roman
