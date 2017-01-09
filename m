Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36432 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdAIUNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 15:13:12 -0500
Date: Mon, 9 Jan 2017 15:13:05 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 09/17] blk-throttle: detect completed idle cgroup
Message-ID: <20170109201305.GM12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <9c3254d92f47a5172e83fc1e84c09fca8243a1e7.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9c3254d92f47a5172e83fc1e84c09fca8243a1e7.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Thu, Dec 15, 2016 at 12:33:00PM -0800, Shaohua Li wrote:
> @@ -1660,6 +1671,11 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
>  	struct throtl_data *td = tg->td;
>  	unsigned long now = jiffies;
>  
> +	if (time_after_eq(now, tg->last_dispatch_time[READ] +
> +					td->throtl_slice) &&
> +	    time_after_eq(now, tg->last_dispatch_time[WRITE] +
> +					td->throtl_slice))
> +		return false;

So, the duration used here is gonna be made explicitly configurable by
a future patch, right?  Might be worthwhile to note that in the
description.

Thanks.

-- 
tejun
