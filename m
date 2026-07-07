Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF170836;
	Tue,  7 Jul 2026 04:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398109; cv=none; b=h2ubpoWvIDI1iInV2hBP90NHcDKat0uaxxnU7zBM+749ANp5+ttIM8+Vy4aQDboWcbhwerWOII8baB+tEBqMqcKHBBnUIc1cM/Nlf487tElNysD3s/56oKPtrKeCM+Ttpa6Kj1M0XW0d+LFqtNnVGLuZteC3SNlGJDGVwY0R064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398109; c=relaxed/simple;
	bh=ipcVe0ewvinqfPqa96xA6s/jXeJkmbLx8YXHrA58piY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0DDxOzusxKuITj7x4F3eBXjoKMhXFW6Kvh/t2gcbnbA/vpE10OJodZxas2j6nKUxFsQJvY/HuV1MSyTnhx5LYVl1mcMkNgNC2S6JyA0Ccsgvc7hp3vnitwoys5Y8ZHjEhgNVVHvF+xyYHxcvob0ht+zDGZeGeIYk8pd26VE1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWr9nKSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWr9nKSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F155C1F000E9;
	Tue,  7 Jul 2026 04:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783398107;
	bh=ExgCVLDFdI945RVRUzYGloq55e4gk8L19dEK84UGFxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aWr9nKSp3WXlMgwpJdiTP2xCpibnssFLt3swkf9NpINfkjb9K668OfCzexCj/KsMX
	 r38S3DHw1BXOoTnknTSFJ0cuqpt2K5I0bMeT4PzXSk7wm4yKhimgGM0XWVkiz6SnJ8
	 4EsX6bcTi5M0M8JYq+g6YoHnTjIyKmxyd6HKQDZi5ZReVG0Ae7g5aVBa3Pd/6OnFwN
	 2B5dNb3PAUZdqe9MAamthS41H7AHG3f93UoGqEpCq9qRVtFKoTpD5GYQiGYrzC2ujz
	 HXo+Uvbf4rYa82zzn62MVhcb7hD2eAoq6cwQUwMVu/mDLsYHsJbeCsj3kAeDimoRFU
	 VoUXdmbFoQ+wQ==
Message-ID: <67fc730b-7373-4738-9f13-73c354f2ae4e@kernel.org>
Date: Tue, 7 Jul 2026 13:21:44 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/6] null_blk: don't locklessly overwrite dev state
 after apply_fn
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 linux-block@vger.kernel.org, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-6-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260707025542.1299859-6-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 11:55, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> The NULLB_DEVICE_ATTR macro unconditionally writes dev->NAME = new_value
> after apply_fn() returns. For attributes with an apply_fn (submit_queues,
> poll_queues), apply_fn already sets dev->NAME under &nullb_list_lock.
> 
> configfs serializes writes via a per-open-file mutex (buffer->mutex), so
> two threads writing to the same attribute through separate open file
> descriptions run the store callback concurrently. The macro's write is
> redundant and lockless, so a concurrent store's losing thread can overwrite
> the winner's value after apply_fn set it, making dev->submit_queues
> mismatch the hardware state. null_map_queues() then hits a WARN_ON_ONCE and
> falls back to a single queue.
> 
> Restructure the macro so that apply_fn attributes return directly after
> apply_fn, and only non-apply_fn attributes write dev->NAME -- those are
> only changeable while not CONFIGURED and have no live hardware state to
> mismatch.
> 
> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
