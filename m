Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3441B0F2C
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154280; cv=none; b=DNBbDB9SzZi62576rTkfZUYghwEramTaT5FPaNsoHYvVB6gQ+GJZRPvDo/CFZYoLFPZw9rY0cJDAQB6edpxQtyvDGRV4igfnYA/AmaQvRjhVSCBf8WwbYiZTD150IRljbkk0DGkRzkEj7WlWjLVN06fLjh9cNHCjWSYnf5uva98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154280; c=relaxed/simple;
	bh=tUkw30uDpzIzxDYNG2E00PPxHyTijgtGuBR9VicYbh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRmO4AHXE6XeHTQHMgO36opouI+p1tkeMFWrowu/TV50pD3lHOmxqrrmkEHYm4TEC+n4DwhJUxTtt6qfc2RVqLPY+xXswxR3Awfm8Ef3KcBVKqOskIBKYPAIQl4iNOhAWYG/i9n9oL1lkoaqBV4BzxJVCw48O3OnewZXKXvqgAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXkpg7AR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXkpg7AR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C44DC4CEDD;
	Fri, 17 Jan 2025 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737154280;
	bh=tUkw30uDpzIzxDYNG2E00PPxHyTijgtGuBR9VicYbh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mXkpg7AR8zrsHQv+BsrEuSL3B80x3YEmP5LpjkTR7iVrJDkEiu3SqDE614n1kdC7E
	 uJpRtu9BPpdz2MWeUgo6jULXwis2tipC8qiQupBfLUXQ/7bC9tHL96RRwPDMf5yNGr
	 jZp+XIPjJe75PjhONORlnxRcGolpxmSABSRLekZOpbaero4wTjW/Fq0j6/QTzRxzZ8
	 GETETddR/J37tSrqKVgUjJw4QNoSNJAE0Cu3Ml6KvH89h+O/hHPDnp+K1NbufeSMPy
	 0QO/UwbDN1OZbhJd97/I9w3uEwZT0km0Ii7+EVqdeFpz5Q82eQ7Uu2teFZtuA6mNJb
	 AI1MUPS8a+fIA==
Message-ID: <5ee4f1a0-5d6c-4011-ac7d-ed6c17d2cfe5@kernel.org>
Date: Sat, 18 Jan 2025 07:51:15 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 1/5] null_blk: generate null_blk configfs
 features string
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
 <20250115042910.1149966-2-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250115042910.1149966-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 1:29 PM, Shin'ichiro Kawasaki wrote:
> The null_blk configfs file 'features' provides a string that lists
> available null_blk features for userspace programs to reference.
> The string is defined as a long constant in the code, which tends to be
> forgotten for updates. It also causes checkpatch.pl to report
> "WARNING: quoted string split across lines".
> 
> To avoid these drawbacks, generate the feature string on the fly. Refer
> to the ca_name field of each element in the nullb_device_attrs table and
> concatenate them in the given buffer. Also, sorted nullb_device_attrs
> table elements in alphabetical order.
> 
> Of note is that the feature "index" was missing before this commit.
> This commit adds it to the generated string.
> 
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Nice cleanup !

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
