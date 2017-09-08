Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 8 Sep 2017 07:41:12 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 2/3] block: make blkcg aware of kthread stored original
 cgroup info
Message-ID: <20170908144112.GZ1774378@devbig577.frc2.facebook.com>
References: <cover.1504748195.git.shli@fb.com>
 <6855d580111c20a6f147f3beec00fb593873608d.1504748195.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6855d580111c20a6f147f3beec00fb593873608d.1504748195.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Sep 06, 2017 at 07:00:52PM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Several blkcg APIs are deprecated. After removing them, bio_blkcg is the
> only API to get cgroup info for a bio. If bio_blkcg finds current task
> is a kthread and has original css recorded, it will use the css instead
> of associating the bio to current task.

Can you please separate out removal of unused APIs from modifications
of existing ones?  The patch is a bit confusing to follow.

Thanks.

-- 
tejun
