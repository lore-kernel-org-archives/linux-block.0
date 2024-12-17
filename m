Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64BE145346
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409474; cv=none; b=lpVfAHyAiLwu3YLUC5xp16wY8BhNwgqSr7w32gzdYia4/yryR464Lr0YvYrsMgu3pO5u8onCDIQCAtp3gmvEYN8TxvyUEXM0Lv52iluk82V/rQT+Xb4KDFFPXarBFg1+qyVzSg65t3Qdqb7HK4Y5pfnPou/s5khyI1AEN2UpW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409474; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDQdI8dhuTVRBnnYxTAs8GUXcxP67Jk3AoEFGxR6oYqZIcejV1BOddy6vNGngdkk/W+nkXTDkN8zz2gDUOyA1IkUpRABRTmSMAYxSFdoOQUvfgfP2yokYwb7ZLPaH7Os7wHcdYt+uFEkIc36j+oF9cchT8MqRuoSdBRP4NkpYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 57BA668BEB; Tue, 17 Dec 2024 05:24:29 +0100 (CET)
Date: Tue, 17 Dec 2024 05:24:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 6/6] blk-zoned: Split queue_zone_wplugs_show()
Message-ID: <20241217042429.GF15358@lst.de>
References: <20241216210244.2687662-1-bvanassche@acm.org> <20241216210244.2687662-7-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216210244.2687662-7-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

