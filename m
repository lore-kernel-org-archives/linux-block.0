Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C883D4118
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964855; cv=none; b=h02wvZmAxwxfcY84VN02NF22CE6BeljfaWeo8EpOO/aoiz+Up4clTSUkz3wpI8IL/QaFTt3yKDu4xhMgaJ4FmJbjuhfSsKFjQrmw6Jr8nmH140Xs2fJ7MaPQxXbqIF4cSPZIs3fx1eSB7+/0ibpIeAWxE/h4nlu1PedGDEP6DVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964855; c=relaxed/simple;
	bh=1pEI2lnlX3JHztcB4CIGc+l7SsRYcpOItLWU98YL44Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kftgAvoygEOSSpJm+CP6Q9c4WgRQcga51IFeMK8cWrTtPe9nKdr6QXQQB9jExpPbvgaA5cOA97qctHLDrGTuF2uvnAb2+r/AuQq/i1T+p/1PD4sZTjocIjymNj7d8yfmcaIwHuYtMqXOxAmwtpALPjovenR3zX5znh5qIccJFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wrXvsZOv; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wrXvsZOv"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hFjxr15xHzlfvpy;
	Wed,  5 Aug 2026 21:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785964845; x=1788556846; bh=rbIUavgVsPzfdm3ogGhVMoXb
	ZIPKz8fxe8EkeE7jAgU=; b=wrXvsZOvxY0Sx0Z3pp2wYXeSZcQXjFgASAKQoKsl
	xuv82iOq1nwV7ueP32b7dyMz9KPn8E0LrD0d1NKqk8lVds6LfF4S29m+dpP5iVa9
	BooMjDawsdPN8SLhhhKYcW+c6dk6qCeYhaAI/DijD5RdgQYld8K5CwuwHlVQ8gcp
	M2lU1e1ufSEsMh9FP3e1CScWXEsHfRSXsA9ZIvycb83/FYQ5s2QTNhQEE0RL9Sxs
	ArpIaKi3rCgFTt+bFqNTWZVYuIcSu30BDoUwDZGFqvHNwRLFrrtEJpsqA07ZjE96
	vwhTMDh5RjlgPiCp3PNWutbiLz/ud0G4oYXlImNY+NYFrA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IprcKWnKbNrb; Wed,  5 Aug 2026 21:20:45 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hFjxm4fzxzlfvpN;
	Wed,  5 Aug 2026 21:20:44 +0000 (UTC)
Message-ID: <6f7bdc51-3f95-4a79-969d-111712b03643@acm.org>
Date: Wed, 5 Aug 2026 14:20:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] block: remember a zone type regardless of its
 condition
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260805022719.735323-1-dlemoal@kernel.org>
 <20260805022719.735323-5-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260805022719.735323-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 7:27 PM, Damien Le Moal wrote:
> +static inline enum blk_zone_cond blk_zstate_to_zone_cond(enum blk_zstate zs)
> +{
> +	u8 idx = zs & BLK_ZSTATE_COND_MASK;
> +
> +	if (WARN_ON(idx >= ARRAY_SIZE(blk_zstate2zcond)))
> +		return 0;
> +
> +	return blk_zstate2zcond[idx];
> +}

Isn't WARN_ON_ONCE() preferred over WARN_ON()?

> +static inline enum blk_zstate blk_zone_cond_to_zstate(enum blk_zone_cond cond)
> +{
> +	if (cond == BLK_ZONE_COND_ACTIVE)
> +		return BLK_ZSTATE_ACTIVE;
> +
> +	if (WARN_ON(cond >= ARRAY_SIZE(blk_zcond2zstate)))
> +		return 0;
> +
> +	return blk_zcond2zstate[cond];
> +}

Same question here - isn't WARN_ON_ONCE() preferred over WARN_ON()?

>   		default:
> -			blk_zone_set_cond(zones_cond, zno, cond);
> +			blk_zstate_set(zones_state, zno, cond,
> +				       blk_zstate_flags(zones_state[zno]));

This is an open-coded implementation of FIELD_MODIFY(), isn't it?

Thanks,

Bart.
