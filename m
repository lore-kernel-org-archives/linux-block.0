Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15028C5C5
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295145; cv=none; b=peBW4OdCKeVMsCfAOoNHSWcvc7Nn0pBiQD4ynGW6OntXun0smLutaPq3oQBeFGwmlFF50R2hRvaQIbiYrXIjmjcQ9fWa+SrxYITAToSny09AsU59GCeMDpidMmwW4ID73Yy3oCyibwHjvc7kTRuIa2+0M1iQM+sxied25P4USYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295145; c=relaxed/simple;
	bh=7NowHJSUH2pyVHnofEQ6kECHa4gWepocJr/qTnQ33bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7Zpm374ORkh+t4mkjin9pgMFJm9QfUSYMM8J+3RMSukViBI52eW8+Rtj/bcWiXs9tJe/3kaGj4GPuMvBlN5aVIB+SG/OEwqXoYP6Lna2WFJUJlcM8ubsRsmf+byA0RMrqQAMXQxDvH2KGWUxPvMCwJBoSPmq8QHKbZb1hEepZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CDD9368B05; Thu, 10 Apr 2025 16:25:30 +0200 (CEST)
Date: Thu, 10 Apr 2025 16:25:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/15] block: add two helpers for
 registering/un-registering sched debugfs
Message-ID: <20250410142530.GA10701@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410133029.2487054-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 09:30:14PM +0800, Ming Lei wrote:
> Add blk_mq_sched_reg_debugfs()/blk_mq_sched_unreg_debugfs() to clean
> up sched init/exit code a bit.

This not just adds the new helpers, but also changes where the
hctx registration and unregistration is called.  From a quick look
this looks fine, but please document it and explain why it is safe
and desirable.

