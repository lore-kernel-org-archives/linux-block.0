Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977FB5027F
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877758; cv=none; b=aLrE1UOTaDbAMkDG2oIpgxCf8/hvK0JAqHXnG/phrVA02QEWwBgn0QgOmu/NdqWZGxz2BNG5AxQV0KWYvMSLYwhVE8m2WMeCKyIQnMHfcMkqkzu6KyrXJpZNcqafeqG8RkzY8oBEyeSdvxeNfPrAgDFpH0KULhyIHOJyY+PU1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877758; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOunCW24+jnurIWmNIDh7GOCkhF9sYEEkRFDVDFdIZij2QvdkTyXJPMk/1PnoVSrHUEZXpvmJbAVTlQOmxgzI9d7i5A2MMuYgVhsrbTGyJFZqPAqbhLbfUCPfr/gFjmtC4Zwj9P3vGj5nS3hh6qcfYjHMIA15gOKuJQmUG70Jzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5FA3267373; Tue, 28 May 2024 08:29:11 +0200 (CEST)
Date: Tue, 28 May 2024 08:29:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: [PATCHv2] block: check for max_hw_sectors underflow
Message-ID: <20240528062911.GA29940@lst.de>
References: <20240524104651.92506-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524104651.92506-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
