Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:44194 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeICJxT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Sep 2018 05:53:19 -0400
Received: by mail-io0-f195.google.com with SMTP id 75-v6so14937891iou.11
        for <linux-block@vger.kernel.org>; Sun, 02 Sep 2018 22:34:46 -0700 (PDT)
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com> <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
 <486f94a563d63c4779498fe8829a546c@mail.gmail.com> <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
 <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com> <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
MIME-Version: 1.0
Date: Mon, 3 Sep 2018 11:04:44 +0530
Message-ID: <66256272c020be186becdd7a3f049302@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> On Fri, 31 Aug 2018, Kashyap Desai wrote:
> > > Ok. I misunderstood the whole thing a bit. So your real issue is
that you
> > > want to have reply queues which are instantaneous, the per cpu ones,
and
> > > then the extra 16 which do batching and are shared over a set of
CPUs,
> > > right?
> >
> > Yes that is correct.  Extra 16 or whatever should be shared over set
of
> > CPUs of *local* numa node of the PCI device.
>
> Why restricting it to the local NUMA node of the device? That doesn't
> really make sense if you queue lots of requests from CPUs on a different
> node.

Penalty of cross numa node is minimal with higher interrupt coalescing
used in h/w.  We see penalty of cross numa traffic for lower IOPs type
work load.
In this particular case we are taking care cross numa traffic via higher
interrupt coalescing.

>
> Why don't you spread these extra interrupts accross all nodes and keep
the
> locality for the request/reply?

I assuming you are refereeing spreading msix to all numa node the way
"pci_alloc_irq_vectors" does.

Having extra 16 reply queue spread across nodes will have negative impact.
Take example of 8 node system (total 128 logical cpus).
If  16 reply queue are spread across numa node, there will be total 8
logical cpu mapped to 1 reply queue (eventually one numa node will have
only 2 reply queue mapped).

Running IO from one numa node will only consume 2 reply queues.
Performance dropped drastically in such case.  This is typical problem
with cpu-msix mapping goes to N:1 where msix is less than online cpus.

Mapping extra 16 reply queue to local numa node will always make sure that
driver will round robin all 16 reply queue irrespective of originated cpu.
We validated this method sending IOs from remote node and did not observed
performance penalty.

>
> That also would allow to make them properly managed interrupts as you
> could
> shutdown the per node batching interrupts when all CPUs of that node are
> offlined and you'd avoid the whole affinity hint irq balancer hackery.

One more clarification -

I am using " for-4.19/block " and this particular patch "a0c9259
irq/matrix: Spread interrupts on allocation" is included.
I can see that 16 extra reply queues via pre_vectors are still assigned to
CPU 0 (effective affinity ).

irq 33, cpu list 0-71
irq 34, cpu list 0-71
irq 35, cpu list 0-71
irq 36, cpu list 0-71
irq 37, cpu list 0-71
irq 38, cpu list 0-71
irq 39, cpu list 0-71
irq 40, cpu list 0-71
irq 41, cpu list 0-71
irq 42, cpu list 0-71
irq 43, cpu list 0-71
irq 44, cpu list 0-71
irq 45, cpu list 0-71
irq 46, cpu list 0-71
irq 47, cpu list 0-71
irq 48, cpu list 0-71


# cat /sys/kernel/debug/irq/irqs/34
handler:  handle_edge_irq
device:   0000:86:00.0
status:   0x00004000
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x01608200
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_MOVE_PCNTXT
            IRQD_AFFINITY_MANAGED
node:     0
affinity: 0-71
effectiv: 0
pending:
domain:  INTEL-IR-MSI-1-2
 hwirq:   0x4300001
 chip:    IR-PCI-MSI
  flags:   0x10
             IRQCHIP_SKIP_SET_WAKE
 parent:
    domain:  INTEL-IR-1
     hwirq:   0x40000
     chip:    INTEL-IR
      flags:   0x0
     parent:
        domain:  VECTOR
         hwirq:   0x22
         chip:    APIC
          flags:   0x0
         Vector:    46
         Target:     0
         move_in_progress: 0
         is_managed:       1
         can_reserve:      0
         has_reserved:     0
         cleanup_pending:  0

#cat /sys/kernel/debug/irq/irqs/35
handler:  handle_edge_irq
device:   0000:86:00.0
status:   0x00004000
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x01608200
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_MOVE_PCNTXT
            IRQD_AFFINITY_MANAGED
node:     0
affinity: 0-71
effectiv: 0
pending:
domain:  INTEL-IR-MSI-1-2
 hwirq:   0x4300002
 chip:    IR-PCI-MSI
  flags:   0x10
             IRQCHIP_SKIP_SET_WAKE
 parent:
    domain:  INTEL-IR-1
     hwirq:   0x50000
     chip:    INTEL-IR
      flags:   0x0
     parent:
        domain:  VECTOR
         hwirq:   0x23
         chip:    APIC
          flags:   0x0
         Vector:    47
         Target:     0
         move_in_progress: 0
         is_managed:       1
         can_reserve:      0
         has_reserved:     0
         cleanup_pending:  0

Ideally, what we are looking for 16 extra pre_vector reply queue is
"effective affinity" to be within local numa node as long as that numa
node has online CPUs. If not, we are ok to have effective cpu from any
node.

>
> Thanks,
>
> 	tglx
>
>
