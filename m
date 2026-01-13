Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDFC2E11BC;
	Tue, 13 Jan 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768288517; cv=none; b=ctQt41dDQfL8tGwglZLy3vmqbaMg6URi9zjGo2nvGK8sAMsGIVnq0ToN5cQzVaBglE8UaSlK9Ytb4ow8QOO1Y9EV+OzYo89xM8QbuhVdezon66z8s6PiUNhAq5FCyvSZoe2dQuEsnY5d0U3XXNweYQ4QJ723OC6G5SVP9LCJL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768288517; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgTpabOBXqefbybLgs7nDBxrzXMQl5zK8aS1i23LIJ2TcOPpp6AHmSHwX0nqcaNL1fLbh+5Lhn1UlajQweqnJKmrqmDI0dK8549xvTnPWa84nHu0rWoglJFp+qP7RZcK2WQTVNhIUzqoHaZZKMZ0OZp/ZYLVlXofgMH+SxEDaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D2CC227AA8; Tue, 13 Jan 2026 08:15:09 +0100 (CET)
Date: Tue, 13 Jan 2026 08:15:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	nitheshshetty@gmail.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block, nvme: remove unused dma_iova_state function
 parameter
Message-ID: <20260113071508.GA26631@lst.de>
References: <CGME20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18@epcas5p3.samsung.com> <20260112143810.2046599-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112143810.2046599-1-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

