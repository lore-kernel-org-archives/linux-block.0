Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33723 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756139AbcK2RbK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2016 12:31:10 -0500
Date: Tue, 29 Nov 2016 12:31:08 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 15/15] blk-throttle: add latency target support
Message-ID: <20161129173108.GB22330@htj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <420a0f26dd7a20ad8316258c81cb64043134bc86.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <420a0f26dd7a20ad8316258c81cb64043134bc86.1479161136.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Mon, Nov 14, 2016 at 02:22:22PM -0800, Shaohua Li wrote:
> One hard problem adding .high limit is to detect idle cgroup. If one
> cgroup doesn't dispatch enough IO against its high limit, we must have a
> mechanism to determine if other cgroups dispatch more IO. We added the
> think time detection mechanism before, but it doesn't work for all
> workloads. Here we add a latency based approach.

As I wrote before, I think that the two mechanisms should operate on
two mostly separate aspects of io control - latency control for
arbitrating active cgroups and idle detection to count out cgroups
which are sitting doing nothing - instead of the two meachanisms
possibly competing.

>  static bool throtl_tg_is_idle(struct throtl_grp *tg)
>  {
> -	/* cgroup is idle if average think time is more than threshold */
> -	return ktime_get_ns() - tg->last_finish_time >
> +	/*
> +	 * cgroup is idle if:
> +	 * 1. average think time is higher than threshold
> +	 * 2. average request size is small and average latency is higher
                                                                   ^
								   lower, right?
> +	 *    than target
> +	 */

So, this looks like too much magic to me.  How would one configure for
a workload which may issue small IOs, say, every few seconds but
requries low latency?

Thanks.

-- 
tejun
