Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 13 Sep 2017 14:42:02 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V2 3/4] block: make blkcg aware of kthread stored
 original cgroup info
Message-ID: <20170913214202.GC378890@devbig577.frc2.facebook.com>
References: <cover.1505335620.git.shli@fb.com>
 <101ca17fd701ce7afbc6e4e7d1d4d7a9f091db1b.1505335620.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <101ca17fd701ce7afbc6e4e7d1d4d7a9f091db1b.1505335620.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 13, 2017 at 02:01:28PM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> bio_blkcg is the only API to get cgroup info for a bio right now. If
> bio_blkcg finds current task is a kthread and has original blkcg
> associated, it will use the css instead of associating the bio to
> current task. This makes it possible that kthread dispatches bios on
> behalf of other threads.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
