Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7452315E96
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801593; cv=none; b=FCVFl2//GeoXKm77ajBnbiqDyHqmh3b9qegP+BPYaDHFeVLiyz0GqIKCDxa9SOs7yNCiHMQ2ovWHuU9XD7uVZzoKnTeNMfZ3HYXz1D+xKn9GX0qPCbd0PA1GscFZUTXd/RoZxfTXBpNIFQuYnOqHudZYhqJEcIOZZ28y/oOQS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801593; c=relaxed/simple;
	bh=pgltzXVVJ3W3HUoU+HSs2Kt5tIPT/3dus4P/zKKlDmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGzOEoC9ralAMPTZkQZnf+vPNAQtmr1/LVqN+wf9PHzvPwKTtfmYGTS6srG0RfJ0hg2RVfb+7JcEoQ1XKF1EAJXafapbWA9O5SRYn9+WgzkOSmNy5rLRt/illOoB4HA+lzGPDeEmd+5f95lYWd8UwHn5TLnG7I02aER46KTAtJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B51468B05; Fri,  9 May 2025 16:39:37 +0200 (CEST)
Date: Fri, 9 May 2025 16:39:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: always allocate integrity buffer when required
Message-ID: <20250509143937.GA1955@lst.de>
References: <20250508175814.1176459-1-kbusch@meta.com> <20250509041949.GA28563@lst.de> <aB4SHKuSiuewRltB@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB4SHKuSiuewRltB@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 09, 2025 at 08:33:00AM -0600, Keith Busch wrote:
> It looks like tag_size just refers to the space for the "application
> tag", which can vary depending on if ref_tag is used or not. But it's
> always going to be smaller than the tuple size.
> 
> I think you mean 'if tuple_size == sizeof(struct {t10|crc64}_pi_tuple)',
> depending on which csum type is used.

Ah yes, of course.

> I introduced a new flag because I
> thought that gen/strip property was just an arbitrary decision that NVMe
> made for PRACT, but if it's a universal thing, then we can totally use
> that. 

There is no other protocol supporting mixed PI / totally user defined
metadata.  But strip/insert can't be supported if there is more metadata
than the PI tuple, so I suspect anyone else picking it up would have
to treat it that way.  If I'm wrong and someone will eventually do
something else we can still go down the flag route when needed.
