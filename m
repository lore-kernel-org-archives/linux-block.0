Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484112CDBE;
	Fri, 13 Feb 2026 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968661; cv=none; b=LtdhLpzFYegW5k9KTtq7SqQUpgUtccruChEEXeQVv+t3krq+hiyLsPNL1Os5kCkBW6LsTiW0r+4x1OOyU1PuDcl4Gteii57ybP0QWI/mWLbktF5iHwO6XpfjeIlyVAvRbnXEDVUTYhNQFKPVxlq/orw+0590EAabsN93j3dWMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968661; c=relaxed/simple;
	bh=Iej+NEixDFiICkcJ7oW5RSH+XN+y2EQLVBJ6GPt8NCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4lJ0pJhch1qXgpazAo1Fa5e/YKMJLiT9KmGA9yYvHQp7iz6u351oKWVQTOS3vj74pdW42aS7mIJAzte/v85+TPMjMtz/f2hhIb5+TH6a+xQYZM9gH1egScmqP8Gmc7uX/kBimCerY9Q0DJJMu23nrl5lTfUx9l2Y6cq54uQ73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ORrtKGXM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ORrtKGXM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PzJr18DZCPt/Rt8pwbA8DQVW7RLNjlPlz5tg8FEv8Uo=; b=ORrtKGXMwe9+5jo5T7ZNsDHk41
	C99i/Ik0qJMDNMJhJLgXyDn+ja1G0rjvFtk7FXps2aUX1s92YauyBMsgo3ib+iSYmAslzhRsuhoKa
	ahd8YGCJouB39S64xocDe4pOT/PTrg6sKKckqxJAhbGbnxpNxy+zgId1882VWGfYAfJcw5B/ksQM9
	1hhY8s4BMPQ7zWlJkwjdqaaF9q11fNuPfq7L7eiC0JbnuyZjLKP4bfnqq8ZTboPDROR/RAzkZnwVT
	ho9f+DkwA84IeSLC78AlZ0meApdqVF/I6pYqyePaTnJEgjrc6a0qowzWF1JhXuoI/2LGkty6SGxP5
	46/zA5mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqnqd-000000037dK-3F8S;
	Fri, 13 Feb 2026 07:44:19 +0000
Date: Thu, 12 Feb 2026 23:44:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: update docs for bio and bvec_iter
Message-ID: <aY7WU_q6au3HgX6W@infradead.org>
References: <20260212-bvec_iter-docs-v1-1-888607db0ddc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212-bvec_iter-docs-v1-1-888607db0ddc@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 12, 2026 at 06:17:03PM +0100, Andreas Hindborg wrote:
> The documentation for bio and bvec_iter refers to a vector named bvl_vec.
> This does not exis. Update the documentation comment with the correct name.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  include/linux/blk_types.h | 2 +-
>  include/linux/bvec.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 5dc061d318a45..10403145a4510 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -271,7 +271,7 @@ struct bio {
>  	 * Everything starting with bi_max_vecs will be preserved by bio_reset()
>  	 */
>  
> -	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
> +	unsigned short		bi_max_vecs;	/* max count of bio_vec we can hold */

If you want to touch it make it actually correct, as the story is
rather complicated:

	/*
	 * Number of elements in bi_io_vec that were allocated for this bio.
	 * Only used by the bio submitter to make bio_add_page fail once full
	 * and freeing the bi_io_vec allocation.  Must not be used in drivers
	 * and does not hold a useful value for cloned bios.
	 */

>  
>  	atomic_t		__bi_cnt;	/* pin count */
>  
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 3fc0efa0825b1..a05e792e6c216 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -79,7 +79,7 @@ struct bvec_iter {
>  						   sectors */
>  	unsigned int		bi_size;	/* residual I/O count */
>  
> -	unsigned int		bi_idx;		/* current index into bvl_vec */
> +	unsigned int		bi_idx;		/* current index into bi_io_vec */

Also not quite correct.  The bvec_iter can be used for bvec array that
are not part of a bio. So more something like:

	/* current index into the bvec array */
	unsigned int		bi_idx;

Also to make this useful I think all the comments on the iter fields
need a bit of polishing as the description is rather terse and often
misleading.

Maybe something like:

struct bvec_iter {
	/*
	 * Current device address in 512 byte sectors.
	 * Only updated by the bio iter wrappers and not the bvec iterator
	 * helpers themselves.
	 */
	 sector_t		bi_sector;

	/*
	 * Remaining size in bytes.
	 */
	unsigned int		bi_size;

	/*
	 * Current index into the bvec array.  The actual current
	 * synthetic bvec is still offset from the caller provided entry
	 * by bio_bvec_done.
	 */
	unsigned int		bi_idx;

	/*
	 * Current offset in the bvec entry pointed to by by_idx.
	 */
	unsigned int            bi_bvec_done;
}
