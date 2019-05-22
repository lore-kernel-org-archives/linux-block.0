Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E15C18E7D
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 10:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA62217D9
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 10:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfEVKbq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 06:31:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfEVKbp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 06:31:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2A103082E42;
        Wed, 22 May 2019 10:31:44 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F4F580C4;
        Wed, 22 May 2019 10:31:33 +0000 (UTC)
Date:   Wed, 22 May 2019 18:31:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU unplug
Message-ID: <20190522103127.GB16877@ming.t460p>
References: <20190517091424.19751-1-ming.lei@redhat.com>
 <6e1d3b66-aaed-4f6f-da34-92a633ff4b44@huawei.com>
 <20190522015620.GA11959@ming.t460p>
 <ce014369-4bf2-55fe-3c0f-3a46d3a016dc@huawei.com>
 <1deeda32-eac2-9056-f17b-3a643e671374@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1deeda32-eac2-9056-f17b-3a643e671374@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 22 May 2019 10:31:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hannes,

On Wed, May 22, 2019 at 11:47:49AM +0200, Hannes Reinecke wrote:
> On 5/22/19 11:06 AM, John Garry wrote:
> > > > > 
> > > > > +static int blk_mq_hctx_notify_prepare(unsigned int cpu,
> > > > > struct hlist_node *node)
> > > > > +{
> > > > > +    struct blk_mq_hw_ctx    *hctx;
> > > > > +    struct blk_mq_tags    *tags;
> > > > > +
> > > > > +    hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> > > > > +    tags = hctx->tags;
> > > > > +
> > > > > +    if (tags)
> > > > > +        clear_bit(BLK_MQ_TAGS_DRAINED, &tags->flags);
> > > > > +
> > > > 
> > > > Hi Ming,
> > > > 
> > > > Thanks for the effort here.
> > > > 
> > > > I would like to make an assertion on a related topic, which I
> > > > hope you can
> > > > comment on:
> > > > 
> > > > For this drain mechanism to work, the blk_mq_hw_ctx’s (and related cpu
> > > > masks) for a request queue are required to match the hw queues
> > > > used in the
> > > > LLDD (if using managed interrupts).
> > > > 
> > > > In others words, a SCSI LLDD needs to expose all hw queues for
> > > > this to work.
> > > > 
> More importantly, the SCSI LLDD needs to be _able_ to expose one hw queue
> per CPU.
> Which cannot be taken for granted; especially in larger machines it's
> relatively easy to have more CPUs than MSI-X vectores...
> 
> > > > The reason I say this is because if the LLDD does not expose the
> > > > hw queues
> > > > and manages them internally - as some SCSI LLDDs do - yet uses managed
> > > > interrupts to spread the hw queue MSI vectors across all CPUs,
> > > > then we still
> > > > only have a single blk_mq_hw_ctx per rq with a cpumask covering
> > > > all cpus,
> > > > which is not what we would want.
> > > 
> > 
> > Hi Ming,
> > 
> > > Good catch!
> > > 
> > > This drain mechanism won't address the issue for these SCSI LLDDs in
> > > which:
> > > 
> > >     1) blk_mq_hw_ctx serves as submission hw queue
> > > 
> > >     2) one private reply queue serves as completion queue, for which one
> > >     MSI vector with cpumask is setup via
> > > pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY).
> > > 
> > > What we should only drain is the completion queue if all its mapped
> > > CPUs are offline.
> > > 
> Hmm. That's a very unusual setup. Typically it's the other way round; SCSI
> LLDDs have several completion queues (as these are mapped to MSI-X vectors),
> but only one submission queue.
> (Classical examples are mptsas, megaraid_sas, aacraid, and hpsa)

Right, that is exactly what we are discussing, one instance of
blk_mq_hw_ctx, and lots of reply queue, each reply queue is mapped to
one MSI-X vector.

> 
> But I still do think we need to handle this case; the HBA might not expose
> enough MSI-X vectors/hw queues for us to map to all CPUs.
> In which case we'd be running into the same situation.

PCI_IRQ_AFFINITY guarantees that all possible CPUs are covered no matter
how many MSI-X vectors there are.

> 
> And I do think we _need_ to drain the associated completion queue as soon as
> _any_ CPU in that set it plugged; otherwise we can't ensure that any
> interrupt for pending I/O will _not_ arrive at the dead CPU.

The genirq code supposes to handle the case well if there is at least
one CPU available for handling the managed IRQ.

However, if it can't, the approach I suggested can cover this case well,
given driver can drain any request, included internal commands which
is sent via the reply queue.

> 
> And yes, this would amount to quiesce the HBA completely if only one queue
> is exposed. But there's no way around this; the alternative would be to code
> a fallback patch in each driver to catch missing completions.
> Which would actually be an interface change, requiring each vendor /
> maintainer to change their driver. Not very nice.

