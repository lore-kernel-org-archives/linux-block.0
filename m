Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0487C1DFF5
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081966; cv=none; b=q7SYcCflWeZlPyGfpu6l7n/rpKrnm0RmNp/OQemgEAOilZL/9nnYZz3x/UUbI73TI3xq9QD6STu+hCO1PT9lnzU/vrwyBAKEUPTXV/Q5/Z4HN2fhjvJqgZKuy9D0W+DxHtwMH+mm88LGKFsdvS2VvRAHXZ++Nr6dtsWwc5il6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081966; c=relaxed/simple;
	bh=nx9qVDTCYZ+O1yf9BjEdeEkqLqEd+5Bd/uBc1KLobmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHtBp3j2++No0g123P0NUF5FjCz9TDHWg5cDWJ7nvatS80aryKNvKbcqpHWrAK2w7ywT/HTxtMltEFKj27OKIk7sYVgyrpJPC3ozgnTCwcn6wcd1KWPQmS8sB/Y4eJ7leM9c+Cbz9YFMgc2HYwVSv0ezpuqjupVE0fB11pnGt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E85D227AAF; Wed, 16 Oct 2024 14:32:41 +0200 (CEST)
Date: Wed, 16 Oct 2024 14:32:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241016123240.GB18219@lst.de>
References: <20241009113831.557606-1-hch@lst.de> <20241009113831.557606-2-hch@lst.de> <Zw-e_CtNKeLJ3q1a@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw-e_CtNKeLJ3q1a@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 16, 2024 at 07:09:48PM +0800, Ming Lei wrote:
> Setting QUEUE_FLAG_DYING may fail passthrough request for
> !GD_OWNS_QUEUE, I guess this may cause SCSI regression.

Yes, as clearly documented in the commit log.

> 
> blk_queue_enter() need to wait until RESURRECT & DYING are cleared
> instead of returning failure.

What we really need to is to split the enter conditions between
disk and standalone queue.  But until then I think the current
version is reasonable enough.

