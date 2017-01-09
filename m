Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35765 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969914AbdAITyO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 14:54:14 -0500
Date: Mon, 9 Jan 2017 14:54:07 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 07/17] blk-throttle: make sure expire time isn't too
 big
Message-ID: <20170109195407.GJ12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <977d7661612aa15e1647690dd2d450ab5e3db1a6.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <977d7661612aa15e1647690dd2d450ab5e3db1a6.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Dec 15, 2016 at 12:32:58PM -0800, Shaohua Li wrote:
> cgroup could be throttled to a limit but when all cgroups cross high
> limit, queue enters a higher state and so the group should be throttled
> to a higher limit. It's possible the cgroup is sleeping because of
> throttle and other cgroups don't dispatch IO any more. In this case,
> nobody can trigger current downgrade/upgrade logic. To fix this issue,
> we could either set up a timer to wakeup the cgroup if other cgroups are
> idle or make sure this cgroup doesn't sleep too long. Setting up a timer
> means we must change the timer very frequently. This patch chooses the
> latter. Making cgroup sleep time not too big wouldn't change cgroup
> bps/iops, but could make it wakeup more frequently, which isn't a big
> issue because throtl_slice * 8 is already quite big.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  block/blk-throttle.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 0f65fce..41ec72c 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -588,6 +588,10 @@ static void throtl_dequeue_tg(struct throtl_grp *tg)
>  static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
>  					  unsigned long expires)
>  {
> +	unsigned long max_expire = jiffies + 8 * throtl_slice;
> +
> +	if (time_after(expires, max_expire))
> +		expires = max_expire;

A comment explaining why we need this would be nice.

Thanks.

-- 
tejun
