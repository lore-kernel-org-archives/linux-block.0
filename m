Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518C61FDF
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409319; cv=none; b=MEu58Jhj+1OWrkWOsTfydzBCIgqJW8hg6+ATqyOy5Ve52k4fi/Y/krhfPQnk8X1+AoT36h4IcO6XsVv1OVbrbp2Q2X2jwExAaF5pJJYvfTFsYdNVw/Lis2r8ozONbOGWkZnm7N7wRikSwuv7uRKs7LqD1U4/Uz/z2Scn8AoYh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409319; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egHerl0N5HfrtDePtwn14TbS3FyryLYHZpFNg3awl1Fdu1voHnSy/8TvFTBGXVqFV1/iB3n/JXs0k1sZiMXPG2HxltJyKwYCzDOdizHXxHwDEsKz/bd4qHfmI91aZZlndRS8vKzVeyVEAFCda+TZbFx5wN0s1Q/1y2FLoRnBM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F08C368BEB; Tue, 17 Dec 2024 05:21:54 +0100 (CET)
Date: Tue, 17 Dec 2024 05:21:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 4/6] blk-zoned: Improve the queue reference count
 strategy documentation
Message-ID: <20241217042154.GD15358@lst.de>
References: <20241216210244.2687662-1-bvanassche@acm.org> <20241216210244.2687662-5-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216210244.2687662-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

