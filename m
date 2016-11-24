Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54310 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S936467AbcKXBGo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2016 20:06:44 -0500
Date: Wed, 23 Nov 2016 17:06:30 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V4 11/15] blk-throttle: add interface to configure think
 time threshold
Message-ID: <20161124010629.GB4724@ksenks-mbp.dhcp.thefacebook.com>
References: <cover.1479161136.git.shli@fb.com>
 <52aae27038728bf0fd1b2b3b6536fcc28c9f2e6c.1479161136.git.shli@fb.com>
 <20161123213243.GD11306@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161123213243.GD11306@mtj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 23, 2016 at 04:32:43PM -0500, Tejun Heo wrote:
> On Mon, Nov 14, 2016 at 02:22:18PM -0800, Shaohua Li wrote:
> > Add interface to configure the threshold
> > 
> > Signed-off-by: Shaohua Li <shli@fb.com>
> > ---
> >  block/blk-sysfs.c    |  7 +++++++
> >  block/blk-throttle.c | 25 +++++++++++++++++++++++++
> >  block/blk.h          |  4 ++++
> >  3 files changed, 36 insertions(+)
> > 
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index 3e284e4..f15aeed 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -532,6 +532,12 @@ static struct queue_sysfs_entry throtl_slice_entry = {
> >  	.show = blk_throtl_slice_show,
> >  	.store = blk_throtl_slice_store,
> >  };
> > +
> > +static struct queue_sysfs_entry throtl_idle_threshold_entry = {
> > +	.attr = {.name = "throttling_idle_threshold", .mode = S_IRUGO | S_IWUSR },
> > +	.show = blk_throtl_idle_threshold_show,
> > +	.store = blk_throtl_idle_threshold_store,
> > +};
> 
> Shouldn't this be a per-cgroup setting along with latency target?
> These two are the parameters which define how the cgroup should be
> treated time-wise.

It should be easy to make it per-cgroup. Just not sure if it should be
per-cgroup. The logic is if the disk is faster, wait time should be shorter to
not harm performance. So it sounds like a per-disk characteristic.

Thanks,
Shaohua
