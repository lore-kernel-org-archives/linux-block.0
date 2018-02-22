Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 22 Feb 2018 07:18:27 -0800
From: Tejun Heo <tj@kernel.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, xuejiufei <jiufei.xue@linux.alibaba.com>,
	Caspar Zhang <caspar@linux.alibaba.com>,
	linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
Message-ID: <20180222151721.GA1641506@devbig577.frc2.facebook.com>
References: <6f136c90-faa9-4bc0-b02f-3a112b4d8360@linux.alibaba.com>
 <20180207213811.GF695913@devbig577.frc2.facebook.com>
 <b590caed-1423-4776-966d-cd9e346a8ea1@linux.alibaba.com>
 <20180208152307.GL695913@devbig577.frc2.facebook.com>
 <aac95b90-786d-95bf-b93d-87ecca79f846@linux.alibaba.com>
 <20180212171143.GY695913@devbig577.frc2.facebook.com>
 <19009bad-8429-c210-dd91-2b20771a66bd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19009bad-8429-c210-dd91-2b20771a66bd@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Feb 22, 2018 at 02:14:34PM +0800, Joseph Qi wrote:
> I still don't get how css_tryget can work here.
> 
> The race happens when:
> 1) writeback kworker has found the blkg with rcu;
> 2) blkcg is during offlining and blkg_destroy() has already been called.
> Then, writeback kworker will take queue lock and access the blkg with
> refcount 0.

Yeah, then tryget would fail and it should go through the root.

Thanks.

-- 
tejun
