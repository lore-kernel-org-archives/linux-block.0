Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652972;
	b=otNYcmwciFFyjBfMrAVooldHAE0+l9p7PHxL2GfZjf3uHE/yolAOoU5zedSOBzMTdo6i
	 geZ+RK1pBcGyF1RwZWWW5VArML1k+CyQFgY23N7rcadyAvSwqdFE+6fNLGOrSy5zl9OSp
	 ZybOC+O5lXPdyOofF2YN8XS/84q7vIzt2q/+uWHJQSx6rEKsoekfqC9Po2jGYCTUTbmLe
	 ihECur0jlX1P0YK5jA9TfluNBPVYMQd0matKE9uS5LBOttUeHVSFrkbBnFUuV/qyv+Ekr
	 bj+qb2cS7VJisC/al4olDK0RxfEQ1gvBT9ysquY9UHIxlwr5ZKy4I175ONX+rn2pttQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652972;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GHdnyu2APtfGqSahpAWOhgzcEJHTs3wnB9D5EtbvANc=;
	b=JuZhiRRPI4QWrZfNZePU18k3bafaeR+Mco70Vdzjv13p2psvxMPv7x6ab9bv8Wnxykzj
	 r9+A278NgBokjvORshmDFg7kQDkxHr+g88P45rxuqGRN+jSw+KTfQJPH/ZGmjcNd63H4y
	 G3w8t2NNUCbQp82hRLAdV6qbf4Cnl7sHH2vh9dl1hJdiAq0ab8F4A6ZudhGmV6WedZJ71
	 p3LT+UYfuAPLOnKA0YvRkM/RrwgMo5vtZTmtI9Gq1qW03tZltOSGCLOAdS66DlrJAdZy1
	 GhGfJjpvr/nzyYZYSL8dAkpBR6CqKLLh3YmKioXiwR+Uo3gJv5Koj5sxiKwJyuQvz0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6NUzDUL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE7606A319
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6NUzDUL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3601F000C1;
	Thu, 22 Oct 2026 07:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792652971;
	bh=GHdnyu2APtfGqSahpAWOhgzcEJHTs3wnB9D5EtbvANc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=W6NUzDULohNeqI0aw2eM5iY4ViVPdURjpC0BT4QvXVzSv47NCY2d4tbVBs/XT3Sh1
	 wvcRjXOKxlDblD1nVoXfLMabgI3xxiT/EzPfGsW0/9Oq0lAKnoNnpfI4hl3ZTlCedJ
	 SiR7GLK/17BYsQzAP9Y4cl3lcAUuFULWXDAW83JsXL6cgTCCXo9obmoRRuLLCCKzSi
	 /Q7ywKY/5aP7LLM/iTBMNst9gtFT+oY2gfRA7nm7ZONivPhySEh92i9FS5SFIXga+X
	 S1iC1PiATtP/lFkyRUjwqBihTIL800d6Va5IB8910ij4AYX5ieclPxbne10d+ku4va
	 DY0C56u7X6Y9w==
Message-ID: <116eadd6-fca6-4c11-a420-46eef145c48a@kernel.org>
Date: Thu, 22 Oct 2026 09:09:29 +0200
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
Subject: Re: [PATCH 1/2] null_blk: fix opening closed zones at the active zone
 limit
To: Niklas Cassel <cassel@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-block@vger.kernel.org
References: <20261021202100.2017938-4-cassel@kernel.org>
 <20261021202100.2017938-5-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261021202100.2017938-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/21 22:21, Niklas Cassel wrote:
> When the open zone limit is reached, null_check_open() closes an
> implicitly open zone only if the active zone limit is not reached.
> 
> Closing an implicitly open zone does not change the number of active
> zones, so this check is wrong. For an empty zone, the active zone limit
> was already checked by null_check_zone_resources(). For a closed zone,
> the check makes writing to, opening or finishing the zone fail with
> BLK_STS_ZONE_OPEN_RESOURCE at the active zone limit, whereas ZBC-3
> (4.5.3.2.7.2) and NVMe ZNS (2.1.1.4.1) require closing an implicitly
> open zone instead.
> 
> Remove the check, and update the comment above
> null_check_zone_resources() accordingly.
> 
> Fixes: dc4d137ee3b7 ("null_blk: add support for max open/active zone limit for zoned devices")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
