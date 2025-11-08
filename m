Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917C224AFA
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762618810; cv=none; b=M//EqR7qUAy8gc1uqQ3QMm8XTliY7u6huIWmaxpC7AvcseGNBaeg1JuyLxcQWoBYkdEEUnwuCENfvhVRdi3/1cRYV7h3CNbM8nkCcRSoRDzPCVrSVStxejfB6k8KdtXSfLXbUij517PddLiK4JxO6VW9sN1YE5DGFp4L8UaCOrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762618810; c=relaxed/simple;
	bh=aNTdW27YWZvANU5Z5pyiXH4HvB/4Zfwcj2asQFCWE4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUnak0exYl+Zm1SMDkAVELdvn5lQx6sN656d3Xim0cBvVbucLXpcEmAaeVN8XyvtouCI/cGuH0JpNANVKKfStbSPlmmuSyC/ZzY+5DZveRqLd++tJTPGzxpKOvjq4Xxvrq6fiMzsX4FtqC+av7E/tWPj3EsLX7tcER9MKAJgiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZAMJbtc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZAMJbtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FECC19425;
	Sat,  8 Nov 2025 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762618810;
	bh=aNTdW27YWZvANU5Z5pyiXH4HvB/4Zfwcj2asQFCWE4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZAMJbtc9+H+mcgBOdq4zwM/s8/rdwse2aLNuK0nE8TnkqJymY+itKN+jQnbO1s43
	 yCB+HVEKvXZGp/SNt8VxIvWOzAUFedOmeZ3BRXzAYKuCHBw+ZpJixnmV0PS6vrKrRd
	 MH1eCDSIKJujBptRqAbi1xFS4yJvtuPZLB92j7c9Z1y6qw6NTkKOJK8Akd0AHD7oSl
	 7WSf5FtefE8xv8uW6RVurVgPaIyw9AeorWFyNoJSAG06OMj+LvdDwkRbOZRE9dSBfr
	 Pn59afwVhMW0EYSvYKrLWCtTtkETukV8xLBg3nDhMUC1Yynp1XqHJMmiWjqwnnvBE3
	 v5nNb//3opkSQ==
Date: Sat, 8 Nov 2025 09:20:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk
Subject: Re: [PATCHv3] blk-integrity: support arbitrary buffer alignment
Message-ID: <aQ9tuPo7XLEAIc5i@kbusch-mbp>
References: <20251107232358.1324461-1-kbusch@meta.com>
 <yq1y0ohjk5a.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1y0ohjk5a.fsf@ca-mkp.ca.oracle.com>

On Fri, Nov 07, 2025 at 10:52:14PM -0500, Martin K. Petersen wrote:
> > +static void blk_crc(struct blk_integrity_iter *iter, void *data,
> > +		    unsigned int len)
> 
> Maybe blk_calculate_checksum() or blk_calculate_guard()? It's a bit
> weird to refer to the IP checksum as a CRC.

Sounds good.
 
> To my knowledge, no SCSI controller can handle PI split across segments
> and the PI tuples are required to be naturally aligned in memory. SCSI
> controllers probably can't handle split data segments either since the
> design constraint is one PI segment per protection interval sized data
> segment.

There are not many nvme controllers that can handle split pi segments
either. Anything setting ID_CTRL SGLS.MSDS can do it, but it's a rarely
advertised capability. For everyone else, metadata buffers have a single
segment limit.

As for interval data split across segments, that's totally fine for any
nvme that supports PI formats. That kind of data was mainly what I was
initially trying to handle here since that's sufficient to reinstate the
lower dma_alignment limit. It wasn't much more work to support split pi
though, unlikely as it is to have hardware capable of it.
