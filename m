Return-Path: <linux-block-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:53407 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIAC62 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 22:58:28 -0400
Date: Sat, 1 Sep 2018 00:48:46 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kashyap Desai <kashyap.desai@broadcom.com>
cc: Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
In-Reply-To: <486f94a563d63c4779498fe8829a546c@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com> <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com> <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com> <615d78004495aebc53807156d04d988c@mail.gmail.com>
 <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de> <486f94a563d63c4779498fe8829a546c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 31 Aug 2018, Kashyap Desai wrote:
> > > It is not yet finalized, but it can be based on per sdev outstanding,
> > > shost_busy etc.
> > > We want to use special 16 reply queue for IO acceleration (these
> queues are
> > > working interrupt coalescing mode. This is a h/w feature)
> >
> > TBH, this does not make any sense whatsoever. Why are you trying to have
> > extra interrupts for coalescing instead of doing the following:
> 
> Thomas,
> 
> We are using this feature mainly for performance and not for CPU hotplug
> issues.
> I read your below #1 to #4 points are more of addressing CPU hotplug
> stuffs. Right ? If we use all 72 reply queue (all are in interrupt
> coalescing mode) without any extra reply queues, we don't have any issue
> with cpu-msix mapping and cpu hotplug issues.  Our major problem with
> that method is latency is very bad on lower QD and/or single worker case.
> 
> To solve that problem we have added extra 16 reply queue (this is a
> special h/w feature for performance only) which can be worked in interrupt
> coalescing mode vs existing 72 reply queue will work without any interrupt
> coalescing.   Best way to map additional 16 reply queue is map it to the
> local numa node.

Ok. I misunderstood the whole thing a bit. So your real issue is that you
want to have reply queues which are instantaneous, the per cpu ones, and
then the extra 16 which do batching and are shared over a set of CPUs,
right?

> I understand that, it is unique requirement but at the same time we may
> be able to do it gracefully (in irq sub system) as you mentioned "
> irq_set_affinity_hint" should be avoided in low level driver.

> Is it possible to have similar mapping in managed interrupt case as below
> ?
> 
>     for (i = 0; i < 16 ; i++)
>         irq_set_affinity_hint (pci_irq_vector(instance->pdev,
> cpumask_of_node(local_numa_node));
> 
> Currently we always see managed interrupts for pre-vectors are 0-71 and
> effective cpu is always 0.

The pre-vectors are not affinity managed. They get the default affinity
assigned and at request_irq() the vectors are dynamically spread over CPUs
to avoid that the bulk of interrupts ends up on CPU0. That's handled that
way since a0c9259dc4e1 ("irq/matrix: Spread interrupts on allocation")

> We want some changes in current API which can allow us to  pass flags
> (like *local numa affinity*) and cpu-msix mapping are from local numa node
> + effective cpu are spread across local numa node.

What you really want is to split the vector space for your device into two
blocks. One for the regular per cpu queues and the other (16 or how many
ever) which are managed separately, i.e. spread out evenly. That needs some
extensions to the core allocation/management code, but that shouldn't be a
huge problem.

Thanks,

	tglx
