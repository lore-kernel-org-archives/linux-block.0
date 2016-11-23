Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32783 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932758AbcKWVcp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2016 16:32:45 -0500
Date: Wed, 23 Nov 2016 16:32:43 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 11/15] blk-throttle: add interface to configure think
 time threshold
Message-ID: <20161123213243.GD11306@mtj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <52aae27038728bf0fd1b2b3b6536fcc28c9f2e6c.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52aae27038728bf0fd1b2b3b6536fcc28c9f2e6c.1479161136.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 14, 2016 at 02:22:18PM -0800, Shaohua Li wrote:
> Add interface to configure the threshold
> 
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  block/blk-sysfs.c    |  7 +++++++
>  block/blk-throttle.c | 25 +++++++++++++++++++++++++
>  block/blk.h          |  4 ++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 3e284e4..f15aeed 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -532,6 +532,12 @@ static struct queue_sysfs_entry throtl_slice_entry = {
>  	.show = blk_throtl_slice_show,
>  	.store = blk_throtl_slice_store,
>  };
> +
> +static struct queue_sysfs_entry throtl_idle_threshold_entry = {
> +	.attr = {.name = "throttling_idle_threshold", .mode = S_IRUGO | S_IWUSR },
> +	.show = blk_throtl_idle_threshold_show,
> +	.store = blk_throtl_idle_threshold_store,
> +};

Shouldn't this be a per-cgroup setting along with latency target?
These two are the parameters which define how the cgroup should be
treated time-wise.

Thanks.

-- 
tejun
