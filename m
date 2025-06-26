Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7635972;
	Thu, 26 Jun 2025 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750914913; cv=none; b=slBom9JIARpoQIdadj/7y9jq1Q2gHWM/dGq0FZpmvh/TXA4WX9ARoZTygEo2XTFpDzdD1oALyqaw+bjhAdRVUMoiC1tBhG+S2JLejZnj56hkhi6ZF20cFuMNCpwwJC7mEbgRoVOoQFb/ibs6i+g98MqtQkMcjhrlVoKQ2iLk2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750914913; c=relaxed/simple;
	bh=IW65xuacCRLF+5e/Er6s2K5fZiFERoV0+h8MX9z5K88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkfrZRj3075k6tYSvbgde4h9wtPVEvEJvp5nDUzDxAkftYky9xHJ/jMvIyIQq07l6SoqbpUEdnHC7i35dA6fpsRnzeMlWLQrTO+tabSJcfxzrbncV/OCxN03Vqekesj19SGNXAZF6iDLZC2w8+wBKnUX16ZljOu/JtL+g/yt9zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EEC0B227AAD; Thu, 26 Jun 2025 07:15:07 +0200 (CEST)
Date: Thu, 26 Jun 2025 07:15:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: Fix a deadlock related to modifying the
 readahead attribute
Message-ID: <20250626051506.GD23248@lst.de>
References: <20250625195450.1172740-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625195450.1172740-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 25, 2025 at 12:54:50PM -0700, Bart Van Assche wrote:
> Fix this by removing the superfluous queue freezing/unfreezing code from
> queue_ra_store().

You'll need to explain why it is useless here.

