Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19B276049;
	Wed,  7 Jan 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774583; cv=none; b=o9+nOgssY4eZQw4t/fLyujJLaMcMRpxZpmGUoayqxvj3XGKLXzXQgDL+SFAJpTeir/bpGK+OPwG/jA9E7EUktWqxF6CcOGZlWYPM0cDQhZbhKP0IT87OyzMToLNuHemQCMm0/si9tn3tf0iBqbrRRA6oyrmK1fbCnqzbD73eUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774583; c=relaxed/simple;
	bh=c9KnDRZffd89kv7fNSY4uCu0xvLE7udUDIgxRUUEgfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUSd3DXIIgha7umQExCSuDV6lAbYNOjmIUF9QcJ0Xav/wZYEMloc6jmGvlPXIV+PYhsPTWxxl0Xf4GAHRDTO1EbSYe9DoPjtWh6VBqrCwTQAYHOL9+CFFAZEXcHWDYBgTviQIrIwCyHQPXJczm63HCAD65HjmkZEiQ2MbvDZcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAwsxbl5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAwsxbl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5592AC4CEF7;
	Wed,  7 Jan 2026 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767774582;
	bh=c9KnDRZffd89kv7fNSY4uCu0xvLE7udUDIgxRUUEgfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAwsxbl5/DK24CGjsFliYKleWSIZKrLT+jYQDNlVhbR98y106ubl/7YvMyLFcDc+j
	 uNA03nnOs64V1QoMqquuS/wXF864uGcgCY9UvVTs4vSOndUjvnFzlVvvJWzSPpMu+S
	 m80VpwPwOJIQyQiAvWePDuJ13vwFEjPgu0bEN/gKOBvxIHGiu670QKPSEm9g574EyI
	 GzKN3RRp4aCAhWXonV079oRR7S8lrDLcQ2c+iCj77LACT74ypShOXsz8pFgcn3IThD
	 Yvt6dahdoTJvI0QRIn8cP2wFKykhbmgFqY/AC4hEON0frdSP0qL9eexjeVN0A+mW1f
	 gfBF+OJomvo9A==
Date: Wed, 7 Jan 2026 17:29:38 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <aV4ZcuXFjN_Eit6v@kbusch-mbp>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <20260104151517.GA563680@unreal>
 <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>

On Tue, Jan 06, 2026 at 05:46:21AM -0700, Jens Axboe wrote:
> On 1/4/26 8:15 AM, Leon Romanovsky wrote:
> > On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
> >> Jens,
> >>
> >> I would like to ask you to put these patches on some shared branch based
> >> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> >> and DMABUF code.
> > 
> > Jens,
> > 
> > Can we please progress with this simple series?
> 
> If Keith/Christoph are happy with it?

Yes, I'm happy with this. Sorry for the delay, I'm still abroad and
encountered some issues when I should have been holidaying (nothing
serious, just bad luck), so it's a slow start to the year for me so far.

Acked-by: Keith Busch <kbusch@kernel.org>
