Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34970 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755486AbcKWVRE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2016 16:17:04 -0500
Date: Wed, 23 Nov 2016 16:17:02 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 07/15] blk-throttle: make throtl_slice tunable
Message-ID: <20161123211702.GB11306@mtj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <24137f881a149d30b98ef040367f26378128d4d2.1479161136.git.shli@fb.com>
 <20161122212715.GD17534@htj.duckdns.org>
 <20161122231824.GC14628@shli-mbp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161122231824.GC14628@shli-mbp.local>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Tue, Nov 22, 2016 at 03:18:24PM -0800, Shaohua Li wrote:
> Hmm, it's not a real 'time slice'. The name is a bit confusion. Maybe rename it
> to 'throtl_interval' or 'throtl_sampling_time'? not sure. bandwidth and iops
> are always in terms of a time interval we measure them. We can't say the
> iops/bw for a single io. So this is really a tuable knob.

Yeah, maybe using a more indicative name is better.  However, even if
we say that this is the sampling period, it's not clear how adjusting
the knob would affect the behavior as that's not something clearly
defined in blk-throtl's operation model.  For contrast, compare it
with the latency target, the implemented behavior might not succeed to
follow the intended configuration perfectly but what the intention of
the configuration is clear regardless.

That said, if this needs to be a tunable knob, it's fine to have it,
but let's at least try to document what the effects of changing the
variable is.

Thanks.

-- 
tejun
