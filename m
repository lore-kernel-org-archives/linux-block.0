Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6720C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 00:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C722261555
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 00:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346986AbhI3AG7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 20:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231238AbhI3AG6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 20:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632960316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FKM4FZ1+Sj46EyvkXnp0WenJowC0Gqd7KS8Hczjzp7Y=;
        b=ZRHGmZVzoxzVkIcogmPbxz4ls8H6RypXHZJWyd9MJndBJVEgf5aCZJBO5CT13vLoROOVuz
        z0WPsK6GTCsVugjhFUsKa5pnbbz8cVY9jeahViFuWEk0vSwWumk8MDtC5CxwF90p2qzCE3
        x1yIbsMODkMldr4gJU4L3eyFMe7Sou0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21--4yjIENIP-yx6NUtRe2ZPw-1; Wed, 29 Sep 2021 20:05:12 -0400
X-MC-Unique: -4yjIENIP-yx6NUtRe2ZPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE7BD801E72;
        Thu, 30 Sep 2021 00:05:10 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72A786A8E7;
        Thu, 30 Sep 2021 00:05:06 +0000 (UTC)
Date:   Thu, 30 Sep 2021 08:05:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 5/7] genirq/affinity: move group_cpus_evenly() into
 lib/
Message-ID: <YVT/Lki9OaRa8OCR@T590>
References: <20210928005558.243352-1-ming.lei@redhat.com>
 <20210928005558.243352-6-ming.lei@redhat.com>
 <74bcc75e-0b68-1d6b-b7f6-4681ec754257@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74bcc75e-0b68-1d6b-b7f6-4681ec754257@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29, 2021 at 03:40:44PM +0100, John Garry wrote:
> 
> > +/**
> > + * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
> > + * @numgrps: number of groups
> > + *
> > + * Return: cpumask array if successful, NULL otherwise. And each element
> > + * includes CPUs assigned to this group
> > + *
> > + * Try to put close CPUs from viewpoint of CPU and NUMA locality into
> > + * same group, and run two-stage grouping:
> > + *	1) allocate present CPUs on these groups evenly first
> > + *	2) allocate other possible CPUs on these groups evenly
> > + *
> > + * We guarantee in the resulted grouping that all CPUs are covered, and
> > + * no same CPU is assigned to different groups
> 
> nit: I'd have "no same CPU is assigned to multiple groups"

OK

> 
> > + */
> > +struct cpumask *group_cpus_evenly(unsigned int numgrps)
> 
> nit: The name group_cpus_evenly() would imply an action on some cpus, when
> it's just calculating some masks - I think "masks" should be at least
> included in the name

Naming is always the hard part in reviewing, I think cpu is more
readable, maybe group_all_cpus_evenly()?

> 
> > +{
> > +	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
> > +	cpumask_var_t *node_to_cpumask;
> > +	cpumask_var_t nmsk, npresmsk;
> > +	int ret = -ENOMEM;
> > +	struct cpumask *masks = NULL;
> > +
> > +	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
> > +		return NULL;
> > +
> > +	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
> > +		goto fail_nmsk;
> > +
> > +	node_to_cpumask = alloc_node_to_cpumask();
> > +	if (!node_to_cpumask)
> > +		goto fail_npresmsk;
> > +
> > +	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
> > +	if (!masks)
> > +		goto fail_node_to_cpumask;
> > +
> > +	/* Stabilize the cpumasks */
> > +	cpus_read_lock();
> > +	build_node_to_cpumask(node_to_cpumask);
> > +
> > +	/* grouping present CPUs first */
> > +	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> > +				  cpu_present_mask, nmsk, masks);
> > +	if (ret < 0)
> > +		goto fail_build_affinity;
> > +	nr_present = ret;
> > +
> > +	/*
> > +	 * Allocate non present CPUs starting from the next group to be
> > +	 * handled. If the grouping of present CPUs already exhausted the
> > +	 * group space, assign the non present CPUs to the already
> > +	 * allocated out groups.
> > +	 */
> > +	if (nr_present >= numgrps)
> > +		curgrp = 0;
> > +	else
> > +		curgrp = nr_present;
> > +	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> > +	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> > +				  npresmsk, nmsk, masks);
> > +	if (ret >= 0)
> > +		nr_others = ret;
> > +
> > + fail_build_affinity:
> 
> nit: Strange that success path goes through "fail" labels. Current code is
> this way, so feel free to ignore.

I'd rather not change current behavior in this patches.

> 
> > +	cpus_read_unlock();
> > +
> > +	if (ret >= 0)
> > +		WARN_ON(nr_present + nr_others < numgrps);
> > +
> > + fail_node_to_cpumask:
> > +	free_node_to_cpumask(node_to_cpumask);
> > +
> > + fail_npresmsk:
> > +	free_cpumask_var(npresmsk);
> > +
> > + fail_nmsk:
> > +	free_cpumask_var(nmsk);
> > +	if (ret < 0) {
> > +		kfree(masks);
> > +		return NULL;
> > +	}
> > +	return masks;
> > +}
> > +EXPORT_SYMBOL_GPL(group_cpus_evenly);
> 
> Are there any users which are available as modules? As I see, the only users
> are blk-mq-cpumap.c and irq/affinity.c, which I guess aren't available as
> modules.

Yeah, so far only two built-in users, I think it is fine to start with
not exporting the symbols, will change to this way in next version.


Thanks, 
Ming

