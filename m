Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Aug 2016 14:54:05 -0400
From: Tejun Heo <tj@kernel.org>
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] blk-mq: fix hang caused by freeze/unfreeze
 sequence
Message-ID: <20160810185405.GN25053@mtj.duckdns.org>
References: <20160808113908.5445-1-roman.penyaev@profitbricks.com>
 <20160810035542.GE25053@mtj.duckdns.org>
 <CAJrWOzCWfMN7qKipgWn2P0dfycu4y5DQysD+7Q1UANgXBgw0+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJrWOzCWfMN7qKipgWn2P0dfycu4y5DQysD+7Q1UANgXBgw0+g@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 10, 2016 at 10:42:09AM +0200, Roman Penyaev wrote:
> Hi,
> 
> On Wed, Aug 10, 2016 at 5:55 AM, Tejun Heo <tj@kernel.org> wrote:
> > Hello,
> >
> > On Mon, Aug 08, 2016 at 01:39:08PM +0200, Roman Pen wrote:
> >> Long time ago there was a similar fix proposed by Akinobu Mita[1],
> >> but it seems that time everyone decided to fix this subtle race in
> >> percpu-refcount and Tejun Heo[2] did an attempt (as I can see that
> >> patchset was not applied).
> >
> > So, I probably forgot about it while waiting for confirmation of fix.
> > Can you please verify that the patchset fixes the issue?  I can apply
> > the patchset right away.
> 
> I have not checked your patchset but according to my understanding
> it should not fix *this* issue.  What happens here is a wrong order
> of invocation of percpu_ref_reinit() and percpu_ref_kill().  So what
> was observed is the following:

Ah, understood.

Acked-by: Tejun Heo <tj@kernel.org>

I'll commit the percpu_refcnt patches too.  While they don't fix the
problem on their own, the changes are generally useful for all mode
switching use cases.

Thanks.

-- 
tejun
