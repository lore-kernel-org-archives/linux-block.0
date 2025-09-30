Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28D22EE5;
	Tue, 30 Sep 2025 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217646; cv=none; b=D0jHx0oQf66QLLJW3k8vF0ZBPt0BWyeyAv6Fulg0dYa+93MqfRCyzSp315qk61VtG5nSUEmiUlJhgPDjuUsXqVWBBk6uHpfCsyKVaStKzO/02WtBo8vs/lddvGQfwcSW2yVeR3TycqCMXkF+2XM0DD/THWSYHqTtraXJet5ZRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217646; c=relaxed/simple;
	bh=3yOBVqQcGMfUpp57UR8NJdhecSdzMtYHIfcF8rQ8U4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVx2rq/x67xI7F3353ebVtLHs/k3aDytmMs4BTT8Ub+U/OTmloF2Xtm8UoyCiHu6K16G/JoJfrDbZEA/nx6dWBAr6qnThPSqJM3HMryY7OZeXUr95e16IzfOLrX6DQdJLabEeLeT1xzXQAIHUIe2aGzg+mnkTHPT+18TPtAQoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULrNk3Vl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULrNk3Vl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9471C4CEF0;
	Tue, 30 Sep 2025 07:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759217645;
	bh=3yOBVqQcGMfUpp57UR8NJdhecSdzMtYHIfcF8rQ8U4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULrNk3VldmAgei4Q48xC9y1S54Zjb+92CxxjSoOH/jWbitFqJ/LrWc/aLVEvaeX48
	 4MBpLMqTeKk6zf/D38MpXZB8SkuVkNfSEQ9Oo0ntafuGQ54j38YW72WZ1QjsnbDxis
	 c9fU1hJRO5MrDAirBaluRFATlEDGcKEPcZwxQl7o=
Date: Tue, 30 Sep 2025 09:34:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, sashal@kernel.org, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCH 6.12 stable] pktcdvd: Handle bio_split() failure
Message-ID: <2025093056-good-profile-cbde@gregkh>
References: <20250930064850.1682-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930064850.1682-1-vulab@iscas.ac.cn>

On Tue, Sep 30, 2025 at 02:48:50PM +0800, Haotian Zhang wrote:
> The error return from bio_split() is not checked before
> being passed to bio_chain(), leading to a kernel panic
> from an invalid pointer dereference.
> 
> Add a check with IS_ERR() to handle the allocation failure
> and prevent the crash.
> 
> This patch fixes a bug in the pktcdvd driver, which was removed
> from the mainline kernel but still exists in stable branches.
> 
> Fixes: 4b83e99ee7092 ("Revert "pktcdvd: remove driver."")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/block/pktcdvd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index 65b96c083b3c..c0999c3d167a 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -2466,6 +2466,8 @@ static void pkt_submit_bio(struct bio *bio)
>  			split = bio_split(bio, last_zone -
>  					  bio->bi_iter.bi_sector,
>  					  GFP_NOIO, &pkt_bio_set);
> +			if (IS_ERR(split))
> +				goto end_io;
>  			bio_chain(split, bio);
>  		} else {
>  			split = bio;
> -- 
> 2.25.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
