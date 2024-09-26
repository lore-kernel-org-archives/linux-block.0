Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B0AEAD5
	for <linux-block@vger.kernel.org>; Thu, 26 Sep 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363263; cv=none; b=egYRNNLYHsALvKrCwu5DXP0ENM/rurtuxq+bzbkyrdG1LXZWuwXu3LzaS769JUgIsnwYIZ0WetLjhz7utcvh8mGzoYkI+6ihRp+jX/Ib4HDAxtnWUF5bxOqEbKBUrKRge+KvR5tyUH++fBrr+WAm09svzWcmj+62uSpZxjqqWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363263; c=relaxed/simple;
	bh=gAfiloP6m7au+IIFfFXlowkqK2zR2URxRao4ffFBcBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l24KxyPE6dkDF3D+b+atl734yeSVFiyqvne4mvhDcUI7ldskI17lBP48Ag05WETIhewnOMXkkr3EkNqSk7Aeep6z+2JkRghN+RD7pDMMhnxkSMNbPADtD40bc4y0kLI15H/MPBMF1gptrSSSmGMYbswZ3/IXLQ8pvgnpAJNkTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIRvB8tk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIRvB8tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802DBC4CEC5;
	Thu, 26 Sep 2024 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727363262;
	bh=gAfiloP6m7au+IIFfFXlowkqK2zR2URxRao4ffFBcBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OIRvB8tkgfJMCfYnsh9nBhke814LUsJqEvRgcfR+KpfRBtJd//5w7ywy9/5CLucHI
	 rmmJmMxnDHXX5KNS4/yXA9KbXMz7zxf72jqwmI/s3OryZxR/sNGyTvdrW6jNGN/jB2
	 z/g1pCP9lNBzr3+8KMJWj+DcnKxCyns7YKkQMlvG2UU7edIb2o2oLihlYTbD5IO51e
	 MiK+3LGl+elEwVf0JMbnVzk7uRdVZFky7nD+hM1l7B6juOKpelVtFApELsCZwI+KRe
	 Q/qhOQ4YCa6BCYUANCfhqjzmkVMjx1R9Fgv2qv+3wIWggbZdbokqosTEiw0uith8hF
	 w5mgnEuvPsgHA==
Date: Thu, 26 Sep 2024 17:07:36 +0200
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <ZvV4uCUXp9_4x5ct@kbusch-mbp>
References: <20240201130126.211402-1-joshi.k@samsung.com>
 <CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
 <20240201130126.211402-3-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201130126.211402-3-joshi.k@samsung.com>

On Thu, Feb 01, 2024 at 06:31:25PM +0530, Kanchan Joshi wrote:
> Block layer integrity processing assumes that protection information
> (PI) is placed in the first bytes of each metadata block.
> 
> Remove this limitation and include the metadata before the PI in the
> calculation of the guard tag.

Very late reply, but I am just now discovering the consequences of this
patch.

We have drives with this format, 64b metadata with PI at the end. With
previous kernels, we had written data to these drives. Those kernel
versions disabled the GUARD generation, so the metadata was written
without it, and everything was fine.

Now we upgrade to 6.9+, and this kernel enables the GUARD check. All the
data previously written to this drive is unreadable because the GUARD is
invalid.

Not sure exactly what to do about this, but it is a broken kernel
upgrade path, so wanted to throw that information out there.
