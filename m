Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 15 Sep 2017 08:51:15 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 1/4] kthread: add a mechanism to store cgroup info
Message-ID: <20170915155115.GG378890@devbig577.frc2.facebook.com>
References: <cover.1505422351.git.shli@fb.com>
 <9649525546c2a69f22c7ec5a87858affece87160.1505422351.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9649525546c2a69f22c7ec5a87858affece87160.1505422351.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 14, 2017 at 02:02:04PM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> kthread usually runs jobs on behalf of other threads. The jobs should be
> charged to cgroup of original threads. But the jobs run in a kthread,
> where we lose the cgroup context of original threads. The patch adds a
> machanism to record cgroup info of original threads in kthread context.
> Later we can retrieve the cgroup info and attach the cgroup info to jobs.
> 
> Since this mechanism is only required by kthread, we store the cgroup
> info in kthread data instead of generic task_struct.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
