Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:53262 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdJRNTV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2017 09:19:21 -0400
Received: by mail-qk0-f170.google.com with SMTP id y23so6130985qkb.10
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2017 06:19:21 -0700 (PDT)
Date: Wed, 18 Oct 2017 06:19:18 -0700
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        Luca Miccio <lucmiccio@gmail.com>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
Message-ID: <20171018131918.GB1302522@devbig577.frc2.facebook.com>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Paolo.

On Tue, Oct 17, 2017 at 12:11:01PM +0200, Paolo Valente wrote:
...
> protected by a per-device scheduler lock.  To give you an idea, on an
> Intel i7-4850HQ, and with 8 threads doing random I/O in parallel on
> null_blk (configured with 0 latency), if the update of groups stats is
> removed, then the throughput grows from 260 to 404 KIOPS.  This and
> all the other results we might share in this thread can be reproduced
> very easily with a (useful) script made by Luca Miccio [1].

I don't think the old request_queue is ever built for multiple CPUs
hitting on a mem-backed device.

> We tried to understand the reason for this high overhead, and, in
> particular, to find out whether whether there was some issue that we
> could address on our own.  But the causes seem somehow substantial:
> one of the most time-consuming operations needed by some blkg_*stats_*
> functions is, e.g., find_next_bit, for which we don't see any trivial
> replacement.

Can you point to the specific ones?  I can't find find_next_bit usages
in generic blkg code.

> So, as a first attempt to reduce this severe slowdown, we have made a
> patch that moves the invocation of blkg_*stats_* functions outside the
> critical sections protected by the bfq lock.  Still, these functions
> apparently need to be protected with the request_queue lock, because

blkgs are already protected with RCU, so RCU protection should be
enough.

Thanks.

-- 
tejun
