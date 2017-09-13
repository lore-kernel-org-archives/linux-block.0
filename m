Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 13 Sep 2017 14:42:27 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V2 4/4] block/loop: make loop cgroup aware
Message-ID: <20170913214226.GD378890@devbig577.frc2.facebook.com>
References: <cover.1505335620.git.shli@fb.com>
 <2f16f7a5176195bc70a2c10dd7fa11ea85b9145f.1505335620.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2f16f7a5176195bc70a2c10dd7fa11ea85b9145f.1505335620.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 13, 2017 at 02:01:29PM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> loop block device handles IO in a separate thread. The actual IO
> dispatched isn't cloned from the IO loop device received, so the
> dispatched IO loses the cgroup context.
> 
> I'm ignoring buffer IO case now, which is quite complicated.  Making the
> loop thread aware cgroup context doesn't really help. The loop device
> only writes to a single file. In current writeback cgroup
> implementation, the file can only belong to one cgroup.
> 
> For direct IO case, we could workaround the issue in theory. For
> example, say we assign cgroup1 5M/s BW for loop device and cgroup2
> 10M/s. We can create a special cgroup for loop thread and assign at
> least 15M/s for the underlayer disk. In this way, we correctly throttle
> the two cgroups. But this is tricky to setup.
> 
> This patch tries to address the issue. We record bio's css in loop
> command. When loop thread is handling the command, we then use the API
> provided in patch 1 to set the css for current task. The bio layer will
> use the css for new IO (from patch 3).
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
