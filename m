Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFB2185A6
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681353; cv=none; b=ZyLwSzDijEZl6gaU2CP7B/CBGoyLrjszBFR7bTvD9HiNO0eQPr/Y2X+3rzF+K/k9U5QaSEmggFSYp/CdQ9xa+K2wvcz7GzfxKnVYwvmMKrtHaPKMsrpumZaW56KYH2+JBI3nZWo7wYnIJiN6bdhBvIhn4gRUsBaTJAM9/zZYPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681353; c=relaxed/simple;
	bh=4kN2Ccnt27vQMIJM3a5POXsRYhLuJYfe8yqJa2A8KjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQN4kMsGPEMgFl/YXr4APjgGhlPOHft/iyO/I3KFCTm3va2qL20ffmCgNDKTLb+GBSju0Vecy0BbVff9hd3rAlLnViawYg9sehxqVCAWgKwJftjca5YJHn7zr5KrjYqTeOXdAuOFHgCasvTXC0kIUBAVprsbOmKPGDNCIKK4gLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D148B68B05; Thu,  8 May 2025 07:15:46 +0200 (CEST)
Date: Thu, 8 May 2025 07:15:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] block: always allocate integrity buffer
Message-ID: <20250508051546.GB27118@lst.de>
References: <20250507191424.2436350-1-kbusch@meta.com> <yq1msbot6ox.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1msbot6ox.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 07, 2025 at 06:31:33PM -0400, Martin K. Petersen wrote:
> I know that we can't have one without the other currently but there's
> some cognitive PI dissonance wrt. keying off BIP_CHECK_GUARD only.
> 
> Maybe worth considering:
> 
> #define BIP_CHECK_FLAGS (BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_APPTAG)
> 
> and validating against that? Or a bip_should_check() wrapper.

I'd vote for the helper.

