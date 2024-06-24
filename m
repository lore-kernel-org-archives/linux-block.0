Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0718E29;
	Mon, 24 Jun 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218830; cv=none; b=B2VrdyQNEfYrxqcDZwlf2JHepuH4UwcYqxXLUkjP1btYFRGGE2rxOoy4uqVWJhnVB6y8B5YuwMUmDToz59Ycbxx7PjJ5yCnCRIU9819bAhKPpcRuOMhGOlNUiF0rvwPx1I1IHMNGtEZlebSnBnD80HBIJsIKf+0AH7uOEQbIQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218830; c=relaxed/simple;
	bh=qeet0RtAm9g1lKDvB5CrRQDn6qEdIqwsJ93yWzBvHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raBOWYPn5MsoSAUUZIUhTOIpR35Zs4RrU8q/uDWIELCERropABo2T1WKuC9gHLbkZkQpciUZsHjGUnlsqh1d/Xocf+bLM0TnRwciyLGjEqcpiRn8URARKgKyokeB7NL8f4CKNYrlrltSlawins3993xA894UKVki/EUM787av+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DDE1068B05; Mon, 24 Jun 2024 10:47:05 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:47:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <20240624084705.GA20292@lst.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de> <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de> <20240622051156.GA11303@lst.de> <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 24, 2024 at 09:13:06AM +0200, Daniel Wagner wrote:
> On Sat, Jun 22, 2024 at 07:11:57AM GMT, Christoph Hellwig wrote:
> > > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > > index 2b461129d1fa..fe751d704e99 100644
> > > --- a/include/linux/sched/isolation.h
> > > +++ b/include/linux/sched/isolation.h
> > > @@ -16,6 +16,7 @@ enum hk_type {
> > >  	HK_TYPE_WQ,
> > >  	HK_TYPE_MANAGED_IRQ,
> > >  	HK_TYPE_KTHREAD,
> > > +	HK_TYPE_IO_QUEUE,
> > >  	HK_TYPE_MAX
> > >  };
> > 
> > It might be a good time to write comments explaining these types?
> 
> Sure, will do.
> 
> Do you think we should introduce a new type or just use the existing
> managed_irq for this?

No idea really.  What was the reason for adding a new one?  The best
person to comment on this is probably Thomas.
