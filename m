Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32866 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763890AbdAITqE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 14:46:04 -0500
Date: Mon, 9 Jan 2017 14:46:00 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 05/17] blk-throttle: add upgrade logic for LIMIT_LOW
 state
Message-ID: <20170109194600.GI12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <75685643afd126cbccefe894ca56fd5dd83fe8cf.1481833017.git.shli@fb.com>
 <20170109184053.GG12827@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170109184053.GG12827@mtj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, again.

On Mon, Jan 09, 2017 at 01:40:53PM -0500, Tejun Heo wrote:
> I think it'd be great to explain the above.  It was a bit difficult
> for me to follow.  It's also interesting because we're tying state
> transitions for both read and write together.  blk-throtl has been
> handling reads and writes independently, now the mode switching from
> low to max is shared across reads and writes.  I suppose it could be
> fine but would it be complex to separate them out?  It's weird to make
> this one state shared across reads and writes while not for others or
> was this sharing intentional?

I thought more about it and as the low limit is regulated by latency,
it makes sense to make the state shared across reads and writes;
otherwise, IOs in one direction could easily mess up the other
direction.  Can you please document that this is an intentional design
and explain the rationale tho?

Thanks.

-- 
tejun
