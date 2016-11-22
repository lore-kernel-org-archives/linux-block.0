Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34562 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755837AbcKVUQp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2016 15:16:45 -0500
Date: Tue, 22 Nov 2016 15:16:43 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 03/15] blk-throttle: configure bps/iops limit for
 cgroup in high limit
Message-ID: <20161122201643.GB17534@htj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <7a4f1b1b0f67bb02d0caadae808c1a89413c202d.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7a4f1b1b0f67bb02d0caadae808c1a89413c202d.1479161136.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 14, 2016 at 02:22:10PM -0800, Shaohua Li wrote:
> each queue will have a state machine. Initially queue is in LIMIT_HIGH
> state, which means all cgroups will be throttled according to their high
> limit. After all cgroups with high limit cross the limit, the queue state
> gets upgraded to LIMIT_MAX state.
> cgroups without high limit will use max limit for their high limit.

Haven't looked at the actual mechanism yet so please correct me if I'm
getting it wrong but at least the above explanation reads incorrect.
Shouldn't max limits applied regardless of whether other cgroups are
above high or not?

Thanks.

-- 
tejun
