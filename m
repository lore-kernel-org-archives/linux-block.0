Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F23A3809;
	Tue, 28 Jul 2026 04:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212641; cv=none; b=sKNsc4I2yvU11fxrElZ988P6907gOlFOVn5ASbKgxs+CMudoW/cAvhePgorB5bujeo+Bif0bfi+Q4s8hIOUYXxdrag2a/qzc36s7jUsbpT3Uk23D7J0sxoAexKHI8pWwYHSslxwE774yDd9lm7lcMhvaBvk5xOXUcMsebdJalE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212641; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIci8QCsVJppxvPGh7vqxib+Sxd9eSGUPbNzwrL8JT/rLe0CuQrHYvUGvXrFxpYCW8MBHNjoMbEsjJ27RSszC/LkSR9yy+tp/y6wraHtIGzB1A1smTmHUzTd17I3u3A3eA32W4krQHuvyZfekLcdeiXHlZP0H0aIFx1MzG1jX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C40968B05; Tue, 28 Jul 2026 06:23:57 +0200 (CEST)
Date: Tue, 28 Jul 2026 06:23:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Weidong Zhu <weizhu@fiu.edu>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: stop the timeout timer when releasing a never
 added disk
Message-ID: <20260728042356.GA19874@lst.de>
References: <20260727201257.211635-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727201257.211635-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

