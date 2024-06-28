Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E084B5A6;
	Fri, 28 Jun 2024 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554577; cv=none; b=pxAhQqa2IFu2w0mQBXTw28YikjbGmK8tSSD6M5XxnQWwmujVZqKAyhsuqXqMgkTJ/mtZxA/m0DdvcFGvkuvKcTp1rIsnAxil5ozO2FS5evvxmnKGZup0VGXUQWoome+iW6S2UP+Y7xXxv+abTACieOJSiorSueAY4ip5tH41Dcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554577; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD0A/EvnMbL6N1JXNS846NekgEj8iNkZ/ROXXun79LTg7cEZp5EGI6udcfU+bt0xDEYHuQNa8OaqBxptXXm5KuGw8iFNhe2JLW6YNq0WOYi3RYzJt0ZltyMR8GUxSMWVZuGrELtk3ZZRNiznkI21nEF2H8FLVYSwC4ldAoYEBKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 77C3168D05; Fri, 28 Jun 2024 08:02:51 +0200 (CEST)
Date: Fri, 28 Jun 2024 08:02:50 +0200
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
Subject: Re: [PATCH v2 1/3] blk-mq: add blk_mq_num_possible_queues helper
Message-ID: <20240628060250.GA26297@lst.de>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de> <20240627-isolcpus-io-queues-v2-1-26a32e3c4f75@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-isolcpus-io-queues-v2-1-26a32e3c4f75@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

