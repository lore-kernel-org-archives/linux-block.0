Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2222F3B;
	Sat, 22 Jun 2024 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719033123; cv=none; b=lBBv3b3xu5XTnm5ans6POHtkDdSPGh7DK/MZzL1AquC3AZbYMfz6kpBV94RJA290nECWKtPkuvPT6/gUL+aIHihH6yClGqcG7waMuezUIr1a48krUvsa90kIRhsSjNrB4W1wCgpj84Ad5jDeWzfP+8SnoDO1NU0X66p6C/bXERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719033123; c=relaxed/simple;
	bh=N8OL5MbRF+25fuK878dj1vlC+U0d0d3B7mAxYg3cA1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5zaAysc6jby6bH6+k6eM2xq+STk3MYtm5YNdd6mnn1HtsyBV19+mTVt8wHqOg/WYbcoVsVl0qw1KzVxs0RqedFKRhtcSE33glgu+aI6pmyYNRYs+W0B4X7ogpL2JchG0luHqcNH43cSBtqfFeUNUAihHBft+UrED2lbX1bxDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E39668C7B; Sat, 22 Jun 2024 07:11:57 +0200 (CEST)
Date: Sat, 22 Jun 2024 07:11:57 +0200
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
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <20240622051156.GA11303@lst.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de> <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 2b461129d1fa..fe751d704e99 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -16,6 +16,7 @@ enum hk_type {
>  	HK_TYPE_WQ,
>  	HK_TYPE_MANAGED_IRQ,
>  	HK_TYPE_KTHREAD,
> +	HK_TYPE_IO_QUEUE,
>  	HK_TYPE_MAX
>  };

It might be a good time to write comments explaining these types?

