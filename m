Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35938 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932909AbcKWVq0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2016 16:46:26 -0500
Date: Wed, 23 Nov 2016 16:46:19 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 10/15] blk-throttle: add a simple idle detection
Message-ID: <20161123214619.GE11306@mtj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <ba2d677b381e94a2f6c4bf5108f4906c78e99d4f.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ba2d677b381e94a2f6c4bf5108f4906c78e99d4f.1479161136.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Shaohua.

On Mon, Nov 14, 2016 at 02:22:17PM -0800, Shaohua Li wrote:
> Unfortunately it's very hard to determine if a cgroup is real idle. This
> patch uses the 'think time check' idea from CFQ for the purpose. Please
> note, the idea doesn't work for all workloads. For example, a workload
> with io depth 8 has disk utilization 100%, hence think time is 0, eg,
> not idle. But the workload can run higher bandwidth with io depth 16.
> Compared to io depth 16, the io depth 8 workload is idle. We use the
> idea to roughly determine if a cgroup is idle.

Hmm... I'm not sure thinktime is the best measure here.  Think time is
used by cfq mainly to tell the likely future behavior of a workload so
that cfq can take speculative actions on the prediction.  However,
given that the implemented high limit behavior tries to provide a
certain level of latency target, using the predictive thinktime to
regulate behavior might lead to too unpredictable behaviors.

Moreover, I don't see why we need to bother with predictions anyway.
cfq needed it but I don't think that's the case for blk-throtl.  It
can just provide idle threshold where a cgroup which hasn't issued an
IO over that threshold is considered idle.  That'd be a lot easier to
understand and configure from userland while providing a good enough
mechanism to prevent idle cgroups from clamping down utilization for
too long.

Thanks.

-- 
tejun
