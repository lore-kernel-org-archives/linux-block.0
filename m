Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AF1A680C;
	Wed, 29 Jul 2026 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285254; cv=none; b=OLVJRuBb2pYUnKzlFNVUYr2wDkjtpo3PuPeh1mN66p9paPX/npFwZMwTe9l2tv9ALRwXc+W2ZdZsms3b6pKGNGv2mHDv4sxxcyLbWCbQ+7zhsr0pA40jTcGX9pvXUriFilnr5pwzOTOuz4TZUECrOkLbvrFxCiXMaRVKzzuMEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285254; c=relaxed/simple;
	bh=q/Y/pa1Xe2qp+Nzii+Rx5bTkqUrCiT/l06hV0Ljw9R8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gSI4OknWnA8/xD8Ruofgi5hkzUrAKTLq9rZKZDB7ITd+3s1NTh5lhUbnwv1O8EdeDf09wWhiiVsWmXkSGAZajQ/LwaLqzFw80pyI3vjZGzWy6Vw7QdcH0tDGPMopEuPmuti64Cut4TGU9pyUqQNZPmzK5yIPHby85GEshVkMSfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A3MuEioC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A3MuEioC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F078E1F000E9;
	Wed, 29 Jul 2026 00:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785285252;
	bh=h651DKBmOo1GzMCJpLzcJjYwjbXQNz3Gs8JdROxsc/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A3MuEioCus+ZZSs+wr2/tZk+Ze9rY5nuN7SMhfNSo7CjV1Sdw7Xlkxm0PEqAwS5cD
	 KcNMOVxc+Ntei4ZNKoFVtDHOCPnWWjmR0aQRgphgdP6U7RQGSaByOZmc3GP4KwQxWq
	 gxFdmwsUoQDRz7Zf4VlbU/174FUilnA1Ig5RdXyE=
Date: Tue, 28 Jul 2026 17:34:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell
 <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Haoqin Huang
 <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v2 1/5] zram: fix early release of global cdict/ddict in
 per-CPU error path
Message-Id: <20260728173411.b2cb2d88147fe768cd6497aa@linux-foundation.org>
In-Reply-To: <20260728092935.31139-1-haoqinhuang7@gmail.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
	<20260728092935.31139-1-haoqinhuang7@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 17:29:31 +0800 Haoqin Huang <haoqinhuang7@gmail.com> wrote:

> zstd_setup_params() creates global cdict and ddict stored in
> params->drv_data, shared across all per-CPU contexts. The per-CPU
> zstd_create() error path called zstd_release_params(), which freed
> those globally-shared objects. While the drv_data=NULL guard in
> zstd_release_params() prevents a double-free on the init failure
> path, this is still a layering violation: a per-CPU callback should
> only clean up its own context, not release resources owned by the
> compression lifecycle (zcomp_init / zcomp_destroy).
> 
> Fix by removing zstd_release_params() from the per-CPU error path
> and replacing it with only zstd_destroy(), which properly cleans
> up the per-CPU context without touching the global params->drv_data.

Thanks.  A [0/N] cover letter would be appropriate.


Do any of these changes have userspace-visible runtime effects?  If so,
please changelog these in full detail.  If not, a statement (in the
[0/N]!) telling us this would be helpful.


AI review might have found a few things, about half of them
pre-existing (zram/zcomp):

	https://sashiko.dev/#/patchset/20260728092935.31139-1-haoqinhuang7@gmail.com


