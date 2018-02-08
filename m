Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2018 07:23:07 -0800
From: Tejun Heo <tj@kernel.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, xuejiufei <jiufei.xue@linux.alibaba.com>,
	Caspar Zhang <caspar@linux.alibaba.com>,
	linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
Message-ID: <20180208152307.GL695913@devbig577.frc2.facebook.com>
References: <6f136c90-faa9-4bc0-b02f-3a112b4d8360@linux.alibaba.com>
 <20180207213811.GF695913@devbig577.frc2.facebook.com>
 <b590caed-1423-4776-966d-cd9e346a8ea1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b590caed-1423-4776-966d-cd9e346a8ea1@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Joseph.

On Thu, Feb 08, 2018 at 10:29:43AM +0800, Joseph Qi wrote:
> So you mean checking css->refcnt to prevent the further use of
> blkg_get? I think it makes sense.

Yes.

> IMO, we should use css_tryget_online instead, and rightly after taking

Not really.  An offline css still can have a vast amount of IO to
drain and write out.

> queue_lock. Because there may be more use of blkg_get in blk_throtl_bio
> in the futher. Actually it already has two now. One is in
> blk_throtl_assoc_bio, and the other is in throtl_qnode_add_bio.
> What do you think of this?

As long as we avoid making the bypass paths expensive, whatever makes
the code easier to read and maintain would be better.  css ref ops are
extremely cheap anyway.

Thanks.

-- 
tejun
