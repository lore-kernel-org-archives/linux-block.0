Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6813473D
	for <linux-block@vger.kernel.org>; Thu,  4 Apr 2024 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265273; cv=none; b=FnTEJ1LFLVFCupkjrk9LP5DWINTod0koYyZFQr4Dr+Vk/b9BOJWvFv2YQ0HlAX3kvb1GkGlazOxa3def2VcOy77jE4V+lrYPSt/EYqjPf6HFUk7aD6G3x3jrgvid+kY4Frqm1ijmQDTX00NB1DVc5PkboT4LKXkEeOpgRETqkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265273; c=relaxed/simple;
	bh=ciwjEoIduPsk7nGPQqW7xbd2pM/oT+BddQO32l5bDI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIIfhM3PrUPGvYcvtzL83pYzSUdoblQ8iiP7C3DFJ4EU0Y6RzkUhjgMgitkTSCq3YiiO0j49OzijUIA1Xy3DZ/Ksz1iVii4mGGSdJ2hWXK+w6A0C9fE7cKU/e+26wWlbtq/ixUF+98wxkjUR1HNuthkjPqqFlna+0fN3/cLEWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlLQtw2r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlLQtw2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70986C433F1;
	Thu,  4 Apr 2024 21:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265272;
	bh=ciwjEoIduPsk7nGPQqW7xbd2pM/oT+BddQO32l5bDI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlLQtw2rbxj/SuR1EodSXMB9fpwJpwKRjwZiDfgj7XcMOblH3KrcFqEuKUU6oWhpR
	 KIWfMmJM8wQrHCswrKvjmWuqeK4z8gP3eT/WOIe2/1rRokEVtXs9j8KZoQli3/nhsU
	 YR7H1emuAlIk6fo4rRugY56o0twaMthpzJjOZCX3FUB3G+hagaKpLWa9MTlQGUi+jH
	 jsdTjk9dUBiONouoY+Y5jyPkVKvQiGkUrzjYeaTO4JLN+mWTPYk0OZDx6B9KfxbX4c
	 5Y6SzEp8P56KojsL1CxxJjGx2iHvfrUVjN4B7um9g5vqchAkqFiWFaE/aT3Kka4e1a
	 OAf271BSPScAQ==
Date: Thu, 4 Apr 2024 15:14:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv2 0/2] block,nvme: latency-based I/O scheduler
Message-ID: <Zg8YNrSnZPjR4kan@kbusch-mbp.dhcp.thefacebook.com>
References: <20240403141756.88233-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403141756.88233-1-hare@kernel.org>

On Wed, Apr 03, 2024 at 04:17:54PM +0200, Hannes Reinecke wrote:
> Hi all,
> 
> there had been several attempts to implement a latency-based I/O
> scheduler for native nvme multipath, all of which had its issues.
> 
> So time to start afresh, this time using the QoS framework
> already present in the block layer.
> It consists of two parts:
> - a new 'blk-nlatency' QoS module, which is just a simple per-node
>   latency tracker
> - a 'latency' nvme I/O policy
 
Whatever happened with the io-depth based path selector? That should
naturally align with the lower latency path, and that metric is cheaper
to track.
