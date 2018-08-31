Return-Path: <linux-block-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:53267 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeIAAds (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 20:33:48 -0400
Date: Fri, 31 Aug 2018 22:24:37 +0200 (CEST)
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
In-Reply-To: <615d78004495aebc53807156d04d988c@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com> <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com> <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 31 Aug 2018, Kashyap Desai wrote:
> > From: Ming Lei [mailto:tom.leiming@gmail.com]
> > Sent: Friday, August 31, 2018 12:54 AM
> > To: sumit.saxena@broadcom.com
> > Cc: Ming Lei; Thomas Gleixner; Christoph Hellwig; Linux Kernel Mailing
> > List;
> > Kashyap Desai; shivasharan.srikanteshwara@broadcom.com; linux-block
> > Subject: Re: Affinity managed interrupts vs non-managed interrupts

Can you please teach your mail client NOT to insert the whole useless mail
header?

> > On Wed, Aug 29, 2018 at 6:47 PM Sumit Saxena
> > <sumit.saxena@broadcom.com> wrote:

> > > > > We are working on next generation MegaRAID product where
> > requirement
> > > > > is- to allocate additional 16 MSI-x vectors in addition to number of
> > > > > MSI-x vectors megaraid_sas driver usually allocates.  MegaRAID
> > > > > adapter
> > > > > supports 128 MSI-x vectors.
> > > > >
> > > > > To explain the requirement and solution, consider that we have 2
> > > > > socket system (each socket having 36 logical CPUs). Current driver
> > > > > will allocate total 72 MSI-x vectors by calling API-
> > > > > pci_alloc_irq_vectors(with flag- PCI_IRQ_AFFINITY).  All 72 MSI-x
> > > > > vectors will have affinity across NUMA node s and interrupts are
> > > affinity
> > > > managed.
> > > > >
> > > > > If driver calls- pci_alloc_irq_vectors_affinity() with pre_vectors =
> > > > > 16 and, driver can allocate 16 + 72 MSI-x vectors.
> > > >
> > > > Could you explain a bit what the specific use case the extra 16
> > > > vectors
> > > is?
> > > We are trying to avoid the penalty due to one interrupt per IO
> > > completion
> > > and decided to coalesce interrupts on these extra 16 reply queues.
> > > For regular 72 reply queues, we will not coalesce interrupts as for low
> > > IO
> > > workload, interrupt coalescing may take more time due to less IO
> > > completions.
> > > In IO submission path, driver will decide which set of reply queues
> > > (either extra 16 reply queues or regular 72 reply queues) to be picked
> > > based on IO workload.
> >
> > I am just wondering how you can make the decision about using extra
> > 16 or regular 72 queues in submission path, could you share us a bit
> > your idea? How are you going to recognize the IO workload inside your
> > driver? Even the current block layer doesn't recognize IO workload, such
> > as random IO or sequential IO.
> 
> It is not yet finalized, but it can be based on per sdev outstanding,
> shost_busy etc.
> We want to use special 16 reply queue for IO acceleration (these queues are
> working interrupt coalescing mode. This is a h/w feature)

TBH, this does not make any sense whatsoever. Why are you trying to have
extra interrupts for coalescing instead of doing the following:

1) Allocate 72 reply queues which get nicely spread out to every CPU on the
   system with affinity spreading.

2) Have a configuration for your reply queues which allows them to be
   grouped, e.g. by phsyical package.

3) Have a mechanism to mark a reply queue offline/online and handle that on
   CPU hotplug. That means on unplug you have to wait for the reply queue
   which is associated to the outgoing CPU to be empty and no new requests
   to be queued, which has to be done for the regular per CPU reply queues
   anyway.

4) On queueing the request, flag it 'coalescing' which causes the
   hard/firmware to direct the reply to the first online reply queue in the
   group.

If the last CPU of a group goes offline, then the normal hotplug mechanism
takes effect and the whole thing is put 'offline' as well. This works
nicely for all kind of scenarios even if you have more CPUs than queues. No
extras, no magic affinity hints, it just works.

Hmm?

> Yes. We did not used " pci_alloc_irq_vectors_affinity".
> We used " pci_enable_msix_range" and manually set affinity in driver using
> irq_set_affinity_hint.

I still regret the day when I merged that abomination.

Thanks,

	tglx
