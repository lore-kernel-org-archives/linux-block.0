Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E1B1F5842;
	Mon, 25 May 2026 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688695; cv=none; b=H9SVfEKO5hHK11O7Pa6rvGSn0REhb56HhfglQKFnlRF0prvHXBAu2w9rbhYHjqHfdIIavAc8gsVRoCD+CsLBb5dvszXAsMF8t9+4HEcddCTJJ8DR0cUrT8lj2qXULOwTMQN81QPVbgK2ezB/cTWpj5Xd05SqcFM0ZY7LCGZf29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688695; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNGhO/jKKx0pmCrFg40GtT7Jk6Fol28RHKvYVKAmA4EGZ0ZP0OakMwCeAZmTSlCfHJihLvUI5C0mstw62uaOQWGUeg4b+1wdsbVhztCv8NCU2aFZljbnlj6C3YScLIjMEbmBaiaSWLcbPR5c9M2Nec0wuLzUZ3FQ/x0xEjnAXqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D2D668B05; Mon, 25 May 2026 07:58:11 +0200 (CEST)
Date: Mon, 25 May 2026 07:58:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] block: skip sync_blockdev() on surprise removal in
 bdev_mark_dead()
Message-ID: <20260525055810.GC3293@lst.de>
References: <20260522220025.1770388-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522220025.1770388-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

