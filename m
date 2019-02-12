Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D9DC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 15:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F2F217D9
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 15:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfBLPtn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:49:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:21300 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbfBLPtn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 10:49:43 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 07:49:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="123917630"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2019 07:49:41 -0800
Date:   Tue, 12 Feb 2019 08:49:23 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V2 3/4] nvme-pci: avoid irq allocation retrying via
 .calc_sets
Message-ID: <20190212154922.GA6176@localhost.localdomain>
References: <20190212130439.14501-1-ming.lei@redhat.com>
 <20190212130439.14501-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212130439.14501-4-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 12, 2019 at 05:04:38AM -0800, Ming Lei wrote:
> Currently pre-caculate each set vectors, and this way requires same
> 'max_vecs' and 'min_vecs' passed to pci_alloc_irq_vectors_affinity(),
> then nvme_setup_irqs() has to retry in case of allocation failure.
> 
> This usage & interface is a bit awkward because the retry should have
> been avoided by providing one reasonable 'min_vecs'.
> 
> Implement the callback of .calc_sets, so that pci_alloc_irq_vectors_affinity()
> can calculate each set's vector after IRQ vectors is allocated and
> before spread IRQ, then NVMe's retry in case of irq allocation failure
> can be removed.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thanks, Ming, this whole series looks like a great improvement for
drivers using irq sets.

Minor nit below. Otherwise you may add my review for the whole series
if you spin a v3 for the other minor comments.

Reviewed-by: Keith Busch <keith.busch@intel.com>

> +static void nvme_calc_irq_sets(struct irq_affinity *affd, int nvecs)
> +{
> +	struct nvme_dev *dev = affd->priv;
> +
> +	nvme_calc_io_queues(dev, nvecs);
> +
> +	affd->set_vectors[HCTX_TYPE_DEFAULT] = dev->io_queues[HCTX_TYPE_DEFAULT];
> +	affd->set_vectors[HCTX_TYPE_READ] = dev->io_queues[HCTX_TYPE_READ];
> +	affd->nr_sets = HCTX_TYPE_POLL;
> +}

The value of HCTX_TYPE_POLL happens to be 2, but that seems more of a
coincidence right now. Can we hard code 2 just in case the value changes?
