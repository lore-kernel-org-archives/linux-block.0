Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70F207DFC
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502150; cv=none; b=F7U99p5W4/TFFKbpLY8rm/TP993bcTGEyLIo5yYDzCeYgGMt03wPGAYsUgXcD+dKYkbnQn6QWMDCaMrOaRFPNFy9T0r0i9xDQlzibNXrVbJ3WPWMVyztWlyWUjVjDXDHcR6X9KXcqJHQhSgmDlWWPWG+o5GcmoOn1oMEpR3yQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502150; c=relaxed/simple;
	bh=cmqj0Z5Clfvh3cMivWgMd9zIgbmrfmuBykALB+AJRzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0R+vTXlbTXABjGKkSetQ63HjRHVHFtq9EWD67+R/eTfGN5rdRPlGrsVb/50TH/C49nsx5t6zZgrcrtuGcf/ickT4JyQLmwsUUO7+SWlMd0/f/YCdup7UfNa8Rj18JvHZhpMvxhCbKSreKb287eWFkZFX+F7GWeNBE92TwRXXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sy4+K6LB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sy4+K6LB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cmqj0Z5Clfvh3cMivWgMd9zIgbmrfmuBykALB+AJRzo=; b=Sy4+K6LBSkFqkbqhYu1QiJqpxw
	JSQG+uIyX64WkRJPDtXNOpNLjHbyKLIvWfsXdQr9mnG+1iHN1Em8Z2WNqg26qjmZiyb/OyblBPdFl
	t9/z8VKYxjOPqgT2HXKlMX0dXUTW2DKasr8JvrgKt6Q2RIzl7jjBy/oyn98GevB+pfdotrmR++pHy
	DnONFeGx2kOVbHvH5viBpHhvTorQkXZn5kaQzgPyigh5m2UvrXK+o9K/IkhPewH84OFG3EIbWsHC5
	URo9cK/xOoANLX9Se5h8BwYG2aDfefUXEh4gNH6bJaCIQnFSH9x9GVsiBiOg7swyv0shyf4KrS2ij
	YzO4R6OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBX9-0000000EmLB-22Ac;
	Fri, 10 Jan 2025 09:42:27 +0000
Date: Fri, 10 Jan 2025 01:42:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Travis Downs <travis.downs@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org
Subject: Re: Semantics of racy O_DIRECT writes
Message-ID: <Z4Drg8pewTBbs0sy@infradead.org>
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
 <20250109045743.GE1323402@mit.edu>
 <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
 <CAOBGo4zdDQ+mV_5X1Y0J2VpV8F63RsBs66Xq4CHPtpBu9MFebg@mail.gmail.com>
 <d2951075-e9e8-460c-9dbf-34bfeb942aa4@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2951075-e9e8-460c-9dbf-34bfeb942aa4@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 09, 2025 at 09:32:54AM -0800, Bart Van Assche wrote:
> in trouble. Additionally, since typical storage controllers use DMA to
> transfer data, and since DMA may happen out of order, another pattern
> than AB00 or ABCD could end up on the storage device, e.g. AB0D.

Only when using an LBA size larger than each chunk, e.g. in the scenario
mentioned by Travis if using a 4k LBA size and not a 512 byte LBA size.

