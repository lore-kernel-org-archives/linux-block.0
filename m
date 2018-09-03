Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:42407 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeICK3e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Sep 2018 06:29:34 -0400
Received: by mail-io0-f176.google.com with SMTP id n18-v6so15007850ioa.9
        for <linux-block@vger.kernel.org>; Sun, 02 Sep 2018 23:10:55 -0700 (PDT)
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com> <20180903021332.GA5481@ming.t460p>
In-Reply-To: <20180903021332.GA5481@ming.t460p>
MIME-Version: 1.0
Date: Mon, 3 Sep 2018 11:40:53 +0530
Message-ID: <6e187fdf263c80e95cf627f6b363cf8d@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To: Ming Lei <ming.lei@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> > It is not yet finalized, but it can be based on per sdev outstanding,
> > shost_busy etc.
> > We want to use special 16 reply queue for IO acceleration (these
queues are
> > working interrupt coalescing mode. This is a h/w feature)
>
> This part is very key to your approach, so I'd suggest to finalize it
> first. That said this way doesn't make sense if you can't figure out
> one doable approach to decide when to use the coalescing mode, and when
> to
> use the regular 72 reply queues.
This is almost finalized, but going through testing and may take some time
to review all the output.
At very high level -
If scsi device is Virtual Disk, it will count each physical disk for data
arm and required condition to use io acceleration (interrupt coalescing)
path is - outstanding for sdev should be more than 8 * data_arms. Using
this method we are not going to impact low latency intensive workload.

>
> If it is just for IO acceleration, why not always use the coalescing
mode?

Ming, we attempted all the possible approaches. Let me summarize.

If we use *all* interrupt coalescing, single worker and lower queue depth
profile is impacted and latency drop is seen upto 20%.

>
> >
> > >
> > > Frankly speaking, you may reuse the 72 reply queues to do interrupt
> > > coalescing by configuring one extra register to enable the
coalescing
> > > mode,
> > > and you may just use small part of the 72 reply queues under the
> > > interrupt coalescing mode.
> > Our h/w can set interrupt coalescing per 8 reply queues. So smallest
is 8.
> > If we choose to take 8 reply queue from existing 72 reply queue
(without
> > asking for extra reply queue), we still have  an issue on more numa
node
> > systems.  Example - in 8 numa node system each node will have only
*one*
> > reply queue for effective interrupt coalescing. (since irq subsystem
will
> > spread msix per numa).
> >
> > To keep things scalable we cherry picked few reply queues and wanted
them
> to
> > be out of cpu-msix mapping.
>
> I mean you can group the reply queues according to the queue's numa node
> info, given the mapping has been figured out there by genirq affinity
> code.

Not able to follow you.  I replied to Thomas on the same topic. Is that
reply clarifies or I am still missing ?

>
> >
> > >
> > > Or you can learn from SPDK to use one or small number of dedicated
cores
> > > or kernel threads to poll the interrupts from all reply queues, then
I
> > > guess you may benefit much compared with the extra 16 queue
approach.
> > Problem with polling -  It requires some steady completion, otherwise
> > prediction in driver gives different results on different profiles.
> > We attempted irq-poll and thread ISR based polling, but it has pros
and
> > cons. One of the key usage of method what we are trying is not to
impact
> > latency for lower QD workloads.
>
> Interrupt coalescing should effect latency too[1], or could you share
your
> idea how to use interrupt coalescing to address the latency issue?
>
> 	"Interrupt coalescing, also known as interrupt moderation,[1] is a
> 	technique in which events which would normally trigger a hardware
> interrupt
> 	are held back, either until a certain amount of work is pending,
or a
> 	timeout timer triggers."[1]
>
> [1] https://en.wikipedia.org/wiki/Interrupt_coalescing

That is correct. We are not going to use 100% interrupt coalescing to
avoid latency impact.  We will have two set of queues. You can consider
this as hybrid interrupt coalescing.
On 72 logical cpu case, we will allocate 88 (72 + 16) reply queues (msix
index). Only first 16 reply queue will be configured in interrupt
coalescing mode (This is special h/w feature.) and remaining 72 reply are
without any interrupt coalescing.  72 reply queue are 1:1 cpu-msix map and
16 reply queue are mapped to local numa node.

