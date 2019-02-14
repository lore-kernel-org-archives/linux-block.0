Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E21C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 14:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395BD21927
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 14:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfBNOEf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:04:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfBNOEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 09:04:35 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guHcm-00085d-Sn; Thu, 14 Feb 2019 15:04:25 +0100
Date:   Thu, 14 Feb 2019 15:04:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V4 1/4] genirq/affinity: store interrupt sets size in
 'struct irq_affinity'
In-Reply-To: <20190214122347.17372-2-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902141502320.1561@nanos.tec.linutronix.de>
References: <20190214122347.17372-1-ming.lei@redhat.com> <20190214122347.17372-2-ming.lei@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Feb 2019, Ming Lei wrote:
>  /**
>   * struct irq_affinity - Description for automatic irq affinity assignements
>   * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
> @@ -266,13 +268,13 @@ struct irq_affinity_notify {
>   * @post_vectors:	Don't apply affinity to @post_vectors at end of
>   *			the MSI(-X) vector space
>   * @nr_sets:		Length of passed in *sets array
> - * @sets:		Number of affinitized sets
> + * @set_size:		Number of affinitized sets

Both nr_sets and set_size comments are wrong ...

>  	nr_sets = affd->nr_sets;
> -	if (!nr_sets)
> +	if (!nr_sets) {
>  		nr_sets = 1;
> +		set_size[0] = affvecs;
> +	} else {
> +		memcpy(set_size, affd->set_size,
> +				IRQ_AFFINITY_MAX_SETS * sizeof(int));

Uuurgh. No. This needs to be nr_sets * sizeof(int) otherwise you copy
beyond the size of the source. nr_sets is already verified to be less than
IRQ_AFFINITY_MAX_SETS.

Fixed it up.

Thanks,

	tglx


