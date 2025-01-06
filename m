Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3378F49
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176884; cv=none; b=GaJitGKWBCbHoGpp2G5sqfhxwJH5gXpQwqn81go30unW1mVh4z7VuPcRJ9HjponR1zU5lYC9E6cC5COL80OkgXsYaARKhJu8f6jWbw8DuQYwqHM4FEzrWqLS66dYkf7m7cjkcF3xqYMD6B+Gr1vqXtKLLg0wU9NEz7sWO34uAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176884; c=relaxed/simple;
	bh=QPehYw3SGLMFmvitpskDrbHEPhMvCsX2BfjrI2Il85Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgYJmsfAjwdiomrz7XruxedqZ5h6hIAJRURNXZqaw52R5wh+X0crEVDV9TxF2NAdWEXLMgJ0yWAPWOa+3CwYyyvTEAaNGGR41ReZphbbfGuulM9FuxLwc+r0YmyOtF/Nc0ksL/Yk/h3x+Q3x9JF5eL0u3akGeLb4oOfx8JxyoqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45A1668C7B; Mon,  6 Jan 2025 16:21:18 +0100 (CET)
Date: Mon, 6 Jan 2025 16:21:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <20250106152118.GB27324@lst.de>
References: <20250106142439.216598-1-dlemoal@kernel.org> <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 07:54:05AM -0700, Jens Axboe wrote:
> On 1/6/25 7:24 AM, Damien Le Moal wrote:
> > The first patch implements the new "zloop" zoned block device driver
> > which allows creating zoned block devices using one regular file per
> > zone as backing storage.
> 
> Couldn't we do this with ublk and keep most of this stuff in userspace
> rather than need a whole new loop driver?

I'm pretty sure we could do that.  But dealing with ublk is complete
pain especially when setting up and tearing it down all the time for
test, and would require a lot more code, so why?  As-is I can directly
add this to xfstests for the much needed large file system testing that
currently doesn't work for zoned file systems, which was the motivation
why I started writing this code (before Damien gladly took over and
polished it).

