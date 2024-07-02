Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A015D5B8
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922115; cv=none; b=azeKC1msp/J7vNU8TIGJxR+QpRXkdDEtxvAiPvuQ32KK1irJXeittAdFbgpfBeGafP4JuhVRXq6NkfLV3+Ra8JG86gHRT07GXPXAhHbJh2qWCCjgTquXPnAMaFNjPofk27An7JPhIbI4Ki+Z0AVkfp/7JwR4ZNhTUIeEt3ii6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922115; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl1v4mbBvLW3WmKzowLjvbGTWsOcYl98B16cNUgFGXXfcn9dt7RFc3CPmxjBXYr/uXuMRBfdNmKratA8diK3ssVyQhgbxi2k7mn0Rv/FHka+oThOKd8i6VxRBlMMCsspHVUZg3ZCVVT2DpjYHNVlpW6malZ+Vv6lxXwuxa+WbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 81C2E68AA6; Tue,  2 Jul 2024 14:08:30 +0200 (CEST)
Date: Tue, 2 Jul 2024 14:08:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: Re: [PATCH v2 1/2] block: Call .limit_depth() after .hctx has been
 set
Message-ID: <20240702120830.GA17584@lst.de>
References: <20240509170149.7639-1-bvanassche@acm.org> <20240509170149.7639-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509170149.7639-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
