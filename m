Return-Path: <SRS0=s4v/=QY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E7BC43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 13:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F7421A4A
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 13:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfBQNpl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:45:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfBQNpl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Feb 2019 08:45:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE70A12AD75;
        Sun, 17 Feb 2019 13:45:40 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8461D5DD73;
        Sun, 17 Feb 2019 13:45:28 +0000 (UTC)
Date:   Sun, 17 Feb 2019 21:45:23 +0800
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
Subject: Re: [patch v6 7/7] genirq/affinity: Add support for non-managed
 affinity sets
Message-ID: <20190217134522.GH7296@ming.t460p>
References: <20190216171306.403545970@linutronix.de>
 <20190216172228.869750763@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216172228.869750763@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 17 Feb 2019 13:45:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Thomas,

On Sat, Feb 16, 2019 at 06:13:13PM +0100, Thomas Gleixner wrote:
> Some drivers need an extra set of interrupts which should not be marked
> managed, but should get initial interrupt spreading.

Could you share the drivers and their use case?

> 
> Add a bitmap to struct irq_affinity which allows the driver to mark a
> particular set of interrupts as non managed. Check the bitmap during
> spreading and use the result to mark the interrupts in the sets
> accordingly.
> 
> The unmanaged interrupts get initial spreading, but user space can change
> their affinity later on. For the managed sets, i.e. the corresponding bit
> in the mask is not set, there is no change in behaviour.
> 
> Usage example:
> 
> 	struct irq_affinity affd = {
> 		.pre_vectors	= 2,
> 		.unmanaged_sets	= 0x02,
> 		.calc_sets	= drv_calc_sets,
> 	};
> 	....
> 
> For both interrupt sets the interrupts are properly spread out, but the
> second set is not marked managed.

Given drivers only care the managed vs non-managed interrupt numbers,
just wondering why this case can't be covered by .pre_vectors &
.post_vectors?

Also this kind of usage may break blk-mq easily, in which the following
rule needs to be respected:

1) all CPUs are required to spread among each interrupt set

2) no any CPU is shared between two IRQs in same set.

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/interrupt.h |    2 ++
>  kernel/irq/affinity.c     |   16 +++++++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> Index: b/include/linux/interrupt.h
> ===================================================================
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -251,6 +251,7 @@ struct irq_affinity_notify {
>   *			the MSI(-X) vector space
>   * @nr_sets:		The number of interrupt sets for which affinity
>   *			spreading is required
> + * @unmanaged_sets:	Bitmap to mark entries in the @set_size array unmanaged
>   * @set_size:		Array holding the size of each interrupt set
>   * @calc_sets:		Callback for calculating the number and size
>   *			of interrupt sets
> @@ -261,6 +262,7 @@ struct irq_affinity {
>  	unsigned int	pre_vectors;
>  	unsigned int	post_vectors;
>  	unsigned int	nr_sets;
> +	unsigned int	unmanaged_sets;
>  	unsigned int	set_size[IRQ_AFFINITY_MAX_SETS];
>  	void		(*calc_sets)(struct irq_affinity *, unsigned int nvecs);
>  	void		*priv;
> Index: b/kernel/irq/affinity.c
> ===================================================================
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -249,6 +249,8 @@ irq_create_affinity_masks(unsigned int n
>  	unsigned int affvecs, curvec, usedvecs, i;
>  	struct irq_affinity_desc *masks = NULL;
>  
> +	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS > sizeof(affd->unmanaged_sets) * 8);
> +
>  	/*
>  	 * Determine the number of vectors which need interrupt affinities
>  	 * assigned. If the pre/post request exhausts the available vectors
> @@ -292,7 +294,8 @@ irq_create_affinity_masks(unsigned int n
>  	 * have multiple sets, build each sets affinity mask separately.
>  	 */
>  	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
> -		unsigned int this_vecs = affd->set_size[i];
> +		bool managed = affd->unmanaged_sets & (1U << i) ? true : false;

The above check is inverted.

Thanks,
Ming
