Return-Path: <SRS0=t9QE=7D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F8C433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 02:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3D6206F6
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 02:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQwp7h6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgEUC6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 22:58:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726861AbgEUC6B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 22:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590029879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wYk1kQY9+pTZpuFHmtiHZ9rb+tj5wA0baIA0oghllHc=;
        b=gQwp7h6fnGPyvoFhlsGp26uy7lbs2MmoexMHbVYSE07VaBoUKWz8R+GEGyNDpypY4BgEri
        0L1y73D7e/3Y6Kr879upK6immKQmeRY7OTTVjYfonR5aszuJ3YaUowQKOK2rljBrAG238W
        8+r4wMAnytwmho/hMF57L/OOECHELJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-W55voAKfNHSSWVnAKsZLnA-1; Wed, 20 May 2020 22:57:57 -0400
X-MC-Unique: W55voAKfNHSSWVnAKsZLnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 467FE800688;
        Thu, 21 May 2020 02:57:56 +0000 (UTC)
Received: from T590 (ovpn-13-123.pek2.redhat.com [10.72.13.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6287C79597;
        Thu, 21 May 2020 02:57:49 +0000 (UTC)
Date:   Thu, 21 May 2020 10:57:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
Message-ID: <20200521025744.GC735749@T590>
References: <20200520170635.2094101-1-hch@lst.de>
 <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 20, 2020 at 02:46:52PM -0700, Bart Van Assche wrote:
> On 2020-05-20 10:06, Christoph Hellwig wrote:
> > this series ensures I/O is quiesced before a cpu and thus the managed
> > interrupt handler is shut down.
> > 
> > This patchset tries to address the issue by the following approach:
> > 
> >  - before the last cpu in hctx->cpumask is going to offline, mark this
> >    hctx as inactive
> > 
> >  - disable preempt during allocating tag for request, and after tag is
> >    allocated, check if this hctx is inactive. If yes, give up the
> >    allocation and try remote allocation from online CPUs
> > 
> >  - before hctx becomes inactive, drain all allocated requests on this
> >    hctx
> 
> What is not clear to me is which assumptions about the relationship
> between interrupts and hardware queues this patch series is based on.
> Does this patch series perhaps only support a 1:1 mapping between
> interrupts and hardware queues?

No, it supports any mapping, but the issue won't be triggered on 1:N
mapping, since this kind of hctx never becomes inactive.

> What if there are more hardware queues
> than interrupts? An example of a block driver that allocates multiple

It doesn't matter, see blew comment.

> hardware queues is the NVMeOF initiator driver. From the NVMeOF
> initiator driver function nvme_rdma_alloc_tagset() and for the code that
> refers to I/O queues:
> 
> 	set->nr_hw_queues = nctrl->queue_count - 1;
> 
> From nvme_rdma_alloc_io_queues():
> 
> 	nr_read_queues = min_t(unsigned int, ibdev->num_comp_vectors,
> 				min(opts->nr_io_queues,
> 				    num_online_cpus()));
> 	nr_default_queues =  min_t(unsigned int,
> 	 			ibdev->num_comp_vectors,
> 				min(opts->nr_write_queues,
> 					 num_online_cpus()));
> 	nr_poll_queues = min(opts->nr_poll_queues, num_online_cpus());
> 	nr_io_queues = nr_read_queues + nr_default_queues +
> 			 nr_poll_queues;
> 	[ ... ]
> 	ctrl->ctrl.queue_count = nr_io_queues + 1;
> 
> From nvmf_parse_options():
> 
> 	/* Set defaults */
> 	opts->nr_io_queues = num_online_cpus();
> 
> Can this e.g. result in 16 hardware queues being allocated for I/O even
> if the underlying RDMA adapter only supports four interrupt vectors?
> Does that mean that four hardware queues will be associated with each
> interrupt vector?

The patchset actually doesn't bind to interrupt vector, and that said we
don't care actuall interrupt allocation.

> If the CPU to which one of these interrupt vectors has
> been assigned is hotplugged, does that mean that four hardware queues
> have to be quiesced instead of only one as is done in patch 6/6?

No, one hctx only becomes inactive after each CPU in hctx->cpumask is offline.
No matter how interrupt vector is assigned to hctx, requests shouldn't
be dispatched to that hctx any more.


Thanks,
Ming

