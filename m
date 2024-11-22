Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCEC28E37
	for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291231; cv=none; b=lYt2kw6QClLhy1f+HFwC35wqqKT6Qf2+uZTtseJRtSbpV9UyIjSrF/ZcTsN5KH3NAttahkKdYsFWUxYet+evCLPt/uFmj9X4a5fHx8Ohd6FU1prJrsv5jWEUaMTHOPpgMf1s+qNgDwbH2TXcifD4K/q9BadvXzbL5vFbh2nx+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291231; c=relaxed/simple;
	bh=Yk7wP9m+ZrilsJlN2GpdbtOcXhR73tQ4ue6IOTxm8rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il/4qhp4QIy5P2FqvWwW/JlwKA0UrbQgPJvqA89UIRULAD3+EaR9dRMdfpUY7fyKs6gp2rfbms1AcdBAqDLDnGd9KoS2SxqAUpPGqKQaGBTW7UGWjQaw7K3wfuwrNd61FTsZlPCkxK4w57g4Ujp3ARI3+ql748m1gEHoUFP0Md4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DadUT9m4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DadUT9m4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93462C4CECE;
	Fri, 22 Nov 2024 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732291231;
	bh=Yk7wP9m+ZrilsJlN2GpdbtOcXhR73tQ4ue6IOTxm8rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DadUT9m4Nx0AB8aX3Z98qNpSZ8Ab96H88n48JItS/NighCaPtwRpzpP47lgYCtyDN
	 JIXdkYJvcVWrN2PE1m910ONBpaVQvOWIqzKhe95FlVinMywYHQ4x4O+66H1gYM5GyP
	 MS0NfJz0ITGe9S0xN8G1o0yDeZVvXa69KRb+BMWls+5aWdfjf8qGsJq7nXGWxpekRw
	 Xvab7l9tMpwKLHHPA9VfAIdrhwFDnITEo7370iI1RzwWtqkVb6w90SbkL0UdQo8QTp
	 1l9R0Qvj8pbjYfK4Fgz/vhJ00/1JgZr4QjWp4UltGbL7O7z+qbdtGTAqnDEkCsFlmt
	 fLVmSFaQa9B0w==
Date: Fri, 22 Nov 2024 09:00:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, axboe@fb.com,
	chaitanyak@nvidia.com, yi.zhang@redhat.com,
	shinichiro.kawasaki@wdc.com, mlombard@redhat.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH] nvmet: fix the use of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
Message-ID: <Z0CqnBhIpmf2snuY@kbusch-mbp.dhcp.thefacebook.com>
References: <20241122085113.2487839-1-nilay@linux.ibm.com>
 <20241122120828.GB25707@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122120828.GB25707@lst.de>

On Fri, Nov 22, 2024 at 01:08:28PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 22, 2024 at 02:20:36PM +0530, Nilay Shroff wrote:
> > The nvme_execute_identify_ns_nvm function uses ZERO_PAGE
> > for copying SG list with all zeros. As ZERO_PAGE would not
> > necessarily return the virtual-address of the zero page, we
> > need to first convert the page address to kernel virtual-
> > address and then use it as source address for copying the
> > data to SG list with all zeros.
> > 
> > Using return address of ZERO_PAGE(0) as source address for
> > copying data to SG list would fill the target buffer with
> > random value and causes the undesired side effect. This patch
> > implements the fix ensuring that we use virtual-address of the
> > zero page for copying all zeros to the SG list buffers.
> 
> I wonder if using ZERO_PAGE() is simply a little too smart for it's
> own sake and it should just use kzalloc like a bunch of other identify
> implementation..

Sure. That'll make it easier to report non-zero values if we decide to
implement a non-stubbed version of this identification later.
