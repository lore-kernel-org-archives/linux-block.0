Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB77C33ADA4
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262071; cv=none; b=NrIxOQaTC5ZnNnlmDvZv1abY5z6LksCl5c9k/Ahx3L1UkFeDYTyCbWkLqwchuqZZWbguWlSZ7vxLTzxdF4/C/pzlRu2G8teRxB+eRnHXJ2Xvgshhjx6EuDBQZhtMXjOmL7M2Dle0j19thA5P5RsoEiMbWoG7mSOU1BBDiC8hqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262071; c=relaxed/simple;
	bh=TqyGbAGUWey2ZrPEWuAJ/0U638wSFa5gT77v5hGPMfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akzTRELuvfSMgki6qog9oLDu7QaHAGnnryPx0tGJehR/3D83nQy/y46O9UcHd6MTZ+hLRInBkzCmGJJuqWgYwVbW4Y9ZLSpHlRSrkfFSrHcDqIm0w2ajAuqvgQVV5ET9cMs/5q7HYyOSPLrgGe75HKjTM8ADzIkTAIjli2Bw/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB85368BFE; Wed, 20 May 2026 09:27:46 +0200 (CEST)
Date: Wed, 20 May 2026 09:27:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com,
	coshi036@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 5/5] block, nvme: add failed_bio callback for
 multipath bio failover
Message-ID: <20260520072746.GD14937@lst.de>
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519172326.3462354-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 19, 2026 at 10:23:26AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme driver has long utilized a zero capacity to indicate the path
> isn't reachable, which creates a race condition with IO dispatch when
> paths are being detached on a live system: when the block layer rejects
> a bio early due to a capacity check failure, drivers with multipath
> support using the original bio have no interception point to redirect
> the bio to another path.

Trying to reverse-engineer - the problem is that the block-layer
code catches being beyond the capacity and directly completes the bio,
right?

IMHO the right fix is to get rid of the capacity hacks, and have a flag
we can catch in the nvme driver and complete through the mechanisms.

Having a callback into the driver for a specific error codition seems
odd.  And I think there's a bunch of cases where we could call this on
a bio the driver hasn't even seen yet, including from file system code.

