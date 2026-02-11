Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBC72D9EF0;
	Wed, 11 Feb 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824589; cv=none; b=p66/0K46Sea7pAONyCZxjJY1owNGahWQxGzwUrW0BV+pT459hcYLSKPvHlsIMwoEFOVryLTji8Zn4kqYmWvpRDac90y5THcv7AVtdaunS6WX0WckKWO5DiZizLF1lol25UEMno1WLxwtaa7sXHoKMQ7vpSvkXiwmcsdjv3ufd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824589; c=relaxed/simple;
	bh=Our+RXGlwLz6j296ZYkaEHksT17m9rMxAqPteuXv8ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIE584DeHfCMjTbuoewh4h9TxrMfugUokeKL2annmVGJ3mLo+3+EPeWxAZT/XbIVPR+eMXY2FTb+Aq62H82DvZ2xjos07Op1xB2H36eRJXVHhRSDrhDYTce878hzB/qsLxKt8+Yz1QJT6KQABTVgE9UO7JNankS6lk+/aw8uqQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7470968C7B; Wed, 11 Feb 2026 16:42:57 +0100 (CET)
Date: Wed, 11 Feb 2026 16:42:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] block: allow IOC_PR_READ_* ioctls with BLK_OPEN_READ
Message-ID: <20260211154257.GA10237@lst.de>
References: <20260210163617.144359-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210163617.144359-1-stefanha@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 10, 2026 at 11:36:17AM -0500, Stefan Hajnoczi wrote:
> It is safe to reduce the permission requirement from BLK_OPEN_WRITE to
> BLK_OPEN_READ since these two ioctls do not modify the persistent
> reservation state. Userspace cannot use the information fetched by these
> ioctls to make changes to the device unless it later opens the device
> with BLK_OPEN_WRITE.

Hmm.  How often do we give unprivileged users access to the block
device node anyway?  But I guess if they can read all the data on
the device, they might as well see the reservation holders as well:

Reviewed-by: Christoph Hellwig <hch@lst.de>

