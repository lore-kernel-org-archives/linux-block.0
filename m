Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C3C25393B
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634968; cv=none; b=OZB7TtlwkgwMsN38y+bgjhZwQfSQ2CxCckqNI8nD/X0fys289/+LE9fNTZZhuZWBe2PO812gHIAHY2Z3+p32gqk+bgEWkwrC+NDiH0mhmgmmg7vxIgblYmTvOvPdPHJm776gYRpkPFsuN0Wk0WuyPnYYl7stlGx1mAnmnAlnEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634968; c=relaxed/simple;
	bh=mFaBvabd14ggol1z5KEIWwG22v1ZYNBQVg6bbfG3tYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxTy3IGPYbfGdyONgn1371Hnxm4jKJ1xr0M3HvfD/FjTFH2zV6GoxLdg9jbBsSYze3R2G7vRx5o5bcSeqK++G+BPtOtUdaLgEP9COEj4LDxrY+FjYtaP2Wi/dn+tcEPtCnOvNWWhosUw9ts9KNx9a1ktWhQzkCFcPvAEabYtJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW5cOYyt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW5cOYyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933F9C4CEEE;
	Wed, 11 Jun 2025 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749634968;
	bh=mFaBvabd14ggol1z5KEIWwG22v1ZYNBQVg6bbfG3tYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HW5cOYytUBPBIxr0zx3pVbWXJVOAzhvQdg0p2AZIUaJwRXknpHPVmB9JiOYscJSF9
	 ReJY4rNIjG/kEzRQZm5Jth7ycRF/Y8oGM5iURsabdK+N6GPkSCWtAWZPA2IjZhpX7C
	 1jsVagJAnLf0+jCNIpyL8EsN199z73A+rqUI39/btL3ulecNqngmr1tqNDvG1mIjaj
	 iK6rnSH+etVgSjt90pSEFDzWV6bD+qkJVTPKtjsc36PVjBhQKfFJ+azKy6evMkqp2q
	 YaYJvz6aNsegwTqo4g2n9bRGxNZo3bqe7CFPNZeajdNjKgWY7Z3xDgJn8bLbB8pq1n
	 OtgRhwWJuER9w==
Message-ID: <084549e6-cd58-4795-b881-f0e7ab3681bc@kernel.org>
Date: Wed, 11 Jun 2025 18:42:47 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20250611044416.2351850-1-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250611044416.2351850-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/06/11 13:44, Christoph Hellwig wrote:
> Bios queued up in the zone write plug have already gone through all all
> preparation in the submit_bio path, including the freeze protection.
> 
> Submitting them through submit_bio_noacct_nocheck duplicates the work
> and can can cause deadlocks when freezing a queue with pending bio
> write plugs.
> 
> Go straight to ->submit_bio or blk_mq_submit_bio to bypass the
> superfluous extra freeze protection and checks.
> 
> Fixes: 9b1ce7f0c6f8 ("block: Implement zone append emulation")
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
