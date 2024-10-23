Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2F19F13C;
	Wed, 23 Oct 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685972; cv=none; b=Lqv1AcsYjzp6KC6/rBD7wjzYESbfX8lfUkA6/Jg1ZOt2aKaIFjcvqGvm/M6BepNhMBlCy30y/rDwaTHgoZkQpNPtMxeUKR7lj4NQ19zuNYM2IM+iMNFFJj10oKBgulfGXh/QokxslTnHTl08A5HiigMXZXGSTJhYCxucmme+YZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685972; c=relaxed/simple;
	bh=ZLSUev1bwzmlDdeEv/itjWCo/kEZ5BkvCurPAsz6XOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScZaQnYngUK4Xe4tVCRN90huCVzpmv8+w3NbW87lLgPMS4g1Xvh/71ycz1BB+VWcTzatbnaswBTJkG+yv1LsHwn0FZpfpX6D+F66DHyFSz5eyrbPNbgoPHWUrPyt1CGcIHWRP+QMqDUmfHOiuu9pKfhcyEvZUYBQbZ5bIk5va4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0D20B227A88; Wed, 23 Oct 2024 14:19:25 +0200 (CEST)
Date: Wed, 23 Oct 2024 14:19:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/3] blk-mq: add non_owner variant of
 start_freeze/unfreeze queue APIs
Message-ID: <20241023121924.GA28777@lst.de>
References: <20241023095438.3451156-1-ming.lei@redhat.com> <20241023095438.3451156-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023095438.3451156-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +/*
> + * non_owner variant of blk_freeze_queue_start
> + *
> + * The queue needn't to be unfreeze in current task, and non-owner use is
> + * fragile and easy to cause race, please try your best to avoid it

Maybe say:

 Unlike blk_freeze_queue_start, the queue doesn't need to be unfrozen
 by the same task.  This is fragile and should not be used if at all
 possible.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

