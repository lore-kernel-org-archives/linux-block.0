Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A00C282CA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D302218B0
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 13:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfBLNiH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:38:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43367 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbfBLNiH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 08:38:07 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtYG6-0003ut-0j; Tue, 12 Feb 2019 14:37:58 +0100
Date:   Tue, 12 Feb 2019 14:37:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2 2/4] genirq/affinity: add new callback for caculating
 set vectors
In-Reply-To: <20190212130439.14501-3-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902121435330.3710@nanos.tec.linutronix.de>
References: <20190212130439.14501-1-ming.lei@redhat.com> <20190212130439.14501-3-ming.lei@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 12 Feb 2019, Ming Lei wrote:

> Currently pre-caculated set vectors are provided by driver for
> allocating & spread vectors. This way only works when drivers passes
> same 'max_vecs' and 'min_vecs' to pci_alloc_irq_vectors_affinity(),
> also requires driver to retry the allocating & spread.
> 
> As Bjorn and Keith mentioned, the current usage & interface for irq sets
> is a bit awkward because the retrying should have been avoided by providing
> one resonable 'min_vecs'. However, if 'min_vecs' isn't same with
> 'max_vecs', number of the allocated vectors is unknown before calling
> pci_alloc_irq_vectors_affinity(), then each set's vectors can't be
> pre-caculated.
> 
> Add a new callback of .calc_sets into 'struct irq_affinity' so that
> driver can caculate set vectors after IRQ vector is allocated and
> before spread IRQ vectors. Add 'priv' so that driver may retrieve
> its private data via the 'struct irq_affinity'.

Nice changelog!

>  	 * Spread on present CPUs starting from affd->pre_vectors. If we
>  	 * have multiple sets, build each sets affinity mask separately.
>  	 */
> -	nr_sets = affd->nr_sets;
> -	if (!nr_sets) {
> +	if (affd->calc_sets) {
> +		affd->calc_sets(affd, nvecs);
> +		nr_sets = affd->nr_sets;
> +	} else if (!affd->nr_sets) {
>  		nr_sets = 1;
>  		affd->set_vectors[0] = affvecs;
> -	}
> +	} else
> +		nr_sets = affd->nr_sets;

Lacks curly brackets.

Aside of that it might make sense to get rid of the local variable, but
that should be done in patch 1 if at all. No strong opinion though.

Thanks,

	tglx
