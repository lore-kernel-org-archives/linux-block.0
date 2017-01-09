Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33148 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163113AbdAIRfa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 12:35:30 -0500
Date: Mon, 9 Jan 2017 12:35:18 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 04/17] blk-throttle: configure bps/iops limit for
 cgroup in low limit
Message-ID: <20170109173518.GF12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <04bae2f6239c13d3160d7c0196c97217c5e4b4c3.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <04bae2f6239c13d3160d7c0196c97217c5e4b4c3.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Thu, Dec 15, 2016 at 12:32:55PM -0800, Shaohua Li wrote:
> each queue will have a state machine. Initially queue is in LIMIT_LOW
> state, which means all cgroups will be throttled according to their low
> limit. After all cgroups with low limit cross the limit, the queue state
> gets upgraded to LIMIT_MAX state.

As with the previous patch, I don't think it's correct to default to
MAX for LIMIT_LOW and then enforce it.  Without specific
configuration, a cgroup should always be above below (so, no latency
requirement) and below max (no hard limiting).

Thanks.

-- 
tejun
