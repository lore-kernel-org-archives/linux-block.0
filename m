Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34755 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758191AbcK2RYi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2016 12:24:38 -0500
Date: Tue, 29 Nov 2016 12:24:35 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 13/15] blk-throttle: add a mechanism to estimate IO
 latency
Message-ID: <20161129172435.GA22330@htj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <9c75c9852b08404b90fbbdb143e81a8ef3b36abf.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9c75c9852b08404b90fbbdb143e81a8ef3b36abf.1479161136.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Shaohua.

On Mon, Nov 14, 2016 at 02:22:20PM -0800, Shaohua Li wrote:
> To do this, we sample some data, eg, average latency for request size
> 4k, 8k, 16k, 32k, 64k. We then use an equation f(x) = a * x + b to fit
> the data (x is request size in KB, f(x) is the latency). Then we can use
> the equation to estimate IO target latency for any request.

As discussed separately, it might make more sense to just use the avg
of the closest bucket instead of trying to line-fit the buckets, but
it's an implementation detail and whatever which works is fine.

> Hard disk is completely different. Latency depends on spindle seek
> instead of request size. So this latency target feature is for SSD only.

I'm not sure about this.  While a disk's latency profile is way higher
and more erratic than SSDs, that doesn't make latency target useless.
Sure, it'll be more crude but there's a significant difference between
a cgroup having <= 20ms overall latency and experiencing multi-sec
latency.

Thanks.

-- 
tejun
