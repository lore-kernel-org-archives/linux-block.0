Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 19 Mar 2018 07:45:32 -0700
From: Tejun Heo <tj@kernel.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, xuejiufei <jiufei.xue@linux.alibaba.com>,
	Caspar Zhang <caspar@linux.alibaba.com>,
	linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5] blk-throttle: fix race between
 blkcg_bio_issue_check() and cgroup_rmdir()
Message-ID: <20180319144532.GJ2943022@devbig577.frc2.facebook.com>
References: <5c99ef07-1133-a45a-9a09-7c29e8139f5b@linux.alibaba.com>
 <20180314140901.GV2943022@devbig577.frc2.facebook.com>
 <d988a1eb-98c0-6a79-d271-778f5ca17b3e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d988a1eb-98c0-6a79-d271-778f5ca17b3e@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Mar 15, 2018 at 09:18:55AM +0800, Joseph Qi wrote:
> > This is pure bike-shedding but offlined reads kinda weird to me, maybe
> > just offline would read better?  Other than that,
> > 
> Do I need to resend a new version for this?

No idea, Jens's call.  He can fix it up if he wants to while applying
but there's no harm in sending an updated version either.

Thanks.

-- 
tejun
