Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2D20D51F
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239075; cv=none; b=bg6k7Lwgu2C0tHd8iaEGUI4/xFrdiFPUlnoRz5P4bTqNq4T4BRMzY5HfvlXglMnzm7LYfjo0U/YivA9lJOKHXdgWM8HPezfwp1x3eCVK4R5xKKNYe/R8oQMbMXV+NAQKZH5NaWBqD3lmy9YPFNhFfirLMpx6ucgO0/YzfYAplrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239075; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFXgXDkjwz/BqnKUEch10KFFknHAsBhw5yWfKmHCKaZxW2h2sI+JU/aPSqvYX9gBxc7sgVeP26N1EO2+CrwOGdBUqzjBUV3JZ8Nf11D28PqVCElckQycZe1xG1gzYgsSog0iOmZbUCc9UPuRFGhE7CQL++rFdkVbbDVyC3rh7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD3C568AFE; Mon, 21 Apr 2025 14:37:48 +0200 (CEST)
Date: Mon, 21 Apr 2025 14:37:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 05/20] block: move sched debugfs register into
 elvevator_register_queue
Message-ID: <20250421123748.GA24202@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com> <20250418163708.442085-6-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418163708.442085-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

