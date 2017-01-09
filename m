Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36208 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936117AbdAIU4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 15:56:51 -0500
Date: Mon, 9 Jan 2017 15:56:43 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 11/17] blk-throttle: add a simple idle detection
Message-ID: <20170109205643.GP12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <b2a4b3d57a248e406a8687bbe2cce6f37c1b0749.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b2a4b3d57a248e406a8687bbe2cce6f37c1b0749.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Dec 15, 2016 at 12:33:02PM -0800, Shaohua Li wrote:
>  /* Throttling is performed over 100ms slice and after that slice is renewed */
>  #define DFL_THROTL_SLICE (HZ / 10)
>  #define MAX_THROTL_SLICE (HZ / 5)
> +#define DFL_IDLE_THRESHOLD_SSD (50 * 1000) /* 50 us */
> +#define DFL_IDLE_THRESHOLD_HD (1000 * 1000) /* 1 ms */
> +#define MAX_IDLE_TIME (500L * 1000 * 1000) /* 500 ms */

Hmm... why are we capping idle time so low?  This is a value to be
configured by userland.  Does it make sense to cap it this low?  Also,
wouldn't it make sense to start with higher default value given that
the user has to explicitly enable low limit for it to be effective and
thus explicitly requesting best effort latency target which will be
added later?

I'm really uncomfortable with pitting these two knobs against each
other in the similar time ranges.  It's really difficult tell what
latency target of 25us means and predict its behavior and when the
idle timeout is 50us.  It's fine if some people fiddle with them but
it'd be great if the defaults clearly indicate that they're operating
in mostly separate time scales.

Thanks.

-- 
tejun
