Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899E24634F
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408576; cv=none; b=ZUZvrHu5oam/t1NkyxFc0k5+rcP6YcByzJbo7HnYsb6tgaAUkFcoK70AALOeNXxZl3mRL1DyoTs49KHcnQYtGpbX456wseVORQlrA9Ng/QBaajuY5SgtcurPi6OgPNWzsR+cN8eGKa3ALGCjHF8vCdf1Ts8YqA6od4uOWpd768E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408576; c=relaxed/simple;
	bh=nQvwxenKg8zBuh7SIaHvZb3D8I9tSsngk2nI63gn4Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9YvBiTQ3xKX/0v0pgS61LTEH/SM6sZheqttPyd2e0TH2Dm3huX+KI9K7Ji1b18bMhETLP05Mbp5k5VXzFQrC46zaW2itoo/8ZPHftqT99U1pImkIOYAcqUdUNEP00AnYyBZemgrBcrnSUjv+LT7gFgI4fXDCa7kQqYpgBx/1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E20C368BFE; Mon, 24 Feb 2025 15:49:29 +0100 (CET)
Date: Mon, 24 Feb 2025 15:49:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, dlemoal@kernel.org, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
Message-ID: <20250224144929.GA2205@lst.de>
References: <20250218082908.265283-1-nilay@linux.ibm.com> <20250218082908.265283-2-nilay@linux.ibm.com> <20250218084622.GA11405@lst.de> <00742db2-08b3-4582-b741-8c9197ffaced@linux.ibm.com> <cecc5d49-9a54-4285-a0d2-32699cb1f908@linux.ibm.com> <Z7nGw_PJfAld8fAz@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7nGw_PJfAld8fAz@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Feb 22, 2025 at 08:44:51PM +0800, Ming Lei wrote:
> IMO, it is fine to read it lockless without READ_ONCE/WRITE_ONCE because
> disk->nr_zones is defined as 'unsigned int', which won't return garbage
> value anytime.
> 
> But I don't object if you want to change to READ_ONCE/WRITE_ONCE.

It changes every time the disk capacity changes.  And on the (uncommon)
reformats.  So the best locking would be the same as for the disk
capacity.

