Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8133070
	for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162341; cv=none; b=tyHcjuQx5gnBWyfAJTloKK04vKokhsoaWbcHYf2lLAuLem3AQ02mlX8HEp2LTlx0qbJpxSDup0PAtVWvwteMb5xaXs++1h1yHn6ZbFo+m9P+CEzpwOqkolkuLDmBg8Y5ijOSi6BKtmba3yg1WmXqQgUqDxwgyIs6EAaW0qTQUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162341; c=relaxed/simple;
	bh=6A4/O19KWdCso7PAlaiIfVe8KDkypKlvSX/4Hon5PXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoHf88ymMNWcXu85a2KlBOywocCW+QMhbc6kQKYFmSuvNHADFfv7JqIbLspo559iR6L9iGYpyT3g2CHjhSbabCXcyIt6shS/M5lP5CMXcKvYLOyLTksbuEA65rOhjH+X9QEan4s9o6p0KSl+QfoIrHH9c1bE1O/i2l+Pb+7dEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13C8D68B05; Mon, 11 Mar 2024 14:05:36 +0100 (CET)
Date: Mon, 11 Mar 2024 14:05:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [BUG REPORT] generic/482 fails on XFS on next-20240308 kernel
Message-ID: <20240311130535.GA31537@lst.de>
References: <87il1tqhbg.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il1tqhbg.fsf@debian-BULLSEYE-live-builder-AMD64>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 11, 2024 at 02:20:31PM +0530, Chandan Babu R wrote:
> Hi,
> 
> Executing generic/482 on a XFS filesystem on next-20240308 kernel generates
> the following call trace,

Please try this patch:

https://lore.kernel.org/linux-block/20240309164140.719752-1-hch@lst.de/

