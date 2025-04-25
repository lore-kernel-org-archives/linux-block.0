Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F825211290
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606287; cv=none; b=WCwoeoLHeyaqQEq6aQD50VXdSAEQLSlRhwZFJhe1xXg9y7y0pxiiZTnIeYi84zt6zDAZe3WoTEQlX6moYV7u3hF9OWe8Fk0qdkN6equvhnlz5zbFoRV9ex9ZunO6j8WiRyiX5kB05jDuSfs2JqaLw+egGDWuXN83eet8hNIs9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606287; c=relaxed/simple;
	bh=0Ittqlwt5ersVC3W45PGEM1lXdDXFjas+DhSmKOyOc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzG5vAbM4y/KEtDK6iVrP/+JejF61oVa1GW3Pf78/IT5NCV0H9xr9e5jAdopcpyzHIUaZGPAldkLekL9o+5f/2KoT8YP3djFByyNgPjyVFVepzAGLuly9YMjzo6BYy9eXkskpGJIu8eYQbrgUSMOOOs4jdKi7pQkzg0pz2Cpsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 376B468BEB; Fri, 25 Apr 2025 20:38:02 +0200 (CEST)
Date: Fri, 25 Apr 2025 20:38:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 17/20] block: move debugfs/sysfs register out of
 freezing queue
Message-ID: <20250425183801.GC26393@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com> <20250424152148.1066220-18-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424152148.1066220-18-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 24, 2025 at 11:21:40PM +0800, Ming Lei wrote:
> Move debugfs/sysfs register out of freezing queue in
> __blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
> can be killed:
> 
> 	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
> 	#1 (fs_reclaim){+.+.}-{0:0}:
> 	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs
> 
> And registering/un-registering debugfs/sysfs does not require queue to be
> frozen.

Please explain the why it's not required.  And talking about lockdep
dependencies is not very useful - it either is an actual lock ordering
issue or a fale positive, but lockdep is just the messenger.
