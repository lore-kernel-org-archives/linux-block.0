Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331F2236F7;
	Fri, 15 Aug 2025 05:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235433; cv=none; b=KKmHGxi1An+zqGG5kFNv4bLO5uzKTlskRRe4SmkCHE5VQTFrOw561DK3demeaNpFFhytIi8P6mhA5+utrbyqq8KqSifzzND9nQruoG0QfCmOUbBnLpQg8QwqrHc7y1uoCOL6XbQ3lCrdqnb4LYD8c8vDDCgmlieTdyC6YgTf48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235433; c=relaxed/simple;
	bh=ym8nrH5PUKBlcRnup+OG13MgSMUvXGm6AMIZk/zzeB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBOjnrhN8gtR9oIUmGGYJlmZsfPCTjdiq6rm05koy32Aiottc9EvG59WLyL+AkJqTDIqHQ5lY19nD+S8EnptgczZReXR9mHgtTGf6lssykdUfa1k4EmUVb+gT7LakrQ86eHMlm8V8VcGAYFxocPk0hQVtD7CmfjqD20qhQcoLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnXYVp1X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnXYVp1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF93C4CEF5;
	Fri, 15 Aug 2025 05:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755235433;
	bh=ym8nrH5PUKBlcRnup+OG13MgSMUvXGm6AMIZk/zzeB4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZnXYVp1XqUnQAI+AMsoxessueKohz/tdVahh1Sm9QLzkQR8ni6Nu1LPlCB28JYgId
	 7SELdFzqy38rM6th8r4Ad76dEsAs35LsZVtmbAvsSY7jdS4ZqgLcs2WVPkbm/zb2Ls
	 ySVF5jG9/zagLIGsHNR59yh4Qm5vgB3fLu86rIHnTpShciwnWlOaf84qOraRVT+Lf8
	 TE9zHZDExm83UPtCK7YJin1M+7OJIXHr5gZu8M1pOhoD1704NGc9N+nSNeA8LQwgBr
	 zCB1y2/7pEVoL8y88KaQInaoZzt6ZK+yyXiWh/gEzMjCTzXk60lBysVHrsl0iF/OsL
	 a1Npka6MM8/Nw==
Message-ID: <d892eb87-6ee2-40a4-9b25-66c2f2e8befa@kernel.org>
Date: Fri, 15 Aug 2025 14:23:50 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: Fix correct parameter desc for the module
To: Genjian <zhanggenjian@126.com>, axboe@kernel.dk,
 shinichiro.kawasaki@wdc.com, johannes.thumshirn@wdc.com, kch@nvidia.com,
 zhengqixing@huawei.com, willy@infradead.org, namcao@linutronix.de,
 vincent.fu@samsung.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Genjian Zhang <zhanggenjian@kylinos.cn>
References: <20250815043033.1534949-1-zhanggenjian@126.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250815043033.1534949-1-zhanggenjian@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 13:30, Genjian wrote:
> From: Genjian Zhang <zhanggenjian@kylinos.cn>

The patch title is a little strange. What about:

null_blk: Fix the description of the cache_size module argument

> 
> When executing modinfo null_blk, there is an error in the description
> of module parameter mbps, and the output information of cache_size is
> incomplete.The output of modinfo before and after applying this patch
> is as follows:
> 
> Before:
> [...]
> parm:           cache_size:ulong
> [...]
> parm:           mbps:Cache size in MiB for memory-backed device.
> 		Default: 0 (none) (uint)
> [...]
> 
> After:
> [...]
> parm:           cache_size:Cache size in MiB for memory-backed device.
> 		Default: 0 (none) (ulong)
> [...]
> parm:           mbps:Limit maximum bandwidth (in MiB/s).
> 		Default: 0 (no limit) (uint)
> [...]
> 
> Fixes: 058efe000b31 ("null_blk: add module parameters for 4 options")
> 

Remove the blank line here.

> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>

With these fixed,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
