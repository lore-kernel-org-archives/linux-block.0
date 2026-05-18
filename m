Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37A3DA7FC
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779083832; cv=none; b=RJyV6aRYJc2Aopv/n8wgQn6IZGDEFcynqHj90/zohHn91z/x/8o0sv63t7m0bYytXb7Pwq/dpOsUQFLopGQm31CiyWd6HRli7lPtOSLN657pZyXKRjp6baGD3Am4ywl1J506ct24T4GD9Nrj9OKuIV76kpcVdvL0s+Pr4IFc38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779083832; c=relaxed/simple;
	bh=omRRaWaVODUqN4DRarvnaOcSgQaqjontElTq09tgS0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxNrV2m78ZV0BUcH/U2yecxFy9obO4WNjToit3WswPjZo5BMkDztt5NWHpEDigXCiPrdBtHVqX4gBNAsohuYZiy6qSqSgGo8n6ymjpXMCYjcnk5bRyoFmL7TjKTvAxlC5glwO02jBrh1dESg12a90ThGc0r0SDWDNmbdifnI/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F9E268C4E; Mon, 18 May 2026 07:56:59 +0200 (CEST)
Date: Mon, 18 May 2026 07:56:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao S <coshi036@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
	axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to
 pr_debug
Message-ID: <20260518055659.GC10368@lst.de>
References: <20260427003457.1264511-1-coshi036@gmail.com> <20260507054809.GA19796@lst.de> <CACd_6n3s+Y+xdsuQVja=t1RUEdro2yQRyJyjpqFcd9_pF98OzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n3s+Y+xdsuQVja=t1RUEdro2yQRyJyjpqFcd9_pF98OzA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, May 16, 2026 at 11:54:49PM -0400, Chao S wrote:
> On Thu, May 07, 2026 at 07:48:09AM +0200, Christoph Hellwig wrote:
> > What is "semantic mutation of Identify Namespace responses" [...]
> 
> The emulated controller returns a mutated Identify Namespace on
> rescan (flbas META_EXT, lbaf.ms != 0, dps == 0) -- the host-unaware

What does "mutated" mean here?

