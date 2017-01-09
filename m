Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36580 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764067AbdAIUIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 15:08:50 -0500
Date: Mon, 9 Jan 2017 15:08:43 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 08/17] blk-throttle: make throtl_slice tunable
Message-ID: <20170109200843.GL12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <3341ed56034ecbcdaaaa63a87345ea7f16178339.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3341ed56034ecbcdaaaa63a87345ea7f16178339.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Thu, Dec 15, 2016 at 12:32:59PM -0800, Shaohua Li wrote:
> throtl_slice is important for blk-throttling. It's called slice
> internally but it really is a time window blk-throttling samples data.
> blk-throttling will make decision based on the samplings. An example is
> bandwidth measurement. A cgroup's bandwidth is measured in the time
> interval of throtl_slice.
> 
> A small throtl_slice meanse cgroups have smoother throughput but burn
> more CPUs. It has 100ms default value, which is not appropriate for all
> disks. A fast SSD can dispatch a lot of IOs in 100ms. This patch makes
> it tunable.
> 
> Since throtl_slice isn't a time slice, the sysfs name
> 'throttle_sample_time' reflects its character better.

Generally looks good.  I think some documentation would be great.
Also, do we wannt set it to a lower number if blk_queue_nonrot()?

Thanks.

-- 
tejun
