Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC60C18E7D
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 10:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D2E2070D
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 10:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfEVKCQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 06:02:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbfEVKCQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 06:02:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF29581E1D;
        Wed, 22 May 2019 10:02:00 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A10A2CF79;
        Wed, 22 May 2019 10:01:45 +0000 (UTC)
Date:   Wed, 22 May 2019 18:01:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU unplug
Message-ID: <20190522100139.GA16877@ming.t460p>
References: <20190517091424.19751-1-ming.lei@redhat.com>
 <6e1d3b66-aaed-4f6f-da34-92a633ff4b44@huawei.com>
 <20190522015620.GA11959@ming.t460p>
 <ce014369-4bf2-55fe-3c0f-3a46d3a016dc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce014369-4bf2-55fe-3c0f-3a46d3a016dc@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 22 May 2019 10:02:15 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 22, 2019 at 10:06:16AM +0100, John Garry wrote:
> > > > 
> > > > +static int blk_mq_hctx_notify_prepare(unsigned int cpu, struct hlist_node *node)
> > > > +{
> > > > +	struct blk_mq_hw_ctx	*hctx;
> > > > +	struct blk_mq_tags	*tags;
> > > > +
> > > > +	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> > > > +	tags = hctx->tags;
> > > > +
> > > > +	if (tags)
> > > > +		clear_bit(BLK_MQ_TAGS_DRAINED, &tags->flags);
> > > > +
> > > 
> > > Hi Ming,
> > > 
> > > Thanks for the effort here.
> > > 
> > > I would like to make an assertion on a related topic, which I hope you can
> > > comment on:
> > > 
> > > For this drain mechanism to work, the blk_mq_hw_ctx’s (and related cpu
> > > masks) for a request queue are required to match the hw queues used in the
> > > LLDD (if using managed interrupts).
> > > 
> > > In others words, a SCSI LLDD needs to expose all hw queues for this to work.
> > > 
> > > The reason I say this is because if the LLDD does not expose the hw queues
> > > and manages them internally - as some SCSI LLDDs do - yet uses managed
> > > interrupts to spread the hw queue MSI vectors across all CPUs, then we still
> > > only have a single blk_mq_hw_ctx per rq with a cpumask covering all cpus,
> > > which is not what we would want.
> > 
> 
> Hi Ming,
> 
> > Good catch!
> > 
> > This drain mechanism won't address the issue for these SCSI LLDDs in which:
> > 
> > 	1) blk_mq_hw_ctx serves as submission hw queue
> > 
> > 	2) one private reply queue serves as completion queue, for which one
> > 	MSI vector with cpumask is setup via pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY).
> > 
> > What we should only drain is the completion queue if all its mapped
> > CPUs are offline.
> > 
> > Looks you suggest to expose all completion(reply) queues as 'struct blk_mq_hw_ctx',
> > which may involve in another more hard problem:  how to split the single
> > hostwide tags into each reply queue.
> 
> Yes, and this is what I expecting to hear Re. hostwide tags.
> 
> I'd rather not work towards that
> > direction because:
> > 
> > 1) it is very hard to partition global resources into several parts,
> > especially it is hard to make every part happy.
> > 
> > 2) sbitmap is smart/efficient enough for this global allocation
> > 
> > 3) no obvious improvement is obtained from the resource partition, according
> > to previous experiment result done by Kashyap.
> 
> I'd like to also do the test.
> 
> However I would need to forward port the patchset, which no longer cleanly
> applies (I was referring to this https://lore.kernel.org/linux-block/20180205152035.15016-1-ming.lei@redhat.com/).
> Any help with that would be appreciated.

The queue type change causes patches not applied any more.

Could you just test the patch against v4.15 and see if there is any
improvement?

Even if it may improve performance on hisi_sas, I still suggest to not
use that approach to solve the issue for draining in-flight requests when
all CPUs of one hw queue becomes offline, since this way might hurt
performance on other drivers.

> 
> > 
> > I think we could implement the drain mechanism in the following way:
> > 
> > 1) if 'struct blk_mq_hw_ctx' serves as completion queue, use the
> > approach in the patch
> 
> Maybe the gain of exposing multiple queues+managed interrupts outweighs the
> loss in the LLDD of having to generate this unique tag with sbitmap; I know

The unique tag has zero cost, see blk_mq_unique_tag().

> that we did not use sbitmap ever in the LLDD for generating the tag when
> testing previously. However I'm still not too hopeful.
> 
> > 
> > 2) otherwise:
> > - introduce one callbcack of .prep_queue_dead(hctx, down_cpu) to
> > 'struct blk_mq_ops'
> 
> This would not be allowed to block, right?

It is allowed to block in CPU hotplug handler.

> 
> > 
> > - call .prep_queue_dead from blk_mq_hctx_notify_dead()
> > 
> > 3) inside .prep_queue_dead():
> > - the driver checks if all mapped CPU on the completion queue is offline
> > - if yes, wait for in-flight requests originated from all CPUs mapped to
> > this completion queue, and it can be implemented as one block layer API
> 
> That could work. However I think that someone may ask why the LLDD just
> doesn't register for the CPU hotplug event itself (which I would really
> rather avoid), instead of being relayed the info from the block layer.

.prep_queue_dead() is run from blk-mq's CPU hotplug handler.

I also think of abstracting completion queue in blk-mq for hpsa,
hisi_sas_v3_hw and  mpt3sas, but that can't cover to drain device's internal
command, so looks it is inevitable for us to introduce driver callback.


Thanks,
Ming
