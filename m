Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1EBC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9547A20870
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIK9MJGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9547A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeKSUlB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeKSUlB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 15:41:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D277820851;
        Mon, 19 Nov 2018 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542622671;
        bh=BqHDvZSfLtp2rbCLClZpsPorl7AKQovWfnfoLygCfJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIK9MJGuN7QkwvpMqLAepkXK0GNyF43Vm5I97BUeDulteOsaS4QbtdgmVgabx73fK
         FFsH04L4vELwA5jXqcEATrdrHEc4aEWVdTu0Ll6n7TUOHXp/INhT9hO7dWbg+L3iM/
         u5AIxx4j6sj9jWoIQa9927kvIsI7Tu9YSh51t7jI=
Date:   Mon, 19 Nov 2018 11:17:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V2 for-4.21 2/2] blk-mq: alloc q->queue_ctx as normal
 array
Message-ID: <20181119101749.GB20178@kroah.com>
References: <20181116112311.4117-1-ming.lei@redhat.com>
 <20181116112311.4117-3-ming.lei@redhat.com>
 <20181116140623.GC4595@kroah.com>
 <20181117023417.GC8872@ming.t460p>
 <20181117100342.GB1482@kroah.com>
 <20181119020426.GB10838@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119020426.GB10838@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 10:04:27AM +0800, Ming Lei wrote:
> On Sat, Nov 17, 2018 at 11:03:42AM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Nov 17, 2018 at 10:34:18AM +0800, Ming Lei wrote:
> > > On Fri, Nov 16, 2018 at 06:06:23AM -0800, Greg Kroah-Hartman wrote:
> > > > On Fri, Nov 16, 2018 at 07:23:11PM +0800, Ming Lei wrote:
> > > > > Now q->queue_ctx is just one read-mostly table for query the
> > > > > 'blk_mq_ctx' instance from one cpu index, it isn't necessary
> > > > > to allocate it as percpu variable. One simple array may be
> > > > > more efficient.
> > > > 
> > > > "may be", have you run benchmarks to be sure?  If so, can you add the
> > > > results of them to this changelog?  If there is no measurable
> > > > difference, then why make this change at all?
> > > 
> > > __blk_mq_get_ctx() is used in fast path, what do you think about which
> > > one is more efficient?
> > > 
> > > - *per_cpu_ptr(q->queue_ctx, cpu);
> > > 
> > > - q->queue_ctx[cpu]
> > 
> > You need to actually test to see which one is faster, you might be
> > surprised :)
> > 
> > In other words, do not just guess.
> 
> No performance difference is observed wrt. this patchset when I
> run the following fio test on null_blk(modprobe null_blk) in my VM:
> 
> fio --direct=1 --size=128G --bsrange=4k-4k --runtime=40 --numjobs=32 \
>   --ioengine=libaio --iodepth=64 --group_reporting=1 --filename=/dev/nullb0 \
>   --name=null_blk-ttest-randread --rw=randread
> 
> Running test is important, but IMO it is more important to understand
> the idea behind is correct, or the approach can be proved as correct.
> 
> Given the count of test cases can be increased exponentially when the related
> factors or settings are covered, obviously we can't run all the test cases.

And what happens when you start to scale the number of queues and cpus
in the system?  Does both options work the same?  Why did the original
code have per-cpu variables?

Anyway, this isn't my subsystem, and it has nothing to do with kobjects,
so I really do not care.  My point is, do not make core changes like
this without really knowing the reason behind the original choice and at
least testing that your change does not break that reasoning.

good luck!

greg k-h
