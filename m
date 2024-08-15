Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C01714CC
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725665; cv=none; b=uhpXC/wntsWQh827FV1GKKYpaKDv0v+SFDj2l0eYb/iNeizCVzAB3pUR71dJIwhpZq7DAz0icFUDHEoby99tT/ROqcVDHTHRxcgk9kUR/aus5hm7rFmBXlZ0ISwKvuDd/9JxEyUy1e8pUsl0jp18n8fRFt06kjkaIT1VHuXil8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725665; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEzHJk7Nj0so1JB4JYwOVVx6pj8Pwl0ki2Ra59ZwD8OPC9amuka8i7qHf5nVkrV8ZHOhej/gEWwBEeN6lRoDpDDdk6FWMPkA+EA9J1dwz9f0aRVeluUcGMfCewAjwRJstUXLuOSS6ZdJExFNRZpEw60vzJ8Ft7Ach6Hd4nFydKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CDAE5227A87; Thu, 15 Aug 2024 14:40:59 +0200 (CEST)
Date: Thu, 15 Aug 2024 14:40:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, kbusch@kernel.org
Subject: Re: [PATCH 2/2] block: Drop NULL check in
 bdev_write_zeroes_sectors()
Message-ID: <20240815124059.GB7803@lst.de>
References: <20240815082755.105242-1-john.g.garry@oracle.com> <20240815082755.105242-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815082755.105242-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

