Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B772F7ADC
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870229; cv=none; b=AYF4pcY0myOBr+nW0o/5Ew5LA38kQ4gRJgC41OInIJPsR8SXzfObYXaGqixBsm/51s1u31AXf1DfuL3mS+BDk8qaJwo8CPPt7CEeH01q4WEirKnOPTsSgqRqrIV5pvkauYhEC1Jjek3504BemoKqyG/+Eq8Joz+CBAMC7SWye8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870229; c=relaxed/simple;
	bh=u+l3T5Btg4YrMUhrTACFMal+8SZFqWLfSmFBfxxo4xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWoEoQlVcpyYI4ShFXZmNECurpCIx7ExWygzhRoNFu79j/cVcnFDhTZUNGYend68yMPaJ2qoDw1MAMsZjGFdcur65HeVqPAhNeY0cf/Wc9qukdn9GKoldMCn6DzDWHzWMGu5x87aUHZz/XowZXufTZTyfrSrz+9XYY0DAFJzoLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 180C1227AAA; Tue, 11 Nov 2025 15:10:22 +0100 (CET)
Date: Tue, 11 Nov 2025 15:10:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	yukuai@fnnas.com, Keith Busch <kbusch@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] block: fix merging data-less bios
Message-ID: <20251111141021.GA3123@lst.de>
References: <20251111140620.2606536-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111140620.2606536-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 11, 2025 at 06:06:20AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The data segment gaps the block layer tracks doesn't apply to bio's that
> don't have data. Skip calculating this to fix a NULL pointer access.
> 
> Fixes: 2f6b2565d43cdb5 ("block: accumulate memory segment gaps per bio")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

