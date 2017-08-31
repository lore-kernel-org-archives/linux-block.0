Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 30 Aug 2017 17:36:58 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, lizefan@huawei.com,
	Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [RFC] block/loop: make loop cgroup aware
Message-ID: <20170831003657.GX491396@devbig577.frc2.facebook.com>
References: <dd357e1638021132cd39a11769a745a8318636d3.1503506490.git.shli@fb.com>
 <20170828225459.GE491396@devbig577.frc2.facebook.com>
 <20170829152236.vvtxahdrwqgmzmm7@kernel.org>
 <20170829152809.GM491396@devbig577.frc2.facebook.com>
 <20170830050704.pabmup7k5dzredtl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170830050704.pabmup7k5dzredtl@kernel.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Shaohua.

On Tue, Aug 29, 2017 at 10:07:04PM -0700, Shaohua Li wrote:
> > The association is already coming from the page.  We just need to make
> > sure that going through loop driver doesn't get in the way of the
> > membership getting propagated to the underlying device.
> 
> I think there is confusion. App writes files in upper layer fs on loop. memcg

Ah, yes, for some reason, I was still thinking about direct ios.

> estabilish membership for the pages of these files. Then writeback does write,
> loop then write these pages to under layer fs. The write is done in loop

Yes.

> thread. The write will allocate new page cache for under layer fs files. The
> issue is we must forward memcg info from upper layer files page cache to under
> layer files page cache.

Ah, I see.  We need to assign the ownership of the page cache pages to
the original dirtier.  Yeah, that's a different problem.  For now,
let's concentrate on the dio case.

> > So, this looks like the loop driver is explicitly forwarding the
> > association from the original issuer to the aio command and then from
> > the aio command to the ios to the underlying device.  I'm wondering
> > whether the right way to do this is making aio forward the association
> > by default, instead of the loop driver doing it explicitly.  That way,
> > all aio users can benefit from the forwarding instead of just loop.
> 
> That's possible. The downside doing this in aio is we must audit all fs to make
> sure all bio have association. I'd like to avoid doing this if there is no
> other loop-like cgroup usage.

But wouldn't that mean that we break cgroup membership for aios that
users issue?  Can't we do this in the generic aio layer?

Thanks.

-- 
tejun
