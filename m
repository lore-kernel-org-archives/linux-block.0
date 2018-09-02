Return-Path: <linux-block-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54001 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeIBQSK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Sep 2018 12:18:10 -0400
Date: Sun, 2 Sep 2018 14:02:30 +0200 (CEST)
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
In-Reply-To: <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com> <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com> <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com> <615d78004495aebc53807156d04d988c@mail.gmail.com>
 <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de> <486f94a563d63c4779498fe8829a546c@mail.gmail.com> <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de> <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 31 Aug 2018, Kashyap Desai wrote:
> > Ok. I misunderstood the whole thing a bit. So your real issue is that you
> > want to have reply queues which are instantaneous, the per cpu ones, and
> > then the extra 16 which do batching and are shared over a set of CPUs,
> > right?
> 
> Yes that is correct.  Extra 16 or whatever should be shared over set of
> CPUs of *local* numa node of the PCI device.

Why restricting it to the local NUMA node of the device? That doesn't
really make sense if you queue lots of requests from CPUs on a different
node.

Why don't you spread these extra interrupts accross all nodes and keep the
locality for the request/reply?

That also would allow to make them properly managed interrupts as you could
shutdown the per node batching interrupts when all CPUs of that node are
offlined and you'd avoid the whole affinity hint irq balancer hackery.

Thanks,

	tglx
