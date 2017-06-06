Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43699 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751724AbdFFVMg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 17:12:36 -0400
Subject: Re: [PATCH] blk-throttle: set default latency baseline for harddisk
To: Shaohua Li <shli@kernel.org>, <linux-block@vger.kernel.org>
CC: <tj@kernel.org>, <Kernel-team@fb.com>, Shaohua Li <shli@fb.com>
References: <af8d351c4d0639b4df0dae777cc96944f52751c1.1496777767.git.shli@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <5c403cc9-fbfa-829e-f413-48fa503df6fb@fb.com>
Date: Tue, 6 Jun 2017 15:12:12 -0600
MIME-Version: 1.0
In-Reply-To: <af8d351c4d0639b4df0dae777cc96944f52751c1.1496777767.git.shli@fb.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/06/2017 01:40 PM, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> hard disk IO latency varies a lot depending on spindle move. The latency
> range could be from several microseconds to several milliseconds. It's
> pretty hard to get the baseline latency used by io.low.
> 
> We will use a different stragety here. The idea is only using IO with
> spindle move to determine if cgroup IO is in good state. For HD, if io
> latency is small (< 1ms), we ignore the IO. Such IO is likely from
> sequential IO, and is helpless to help determine if a cgroup's IO is
> impacted by other cgroups. With this, we only account IO with big
> latency. Then we can choose a hardcoded baseline latency for HD (4ms,
> which is typical IO latency with seek).  With all these settings, the
> io.low latency works for both HD and SSD.

I think that makes sense for reads - a quick read is certainly a cache
hit, due to a sequential IO hit. But what about for writes? Most are
absorbed by the write cache, so most will be < 1ms probably. Let's say
an app is doing random writes, the one write we do account will
potentially come at a much higher cost than the actual cost of that one
write. Simiarly for sequential writes, but the ratio of costs is closer
there.

Maybe that's OK?

-- 
Jens Axboe
