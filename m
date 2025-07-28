Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF6EEA8;
	Mon, 28 Jul 2025 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753674936; cv=none; b=tCOeKo8zOlMZscxLuQyRv0/ce5NtX5yQgwBSbwX/M4SOknDIc9a3G1yNBPBy4uzpEbWpCIdN0SXi8Xz8j4yh+AWxLm0pJknFoxCL/bmrODxRzJBv+28losNsUlVI6VTyydm8ZW9gyeawb+5pmI5Ic2b5g7fBtM29TIpISKL2h7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753674936; c=relaxed/simple;
	bh=IspbyPuUKbRFUFCRRceFUBq8nL8gFghMt5iHnrL2Oy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaQa2+cjOz7M1SILrtvxrH/VCVL9aHzzxywhltdmnkULscdyRoaGwsaDAGeZebHYlFqzizXoL+WOv42mEZ8NwfdqVFSDI/31lhRhqUteNFB99Zs+xILCtjje3r0Tz1Vcj3p76pBuEDPX4CcXTAli0iESvvl5nih+AR5H/HxjhHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVZ9EdJ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVZ9EdJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1DCC4CEE7;
	Mon, 28 Jul 2025 03:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753674935;
	bh=IspbyPuUKbRFUFCRRceFUBq8nL8gFghMt5iHnrL2Oy8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DVZ9EdJ2GF0i1b/2F9Fx7FZDHsZMRIt2Gap2FYjoeJ2E7nQkdZlPmv8KD9L3LuZcI
	 9fIWDq2T5jexzSaXc8Z90Ibj3+9bivbAOMsKs6Ew+FndLfKlY+UkfeDLsih+PRF3zv
	 N6wWdTu0fLeyUpsPidckrgTGIgFiU+RQA8Sv4n+V/4RoB2AdYqLMgWuhDNhFlCQhBr
	 9nbxRA191u5LspyiTdA6lwqlLb8Sa0mNg9dH6U849LX28Vgf9DKWQUQKjeMLaWpBFg
	 HHw8AWZfLFNzdRKCnIhgFIFQI++BttH7pb8pyWAUmRKrqZZvzYiHiIvn8mvnNfnFog
	 l8QZQgnNVvziQ==
Message-ID: <0f3f0978-eb42-4d83-81ad-e42cc482d674@kernel.org>
Date: Mon, 28 Jul 2025 12:53:04 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-ioc: don't hold queue_lock for ioc_lookup_icq()
To: Yu Kuai <yukuai@kernel.org>, jack@suse.cz, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250725180334.40187-1-yukuai@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250725180334.40187-1-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/25 3:03 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently issue io can grab queue_lock three times from bfq_bio_merge(),
> bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
> necessary if icq is already created because both queue and ioc can't be
> freed before io issuing is done, hence remove the unnecessary queue_lock
> and use rcu to protect radix tree lookup.
> 
> Noted this is also a prep patch to support request batch dispatching[1].
> 
> [1] https://lore.kernel.org/all/20250722072431.610354-1-yukuai1@huaweicloud.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Look OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
