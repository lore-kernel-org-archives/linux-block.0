Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04E2F12C0
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754556; cv=none; b=BwPsfTMPvFA93RlSe6nn5p6ZKoR9zRlPWPHXpnvzNPL3IrOr0He73veUdGBD5W9deAIOrzBnR1EPP71/DL48hWM62kynV8LWaezxrDkjMxam/n7zZcR6hXx7SCtAVLyEihwVzIluTdOJ6TuUiQffoP3DP+QDIbEDOfhG9IDBZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754556; c=relaxed/simple;
	bh=oOC1zgaVVaJ3qVkKEcaDMIcFtxNTCgOyx15Yb9PY+GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEDxDAOd1UehPI/9r1cXAIO5XHe5cT9KdAJRGYyEyE/zmzY6lFYIp5ByhRNkR8LoRSb6y5nSHII8wXb9Qsaw1W2B0+Xbwy4HePg1uAI5QLNvF9QVUk1Jwu5a78vKzJ8hh+cWH/li3tzGKwP3Wxsx3YUUEohXz4o3hwGpxUyNdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUhTqyGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUhTqyGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD24AC4CEF7;
	Wed, 29 Oct 2025 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754556;
	bh=oOC1zgaVVaJ3qVkKEcaDMIcFtxNTCgOyx15Yb9PY+GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUhTqyGhl0sdbRZ7K5S18Hqts4IqycfS6DVA0VeRLRvam1RyqRKGp2Kp7PmA/k27C
	 bDS0t6dEsBELFTRn7CA4zJf9yu1rI6ZCQBZW4IHLFGx26gP+6QL0luji2ofBKnOtjk
	 cQ9BCN9Jj0wHexiBRUGRUSduh6otBpsZhSvToWNnWehgMfs6f14G1Nhe+I+zcEHjIU
	 kFOiPwyKScZGEwTZdKRCw0yEK8CzcMoP8Rz+3hSEk5uA0BSWHEXIvpkRxAOJ2nHn33
	 uAZsf4YTEhBtcaMOyf/3xQiFywRDtNpmQ7TMXSj6/rg4gS/i6FXgk3jxmw+8IiG7aK
	 YgcyuKgokSXrA==
Date: Wed, 29 Oct 2025 10:15:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, hch <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH] null_blk: set dma alignment to logical block size
Message-ID: <aQI9uiTuEr8hbWbC@kbusch-mbp>
References: <20251029133956.19554-1-hans.holmberg@wdc.com>
 <aQIgvwec4Ol7ed8K@kbusch-mbp>
 <49749a76-5849-410f-966d-6011dd4d5f41@wdc.com>
 <aQI7hyET6f-nXnmp@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQI7hyET6f-nXnmp@kbusch-mbp>

On Wed, Oct 29, 2025 at 10:06:31AM -0600, Keith Busch wrote:
> 
> After this, you can set dma_alignment to 1.

Oh wait, no, it still can't be smaller than 511 because everything
operates on "SECTOR_SIZE". Which also seems like it shouldn't be
necessary...

Sorry, let's just do your patch. That seems the safest thing for now,
and I can mess with dma alignment limits for a follow up (I'm already
doing something similiar for generic protection information).

Reviewed-by: Keith Busch <kbusch@kernel.org>
