Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A11C3F1C
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153301; cv=none; b=T/KsC00bMQf6IC0XX6hK53vTPij+U1Ce7t284XE467qO28UQo+n87qRNzRAv9T9spJkNLqF7YLQ0qusC4cWoZo9ydgfUrPbQGCuPtL7gJyDMDZ3e+Q0cS2ZUgt8VHm/HMxhKQmLxNTQhk8X2JezpQw1SPmH7UnUm8drhXXcYMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153301; c=relaxed/simple;
	bh=jozCrFVcGVVYr22yQndhjy7mCJ0Tpy2ZpN2BKRos3l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewtKW8LgayglOsKWvsoV6YYVl33EVsDrA7Ffgi2Hk2jNBaLTblAC8OmeRvdEdMYP6jf1abloPvvoGllj63fQUdG1HYhjJgyYgCiT/9TFRtq/Ooe2hQhaSferHk2zGfVOPh5j+8XPUZAxROw4NWRrbHGjG13J3W41oYtlnJyZtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02E7E227A87; Thu, 17 Oct 2024 10:21:36 +0200 (CEST)
Date: Thu, 17 Oct 2024 10:21:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-ID: <20241017082135.GA28355@lst.de>
References: <CGME20241016201330epcas5p33226adcbff73f7df7cced504aea64a13@epcas5p3.samsung.com> <20241016201309.1090320-1-kbusch@meta.com> <20241017060123.GA8191@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017060123.GA8191@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 17, 2024 at 11:31:23AM +0530, Anuj Gupta wrote:
> Not for nvme passthrough, but all this code is needed for io_uring
> metadata series. Please see the need/justifcation [*].
> 
> [*] https://lore.kernel.org/linux-block/20241017054900.alfiqn3o37f4kkxb@green245/

But it could easily set it in bio_integrity_map_user.
