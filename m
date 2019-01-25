Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD11C282C2
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7B92084A
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfAYJ4g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:56:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfAYJ4g (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 04:56:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80A82C057E22;
        Fri, 25 Jan 2019 09:56:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C966608C3;
        Fri, 25 Jan 2019 09:56:24 +0000 (UTC)
Date:   Fri, 25 Jan 2019 17:56:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 0/5] genirq/affinity: introduce .setup_affinity to
 support allocating interrupt sets
Message-ID: <20190125095617.GA17754@ming.t460p>
References: <20190125095347.17950-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125095347.17950-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 25 Jan 2019 09:56:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 25, 2019 at 05:53:42PM +0800, Ming Lei wrote:
> Hi,
> 
> The current support for allocating interrupt sets requires that same 'max_vec'
> and 'min_vec' is passed to pci_alloc_irq_vectors_affinity(), then driver has to
> try to allocate again and again until it succeeds.
> 
> This patch introduces .setup_affinity callback, and we can use it to
> re-caculate interrupt sets and build affinity for each set after
> irq vectors are allocated.
> 
> Turns out both genirq/affinity and nvme code get simplified a lot.
> 
> Please review and comment!
> 
> Ming Lei (5):
>   genirq/affinity: move allocation of 'node_to_cpumask' to
>     irq_build_affinity_masks
>   genirq/affinity: allow driver to setup managed IRQ's affinity
>   genirq/affinity: introduce irq_build_affinity()
>   nvme-pci: simplify nvme_setup_irqs() via .setup_affinity callback
>   genirq/affinity: remove support for allocating interrupt sets
> 
>  drivers/nvme/host/pci.c   |  97 +++++++++++++++++++++--------------------
>  drivers/pci/msi.c         |  14 ------
>  include/linux/interrupt.h |  42 ++++++++++++------
>  kernel/irq/affinity.c     | 108 ++++++++++++++++++++++++----------------------
>  4 files changed, 133 insertions(+), 128 deletions(-)

oops, forget to CC Keith.

Thanks,
Ming
