Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5D28A1F9
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786999; cv=none; b=qFX4Gh+NOJllvG2RoPGMIK2381fnB7SSQWIC7gCoLJNhl2Nu+7lgNmDLB7Z+EDrj9I5HqDLdVst+/7BWIxj9+kzJ/WM1vyrS+2048D1jhEjNG3LZKvg1iK7ORFSO7ror6Vj9tyAcyJKZQFF8mDv1oYSqUX4JP48UozwvtDybFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786999; c=relaxed/simple;
	bh=f5DpGvtfzIb1WEeRUVrV8Nj2HjsS7MlsFCrgA66BaNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUK5DLTtnj917lLYyo+1U7J8h261QaT3KulHWuM/lAqNUrPjYTFoGg0iDTfgL84MnU7rMNBmmi3UzYvjSIcjZ0PbVWbUGmiYvT63wriO0wSnLpk+R1XvE51OYcikH2VOtfPAMKBBFzXnLTy8ElNfkICCkNpnmritBoLINkJ5Ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTTD/Oku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTTD/Oku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155F1C4CEEF;
	Tue, 29 Jul 2025 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753786997;
	bh=f5DpGvtfzIb1WEeRUVrV8Nj2HjsS7MlsFCrgA66BaNc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cTTD/OkuavMmD1udgYlHzosZnJn/YhluYynEcWJDhs0v+bu5kV2J1zYvp2u2xHvI1
	 8lpTdd5093Oz8ituwnUbcJkIlhOY8ZE+vh6WC/RmUfVR0l2K1TbMFxL5c0NwKKroBQ
	 pOVA0Yv8FQlIWtB3FXokY3GhOAS8ScS/MdgWow91LkK9iBT0ttU9V+zY8dHcfKqz1m
	 xGsgHaui5P3Z1sNljRvZq/MFd4DMK7srhWIqaCu+E1tQ4R7UiJ+sLgaC6d+Axx9U2D
	 1MWO020Pbx4+PaPhsjlaaobj9juxD6JHCQIi2igGNDzJHamsZ0zgn590kHGA1Qg8Ss
	 /O+b5xB9FiVrQ==
Message-ID: <cc2ed0c4-05a1-4870-9577-28f5bf10f549@kernel.org>
Date: Tue, 29 Jul 2025 20:03:14 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block: Enforce power-of-2 physical block size
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
 hare@suse.de, bvanassche@acm.org
References: <20250729091448.1691334-1-john.g.garry@oracle.com>
 <20250729091448.1691334-3-john.g.garry@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250729091448.1691334-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/25 18:14, John Garry wrote:
> The merging/splitting code and other queue limits checking depends on the
> physical block size being a power-of-2, so enforce it.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/blk-settings.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index fa53a330f9b99..5ae0a253e43fd 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -274,6 +274,10 @@ int blk_validate_limits(struct queue_limits *lim)
>  	}
>  	if (lim->physical_block_size < lim->logical_block_size)
>  		lim->physical_block_size = lim->logical_block_size;
> +	else if (!is_power_of_2(lim->physical_block_size)) {
> +		pr_warn("Invalid physical block size (%d)\n", lim->physical_block_size);

Nit: format should use %u

> +		return -EINVAL;
> +	}

Nit: Add the curly brackets to the if part too.

Other than that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

>  
>  	/*
>  	 * The minimum I/O size defaults to the physical block size unless


-- 
Damien Le Moal
Western Digital Research
