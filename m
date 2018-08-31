Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:54136 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIAB6o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 21:58:44 -0400
Received: by mail-it0-f52.google.com with SMTP id p79-v6so8964264itp.3
        for <linux-block@vger.kernel.org>; Fri, 31 Aug 2018 14:49:19 -0700 (PDT)
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com> <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
MIME-Version: 1.0
Date: Fri, 31 Aug 2018 15:49:17 -0600
Message-ID: <486f94a563d63c4779498fe8829a546c@mail.gmail.com>
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

> >
> > It is not yet finalized, but it can be based on per sdev outstanding,
> > shost_busy etc.
> > We want to use special 16 reply queue for IO acceleration (these
queues are
> > working interrupt coalescing mode. This is a h/w feature)
>
> TBH, this does not make any sense whatsoever. Why are you trying to have
> extra interrupts for coalescing instead of doing the following:

Thomas,

We are using this feature mainly for performance and not for CPU hotplug
issues.
I read your below #1 to #4  points are more of addressing CPU hotplug
stuffs. Right ?  We also want to make sure if we convert megaraid_sas
driver from managed to non-managed interrupt, we can still achieve CPU
hotplug requirement.  If we use " pci_enable_msix_range" and manually set
affinity in driver  using irq_set_affinity_hint, cpu hotplug feature works
as expected. <irqbalancer> is able to retain older mapping and whenever
offlined cpu comes back, irqbalancer restore the same old mapping.

If we use all 72 reply queue (all are in interrupt coalescing mode)
without any extra reply queues, we don't have any issue with cpu-msix
mapping and cpu hotplug issues.
Our major problem with that method is latency is very bad on lower QD
and/or single worker case.

To solve that problem we have added extra 16 reply queue (this is a
special h/w feature for performance only) which can be worked in interrupt
coalescing mode vs existing 72 reply queue will work without any interrupt
coalescing.   Best way to map additional 16 reply queue is map it to the
local numa node.

I understand that, it is unique requirement but at the same time we may be
able to do it gracefully (in irq sub system) as you mentioned  "
irq_set_affinity_hint" should be avoided in low level driver.



>
> 1) Allocate 72 reply queues which get nicely spread out to every CPU on
the
>    system with affinity spreading.
>
> 2) Have a configuration for your reply queues which allows them to be
>    grouped, e.g. by phsyical package.
>
> 3) Have a mechanism to mark a reply queue offline/online and handle that
on
>    CPU hotplug. That means on unplug you have to wait for the reply
queue
>    which is associated to the outgoing CPU to be empty and no new
requests
>    to be queued, which has to be done for the regular per CPU reply
queues
>    anyway.
>
> 4) On queueing the request, flag it 'coalescing' which causes the
>    hard/firmware to direct the reply to the first online reply queue in
the
>    group.
>
> If the last CPU of a group goes offline, then the normal hotplug
mechanism
> takes effect and the whole thing is put 'offline' as well. This works
> nicely for all kind of scenarios even if you have more CPUs than queues.
No
> extras, no magic affinity hints, it just works.
>
> Hmm?
>
> > Yes. We did not used " pci_alloc_irq_vectors_affinity".
> > We used " pci_enable_msix_range" and manually set affinity in driver
using
> > irq_set_affinity_hint.
>
> I still regret the day when I merged that abomination.

Is it possible to have similar mapping in managed interrupt case as below
?

    for (i = 0; i < 16 ; i++)
        irq_set_affinity_hint (pci_irq_vector(instance->pdev,
cpumask_of_node(local_numa_node));

Currently we always see managed interrupts for pre-vectors are 0-71 and
effective cpu is always 0.
We want some changes in current API which can allow us to  pass flags
(like *local numa affinity*) and cpu-msix mapping are from local numa node
+ effective cpu are spread across local numa node.

>
> Thanks,
>
> 	tglx
