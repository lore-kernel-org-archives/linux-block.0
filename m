Return-Path: <zhangbenlong@didichuxing.com>
Date: Wed, 2 May 2018 10:20:20 +0800
From: Benlong Zhang <zhangbenlong@didichuxing.com>
To: Tejun Heo <tj@kernel.org>
CC: <axboe@kernel.dk>, <shli@kernel.org>, <david@fromorbit.com>,
	<bfoster@redhat.com>, <linux-block@vger.kernel.org>, Josef Bacik
	<jbacik@fb.com>
Subject: Re: [PATCH] A tentative patch to bypass REQ_META in blk throttle
Message-ID: <20180502022004.GA3831@localhost>
References: <20180420100554.GA23471@localhost>
 <20180426190118.GP1911913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20180426190118.GP1911913@devbig577.frc2.facebook.com>
Return-Path: zhangbenlong@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

Hi Tejun,

On Thu, Apr 26, 2018 at 12:01:18PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Fri, Apr 20, 2018 at 06:06:01PM +0800, Benlong Zhang wrote:
> > One problem with cgwb is how fs should treat metadata bios.
> > For example in xfs, the log might be partially stuck in one
> > group, leaving threads in other groups waiting for too long.
> > Please refer to the linux-xfs discussion:
> > "[PATCH V2] xfs: implement cgroup writeback support"
> > 
> > One approach is to correctly tag bio->bi_css from within the
> > filesystems (for xfs log should be blkcg_root), and the other
> > is to skip them, but relies on REQ_META being set.
> > 
> > It works with xfs on a cgwb porting implementation to 3.10.0.
> > But really not sure about other filesystems...
> 
> Yeah, Josef (cc'd) is working on a similar approach but in a more
> generic way.

Good to know and looking forward to the code.

Thank you for your reply!

Benlong

> 
> Thanks.
> 
> -- 
> tejun
