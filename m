Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68522C1589
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536940; cv=none; b=pIEk9tyaBded/ibpzwOUsgnet2wHDqd8AVzS1LwMHsarOLd5ln9rx3OmgIaJlcANMaI3jRdGWBnn/QWejHf9vqD2VzFYnyXg36s9qJ/J+tkt2t7oRPw6tsOy7BwchRt+Ktsn7hfoD6HN6W52Tf6E5Md+KuKUTUSSK72KgVn+BXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536940; c=relaxed/simple;
	bh=F399ZTCdah/TyN4A/NMqmFjZab7/JkTvxSOkXF+kEiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTmBmKk9q46gpICdD3AuIyBNsMiFshUbPtG9jQvNYuSxOBnKYKDUCWJ1Fd08L8VWX2WRREzPvmwi76EAPJJcx9hLWjGC+eZ/+IahQiXN3Uh+zrm/gZxay+b9CribzZrolOh0w64UE5hav+mnLAnp8GIu1aFu1EW/dF+BjGkMpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLnGmRnm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLnGmRnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC7DC4CEF7;
	Thu, 19 Feb 2026 21:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771536940;
	bh=F399ZTCdah/TyN4A/NMqmFjZab7/JkTvxSOkXF+kEiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bLnGmRnmgwr1YcueD3SX44kmY6H1LH8F3kJCp3epTe6uijjizm1sKoj8cjcNI3Rvt
	 C5oEzKE8IXupEX7JcevNcAtIssLxz46Mojzci0uGtGDh/AIPs/aTuktTCEen6rbHBR
	 D0LJ1YNpa8d48ETncbhFVGVvtjQ1Z982t5yb819wMJ0l6qanZoLhvJ10ZhIKbbY4Q7
	 34xcJJ5W9k2MGU0UfS87Dgh74vEDtMO/rgJPhQkmYDIYtZrbFiyhOX0QqrXfrHD+B6
	 X7tf9kULV/MxMaBx8c1bviM9/iADZYzg7ht015zikxnAmfnMap4Vx75jd213tVfmkh
	 TChlFuT7Ld0vA==
Message-ID: <2c3d9a18-c1fa-44d1-b5b5-0d436f5c3b2e@kernel.org>
Date: Fri, 20 Feb 2026 06:35:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] zbd: do not handle write pointer values as
 numeric for full zones
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20260219122229.174539-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260219122229.174539-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/26 21:22, Shin'ichiro Kawasaki wrote:
>  	local _IFS=$IFS
> -	local -i loop=0
> +	local -i loop=0 cond
>  	IFS=$' ,:'
>  	while read -r -a _tokens
>  	do
>  		ZONE_STARTS+=($((_tokens[1])))
>  		ZONE_LENGTHS+=($((_tokens[3])))
>  		ZONE_CAPS+=($((_tokens[cap_idx])))
> -		ZONE_WPTRS+=($((_tokens[wptr_idx])))
> -		ZONE_CONDS+=($((${_tokens[conds_idx]%\(*})))
> +		# The latest blkzone reports 'N/A' as write pointers for full
> +		# zones. In that case, do not handle it as numeric.
> +		cond=$((${_tokens[conds_idx]%\(*}))
> +		if ((cond == ZONE_COND_FULL)); then

Missing handling of readonly and offline too. These also have invalid WP.

Anyway, why even look at the output from blkzone for this case ? The WP is
invalid, so its value is "garbage" !
Why not simply something like:

		ZONE_WPTRS+=($(( $((_tokens[1])) + $((_tokens[3])))

or just use ULLONG_MAX/-1 for the value. Any value will do. Doing so, you are
not dependent on what blkzone displays for full, readonly and offline zones.

> +			ZONE_WPTRS+=("${_tokens[wptr_idx]}")
> +		else
> +			ZONE_WPTRS+=($((_tokens[wptr_idx])))
> +		fi
> +		ZONE_CONDS+=("${cond}")
>  		ZONE_TYPES+=($((${_tokens[type_idx]%\(*})))
>  		if [[ ${ZONE_TYPES[-1]} -eq ${ZONE_TYPE_CONVENTIONAL} ]]; then
>  			(( NR_CONV_ZONES++ ))


-- 
Damien Le Moal
Western Digital Research
