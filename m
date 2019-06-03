Return-Path: <SRS0=uYlv=UC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECF6C04AB6
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 07:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE8927CE7
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 07:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFCHlY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:41:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfFCHlY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Jun 2019 03:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FC9A3092650;
        Mon,  3 Jun 2019 07:41:23 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E930760BF1;
        Mon,  3 Jun 2019 07:41:17 +0000 (UTC)
Date:   Mon, 3 Jun 2019 15:41:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Minwoo Im <minwoo.im@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] genirq/affinity: remove unused arg when building aff mask
Message-ID: <20190603074112.GB11812@ming.t460p>
References: <20190602112117.31839-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190602112117.31839-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 03 Jun 2019 07:41:23 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 02, 2019 at 08:21:17PM +0900, Minwoo Im wrote:
> When building affinity masks, the struct irq_affinity *affd is not
> needed because irq_create_affinity_masks() has already given a cursored
> current vector after pre_vectors via "curvec".
> 
> This patch removes unused argument for irq_build_affinity_masks() and
> __irq_build_affinity_masks().  No functions changes are included.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>  kernel/irq/affinity.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index f18cd5aa33e8..4352b08ae48d 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -94,8 +94,7 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
>  	return nodes;
>  }
>  
> -static int __irq_build_affinity_masks(const struct irq_affinity *affd,
> -				      unsigned int startvec,
> +static int __irq_build_affinity_masks(unsigned int startvec,
>  				      unsigned int numvecs,
>  				      unsigned int firstvec,
>  				      cpumask_var_t *node_to_cpumask,
> @@ -171,8 +170,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
>   *	1) spread present CPU on these vectors
>   *	2) spread other possible CPUs on these vectors
>   */
> -static int irq_build_affinity_masks(const struct irq_affinity *affd,
> -				    unsigned int startvec, unsigned int numvecs,
> +static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
>  				    unsigned int firstvec,
>  				    struct irq_affinity_desc *masks)
>  {
> @@ -197,7 +195,7 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
>  	build_node_to_cpumask(node_to_cpumask);
>  
>  	/* Spread on present CPUs starting from affd->pre_vectors */
> -	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs,
> +	nr_present = __irq_build_affinity_masks(curvec, numvecs,
>  						firstvec, node_to_cpumask,
>  						cpu_present_mask, nmsk, masks);
>  
> @@ -212,7 +210,7 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
>  	else
>  		curvec = firstvec + nr_present;
>  	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> -	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs,
> +	nr_others = __irq_build_affinity_masks(curvec, numvecs,
>  					       firstvec, node_to_cpumask,
>  					       npresmsk, nmsk, masks);
>  	put_online_cpus();
> @@ -295,7 +293,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  		unsigned int this_vecs = affd->set_size[i];
>  		int ret;
>  
> -		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
> +		ret = irq_build_affinity_masks(curvec, this_vecs,
>  					       curvec, masks);
>  		if (ret) {
>  			kfree(masks);
> -- 
> 2.21.0
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming
