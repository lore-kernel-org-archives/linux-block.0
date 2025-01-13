Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF8922CF05
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776237; cv=none; b=ZdwqkLSFEkqRkC7aZoWvZIvfe6Y8QuNrtXO4xCZEQmgWVZx+pc1sTt4i8g5tuzNchaFVhI8iU3vrjvsWH5VS+9RpYV13tKlRFVnSkZ5hGJg3RfLisztJdhO6vanFkrOZKKMvEPsXjxoM3N0Y7jzec4eCsFnKR4RMh3LZ0balUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776237; c=relaxed/simple;
	bh=6SFDkfXxdRJrbuCBqo17XEF1WfRPflC4UZqv8pZw5WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhdLfftKFmfnLt6OaFeNKB7EVtZCa3JjGHTNRfd+75SErOmYa50BWbAT/yCClCosW6OGYl2gF/wVgArrTzMmTlZAyQn8tK3LvCmOpYtOV9aMi2Uk9+IHJEJTb2xZS1rDP59APpFZIx3qTw0mdGfGLP9+MthPXaUw+4DiW/crym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bhb0JT//; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bhb0JT//"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pNdhEwadkB1eS3huO5DV79eBaxl57jUcYRETYFIMKZg=; b=bhb0JT//Z8V/h0s5x/P2xfB4FP
	UQmTz7ysLpwyjzGSZeBOSCbYOHzcAgN3bW88FQ5bOEb7l+SyL4oToNVeU7D+8HxQ6BHiBZA6F+pGY
	9EWlYl5fvl/D1AE0UCkvr0FWB7UA1uFed8U3m2xOko/XU2lC5bC4m3eebmHKJyemSftmoWTKtjN96
	KVSqNHCEQYZGJN0ISvxzQTArgKbC0PjbyLco7qzOgN/gFfkU1aYFmEIaVWMgwG7Vw/hQnmUyD6W4u
	As7Fhm9Fxsk9kCflPT/n0quHT5YFQTpze0gWJAjFdsZSfX04BfVc3EKyKJX6GmIG1kJewUyrL5hY5
	N+OIyclw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXKpu-00000005JM2-2lsz;
	Mon, 13 Jan 2025 13:50:34 +0000
Date: Mon, 13 Jan 2025 05:50:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: move vfs_fsync() out of loop_update_dio()
Message-ID: <Z4UaKmN551grXYMn@infradead.org>
References: <20250113120644.811886-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113120644.811886-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

NAK for the same reason as v1.  It's not needed because there is no
deadlock, just a false positive due to missing annotations of lock
instances, and we need to fsync with a frozen queue to ensure there
is no outstanding I/O.

