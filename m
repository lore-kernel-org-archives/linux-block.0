Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36491 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbcKVVmC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2016 16:42:02 -0500
Date: Tue, 22 Nov 2016 16:42:00 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 05/15] blk-throttle: add downgrade logic
Message-ID: <20161122214200.GE17534@htj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <d5670c98a3e4239202c4dad8f16add803a629f15.1479161136.git.shli@fb.com>
 <20161122212121.GC17534@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161122212121.GC17534@htj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Tue, Nov 22, 2016 at 04:21:21PM -0500, Tejun Heo wrote:
> 1. A cgroup and its high and max limits don't have much to do with
>    other cgroups and their limits.  I don't get how the choice between
>    high and max limits can be a td-wide state.

Ah, okay, this combines with idle cgroup detection to determine
whether the cgroups should be allowed to exceed high limits.  It makes
more sense to me now.  In that case, for the high/max limit range
issues, the enforced high/max limits can simply follow what's implied
by the configuration.  e.g. if high=100 max=80, just behave as if both
high and max are 80.

> 2. Comparing parent's and child's limits and saying that either can be
>    ignored because one is higher than the other isn't correct.  A
>    parent's limit doesn't apply to each child separately.  It has to
>    be aggregated.  e.g. you can ignore a parent's setting if the sum
>    of all children's limits is smaller than the parent's but then
>    again there could still be a lower limit higher up the tree, so
>    they would still have to be examined.

This part still seems weird tho.  What am I misunderstanding?

Thanks.

-- 
tejun
