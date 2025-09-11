Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724CE223DD1
	for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571227; cv=none; b=JuftVjusspwmE8V/YZYAAWEh6zna/r5t5cx8j3YuYhYqpODbAYH3osL7RODMD2Dc8/aNLCVRvmmiVJiWXOy/P9ibTUB12PDO4hPBJ0vkmTjqA8utjyCZ55PDOtUSHGlf0PygowxlFMPYwMePFOPjjiFCG62KRtrKMZJxIxAlFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571227; c=relaxed/simple;
	bh=E8qvfO77VwuFRcB88nYC/ZAbqZvATOB41Uc/3dlyLKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/1XkyrJUOblGU+E7OMj5PZh5npgjq7d+kgpzmIU32JLVSGzbXsnQrllmKfzcjuaOnQo42DGaT0HEhs0fd09HAzEJ1JO5THc7B7StYVtumHuE+8UtpxQxCUGcUEMifaviKCj5lqjZahC31oASLARBQDU2AK9MnugY4uOoUTqtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A76B868BEB; Thu, 11 Sep 2025 08:07:13 +0200 (CEST)
Date: Thu, 11 Sep 2025 08:07:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the bi_inline_vecs variable sized
 array from struct bio
Message-ID: <20250911060712.GA12964@lst.de>
References: <20250908105653.4079264-1-hch@lst.de> <20250908105653.4079264-3-hch@lst.de> <42becc1c-e842-4eba-a7ad-5b1e60594243@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42becc1c-e842-4eba-a7ad-5b1e60594243@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 09, 2025 at 09:16:25AM +0100, John Garry wrote:
> On 08/09/2025 11:56, Christoph Hellwig wrote:
>> Bios are embedded into other structures, and at least spare is unhappy
>
> sparse?

Yes.

>
>> about embedding structures with variable sized arrays.  There's no
>> real need to the array anyway,
>
> "real need for the array anyway"?

Yes.

