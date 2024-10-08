Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378243C0C
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 04:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361572; cv=none; b=oBThDTM2jBa6XvYH6ZRqiw42YZoqaeWRDDrRGTeDBp6xRzhzSBeJ1W06vlbAM6i7jAQnbW3quyYOzBnKtQdqJ2pyHUEsrSWLlulsvjO8TYFRLjwq4s6ZXlZjh+ZdPjJnIDqJd6hlt+PqIKXlDBb5owIqMpKg2Eg8GtfxmQwbyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361572; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0y2xzw+WrrOPEeCaKu3PNBVmvugaPfiXg2NyC6Gi2b6tA52WlXaN5vLi8J1rbRW00Qsnc+xtiw1c5HMj9xHdrhLA4OuN7Cm454W8DLMUqWCEWE20Q/r73OdLwh3BUyOSknBvJhh0CRUtebJe7phbUSv4inBkHpkFmvR86Qmn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25C1B227A88; Tue,  8 Oct 2024 06:26:07 +0200 (CEST)
Date: Tue, 8 Oct 2024 06:26:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] block: enable passthrough command statistics
Message-ID: <20241008042606.GA21010@lst.de>
References: <20241007153236.2818562-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007153236.2818562-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

