Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687B3C13FF
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159011; cv=none; b=SHW+1ep7pSN4pkC20XOqcYIAI0OPtXkhJZk/BBIkUxsUmY82Z9symAYOkMRNOxn61r668VtDkcpQGRv6bwvt7ef3spEBOMniiTcNMNJLo98hUq92BgqABRxyIMG3iT4iejc3TAk3rAFDAj7pW4+s1A0kLT7GNseXRt+eSNCATPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159011; c=relaxed/simple;
	bh=uHIh4c9K8CS2KkwogB0RpIK324HP9b00ZgfGn1rcvOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnHqKvrxy7Ml5xkr+dFpTSxcRa8BoeZQIO0/nkzrapVZV7fikWX6ciOy5hQVh8lVublK11d2aHiY12xWkhsS23hsGsVP21GaEzYxh+zONhwPBRghdO3nu6rTPfhu51MOJjWo2tRjRltssB/rShIoOw5M3KF+pxEfFAJWT30u6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K98zmTKj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K98zmTKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AF7C19425;
	Tue, 14 Apr 2026 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776159011;
	bh=uHIh4c9K8CS2KkwogB0RpIK324HP9b00ZgfGn1rcvOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K98zmTKj6Ad6P+EbA/XBgBYkjwmLIQhpTJPmyETC62jOmQeVgXwEZm5gGQ0DxtPcC
	 HvMZLwEwC4uSmt5cNyWljBUmjqgsBcZ8AWhRiQslZ0mSSp3SctX2Xwna3jY5pcpYPN
	 G3H1jg1ph9EcBXWpuUpWe0nTddsbW/auevQDSyux/Fe07ynLjkCk7iXJ8AKGp2LNBH
	 Facs4AYE0vPLpf+5pzg0oitLXccewWaII9rb95bPglc+hfN8ckbsOGv0ugXvWdygH1
	 VPzGOrwRv5ubeJwBMPufcCnZdUk4ypemC3Lt/32IvZg2zsVTDtt3tjjwZJpz9VKZFo
	 X3w8CEIRxgY7Q==
Message-ID: <6b4e175b-263e-4e56-bdce-680e50626758@kernel.org>
Date: Tue, 14 Apr 2026 11:30:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] zloop: remove irq-safe locking
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260414081811.549755-1-hch@lst.de>
 <20260414081811.549755-7-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260414081811.549755-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 10:17, Christoph Hellwig wrote:
> All of zloop runs in user context, so drop the irq-safe locking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
