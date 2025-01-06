Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3EE2BAEC
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152049; cv=none; b=fdNkiDSi+razxKhcCZYOtIwcixCQH30yHAAPgczAo50Nss9fK+uMhjh9ow4DOcS7cSARPfbZUhZAVPQ7pH5UBHbObyErMA5oQrcl5AsKDwEYegBob9CKG5+iyhk6ePyQ5TYjN9w605EHQGp74E93CBq4WijSbqHjoCa6ZBLkXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152049; c=relaxed/simple;
	bh=c9Y0DVqueCk0UCTr9RI6gpPIb+TrMQ61OaZmxAw196k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkoKweMGSYz22G6ZkQpAzVUhFHgX+4phvvoeLiHZEENckWwdGr3utcu7lelv9BWHDn8jpAP65x3Kd78q/NwppYrCR9ampK1a69o/nnnxR++bMWShLL0nS7GFzdAouJa/RWX+ewMUaClFRHsgoyJB0xM+mMWPoFOnLzdD1mFcMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AE0968BFE; Mon,  6 Jan 2025 09:27:22 +0100 (CET)
Date: Mon, 6 Jan 2025 09:27:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <20250106082721.GB18408@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-2-dlemoal@kernel.org> <977ab809-ba06-4537-b568-cc25f56b5b7a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977ab809-ba06-4537-b568-cc25f56b5b7a@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jan 04, 2025 at 09:56:14PM +0530, Nilay Shroff wrote:

[can you please quote your mails properly, having to scroll pages of
fullquotes isn't very readable]

> > +	if (entry->store) {
> > +		blk_mq_freeze_queue(q);
> > +		mutex_lock(&q->sysfs_lock);
> > +		res = entry->store(disk, page, length);
> > +		mutex_unlock(&q->sysfs_lock);
> > +		blk_mq_unfreeze_queue(q);
> > +		return res;
> > +	}
> > +
> Can we move ->sysfs_lock before freezing queue? We follow the locking order 
> of acquiring ->sysfs_lock before freeze lock. For instance, we've these 
> call sites (elevator_disable(), elevator_switch()) where we first acquire 
> ->sysfs_lock and then freezes the queue. It's OK if you think this patchset
> fixes locking order between limits lock and queue freeze and so we may address 
> it in another patch. 

sysfs_lock as-is doesn't make much sense.  The sysfs (actually kernfs)
core already serializes ->store and ->show calls vs themselves and
attribute removal, and the limits lock protects the actual limits.

The problem is that the block code also abuses the lock for various
other things, so this is non-trivial.

What I've done in my version of the series is to drop it just for the
limits method for now.

