Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84F250C06
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686052; cv=none; b=bAwhdxgwUKGQ8iASEnAfPjaSTCaOMm8lTzpjyWxXRloSYVUnQxBgblUzwgDdrutVAiivRtxta/lUNvdynBOrD4KBhKojgBa+1JtsosBiWQP5HKt6pRStho9X73IAEnHfSveIyI8XmNwi74gfxXhjXpivm8JXk2Rk8bwb9nUXFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686052; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TihOE/gTF5+t/tgjhI0CL+S6ydHbxFqQG9IKRe6qqDNRwvM+wFVqxgwtbH84QmCuGZxEd/v3d/x67lq/e41zQjMgqRMz3bx51W8uALCsy3KjZNfFaSbfxcKF9oT2gyZIiqbyG4sNwGVUj9ukMuEOC8K0HM6Df3ZPomrAQpXTE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 237D768B05; Mon, 23 Jun 2025 15:40:46 +0200 (CEST)
Date: Mon, 23 Jun 2025 15:40:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <20250623134045.GA27394@lst.de>
References: <20250618060045.37593-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618060045.37593-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

