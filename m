Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34737 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933381AbdAIVOH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 16:14:07 -0500
Date: Mon, 9 Jan 2017 16:14:04 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 14/17] blk-throttle: add interface for per-cgroup
 target latency
Message-ID: <20170109211404.GS12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <780b07f3e3163f5fbacaa32a4eb808e3b7940f2e.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <780b07f3e3163f5fbacaa32a4eb808e3b7940f2e.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Thu, Dec 15, 2016 at 12:33:05PM -0800, Shaohua Li wrote:
> @@ -438,6 +439,11 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
>  	}
>  	tg->idle_ttime_threshold = U64_MAX;
>  
> +	/*
> +	 * target latency default 0, eg, latency threshold is 0, which means
> +	 * cgroup's latency is always higher than threshold
> +	 */
> +
>  	return &tg->pd;
>  }

So, this is something which bothers me regarding the default settings.
I suspect the reason why the earlier patch went for tight idle time
was because we're setting default latency to zero, so to achieve good
utilization, the idle timeout must be shortened so that it neutralizes
the 0 latency target here.

I don't think this is a good default configuration.  Latency target
should be the mechanism which determines how shareable an active
cgroup which is under its low limit is.  That's the only thing it can
do anyway.  Idle time mechanism should serve a different purpose, not
an overlapping one.

If we want to default to latency guarantee, we can go for 0 latency
and a long idle timeout, even infinity.  If we want to default to good
utilization, we should pick a reasonable latency target (which is tied
to the device latency) with a reasonable idle timeout (which is tied
to how human perceives something to be idle).

Please note that it's kinda clear that we're misconfiguring it in the
previous patch in that we're altering idle timeout on device type.
Idle timeout is about the application behavior.  This isn't really
decided by request completion latency.  On the other hand, latency
target is the parameter which is device dependent.  The fact that it
was picking different idle time depending on device type means that
the roles of idle timeout and latency target are overlapping.  They
shouldn't.  It gets really confusing.

Thanks.

-- 
tejun
