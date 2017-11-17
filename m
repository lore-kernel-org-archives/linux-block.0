Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757699AbdKQT0Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Nov 2017 14:26:16 -0500
Date: Fri, 17 Nov 2017 11:26:14 -0800
From: Shaohua Li <shli@kernel.org>
To: Khazhismel Kumykov <khazhy@google.com>
Cc: axobe@kernel.dk, shli@fb.com, vgoyal@redhat.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] blk-throttle: add burst allowance.
Message-ID: <20171117192614.4knf72v26iir6tpi@kernel.org>
References: <20171114231022.42961-1-khazhy@google.com>
 <20171116165033.4noofd6gkaj6x3yl@kernel.org>
 <CACGdZY+OdN-yfTGFgd1qmXBn+z3OkKMX3FeCnwSdYVHj7HdQyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACGdZY+OdN-yfTGFgd1qmXBn+z3OkKMX3FeCnwSdYVHj7HdQyw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 16, 2017 at 08:25:58PM -0800, Khazhismel Kumykov wrote:
> On Thu, Nov 16, 2017 at 8:50 AM, Shaohua Li <shli@kernel.org> wrote:
> > On Tue, Nov 14, 2017 at 03:10:22PM -0800, Khazhismel Kumykov wrote:
> >> Allows configuration additional bytes or ios before a throttle is
> >> triggered.
> >>
> >> This allows implementation of a bucket style rate-limit/throttle on a
> >> block device. Previously, bursting to a device was limited to allowance
> >> granted in a single throtl_slice (similar to a bucket with limit N and
> >> refill rate N/slice).
> >>
> >> Additional parameters bytes/io_burst_conf defined for tg, which define a
> >> number of bytes/ios that must be depleted before throttling happens. A
> >> tg that does not deplete this allowance functions as though it has no
> >> configured limits. tgs earn additional allowance at rate defined by
> >> bps/iops for the tg. Once a tg has *_disp > *_burst_conf, throttling
> >> kicks in. If a tg is idle for a while, it will again have some burst
> >> allowance before it gets throttled again.
> >>
> >> slice_end for a tg is extended until io_disp/byte_disp would fall to 0,
> >> when all "used" burst allowance would be earned back. trim_slice still
> >> does progress slice_start as before and decrements *_disp as before, and
> >> tgs continue to get bytes/ios in throtl_slice intervals.
> >
> > Can you describe why we need this? It would be great if you can describe the
> > usage model and an example. Does this work for io.low/io.max or both?
> >
> > Thanks,
> > Shaohua
> >
> 
> Use case that brought this up was configuring limits for a remote
> shared device. Bursting beyond io.max is desired but only for so much
> before the limit kicks in, afterwards with sustained usage throughput
> is capped. (This proactively avoids remote-side limits). In that case
> one would configure in a root container io.max + io.burst, and
> configure low/other limits on descendants sharing the resource on the
> same node.
> 
> With this patch, so long as tg has not dispatched more than the burst,
> no limit is applied at all by that tg, including limit imposed by
> io.low in tg_iops_limit, etc.

I'd appreciate if you can give more details about the 'why'. 'configuring
limits for a remote shared device' doesn't justify the change.
