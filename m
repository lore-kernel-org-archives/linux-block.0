Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21414D290
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061815; cv=none; b=m+6q0GSP/P76qQVOee2wa/X9jrd3aPsPv2abVecEI+dvMBmUT8flqvv5r3F892B6X8i1IrD6a4uG5W4WEoGF82GCJpKjRQAVwa9XgEMmbIL4J/5NdCsz1hMdaRT77Uemm6KUE6oZbOhKzB4LlE49Kf9B5cfmis4FvYYEyULn8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061815; c=relaxed/simple;
	bh=Q3vJfOAa2IQMcJhsHSRgWylD1UwDxTd0fO3OB9KEeeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N0GHRHTdjqEuPDe4HdbkAZEpnzgKMCrt9PXCasnFtrVwazKL8EspgiY1V7vilXoR1sST+CgQFu5T3wfK/hInwiPZoTe/pcS7yu9ufrNHhCeoYsNITGbpSreFRUUQJP+bjAKJJfM38Hbtqhx/aRlPPGJ4/rfSqra8+kDTTFYZUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wlgGMjjU; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wlgGMjjU"
Message-ID: <65f8ef75-0555-47e8-9da9-c5a99892202a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714061807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6GLKBhouX+vNCUCld20wD++05J3HQ8t6SQdO8Sdbpw=;
	b=wlgGMjjUp2yl88wzSD883kWkF9LhbVQQUhQCuCrScixstnKpQgBxdfXyyFOHH+MEc3hnQP
	inZOhMdqA/54IseHWqZBVTvl1N1QeIQp0ifS+H29pAgaGgf2C3Fh37s+h9mHWgoQ29h2zj
	Igd2EkhyQwellJzSN2nrPIT3IM+6sdA=
Date: Thu, 25 Apr 2024 18:16:43 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] null_blk: Fix the problem "mutex_destroy missing"
To: axboe@kernel.dk, dlemoal@kernel.org, linux-block@vger.kernel.org
References: <20240425153844.20016-1-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240425153844.20016-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/4/25 17:38, Zhu Yanjun 写道:
> When a mutex lock is not used any more, the function mutex_destroy
> should be called to mark the mutex lock uninitialized.
> 

Sorry. Fixes tag is missing.
I will send out the V2 with this Fixes tag.

Zhu Yanjun

> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>   drivers/block/null_blk/main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index ed33cf7192d2..eed63f95e89d 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -2113,6 +2113,8 @@ static void __exit null_exit(void)
>   
>   	if (tag_set.ops)
>   		blk_mq_free_tag_set(&tag_set);
> +
> +	mutex_destroy(&lock);
>   }
>   
>   module_init(null_init);

