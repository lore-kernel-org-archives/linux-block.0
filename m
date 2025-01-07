Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C66ECC
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230728; cv=none; b=TlSJrNuBslXco/gcC9Hyll7mnGwCKnp0zZqkrOl8dSJCtcB8q3AC9zWoTwDY96hBtIv6m9+lhU+tN9EmdoRFFYbAqLAFnI9HTsBb/9S29y6cC+38Omo2NrVcjEUXOOVKHxWLqCOsE+Qxl4xl850MAcY45t26tzzIJhDQCQb/NC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230728; c=relaxed/simple;
	bh=/E4X4+BdCHtmiuxI8LIJLEPa0QjBDVTxrqH6WgzDm5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Md5RmbVpiXXhpbY1WPJSh5S38d9FYXcITJGeRfOf8i0xh/wwEpodGeIs8kPeaWaoGTKfqJrGZxSs425N4x0G3JNS/HqKgltutsnvYJxqGiWqk89dWrGN9bIYp0xJsFdg0YzU0RcLYGHJJL8PLvZIEhYGkO1XHIrXIhz1Jg2Q3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7141167373; Tue,  7 Jan 2025 07:18:42 +0100 (CET)
Date: Tue, 7 Jan 2025 07:18:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <20250107061842.GA14021@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-2-dlemoal@kernel.org> <Z3tOn4C5i096owJc@fedora> <20250106082902.GC18408@lst.de> <Z3u7Twc4UPWvlfJJ@fedora> <20250106152931.GC27431@lst.de> <Z3x5F3_GIkD4sxl7@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3x5F3_GIkD4sxl7@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 07, 2025 at 08:45:11AM +0800, Ming Lei wrote:
> > No, we had various bug reports due to it, including racing with other
> > updates.  Let's stop trying to take shortcuts that will byte us again
> > later and sort this out properly.
> 
> Can you share the bug reports? I am curious how it happen.

Try to search old scsi and nvme list reports for trouble, one case
with the discard limits, the other about the max sectors.

