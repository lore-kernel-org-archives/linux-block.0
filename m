Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028C30C612
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061624; cv=none; b=UcilbT4j/g89NicPzxf/Wsb6CrCNr4If7X5KQncNTCCpYlhOXkR6QRPFOQDWeyIn6dCsARMQP1oPgPnPpi3KYGNSXWcAoR3Cf+LG6iNcjqQd3uOD+EcFlzWF6R9sZGlqQ/7/oM20ZY6OZoAuVU/KD+gcRFZpGH1NUoKttuYKOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061624; c=relaxed/simple;
	bh=gBZUHkRkyhFdZE9Wwb6k6Tyeo48XcyTM2JRTZ8FQ5Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEx3pGylZ2eQgSAYfni+mJnVgoBbxIW3YuKWgBnrxhRxT+M/GXfmVgIrsas+iud9GxK5MSDgOj+GXLCzderRAxeZaY1l/zRK+xImWciKIC5z1+kWRk6G0m6gFovU1/GaTvt38X4Cbo2V0Jih3Qx+lRX/aDt4OmJFoeAyccLXrgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5EpW2/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5EpW2/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E849EC4CEF1;
	Thu, 13 Nov 2025 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763061624;
	bh=gBZUHkRkyhFdZE9Wwb6k6Tyeo48XcyTM2JRTZ8FQ5Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5EpW2/SYxzUXorYmU3U1+D3LwYdJHFooSpBnD5XxB3dHDfHkdxMwwT3yxyKuYkhY
	 fuhj/tx7J6xeWN9+MlHNtaY1Jvi9T16eMy08rOW0nYQTbLQ8cRfHn7obZFNbfnCcL7
	 3bP+XI8pex13JcljuJxuMgKEuUUShzJoAAf6n2Rrcw50L+ysW9oakecdVjC63AZIxE
	 2ZzEq3xKfo/9TNhVZom7RWfM48JACDJoAFQSSkinl46qvQCQFPCC2VybtXnLvDWYZT
	 S/Vx4xVTM230mvjkU39TmxQx+Ke1QXWvwEl6I+C0GTyxlTNzMrPMcPq6wR3dmIKhcH
	 n/oZVf35iOqWw==
Date: Thu, 13 Nov 2025 19:20:22 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251113192022.GA3971299@google.com>
References: <20251113152621.2183637-1-kbusch@meta.com>
 <20251113173135.GD1792@sol>
 <aRYf9S-UuJqa37fi@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRYf9S-UuJqa37fi@kbusch-mbp>

On Thu, Nov 13, 2025 at 01:14:13PM -0500, Keith Busch wrote:
> On Thu, Nov 13, 2025 at 09:31:35AM -0800, Eric Biggers wrote:
> > On Thu, Nov 13, 2025 at 07:26:21AM -0800, Keith Busch wrote:
> > > +static void blk_set_ip_pi(struct t10_pi_tuple *pi,
> > > +			  struct blk_integrity_iter *iter)
> > >  {
> > > -	u8 offset = bi->pi_offset;
> > > -	unsigned int i;
> > > -
> > > -	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
> > > -		struct crc64_pi_tuple *pi = iter->prot_buf + offset;
> > > +	__be16 csum = (__force __be16)~(lower_16_bits(iter->crc));
> > 
> > This just throws away half of the checksum instead of properly combining
> > the two halves.  How is this being tested?
> 
> Yeah, this is the only guard type I've never seen a device subscribe to,
> so not particularly easily tested on my side. I just forced the code
> path down here anyway and checked if the result matches the result from
> the existing code calling "ip_compute_csum()". Maybe I can just continue
> using that as I suspect devices using that can't handle split data
> intervals that I'm trying to enable.

Wouldn't csum_fold() combine the halves correctly?

Anyway, it needs to be tested.

- Eric
