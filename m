Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7652367B8;
	Mon, 25 May 2026 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695158; cv=none; b=UrdBIKgeqdQmrROgnIOHcyrPhnoIwUEbg+zSHYsAoOu9p1rtv+UwDnGWwfD5Ya9D7BiHn4Kryh5uKXgB+FwYtBQQeuJtbJ5xDyJcLcwKi+TBAyInf1uv7WRJyugpjxA1lcUK/1t7kozicOI7zI2rrL3DAPW2JA3aiPLVgsFuWA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695158; c=relaxed/simple;
	bh=t/cYPrdwJNXzSep824CP+QR2P+HPjArNcs9iORgSGuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+0CUPparkAdjY6/Mm4EId8w2HeXpHABEr3SpR8BClzZVGBzzqbCbj0TegHjaa/VEVRYYEKhqQ77N1ex/e5yZOVfJBgPY1WQw/hV429Dfmq/zNkr6nUcDkdWLxRZc9xx7OhUMkBbsnnxljEP8v8tN5pwEZjjudG29jYZeRVK8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C37968B05; Mon, 25 May 2026 09:45:52 +0200 (CEST)
Date: Mon, 25 May 2026 09:45:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: fix dio leak on integrity metadata mapping
 failure
Message-ID: <20260525074551.GA5432@lst.de>
References: <20260518074258.1600307-1-aaron1esau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518074258.1600307-1-aaron1esau@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +			if (unlikely(ret)) {
> +				bio->bi_status = BLK_STS_IOERR;
> +				bio_endio(bio);
> +				break;
> +			}

AFAICS the same issue also exists for the other goto fail case,
so we should convert the code at that label to a bio_endio().

I think both this and the existing -EAGAIN case and even the
-EIOCBQUEUED case leak the reference on the original bio.  Or am
I missing something?

It might makes sense to stop playing games with that bio refcount
and just have a status field in struct blkdev_dio.
