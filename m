Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9328C5B9
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296052; cv=none; b=oHUUysINCRsqC784pX8M37MKdzO0NqSvLOsV1KaTlkk7sc4sV5q2E8qDSuqHc6/qaO0/+XkbLoLWDMd9CWvRSmrDiHhQTlYeuwX/oRpA9JkezZk4lP2B0hDswNaEXjJZNHMADH3WMk4e5yyuQtAbFF8iMixN2IZPwDvAMBPSktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296052; c=relaxed/simple;
	bh=SIx6m9wwJZxikARVHtNrW2C6s5P0HT2rUFqxUK6jFEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtAKyV3LQ+spvGQQY+t12bhcsnUZCdalh+AgK6eBhOqHo4qUEffY+GrB9n7283zq7USAs9ZivuN1OI5YzeshoW0Juk2iQ/dRqMPh7jTzafCE5ANlMwIy+6025TMoyGJIsAuntl07RsrtCWN0FrwLZeb6f/5Z+G817i7EabKL2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB8A268B05; Thu, 10 Apr 2025 16:40:44 +0200 (CEST)
Date: Thu, 10 Apr 2025 16:40:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/15] block: simplify elevator reset for updating
 nr_hw_queues
Message-ID: <20250410144044.GD10701@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-6-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410133029.2487054-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 09:30:17PM +0800, Ming Lei wrote:
> In blk_mq_update_nr_hw_queues(), nr_hw_queues may change, so elevator has
> to be reset after nr_hw_queues is changed.

This should be past tense I guess?

> Now elevator switch isn't allowed during blk_mq_update_nr_hw_queues(), so
> we can simply call elevator_change() to reset elevator sched tags after
> nr_hw_queues is updated.

Now that elevator switches aren't allowed during
blk_mq_update_nr_hw_queues(), we can simply call elevator_change() to
reset elevator sched tags after nr_hw_queues is updated.

?

Anyway, glad to see this code go away!

Reviewed-by: Christoph Hellwig <hch@lst.de>
