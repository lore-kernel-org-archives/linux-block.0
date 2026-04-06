Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D0221FB1;
	Mon,  6 Apr 2026 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775456699; cv=none; b=OshVBg2uPUofrTHfm/hC/70RLDeNzrzmI/HDqFNMQv9nU0NAfFXyKmvSrIAhJ4FEPMSkjZSutKaIEUNSMvfxuGQ03GZDF9qNOFzabH7jUTEef1IsTUuWnhwsCzcn2wmesyRbuYW+zPpXxtbL6iw/UNjqKkFCxto+2xLRWekCwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775456699; c=relaxed/simple;
	bh=m3snPEQZ78gA909gk84e5KQlvOS6nbW3yEq9YjG4fZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXFGiP+ijXCmpT64FYqkiQoIKAqgb6V8UrE1n+fyXNPprh6v5mQW5l9Xn19WTnveYYcEmH109K8hU3yKzusPJ0tRuAKP46vvb3l/PGI7n2JpWshL88/hB58xO4qeN6Di9kZfKPfL2jTdox9xt/0wmaWXQ0LCV7vxF7MRHfzmpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pLmpdkK5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pLmpdkK5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R29TxGLXg7FHQ9GmrPJFsq17DbINDvyHpymOhOOy4xU=; b=pLmpdkK5OL6SrKq5efcgPoZU3v
	abfrNh5zRPg8/xx0EEPupR6Gxfj5y5ubPXlXqzW735u2/IJwBmcdV0Tn2jmiZg0gXOTLZMiiSMmNj
	g37hs7nPM7r9qNORFOFAPTBbjE2+QoL9IZA3QcfBQpXthf7UmUhHnjNvZ5GwmiLfMRegYfc8DoxmV
	S+pd9Tgz1ioA2VcITBX+NYuUS1zAsVi8tBqWeKUCkfz1qg8pROkshtZaggXoX8sYd5V+QTsNJV4Qh
	/tAxiUZY4iU1dTo6jXCyPHfP63kVGnohhBXGjdsgpAaInuzcSB2QYP5ANTzS92p7jdLhKESzMVDaR
	33plwtng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9dOL-00000004qM6-0d2n;
	Mon, 06 Apr 2026 06:24:57 +0000
Date: Sun, 5 Apr 2026 23:24:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] t10-pi: reduce ref tag code duplication
Message-ID: <adNRuW8uVwHh2RIW@infradead.org>
References: <20260403185101.2172135-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403185101.2172135-1-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 03, 2026 at 12:51:00PM -0600, Caleb Sander Mateos wrote:
> t10_pi_ref_tag() and ext_pi_ref_tag() are identical except for the final
> truncation of the ref tag to 32 or 48 bits. Factor out a helper
> full_pi_ref_tag() to return the untruncated ref tag and use it in
> t10_pi_ref_tag() and ext_pi_ref_tag().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  include/linux/t10-pi.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
> index 2c59fe3efcd4..c6fe5db47c7a 100644
> --- a/include/linux/t10-pi.h
> +++ b/include/linux/t10-pi.h
> @@ -35,18 +35,23 @@ struct t10_pi_tuple {
>  };
>  
>  #define T10_PI_APP_ESCAPE cpu_to_be16(0xffff)
>  #define T10_PI_REF_ESCAPE cpu_to_be32(0xffffffff)
>  
> -static inline u32 t10_pi_ref_tag(struct request *rq)
> +static inline u64 full_pi_ref_tag(struct request *rq)
>  {
>  	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
>  
>  	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
>  	    rq->q->limits.integrity.interval_exp)
>  		shift = rq->q->limits.integrity.interval_exp;
> -	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT) & 0xffffffff;
> +	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT);
> +}

This should probably move abouve the struct t10_pi_tuple definition
so that we keep clear blocks for classic vs extended PI.

> +
> +static inline u32 t10_pi_ref_tag(struct request *rq)
> +{
> +	return full_pi_ref_tag(rq) & 0xffffffff;

Use lower_32_bits here to make it more clear and mirror the ext version?

Otherwise looks good.
