Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 7 Sep 2018 09:52:03 -0700
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] blkcg: fix ref count issue with bio_blkcg using
 task_css
Message-ID: <20180907165203.GA1100574@devbig004.ftw2.facebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-2-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906211045.29055-2-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 06, 2018 at 05:10:34PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> The accessor function bio_blkcg either returns the blkcg associated with
> the bio or finds one in the current context. This can cause an issue
> when trying to associate a bio with a blkcg. Particularly, it's the
> third case that is problematic:
> 
> 	return css_to_blkcg(task_css(current, io_cgrp_id));
> 
> As the above may race against task migration and the cgroup exiting, it
> is not always ok to take a reference on the blkcg returned from
> bio_blkcg.
> 
> This patch adds association ahead of calling bio_blkcg rather than
> after. This makes association a required and explicit step along the
> code paths for calling bio_blkcg. blk_get_rl is modified as well to get
> a reference to the blkcg it may use and blk_put_rl will always put the
> reference back. Association is also moved above the bio_blkcg call to
> ensure it will not return NULL in blk-iolatency.
> 
> BFQ and CFQ utilize this flaw, but due to the complexity, I do not want
> to address this in this series. I've created a private version of the
> function with notes not to use it describing the flaw. Hopefully soon,
> that code can be cleaned up.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
