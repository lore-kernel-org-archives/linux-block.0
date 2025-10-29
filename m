Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C008248176
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728297; cv=none; b=Oqo9hiv3G1UxYQeYvGeu4unwTqWMbVejj6NBaASGlrkoozYlNlu+0IgXra7bZb0wR4RUSBZtEQRTG5L1pdsuGjImTeoiKsSyE4SS1fYEnOy8q05WSxQ5NwWKTxadbhAHD7Cpha05RvYd7xJ6G/yxXD5vOCdo+WFGOKcnkKtBk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728297; c=relaxed/simple;
	bh=xJnjeJfkjZ7dYnuqID88dmsQaTeZ04f6fh9gRc75lHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFOmZ1PXB189qLLHtFBUHZ19IA7zt1RhfQjql2tk4q+Io8/gI/WQTz0IT7JMas2sbIdpUApd6KfztW54Cj6JM6R1j8Yvn7NyyNGjXN/TcNajtOS07STyDM0GkVqKvpsNXK2IqAEfuFpQvsM5C9KFtUoJuraRWpvLLmEFS3tKcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 033E8227A88; Wed, 29 Oct 2025 09:58:10 +0100 (CET)
Date: Wed, 29 Oct 2025 09:58:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue
 attributes
Message-ID: <20251029085810.GA32474@lst.de>
References: <20250702182430.3764163-1-bvanassche@acm.org> <20250703090906.GG4757@lst.de> <918963a5-a349-433a-80a8-6d06c609f20e@acm.org> <20250708095707.GA28737@lst.de> <b23c05be-2bde-424a-a275-811ccc01567c@acm.org> <20250710080341.GA8622@lst.de> <563ef9b02d49fa05418c7a1b0b384d898819e0e9.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563ef9b02d49fa05418c7a1b0b384d898819e0e9.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 27, 2025 at 03:43:50PM +0100, Martin Wilck wrote:
> As Bart's patch only addresses the regression introduced by
> b07a889e8335 ("block: move q->sysfs_lock and queue-freeze under
> show/store method"), can we perhaps leave non-sysfs users of queue
> freezing aside in this context?
> 
> As far as sysfs users are concerned, what problem do you see with
> Bart's approach to introduce a timeout for freezing the queues, and
> returning an error to user space if this timeout is exceeded?
> 
> Would you be willing to accept the set if we'd use the timeout approach
> for all affected sysfs attributes?

Maybe it's because the discussion, but I have no idea what you are
trying to advocate for.  But a timeout for a locking operation is
not an option to work around deadlocks.

