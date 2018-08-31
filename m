Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 31 Aug 2018 16:53:28 -0700
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] blkcg: associate writeback bios with a blkg
Message-ID: <20180831235328.GG1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-10-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831015356.69796-10-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 30, 2018 at 09:53:50PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> One of the goals of this series is to remove a separate reference to
> the css of the bio. This can and should be accessed via bio_blkcg. In
> this patch, the wbc_init_bio call is changed such that it must be called
> after a queue has been associated with the bio.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
