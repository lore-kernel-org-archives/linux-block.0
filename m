Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E3AC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 21:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A504E222A4
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 21:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391552AbfBMVmN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:42:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389739AbfBMVmM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 16:42:12 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gu2Hz-0006JT-KB; Wed, 13 Feb 2019 22:41:55 +0100
Date:   Wed, 13 Feb 2019 22:41:55 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Keith Busch <keith.busch@intel.com>
cc:     Bjorn Helgaas <helgaas@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
In-Reply-To: <20190213213149.GB8027@localhost.localdomain>
Message-ID: <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de>
References: <20190213105041.13537-1-ming.lei@redhat.com> <20190213105041.13537-2-ming.lei@redhat.com> <20190213150407.GB96272@google.com> <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de> <20190213213149.GB8027@localhost.localdomain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Feb 2019, Keith Busch wrote:
> On Wed, Feb 13, 2019 at 09:56:36PM +0100, Thomas Gleixner wrote:
> > On Wed, 13 Feb 2019, Bjorn Helgaas wrote:
> > > On Wed, Feb 13, 2019 at 06:50:37PM +0800, Ming Lei wrote:
> > > > We have to ask driver to re-caculate set vectors after the whole IRQ
> > > > vectors are allocated later, and the result needs to be stored in 'affd'.
> > > > Also both the two interfaces are core APIs, which should be trusted.
> > > 
> > > s/re-caculate/recalculate/
> > > s/stored in 'affd'/stored in '*affd'/
> > > s/both the two/both/
> > > 
> > > This is a little confusing because you're talking about both "IRQ
> > > vectors" and these other "set vectors", which I think are different
> > > things.  I assume the "set vectors" are cpumasks showing the affinity
> > > of the IRQ vectors with some CPUs?
> > 
> > I think we should drop the whole vector wording completely.
> > 
> > The driver does not care about vectors, it only cares about a block of
> > interrupt numbers. These numbers are kernel managed and the interrupts just
> > happen to have a CPU vector assigned at some point. Depending on the CPU
> > architecture the underlying mechanism might not even be named vector.
> 
> Perhaps longer term we could move affinity mask creation from the irq
> subsystem into a more generic library. Interrupts aren't the only
> resource that want to spread across CPUs. For example, blk-mq has it's
> own implementation to for polled queues, so I think a non-irq specific
> implementation would be a nice addition to the kernel lib.

Agreed. There is nothing interrupt specific in that code aside of some
name choices.

Btw, while I have your attention. There popped up an issue recently related
to that affinity logic.

The current implementation fails when:

        /*
         * If there aren't any vectors left after applying the pre/post
         * vectors don't bother with assigning affinity.
	 */
	if (nvecs == affd->pre_vectors + affd->post_vectors)
    		return NULL;

Now the discussion arised, that in that case the affinity sets are not
allocated and filled in for the pre/post vectors, but somehow the
underlying device still works and later on triggers the warning in the
blk-mq code because the MSI entries do not have affinity information
attached.

Sure, we could make that work, but there are several issues:

    1) irq_create_affinity_masks() has another reason to return NULL:
       memory allocation fails.

    2) Does it make sense at all.

Right now the PCI allocator ignores the NULL return and proceeds without
setting any affinities. As a consequence nothing is managed and everything
happens to work.

But that happens to work is more by chance than by design and the warning
is bogus if this is an expected mode of operation.

We should address these points in some way.

Thanks,

	tglx



