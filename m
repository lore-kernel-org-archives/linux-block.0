Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 11 Sep 2018 16:50:09 -0700
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] blkcg: convert blkg_lookup_create to find closest
 blkg
Message-ID: <20180911235009.GC2966370@devbig004.ftw2.facebook.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
 <20180911184137.35897-4-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180911184137.35897-4-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 11, 2018 at 02:41:28PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> There are several scenarios where blkg_lookup_create can fail. Examples
> include the blkcg dying, request_queue is dying, or simply being OOM. At
> the end of the day, most handle this by simply falling back to the
> q->root_blkg and calling it a day.
> 
> This patch implements the notion of closest blkg. During
> blkg_lookup_create, if it fails to create, return the closest blkg
> found or the q->root_blkg. blkg_try_get_closest is introduced and used
> during association so a bio is always attached to a blkg.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
