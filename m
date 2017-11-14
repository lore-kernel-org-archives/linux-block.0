Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 14 Nov 2017 13:03:26 -0800
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Kernel-team@fb.com
Subject: Re: [PATCH] blkcg: correctly update stat
Message-ID: <20171114210326.GS983427@devbig577.frc2.facebook.com>
References: <2fefc7364715a5c7d928fd02e4edeb7f80633c7f.1510682654.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2fefc7364715a5c7d928fd02e4edeb7f80633c7f.1510682654.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 14, 2017 at 10:05:07AM -0800, Shaohua Li wrote:
> blkcg_bio_issue_check() checks throtl for stat update, which isn't good
> because the bio could be splitted into small bios, the samll bios go
> into blkcg_bio_issue_check again and we update stat for the small bios,
> so we the stat is double charged. To fix this, we only update stat if
> the bio doesn't have BIO_THROTTLED flag. The fix will update stat ahead
> of bio skips from blk-throttle, but eventually the stat is correct.
> 
> This patch is on top of patch:
> https://marc.info/?l=linux-block&m=151060860608914&w=2
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
