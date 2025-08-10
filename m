Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89762AD51
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754834971; cv=none; b=CbYzVvJEXVuH0r2h5YvFqUwQLO8EqsDlw121SKi4ObnBe339n8dS1j6K1hmJ9rMPQrseReYgp3P2+qR1dnuuR/EBgXDSDqylZBkob54NwYOhmubR9C6Xy3IsNhUbQ/MqKocA6b9LEbqpCRtnd7M+jxBHNq5V8GxYtAjfvvmqDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754834971; c=relaxed/simple;
	bh=VrrGU0PN9EGChvaf/fRcgq4fedQVLqvXnHtcGpx/IQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNfLdWiaQaSZlHvecmJa0NHHfe7me1W0d/vlZum2nCO3a7GR8tGjVF6HBdOU50VouPbqtXCTB805+BJxonhplJpSzuKgSc2TBPmRJTMO6slN9Ryadja1IHAuMkaHOzCSev2pv8Uysz3RmQUy8eomKVGs0wScUXmpOtl4xIF0Ohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 947DE68BEB; Sun, 10 Aug 2025 16:09:26 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:09:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 2/8] blk-mq-dma: provide the bio_vec list being
 iterated
Message-ID: <20250810140926.GE4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 08, 2025 at 08:58:20AM -0700, Keith Busch wrote:
> +	struct bio_vec                  *bvec;

.. and another thing.  bvec feels a bit confusing as the pointer is not
to the current bvec, but the base bvec table and the name should
express that some how.  Maybe just bvecs for the shortest possible
way to kinda express that?

