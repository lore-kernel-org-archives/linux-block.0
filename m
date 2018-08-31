Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 31 Aug 2018 16:47:59 -0700
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] blkcg: associate a blkg for pages being evicted by
 swap
Message-ID: <20180831234759.GF1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-9-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831015356.69796-9-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 30, 2018 at 09:53:49PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> A prior patch in this series added blkg association to bios issued by
> cgroups. There are two other paths that we want to attribute work back
> to the appropriate cgroup: swap and writeback. Here we modify the way
> swap tags bios to include the blkg. Writeback will be tackle in the next
> patch.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
