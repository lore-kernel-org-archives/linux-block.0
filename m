Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19F13FEE
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299581; cv=none; b=QDcgQQOCN9Jenm1ZCx8b11LSKM7zz4MKEGfTWfkxDoud9EBRCpe2uzzRUQvQB4Ur73/p/HApknehSEWbkjf54w0B+kFjGcJUF5s49QifMmHAZG1aMzOg4G9fJDSlRJFmjw+LsKpb3JKF19OD9KtMhEeZz9EEF6yZrKpB5SOMtfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299581; c=relaxed/simple;
	bh=MJP11/QvfhvD18yrQkw6920l9kku52DISNJt3+SrcTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEqBOsbp/FAfIl4nMT12iXcgVeAoKTQjTbEPkD57jIUdZzoERIYS2UdXgmmyA0UPSy7uw9UdkDLxv/RrBPCUmPHo93KYkF2ZvGldZwkM1F+ISi13ziUf4XJXTBv7LVb0UhZiJo/3F1+dR+YgUSg/omUZvZuHuH58BbnkcpcKcgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83576227A8E; Wed, 30 Oct 2024 15:46:15 +0100 (CET)
Date: Wed, 30 Oct 2024 15:46:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] block: always verify unfreeze lock on the owner
 task
Message-ID: <20241030144614.GC32043@lst.de>
References: <20241030124240.230610-1-ming.lei@redhat.com> <20241030124240.230610-5-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030124240.230610-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 30, 2024 at 08:42:36PM +0800, Ming Lei wrote:
> commit f1be1788a32e ("block: model freeze & enter queue as lock for
> supporting lockdep") tries to apply lockdep for verifying freeze &
> unfreeze. However, the verification is only done the outmost freeze and
> unfreeze. This way is actually not correct because q->mq_freeze_depth
> still may drop to zero on other task instead of the freeze owner task.

Well, that's how non-owner functions work in general.

> Fix this issue by always verifying the last unfreeze lock on the owner
> task context, and freeze lock is still verified on the outmost one.
> 
> Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

What does this actually fix vs just improving coverage?  Because the
hacks in here look pretty horrible and I'd be much happier if we didn't
have them.

