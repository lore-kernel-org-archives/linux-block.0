Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE5339B20;
	Tue, 18 Nov 2025 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488704; cv=none; b=O1Z1fEjJX14yOfp7hWl7U5ep4LNtGPw0wJyqRnEfmPT/JUKy0l71Khww0Bp79r8H2yPinrsyj15BeTml34AGMOUqeP2kEZHVUNvTzhbpiHmmGJfjLZhmhCZjlpm7N81VkzwlF6h7mwcCDLqk0aSghzH0V7nkDfdbIW0hmBRin1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488704; c=relaxed/simple;
	bh=gXLYFoI5HKY7XzkdKe3wBPCOcpuojDRXTSnfYbyW4Do=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YiF6XKfYMEPzXlLSobYGM9kDrXKg26h+hS3KN7J9be8sJjU2x025m1DKzUxbghgudYJaXqI1tRK/SYJ6i7Y7ld3186Yz1IX3B/fMOc91o852j1mjkOl9l3uE0CqBFk+yE4b3orF/18IxBOlj4Byu8jTJFbwvg0Ln/HhecewoV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tkcpWsQ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tkcpWsQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDAEC19424;
	Tue, 18 Nov 2025 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763488704;
	bh=gXLYFoI5HKY7XzkdKe3wBPCOcpuojDRXTSnfYbyW4Do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tkcpWsQ6wQ6ft+VT1F4eerpYqic8MpMrWBidA6eNKsiaEuYYzbOBCnXiIjI9MPngY
	 Bc3J4n5aYkUOXdje5HtrVyQQr5TJpUzkCy1vIM9+bsCW5JR8cDh8dsMoanlYWpLMo9
	 cBdJ/a/HvkXNNfhHF3kURONhqZwQq8HcSotl9qsI=
Date: Tue, 18 Nov 2025 09:58:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: senozhatsky@chromium.org, bgeffon@google.com, licayy@outlook.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [PATCH v2] zram: Fix the issue that the write - back limits
 might overflow
Message-Id: <20251118095821.ebea2deea23aea6921866aa8@linux-foundation.org>
In-Reply-To: <tencent_2FEBA8888C5B7C3CC495E17C29EFE76BA805@qq.com>
References: <tencent_2FEBA8888C5B7C3CC495E17C29EFE76BA805@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 16:15:50 +0800 Yuwen Chen <ywen.chen@foxmail.com> wrote:

> Since the value of bd_wb_limit is an unsigned number, when the
> page size is larger than 4 KB, it may cause an out-of-bounds situation.

Please update the changelog to fully describe this out-of-bounds
situation.  Where does it occur, why, how, with what effects?

> This patch fixes the issue by limiting bd_wb_limit to be an
> integer multiple of PAGE_SIZE / 4096.

I don't see at all how clearing the lower 11 bits is related to "page
size is larger than 4 KB".

All quite confusing!

> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -579,6 +579,7 @@ static ssize_t writeback_limit_store(struct device *dev,
>  	if (kstrtoull(buf, 10, &val))
>  		return ret;
>  
> +	val = val & (~((1UL << (PAGE_SHIFT - 12)) - 1));

Needs a little comment, I suggest.

>  	down_write(&zram->init_lock);
>  	zram->bd_wb_limit = val;
>  	up_write(&zram->init_lock);
> -- 
> 2.34.1
