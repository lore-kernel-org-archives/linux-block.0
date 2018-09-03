Return-Path: <linux-block-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeICUtD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Sep 2018 16:49:03 -0400
Date: Mon, 3 Sep 2018 18:28:06 +0200 (CEST)
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
In-Reply-To: <66256272c020be186becdd7a3f049302@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com> <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com> <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com> <615d78004495aebc53807156d04d988c@mail.gmail.com>
 <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de> <486f94a563d63c4779498fe8829a546c@mail.gmail.com> <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de> <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com> <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
 <66256272c020be186becdd7a3f049302@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 3 Sep 2018, Kashyap Desai wrote:
> I am using " for-4.19/block " and this particular patch "a0c9259
> irq/matrix: Spread interrupts on allocation" is included.

Can you please try against 4.19-rc2 or later?

> I can see that 16 extra reply queues via pre_vectors are still assigned to
> CPU 0 (effective affinity ).
> 
> irq 33, cpu list 0-71

The cpu list is irrelevant because that's the allowed affinity mask. The
effective one is what counts.

> # cat /sys/kernel/debug/irq/irqs/34
> node:     0
> affinity: 0-71
> effectiv: 0

So if all 16 have their effective affinity set to CPU0 then that's strange
at least.

Can you please provide the output of /sys/kernel/debug/irq/domains/VECTOR ?

> Ideally, what we are looking for 16 extra pre_vector reply queue is
> "effective affinity" to be within local numa node as long as that numa
> node has online CPUs. If not, we are ok to have effective cpu from any
> node.

Well, we surely can do the initial allocation and spreading on the local
numa node, but once all CPUs are offline on that node, then the whole thing
goes down the drain and allocates from where it sees fit. I'll think about
it some more, especially how to avoid the proliferation of the affinity
hint.

Thanks,

	tglx
