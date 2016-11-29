Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755911AbcK2Sa4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2016 13:30:56 -0500
Date: Tue, 29 Nov 2016 10:30:44 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V4 13/15] blk-throttle: add a mechanism to estimate IO
 latency
Message-ID: <20161129183044.GB36738@shli-mbp.local>
References: <cover.1479161136.git.shli@fb.com>
 <9c75c9852b08404b90fbbdb143e81a8ef3b36abf.1479161136.git.shli@fb.com>
 <20161129172435.GA22330@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161129172435.GA22330@htj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 29, 2016 at 12:24:35PM -0500, Tejun Heo wrote:
> Hello, Shaohua.
> 
> On Mon, Nov 14, 2016 at 02:22:20PM -0800, Shaohua Li wrote:
> > To do this, we sample some data, eg, average latency for request size
> > 4k, 8k, 16k, 32k, 64k. We then use an equation f(x) = a * x + b to fit
> > the data (x is request size in KB, f(x) is the latency). Then we can use
> > the equation to estimate IO target latency for any request.
> 
> As discussed separately, it might make more sense to just use the avg
> of the closest bucket instead of trying to line-fit the buckets, but
> it's an implementation detail and whatever which works is fine.

that is still like a line fit. Don't think there is big difference.

> > Hard disk is completely different. Latency depends on spindle seek
> > instead of request size. So this latency target feature is for SSD only.
> 
> I'm not sure about this.  While a disk's latency profile is way higher
> and more erratic than SSDs, that doesn't make latency target useless.
> Sure, it'll be more crude but there's a significant difference between
> a cgroup having <= 20ms overall latency and experiencing multi-sec
> latency.

Sure, latency target is useful for hardisk too. But we need a different
stragety. For hard disk, the latency highly depends on seek. Probably we can
make the latency target the same for all request size. Not sure if average
latency makes sense. Need more tests with hard disk. I'd like to forcus on SSD
in current stage.

Thanks,
Shaohua
