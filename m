Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCF15B102;
	Thu,  8 May 2025 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746683997; cv=none; b=AKF6tcdqEq+PRAVHthDZzDsM4QGhpbOnQcQ11gFPVCFNKOLQZ3hZwByxxXfAROdlocoRLxCg2FaGJ4RpTO1d9L1GIx2DQvzJTDiiqR/n5SC4KYmswodoscGd93xwoVlgMZ/QrNSk8WWHL8wzGRRzPhIzkF3s6DivuVNQJHDRw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746683997; c=relaxed/simple;
	bh=zG7OfuvMHjM+uyZz7/fJsNuGKR0uvYN7TnVnUmWy5jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVmi/wHXstEVDdIKAyv+pK56ryRXVX/NAPwzVXZzbQ3Snvv7CHgXwduYkVT9sRbhHBxXI65LIAQDK7v06gI5OAAIchaoROfyTlRV6MBrAvEGBqzH8WESGPuk8lA3jhE0FVLyA/eLQ2+IyFC9o3R6UiNu8MjnPu5p0mEGRi+mYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FAF868AA6; Thu,  8 May 2025 07:59:51 +0200 (CEST)
Date: Thu, 8 May 2025 07:59:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
	Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] block: Make MMC respect REQ_NOUNMAP?
Message-ID: <20250508055951.GA28277@lst.de>
References: <4e1600a7-24d4-454a-87d6-6528b1c4c88d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e1600a7-24d4-454a-87d6-6528b1c4c88d@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 07, 2025 at 06:24:34PM +0200, Ahmad Fatoum wrote:
>     blk_ioctl_zeroout
>         blkdev_issue_zeroout(..., BLKDEV_ZERO_NOUNMAP)
>             __blkdev_issue_write_zeroes(..., BLKDEV_ZERO_NOUNMAP)
> 	    submit_bio_wait(bio->bi_opf = REQ_NOUNMAP)
> 
> __REQ_NOUNMAP has comment saying 'do not free blocks when zeroing',
> but as shown above, TRIM allows the card to unmap the indicated region.

__REQ_NOUNMAP is a hint.  All the storage specs are a mess in this
area as they usually get the polarity wrong and/or just have very
vague semantics.  Also actually writing zeroes and not unmapping is
totally pointless on flash storage as it just increases PE cycles
for no good reason.

