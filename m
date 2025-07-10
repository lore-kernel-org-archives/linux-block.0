Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690F2F3E
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 04:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121036; cv=none; b=I4gikf27Qfg/O5GKUjx0C78Qp5qax5nAsfeCjxDMFU84bMsxPhBGBKtjq+yOfsGZt1Mvul3C7+WdBy8LmisxNugfEfS05RZXW1ddBX9WLKDegOgTQGWfWYmuuUKpWoQetWrT8Qmz/U+BUBx1hrCD5s0wA9n7L3HfM8Cm/lhjc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121036; c=relaxed/simple;
	bh=2IqYWLLjroHBkJr3OBJ08jEm5zTLj/pnzoltRRFNfgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8fFbGgyLV44fyFR7nZqpQbl5Tx6yI64nNnssY5S7Yuc7mDQswHE4fVFnLThmfeuvm2IjtQlAdunwKvak5VCDOc/eqRJgPJSvsA/SdzNU9nQYzi78tV/UKUQfocVzGsbf3ude66xo7qaXQC0vEwvNTxoWfKX8pZtqCY93SVET5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvnBlvf8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvnBlvf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B4AC4CEE3;
	Thu, 10 Jul 2025 04:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752121036;
	bh=2IqYWLLjroHBkJr3OBJ08jEm5zTLj/pnzoltRRFNfgQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RvnBlvf8BhdMjxUPafvZ1j8ArqiP0WQJLeXGHJs8yx7a3mIxM/01APJt0R7epPss5
	 AGYX19bHv1aSHCdW/PsoJrKjfkNBYc0nYx6nXNANitn/5u8yVSIHCXWQpNVh4aDBbt
	 jtE4t51F0hLKmrpwSd07+MeH8qu3qmeq130IFCrZRU03+nZKq3kGYariwVVGWvYmt8
	 U958PdSQZdLnpRcd43nEF8c/4ybA438uuGKR3JbW15u6fEVWPJeAoowbFHbgFxONDC
	 xY86VA3YqRIGvm2w4fsdgJKsAHsUMc6xFZLoBG/1JynzwGTrH/ZsSj8Hw+4op8uXKK
	 fCwjCh9S+P8Lw==
Message-ID: <0ae57bd8-3f0f-4434-956c-fa6747cb319b@kernel.org>
Date: Thu, 10 Jul 2025 13:15:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] block: split blk_zone_update_request_bio into two
 functions
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-3-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250709114704.70831-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 8:47 PM, Johannes Thumshirn wrote:
> blk_zone_update_request_bio() does two things. First it checks if the
> request to be completed was written via ZONE APPEND and if yes it then
> updates the sector to the one that the data was written to.
> 
> This is small enough to be an inline function. But upcoming changes adding
> a tracepoint don't work if the function is inlined.
> 
> Split the function into two, the first is blk_req_bio_is_zone_append()
> checking if the sector needs to be updated. This can still be an inline
> function. The second is blk_zone_append_update_request_bio() doing the
> sector update.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
