Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4F27E1C5;
	Fri,  9 Jan 2026 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937945; cv=none; b=NCk3DtWXrolag8d+UDi1u/Y4ojRj9gxHKSQDIU0XC18D2xLVKHraYYOaguCXFxXH9csvlf1r1wfAmsprXUA5kTwx8WcWzNng/hczbQ7N+e11BIAy7JsEt9vXziUyk8JPFSpHLXfxRUMi8xObIOGSEcHjif4gY4yZA0ixArRJNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937945; c=relaxed/simple;
	bh=Ckwc5CGmD8usAWU4M3kwYws8QbnwWbl1URm9yEK50dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvGVkqfb+kzWQ9POB4+c5ymk5Auwxt4f0YK9fX/2TFuxM7cHENNNhTlzC7dTgXJs2LPhFDPOhG1bIo0EYXQTpUvIclxFw1dqL5+QBhd78sDfSONnIgYygFuUp7YrNGSf+n6qgMmyvMH2cLpIUNY0g23eHxy18obAYB5GPQUeUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C5B967373; Fri,  9 Jan 2026 06:52:20 +0100 (CET)
Date: Fri, 9 Jan 2026 06:52:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/3] block: replace gfp_t with bool in
 bio_integrity_prep()
Message-ID: <20260109055220.GB4949@lst.de>
References: <20260108172212.1402119-1-csander@purestorage.com> <20260108172212.1402119-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108172212.1402119-3-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 08, 2026 at 10:22:11AM -0700, Caleb Sander Mateos wrote:
> Since commit ec7f31b2a2d3 ("block: make bio auto-integrity deadlock
> safe"), the gfp_t gfp variable in bio_integrity_prep() is no longer
> passed to an allocation function. It's only used to compute the
> zero_buffer argument to bio_integrity_alloc_buf(). So change the
> variable to bool zero_buffer to simplify the code.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

