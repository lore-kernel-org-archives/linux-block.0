Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F622AE48
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069545; cv=none; b=b7I6h9UQwaozjAVzgQgn0/ZvsCmkd2pIH0GYRKmONOvHDYA8MRHzUFfUmMbyuTzUhaDVzsZeOp83rttAGz6edXdXmxjNzXQ4mHe0AqCqf3gXkpixySd9uaLbO2WaLOEEl4ihNLoiywGLho2T+i7eHabQHpXv57xEnc/cOIoAESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069545; c=relaxed/simple;
	bh=4pV1Tyjp4FEIVR5tFPAHg4NMdqEdQpwy9teL996fOKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/Y5Mu/bWlDYawA7Hp00zUA4xXfKtTmfSFJOmw20nz5DZlxZTtbLJWqIy37h5XCzkPVqmX1VLCYgyfZQgCn59ufcAe07+iPqeOuZRzjtEH6pCzUNXQlMNfFqCQTY2/M7+MnKw78hRkDpKccFGrghFrCEnr78K3tQuag8gP6fFhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TisKMvCB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TisKMvCB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4pV1Tyjp4FEIVR5tFPAHg4NMdqEdQpwy9teL996fOKg=; b=TisKMvCBSFh9P2hTj/0w0vwoOn
	4JL0q01Pq+DPcrTu6TZisM3JqSd95gNJK9FrMjrobhzyVKID1iZX7c3HIsdLdSksvwdTRami5uFgM
	N5/OGm0uIUGceeoqWj38LbIu6D1qoIoiBaVq/0EzSIJvjHeS6ridZygFjMCTwFJWS/BA1/i0bFwfP
	zxVsGKUa4zSs7wG6J5P6nLCag2XdrqenWKh34i3Fgsj7+O+L35HdgWDjz45/+VCbTyrNkv/4nFa5E
	XOKcbo7X5uxjAVU2xTBxcRtQ0XALhJtnF9k9fZ8EohCmsFYCXZB7/UB/mqFxHKI0HoZT84Vu/w5Vp
	IzSIP2Mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBY8-00000006pON-27Zy;
	Wed, 10 Jun 2026 05:32:24 +0000
Date: Tue, 9 Jun 2026 22:32:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>, Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 22/27] rbd: Enable lock context analysis
Message-ID: <aij26KvKBT6NT_Pg@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <e239f06e82bb4e6f527a9be87d87dd58ffa265d1.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e239f06e82bb4e6f527a9be87d87dd58ffa265d1.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 09, 2026 at 03:05:09PM -0700, Bart Van Assche wrote:
> Add lock context annotations and enable lock context analysis.

It does part one, it does not do part 2 described here.

