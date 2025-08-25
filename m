Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE7028850B
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108533; cv=none; b=C0gxtHIiBCV38Bv0QXu0dPpIgelogeD7ZSCpMoz5eOXTbnZyuUThHQkn+LY0svHSupxJr7WgjW5RDwBNIvpWQzgcgGXqekS2B1NOnj3wzeZPPXHFou1zgAB0GtOapZs93+4ZXQ0tuWx6adnXgVQQJhAfOqatK+lv3SQ9E5HAHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108533; c=relaxed/simple;
	bh=0+4M3BUA9zvD8BaTM7hRLHCZrT6kLmaOitXDirkEl00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O12Lch5sI2y8RElrAXKy3AJ3bUW0XZUz+e+tTjybTZnbOZ7xZnmHCR5vxoYo2Kl0TqbZEenRtnmkczosfL9x8GWX4YU7TSFSbvWT5rqjwr5Z3c66R8BRyB6MHbgSmVjvMlFuGGMCOFkyFViP8N2pjn5f43uAjuBbmOBdPjDghz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF51C68AA6; Mon, 25 Aug 2025 09:55:26 +0200 (CEST)
Date: Mon, 25 Aug 2025 09:55:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 0/9] blk dma iter for integrity metadata
Message-ID: <20250825075526.GL20853@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Jens, anything blocking this?

