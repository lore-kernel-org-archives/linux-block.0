Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354EC38E126;
	Mon, 25 May 2026 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691943; cv=none; b=AHklae7UOYJ5nYKiieb0SPbGDbbHKai5E5VL9uDIVDGfzEroNYKkRO2qK+bBrlRWKXvnyGw9Jn2590ERXf0TDCgD656mBnIAVnhOLD7FzgwUSd8MW+ZnYFM6AcfD/6hsXHD+ioET5/7N+EIus1SrkOh7/aD3xYU67lkPrZWQ6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691943; c=relaxed/simple;
	bh=a2wcUSnSk3zf75vYsmjLFV1i+2oU39e7BvraVF5gbK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3AWYMpp0Ak/PiBq7JbNyQvpDcmgfM1Ca3rhsrmkXxz0ptorKNjtRNLnCvPAhW3tSY9mQQrE8F4/REHpvIj1/3ird4peOucv4OkC7AUR4AmD5klCJkEGnRRM7/34OqA2qqKx28qFDy9yuvKjsQp1tyvZM4EKkWOvESaneoshTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du8rvlbo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du8rvlbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4701F000E9;
	Mon, 25 May 2026 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779691934;
	bh=+uZTIJVoSvZifmb04HQsusRFodHBZxoyipd8FVMzc/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Du8rvlbouwmZxG6k0edes5et7yEI2nRm3c/x2AVTwBp0vryg6hpb/jCt6nq3b+DxP
	 cxu33nDCEKVh8Xe92O5EAN2kQ+rK0YNTtPsxHivGMu00FZBqxx73/jXxtimF/NPipL
	 tQErUxNCUfQWNSyg/fLodfNBpjk0oRgeoEpUI1uyp5w+Q4H5MZexhZRuL3e73EJgfF
	 KiyFz5s6sZN5ZOnkW9stWFIv1Wvr6XEjvu+LFdsYV6yB92UY43bYze22ZbHtSomSwW
	 0XZAZdYhpZULPnO5WPEHwmvacqWaqZtjmNig8zXC6PJsmAQ1/2TLrkvgNSM/73+h3d
	 dbGUyvvwaeV+w==
Date: Mon, 25 May 2026 09:52:09 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
Message-ID: <ahPxmSqT4Y4jcAbQ@kernel.org>
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
 <ahPnX-CwVgK-9chp@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahPnX-CwVgK-9chp@infradead.org>

On Sun, May 24, 2026 at 11:08:31PM -0700, Christoph Hellwig wrote:
> On Wed, May 20, 2026 at 11:15:52AM +0300, Mike Rapoport (Microsoft) wrote:
> > check_partition() allocates a buffer to use as backing buffer for
> > seq_buf.
> > 
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> > 
> > Replace use of __get_free_page() with kmalloc() and free_page() with
> > kfree().
> 
> So I heard various vague references that we should replace
> __get_free_page with kmalloc, but nothing definitive.  Can you please
> point to a good resource for that?

There was quite recent discussion when I posted patches that change
__get_free_page to return void *:

https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/

And an old thread when Al posted similar patches:

https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/T/#u<S-Del>

-- 
Sincerely yours,
Mike.
