Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628153218BA;
	Sat, 14 Feb 2026 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771059370; cv=none; b=rwymQTTUKMAf3V3Gr6j2xyOq23OS2gft2IVa1kVXHO8Tjuu29vqPQAuGQDSXvTRAESvI9J3nAq8/xoR+TNL278XIbg9yl5IVA6aMBHYqigiR3yIGmeBZ9fOe5Zwk6czGTwoCP0mEqM9+qNFRdZUEGDRHximR9jjRz3YdF1p47xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771059370; c=relaxed/simple;
	bh=IIzKCWqYZtUtN0moDiJHtJIxDJ+HraglrbakRnyqpsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AA+ydM04KkNUSa/ccNAM//r/ZzSrOleoS1/U0He3Uu4dmT3POiTcTKP25twxI23jkso+4EGWv89LR/uoKQLmuCBUOasxbGEKYB+DPMLi4jRPrzkTEaFpAXNmsjHGFm48cPq+miR4wfFlLYWhJEuMPrYPAe/8KMFjCKivEQQ0d/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD7xONfY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD7xONfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DC3C19421;
	Sat, 14 Feb 2026 08:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771059369;
	bh=IIzKCWqYZtUtN0moDiJHtJIxDJ+HraglrbakRnyqpsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eD7xONfYr/y8UmLWJDha5t5qrqAyLz2QCbNMHNhWV510149g6hpnhKCNQ1jF6jzEN
	 UN6C+rGRgRRWnA8pueV6qgF4qcX9/LhOyEPDUl+gmKMe3RwDKFl8bAf3SeNGVfvm0v
	 e1WGnfPJJ4We8SIprpj3j+6z4rRtpM6RTg5bC4AN/GOmOD800R3X/kgyXbLA3W2Wo7
	 vKUu4E/h2C/UIBZYbAns7cSlFaMBW0bBKd5l9xiz0CreUMQaXklheEpzpLFOBs+aR9
	 FLvyCEQhoP9BwkVLMC6plz0d5EdPJdfrMDlHg6A++Ngme/X0SGVrx7Tf4U+6S/vVsJ
	 5ABjr3las7LdQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: update docs for bio and bvec_iter
In-Reply-To: <aY7WU_q6au3HgX6W@infradead.org>
References: <20260212-bvec_iter-docs-v1-1-888607db0ddc@kernel.org>
 <aY7WU_q6au3HgX6W@infradead.org>
Date: Sat, 14 Feb 2026 09:55:58 +0100
Message-ID: <87qzqnsnz5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Feb 12, 2026 at 06:17:03PM +0100, Andreas Hindborg wrote:
>> The documentation for bio and bvec_iter refers to a vector named bvl_vec.
>> This does not exis. Update the documentation comment with the correct name.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  include/linux/blk_types.h | 2 +-
>>  include/linux/bvec.h      | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 5dc061d318a45..10403145a4510 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -271,7 +271,7 @@ struct bio {
>>  	 * Everything starting with bi_max_vecs will be preserved by bio_reset()
>>  	 */
>>  
>> -	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
>> +	unsigned short		bi_max_vecs;	/* max count of bio_vec we can hold */
>
> If you want to touch it make it actually correct, as the story is
> rather complicated:
>
> 	/*
> 	 * Number of elements in bi_io_vec that were allocated for this bio.
> 	 * Only used by the bio submitter to make bio_add_page fail once full
> 	 * and freeing the bi_io_vec allocation.  Must not be used in drivers
> 	 * and does not hold a useful value for cloned bios.
> 	 */

Thanks, this is much more useful to the reader.

>
>>  
>>  	atomic_t		__bi_cnt;	/* pin count */
>>  
>> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
>> index 3fc0efa0825b1..a05e792e6c216 100644
>> --- a/include/linux/bvec.h
>> +++ b/include/linux/bvec.h
>> @@ -79,7 +79,7 @@ struct bvec_iter {
>>  						   sectors */
>>  	unsigned int		bi_size;	/* residual I/O count */
>>  
>> -	unsigned int		bi_idx;		/* current index into bvl_vec */
>> +	unsigned int		bi_idx;		/* current index into bi_io_vec */
>
> Also not quite correct.  The bvec_iter can be used for bvec array that
> are not part of a bio. So more something like:
>
> 	/* current index into the bvec array */
> 	unsigned int		bi_idx;

Cool.

>
> Also to make this useful I think all the comments on the iter fields
> need a bit of polishing as the description is rather terse and often
> misleading.
>
> Maybe something like:
>
> struct bvec_iter {
> 	/*
> 	 * Current device address in 512 byte sectors.
> 	 * Only updated by the bio iter wrappers and not the bvec iterator
> 	 * helpers themselves.
> 	 */
> 	 sector_t		bi_sector;
>
> 	/*
> 	 * Remaining size in bytes.
> 	 */
> 	unsigned int		bi_size;
>
> 	/*
> 	 * Current index into the bvec array.  The actual current
> 	 * synthetic bvec is still offset from the caller provided entry
> 	 * by bio_bvec_done.
> 	 */
> 	unsigned int		bi_idx;
>
> 	/*
> 	 * Current offset in the bvec entry pointed to by by_idx.
> 	 */
> 	unsigned int            bi_bvec_done;
> }

I'll add these.


Best regards,
Andreas Hindborg


