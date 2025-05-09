Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED7244664
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746757356; cv=none; b=k+k+W5Y7cKXc1vTUiOWKvjb7+a1AP7YwcGinfPdX/YjkpDmTJkLAow0gNxEVoLN7BiX4DO019RU6qFe8pIxND5jSmUDWwyvkQy1F0ttqQqkKWHOT9i0txJCE1xL+KybyKSr91yyqPQryz0xCTKa56vTABEOkcmYQEXDUQlAMOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746757356; c=relaxed/simple;
	bh=Lnw5auLArtZOhIatGNwbk3W8GByv+4IzBJQn2/H6EeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU20Cm6NHVwGYIZyANCmnahV4kX29Fju4kA5oKzsvNNNm26m/PZitsPu42/DyfnDNm3JdfwFoMabD3gxHKwgz/z+ICH5I/6P5Ra30mWHRd/p15cUF8g/QFnbwEmeOjj11wINCP9EQrZ6UWhrWp1acSMFtqlLsFgc3z5K54ty2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9XlWWnr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9XlWWnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746757353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3wQCin9HeB8txhWwzUBKyex+RK7rsIvnKnnr87lbKI=;
	b=a9XlWWnrjyKXD7cZAZR+rRuUH5e/MtgpFTvq8jYKfxtOvDY23U2NCChiA13R54obX3/cFk
	brBO2HusuqLK4IulbLYagT5aqF2AAgbaUaM+G/3zbqCeFVLAKoz4G8Pv8UVVTaKaEwy7cd
	yllfXo7xEOoReZyWkq6GGrnbBBkiNvA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-bllVoA_ENB2Ua9YfXuprIA-1; Thu,
 08 May 2025 22:22:29 -0400
X-MC-Unique: bllVoA_ENB2Ua9YfXuprIA-1
X-Mimecast-MFC-AGG-ID: bllVoA_ENB2Ua9YfXuprIA_1746757346
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B1DD195608F;
	Fri,  9 May 2025 02:22:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.120])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8709180045B;
	Fri,  9 May 2025 02:22:12 +0000 (UTC)
Date: Fri, 9 May 2025 10:22:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v6 7/9] lib/group_cpus: honor housekeeping config when
 grouping CPUs
Message-ID: <aB1mz7a8tEZhVNIG@fedora>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
 <20250424-isolcpus-io-queues-v6-7-9a53a870ca1f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-isolcpus-io-queues-v6-7-9a53a870ca1f@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Apr 24, 2025 at 08:19:46PM +0200, Daniel Wagner wrote:
> group_cpus_evenly distributes all present CPUs into groups. This ignores
> the isolcpus configuration and assigns isolated CPUs into the groups.
> 
> Make group_cpus_evenly aware of isolcpus configuration and use the
> housekeeping CPU mask as base for distributing the available CPUs into
> groups.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  lib/group_cpus.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index 016c6578a07616959470b47121459a16a1bc99e5..707997bca55344b18f63ccfa539ba77a89d8acb6 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -8,6 +8,7 @@
>  #include <linux/cpu.h>
>  #include <linux/sort.h>
>  #include <linux/group_cpus.h>
> +#include <linux/sched/isolation.h>
>  
>  #ifdef CONFIG_SMP
>  
> @@ -330,7 +331,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>  }
>  
>  /**
> - * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
> + * group_possible_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
>   * @numgrps: number of groups
>   * @nummasks: number of initialized cpumasks
>   *
> @@ -346,8 +347,8 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>   * We guarantee in the resulted grouping that all CPUs are covered, and
>   * no same CPU is assigned to multiple groups
>   */
> -struct cpumask *group_cpus_evenly(unsigned int numgrps,
> -				  unsigned int *nummasks)
> +static struct cpumask *group_possible_cpus_evenly(unsigned int numgrps,
> +						  unsigned int *nummasks)
>  {
>  	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
>  	cpumask_var_t *node_to_cpumask;
> @@ -427,6 +428,81 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps,
>  	*nummasks = nr_present + nr_others;
>  	return masks;
>  }
> +
> +/**
> + * group_mask_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
> + * @numgrps: number of groups
> + * @cpu_mask: CPU to consider for the grouping
> + * @nummasks: number of initialized cpusmasks
> + *
> + * Return: cpumask array if successful, NULL otherwise. And each element
> + * includes CPUs assigned to this group.
> + *
> + * Try to put close CPUs from viewpoint of CPU and NUMA locality into
> + * same group. Allocate present CPUs on these groups evenly.
> + */
> +static struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
> +					      const struct cpumask *cpu_mask,
> +					      unsigned int *nummasks)
> +{
> +	cpumask_var_t *node_to_cpumask;
> +	cpumask_var_t nmsk;
> +	int ret = -ENOMEM;
> +	struct cpumask *masks = NULL;
> +
> +	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
> +		return NULL;
> +
> +	node_to_cpumask = alloc_node_to_cpumask();
> +	if (!node_to_cpumask)
> +		goto fail_nmsk;
> +
> +	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
> +	if (!masks)
> +		goto fail_node_to_cpumask;
> +
> +	build_node_to_cpumask(node_to_cpumask);
> +
> +	ret = __group_cpus_evenly(0, numgrps, node_to_cpumask, cpu_mask, nmsk,
> +				  masks);
> +
> +fail_node_to_cpumask:
> +	free_node_to_cpumask(node_to_cpumask);
> +
> +fail_nmsk:
> +	free_cpumask_var(nmsk);
> +	if (ret < 0) {
> +		kfree(masks);
> +		return NULL;
> +	}
> +	*nummasks = ret;
> +	return masks;
> +}
> +
> +/**
> + * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
> + * @numgrps: number of groups
> + * @nummasks: number of initialized cpusmasks
> + *
> + * Return: cpumask array if successful, NULL otherwise.
> + *
> + * group_possible_cpus_evently() is used for distributing the cpus on all

s/evently/evenly/

> + * possible cpus in absence of isolcpus command line argument.

s/isolcpus/isolcpus=io_queue

> + * group_mask_cpu_evenly() is used when the isolcpus command line
> + * argument is used with managed_irq option. In this case only the

s/managed_irq/io_queue

> + * housekeeping CPUs are considered.

I'd suggest to highlight the difference, which is one fundamental thing,
originally all CPUs are covered, now only housekeeping CPUs are
distributed.

Otherwise, looks fine to me:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

