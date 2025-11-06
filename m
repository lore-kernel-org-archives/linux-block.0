Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1118CC13
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427022; cv=none; b=RCRFFGREbM+Q+zlgqL8Y4eIOlbG5lUJAP6HPQh4YccxzrJZU9TSKg9HeUn2HoMBnOFRNSeqzLVYjhw5TsUobGSdctkyOBgDhtTH+w9f8nQgL9K23HWOgy/S6PkKd4ESX4YCzAEMlN6521kmm9xQyKR61CjUkqnl+btD+hH5aNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427022; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWV9OBXsCBKJfUqxkXQNmNh80LQvBbq9584wSWYYql6pzlZVKNKAn0pNyQnQIz2HjnurcJGGXG4NIkpZ3FIFUYoMGmlFhAX7yLUkVRMc2BT71ErTgyxwX0w8vbX++SbJs1a/VXmeR++QwewWA042y/I4yv+NeVpa4Ll3EqMAZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 62A04227AAE; Thu,  6 Nov 2025 12:03:37 +0100 (CET)
Date: Thu, 6 Nov 2025 12:03:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] block: introduce bdev_zone_start()
Message-ID: <20251106110337.GC30278@lst.de>
References: <20251106070627.96995-1-dlemoal@kernel.org> <20251106070627.96995-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106070627.96995-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

