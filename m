Return-Path: <shli@kernel.org>
Date: Fri, 8 Sep 2017 10:07:15 -0700
From: Shaohua Li <shli@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 3/3] block/loop: make loop cgroup aware
Message-ID: <20170908170715.54c536vy77w2biki@kernel.org>
References: <cover.1504748195.git.shli@fb.com>
 <83915a4be672d99729029800196008c3b39c7a3a.1504748195.git.shli@fb.com>
 <20170908144808.GA1774378@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170908144808.GA1774378@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 08, 2017 at 07:48:09AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 06, 2017 at 07:00:53PM -0700, Shaohua Li wrote:
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 9d4545f..9850b27 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -482,6 +482,8 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
> >  {
> >  	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
> >  
> > +	if (cmd->css)
> > +		css_put(cmd->css);
> >  	cmd->ret = ret > 0 ? 0 : ret;
> >  	lo_rw_aio_do_completion(cmd);
> 
> The fact that we're forwarding explicitly in loop still bothers me a
> bit.  Can you please elaborate why we don't want to do this
> generically through aio?

I think we must forward in loop, because each cmd could come from different
cgroup, so we must explicitly forward for each cmd.

The main reason not to do the forward in aio is complexity. We at least have 3
different implementations for dio:
- __blockdev_direct_IO for ext4 and btrfs
- iomap dio for xfs
- blockdev dio implementation

Forwarding in dio means hooking the cgroup association for each bio dispatched
in the implementations, which is a little messy. I'd like to avoid this if
there is no strong reason to do it.

Thanks,
Shaohua
