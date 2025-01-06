Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804A1DDA3B
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186735; cv=none; b=G1tt0EhbN1AgCnsxMD5LaztJhZlxVcYoMMu+g/oU9WWJwTpgQ2yKZ7shlksHVSrDdav8dGcLvUqxMLzY4Y+JuCgccgZ+HH6r7CM6gzlMnGo7aqiuEzZEH3g3FKATJgirvsaEVMhxVKzv8NsFsmiUdEqzqbdUbln7mM+A3JF+w6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186735; c=relaxed/simple;
	bh=0iW+CXGDWJpU4F9OEJEhjTv7vAy41E18NSyCLlv5H6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsRkp+bilL6wOC60Zgd1JErmKIsugsOkZK/1zUVXjmfXG6jFiZdXKZWFvRKAD9K/v1DeKDOrznZNwbcvlZ9MlbwqHar95XuWmFsxLmBE+HBOweER54NsXeBKZ3k1BBiY4c5oNZQz+RYapV8gaPJwLniNoLgbqxGPeFQCWTqHVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 62FC868C7B; Mon,  6 Jan 2025 19:05:28 +0100 (CET)
Date: Mon, 6 Jan 2025 19:05:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <20250106180527.GA31190@lst.de>
References: <20250106142439.216598-1-dlemoal@kernel.org> <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk> <20250106152118.GB27324@lst.de> <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk> <20250106153252.GA27739@lst.de> <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk> <20250106154433.GA28074@lst.de> <5f57ff26-2c87-45fa-bb91-4f68492bac85@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f57ff26-2c87-45fa-bb91-4f68492bac85@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 10:38:24AM -0700, Jens Axboe wrote:
> > just not on the same page.  I don't know anything existing and usable,
> > maybe I've just not found it?
> 
> Not that I'm aware of, it was just a suggestion/thought that we could
> utilize an existing driver for this, rather than have a separate one.
> Yes the proposed one is pretty simple and not large, and maintaining it
> isn't a big deal, but it's still a new driver and hence why I was asking
> "why can't we just use ublk for this". That also keeps the code mostly
> in userspace which is nice, rather than needing kernel changes for new
> features, changes, etc.

Well, the reason to do a kernel driver rather than a ublk back end
boils down to a few things:

 - writing highly concurrent code is actually a lot simpler in the kernel
   than in userspace because we have the right primitives for it
 - these primitives tend to actually be a lot faster than those available
   in glibc as well
 - the double context switch into the kernel and back for a ublk device
   backed by a file system will actually show up for some xfstests that
   do a lot of synchronous ops
 - having an in-tree kernel driver that you just configure / unconfigure
   from the shell is a lot easier to use than a daemon that needs to
   be running.  Especially from xfstests or other test suites that do
   a lot of per-test setup and teardown
 - the kernel actually has really nice infrastructure for block drivers.
   I'm pretty sure doing this in userspace would actually be more
   code, while being harder to use and lower performance.

So we could go both ways, but the kernel version was pretty obviously
the preferred one to me.  Maybe that's a little biasses by doing a lot
of kernel work, and having run into a lot of problems and performance
issues with the SCSI target user backend lately.
