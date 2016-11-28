Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38227 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754917AbcK1WOb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 17:14:31 -0500
Date: Mon, 28 Nov 2016 14:14:16 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V4 11/15] blk-throttle: add interface to configure think
 time threshold
Message-ID: <20161128221415.GA94530@shli-mbp.local>
References: <cover.1479161136.git.shli@fb.com>
 <52aae27038728bf0fd1b2b3b6536fcc28c9f2e6c.1479161136.git.shli@fb.com>
 <20161123213243.GD11306@mtj.duckdns.org>
 <20161124010629.GB4724@ksenks-mbp.dhcp.thefacebook.com>
 <20161128220818.GA12948@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161128220818.GA12948@htj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 28, 2016 at 05:08:18PM -0500, Tejun Heo wrote:
> Hello, Shaohua.
> 
> On Wed, Nov 23, 2016 at 05:06:30PM -0800, Shaohua Li wrote:
> > > Shouldn't this be a per-cgroup setting along with latency target?
> > > These two are the parameters which define how the cgroup should be
> > > treated time-wise.
> > 
> > It should be easy to make it per-cgroup. Just not sure if it should be
> > per-cgroup. The logic is if the disk is faster, wait time should be shorter to
> > not harm performance. So it sounds like a per-disk characteristic.
> 
> Yes, this is something dependent on the device, but also on the
> workload.  For both this parameter and the latency target, it seems
> that they should be specified along with the actual device limits so
> that they follow the same convention and can be specified per cgroup *
> block device.  What do you think?

That's ok, I'm totally fine to make it per cgroup and per disk.

Thanks,
Shaohua
