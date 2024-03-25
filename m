Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57F2F37
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392827; cv=none; b=ba1GfAxUbtu8bFBCUncWibazS9zhRpKNHKI5UbNP7pFnNwl50CVh3NH+MBrct6GMk9uo15ZJomuBJBt1cl0RGdCQGZ4U3iO6bMUUt1vqHWBHZEEGpHXEEx2HJvXgMS6Bw9aZKVuEkYcO+yFxoPFucZ96o3Gwvc/j70gKr42y/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392827; c=relaxed/simple;
	bh=rWvmIay/qmvcUbfGLILflE9sZ0+7UoLq6Acz0IT/LFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n93pabb/R0k5fRrMlP3lccqkiJat+xPd4NNv7R/gXal8JY1tnIqtY2uK3+qq4FJBtxyYXT3XezUM+jjEsf7oD31UgHS2P4G3bHIAJZitHQc8QtlxkKDFq+DMAbXFKdqPU+2kD8cdIJMBtZpGfEProon1YB+dDfeLcm+2Sv13WeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVkDnsTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVkDnsTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0BFC433F1;
	Mon, 25 Mar 2024 18:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711392827;
	bh=rWvmIay/qmvcUbfGLILflE9sZ0+7UoLq6Acz0IT/LFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVkDnsTVzVykuLCAb/1h0PaSTYv5gqpWFV/YJoGaZ9YwFxRxp87SWilZ4ZzIRJyyq
	 gypwP3PCRzYfebv5/NOAzo+gF+kI5hmQIh8a65WZ5BFSnbiUA8PkQpYh6eyEoSoY6e
	 ++S3PyjvodtkZ+oKfJ7kziiirzLrjiKLQaG5NtQnTvz70K9e45S6MY5U7ZXZNU6vDI
	 Q/yEErM1q86W3v6VKt7p47hG+3Dgb7DCwuTGDpzF1FA0thMVO8EwrLmTVibE4KF0kr
	 eJmBJUAyRIauQ8zdKOctm+M8n7gf/QWBRFVaVJ6atSGv+xgfH7OzI8cb1UUrVtOgxR
	 3f8k6k+u+wX+Q==
Date: Mon, 25 Mar 2024 11:53:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH V2] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZgHIOUpZB78uVxAm@kbusch-mbp.dhcp.thefacebook.com>
References: <20240324133702.1328237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324133702.1328237-1-ming.lei@redhat.com>

On Sun, Mar 24, 2024 at 09:37:02PM +0800, Ming Lei wrote:
> @@ -780,6 +793,9 @@ void submit_bio_noacct(struct bio *bio)
>  		}
>  	}
>  
> +	if (WARN_ON_ONCE(!bio_check_alignment(bio, q)))
> +		goto end_io;
> +

The "status" at this point is "BLK_STS_IOERR", so user space would see
EIO, but the existing checks return EINVAL. I'm not sure if that's "ok",
but assuming it is, I think the user visible different behavior should
be mentioned in the changelog.

Alternatively, maybe we want an asynchronous way to return EINVAL for
these conditions. It's more informative to a user where the problem is
than a generic EIO. There is no BLK_STS_ value that translates to
EINVAL, though, so maybe we need a new block status code like
BLK_STS_INVALID_REQUEST.

> @@ -53,10 +52,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
> -	if ((sector | nr_sects) & bs_mask)
> -		return -EINVAL;
> -
>  	if (!nr_sects)
>  		return -EINVAL;
