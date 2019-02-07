Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA798C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0A721916
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549576930;
	bh=SrGQtSRwp7rdI7Pn1+ONFD6lQT2q2uoDnk5SazLE9kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mDY+fgHKi4kRQwk7GMLefbqefoiaZrN+GT8IfFG5fsBstSFWynvl5kfNJINreQkBh
	 htmrJz6KZfXLYWl+WxdhPdWF5UvFfD6qrkTN2vUA3gKJxYOd+KDYS+7k5zd3XbYQSE
	 YeBU6KB2zcrUG7KuZRYQJiRWyBmQfTn5ABnHoZxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBGWCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfBGWCJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 17:02:09 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8667221721;
        Thu,  7 Feb 2019 22:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549576928;
        bh=SrGQtSRwp7rdI7Pn1+ONFD6lQT2q2uoDnk5SazLE9kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDnugmESFHVNnH8NkIoeNXzfZtWsQBX2ejQynqs1ryVAi0wdoailGUxVlHc3SdW7f
         fpENkzt8A1aTc8RWpt0gHxocOcJs+d675QZh/3nXqAt6M/u2CGYS2qbTRaW9S0jYmY
         QfkiPS1MTPWgxZ1vfDJcnVT61i54w/6ooZqKlQeo=
Date:   Thu, 7 Feb 2019 16:02:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] genirq/affinity: move allocation of
 'node_to_cpumask' to irq_build_affinity_masks
Message-ID: <20190207220204.GP7268@google.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125095347.17950-2-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 25, 2019 at 05:53:43PM +0800, Ming Lei wrote:
> 'node_to_cpumask' is just one temparay variable for irq_build_affinity_masks(),
> so move it into irq_build_affinity_masks().
> 
> No functioanl change.

s/temparay/temporary/
s/functioanl/functional/

> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Nice patch, this is much cleaner.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  kernel/irq/affinity.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 45b68b4ea48b..118b66d64a53 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -175,18 +175,22 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
>   */
>  static int irq_build_affinity_masks(const struct irq_affinity *affd,
>  				    int startvec, int numvecs, int firstvec,
> -				    cpumask_var_t *node_to_cpumask,
>  				    struct irq_affinity_desc *masks)
>  {
>  	int curvec = startvec, nr_present, nr_others;
>  	int ret = -ENOMEM;
>  	cpumask_var_t nmsk, npresmsk;
> +	cpumask_var_t *node_to_cpumask;
>  
>  	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
>  		return ret;
>  
>  	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
> -		goto fail;
> +		goto fail_nmsk;
> +
> +	node_to_cpumask = alloc_node_to_cpumask();
> +	if (!node_to_cpumask)
> +		goto fail_npresmsk;
>  
>  	ret = 0;
>  	/* Stabilize the cpumasks */
> @@ -217,9 +221,12 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
>  	if (nr_present < numvecs)
>  		WARN_ON(nr_present + nr_others < numvecs);
>  
> +	free_node_to_cpumask(node_to_cpumask);
> +
> + fail_npresmsk:
>  	free_cpumask_var(npresmsk);
>  
> - fail:
> + fail_nmsk:
>  	free_cpumask_var(nmsk);
>  	return ret;
>  }
> @@ -236,7 +243,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  {
>  	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
>  	int curvec, usedvecs;
> -	cpumask_var_t *node_to_cpumask;
>  	struct irq_affinity_desc *masks = NULL;
>  	int i, nr_sets;
>  
> @@ -247,13 +253,9 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	if (nvecs == affd->pre_vectors + affd->post_vectors)
>  		return NULL;
>  
> -	node_to_cpumask = alloc_node_to_cpumask();
> -	if (!node_to_cpumask)
> -		return NULL;
> -
>  	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
>  	if (!masks)
> -		goto outnodemsk;
> +		return NULL;
>  
>  	/* Fill out vectors at the beginning that don't need affinity */
>  	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
> @@ -271,11 +273,10 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  		int ret;
>  
>  		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
> -						curvec, node_to_cpumask, masks);
> +						curvec, masks);
>  		if (ret) {
>  			kfree(masks);
> -			masks = NULL;
> -			goto outnodemsk;
> +			return NULL;
>  		}
>  		curvec += this_vecs;
>  		usedvecs += this_vecs;
> @@ -293,8 +294,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
>  		masks[i].is_managed = 1;
>  
> -outnodemsk:
> -	free_node_to_cpumask(node_to_cpumask);
>  	return masks;
>  }
>  
> -- 
> 2.9.5
> 
