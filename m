Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7A1DED56
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745237018; cv=none; b=Fh5xs1CVLiuhhHvNdY3E6s8QPIjgXPZYYL09SMpTYwOnnn5TrWFV0yfaO5QuKqOYlX7VpbY+Vry9SLZVYzuabvxKGOWPpvT8Pi3tSouxUzqF+XNuky3n6lpleMyYhdSuJxIvdnkTfUyklwqPpaM9CUnxaTe1V1f3f+cv2wW6tig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745237018; c=relaxed/simple;
	bh=IKXw8hSlKdaM3S3UKUrWexxv+tkgvyRch87C7x7hx3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZWp801wt47cvAXQUKvOxpwogIjK/SYImEejgX+VtJ3QjxpgXMuz1tZNF04XU7ZDN5Jpx4pvgoVr1yCQ3o5l/Dh8lTQ1xIz9jURNc9nTRCtLUYWC5Q0MhSFG5RBw25KQVWEB4lywh+Msb7ERBCNQOYF6mbHRrxoc+ed4x6qJZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fpSgWTpY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fpSgWTpY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hDO3A6gJh7dxP1hN8nCmT8cAmiz/JZcUoiVnRQsofs4=; b=fpSgWTpY9s+mE7yBTjpxMMlTjk
	yRqlPnWc6Ol2mAzZfsGy7/7VdYofdrvICAzKO+p5jkrMdVFidKeOciQpgcZU1zPrzVPimI83iGFlV
	zkwszsKp65P0LHBsGPzyq0NubIPeCSjyPM0PpbsBvJsW7WkZKgVJiSuPtAQbPBB2PiM45xlRFmy64
	o726im1vGUm86V8RcIVzzOMeig13D/UzFYW2B4ZjlvCavHZM7Bv/ovfhzqPSHXqlmqbPFv2W86DRa
	VnDc93+Cz7eF9R4MjNhQnoSgWISFb4JP4mLQWQcmLe4b3+zpGmmJQLcV0XGzhBQIrPk3p4eoCS7Vn
	nTmPWP4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6ps8-00000004Enh-3yh8;
	Mon, 21 Apr 2025 12:03:36 +0000
Date: Mon, 21 Apr 2025 05:03:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, yangerkun@huawei.com,
	yukuai3@huawei.com, ming.lei@redhat.com, tj@kernel.org
Subject: Re: [PATCH V3 4/7] blk-throttle: Introduce flag
 "BIO_TG_BPS_THROTTLED"
Message-ID: <aAY0GNzcJH28OEtA@infradead.org>
References: <20250418040924.486324-1-wozizhi@huaweicloud.com>
 <20250418040924.486324-5-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418040924.486324-5-wozizhi@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 18, 2025 at 12:09:21PM +0800, Zizhi Wo wrote:
> +	/*
> +	 * This bio has undergone rate limiting at the single throtl_grp level bps
> +	 * queue. Since throttle and QoS are not at the same level, reuse the value.
> +	 */

Please limit your comments to 80 characters to keep them readable.

But I also don't understand what "level" even means here.

