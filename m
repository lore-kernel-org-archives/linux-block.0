Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4983E1D0E
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756332; cv=none; b=a7qKlTRh9hQrYv9ENKzRjcaL1qANomp8d2gfHjhzfv20dg8ntScOFV1bOatBvLGuXSOxRuYMak2azVtDav/3jveVmDhkd1I5xgDWo9lh/OUyVmIGEvcwZvgosy64L2eCNiG8KeutBfqDfuuOiTlQ6Idfm+Ui24SzR4LKTGMv2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756332; c=relaxed/simple;
	bh=3m15DZijIWfsEyX7cHmPnMSI+82pyFmnc4pY5VhLTGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEaAwHlbfrVrJIIE6yOlqDneZwvWFdVmekRgbJjQzwQE6ywr68dwrHmkzcaljeYixEnWi7sxl3fADoRUL/sjEGdao4GSlbkcbpO5kSRvG71gpyJy4ypqq+GCIY+euxhFfmhGo23HnGegAEJfoNunGe31tV0uyGcM/wFWwFE9DCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6F0468C7B; Tue, 17 Mar 2026 15:05:28 +0100 (CET)
Date: Tue, 17 Mar 2026 15:05:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 05/12] loop: Add lock context annotations
Message-ID: <20260317140528.GC2670@lst.de>
References: <20260316200901.4111651-1-bvanassche@acm.org> <20260316200901.4111651-7-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316200901.4111651-7-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 16, 2026 at 01:08:42PM -0700, Bart Van Assche wrote:
> Prepare for enabling lock context analysis by adding lock context
> annotations that are compatible with Clang.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/loop.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 0000913f7efc..9c7ed9e8a442 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -107,6 +107,8 @@ static DEFINE_MUTEX(loop_validate_mutex);
>   * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
>   */
>  static int loop_global_lock_killable(struct loop_device *lo, bool global)
> +	__cond_acquires(0, &lo->lo_mutex)
> +	__no_context_analysis /* conditional locking */

Same comment as for the first patch, please try to sort these things
out instead of using the big hammer without much of an explanation.

