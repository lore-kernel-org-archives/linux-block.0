Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF42D629
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602347; cv=none; b=ZYutbeohQxXTOJC4dUF04R6yE40bgGDewVcNPKKSE2U7+k/PPBqxz+8DNhCsUo1Fl3pAY9m3BvOP86XqUPfT4nTPtmIjf8ye7ddDJDNx+FpW0y4VTGqdGgGZMZUekeiUKFxJfw3Al6W7KG1pSgaiL4BcKXuf7+ji4n6ycCNVaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602347; c=relaxed/simple;
	bh=F6dEkrKtgYVkNtxUhG7SaK9f0d7gWmhPuu63w8ce6MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kyfo0OctvCiiGr2Y2ACW3hL/c9SJXydezdEd8Y3ep279bWEHVudJQdYkdlP6j9deNJlTzaFi/IWlw/qObH/6PipJbQwWLx0mF0y4KkCQOvijaWRYFGFQXY6gB/4715FmjLjYZ1shnqsAFjyeB6zOL/M4ascM0iEbSQRWDnwzzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onBejTFZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onBejTFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E9FC43394;
	Thu, 18 Jan 2024 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602346;
	bh=F6dEkrKtgYVkNtxUhG7SaK9f0d7gWmhPuu63w8ce6MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onBejTFZK/YYg6A0WlzbJigcMjilLOOthxvSiiK8BmrNi0qv1c+VEvf9QR+Res711
	 9FieRI2IMJqAwtlQnPFanBc+JJS8VmzScFiAyWTuvYTRoj7Rp4e3ZyXeCOZva8a8L9
	 7GDhwUbsl7ceXqqexGLdYPWUGSgwZ0VyvTl98JCGcMXuMycWUDfCmlrurWsI6kfmqH
	 M97x4wBfWwEo8aLmCW+05/9IyYmyvNX6PWR7yRz74jhLU4Z1z7/R35poT/ke8bIs+7
	 FZZ5Qr53wbvC2gpVujr0RVC9Ua7lzRTGejD4+QayLjWg7dW00lUfbupDAUbqKdjkgh
	 qZ03KX+Ny0zvQ==
Date: Thu, 18 Jan 2024 11:25:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, bvanassche@acm.org
Subject: Re: [PATCH 2/2] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Message-ID: <ZaltJ2H3pRVFqXIu@kbusch-mbp.dhcp.thefacebook.com>
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118180541.930783-3-axboe@kernel.dk>

On Thu, Jan 18, 2024 at 11:04:57AM -0700, Jens Axboe wrote:
> +#define DD_CPU_BUCKETS		32
> +#define DD_CPU_BUCKETS_MASK	(DD_CPU_BUCKETS - 1)

A bit of wasted space on machines with < 32 CPUs, no? Sure, it's not
much and the fixed size makes the implementation simpler, but these add
up.
