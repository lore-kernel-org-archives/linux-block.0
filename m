Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA018C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 16:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8983420874
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 16:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfBJQa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:30:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37162 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfBJQa4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 11:30:56 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gss0A-0006h6-E5; Sun, 10 Feb 2019 17:30:42 +0100
Date:   Sun, 10 Feb 2019 17:30:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
In-Reply-To: <20190125095347.17950-3-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de>
References: <20190125095347.17950-1-ming.lei@redhat.com> <20190125095347.17950-3-ming.lei@redhat.com>
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

Ming,

On Fri, 25 Jan 2019, Ming Lei wrote:

> This patch introduces callback of .setup_affinity into 'struct
> irq_affinity', so that:

Please see Documentation/process/submitting-patches.rst. Search for 'This
patch' ....

> 
> 1) allow drivers to customize the affinity for managed IRQ, for
> example, now NVMe has special requirement for read queues & poll
> queues

That's nothing new and already handled today.

> 2) 6da4b3ab9a6e9 ("genirq/affinity: Add support for allocating interrupt sets")
> makes pci_alloc_irq_vectors_affinity() a bit difficult to use for
> allocating interrupt sets: 'max_vecs' is required to same with 'min_vecs'.

So it's a bit difficult, but you fail to explain why it's not sufficient.

> With this patch, driver can implement their own .setup_affinity to
> customize the affinity, then the above thing can be solved easily.

Well, I don't really understand what is solved easily and you are merily
describing the fact that the new callback allows drivers to customize
something. What's the rationale? If it's just the 'bit difficult' part,
then what is the reason for not making the core functionality easier to use
instead of moving stuff into driver space again?

NVME is not special and all this achieves is that all drivers writers will
claim that their device is special and needs its own affinity setter
routine. The whole point of having the generic code is to exactly avoid
that. If it has shortcomings, then they need to be addressed, but not
worked around with random driver callbacks.

Thanks,

	tglx
