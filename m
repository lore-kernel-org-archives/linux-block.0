Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002193DE43E
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048583; cv=none; b=nN8RRRvQayZaMU915k7YxqTcKChVvrgI2HCYlYTAHHG7mGiparkXoF60aoL5QkYMg7SliWXfZ+POu/PfjyveuDbJbN70T8i397RtWnJJ9A3aDs8xrwO4fEoHx2cmXMmj2zwT8PjuPy3Meekzl1xb4Pa6NkFlrjemUF6vxaduKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048583; c=relaxed/simple;
	bh=Hwv2ULucRNeNTguBZCBdFBtLeSnDOL6oxC3UxWi44Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6TSbUb5VdaY9z1XyyIVIDktyFki2ICnaedrmek4UG0ElNumCgkeHSSf2JHj14NwCTazsXGF8CD+QDQuwlTTVaFVTD9X4AFJwj2xF6J1q+UMDJ+/6AvQGAzdyt0i761TWkeL81etsvpPuMZSnfo6C9vtnitm3wADV2PHeAk2/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzbPpyxf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzbPpyxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559761F00893;
	Tue,  9 Jun 2026 23:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781048582;
	bh=1ubVxCnCRhZWzPWgZzfE6yzL4Xg0gDrNlXRnk0ObHDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OzbPpyxf+heKcTDuoB7gT3uFO9AgGkU9UB2L+Mz7PyNIEuLTcShZwJ0QzKXZnJaMJ
	 i8HSGxs3AuNFVkJkthISupf9sEXHogGBYEuQXv83F/d5cHfxJqeJgsVmiV8GzgWdCK
	 tuhEHWGBnW5AqA0r7gC9XuT49FIR+RcsEbveUL2Go1xIvwdKmJUBptCYWEqunzbG7t
	 DXRFsPJYvtZvuA/4P0QjWCREmHA1jdeY0+Oa/Rt3Lqc6lkM0PU59ahWjEVtXuYLMvD
	 gQAVIZqijO16ZCBpXkg4C95iJ62fLaufBDVVTA8VAHrDNgkfUMrY+ccL6lQOVkAiPR
	 uVlW0Spz6YQ3g==
Message-ID: <ccf035c5-c461-4f26-a5b0-b1b47b4a40d3@kernel.org>
Date: Wed, 10 Jun 2026 07:42:46 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/27] null_blk: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Marco Elver <elver@google.com>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Nilay Shroff <nilay@linux.ibm.com>, Genjian Zhang <zhanggenjian@kylinos.cn>,
 Kees Cook <kees@kernel.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <b70422c6f243b9275e336430071b52eb92dd40c4.1781042470.git.bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b70422c6f243b9275e336430071b52eb92dd40c4.1781042470.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/06/10 6:05, Bart Van Assche wrote:
> Add __must_hold() annotations where these are missing. Annotate two
> functions that use conditional locking with __context_unsafe(). Enable lock
> context analysis in the Makefile.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
