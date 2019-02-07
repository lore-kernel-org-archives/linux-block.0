Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68538C282CC
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371F521917
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549578095;
	bh=SriIerW9Gq0RzWOeJdouSrhpvOFqRZnQYWmkydk8a0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ICO385VFor3n3y9b2URM68NlXwXxnTIJDzyFXJWBHkDpbzCbY95H2dty8/c5NWaZ4
	 7FZNCcZ/qGLS50oa1o7EowyCEJhUNjqtThmHgv0C2V0u0je9iEXg3O4oLCMQkqH+bV
	 XO1Lk9Yu5O0EBToj5QaZB3D8nbyDBot1i8iiNbJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfBGWVe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfBGWVe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 17:21:34 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D4E82147C;
        Thu,  7 Feb 2019 22:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549578092;
        bh=SriIerW9Gq0RzWOeJdouSrhpvOFqRZnQYWmkydk8a0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHqdxvD0bQCRQXMWGDsspjtPtJp0FztOq3BoSbbiQm7qMKzsoCpKhh0KKM3nJgdlk
         bax02RdSG9ry2EPA3UVQv8hewo5TzQ6DEK2hlAHLMVFvCm0dWjmfgi3ENzqxoZxYTk
         hSa8mjAtGwpfeoOyLUe2a+bMNmIKbBFXa3pYl7sc=
Date:   Thu, 7 Feb 2019 16:21:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
Message-ID: <20190207222130.GQ7268@google.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125095347.17950-3-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 25, 2019 at 05:53:44PM +0800, Ming Lei wrote:
> This patch introduces callback of .setup_affinity into 'struct
> irq_affinity', so that:
> 
> 1) allow drivers to customize the affinity for managed IRQ, for
> example, now NVMe has special requirement for read queues & poll
> queues
> 
> 2) 6da4b3ab9a6e9 ("genirq/affinity: Add support for allocating interrupt sets")
> makes pci_alloc_irq_vectors_affinity() a bit difficult to use for
> allocating interrupt sets: 'max_vecs' is required to same with 'min_vecs'.

s/is required to same with/is required to be equal to/

> With this patch, driver can implement their own .setup_affinity to
> customize the affinity, then the above thing can be solved easily.

s/driver/drivers/

> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/interrupt.h | 26 +++++++++++++++++---------
>  kernel/irq/affinity.c     |  6 ++++++
>  2 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index c672f34235e7..f6cea778cf50 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -242,30 +242,38 @@ struct irq_affinity_notify {
>  };
>  
>  /**
> + * struct irq_affinity_desc - Interrupt affinity descriptor
> + * @mask:	cpumask to hold the affinity assignment
> + */
> +struct irq_affinity_desc {
> +	struct cpumask	mask;
> +	unsigned int	is_managed : 1;
> +};

I was going to comment that "managed" already has a common usage
related to the devm_*() functions, but I don't think that's what you
mean here.  But then I noticed that you're only *moving* this code,
so you couldn't change it anyway.

But I still wonder what "managed" means here.

> +
> +/**
>   * struct irq_affinity - Description for automatic irq affinity assignements
>   * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
>   *			the MSI(-X) vector space
>   * @post_vectors:	Don't apply affinity to @post_vectors at end of
>   *			the MSI(-X) vector space
> + * @setup_affinity:	Use driver's method to setup irq vectors affinity,
> + * 			and driver has to handle pre_vectors & post_vectors
> + * 			correctly, set 'is_managed' flag correct too

s/irq vectors/irq vector/
s/correct/correctly/

In general I don't think "correctly" is very useful in changelogs
and comments.  Usually it just means "how *I* think it should be
done", but it doesn't tell anybody else exactly *how* it should be
done.

What does it mean for a driver to handle pre_vectors & post_vectors
"correctly"?  The driver's .setup_affinity() method receives an array
of struct irq_affinity; maybe it means that method should set the
cpumask for each element as it desires.  For @pre_vectors and
@post_vectors, I suppose that means their cpumask would be
irq_default_affinity?

But I guess the .setup_affinity() method means the driver would have
complete flexibility for each vector, and it could use
irq_default_affinity for arbitrary vectors, not just the first few
(@pre_vectors) and the last few (@post_vectors)?

What's the rule for how a driver sets "is_managed"?

> + * @priv:		Private data of @setup_affinity
>   * @nr_sets:		Length of passed in *sets array
>   * @sets:		Number of affinitized sets
>   */
>  struct irq_affinity {
>  	int	pre_vectors;
>  	int	post_vectors;
> +	int	(*setup_affinity)(const struct irq_affinity *,
> +				  struct irq_affinity_desc *,
> +				  unsigned int);
> +	void    *priv;
>  	int	nr_sets;
>  	int	*sets;
>  };
>  
> -/**
> - * struct irq_affinity_desc - Interrupt affinity descriptor
> - * @mask:	cpumask to hold the affinity assignment
> - */
> -struct irq_affinity_desc {
> -	struct cpumask	mask;
> -	unsigned int	is_managed : 1;
> -};
> -
>  #if defined(CONFIG_SMP)
>  
>  extern cpumask_var_t irq_default_affinity;
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 118b66d64a53..7b77cbdf739c 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -257,6 +257,12 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	if (!masks)
>  		return NULL;
>  
> +	if (affd->setup_affinity) {
> +		if (affd->setup_affinity(affd, masks, nvecs))
> +			return NULL;
> +		return masks;
> +	}

>  	/* Fill out vectors at the beginning that don't need affinity */
>  	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
>  		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
> -- 
> 2.9.5
> 
