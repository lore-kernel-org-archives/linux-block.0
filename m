Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559B1AA1F1;
	Tue, 19 Nov 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019696; cv=none; b=l6uZWzCCMTeahKzaoSsrPHB1YW54OjWJDQFqKvnnJqd3aMNEajeYZwixVwNB0ot6T/kY/Mhpwe3pAPgTkHLLMHCfeoztbsXglIKUP9Jk+zs/e4RnJ5k3saKNdgfZ2CwQJaCDfWOGDTk1V8wnIEcfV8aue8ZwMoLjmlpwu8Te/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019696; c=relaxed/simple;
	bh=Y4ntd7lqNra1GbzB3dOJDRk7SPwBsZ1m210j3i1SxFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osqGaW+Yov+63UrOsI41fMxwvhxZkY8Uml80rHeSEmLVPgTdvug5Zs1jGhKC00Ni/j9nywaeFsr9xV4HRPsZJPgrQD2BXAZ5yFHg14sT2J0m98Z0oRBW2EQah1AjB2omDrNRI4q/zbTXTnnH0G1z9vCid09DRbBO8MRW3pHD11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yAslGkN8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yAslGkN8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aWPfNOFyMr2gdlTCVV3ms9UH6Y9NUzgjDpZZpZXycig=; b=yAslGkN8nKkOScQwWePzSqI5hm
	wCqLZf8cyO3HzVixm91NG7d7kVuKWwioQpQGv+9DwereMQCvfYbdgZ0stpgMKULQOeWdronro/5Nu
	oHiQ3uZpEWm1PI2CL4icUMRytr1L5gCSPVLZ/WTku4cJdX09xU9mApjyEZHsjofrMS1t4GczXO/Sm
	gca26IlCRdG5j5ekV2mBYDLiAbBEysluCa7h1mS+2XsteWz9xMOPJS6I7eSA5Fr+wEcAGt7FQ7ZHW
	0+rHp0CBjoP3T7AOfkrZeP/ncRzgPtdiP+OIWQWm22wxQSqV02S98l0GG6/k9jxMcwu/XP9/twfv4
	UDF29bww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNRU-0000000CNpp-0hjE;
	Tue, 19 Nov 2024 12:34:52 +0000
Date: Tue, 19 Nov 2024 04:34:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
	terrelln@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH v1 3/3] zram: introduce crypto-api backend
Message-ID: <ZzyF7PAoII0E5Vf5@infradead.org>
References: <20241119122713.3294173-1-avromanov@salutedevices.com>
 <20241119122713.3294173-4-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119122713.3294173-4-avromanov@salutedevices.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 19, 2024 at 03:27:13PM +0300, Alexey Romanov wrote:
> Since we use custom backend implementation, we remove the ability
> for users to use algorithms from crypto backend. This breaks
> backward compatibility, user doesn't necessarily use one of the
> algorithms from "custom" backends defined in zram folder.
> For example, he can use some driver with hardware compression support.
> 
> This patch adds opinion to enable Crypto API: add ZRAM_BACKEND_CRYPTO_API.
> Option is enabled by default, because in previously version of ZRAM
> it was possible to choose any alogirthm using Crypto API. This is
> also done for backward compatibility purposes.

Which crypto API algorithm do you care about?  You should probably
just add a backend for that instead of a double indirection.

