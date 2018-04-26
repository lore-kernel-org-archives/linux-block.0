Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 26 Apr 2018 12:01:18 -0700
From: Tejun Heo <tj@kernel.org>
To: Benlong Zhang <zhangbenlong@didichuxing.com>
Cc: axboe@kernel.dk, shli@kernel.org, david@fromorbit.com,
	bfoster@redhat.com, linux-block@vger.kernel.org,
	Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] A tentative patch to bypass REQ_META in blk throttle
Message-ID: <20180426190118.GP1911913@devbig577.frc2.facebook.com>
References: <20180420100554.GA23471@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180420100554.GA23471@localhost>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Fri, Apr 20, 2018 at 06:06:01PM +0800, Benlong Zhang wrote:
> One problem with cgwb is how fs should treat metadata bios.
> For example in xfs, the log might be partially stuck in one
> group, leaving threads in other groups waiting for too long.
> Please refer to the linux-xfs discussion:
> "[PATCH V2] xfs: implement cgroup writeback support"
> 
> One approach is to correctly tag bio->bi_css from within the
> filesystems (for xfs log should be blkcg_root), and the other
> is to skip them, but relies on REQ_META being set.
> 
> It works with xfs on a cgwb porting implementation to 3.10.0.
> But really not sure about other filesystems...

Yeah, Josef (cc'd) is working on a similar approach but in a more
generic way.

Thanks.

-- 
tejun
