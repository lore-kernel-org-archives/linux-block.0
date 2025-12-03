Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157421E7C08
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764742383; cv=none; b=N5bRQkoXsnabkTTIELpIjQ8fadxKYCrw+Gc7S6UVAsP2HsuMzw4lOWTDuKYb+MVzFBChmshVg8uxksNJa8VtIU9b/V9uU3sNhiZXm96OFoYjSWqKLg2RaMaZT1V0XxpcUx3ytx6SkayKU7JjsxY0UJkb3Zw3uMKpIaiGfOlaGnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764742383; c=relaxed/simple;
	bh=jqeNUozN4U7UOKZtPl+SPcdPlivLnSxvhLlrdM8ZG9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVO/m0QyxYo047flBV0qPHQnbYf8f51QrVYsCdap2YDGj6agFwZRGjlImeN3bHe8cELd1uHVqdVyryftr23TN9kEmRRaYc0cCq7MY+m6OUfOy8PzYAf3zG+K5OmIGcEKQpAZqiyLNGdOsXRpXYtrbKZAm9YLI2UB1miMMqQO5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjqjdQiu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjqjdQiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44021C4CEFB;
	Wed,  3 Dec 2025 06:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764742382;
	bh=jqeNUozN4U7UOKZtPl+SPcdPlivLnSxvhLlrdM8ZG9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjqjdQiu3qFiyzHkGqSgh7HmcbB2MwAr1UOKGFIgTha2U1C/O85Bo3IM0LALBxKTH
	 VK88V9KcxEjwnhIHq0YCwpIv13J9qYijsDwXPxj6OhtmAhnXmxeqjBHjVnb7TAxi20
	 5v+vrb+CZOZ0QYp70UoNP76348rl6LtDA2EHzwI6y2MQgRYq1/gdqcPUKm0p5eRLSp
	 Tsif8Dmm/wZMXZs9jVQI7YOlTAK5ERv2WDor4GSar14+Cu7T17sOdBOhMuz9ddvmk0
	 qri4TY5y7noZbRW25K8dTqIQl1fqmLjpzXDM6oFlr4KIqKApqoSTGYcxGpNpet5sls
	 Hd3U6YfU/BGIw==
Date: Wed, 3 Dec 2025 07:12:58 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, dlemoal@kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH V3] blk-mq: add blk_rq_nr_bvec() helper
Message-ID: <aS_U6m9ZzQHFqE23@ryzen>
References: <20251203035809.30610-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203035809.30610-1-ckulkarnilinux@gmail.com>

On Tue, Dec 02, 2025 at 07:58:09PM -0800, Chaitanya Kulkarni wrote:
> Add a new helper function blk_rq_nr_bvec() that returns the number of
> bvecs in a request. This count represents the number of iterations
> rq_for_each_bvec() would perform on a request.
> 
> Drivers need to pre-allocate bvec arrays before iterating through
> a request's bvecs. Currently, they manually count bvecs using
> rq_for_each_bvec() in a loop, which is repetitive. The new helper
> centralizes this logic.
> 
> This pattern exists in loop and zloop drivers, where multi-bio requests
> require copying bvecs into a contiguous array before creating
> an iov_iter for file operations.
> 
> Update loop and zloop drivers to use the new helper, eliminating
> duplicate code.
> 
> This patch also provides a clear API to avoid any potential misuse of
> blk_nr_phys_segments() for calculating the bvecs since, one bvec can
> have more than one segments and use of blk_nr_phys_segments() can
> lead to extra memory allocation :-
> 
> [ 6155.673749] nullb_bio: 128K bio as ONE bvec: sector=0, size=131072
> [ 6155.673846] null_blk: #### null_handle_data_transfer:1375
> [ 6155.673850] null_blk: nr_bvec=1 blk_rq_nr_phys_segments=2
> [ 6155.674263] null_blk: #### null_handle_data_transfer:1375
> [ 6155.674267] null_blk: nr_bvec=1 blk_rq_nr_phys_segments=1
> 
> Reviewed-by: Niklas Cassel<cassel@kernel.org>

Missing space before '<'.

Perhaps Jens can fix up when applying if you get no further comments.


Kind regards,
Niklas
