Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F01C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 03:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB0420855
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 03:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfBKDyN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:54:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfBKDyN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 22:54:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C442FC0669AC;
        Mon, 11 Feb 2019 03:54:12 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2803360BE0;
        Mon, 11 Feb 2019 03:54:04 +0000 (UTC)
Date:   Mon, 11 Feb 2019 11:54:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
Message-ID: <20190211035358.GA8638@ming.t460p>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-3-ming.lei@redhat.com>
 <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 11 Feb 2019 03:54:12 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Thomas,

On Sun, Feb 10, 2019 at 05:30:41PM +0100, Thomas Gleixner wrote:
> Ming,
> 
> On Fri, 25 Jan 2019, Ming Lei wrote:
> 
> > This patch introduces callback of .setup_affinity into 'struct
> > irq_affinity', so that:
> 
> Please see Documentation/process/submitting-patches.rst. Search for 'This
> patch' ....

Sorry for that, because I am not a native English speaker and it looks a bit
difficult for me to understand the subtle difference.

> 
> > 
> > 1) allow drivers to customize the affinity for managed IRQ, for
> > example, now NVMe has special requirement for read queues & poll
> > queues
> 
> That's nothing new and already handled today.
> 
> > 2) 6da4b3ab9a6e9 ("genirq/affinity: Add support for allocating interrupt sets")
> > makes pci_alloc_irq_vectors_affinity() a bit difficult to use for
> > allocating interrupt sets: 'max_vecs' is required to same with 'min_vecs'.
> 
> So it's a bit difficult, but you fail to explain why it's not sufficient.

The introduced limit is that 'max_vecs' has to be same with 'min_vecs' for
pci_alloc_irq_vectors_affinity() wrt. NVMe's use case since commit
6da4b3ab9a6e9, then NVMe has to deal with irq vectors allocation failure in
the awkward way of retrying.

And the topic has been discussed in the following links:

https://marc.info/?l=linux-pci&m=154655595615575&w=2
https://marc.info/?l=linux-pci&m=154646930922174&w=2

Bjorn and Keith thought this usage/interface is a bit awkward because the passed
'min_vecs' should have avoided driver's retrying.

For NVMe, when irq vectors are run out of from pci_alloc_irq_vectors_affinity(),
the requested number has to be decreased and retry until it succeeds, then the
allocated irq vectors has to be re-distributed among the whole irq sets. Turns
out the re-distribution need driver's knowledge, that is why the callback is
introduced.

> 
> > With this patch, driver can implement their own .setup_affinity to
> > customize the affinity, then the above thing can be solved easily.
> 
> Well, I don't really understand what is solved easily and you are merily
> describing the fact that the new callback allows drivers to customize
> something. What's the rationale? If it's just the 'bit difficult' part,
> then what is the reason for not making the core functionality easier to use
> instead of moving stuff into driver space again?

Another solution mentioned in previous discussion is to split building & setting up
affinities from allocating irq vectors, but one big problem is that allocating
'irq_desc' needs the affinity mask for figuring out 'node', see alloc_descs().

> 
> NVME is not special and all this achieves is that all drivers writers will

I mean that NVMe is the only user of irq sets.

> claim that their device is special and needs its own affinity setter
> routine. The whole point of having the generic code is to exactly avoid
> that. If it has shortcomings, then they need to be addressed, but not
> worked around with random driver callbacks.

Understood.

Thanks,
Ming
