Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:49802 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941016AbcIZPJH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2016 11:09:07 -0400
Date: Mon, 26 Sep 2016 17:09:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, tglx@linutronix.de,
        agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] nvme: switch to use pci_alloc_irq_vectors
Message-ID: <20160926150905.GA16811@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de> <1473862739-15032-12-git-send-email-hch@lst.de> <c8150106-764e-f8e9-4c1c-27e60ad96e83@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c8150106-764e-f8e9-4c1c-27e60ad96e83@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 23, 2016 at 03:21:14PM -0700, Sagi Grimberg wrote:
> Question: is using pci_alloc_irq_vectors() obligated for
> supplying blk-mq with the device affinity mask?

No, but it's very useful.  We'll need equivalents for other busses
that provide multipl vectors and vector spreading.

> If I do this completely-untested [1] what will happen?

Everything will be crashing and burning because you call to_pci_dev on
something that's not a PCI dev?

For the next merge window I plan to wire up the affinity information
for the RDMA code, and I will add a counterpart to blk_mq_pci_map_queues
that spreads the queues over the completion vectors.