We still can solve the issue by exposing one submission queue(hctx) like the
current code.

Driver can drain requests in the introduced callback of .prep_queue_dead().

> 
> > > Looks you suggest to expose all completion(reply) queues as 'struct
> > > blk_mq_hw_ctx',
> > > which may involve in another more hard problem:  how to split the single
> > > hostwide tags into each reply queue.
> > 
> > Yes, and this is what I expecting to hear Re. hostwide tags.
> > 
> But this case is handled already; things like lpfc and qla2xxx have been
> converted to this model (exposing all hw queues, and use a host-wide
> tagmap).

I remember that the performance won't be good from your initial test
on this way.

https://marc.info/?t=149130779400002&r=1&w=2

I am just wondering how both lpfc or qla2xx share the hostwide tags
among all hctxs, given not see such code in blk-mq, could you explain
it a bit?

> 
> So from that side there is not really an issue.
> 
> I even provided patchset to convert megaraid_sas (cf 'megaraid_sas: enable
> blk-mq for fusion'); you might want to have a look there to see how it can
> be done.
> 
> > I'd rather not work towards that
> > > direction because:
> > > 
> > > 1) it is very hard to partition global resources into several parts,
> > > especially it is hard to make every part happy.
> > > 
> > > 2) sbitmap is smart/efficient enough for this global allocation
> > > 
> > > 3) no obvious improvement is obtained from the resource partition,
> > > according
> > > to previous experiment result done by Kashyap.
> > 
> > I'd like to also do the test.
> > 
> > However I would need to forward port the patchset, which no longer
> > cleanly applies (I was referring to this https://lore.kernel.org/linux-block/20180205152035.15016-1-ming.lei@redhat.com/).
> > Any help with that would be appreciated.
> > 
> If you would post it on the mailing list (or send it to me) I can have a
> look. Converting SAS is on my list of things to do, anyway.
> 
> > > 
> > > I think we could implement the drain mechanism in the following way:
> > > 
> > > 1) if 'struct blk_mq_hw_ctx' serves as completion queue, use the
> > > approach in the patch
> > 
> > Maybe the gain of exposing multiple queues+managed interrupts outweighs
> > the loss in the LLDD of having to generate this unique tag with sbitmap;
> > I know that we did not use sbitmap ever in the LLDD for generating the
> > tag when testing previously. However I'm still not too hopeful.
> > 
> Thing is, the tag _is_ already generated by the time the command is passed
> to the LLDD. So there is no overhead; you just need to establish a 1:1
> mapping between SCSI cmds from the midlayer and your internal commands.
> 
> Which is where the problem starts: if you have to use the same command pool
> for internal commands you have to set some tags aside to avoid a clash with
> the tags generated from the block layer.
> That's easily done, but if you do that quiescing is getting harder, as then
> the block layer wouldn't know about these internal commands.
> This is what I'm trying to address with my patchset to use private tags in
> SCSI, as then the block layer maintains all tags, and is able to figure out
> if the queue really is quiesced.
> (And I really need to post my patchset).
> 
> > > 
> > > 2) otherwise:
> > > - introduce one callbcack of .prep_queue_dead(hctx, down_cpu) to
> > > 'struct blk_mq_ops'
> > 
> > This would not be allowed to block, right?
> > 
> > > 
> > > - call .prep_queue_dead from blk_mq_hctx_notify_dead()
> > > 
> > > 3) inside .prep_queue_dead():
> > > - the driver checks if all mapped CPU on the completion queue is offline
> > > - if yes, wait for in-flight requests originated from all CPUs mapped to
> > > this completion queue, and it can be implemented as one block layer API
> > 
> > That could work. However I think that someone may ask why the LLDD just
> > doesn't register for the CPU hotplug event itself (which I would really
> > rather avoid), instead of being relayed the info from the block layer.
> > 
> Again; what would you do if not all CPUs from a pool are gone?
> You still might be getting interrupts for non-associated interrupts, and
> quite some drivers are unhappy under these circumstances.
> Hence I guess it'll be better to quiesce the queue as soon as _any_ CPU from
> the pool is gone.

Why? If there is CPU alive for the queue, the queue should work for
that CPU. 

Also if there is one CPU alive for the queue, you can't quiesce the
queue easily, given we have to allow the alive CPU to submit IO.

Also we can't use queue freeze in CPU hotplug handler, that may cause queue
dependency issue.

> 
> Plus we could be doing this from the block layer without any callbacks from
> the driver...

That depends if all drivers can avoid to send internal command via managed IRQ,
at least now, almost all hpsa, mpt3sas and hisi_sas may do that, cause
the reply queue is selected simply by passing 'raw_processor_id()'.

I am not sure if private tags can help on this issue, what we need to do
is to drain and in-flight requests(internal or io) from one reply queue(
MSI-X vector). That means private tags still have to deal with the reply
queue mapping.

Thanks,
Ming
