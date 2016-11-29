Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34130 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbcK2WgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2016 17:36:09 -0500
Date: Tue, 29 Nov 2016 17:36:07 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 13/15] blk-throttle: add a mechanism to estimate IO
 latency
Message-ID: <20161129223607.GB17732@htj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <9c75c9852b08404b90fbbdb143e81a8ef3b36abf.1479161136.git.shli@fb.com>
 <20161129172435.GA22330@htj.duckdns.org>
 <20161129183044.GB36738@shli-mbp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129183044.GB36738@shli-mbp.local>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Tue, Nov 29, 2016 at 10:30:44AM -0800, Shaohua Li wrote:
> > As discussed separately, it might make more sense to just use the avg
> > of the closest bucket instead of trying to line-fit the buckets, but
> > it's an implementation detail and whatever which works is fine.
> 
> that is still like a line fit. Don't think there is big difference.

Yeah, just wondering whether that'd be simpler.

> > > Hard disk is completely different. Latency depends on spindle seek
> > > instead of request size. So this latency target feature is for SSD only.
> > 
> > I'm not sure about this.  While a disk's latency profile is way higher
> > and more erratic than SSDs, that doesn't make latency target useless.
> > Sure, it'll be more crude but there's a significant difference between
> > a cgroup having <= 20ms overall latency and experiencing multi-sec
> > latency.
> 
> Sure, latency target is useful for hardisk too. But we need a different
> stragety. For hard disk, the latency highly depends on seek. Probably we can
> make the latency target the same for all request size. Not sure if average
> latency makes sense. Need more tests with hard disk. I'd like to forcus on SSD
> in current stage.

Sure, it's fine to focus on SSDs for now but with either line fitting
or bucketed avg, it should be fine, right?  The slope of the line
would be way lower and the deviation would be higher but that doesn't
really get in the way here.

Thanks.

-- 
tejun
