Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55777E8
	for <linux-block@vger.kernel.org>; Sat,  2 Mar 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388410; cv=none; b=BWFbrl65HRRStep1fmfKHmY/4iDAzc+1JK4hMikkowjvWam1TfmNpsdlTM+H2jBg8r7XAyrSMPDQZrZyjoq557eBGP1gp0kcd+wa1qCjYx/fAi9FbYnACnKQLijmPR8qXHjmYV+eBoPG3fl9gCXupOHdFZGGmSbm2JJ+7kD5MbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388410; c=relaxed/simple;
	bh=DAkUN0Z009a5okHX+fbBoYOoY9HsEvDBJsvKQFJenJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmGQPWDL9BuyqFggIsYLHcAj8+6Fa9+vkLv6y6oAfPzDENulYBp3lfi3LXD97cuLltsFNwoCsksfoVvpUqSWuiZxD1UXe0qaZNJBAz7R/vtgdYdIHQxldFimzXu+9J+VbvyRa5kEBV1micFs2zrL6dE7uyLGIx5R3XSfgzlIiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9DBE767373; Sat,  2 Mar 2024 15:06:44 +0100 (CET)
Date: Sat, 2 Mar 2024 15:06:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] virtio_blk: Do not use
 disk_set_max_open/active_zones()
Message-ID: <20240302140644.GA1319@lst.de>
References: <20240301192639.410183-1-dlemoal@kernel.org> <20240301192639.410183-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301192639.410183-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

no idea why this got dropped from my patch because I did have it
when testing virtio_blk.

