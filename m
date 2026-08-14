Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F8A417D99
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692643; cv=none; b=UXiDALQD2usssyS0LtclHfgtDv9HbmtshOISu0BANJ1AFqxA820qaTaTJUgL8LEeKRBsreW4dKr77RHOLPo7Vh8ZTzowIDnCCYl0osg94zr6uimGbwAe2ynEWc4OK6jCfeqt9n/GCVv+bL+M597QogfhYaaR/lPIHnxIKkx2KKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692643; c=relaxed/simple;
	bh=oPseIc3w0wla6zbXFU8ObSlEvKyK2RBDis7aC1yU4dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYnzMg0cf5TZ34ouWEKmSRvkqr/frSFzxl1A+IpYyhcideOeRUofR4KuZ/JWOKm/tsEx2IuaLuc/ybbc2Hlrz3Al1NPpdbfLB7xL9LMCSSpLhQSfFrrwEwaD6l/uizQygv5gjulP4VkSQ7HjQD4YzdPFFVrqXgDib8jSBkOpapw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F2BF68B05; Fri, 14 Aug 2026 09:30:32 +0200 (CEST)
Date: Fri, 14 Aug 2026 09:30:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 04/13] block: remember a zone type regardless of its
 condition
Message-ID: <20260814073031.GA10268@lst.de>
References: <20260814063201.1762743-1-dlemoal@kernel.org> <20260814063201.1762743-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814063201.1762743-5-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Still looks good with the new fix.

