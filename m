Return-Path: <SRS0=s4v/=QY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F33C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 13:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E2B21B69
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 13:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfBQNjO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:39:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfBQNjO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Feb 2019 08:39:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D8CA80F81;
        Sun, 17 Feb 2019 13:39:14 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 250171024967;
        Sun, 17 Feb 2019 13:39:04 +0000 (UTC)
Date:   Sun, 17 Feb 2019 21:39:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch v6 5/7] genirq/affinity: Remove the leftovers of the
 original set support
Message-ID: <20190217133859.GF7296@ming.t460p>
References: <20190216171306.403545970@linutronix.de>
 <20190216172228.689834224@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216172228.689834224@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 17 Feb 2019 13:39:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 16, 2019 at 06:13:11PM +0100, Thomas Gleixner wrote:
> Now that the NVME driver is converted over to the calc_set() callback, the
> workarounds of the original set support can be removed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/affinity.c |   20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> Index: b/kernel/irq/affinity.c
> ===================================================================
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -264,20 +264,13 @@ irq_create_affinity_masks(unsigned int n
>  
>  	/*
>  	 * Simple invocations do not provide a calc_sets() callback. Install
> -	 * the generic one. The check for affd->nr_sets is a temporary
> -	 * workaround and will be removed after the NVME driver is converted
> -	 * over.
> +	 * the generic one.
>  	 */
> -	if (!affd->nr_sets && !affd->calc_sets)
> +	if (!affd->calc_sets)
>  		affd->calc_sets = default_calc_sets;
>  
> -	/*
> -	 * If the device driver provided a calc_sets() callback let it
> -	 * recalculate the number of sets and their size. The check will go
> -	 * away once the NVME driver is converted over.
> -	 */
> -	if (affd->calc_sets)
> -		affd->calc_sets(affd, affvecs);
> +	/* Recalculate the sets */
> +	affd->calc_sets(affd, affvecs);
>  
>  	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
>  		return NULL;
> @@ -344,11 +337,6 @@ unsigned int irq_calc_affinity_vectors(u
>  
>  	if (affd->calc_sets) {
>  		set_vecs = maxvec - resv;
> -	} else if (affd->nr_sets) {
> -		unsigned int i;
> -
> -		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
> -			set_vecs += affd->set_size[i];
>  	} else {
>  		get_online_cpus();
>  		set_vecs = cpumask_weight(cpu_possible_mask);
> 
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
