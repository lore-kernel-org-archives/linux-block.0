Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3B3451C8;
	Mon, 21 Sep 2026 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012461; cv=none; b=CX1hKk4xsXcP9HwF+shNYZBPHTivR+wbPlsyb3hhxnIfSx/F0B7laYLs7iBnesRXwSkfvmD9PoX85x2ghhCDyAmvApxWX17MkTXFsIlsNRsh6FjoLjRtZLRhDmJKOAE/NeDabgVEVp/SNZUfQUDlOjvtz74i9Pm+oPrfetHtK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012461; c=relaxed/simple;
	bh=W2sTmF0h9eTycZzHaHETeYfrC2ve1SdmSUXNjWH6ogQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwfjoLFnZaNILe2XdTLP8yxK5Rx0H9yDXEDAI6UQu16tF4ZXy7lPkzrUsTrGLzbamLVuXIEd3CrR2rYi5Ar4u9T88TRqPGNYiBmKTTFT3MV/gIwASwkveI5IVJo/ZvhOZF5liBlnMHSk74NGMw6siDXWSgcJiNN3h+GD+t5lYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SqjCY2BA; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SqjCY2BA"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hpVrV1jf7z1XM4Tn;
	Mon, 21 Sep 2026 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790012453; x=1792604454; bh=s/qD/yP/nZKgimxLxhrVpNeL
	GX+y2IvysHmu+C1EYSM=; b=SqjCY2BAbY3RwG90NYkFu0VK3XdJcImidrz08Mkt
	bfamCEd5wlSkLCMrOvA3RqhlcDTeqxwJJHINBz9uEgqN0lWexSBFlvIls58maqPG
	SlOOGQURLq3XwzDB4Ey0SN/k+o1nZH8gVZW7JxJBYTBcnXh2URuYayYvdXDOR07Q
	i2t0DrmgnMhmkfH//prYw+sRZMtDU3aslcQlOL2ZwBtzdhFVk83H5LZQ+6QmVmBU
	PJ3C0UH2T4IzX8p1XI+tEfNu8f2Hzg71hQhIXYp+qPC+oENdfMyNHzbhwoauJvWd
	tEwQYEwvqGxa96BMtDK8cqkjQuTy+zAC3m2MHJyd5NmMnw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id h97cIMHrh7yp; Mon, 21 Sep 2026 17:40:53 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hpVrN0JtRz1XM4TB;
	Mon, 21 Sep 2026 17:40:51 +0000 (UTC)
Message-ID: <a7ee4ea1-c255-4613-a4cd-aa20400b8756@acm.org>
Date: Mon, 21 Sep 2026 10:40:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] loop: defer the queue limits clear to a workqueue
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260919104700.1578247-1-cui.tao@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260919104700.1578247-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/26 3:47 AM, Tao Cui wrote:
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 9f6e518e60d28..d6460f359c0a8 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -68,9 +68,10 @@ struct loop_device {
>   	struct list_head        idle_worker_list;
>   	struct rb_root          worker_tree;
>   	struct work_struct      clear_limits_work;
> -	atomic_t		clear_limits_mode;
> -	atomic_t		rebind_gen;
> -	atomic_t		clear_limits_gen;
> +	struct mutex		clear_limits_lock;
> +	unsigned int		clear_limits_mode;
> +	unsigned int		rebind_gen;
> +	unsigned int		clear_limits_gen;

This patch has been generated as a diff compared to v3. Please make sure
that your patch applies cleanly to Jens' for-next branch.

Thanks,

Bart.
