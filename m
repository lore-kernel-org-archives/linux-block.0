Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75D153598;
	Tue, 19 Nov 2024 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035039; cv=none; b=hBQ721+CP9TL0ZHnuZOBntO/OPwlpOoeg1ovaKziioUjyRgIQqtflYOedJfiLLXRK0Ks+ZuLlePpTQWYPSL46NeOu2OLG/KKvjA5yPxNBIwYzr0IS38X/NBqofVi67AedTyBqCndY1ynSHUxh1j41UkozYcpTRfHnFNZrzmJr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035039; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgt3Ns6oOrtJ6xhYI9crQPqh0JKT6XjZnzVfpn8BDB48+Hd5NcZujWqQAbBfWuAaM8MiGsAu9It0+Jks+oQq3Zz4rv11DNQdOwGN74cYrJykekz/bO0461hJKEp8X9PL/ROGFM7nvWiwzPv1Sc8gibjfscTyxbPC0RfyN6DYCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GM5hNg5M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GM5hNg5M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GM5hNg5M7v9fKGcpFwirpqVy+L
	DRda9WD9D/FQ+cm8Z3kNlKisW2A0PGR62YtfHpUf4HA9IXmRcIKcX09zclrEGh5Y8DwoC1OaLl9Ft
	uI3QwvLvs7ZwzstYYfpVRCgltSfdR60IBj97v6WA92bvSyGLLCD9BOb9pE40d2IDAeQ4rwae5bCw+
	HJPEZadXM7WVFQRPJh1A+ZqJGb17ZR+BUL4TVsp3IypGxs28QWcnAq7ALksNeNiaz+SZ9TWhiQ6rE
	5WTp+BtnZcymj6nn04h7AOW4u7d9MQKyA8l12Lg9aVR25EPnEPiy5D90PAjS+Spc/daP+kD2gilO+
	h8qCQ1RA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDRQz-0000000D6GA-3086;
	Tue, 19 Nov 2024 16:50:37 +0000
Date: Tue, 19 Nov 2024 08:50:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, hare@suse.de,
	kbusch@kernel.org
Subject: Re: [PATCH v5] block: blk-mq: fix uninit-value in blk_rq_prep_clone
 and refactor
Message-ID: <ZzzB3fErIdy0OHXQ@infradead.org>
References: <20241119164412.37609-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119164412.37609-1-surajsonawane0215@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

