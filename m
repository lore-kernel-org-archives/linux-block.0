Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 12 May 2016 11:10:45 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, broonie@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH BUGFIX V4] block: add missing group association in
 bio-cloning functions
Message-ID: <20160512151045.GR4775@htj.duckdns.org>
References: <5732D47A.4090706@kyup.com>
 <1462958884-9457-1-git-send-email-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462958884-9457-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 11, 2016 at 11:28:04AM +0200, Paolo Valente wrote:
> When a bio is cloned, the newly created bio must be associated with
> the same blkcg as the original bio (if BLK_CGROUP is enabled). If
> this operation is not performed, then the new bio is not associated
> with any group, and the group of the current task is returned when
> the group of the bio is requested.
> 
> Depending on the cloning frequency, this may cause a large
> percentage of the bios belonging to a given group to be treated
> as if belonging to other groups (in most cases as if belonging to
> the root group). The expected group isolation may thereby be broken.
> 
> This commit adds the missing association in bio-cloning functions.
> 
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> Reviewed-by: Nikolay Borisov <kernel@kyup.com>

 Acked-by: Tejun Heo <tj@kernel.org>

It prolly should also have the following tags

Fixes: da2f0f74cf7d ("Btrfs: add support for blkio controllers")
Cc: stable@vger.kernel.org # v4.3+

Thanks.

-- 
tejun
