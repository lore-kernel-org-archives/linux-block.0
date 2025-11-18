Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639892749DF
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448321; cv=none; b=WzZKDuZz5sG6dbLAHsnp+P0crgDf7MCVCuqwBZXgLum5dfqGVZFlWce2MYhtw/msj5CBdlzkf2Wjn4pnZd6Telxq+cOklgrjPJ33NVvou2G2mDoFEFnJLO8WKIDWoXH4x/Evpmkz7RMzRpVv9edzEqnN6F2uxhR45wvW+jFKXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448321; c=relaxed/simple;
	bh=kquegUAorAzaLInfKeWDpAj7igXGfm+PAokRA6iJHBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQImao+K6ySpz91Ef7aSio9D41841BMnEx2OmE/FWreSK6/qsC5Lb/aQBUaGk/C+C6vwBmcjQ15MiSkTm00vPAxVSBq5jbem9gqubkvpvOHDSluSuc8xJ+4Uz/FdUiyoW+JT0b3Pp8J0qkY74DPCdqJs9XDUBJ6XfXH596rhIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07E966732A; Tue, 18 Nov 2025 07:45:14 +0100 (CET)
Date: Tue, 18 Nov 2025 07:45:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251118064513.GA24192@lst.de>
References: <20251117203935.1487303-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117203935.1487303-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 17, 2025 at 12:39:35PM -0800, Keith Busch wrote:
>   * Fixed up ip checksum when it's split among intervals. The previous
>   version would happen to work if the data interval was aligned in a
>   single segment, but it would have gotten the wrong final result if it
>   had to do multiple partial updates.
> 
>   Testing this type was a little more difficult than it sounds. The
>   scsi_debug driver would force alignment, so it would never hit the
>   partial condition that was previously broken.
> 
>   To test it, I hacked up a nvme qemu emulation for this checksum type,
>   taking some liberty with the protocol's undefined fields.  qemu has
>   its own checksum implementation, 'net_raw_checksum()', and it is
>   calculating the same result through its contiguous bounce buffer as

Hah.  Even if it doesn't work for the IP checksum, can we wire up some
of your tests in blktests?

I think the new split_interval_capable need to be stacked as we still
build I/O to limits.  Not just for that it might be nice to turn it
into a BLK_FEAT_* bit.

Otherwise this looks good to me.
