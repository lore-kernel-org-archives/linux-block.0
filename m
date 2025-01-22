Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC41BC063
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527294; cv=none; b=bF1n2yVI3PqY9lcM5VjulfubUpFOBbj2lgZyuAfgsKvBOfOX7s4y8uN9+xJ3jqb8JYDVL70iZGdzUqWcVDFOwsFaB7SrJ0GO6oKPAEe7qHHQ3g4VV1V3HEgiatTBdjMbjk1xO3+jEk6dZ+TPaSVuuW0ReLFztYhO7PCtPj4KA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527294; c=relaxed/simple;
	bh=bG4gzu8uPUCOudfmUG/xL/41cshQltkymC8Wth3pGCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw9A8f2AE7D6EnjjnmF8It/TXR+NG4q5kyvejDB+07fE0RUrG48Bh3x02DpyQktlceM6HZYpTsafWBSUdA4tY7QR6Q1UUfNuQHqZ+L6hFhfruFg8nDaRajvYgiNIMi6CR0n9C+VhCV7JT42hTkQUpdes/j0zFAzBnt9gtS5iaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BC1B68D05; Wed, 22 Jan 2025 07:28:07 +0100 (CET)
Date: Wed, 22 Jan 2025 07:28:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [RFC PATCH 1/1] block: get rid of request queue
 ->sysfs_dir_lock
Message-ID: <20250122062806.GA30750@lst.de>
References: <20250120130413.789737-1-nilay@linux.ibm.com> <20250120130413.789737-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120130413.789737-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 20, 2025 at 06:34:11PM +0530, Nilay Shroff wrote:
> The request queue uses ->sysfs_dir_lock for protecting the addition/
> deletion of kobject entries under sysfs while we register/unregister
> blk-mq. However kobject addition/deletion is already protected with
> kernfs/sysfs internal synchronization primitives. So use of q->sysfs_
> dir_lock seems redundant.

From the pure sysfs perspective, yes.  The weird thing with block
layer sysfs is that unregistration/registration can happen at weird
times, though.

> Moreover, q->sysfs_dir_lock is also used at few other callsites along
> with q->sysfs_lock for protecting the addition/deletion of kojects.
> One such example is when we register with sysfs a set of independent
> access ranges for a disk. Here as well we could get rid off q->sysfs_
> dir_lock and only use q->sysfs_lock.
> 
> The only variable which q->sysfs_dir_lock appears to protect is q->
> mq_sysfs_init_done which is set/unset while registering/unregistering
> blk-mq with sysfs. But this variable could be easily converted to an
> atomic type and used safely without using q->sysfs_dir_lock.
> 

So sysfs_dir_lock absolutely should go.  OTOH relying more on sysfs_lock
is a bad idea, as that is also serialied with the attributes, which
again on a pure sysfs basis isn't needed.  Given that you don't add
new critical sections for it this should be fine, though.

> So with this patch we remove q->sysfs_dir_lock from each callsite
> and also make q->mq_sysfs_init_done an atomic variable.

Using an atomic_t for a single variable is usually not a good idea.
Let's take a step back and look at what mq_sysfs_init_done is trying
to do.

It is set by blk_mq_sysfs_register, which is called by
blk_register_queue. before marking the queue registered and setting the
disk live.  It is cleared in blk_mq_sysfs_unregister called from
blk_unregister_queue just after clearing the queue registered bit.

So maybe we could do something with the queue registered bit, although
eventually I'd like to kill that as well, but either way we need
to explain how the flag prevents the nr_hw_queues update racing with
disk addition/removal.  AFAICS we're not completely getting this
right even right now.  We'd probably need to hold tag_list_lock
over registering and unregistering the hctx sysfs files.

