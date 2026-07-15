Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAB1FECCD;
	Wed, 15 Jul 2026 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090064; cv=none; b=Poscj5zF3ezHM1wFDWXyChmGH+kQannzlV7kdTv1xBIYPmy0qVVlvsBMJHghLCHqF4dvSmzU/AbcMXtSSVe44hCshi6Id7NZm7zRQk+KcUCqRah61UqZGym4xea7850SxPPKRgK0gC7Cg00wzIDR1DiEMDIsXZHyPMunPaWrE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090064; c=relaxed/simple;
	bh=qWiFCAeFKT/t3VF6QpdAeEwO2eLltsyZSOI2ideFXos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAxZGMVLaR4PpI/PKQ3mlhlJu2ielaM9R3cPdmBZ7qVB9s2U2GuiarD4YLwbZtaKgtY+E2m2qBofkSxo2YmPC0qZMEgoHlmRByuK+H2bHr5lOHP6yRm4Hl3G8MM7N4DxvPtrE+IXlSGkRzegMcbVYUeybj0AZMuoZRZHtsHYdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 684F968B05; Wed, 15 Jul 2026 06:34:17 +0200 (CEST)
Date: Wed, 15 Jul 2026 06:34:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, Qu Wenruo <wqu@suse.com>,
	Neptune <z1281552865@gmail.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] block,iov_iter: move bio_iov_iter_align_down into
 iov_iter_extract_bvecs
Message-ID: <20260715043417.GA15746@lst.de>
References: <20260714131318.2670042-1-hch@lst.de> <20260714131318.2670042-4-hch@lst.de> <alZHF1wZY58JSU7N@kbusch-mbp> <20260714145026.GA2213@lst.de> <alZniKpsda_UJtj1@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alZniKpsda_UJtj1@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 14, 2026 at 10:44:56AM -0600, Keith Busch wrote:
> On Tue, Jul 14, 2026 at 04:50:26PM +0200, Christoph Hellwig wrote:
> > Yeah, we need to support that.  Kinda interesting that xfstests did
> > not hit it, though.  So back to the previous version.
> 
> Here's a simple test for this case if you want to try. This should work
> for any file or raw disk with nvme backing storage.
> 
> It prints "Success" before this series, and "Bad Address" after.

Yes, assuming the NVMe doesn't support SGLs and has a 512 byte
block size..  I guess this is going into blktessts/xfstests
once the query API lands?

