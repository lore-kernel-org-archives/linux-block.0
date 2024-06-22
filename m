Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6DE2F3B;
	Sat, 22 Jun 2024 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719033200; cv=none; b=cio0J0KC1vHMsj+JfYPmkFo+tPLH8jHPiaZAYT0Jakb8u1LfemUctRyH3xUklxmOmHmOrUqO+xMNA78K0AgYjPa9E5ULFEdoIBpAoNrDtGZjo6QdxfbtIoBV9aYC7Glx3KcNIxkSSTmx4MyYTHdUmhROFhjXtwHAKcptsZzXK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719033200; c=relaxed/simple;
	bh=VqB7IMrNePBc6tjJRlZcbN6FLWL5MS2eWZeTwiRLYhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPmuQddioxbVtjTKim8xBmSh8joIKD/kfl/YTVQwfE2TFySBFOqa1sbdQJ9dBS2QuzoZE+DvQlL2Z5E7K6wxNt4yTr47XcuzCcOvdakOYadWa488zihtjvA4z7g4j/k9ogXurU+XLQBcHBZ1VYI0XlzMn59mAKK2bDr8PJH0qR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF51B68CFE; Sat, 22 Jun 2024 07:13:15 +0200 (CEST)
Date: Sat, 22 Jun 2024 07:13:15 +0200
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
Subject: Re: [PATCH 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <20240622051315.GB11303@lst.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de> <20240621-isolcpus-io-queues-v1-3-8b169bf41083@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-isolcpus-io-queues-v1-3-8b169bf41083@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Shouldn't this go before the current patch 2?

> +	io_queue_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
> +	if (!cpumask_empty(io_queue_mask))
> +		return group_mask_cpus_evenly(numgrps, io_queue_mask);
> +	else
> +		return group_possible_cpus_evenly(numgrps);
> +}

No need for an else after the return above.

