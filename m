Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661763;
	b=kVURhRCS+5CKNaZhghd6tLLBZVB1xlOHstzm3OckBGtCTqZg+CbD2USNH0HCW1j4Mhzg
	 8OVrdeb3UeRNHVa+V6YC2mIMRQLlAjlXmg5r3zJdv+fAJnCyf/tO16+SkaCjXs6bU17M9
	 zP58ltCHzfe5FxX2LCLoJdAQ2pf71PfO4B8ImWqWbEfwL7/jmN58LoXdv7huKsCatwV1T
	 CtHHsNFUfD1Oj18GyWyAy7+qip7HUkGMenQAHHKrhzeqEnoCOmLFvjiYLy1F1kOfrLM5p
	 UsyY2zEAPF5Gb2dcVA/WWfWoBUsHzZjvkUs5tC6gS22VYphz6kis1yiY6bsbi83GGtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661763;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=bOLqlTDYeybY+qOI0P4ztx8d8galC8je3iP7MYWLt3g=;
	b=tAkTQm+GIxKRNVinFMrHyZgBWI4W3hcGL32ZVNOT/681ytSwDQCPze1dVZAIwDEOc3I4
	 RRYoHzBIMQjiL7fot7nsJadNRkcDvAnReMIKiZ4TeIk5E2k6pwl5UbEe2Jj6mmdRuAZGq
	 /Ie3vtt4Q38wBcgQ4i2h4M/s3ysf/H5Tw5bMTxa9d9TNv8wQDCLs1Ep1qk+rj1TCTtUk3
	 FLIqNsfbAXg2iXou4B62egbfJ2Ee3NxlU5NL9MSa+j2lpbyRTnpi0iSja4K64RVSQe30J
	 XQP+CaWNVMpmAEnhlbriIvtvpmy3bRUNvhnHhzd8XkBVBJEV6dvDzlSH0Wf6LUNUpjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bttVeewz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D83606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bttVeewz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AEA1F000C1;
	Thu, 22 Oct 2026 09:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792661762;
	bh=bOLqlTDYeybY+qOI0P4ztx8d8galC8je3iP7MYWLt3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bttVeewzjwzwXEFGnGD1mumtd8A73XPsVsJoHfFTmQegITj1WvDfElnyGmlWyTRX4
	 WdDmJqKNe1NwtfE+W/GQ6PTx1DiyrUtKWp48985YkF8S4gjIfe+ZCAiwA/U2DhXhJ7
	 noOuNFnELb01nGMXcXXU5EU9aQbvG3BIAPkRAwGr+vq7IS7buoBUGEzbtPzE1dgb/l
	 nvJPNg4aRzS971Y32XSI1dpN9l6U8YkBlPu0zAoNEWLH7M3wa0h+yu6Mh1uLspB6yo
	 CYbLARe8NfwnVT6jSpPs72+L0t0oC8j1SZ14iah3E07Ml2/ixyc2aUqOSGejb1VAQy
	 u+FL/b8GHCDCQ==
Message-ID: <64df4dbc-24ce-4aaa-8a9b-afa9a9beeaec@kernel.org>
Date: Thu, 22 Oct 2026 11:36:00 +0200
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] null_blk: clean up setting zones read-only or
 offline
To: Niklas Cassel <cassel@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-block@vger.kernel.org
References: <20261022092158.2248831-5-cassel@kernel.org>
 <20261022092158.2248831-8-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261022092158.2248831-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/22 11:22, Niklas Cassel wrote:
> null_set_zone_cond() takes a zone condition, even though read-only and
> offline are the only zone conditions that it can set. Because of this,
> it needs a WARN_ON_ONCE() to reject any other zone condition, and its
> name suggests a generic helper that can set any zone condition.
> 
> Rename null_set_zone_cond() to null_set_zone_readonly_or_offline(), and
> replace its zone condition argument with a bool, set_offline, which
> selects between the read-only and offline conditions. Also remove the
> comment above the function, as it only repeats the new function name.
> 
> zone_cond_store() keeps taking a zone condition, as it, unlike
> null_set_zone_readonly_or_offline(), contains generic code, and might
> be extended to support additional zone conditions in the future.
> 
> No functional change, as zone_cond_store() is only called with the
> read-only or offline condition.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
