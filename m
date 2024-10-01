Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A41C6889
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797050; cv=none; b=nBNHE5DJD8DBF17CSmhTbKcRWDi41DuEJSHyR3CMokfBXlow8CPD4X3ulFX1gEqPaiMc8OmXUATxeNJh/pYUAGO5fJdrZdbY7jIfi5P7DFkGgzIQOs8zd26oe7V2Qfm4tjOoDzN+VxNJM5OcdSmLVza7mPWKXd9BEWNlylK5pnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797050; c=relaxed/simple;
	bh=XBFt+lN55keQTEfhyTVFuCqjDhRK8NSUj6BMZjb+tK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcyV4wXThoLLCMMxQ5HIAhmwP4AyteE0ylU09yTSUfDtqnCPLG8jJJ2hniegAB0Y8Ezg8lLnSWRD0prCUYpu0+x+x63KjXSrvNeybixRXzcCjQ2EWxD23PuQALgSEv8ligWIik5dgjP8sbvvFFFSufcoWHDKUhs6vJAAgUCmSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK/fIkxo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK/fIkxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82091C4CEC6;
	Tue,  1 Oct 2024 15:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727797050;
	bh=XBFt+lN55keQTEfhyTVFuCqjDhRK8NSUj6BMZjb+tK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UK/fIkxoSH6VW5Ach0U0AessLuQMkVM+e4T0r06/srnyrFf18bGE/J462pJGtZ1oI
	 zxVR3bGCh0ni06pQJGGd6hX3QFXC78YNLlEWnxvVm9soyrVJKToLrbKEb7uZbUAHDh
	 scSrTd72Nr3z/FuQIwG1AoHOomzqyrUN9krPGnVUq6j0LLaB8ZQo5NCxAQQPaqotx3
	 2Sx9fo3meBhyKj6PkYBfZcjF2vESQS3+i339YNhUtJBMTZw8fNJ3cZUgvoMfHUaeqG
	 hN34RQeJpQ4SKurejJL/zhcToGJswA4YP8eBfPUI9/YzXPgmykpOFC2d4zEl4R5zjG
	 3QAzf1SrSwOew==
Date: Tue, 1 Oct 2024 09:37:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <ZvwXN5n1XyqRoH9H@kbusch-mbp.mynextlight.net>
References: <20240201130126.211402-1-joshi.k@samsung.com>
 <CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
 <20240201130126.211402-3-joshi.k@samsung.com>
 <ZvV4uCUXp9_4x5ct@kbusch-mbp>
 <8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
 <ZvWSFvI-OJ2NP_m0@kbusch-mbp>
 <165deefb-a8b3-594e-9bfb-b3bcd588d23f@samsung.com>
 <yq1ttdx81ub.fsf@ca-mkp.ca.oracle.com>
 <20241001072708.tgdmbi56vofjkluc@ArmHalley.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001072708.tgdmbi56vofjkluc@ArmHalley.local>

On Tue, Oct 01, 2024 at 09:27:08AM +0200, Javier González wrote:
> On 30.09.2024 13:57, Martin K. Petersen wrote:
> > 
> > Kanchan,
> > 
> > > I spent a good deal of time on this today. I was thinking to connect
> > > block read_verify/write_generate knobs to influence things at nvme level
> > > (those PRCHK flags). But that will not be enough. Because with those
> > > knobs block-layer will not attach meta-buffer, which is still needed.
> > > 
> > > The data was written under the condition when nvme driver set the
> > > pi_type to 0 (even though at device level it was non-zero) during
> > > integrity registration.
> > > 
> > > Thinking whether it will make sense to have a knob at the block-layer
> > > level to do something like that i.e., override the set
> > > integrity-profile with nop.
> > 
> > SCSI went to great lengths to ensure that invalid protection information
> > would never be written during normal operation, regardless of whether
> > the host sent PI or not. And thus the only time one would anticipate a
> > PI error was if the data had actually been corrupted.
> > 
> 
> Is this something we should work on bringin to the NVMe TWG?

Maybe. It looks like they did the spec this way one purpose with the
ability to toggle guard tags per IO.

Just some more background on this because it may sound odd to use a data
protection namespace format that the kernel didn't support:

In this use case, writes to the device primarily come from the
passthrough interface, which could always use the guard tags for
end-to-end protection. The kernel block IO was the only path that had
the limitation.

Besides the passthrough interface, though, the setup uses kernel block
layer to write the partition tables. Upgrading from 6.8 -> 6.9 won't be
able to read the partition table on these devices. I'm still not sure
the best way to handle this, though.
