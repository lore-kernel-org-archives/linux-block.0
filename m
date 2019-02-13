Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C718FC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABDF222CC
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfBMVcG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:32:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:37158 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfBMVcG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 13:32:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="126250644"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2019 13:32:04 -0800
Date:   Wed, 13 Feb 2019 14:31:49 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
Message-ID: <20190213213149.GB8027@localhost.localdomain>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-2-ming.lei@redhat.com>
 <20190213150407.GB96272@google.com>
 <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 09:56:36PM +0100, Thomas Gleixner wrote:
> On Wed, 13 Feb 2019, Bjorn Helgaas wrote:
> > On Wed, Feb 13, 2019 at 06:50:37PM +0800, Ming Lei wrote:
> > > We have to ask driver to re-caculate set vectors after the whole IRQ
> > > vectors are allocated later, and the result needs to be stored in 'affd'.
> > > Also both the two interfaces are core APIs, which should be trusted.
> > 
> > s/re-caculate/recalculate/
> > s/stored in 'affd'/stored in '*affd'/
> > s/both the two/both/
> > 
> > This is a little confusing because you're talking about both "IRQ
> > vectors" and these other "set vectors", which I think are different
> > things.  I assume the "set vectors" are cpumasks showing the affinity
> > of the IRQ vectors with some CPUs?
> 
> I think we should drop the whole vector wording completely.
> 
> The driver does not care about vectors, it only cares about a block of
> interrupt numbers. These numbers are kernel managed and the interrupts just
> happen to have a CPU vector assigned at some point. Depending on the CPU
> architecture the underlying mechanism might not even be named vector.

Perhaps longer term we could move affinity mask creation from the irq
subsystem into a more generic library. Interrupts aren't the only
resource that want to spread across CPUs. For example, blk-mq has it's
own implementation to for polled queues, so I think a non-irq specific
implementation would be a nice addition to the kernel lib.
