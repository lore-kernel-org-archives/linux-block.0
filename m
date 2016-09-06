Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8219 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755839AbcIFRUL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Sep 2016 13:20:11 -0400
Date: Tue, 6 Sep 2016 13:30:53 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/7] blk-mq: allow the driver to pass in an affinity mask
Message-ID: <20160906173053.GC25201@localhost.localdomain>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
 <1472468013-29936-5-git-send-email-hch@lst.de>
 <20160831163852.GB5598@localhost.localdomain>
 <20160901084624.GC4115@lst.de>
 <20160901142410.GA10903@localhost.localdomain>
 <20160905194759.GA26008@lst.de>
 <20160906143928.GA25201@localhost.localdomain>
 <20160906165056.GB26214@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160906165056.GB26214@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 06, 2016 at 06:50:56PM +0200, Christoph Hellwig wrote:
> [adding Thomas as it's about the affinity_mask he (we) added to the
>  IRQ core]
> > Here's my topology info:
> > 
> >   # numactl --hardware
> >   available: 2 nodes (0-1)
> >   node 0 cpus: 0 1 2 3 4 5 6 7 16 17 18 19 20 21 22 23
> >   node 0 size: 15745 MB
> >   node 0 free: 15319 MB
> >   node 1 cpus: 8 9 10 11 12 13 14 15 24 25 26 27 28 29 30 31
> >   node 1 size: 16150 MB
> >   node 1 free: 15758 MB
> >   node distances:
> >   node   0   1
> >     0:  10  21
> >     1:  21  10
> 
> How do you get that mapping?  Does this CPU use Hyperthreading and
> thus expose siblings using topology_sibling_cpumask?  As that's the
> only thing the old code used for any sort of special casing.
> 
> I'll need to see if I can find a system with such a mapping to reproduce.

Yes, this is a two-socket server with hyperthreading enabled. Numbering
the physical CPUs before the hyperthreads is a common numbering on
x86, so we're going to see this split numbering on any multi-socket
hyperthreaded server.

The topology_sibling_cpumask shows the right information. The resulting
mask from cpu 0 on my server is 0x00010001; cpu 1 is 0x00020002, etc...

> > What we want for my CPU topology is the 16th CPU to pair with CPU 0,
> > 17 pairs with 1, 18 with 2, and so on. You can't convey that information
> > with this scheme. We need affinity_masks per vector.
> 
> We actually have per-vector masks, but they are hidden inside the IRQ
> core and awkward to use.  We could to the get_first_sibling magic
> in the block-mq queue mapping (and in fact with the current code I guess
> we need to).  Or take a step back from trying to emulate the old code
> and instead look at NUMA nodes instead of siblings which some folks
> suggested a while ago.

Adding the first sibling magic in blk-mq would fix my specific case,
but it doesn't help genericly when we need to pair more than just thread
siblings.
