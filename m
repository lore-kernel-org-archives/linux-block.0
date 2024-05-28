Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCEE73518
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883156; cv=none; b=qzZSD7x5ZG0cBr9dWA6SW9kNTfu1oAAK69PHbYY3DvK212VZsA19CHIxiN0z0tE187vcu80TyElis5M3vYyCPponD/O4L4k4dtmewTtsNTlXdsWmxrvNt0BaAAFuRTrjoscLVFatTTrgTQtdp4lrWQSc3eyNT3NWVEXN9zzwCA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883156; c=relaxed/simple;
	bh=jTWwsXUTEUiZDh/6yBD76co0QVMSGAXKktf8eNA20E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE5SGkxUNrwHe3+sugljLjGJrkt3OMpCOaHMVvuFrXuhoTnbT5TP5rheOIwtVrvSMlHd+me3CZhhLBv2HDF651c4P28CjfTwlcRaQ7NHvqernojvaBdjdjBRgbLstWvO7ILculgBY67T1M/ngkIH4i8DW7VKTdD+1Dx1NwSfgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 90A5268B05; Tue, 28 May 2024 09:59:10 +0200 (CEST)
Date: Tue, 28 May 2024 09:59:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, martin.petersen@oracle.com,
	anuj20.g@samsung.com
Subject: Re: [PATCH] block: streamline meta bounce buffer handling
Message-ID: <20240528075910.GA1550@lst.de>
References: <CGME20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33@epcas5p1.samsung.com> <20240506051047.4291-1-joshi.k@samsung.com> <20240506060509.GA5362@lst.de> <87067eac-db91-c144-b3da-86d16f0a060a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87067eac-db91-c144-b3da-86d16f0a060a@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 24, 2024 at 03:58:45PM +0530, Kanchan Joshi wrote:
> On 5/6/2024 11:35 AM, Christoph Hellwig wrote:
> > Can we take a step back first?
> 
> Now that back step has been taken[*], can this patch be looked at.
> This still applies cleanly.

Please try the same approach for the blk-map data path first,
that should keep them consistent and also gives much better test
coverage.

