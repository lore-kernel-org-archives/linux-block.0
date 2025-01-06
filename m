Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1082D98
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177378; cv=none; b=iFUh9h8mLdE0/KY4FgEMtmyFghmEOugOjT8oP0WTEu5BTjXVAhppD+nDsMLvrXdHgheStqQC+HmYz4tn7/2nkcT5z7JiSL3HkIRIzOZ8znx1Hb1ukmMPZC57MuOpUZonWBkzszA14ZeflsXblvA6kuIfbbXajoJ5GGp4zICNQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177378; c=relaxed/simple;
	bh=AfYAWmfGdU3HFedD1sztyr60cIzuChdD09/oRqr59cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFicFAtW+ed2YRreiLTfN8wgpnFFPokduZAXevWw00/fbqeJJvUrwyN2Wpv4X+jPUbNmiwt+KM9CEcfXjHUjTY05Z+fkLncWEvZ5N/ior95xSKxGsh3TJeGroxharwDSuldMK8Zh85vWFSXauYVcs24CvRlkkiCfSD/FJYCBQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 20E4F68C7B; Mon,  6 Jan 2025 16:29:32 +0100 (CET)
Date: Mon, 6 Jan 2025 16:29:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <20250106152931.GC27431@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-2-dlemoal@kernel.org> <Z3tOn4C5i096owJc@fedora> <20250106082902.GC18408@lst.de> <Z3u7Twc4UPWvlfJJ@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3u7Twc4UPWvlfJJ@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 07:15:27PM +0800, Ming Lei wrote:
> On Mon, Jan 06, 2025 at 09:29:02AM +0100, Christoph Hellwig wrote:
> > On Mon, Jan 06, 2025 at 11:31:43AM +0800, Ming Lei wrote:
> > > As I mentioned in another thread, freezing queue may not be needed in
> > > ->store(), so let's discuss and confirm if it is needed here first.
> > > 
> > > https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/
> > 
> > We do need the freezing.  What you're proposing is playing fast and loose
> > which is going to get us in trouble.
> 
> It is just soft update from sysfs interface, and both the old and new limits
> are correct from device viewpoint.
> 
> What is the trouble? We have run the .store() code without freezing for
> more than 10 years, no one report issue in the area.

No, we had various bug reports due to it, including racing with other
updates.  Let's stop trying to take shortcuts that will byte us again
later and sort this out properly.

