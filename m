Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE719E968
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045144; cv=none; b=JcRrmEeX3tb48145y99WASAg77UceLadbsCbrkSvf/BQoBiGE5CjspuN64UAeeTDmIrJLJcvI5JcoEcAtVysDRHSYq37vigCGVA6F49P7XNAaNctT905tIkcm9ql5sTJWBkGMOr6skdYf7OhQfKZkRyds9WmHj7ZwSM5H3WQ0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045144; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsI6/bYc9pK3w9b/SQD/b4sENlvsEZ36AvMiNNfPH2DTVDrGzdl+c//kuEIzO1moW5iL+m/ReZgc+ca4e2myoZwcUuM87xNaRnpyxdD2+/+keodukhyIZAad4cwzSsjZUTTNXQyg+B0Dqi2KoXNzvuC6fICx7jDAKqtV0uBnv+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E450A227AAA; Thu, 13 Nov 2025 15:45:38 +0100 (CET)
Date: Thu, 13 Nov 2025 15:45:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] block: fix NULL pointer dereference in
 disk_report_zones()
Message-ID: <20251113144538.GB30779@lst.de>
References: <20251113134028.890166-1-dlemoal@kernel.org> <20251113134028.890166-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113134028.890166-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

