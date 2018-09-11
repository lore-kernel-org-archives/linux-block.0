Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 11 Sep 2018 16:51:50 -0700
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] blkcg: remove additional reference to the css
Message-ID: <20180911235150.GD2966370@devbig004.ftw2.facebook.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
 <20180911184137.35897-10-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180911184137.35897-10-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 11, 2018 at 02:41:34PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> The previous patch in this series removed carrying around a pointer to
> the css in blkg. However, the blkg association logic still relied on
> taking a reference on the css to ensure we wouldn't fail in getting a
> reference for the blkg.
> 
> Here the implicit dependency on the css is removed. The association
> continues to rely on the tryget logic walking up the blkg tree. This
> streamlines the three ways that association can happen: normal, swap,
> and writeback.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
