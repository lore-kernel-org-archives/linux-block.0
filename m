Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251F426EBE
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122628; cv=none; b=tAnyLqu0UHU7AkyK6BZ4n3HQAEBYR0LV/JjAX6Hl0cRbKrQ0AvNCkDq3/WD3GRZt6k8RxsAQoCWbgCvFiNHKssweDK3TcD/BoM76X/7dkZXbS6nX7seqWc8hTOYe7Mp1wJlGGy5DG5VpO41FQRJWgTlCpjwvhSCm6y1mvDyhYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122628; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0hTfedSCMtBCAUqk2M84vtKdFvIoWYv/4SNCD/VtumwPdCqImdIepUxguzXQJ6/VGEUiyxbinfq4n1AL/yud58kBwulxCV+MOSR7O6aorj5pVKGuWuiTL0YccW3waMTzsAY5Fk8V7VjMfxNykuKSQV020yF02dikprKw5Uv0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A0fUWvkW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A0fUWvkW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=A0fUWvkW0qOFFF2AgWbzxrEmDJ
	uoTNcii/s6IA3lG7f0VC8z0ToFlgE4K+ArjK8Bb6qQXD4lDMgx3ok8vUkoizr1Tivtlb6a6qVpGqg
	OtSidKOU6aZkZGX6H8B0GYHJljU7FIfHKnAAxYdYOuXEBcXhaowlXSlimgvY/wVLQrPksZM/WJEkS
	X6i1YAjIa9U/ZQw4c9Muph6kEH72604TrT2SDDVx8EwMuzv4uZG/zrEZLsxd8EjgbJk+nx8L3+PlV
	8EMF3JuE+eCg4628BjcENl0s7BQ2bQbMrrOQ0tGOKKf6UCoF6SD1qmxB4KtY9BHyls90V+5s19OhJ
	n8VKTqYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vve30-00000006iLu-43Sw;
	Thu, 26 Feb 2026 16:17:06 +0000
Date: Thu, 26 Feb 2026 08:17:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Documentation: ABI: stable: document the
 zoned_qd1_writes attribute
Message-ID: <aaByAiefG9ZiLOou@infradead.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
 <20260226041024.2154806-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226041024.2154806-8-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

