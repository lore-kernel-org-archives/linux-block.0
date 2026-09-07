Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBF2E06D2;
	Mon,  7 Sep 2026 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765085; cv=none; b=F4LSEN05ax0CQ+ejmBbpLF0Zlels/i2xkpybXZq6y/7Fr6QI2tVeg7mtN97Qk7fxpqv4c5Zrerx/2l2WUj1DqAYpX/Xo3038MJZCSjDxNfhS5pI3UOEHQVEZzc4vmbca2r220tq7fGotPJ1mP1hz195OO8DvMzlxFnOY+px+bNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765085; c=relaxed/simple;
	bh=daNpURU2R9wHKnocDXbLEWdsOBrEFPL8X5tSwCbxUd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3jicKWjoh5U4I7p4+dwtNxJYc8fv14UDwwwnbPscT9gjcV6Yli3MdDq2hCBk56hC5mZxJAwcSdV1Jk+qpytAP75RdWivm24OAPLfkrXYOruGyDY2NQ4qVEKq0PxaIol65MP3jTSO1gp3eyJJFV/W+G8nzR4n5M94JaRCwgk/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DA4168BFE; Mon,  7 Sep 2026 09:11:20 +0200 (CEST)
Date: Mon, 7 Sep 2026 09:11:20 +0200
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
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 4/7] block: honor IOCB_NOWAIT in the block device
 buffered read path
Message-ID: <20260907071120.GC934@lst.de>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu> <20260828-blkdev-fixes-v2-4-32f3f40cebed@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-blkdev-fixes-v2-4-32f3f40cebed@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock_shared(bd_inode)) {
> +			if (!ret)
> +				ret = -EAGAIN;
> +			goto reexpand;
> +		}
> +	} else {
> +		inode_lock_shared(bd_inode);
> +	}

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Do we want something like kiocb_inode_lock/kiocb_inode_lock_shared helper
to better encapsulate this pattern?

