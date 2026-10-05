Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85AF41A57D;
	Mon,  5 Oct 2026 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190165; cv=none; b=ir+FL9jq4+Bbt4Ea9DyGi90n4V+a8Q96FTXWIHftjiwn0s5+DTskt2E0uRyS/ZkQfO9jpQICpQKNDH/II0mbknj6MzSoBLAJC19X2LwBHY8YPHUR6/WDd+fMTFrJIuo3cTWurhuIYsrM9uAOan3trGXnlrxKBFsxIlBqXGcyqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190165; c=relaxed/simple;
	bh=BRHpivnfsreuPPDvprMRRzoL7r3zQjMBdXjcrpgtSnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0AHHWSZWWTIJc9R14z2HZcBENdpc2kK4HDnQvYCHIjTtKHLkrpSomvlGHX0+EXV/n3LVcH4gqHlQfBm/AwFbYqN5cns/k5qwERxwRcCECJMEcgHoqwgvf/rqvt3Ecu1RE1D9G3unKgHH1qipO2B0fAdJ9QHQdju0na+KaFWHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1657368BFE; Mon,  5 Oct 2026 10:49:18 +0200 (CEST)
Date: Mon, 5 Oct 2026 10:49:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v3 for-next 1/3] block: Reject unknown status tags in error
 injection rules
Message-ID: <20261005084917.GA9160@lst.de>
References: <20260928221634.43239-1-haris.iqbal@linux.dev> <20260928221634.43239-2-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928221634.43239-2-haris.iqbal@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 29, 2026 at 12:16:32AM +0200, Md Haris Iqbal wrote:
> tag_to_blk_status() returns BLK_STS_OK both for the "OK" tag and for a
> tag it does not recognize, so a caller cannot tell the two apart. The
> block error injection code (which is the sole user of this function
> currently) relies on error_inject_add() later to reject adding a rule with
> status=BLK_STS_OK. This is okay for the current state of error injection.
> 
> The delay option added in the next commit makes the rule with status=OK
> valid, meaning the function tag_to_blk_status() now needs to explicitly
> match BLK_STS_OK for it, and fail for a tag it does not recognize. Hence
> make tag_to_blk_status() take a second param to update the matched status,
> and return true in case of a successful match. If a match is not found,
> the function tag_to_blk_status() returns false and *status remains
> unchanged.
> 
> A repeated status= where an invalid tag comes first is now rejected
> instead of being overridden by the later one.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
> ---
>  block/blk-core.c        | 14 ++++++--------
>  block/blk.h             |  2 +-
>  block/error-injection.c |  7 ++++---
>  3 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 13dc70e8f55d..c45846b9c50d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -225,21 +225,19 @@ const char *blk_status_to_tag(blk_status_t status)
>  	return blk_errors[idx].tag;
>  }
>  
> -blk_status_t tag_to_blk_status(const char *tag)
> +bool tag_to_blk_status(const char *tag, blk_status_t *status)
>  {
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
>  		if (blk_errors[i].tag &&
> -		    !strcmp(blk_errors[i].tag, tag))
> -			return (__force blk_status_t)i;
> +		    !strcmp(blk_errors[i].tag, tag)) {
> +			*status = (__force blk_status_t)i;
> +			return true;
> +		}
>  	}
>  
> -	/*
> -	 * Return BLK_STS_OK for mismatches as this function is intended to
> -	 * parse error status values.
> -	 */
> -	return BLK_STS_OK;
> +	return false;
>  }
>  
>  /**
> diff --git a/block/blk.h b/block/blk.h
> index 2cc03aa54c53..5fa54162c686 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -52,7 +52,7 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
>  
>  const char *blk_status_to_str(blk_status_t status);
>  const char *blk_status_to_tag(blk_status_t status);
> -blk_status_t tag_to_blk_status(const char *tag);
> +bool tag_to_blk_status(const char *tag, blk_status_t *status);
>  enum req_op str_to_blk_op(const char *op);
>  
>  bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
> diff --git a/block/error-injection.c b/block/error-injection.c
> index e14bc4b723ef..db543fe27630 100644
> --- a/block/error-injection.c
> +++ b/block/error-injection.c
> @@ -171,15 +171,16 @@ static int match_op(substring_t *args, enum req_op *op)
>  static int match_status(substring_t *args, blk_status_t *status)
>  {
>  	const char *tag;
> +	bool found;
>  
>  	tag = match_strdup(args);
>  	if (!tag)
>  		return -ENOMEM;
> -	*status = tag_to_blk_status(tag);
> -	if (!*status)
> +	found = tag_to_blk_status(tag, status);
> +	if (!found)
>  		pr_warn("invalid status '%s'\n", tag);
>  	kfree(tag);
> -	return 0;
> +	return found ? 0 : -EINVAL;

	if (!found) {
  		pr_warn("invalid status '%s'\n", tag);
		return -EINVAL;
	}
	return 0;

to keep the code a bit more readable.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
