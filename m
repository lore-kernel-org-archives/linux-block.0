Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542D1F63E1
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327358; cv=none; b=ktG7GMAhiPHMa93xRt/rdTA9uQr6GCQ8QG9NDjyDxbhbLGSvQdMf79jwqhEC8zdJ5gPPDjBQDWr064cf5D8DpT8tTJ3tOVWqKFTu59O5MHwKuZ7kFbRwPFVBKZGbzETESDJiMeypqIiz+RJJuM7JwQvlcQhH8bOhSnMEeNIynas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327358; c=relaxed/simple;
	bh=nO5UB7NuniqyyZq5SJ3+zh3UTpkUjSBy3Sds9gpldx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEBxNHt4mE0ZKFA+MgEQHhZGNv6dPp27Q2Bx1P8b+ZyaiRPXt+mY7UrbPel5ZS0zC+xYy23d1pIaG+nYJxkZdlwJPfyUXufrsH6gp7WPmOUzkWEVt+So2GlTm1wthFu/lCvI2QBLzKjSeRn7kGzIX9DjCJxAAsDuGGtp9xF1dmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BAFC068BEB; Wed,  8 Jan 2025 10:09:12 +0100 (CET)
Date: Wed, 8 Jan 2025 10:09:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <20250108090912.GA27786@lst.de>
References: <20250106142439.216598-1-dlemoal@kernel.org> <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk> <20250106152118.GB27324@lst.de> <Z33jJV6x1RnOLXvm@fedora> <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org> <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 08, 2025 at 04:13:01PM +0800, Ming Lei wrote:
> It is backed by virtual memory, which can be big enough because of swap, and

Good luck getting half way decent performance out of swapping for a 50TB
data set.  Or even a partially filled one which really is the use case
here so it might only be a TB or so.

> it is also easy to extend to file backed support since zloop doesn't store
> zone meta data, which is similar to ram backed zoned actually.

No, zloop does store write point in the file sizse of each zone.  That's
sorta the whole point becauce it enables things like mount and even
power fail testing.

All of this is mentioned explicitly in the commit logs, documentation and
code comments, so claiming something else here feels a bit uninformed.

