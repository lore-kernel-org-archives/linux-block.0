Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D294261B80;
	Mon,  9 Feb 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658398; cv=none; b=hKhf91OPL2jfPNt0Ovq/8YcGVfgar2R4pSUUec+34WEru9jTd/fa4nWwLysEX+cVM31xgadTHWQkvzT3IoXcJOqQmL5UgmyUpNWbCkGjIrdmZ4ikA2W58xrlimyb9l1DftxynMp0gIS7VBzsP/dRpcsKj6ldVSSbpGNRZRPncCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658398; c=relaxed/simple;
	bh=2Hb+UNIiEGocniymuKs6cMDcwekIGmDxi7MXI9H+xkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeZTHHkAaZvHxbHtFQUCwiaOefo/51iX5aFfPxt7/FrhhsxzSn54CLopK76qdC1TevYVPWcOw2C/dk8MoKYAlt6UoR9EItY3nDLk+GCneopan9kcGeUKhuhNDKKoc4fWReN4zFOF3Vf1v+eG58mmAhYjCytphm2sJ0OMr154bgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHnD3ZUY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHnD3ZUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502B0C116C6;
	Mon,  9 Feb 2026 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770658398;
	bh=2Hb+UNIiEGocniymuKs6cMDcwekIGmDxi7MXI9H+xkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHnD3ZUYfRfwaMMY95GtqybyB4h3KN+nllONBz6jjwKHHN1hRec5/D9habNfjOlmK
	 vc/ODRS8TdWtgQw/I62uM6WlvAPsTKofYjwUnZAW/JrRad/LoRS2k6c389YCy51lz0
	 WwcpUT3rJiPFmrHW3u8Gch3xM4nLYsgpOU0nMJBvMZczPWZyzrAj8VH3WUXuKFFrjd
	 8E9P/FAyJa2QLp6hTzW7qz3Kxk/9dQ/ATXX+zTBvG0mK/8DoDu1ZZ4/8KzBj0zSzP3
	 mmx032WZh9Osrd9KZ6L4dxH5k4M35Qu8tWlReInMP3lQW1EpD7ALsV3qPTdgqjBpYt
	 BR/oSSGLXNAXg==
Date: Mon, 9 Feb 2026 10:33:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, sven@kernel.org, j@jannau.net,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com,
	neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs
 file creation
Message-ID: <aYoaWwI-sl5hK6s_@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-5-yukuai@fnnas.com>
 <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org>

On Mon, Feb 09, 2026 at 08:40:29AM -0800, Bart Van Assche wrote:
> On 2/9/26 12:29 AM, Yu Kuai wrote:
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index faeaa1fc86a7..03583d0d3972 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -613,11 +613,6 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> >   				 const struct blk_mq_debugfs_attr *attr)
> >   {
> >   	lockdep_assert_held(&q->debugfs_mutex);
> > -	/*
> > -	 * Creating new debugfs entries with queue freezed has the risk of
> > -	 * deadlock.
> > -	 */
> > -	WARN_ON_ONCE(q->mq_freeze_depth != 0);
> >   	/*
> >   	 * debugfs_mutex should not be nested under other locks that can be
> >   	 * grabbed while queue is frozen.
> 
> The above looks fine to me.
> 
> > @@ -628,9 +623,19 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> >   	if (IS_ERR_OR_NULL(parent))
> >   		return;
> > +	/*
> > +	 * Avoid creating debugfs files while the queue is frozen, wait for
> > +	 * the queue to be unfrozen and prevent new freeze while creating
> > +	 * debugfs files.
> > +	 */
> > +	if (blk_queue_enter(q, 0))
> > +		return;
> > +
> >   	for (; attr->name; attr++)
> >   		debugfs_create_file_aux(attr->name, attr->mode, parent,
> >   				    (void *)attr, data, &blk_mq_debugfs_fops);
> > +
> > +	blk_queue_exit(q);
> >   }
> 
> This is not clear to me. Why are concurrent queue freezes not allowed
> while debugfs attributes are created? I don't see any code in debugfs
> that calls back into the block layer while creating debugfs attributes?
> Did I perhaps overlook something?

I had to look up the original commit that introduced the WARN,
65d466b629847. The commit message says "Creating new debugfs entries can
trigger fs reclaim", so that must be the path that enters back into the
blaock layer request_queue.
