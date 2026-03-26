Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843B2264A3
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506311; cv=none; b=su/kHvk/qVv9qK33yo48rUgzl0lE7ttTsnGAkBn9e1CKxwoZ94Ak9j7Ve2B8rbv3IDsYNsLrXjyTERcd+sLtVBFTkHdW9Lkr+vnzyr4aaEeSN0rmpkpA2HPVofOKAQxTpkrWChEaocyjE3wIS4Hz0aT9/1BDj8RaGCdnvvWlbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506311; c=relaxed/simple;
	bh=zHcFkZ5gj5J6yJkLtB/6Bmv2CniQJORDM5RWaRQuzlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6r1cDvyadZG974ZHl6g+TAE9E/s7PMeg8akFOomZdIRrjfyy8RPD2VSccu1i7yxaWRsxxMC8N+lTDS4iQWQ+/4r9yxr870jIYLlGk6Ks26LyTwaErlSWlnHHwhB/eHgrnGdCF6fcNxzM7k3ludCkA4/JIxDrEtU4mP6h8Rtvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3113668B05; Thu, 26 Mar 2026 07:25:08 +0100 (CET)
Date: Thu, 26 Mar 2026 07:25:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 02/26] block: Annotate the block device functions
Message-ID: <20260326062507.GC24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:44:43PM -0700, Bart Van Assche wrote:
> Prepare for enabling thread-safety analysis by adding __release()
> annotations where appropriate. Explicit __release() annotations have
> been added since Clang does not support adding a __releases() annotation
> to a function pointer.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/bdev.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index ed022f8c48c7..1f710b8bfb9f 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -312,7 +312,9 @@ int bdev_freeze(struct block_device *bdev)
>  	mutex_lock(&bdev->bd_holder_lock);
>  	if (bdev->bd_holder_ops && bdev->bd_holder_ops->freeze) {
>  		error = bdev->bd_holder_ops->freeze(bdev);
> +		/* bdev->bd_holder_ops->freeze() released bd_holder_lock */
>  		lockdep_assert_not_held(&bdev->bd_holder_lock);
> +		__release(&bdev->bd_holder_lock);
>  	} else {
>  		mutex_unlock(&bdev->bd_holder_lock);
>  		error = sync_blockdev(bdev);
> @@ -355,7 +357,9 @@ int bdev_thaw(struct block_device *bdev)
>  	mutex_lock(&bdev->bd_holder_lock);
>  	if (bdev->bd_holder_ops && bdev->bd_holder_ops->thaw) {
>  		error = bdev->bd_holder_ops->thaw(bdev);
> +		/* bdev->bd_holder_ops->freeze() released bd_holder_lock */
>  		lockdep_assert_not_held(&bdev->bd_holder_lock);
> +		__release(&bdev->bd_holder_lock);
>  	} else {
>  		mutex_unlock(&bdev->bd_holder_lock);
>  	}
> @@ -1254,9 +1258,11 @@ EXPORT_SYMBOL(lookup_bdev);
>  void bdev_mark_dead(struct block_device *bdev, bool surprise)
>  {
>  	mutex_lock(&bdev->bd_holder_lock);
> -	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
> +	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead) {
>  		bdev->bd_holder_ops->mark_dead(bdev, surprise);
> -	else {
> +		/* bdev->bd_holder_ops->mark_dead() released bd_holder_lock */
> +		__release(&bdev->bd_holder_lock);

This sounds like ->mark_dead also needs matching annotations.  Or
can we have a way to annotate the expexcted lock context changes on
indirect function calls, as that would be very useful in general.

