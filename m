Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5090242D9B
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713048; cv=none; b=f2D1iZLwhYjVp4uhCrleMslzjXf+JRlGShmMBWnjNiM7YryEOlguMZCmqLKA2/htnQRv0IFetJUZ5mYD22cpot0FOvV8g7s7NBxE05rnGFpu99pT6qvnnEX5swGMX2ULBZ8/QzDbmnrsUhh2Fn1q7z9Fq2ZSCBkW417AgPTx7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713048; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnPikCLd4TtNxK8GJLfem9D6eMPRYCm+ZvxQErYJiuu4XDz2sJf7NlKco/Ek15im5Q61QkCOH0Bnd6Lus4C5XkPXrHZYOkHPQsE1DMS9G8DrmcKwsm8GVlR9R13d5XeyGrkq+q92Qb/QXhPwzxZ+aLPxTJA/aV6J9zCepYkJf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BD0767373; Thu,  8 May 2025 16:04:01 +0200 (CEST)
Date: Thu, 8 May 2025 16:04:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] block: don't quiesce queue for calling
 elevator_set_none()
Message-ID: <20250508140401.GA31804@lst.de>
References: <20250508085807.3175112-1-ming.lei@redhat.com> <20250508085807.3175112-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508085807.3175112-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

