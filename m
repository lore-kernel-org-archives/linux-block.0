Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8A2F3B;
	Sat, 22 Jun 2024 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719033265; cv=none; b=il6sldO9l0VH7zU4Hw3ehwwC3dVUKq62JXifQaT0jD+U4gNzpUZ8CeTHktG65R/twizETsOO6Wk9qGvHaEIVbZfexkgoZTjKTqzkp4yI+R0Dc3hryqpd3446pEqJCcUslgYBsufSrbs0s87YB38BK3+IvPWcfJnc15I9Ca6U7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719033265; c=relaxed/simple;
	bh=buuKxO5nluzeMBoLsTf8U8JGcYeOfjqV8bO02Qp/Dlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Azzt8T4hV7nMEiw5tKkosivwxKyxEA2TkWMq02IS8Xrig0GpHN0xJ9gJ2aVlezTIVmb9++nnfvjM8beiz1oUNqVTvfV7oq2Nn9A0tXOtU523XD+snQPGJuhIvrH3lvteqWqoqrSZJ76FMOPpMKWOeuxQiuhTsvM6wWZH31/UMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0838168CFE; Sat, 22 Jun 2024 07:14:21 +0200 (CEST)
Date: Sat, 22 Jun 2024 07:14:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-pci: limit queue count to housekeeping cpus
Message-ID: <20240622051420.GC11303@lst.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de> <20240621-isolcpus-io-queues-v1-2-8b169bf41083@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-isolcpus-io-queues-v1-2-8b169bf41083@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9638b25fd521..43c039900ef6 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -11,10 +11,23 @@
>  #include <linux/smp.h>
>  #include <linux/cpu.h>
>  #include <linux/group_cpus.h>
> +#include <linux/sched/isolation.h>
>  
>  #include "blk.h"
>  #include "blk-mq.h"
>  
> +unsigned int blk_mq_num_possible_queues(void)
> +{
> +	const struct cpumask *io_queue_mask;
> +
> +	io_queue_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
> +	if (!cpumask_empty(io_queue_mask))
> +		return cpumask_weight(io_queue_mask);
> +
> +	return num_possible_cpus();
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);

This should be split into a separate patch.  And it could really use
a kerneldoc comment.

> -	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
> +	return blk_mq_num_possible_queues() + dev->nr_write_queues + dev->nr_poll_queues;

Please avoid the overly long line here.

Otherwise this looks good to me.

