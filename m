Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036BA2940B
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764742216; cv=none; b=GsjraaF+XG+T1yFND99XXBHKwQbD7xXclFsSZM4QDewfR332nqszdS12I9xgHxV8HRb3B7kWpAELJkXgXlmDV2FgEHD06Dwfu2c0DKIK5kMwC00KDO0eSEG9Nj73L0oLWgItINQxFhn9mBSeqEUjXWgvH8Aw+l3P0QzqRmFJuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764742216; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfYru78VbEbvS3DTlG37XBjqseVED5NfN3GPoZBfzquS2rhJ6pMtgkHbIc+j0Kl2L9zwkClH2ulsTYfANs37EmOjUFXUlOq8DFGLGD/uqkpf8y6pCtxz3lKPTpnM3d4BkZIiUML0sdzPCwafz21cDEbBcVY1csqFJs37tbv5rRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C0B568B05; Wed,  3 Dec 2025 07:10:11 +0100 (CET)
Date: Wed, 3 Dec 2025 07:10:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, dlemoal@kernel.org,
	linux-block@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH V3] blk-mq: add blk_rq_nr_bvec() helper
Message-ID: <20251203061011.GB16509@lst.de>
References: <20251203035809.30610-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203035809.30610-1-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

