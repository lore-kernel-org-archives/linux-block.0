Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:55392 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHaLAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 07:00:20 -0400
MIME-Version: 1.0
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
In-Reply-To: <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 31 Aug 2018 14:54:07 +0800
Message-ID: <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
Subject: Re: Affinity managed interrupts vs non-managed interrupts
To: sumit.saxena@broadcom.com
Cc: Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 29, 2018 at 6:47 PM Sumit Saxena <sumit.saxena@broadcom.com> wrote:
>
> > -----Original Message-----
> > From: Ming Lei [mailto:ming.lei@redhat.com]
> > Sent: Wednesday, August 29, 2018 2:16 PM
> > To: Sumit Saxena <sumit.saxena@broadcom.com>
> > Cc: tglx@linutronix.de; hch@lst.de; linux-kernel@vger.kernel.org
> > Subject: Re: Affinity managed interrupts vs non-managed interrupts
> >
> > Hello Sumit,
> Hi Ming,
> Thanks for response.
> >
> > On Tue, Aug 28, 2018 at 12:04:52PM +0530, Sumit Saxena wrote:
> > >  Affinity managed interrupts vs non-managed interrupts
> > >
> > > Hi Thomas,
> > >
> > > We are working on next generation MegaRAID product where requirement
> > > is- to allocate additional 16 MSI-x vectors in addition to number of
> > > MSI-x vectors megaraid_sas driver usually allocates.  MegaRAID adapter
> > > supports 128 MSI-x vectors.
> > >
> > > To explain the requirement and solution, consider that we have 2
> > > socket system (each socket having 36 logical CPUs). Current driver
> > > will allocate total 72 MSI-x vectors by calling API-
> > > pci_alloc_irq_vectors(with flag- PCI_IRQ_AFFINITY).  All 72 MSI-x
> > > vectors will have affinity across NUMA node s and interrupts are
> affinity
> > managed.
> > >
> > > If driver calls- pci_alloc_irq_vectors_affinity() with pre_vectors =
> > > 16 and, driver can allocate 16 + 72 MSI-x vectors.
> >
> > Could you explain a bit what the specific use case the extra 16 vectors
> is?
> We are trying to avoid the penalty due to one interrupt per IO completion
> and decided to coalesce interrupts on these extra 16 reply queues.
> For regular 72 reply queues, we will not coalesce interrupts as for low IO
> workload, interrupt coalescing may take more time due to less IO
> completions.
> In IO submission path, driver will decide which set of reply queues
> (either extra 16 reply queues or regular 72 reply queues) to be picked
> based on IO workload.

I am just wondering how you can make the decision about using extra
16 or regular 72 queues in submission path, could you share us a bit
your idea? How are you going to recognize the IO workload inside your
driver? Even the current block layer doesn't recognize IO workload, such
as random IO or sequential IO.

Frankly speaking, you may reuse the 72 reply queues to do interrupt
coalescing by configuring one extra register to enable the coalescing mode,
and you may just use small part of the 72 reply queues under the
interrupt coalescing mode.

Or you can learn from SPDK to use one or small number of dedicated cores
or kernel threads to poll the interrupts from all reply queues, then I
guess you may benefit much compared with the extra 16 queue approach.

Introducing extra 16 queues just for interrupt coalescing and making it
coexisting with the regular 72 reply queues seems one very unusual use
case, not sure the current genirq affinity can support it well.

> >
> > >
> > > All pre_vectors (16) will be mapped to all available online CPUs but e
> > > ffective affinity of each vector is to CPU 0. Our requirement is to
> > > have pre _vectors 16 reply queues to be mapped to local NUMA node with
> > > effective CPU should be spread within local node cpu mask. Without
> > > changing kernel code, we can
> >
> > If all CPUs in one NUMA node is offline, can this use case work as
> expected?
> > Seems we have to understand what the use case is and how it works.
>
> Yes, if all CPUs of the NUMA node is offlined, IRQ-CPU affinity will be
> broken and irqbalancer takes care of migrating affected IRQs to online
> CPUs of different NUMA node.
> When offline CPUs are onlined again, irqbalancer restores affinity.

 irqbalance daemon can't cover managed interrupts, or you mean
you don't use pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY)?

Thanks,
Ming Lei
