Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282715B998
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778132901; cv=none; b=qNfckz0I6ghsnsrJXKZU/TgeVMaLY/nBS3A7gpzYa3efPJ3ux3Nhfl9Aa+49+nVBO9dU2lZk5zVBMu1zlIBZovNhaB+elE3zB2cqj2pFLvAqQl6hihbIsnKkPc+b1ymKLLIzJZd0FzTYt6YbdZ3W43TXuK2pd0kw/0SHeJgIhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778132901; c=relaxed/simple;
	bh=MHEQQirZauvqpsBgaxa5yG1q2xBk/WB9znURSe0w8zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqnB+jDZwCT8svMsqaH+6dJbB2nW2Bzh8jw87EdoCOZ2y2OLk0Epl9uP3yCQfPyogd6mMvjHYus09XmKpdO01L6tIW++CcktjHHq43TX2PPf5+kbY4tehHiK0ioMjwDJPnc0S/O0C0o/jDiK3xE24gP4CUx8vjaBO5ItKm8bP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF3EC68BEB; Thu,  7 May 2026 07:48:09 +0200 (CEST)
Date: Thu, 7 May 2026 07:48:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to
 pr_debug
Message-ID: <20260507054809.GA19796@lst.de>
References: <20260427003457.1264511-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427003457.1264511-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Apr 26, 2026 at 08:34:56PM -0400, Chao Shi wrote:
> When an NVMe namespace is configured with embedded metadata (flbas bit 4
> set, NVME_NS_FLBAS_META_EXT) but no Protection Information (dps=0) and
> no NVME_NS_METADATA_SUPPORTED, nvme_setup_rw() fires WARN_ON_ONCE on
> any request that reaches it with REQ_INTEGRITY unset.  The WARN was
> observed repeatedly during NVMe fuzz testing with a FEMU-based fuzzer
> that performs semantic mutation of Identify Namespace responses.

What is "semantic mutation of Identify Namespace responses" supposed to
mean?

> In both cases the bio was submitted without REQ_INTEGRITY (because
> blk_get_integrity() returned NULL at dispatch time, so
> bio_integrity_action() returned 0 and bio_integrity_prep() was not
> called), and it reaches nvme_setup_rw() for a namespace where
> head->ms != 0.  The existing BLK_STS_NOTSUPP return correctly handles
> this dispatch; the WARN_ON_ONCE is a false positive.

That means we fail to properaly freeze and quiesce the queue over
updateѕm which has much worse results than just a WARN_ON.  So if we
care about this rather theoretical case we'll need to fix that.

