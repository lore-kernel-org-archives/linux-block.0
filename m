Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34A40A956;
	Mon,  7 Sep 2026 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765223; cv=none; b=iHkbTx4lvjq6hbNbHVCAo54nYiK9fNjscZIVnNpByyGBX4K1C2+QGlxNqq5PmVCbXddzMU93yNA74rc3nJ7ZSqDkbEH8nMeTL8qpkejWaRPGzeVix/07B3HybNl6vfWwb/XcvDkNodRPTQijZepHt1z0V3GzcdsVIwS6zFpTLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765223; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F11cvTIghZ5O+4jHmzlfsAD5zjCQbLk4uuUpaS/o5oAEcI5KPCY6LCT5GmRmCDQ41mm3EWjYbCfS5MqVI/1rEhsL5Kr2ynOUJ66HLpVCOoHIJp1vmnvQgS4e9qXYm5DZrc+s1FdNh8Bl9pMwRi+iuIhyOmJfymWKQrKPj8K92cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4547C68D0A; Mon,  7 Sep 2026 09:13:37 +0200 (CEST)
Date: Mon, 7 Sep 2026 09:13:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] block: remove dead metadata handling from the
 async direct I/O path
Message-ID: <20260907071336.GF934@lst.de>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu> <20260828-blkdev-fixes-v2-7-32f3f40cebed@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-blkdev-fixes-v2-7-32f3f40cebed@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

