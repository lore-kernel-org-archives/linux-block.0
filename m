Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B82EE607;
	Tue, 12 Aug 2025 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012341; cv=none; b=FQryj7rLksBHiqD/W/7CvS7MkZy7TbtDyoGtV0ikLR70neERQADqeCaIw41FAXs2CsXUlfG5zMAEUijSwAF+LcOwn28mr10qhX4700ofFXIaAypAYrLWJPIUT0GvMTjWdQT0h/r57lrRt27x7ecC9H1sjbohhoTr3i5kXxx2wOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012341; c=relaxed/simple;
	bh=nsseHiGWk7TU6ziuiwgkyJRZliJgc8C0Kg70M7ASIV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tE/Tv+WQ+b4BHtEG4Yqus6YfJb/Y+t6nXnnwrKWZ3kQ23xNyDi5A3y8Weuvofjd9C9IjVokvsCz28opxdHCOo6I8H2zAzhzx6+8BZGgnPbPHTA6TyPAMysQZaWDXvi8tp96BDZKG7qj6dzofrvGudndB4Vm/757WXnBZmc9Cg34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xH+xHPkg; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xH+xHPkg"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c1b162NrYzlgqVc;
	Tue, 12 Aug 2025 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1755012329; x=1757604330; bh=3tLxKxc+TwcFKq6KBdf5w9PF
	lXQRscOu7o1mOOsV3xg=; b=xH+xHPkgFiba63Cb2RNsicnQw25Veqp+0LUTO1pZ
	A3+fgxMHu8VBX7q0J3rNEWvoz82EtRkLSIdYV5Ett4+1S3kE8sID3SVKUp5JAFms
	zTNb/fKwOPB2+i+2zCu3xkHThjyxtyyrGpDvULnFtfPBggHlEc2sZrOPtsoo5jXH
	AoNkIVqTfU7m5v5D64LyQOoKNFffdX7tezMZeV6/mUaH9EPUXhzXGIaLavJFJHCa
	gDSfyLhAeeb0bKUWWWkjEdc+kxdRdo3UaH+OcJ7b/obfGqPXVaeyi3HgvrxP3C6+
	Jr3kMuyXic624+9jM1b1dNDEnG4mPC63KwKrGbMnPzMebg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 53PdLyMLiwHx; Tue, 12 Aug 2025 15:25:29 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c1b123NtbzlgqVs;
	Tue, 12 Aug 2025 15:25:25 +0000 (UTC)
Message-ID: <475fb909-cbd2-4de0-8044-8fc5b0a1b400@acm.org>
Date: Tue, 12 Aug 2025 08:25:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix "prefered"->"preferred"
To: Xichao Zhao <zhao.xichao@vivo.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250812091803.94751-1-zhao.xichao@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250812091803.94751-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 2:18 AM, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9692fa4c3ef2..adb26eab67d8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2361,7 +2361,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>   EXPORT_SYMBOL(blk_mq_run_hw_queue);
>   
>   /*
> - * Return prefered queue to dispatch from (if any) for non-mq aware IO
> + * Return preferred queue to dispatch from (if any) for non-mq aware IO
>    * scheduler.
>    */
>   static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)

This patch conflicts with one of my patch series so it would help me if
this patch would not be applied. I can integrate this patch in my patch
that modifies the behavior of this function. See also
https://lore.kernel.org/linux-block/20250811200851.626402-5-bvanassche@acm.org/T/#u

Bart.
