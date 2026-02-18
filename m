Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834F3019B0
	for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451103; cv=none; b=cfw/c1ivPeMrUbZvFUcCXmREIaB2JCNT+cvdsuer30hr1XvhcnvbIPWPSksG9Q8+VaA/J7BdpA88isRB8mTJHdoMTNnpFlP7UKNTL0DM1qCt/X1J6weKDJ/7dtBZEATvLRsRO8vNL47DyBumKwvSIMTbBJZXgVR2c+tOT8pM04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451103; c=relaxed/simple;
	bh=ZrdFjhE0k2DMKFC9YEGr9dqjndLlXLHRMk1yIm5477M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb02YacGpFTa9tREs4HOzYAikpSQlx0PWULYsZY8HyPouqUYt1KuaS5tskaN1CE119qBltCXGbV9gg4WkTAdYu7jvPpffN6Q40erGnaPSvk/PNhAIAY2faoLHOCaEn+C2iWg8WEregR6//VtqZSchUoD80J/a8uVxBexss3e0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by4lmpAx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by4lmpAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93170C116D0;
	Wed, 18 Feb 2026 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771451102;
	bh=ZrdFjhE0k2DMKFC9YEGr9dqjndLlXLHRMk1yIm5477M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=by4lmpAxhyoFtpGhMX9H1n4zBGroWeHGpWEbhRwMnaiBNVoVeoZR2/RuMh/B5PrRT
	 rB8nXO3Q+TdIhy4RT1NS5OSv4astCvHT9GJJRRtViMrUDfHC+Jf+NYx0Z9VYVfnUYN
	 H+DLZWesXfr91Rli5+zLVnqwC8S4KFAaQ2D0mqz2EnL90xp9q2TGWMaKsQHGX/YptW
	 v0tnVHe8JUZwGcB542at39ObEVNUOeHjCSm1U8K5b+B/L37I3Q8yuQv+C9R50GAM2M
	 CHmcRKvGz7WjhwOXtkmwp5rXqmuRbE201e2tqBwOkYSnP2gMY1Dt1I3KVSP7+pjg5a
	 tPqxli5i3zpOA==
Date: Wed, 18 Feb 2026 14:45:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, csander@purestorage.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv7] blk-integrity: support arbitrary buffer alignment
Message-ID: <aZYy3L-UVjgNQS11@kbusch-mbp>
References: <20251125185718.2190305-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125185718.2190305-1-kbusch@meta.com>

On Tue, Nov 25, 2025 at 10:57:18AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A bio segment may have partial interval block data with the rest
> continuing into the next segments because direct-io data payloads only
> need to align in memory to the device's DMA limits.
> 
> At the same time, the protection information may also be split in
> multiple segments. The most likely way that may happen is if two
> requests merge, or if we're directly using the io_uring user metadata.
> The generate/verify, however, only ever accessed the first bip_vec.
> 
> Further, it may be possible to unalign the protection fields from the
> user space buffer, or if there are odd additional opaque bytes in front
> or in back of the protection information metadata region.
> 
> Change up the iteration to allow spanning multiple segments. This patch
> is mostly a re-write of the protection information handling to allow any
> arbitrary alignments, so it's probably easier to review the end result
> rather than the diff.
> 
> Martin reports many SCSI controllers are not able to handle interval
> data composed of multiple segments when PI is used, so this patch
> introduces a new integrity limit that a low level driver can set to
> notify that it is capable of handling that, default to false. The nvme
> driver is the first one to enable it in this patch. Everyone else will
> force DMA alignment to the logical block size to ensure interval data is
> always aligned within a single segment.

Hi Jens,
It just came to my attention that this one is still outstanding. Any
thoughts about pulling this in? I may have to rebase it, but just want
to check before doing that.
