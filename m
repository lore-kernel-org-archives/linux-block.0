Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01601A0B15;
	Tue, 18 Nov 2025 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507452; cv=none; b=fXV2Y3qNcpA6Ie0g8YTRk3ZEVzNyGO4uUtS6qjkeKbujp+fpMqSOcRaQm0q1rlIH353TKg4F5ywiWd7A2bf/qICPkRsHMWqd49dZdZrmSkRBhJcOZxTKFmNJYVe3PAtjId3pJ0nFj+ueQnlyWuoJsOLuiY3Td4LTrqd7i7iP38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507452; c=relaxed/simple;
	bh=7QQygTuOQynkohM3s2IldwIWULLZl54zzYKbrbFD0h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrvxbYa4oBJszb8Zz+H2Bw1joLbnA0HLJnZsThY8GF2zJKz49TGP8pXqNYTqyYcwh3cO+bYJQleVs2nmrZCKSNbb+Jk/rqsOa3citioxM4TW8EaJ84f9XR4f+ihOqNIX1myZNOxWyINiyieYjm8b6L3tFFEpj4JMclTDALXqUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjl6Tzrp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjl6Tzrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B5C2BC86;
	Tue, 18 Nov 2025 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763507452;
	bh=7QQygTuOQynkohM3s2IldwIWULLZl54zzYKbrbFD0h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjl6TzrpZsV04eh6v4kBgSjuImsUEm9WB8cKFVv14EuRtklHdlW51lAuUidl0puBT
	 /IF5mdPC3JYaXh8luXYGEmHJQo6wAyvmAkXCf0uDKs/u1yPKSB3EC5rRQ6qmwZWhyx
	 FaDwU0h5JeIWJPU53QMFBRrhcdrYcLXS3EIyuLJTvuLMl/vXie8Kgsa9IFsKIUy0GO
	 /h8GD/lqiNP4ZMu8+UmzWPn6pK8NKXbje/eKaBBlPAveJaAP6m1psqUscXnmTOWsik
	 C89DuwxDNpGBXHoLLilCTvrfvxfD5l29AztFyNNomSnF5rTmkbcSzkWnn8HjY+SvPO
	 KhHFFIK87Wpdg==
Date: Tue, 18 Nov 2025 16:10:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <aRz8-IB6dq5tlpae@kbusch-mbp>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <aRt5DPnMwzDw8_dF@kbusch-mbp>
 <20251118051823.GA21858@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118051823.GA21858@lst.de>

On Tue, Nov 18, 2025 at 06:18:23AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 17, 2025 at 12:35:40PM -0700, Keith Busch wrote:
> > > +	size_t total_len;
> > 
> > Changing the generic phys_vec sounds fine, but the nvme driver has a 8MB
> > limitation on how large an IO can be, so I don't think the driver's
> > length needs to match the phys_vec type.
> 
> With the new dma mapping interface we could lift that limits for
> SGL-based controllers as we basically only have a nr_segments limit now.
> Not that I'm trying to argue for multi-GB I/O..

It's not a bad idea. The tricky part is in the timeout handling. If
we allow very large IO, I think we need a dynamic timeout value to
account for the link's throughput. We can already trigger blk-mq
timeouts if you saturate enough queues with max sized IO, despite
everything else working-as-designed.
