Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896971F666A
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448071; cv=none; b=LeF9Tsbgx6Q0iQ/gu6p/MAhnMbG8zjrna/4bH16ojo9nU+kqZQtvYaA8MXeu6MXRtkq+IJcJwbyT/HEuCgyX+p18OaatmiR0tOE4TYBf9y4BGh4YjMVksawuegVdS25HhvRbafZigI5S7MwqkVASMG6k7jbbP9TzOUrNAXKbL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448071; c=relaxed/simple;
	bh=p2lSSEYAGHUTYZBv92OlH4JgXsXntpb3HilPhHeklBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTg26735ZwC43EbeAhJhgevvjzhsNOs2Mt7onsC2iLbCt/imYeYMxXh/u9JQV/18FFNc4F+91l9+i9tYquxFK57X9Le3Dwfu/K4aKkT59uN+UHSxfnZyA5kfTGn23hNHKbi4/ZQGbk4LjdzDJpCmL2ETxS+NB1gEll5rsJvd43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVPXwvTU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVPXwvTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436FCC4CED3;
	Tue, 17 Dec 2024 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448071;
	bh=p2lSSEYAGHUTYZBv92OlH4JgXsXntpb3HilPhHeklBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sVPXwvTU934pWiiGydxYQmLpT8z0mMAtHqZnd66DyczgUu2/ANjrkEpgT9piDfyz4
	 nwUMFhnz2/TfmdGQXMPyIFS83WEaT2/nEP6HDFrmrVoy1RvufQqgdNeqMWtetlIpmY
	 sSBt7XH1gSSkwqwPgrwjdty0N78kihcoD2BcB5Nbk8S5ManCqohBXp4kUnKnfyPd7F
	 YXlsmQIqQXwVJKwWQ/NSTa6T8WvvYvwQe96t/zvD6v0frQ3jG5lF+e3zriGTN3NJIO
	 qYfjVcqdbprtReljG83WkFLBwmey9IiG+oZPKNT29111R4tByzy0j1UCxs0Q3/BKIK
	 c+HrBoxMIIF2A==
Message-ID: <ad8ef92c-55d5-41a2-99bd-9d6f5c7ae167@kernel.org>
Date: Tue, 17 Dec 2024 07:07:50 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] blk-zoned: Minimize #include directives
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20241216210244.2687662-1-bvanassche@acm.org>
 <20241216210244.2687662-2-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241216210244.2687662-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 13:02, Bart Van Assche wrote:
> Only include those header files that are necessary.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
