Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151603F23CA
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200097; cv=none; b=QRfUN+pcKp/y1oFmWQzIfOwFznJF9TVCFK6K7C5NGhVFKpLaCrpTEBwvJo1QhB7gORGU0NdtihuEqDxXM+mGQZqwaHdaxFrTQsHzy5wFdEroOBkyTlK4N+99cwgPp9Yz3VxJWvWhzEh20Y+/41NPQmSyX6WTLsPc5eEhMmL85g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200097; c=relaxed/simple;
	bh=lWOjj+T5MJmiyfpCrQs4Qdf+esy9N57xGeyxKiwCPaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIEVBbt+AzW3zf5sEERa0f6X9C3t+CBXFV/AD820bouCC6ItK/hZ2KzyiqOvnprqniB6Va0wKuVUUz+PesIB0u+7Wc1cNCzufIWr7PWARxHSVsgDMnlDsOXrQjDsIyw3QvzQptjAMn8WPk3/9Ep/CQEgWlbtIic3aypgiXj939E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ubSgYXrL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ubSgYXrL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3NY0Ykvy2Ovvl4prrvT2yT3g9NPZNu+PP0UWj/981oA=; b=ubSgYXrLPUAjV0+T9rCDEiBCRf
	kywUlX/dLtsj9v17W7C62zJ2uBwvzTLISS6LTLYczV19Q0ZwGUwNc3hBRi5LpfGBc4c/Mxd4gqQfW
	/HPr4hBAOiQMYOf0P3PTgPDao6waF+mavhnt1JQckLbcJ2r8ny2hjlXK44apsjFtW5lzXxmPqxpmq
	DChQ8umvHDjlYN/fKQBqYFBFPqN/8Ii4UJgsq717HhiWCfWEbLiXXDU7glyJjmRKX3O9vm7QJf6w0
	Hv0hu4+PVea7zRi/t6CE1BDvQnPyoOIDgcTblsn1MGm00WeAOkTcpHYsQImiIUr4uS/+3f6cBXK8i
	G4ouDdoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyCU-00000008OvK-1ajO;
	Fri, 27 Feb 2026 13:48:14 +0000
Date: Fri, 27 Feb 2026 05:48:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/8] block: fix zone write plug removal
Message-ID: <aaGgniwHscUGHvXu@infradead.org>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227014951.2327711-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 27, 2026 at 10:49:44AM +0900, Damien Le Moal wrote:
>  again:
>  	zwplug = disk_get_zone_wplug(disk, sector);
>  	if (zwplug) {
> -		/*
> -		 * Check that a BIO completion or a zone reset or finish
> -		 * operation has not already removed the zone write plug from
> -		 * the hash table and dropped its reference count. In such case,
> -		 * we need to get a new plug so start over from the beginning.
> -		 */
>  		spin_lock_irqsave(&zwplug->lock, *flags);
> -		if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED) {
> -			spin_unlock_irqrestore(&zwplug->lock, *flags);
> -			disk_put_zone_wplug(zwplug);
> -			goto again;
> -		}
>  		return zwplug;

So this special case now simplify goes away, and we let writes to
reset/finished zoned go down the normal path, and then they'll hit the
incorrect write pointer check and error out.  Nice!

The entire patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
