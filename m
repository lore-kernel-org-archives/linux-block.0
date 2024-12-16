Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2878313D61B
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364155; cv=none; b=s7/lWst/uQuWwtusbvdiJkkoFYfbw0m/6Q+0S78URfpE/teWmpv9BT+/KO1cpqOEb6Efsj2rg+/aNoqmRP5ZyI38Ttcc8vUnfq+vPUh1i/zfNdPA1+gr7DKx7Vn6OzQDzugcsTOpB7nEEGlQiz7OsOmRtNbQbzugOi+TX2K4F78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364155; c=relaxed/simple;
	bh=HcekoDiA53UAsqB1MkD+UKreqwbzDpNohH5pxgj7Erc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP0NH4WBRmXYRLmWUyAcBEw2D7zhirMRsNPEOs4qmuhCsAolG6QHLKyS1mQxGwIRb4i5F5cRB/88FumXCYGklFRkV+cGddItjSaw2k7eUTQAgtxu4MMZfyQoNu0lC7pL6aF08n5EdF4wjytHzkX2iR6EfuEWf5nJYX0D6CTEOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA0BA68C4E; Mon, 16 Dec 2024 16:49:01 +0100 (CET)
Date: Mon, 16 Dec 2024 16:49:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs
 for atomic update queue limits
Message-ID: <20241216154901.GA23786@lst.de>
References: <20241216080206.2850773-1-ming.lei@redhat.com> <20241216080206.2850773-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216080206.2850773-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 16, 2024 at 04:02:03PM +0800, Ming Lei wrote:
> More importantly, queue_limits_start_update() returns one local copy of
> q->limits, then the API user overwrites the local copy, and commit the
> copy by queue_limits_commit_update() finally.
> 
> So holding q->limits_lock protects nothing for the local copy, and not see
> any real help by preventing new update & commit from happening, cause
> what matters is that we do validation & commit atomically.

It protects against someone else changing the copy in the queue while
the current thread is updating the local copy, and thus incoherent
updates.  So no, we can't just remove it.

