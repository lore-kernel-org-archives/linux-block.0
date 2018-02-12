Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 12 Feb 2018 09:11:43 -0800
From: Tejun Heo <tj@kernel.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, xuejiufei <jiufei.xue@linux.alibaba.com>,
	Caspar Zhang <caspar@linux.alibaba.com>,
	linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
Message-ID: <20180212171143.GY695913@devbig577.frc2.facebook.com>
References: <6f136c90-faa9-4bc0-b02f-3a112b4d8360@linux.alibaba.com>
 <20180207213811.GF695913@devbig577.frc2.facebook.com>
 <b590caed-1423-4776-966d-cd9e346a8ea1@linux.alibaba.com>
 <20180208152307.GL695913@devbig577.frc2.facebook.com>
 <aac95b90-786d-95bf-b93d-87ecca79f846@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aac95b90-786d-95bf-b93d-87ecca79f846@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Joseph.

On Fri, Feb 09, 2018 at 10:15:19AM +0800, Joseph Qi wrote:
> IIUC, we have to identify it is in blkcg_css_offline now which will
> blkg_put. Since percpu_ref_kill_and_confirm in kill_css will set flag
> __PERCPU_REF_DEAD, so we can use this to avoid the race. IOW, if
> __PERCPU_REF_DEAD is set now, we know blkcg css is in offline and
> continue access blkg may risk double free. Thus we choose to skip these
> ios.
> I don't get how css_tryget works since it doesn't care the flag
> __PERCPU_REF_DEAD. Also css_tryget can't prevent blkcg_css from
> offlining since the race happens blkcg_css_offline is in progress.
> Am I missing something here?

Once marked dead, the ref is in atomic mode and css_tryget() would hit
the atomic counter.  Here, we don't care about the offlining and
draining.  A draining memcg can still have a lot of memory to be
written back attached to it and we don't want punt all of them to the
root cgroup.

Thanks.

-- 
tejun
