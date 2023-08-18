Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB96C7113C
	for <linux-block@archiver.kernel.org>; Fri, 18 Aug 2023 14:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbjHROAY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Aug 2023 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377779AbjHRN7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2023 09:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A53A420E
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2023 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692367132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pOUfdHMnG05j5uCs4vC0Zp9XVakVRZi3j6poFeSIlGQ=;
        b=HcJ2r9kwIOrLPyJlSQLOcpSBvvpWCmifentua9DGn61e25ebcnU1WRmU8cj/ZObiM20x79
        lWLEbDrSFJhGAU4/96Ok6JfhMuWL0Au9IcJdUEwTC7IqOy8y/lEZSb1wEZFPuCpPinIRvA
        zpmdJl+qRj8KeFSS+4v/3xz5jt/ERnM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-sMLec9EYM6SvPNB4yFmYgg-1; Fri, 18 Aug 2023 09:58:48 -0400
X-MC-Unique: sMLec9EYM6SvPNB4yFmYgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 784173811F4E;
        Fri, 18 Aug 2023 13:58:47 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C93482026D68;
        Fri, 18 Aug 2023 13:58:41 +0000 (UTC)
Date:   Fri, 18 Aug 2023 21:58:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>
Subject: Re: [PATCH V2] lib/group_cpus.c: avoid to acquire cpu hotplug lock
 in group_cpus_evenly
Message-ID: <ZN95DCe2Ipt2FW75@fedora>
References: <20230818015244.1176929-1-ming.lei@redhat.com>
 <a60de9ff-6dad-f243-6bd0-56810ef57c85@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a60de9ff-6dad-f243-6bd0-56810ef57c85@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 18, 2023 at 02:59:13PM +0800, Chengming Zhou wrote:
> Hi,
> 
> On 2023/8/18 09:52, Ming Lei wrote:
> > group_cpus_evenly() could be part of storage driver's error handler,
> > such as nvme driver, when may happen during CPU hotplug, in which
> > storage queue has to drain its pending IOs because all CPUs associated
> > with the queue are offline and the queue is becoming inactive. And
> > handling IO needs error handler to provide forward progress.
> > 
> > Then dead lock is caused:
> > 
> > 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> > handler is waiting for inflight IO
> > 
> > 2) error handler is waiting for CPU hotplug lock
> > 
> > 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> > error handling can't provide forward progress.
> > 
> > Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> > in which two stage spreads are taken: 1) the 1st stage is over all present
> > CPUs; 2) the end stage is over all other CPUs.
> > 
> > Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> > remove the CPU hotplug lock by storing it into one local cache. This way
> > doesn't change correctness, because all CPUs are still covered.
> > 
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: linux-nvme@lists.infradead.org
> > Cc: linux-block@vger.kernel.org
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Reported-by: Guangwu Zhang <guazhang@redhat.com>
> > Tested-by: Guangwu Zhang <guazhang@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V2:
> > 	- fix "Cc: block list"
> > 	- add tested-by tag
> > 
> >  lib/group_cpus.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > index aa3f6815bb12..15006e79196f 100644
> > --- a/lib/group_cpus.c
> > +++ b/lib/group_cpus.c
> > @@ -348,6 +348,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
> >  {
> >  	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
> >  	cpumask_var_t *node_to_cpumask;
> > +	cpumask_var_t local_cpu_present_mask;
> >  	cpumask_var_t nmsk, npresmsk;
> >  	int ret = -ENOMEM;
> >  	struct cpumask *masks = NULL;
> > @@ -355,6 +356,16 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
> >  	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
> >  		return NULL;
> >  
> > +	if (!zalloc_cpumask_var(&local_cpu_present_mask, GFP_KERNEL))
> > +		goto fail_local_pres_mask;
> > +
> > +	/*
> > +	 * Make a local cache of 'cpu_present_mask', so the two stages
> > +	 * spread can observe consistent 'cpu_present_mask' without holding
> > +	 * cpu hotplug lock.
> > +	 */
> > +	cpumask_copy(local_cpu_present_mask, cpu_present_mask);
> > +
> 
> Maybe we can reuse npresmsk instead of allocating another cpumask?
> In the first stage: npresmsk = cpu_present_mask
> In the second stage: npresmsk = cpu_possible_mask & ~npresmsk

Good idea!


Thanks, 
Ming

