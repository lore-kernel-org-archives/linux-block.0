Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 13 Sep 2017 14:43:08 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V2 1/4] kthread: add a mechanism to store cgroup info
Message-ID: <20170913214308.GE378890@devbig577.frc2.facebook.com>
References: <cover.1505335620.git.shli@fb.com>
 <802ba16bd896e56bc974780e97157760fde7c273.1505335620.git.shli@fb.com>
 <20170913213820.GA378890@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170913213820.GA378890@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 13, 2017 at 02:38:20PM -0700, Tejun Heo wrote:
> Maybe doing sth like the following is less error-prone?
> 
> kthread_associate_blkcg(@css)
> {
> 	if (current's kthread->blkcg_css)
> 		put kthread->blkcg_css and set it to NULL;
> 	if (@css)
> 		get @css and set kthread->blkcg;
> }

Ooh, also, maybe add a WARN_ON_ONCE on non-NULL blkcg_css on kthread
exit?

Thanks.

-- 
tejun
