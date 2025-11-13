Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919329D26B;
	Thu, 13 Nov 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064224; cv=none; b=O7WjTlXWSMofb+5aWblIvG5UBM1NKpETxQHPAvnN5dNcnFJB2Atpg+2H4qSp6Oc1M77qUGrttHHEwaH90HE0L2tyJ8Zf7yWiiXwS4v4bot3FmT75n37vf2PUPg3c4MtR8DIoXrmrtJMHxYHkJD1dbLRorZ+ETxthMKRgdYOcZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064224; c=relaxed/simple;
	bh=VIyLS42qOIPgbAl+g85RFFHDxN6iYSGrqionhuMIQ4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyFIDI5f0cdqsLlG1qV3LlwBVNryRtlUc2qS0osVfMb5YePVlHEok6wEIQzYXRySq/QFYFHmJtBStuvXFD7a+//VykBTW10/Gb50OfGu37MSL39+KMWv53h+aVwlEtx+fhfWkLKi/ftG6jPWjQdN3UmXbR2kcBf01USmulgXrT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca0g4cax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca0g4cax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03A2C4CEF5;
	Thu, 13 Nov 2025 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763064223;
	bh=VIyLS42qOIPgbAl+g85RFFHDxN6iYSGrqionhuMIQ4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ca0g4caxtzKZ02bma6BpHfrhKpEFzRSLqtvL9987Imx7HhuGqao/TltL2duV4X4i+
	 ccQsQBEHEZTh30kdwuTwCJ4C2oEJtd4v/QvVFJw6mzbBjjjMG9ocjRtEbxNhYsH0V7
	 ifFXw0DSAxBQEaWD6nnvooKN4W2nYLGbmsETf2beBoxlUR+S9zF3OFO21J20bHzUDx
	 3m2pM6CISksTcmIfQrSEE74jqAlsHr7Ohio9r5fEZaNhdxPe4AWCmOnDPaVaLe8i9Y
	 JCWe6CqAPdenbn71OWVvWr70dqupWd9iCwIKB7TBngjUXaJ/mJ0YRbQFAThZBWr1Fm
	 zmtt9bOgtTEZw==
Date: Thu, 13 Nov 2025 15:03:40 -0500
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
Message-ID: <aRY5nCvNnQk4mMCT@kbusch-mbp>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <20251113195008.GA111768@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113195008.GA111768@unreal>

On Thu, Nov 13, 2025 at 09:50:08PM +0200, Leon Romanovsky wrote:
> Can you please squash this fixup instead?

I think you should change pci_p2pdma_state() to always initialize the
map type instead of making the caller do it.
