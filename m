Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672424886E;
	Wed, 19 Nov 2025 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550423; cv=none; b=JkRHebt+3+inqhX3p9//0C9TKmSwE6kpvSeTv3dsuRcBGWarxwwC4JIGubwyaTqWyUMYzR0878tLM+Sq0kaKSvwfhu5BtyGDmTbGgKH5UJLIXnI43YIKb4gtX+YfFTA5ADTGaidYvnvEvEhJamzC6BOAHs2PsmOYcvf+u0AvkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550423; c=relaxed/simple;
	bh=S3zTVStBoLYGmYGmxZC0NIadrgUI21u3no3kP3JU4m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnRgqSsT+gAP6+8Esa3te7RgPle+WiH8wurpm8bGslerzI8GD8CAjE37J2AqfNPsWVokE/LMH/ZwvPcjV41fxSUspTPQJHhOrkK83zxJz+uJhNNV4rrwK0epUfQ4gGokp9SzOEOiL/PmFlF9eGgEjU7qLa8bld+7csMrHzgYsjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2oXOGb+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2oXOGb+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E385C19422;
	Wed, 19 Nov 2025 11:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763550422;
	bh=S3zTVStBoLYGmYGmxZC0NIadrgUI21u3no3kP3JU4m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2oXOGb+nSFmMH/C3fHQdKnLwI+dzInHFjDWDiM9Y2GgvnvftKQCcFuAyKUirvzps
	 9vh779mzu/HLXKFzPlOHSHr4efcZMbp2dHAa+G1OCa3KpqQ8Mk+4QRvgIrnuUGUgSW
	 DjyECJHD1IL/sDvMXLtjOvlnxK2sIR+7MQkEHp6KZ6WQ/lBN8KsQbS/8dQg+fSePBd
	 q4LhLgHlFkt9y/fctoQ7oAXFSNR2oT4e82MLX5bUr3kW9+JBNzbs05xXjsDsVFGgrj
	 C4RWQYbz0re4CmM/BortuOyD27zlQtDCtH91QfGy/mkvkxw/nDGn6fBeRfCpiP5+Nl
	 RFNNSmrETZ2vA==
Date: Wed, 19 Nov 2025 13:06:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119110655.GB13783@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <20251118050311.GA21569@lst.de>
 <20251119095516.GA13783@unreal>
 <20251119101048.GA26266@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119101048.GA26266@lst.de>

On Wed, Nov 19, 2025 at 11:10:48AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 19, 2025 at 11:55:16AM +0200, Leon Romanovsky wrote:
> > So what is the resolution? Should I drop this patch or not?
> 
> I think it should be dropped.  I don't think having to use one 96-bit
> structure per 4GB worth of memory should be a deal breaker.

No problem, will drop.
