Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352A1CAB8
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578332; cv=none; b=CGpBx5H6eZnvDqGYDUz1PlPZh8nGNF2kyhvwPSWsGAKOiQY94dV425fwB3Fbautedl2ED9Zg8kwZd3PlHMcYvQpRFWj2dA5czvg7z1xtuZt/BvFIHViV2g9QMYGo9wi7QjULfPZRpsNIn0Sr1jEWXjTYlD7mreLQ/pm88Rlcd28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578332; c=relaxed/simple;
	bh=v6mSk6OKNPsplEjbGhg+prccYk6LuC72kR6YDaf2wHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nszWuLkz0ii/UgB/cOfild7jM2uNYpV1uwNUngmcBq8wCFZ9ohN4j8fyFTfFEiPQd5/3ezKVz1TIO6j1cECly3Ytkl2iM+5zAzyJ5HI16GjHHMbyqUzuY3QKa/u3PF+rAUumtBh63cGPD+EZIy3t+8KPasB3C7xLwDhCGG7jTRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 24ABE227ACB; Tue, 17 Sep 2024 15:05:19 +0200 (CEST)
Date: Tue, 17 Sep 2024 15:05:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
Message-ID: <20240917130518.GA32184@lst.de>
References: <20240917053258.128827-1-dlemoal@kernel.org> <20240917055331.GA2432@lst.de> <CAFj5m9JZe5g07YNVh6BL8ZixabRTrhx-AELxTxFNm9STM7gNzA@mail.gmail.com> <5ff26f49-dea6-4667-ae90-7b61908f67cf@kernel.org> <Zul97FvBsVuC1_h3@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zul97FvBsVuC1_h3@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 17, 2024 at 09:02:36PM +0800, Ming Lei wrote:
> 
> Here 'no_freeze' means that automatic 'freeze queue' isn't needed, or
> it can be named as 'no_auto_freeze'.
> 
> Again, 'load_module' is one bad name from interface viewpoint, which is just
> needed by 'scheduler' only.

If we want to reshuffle this we could have a ->store_unfrozen method
that does all the work.  But as long as the elevator loading is the
only thing that needs do to unfrozen work I'd just keep things as it
and not rock the boat.