As explained above, per scsi device outstanding is a key factors to route
io to queues with interrupt coalescing vs regular queue (without interrupt
coalescing.)
Example -
If there are sync IO request per scsi device (one IO at a time), driver
will keep posting those IO to the queues without any interrupt coalescing.
If there are more than 8 outstanding io per scsi device, driver will post
those io to reply queues with interrupt coalescing. This particular group
of io will not have latency impact because coalescing depth are key
factors to flush the ios. There can be some corner cases of workload which
can theoretically possible to have latency impact, but having more scsi
devices doing active io submission will close that loop and we are not
suspecting those issue need any special treatment. In fact, this solution
is to provide reasonable latency + higher iops for most of the cases and
if there are some deployment which need tuning..it is still possible to
disable this feature.  We really want to deal with those scenario on case
by case bases (through firmware settings).


>
> > I posted RFC at
> > https://www.spinics.net/lists/linux-scsi/msg122874.html
> >
> > We have done extensive study and concluded to use interrupt coalescing
is
> > better if h/w can manage two different modes (coalescing on/off).
>
> Could you explain a bit why coalescing is better?

Actually we are doing hybrid coalescing. You are correct, we have no
single answer here, but there are pros and cons.
For such hybrid coalescing we need h/w support.

>
> In theory, interrupt coalescing is just to move the implementation into
> hardware. And the IO submitted from the same coalescing group is usually
> irrelevant. The same problem you found in polling should have been in
> coalescing too.

Coalescing either in software or hardware is best attempt mechanism and
there is no steady snapshot of submission and completion in both the case.

One of the problem with coalescing/polling in OS driver is - Irq-poll
works in interrupt context and waiting in polling consume more CPU because
driver should do some predictive loop. At the same time driver should quit
after some completion to give fairness to other devices.  Threaded
interrupt can resolve the cpu hogging issue, but we are moving our key
interrupt processing to threaded context so fairness will be compromised.
In case of threaded interrupt polling we may be impacted if interrupt of
other devices request the same cpu where threaded isr is running.  If
polling logic in driver does not work well on different systems, we are
going to see extra penalty of doing disable/enable interrupt call.  This
particular problem is not a concern if h/w does interrupt coalescing.

>
> >
> > >
> > > Introducing extra 16 queues just for interrupt coalescing and making
it
> > > coexisting with the regular 72 reply queues seems one very unusual
use
> > > case, not sure the current genirq affinity can support it well.
> >
> > Yes. This is unusual case. I think it is not used by any other
drivers.
> >
> > >
> > > > >
> > > > > >
> > > > > > All pre_vectors (16) will be mapped to all available online
CPUs but
> > > > > > e
> > > > > > ffective affinity of each vector is to CPU 0. Our requirement
is to
> > > > > > have pre _vectors 16 reply queues to be mapped to local NUMA
node
> > > with
> > > > > > effective CPU should be spread within local node cpu mask.
Without
> > > > > > changing kernel code, we can
> > > > >
> > > > > If all CPUs in one NUMA node is offline, can this use case work
as
> > > > expected?
> > > > > Seems we have to understand what the use case is and how it
works.
> > > >
> > > > Yes, if all CPUs of the NUMA node is offlined, IRQ-CPU affinity
will be
> > > > broken and irqbalancer takes care of migrating affected IRQs to
online
> > > > CPUs of different NUMA node.
> > > > When offline CPUs are onlined again, irqbalancer restores
affinity.
> > >
> > >  irqbalance daemon can't cover managed interrupts, or you mean
> > > you don't use pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY)?
> >
> > Yes. We did not used " pci_alloc_irq_vectors_affinity".
> > We used " pci_enable_msix_range" and manually set affinity in driver
using
> > irq_set_affinity_hint.
>
> Then you have to cover all kind of CPU hotplug issues in your driver
> because you switch to driver to maintain the queue mapping.
>
> Thanks,
> Ming
