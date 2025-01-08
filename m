Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70E11CAF
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736315228; cv=none; b=tciQ+R4XlGLFrVV3ESt9SWmxVmYZXMX+kyLLbjWpYlAOpOo9eSK+AQ9kUvonU3bmOJdq+VfgSd6kJvnDmBvZBs0ATK5OozQtNnEzGwfaN+vP6cVBy46yTeVYRkJyx0diSJ/6ZgjlV42gCexoR2uhDJZ8WA+D+69Bq+UQ+tjQQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736315228; c=relaxed/simple;
	bh=KayOgvKf0VHrI28yAbHom3uabGlohiLhKtHo8Nm2mn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6s3cExjUea7F0LSMbCJyD35ug3WkHvkq7ihD13SCAxmyLWyx6Mo+n8/4VkW83g91jatjUkA2e9Cn4ImXOefhKz1ygTzWmj2t9nJVE5K8Zh2jZ2we3SLhE52zUToIB2MnTswND+kYOi+MsHWRy2YRIzgFLaBjLbHmVXOFHfbMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21AAC68BEB; Wed,  8 Jan 2025 06:47:01 +0100 (CET)
Date: Wed, 8 Jan 2025 06:47:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <20250108054700.GB20178@lst.de>
References: <20250106142439.216598-1-dlemoal@kernel.org> <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk> <20250106152118.GB27324@lst.de> <Z33jJV6x1RnOLXvm@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z33jJV6x1RnOLXvm@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 08, 2025 at 10:29:57AM +0800, Ming Lei wrote:
> You can link with libublk or add it to rublk, which supports ramdisk zone
> already, then install rublk from crates.io directly for setup the
> test.

ramdisk are nicely supported in null_blk already.  And rust crates
are a massive pain as they tend to not be packaged nicely.  Exatly
what I do not want to depend on.

> Forking one new loop could add much more pain since you may have to address
> everything we have fixed for loop, please look at 'git log loop'

The biggest problem with the loop driver is the historic baggage in
the user interface. That's side stepped by this driver (and even for
conventional device a loop-ng doing the same might be nice, but that's
a separate story).

