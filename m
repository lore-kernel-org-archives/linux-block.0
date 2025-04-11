Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8EC18D;
	Fri, 11 Apr 2025 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744329694; cv=none; b=oRiltykbm+yhmqx9DZqUAiut8d1xQ6TjVuE3pTdLozrvRb1u+rjZ8XiQL5R0EaNqZyJ/rHcoPegytz3m2mjWJlSeKQsvoYfpGGqreOneBGpaj2lS+M0CUeFGOpac69a/So7cx2TnSFfkp57ViMV+X7ptKsHbEUn56TTyWEZ5Uvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744329694; c=relaxed/simple;
	bh=sR6Q2H/tnBfnFHzjVwe0ng8gYSuAZzZOuKXxcR4gvfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a86QJzE2zWQ/lU7u2NynohWn9RZ3p71BTi2puFA6KcSGHAJBTwgP1mqaJOnEI0/RxCWHZX/Os5owIxzGKSqPUkQjE6pxFYJxreEaTuK8eBqc63pFIoY0qrhJGd+no67grNK2AOSnykLCHPZpXGRc365t2c0zoJ1aPngfKeeWH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaGPbOB8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaGPbOB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39248C4CEDD;
	Fri, 11 Apr 2025 00:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744329693;
	bh=sR6Q2H/tnBfnFHzjVwe0ng8gYSuAZzZOuKXxcR4gvfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LaGPbOB8tSHaDXo1ERd4/9ACIqqJgQ5kzlaG49zuvx+5I+G9uPsWsze5zZMtKDrpZ
	 Mn0K2CDCpuQgL/YjT0BXGTuFKTadqX9lMphGOmC/rl/HuguojawUJjVDu0A++AJbt6
	 h8rhsBQNRuwf//uD4UD3IPy47GOJ6RWyHumuOzSi0X//70M/ktc1R26vaDaop7lncu
	 2kD9Yda+s5tLHkMTWLIJcMICOLqF6aj3m55Hr2WCx1ObRj+R3Sy+Fm0p3e8NRPVa1N
	 1gSTZcKWgu91Qm4Zf55k4k5tZ+LQ2q+ZoizMeKQ/6laMtp/aKDYUuOUGOuWN/r2261
	 ROJmWnUtNkNsA==
Message-ID: <228dd40d-29b6-4978-bf40-71c9c531f938@kernel.org>
Date: Fri, 11 Apr 2025 09:01:31 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: Use strscpy() instead of strscpy_pad() in
 null_add_dev()
To: Thorsten Blum <thorsten.blum@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>, Zheng Qixing <zhengqixing@huawei.com>,
 Yu Kuai <yukuai3@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410154727.883207-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250410154727.883207-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 00:47, Thorsten Blum wrote:
> blk_mq_alloc_disk() already zero-initializes the destination buffer,
> making strscpy() sufficient for safely copying the disk's name. The
> additional NUL-padding performed by strscpy_pad() is unnecessary.
> 
> If the destination buffer has a fixed length, strscpy() automatically
> determines its size using sizeof() when the argument is omitted. This
> makes the explicit size argument unnecessary.
> 
> The source string is also NUL-terminated and meets the __must_be_cstr()
> requirement of strscpy().
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
