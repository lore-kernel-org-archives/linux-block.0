Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20CCA64
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305667; cv=none; b=bxnDPCHiMD5rH3zKYasxMt9+Tc4DUdGpcE96dEWd+ifS1BUh8kR2BGjmNUmT4Vn9v1QWx4B6cF9c1Caa3EfdGzu6ARIxeMH3ZjY6q6jz568kDk9oEO8jf+tB2VS19BBywph1HM7t3VJuNuDMM21VgqrC3YhiND4JCcLR7gYMcEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305667; c=relaxed/simple;
	bh=71fVn7EIfkt+Baz4zC5DHDwKuoAmesD2QIgRHoTQuhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ+MnAJnYgDhgKzBwRfSrG3LV/3YBmaHOhe0Da9oaAAVb/HIBOHazo1xFUnENFimJ02fTX1XsimadGYUHaxaMBlDSqUyROpPeWwhuf8sya4GrZWddkRD7lkN6cfj9etgc//HJD8kqYnP3YARLg9viiWNT94y8ODDpwMFvkAcFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4385268AA6; Tue, 22 Apr 2025 09:07:40 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:07:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 12/20] block: add `struct elv_change_ctx` for
 unifying elevator_change
Message-ID: <20250422070739.GC30990@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com> <20250418163708.442085-13-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418163708.442085-13-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Apr 19, 2025 at 12:36:53AM +0800, Ming Lei wrote:
> Add `struct elv_change_ctx` and prepare for unifying elevator_change(),
> with this way, any input & output parameter can be provided & observed
> in top caller.
> 
> This way also helps to move kobject & debugfs things out of
> ->elevator_lock & freezing queue.

As pointed out last time, please move the entire loop body that
calls __elevator_change from __blk_mq_update_nr_hw_queues into a
helper inside of elevator.c, which means that this structure can
be kept private there.

Also please use a flags value with named flags instead of the various
booleans.

