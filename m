Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5B6C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA98020851
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA98020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeKSVOn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:14:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:5004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbeKSVOn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 16:14:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C14E307D91A;
        Mon, 19 Nov 2018 10:51:28 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91D445D9CB;
        Mon, 19 Nov 2018 10:51:22 +0000 (UTC)
Date:   Mon, 19 Nov 2018 18:51:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V2 for-4.21 2/2] blk-mq: alloc q->queue_ctx as normal
 array
Message-ID: <20181119105117.GB18231@ming.t460p>
References: <20181116112311.4117-1-ming.lei@redhat.com>
 <20181116112311.4117-3-ming.lei@redhat.com>
 <20181116140623.GC4595@kroah.com>
 <20181117023417.GC8872@ming.t460p>
 <20181117100342.GB1482@kroah.com>
 <20181119020426.GB10838@ming.t460p>
 <20181119101749.GB20178@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119101749.GB20178@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 19 Nov 2018 10:51:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 11:17:49AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 19, 2018 at 10:04:27AM +0800, Ming Lei wrote:
> > On Sat, Nov 17, 2018 at 11:03:42AM +0100, Greg Kroah-Hartman wrote:
> > > On Sat, Nov 17, 2018 at 10:34:18AM +0800, Ming Lei wrote:
> > > > On Fri, Nov 16, 2018 at 06:06:23AM -0800, Greg Kroah-Hartman wrote:
> > > > > On Fri, Nov 16, 2018 at 07:23:11PM +0800, Ming Lei wrote:
> > > > > > Now q->queue_ctx is just one read-mostly table for query the
> > > > > > 'blk_mq_ctx' instance from one cpu index, it isn't necessary
> > > > > > to allocate it as percpu variable. One simple array may be
> > > > > > more efficient.
> > > > > 
> > > > > "may be", have you run benchmarks to be sure?  If so, can you add the
> > > > > results of them to this changelog?  If there is no measurable
> > > > > difference, then why make this change at all?
> > > > 
> > > > __blk_mq_get_ctx() is used in fast path, what do you think about which
> > > > one is more efficient?
> > > > 
> > > > - *per_cpu_ptr(q->queue_ctx, cpu);
> > > > 
> > > > - q->queue_ctx[cpu]
> > > 
> > > You need to actually test to see which one is faster, you might be
> > > surprised :)
> > > 
> > > In other words, do not just guess.
> > 
> > No performance difference is observed wrt. this patchset when I
> > run the following fio test on null_blk(modprobe null_blk) in my VM:
> > 
> > fio --direct=1 --size=128G --bsrange=4k-4k --runtime=40 --numjobs=32 \
> >   --ioengine=libaio --iodepth=64 --group_reporting=1 --filename=/dev/nullb0 \
> >   --name=null_blk-ttest-randread --rw=randread
> > 
> > Running test is important, but IMO it is more important to understand
> > the idea behind is correct, or the approach can be proved as correct.
> > 
> > Given the count of test cases can be increased exponentially when the related
> > factors or settings are covered, obviously we can't run all the test cases.
> 
> And what happens when you start to scale the number of queues and cpus
> in the system?

It is related with cpus.

> Does both options work the same?

This patch may introduce one extra memory read for getting one
'blk_mq_ctx' instance.

> Why did the original code have per-cpu variables?

Each instance of 'struct blk_mq_ctx' is actually percpu, so it is natural
to allocate it as one percpu variable.

However, there is the kobject lifetime issue if we allocate all 'blk_mq_ctx'
instances as one single percpu variable, because we can't release just one
part(for one cpu) of the single percpu variable.

So this patch converts the percpu variable into one loop-up table(read
only) and one 'blk_mq_ctx' instance for each CPU, and all the instances
are allocated from the local NUMA node of its CPU.

Another approach is to keep the percpu allocation, and introduces one
reference counter for counting how many active 'ctx' there are, and only
free the percpu variable when the ref drops zero, then we may save one
extra memory read for __blk_mq_get_ctx().


Thanks,
Ming
