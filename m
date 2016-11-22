Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34800 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933800AbcKVXSk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2016 18:18:40 -0500
Date: Tue, 22 Nov 2016 15:18:24 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V4 07/15] blk-throttle: make throtl_slice tunable
Message-ID: <20161122231824.GC14628@shli-mbp.local>
References: <cover.1479161136.git.shli@fb.com>
 <24137f881a149d30b98ef040367f26378128d4d2.1479161136.git.shli@fb.com>
 <20161122212715.GD17534@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161122212715.GD17534@htj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 22, 2016 at 04:27:15PM -0500, Tejun Heo wrote:
> Hello,
> 
> On Mon, Nov 14, 2016 at 02:22:14PM -0800, Shaohua Li wrote:
> > throtl_slice is important for blk-throttling. A lot of stuffes depend on
> > it, for example, throughput measurement. It has 100ms default value,
> > which is not appropriate for all disks. For example, for SSD we might
> > use a smaller value to make the throughput smoother. This patch makes it
> > tunable.
> 
> It bothers me a bit because time slice doesn't mean anything inherent
> to throttling.  It really is an implementation detail - throttling can
> be implemented at per-operation level without time slice involved at
> all.  It's okay to expose the knob if necessary but the meaning of the
> knob is almost completely arbitrary to users (as it has no inherent
> meaning).

Hmm, it's not a real 'time slice'. The name is a bit confusion. Maybe rename it
to 'throtl_interval' or 'throtl_sampling_time'? not sure. bandwidth and iops
are always in terms of a time interval we measure them. We can't say the
iops/bw for a single io. So this is really a tuable knob.

Thanks,
Shaohua
