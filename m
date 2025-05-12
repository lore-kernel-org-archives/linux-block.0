Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC42576
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747023676; cv=none; b=cw297fVk4xpZD9hr2QU0ezMM+0x2lsq97wPj9mRVnsw+K4QLXHwm90v0eRWieSqwF1WoTiGcdQTabJw5LuaxS/EzfQ71PNj6S6PU0NDchDTVDg5l75ecD4HcuHRxGspHx+wj8UJxP6pqDESPPI0lHAcUBPzq0zAIkLKu3Z60bbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747023676; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdW9I5KljXxcreNhRUkL0OdSu5E+vuoDBr4YY9YzkYBtmBmZjMT19PdEXVoKEBY4uDClc6HPfQTb54Wp/b88ZZ6cvkmdoMTBH79h5GfSGxc7D+drb8nVBmycXZQc6xzQkmwsHJcILEwyMBrsdJQ3nFRiK61hVf/TrkAU7jmgy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4517768AA6; Mon, 12 May 2025 06:21:02 +0200 (CEST)
Date: Mon, 12 May 2025 06:21:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, hch@lst.de,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4] block: always allocate integrity buffer when required
Message-ID: <20250512042102.GA600@lst.de>
References: <20250509153802.3482493-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509153802.3482493-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

