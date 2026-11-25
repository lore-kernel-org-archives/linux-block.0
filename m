Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645047;
	b=cPmxF4duF9m3RwaDYA2N0pmxzN99+8imHTiN2DxuWTn5VKAeFQd5W2YAu/tH/3NQpbA5
	 gpImQqQ1d/WLCwTmgOCvUU3CkuRL8vrvk77NAVdXklTQw0yDPjcXBgPieFMIDLSRQywGd
	 6JMv07k7GSXG6KM8dTMHqER40Izv65l0Ps6b2ShjEhYfej5UmFd7PNSAVACGC7YC+GbY4
	 SJz7Yu0mp0y/VwThlQeiM+M5u1LIk0aNWF+VLYz0fzskqDp9osn0uOcO2XJt6NerFOWPT
	 bcrhx24S6pbUhStgSG9n2X2kH7MObURbm2iG8g/A20XzJS0Ltlz/AlK2uZPhofHPzig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645047;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fib/OP+gss1p6MdrM+GlozKxhBC3Hluh6G01cm7+Gc0=;
	b=L7yiaA/d/gTYWhfNSBgMHpI5z96E0oX6n4ian+7xWBBvrKoKV2KOq3ji2Dd8NagMle7W
	 FN6L3d1bRH0jWK9A0sxIFaeM5jTb336WR+Fj3kRl7Upb9hwsL6MMjA0J7ynczKk2Ud0t7
	 nHe98UYC5y/QnzHjccjbO7X650v+yPe+AmHG47SvygrllnBwWwjvjE4BZB8igy0QrF2JX
	 aQsdpoXatYviH+yc6+eKvfwIl2oDeo0GlmVfHnLKwpFzZcYiTBpwvHmcpLbGz3CtXUwme
	 u8lsowiZLGE5X8xU9eIcgjxgiz5SYTyMx7pw02zNOL/4htsarX+ECuZu86NDHQ449ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TULulOfR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2212D606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TULulOfR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53381F000C4;
	Wed, 25 Nov 2026 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645046;
	bh=fib/OP+gss1p6MdrM+GlozKxhBC3Hluh6G01cm7+Gc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TULulOfRyORqw8254ZNwE7kOdmpXLOcvs47ZzbqhP8HhysYd2cz8OtMrubvdfSrKR
	 QOgGVxE8vnUS2E1VrbMwK/GFGDJP967xqnjnXSDJ2VVIrAZtIiCK9nuAwuDv0bXTOF
	 v2cZk2hloxEnJMSb79WYh5JvMgjDMp/pFIfoOWn7zAaftmUUMszR1z4gr/vpotQuBS
	 m7HrzLBo71yV5yuod9c9HFd5tTrybUzN2RSt/CTMIC50trj/VseN96KH1dsT+nojhp
	 cy6K1hfT4iLAUB/w+WaIB0tvI2q9K40pRGnAS2KYoWAhWD3c1KW96W5LJ63hjAzHEL
	 8qXWFeHfpSRzA==
Message-ID: <c1eb9041-07b2-4932-bc74-5f82f112d4d5@kernel.org>
Date: Thu, 26 Nov 2026 07:17:24 +0900
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
Subject: Re: [PATCH] blktrace: fix ftrace record generation for v2 format
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20261124124239.146858-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261124124239.146858-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 21:42, Johannes Thumshirn wrote:
> Since commit 4d8bc7bd4f73 ("blktrace: move ftrace blk_io_tracer to
> blk_io_trace2") ftrace's blktrace records are in the blk_io_trace2
> format, but blk_trace_synthesize_old_trace() still copies the raw bytes
> after sector like it did in the v1 layout. With the 'bin' trace option
> set, the synthesized v1 records therefore contain the pid in the action
> field, the action in the pid and device fields and so on, and the PDU is
> read from the wrong offset.
> 
> Manually create the struct in blk_trace_synthesize_old_trace() instead
> of copying over.
> 
> Fixes: 4d8bc7bd4f73 ("blktrace: move ftrace blk_io_tracer to blk_io_trace2")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
