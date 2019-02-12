Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6014C282CE
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F74F2186A
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 13:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfBLNfj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:35:39 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43354 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfBLNfj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 08:35:39 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtYDi-0003rU-5V; Tue, 12 Feb 2019 14:35:30 +0100
Date:   Tue, 12 Feb 2019 14:35:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2 1/4] genirq/affinity: store irq set vectors in 'struct
 irq_affinity'
In-Reply-To: <20190212130439.14501-2-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902121434280.3710@nanos.tec.linutronix.de>
References: <20190212130439.14501-1-ming.lei@redhat.com> <20190212130439.14501-2-ming.lei@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 12 Feb 2019, Ming Lei wrote:

> Currently the array of irq set vectors is provided by driver.
> 
> irq_create_affinity_masks() can be simplied a bit by treating the
> non-irq-set case as single irq set.
> 
> So move this array into 'struct irq_affinity', and pre-define the max
> set number as 4, which should be enough for normal cases.

You really want to add some sanity check which makes sure, that nr_sets is
<= IRQ_MAX_SETS.

Thanks,

	tglx
