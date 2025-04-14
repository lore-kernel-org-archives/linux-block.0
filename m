Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E23917A303
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610888; cv=none; b=Xhl7DaeyDtyVQ+PHf7T6C0xjeEPhXkoVdRN55rKJ6ZTZI8CARrQKsSEWesjsx8QXlqBQBJQ4nAkpoSrexaZcMH9Rty3eS25BPHOD3Chr1m4aZurizVDNlrg5OkXIaF0XOsi+0CJImg3mmRUVebOxlJQjODPEYl/SON+x91NE24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610888; c=relaxed/simple;
	bh=Kf+QZSJyGf/8LOcCP0lU0SPd5AF8/QbFVh6JcNh7ZLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uP09DIS8dPY7qcQ2UGYHL0VyYaleyqMGGLgERx3fQ5R1dmfpO4HL1eXR2zAtsE6DcJ4ujFz7K6SiPb2cT0GQfrIXPTA3B8pGPOVlVOlxRpj7jEUwGDbqyfjrIcf+gMGM/ysXX6BybxtNIdIgXe8UVav8UEyulfb5f5QbKQsV2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BA5B68B05; Mon, 14 Apr 2025 08:07:55 +0200 (CEST)
Date: Mon, 14 Apr 2025 08:07:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 04/15] block: prevent elevator switch during updating
 nr_hw_queues
Message-ID: <20250414060754.GA6451@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-5-ming.lei@redhat.com> <20250410143622.GC10701@lst.de> <Z_xczMuX5_yDKdAs@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_xczMuX5_yDKdAs@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 14, 2025 at 08:54:36AM +0800, Ming Lei wrote:
> > >  	elv_iosched_load_module(name);
> > >  
> > > +	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
> > > +
> > > +	if (set->flags & BLK_MQ_F_UPDATE_HW_QUEUES) {
> > 
> > What provides atomicity for field modifications vs reading of set->flags?
> > i.e. does this need to switch using test/set_bit?
> 
> WRITE is serialized via tag set lock with synchronize_srcu().
> 
> READ is covered by srcu read lock.
> 
> It is typical RCU usage, one writer vs. multiple writer.

No, (S)RCU does not help you with atomicy of bitfields.

> > Also mixing internal state with driver provided flags is always
> > a bad idea.  So this should probably be a new state field in the
> > tag_set and not reuse flags.
>  
> That is fine, but BLK_MQ_F_TAG_QUEUE_SHARED is used in this way too.

Yes, that should also move over to the state field.  Amd rnbd needs
to be fixed to not set it diretly which is a good example for why
they should not be mixed..

