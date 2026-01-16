Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C327816C
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548740; cv=none; b=kvSQbTIXAMQJINglaJOdA2yvBaqsTOlUdTq4/Gr6LfFzkP8g1v6kQiUfOKc6189r0oxLQrpVC4ilf5ONgw5Hrx5mr5Cf+7Nn9R++H+S1reAEA7iUfceNyjN0pyoWpAAGWih9koBDhAp8jwYTDG3YVij4dCh3NS0PYTxAxBj8aDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548740; c=relaxed/simple;
	bh=HrZxHqGlspVWStqt/o8ilWNhVPUBqQKhYTIA+Im+TIM=;
	h=Message-Id:To:In-Reply-To:From:Subject:Date:Mime-Version:
	 Content-Type:References; b=AxP0ObmKle/M5Fr2QB/Afx7jC/wUzp3DGH6BiqdAs+KJW8jyjZhFirCwcUdabaFxzWON3ppUNVqtOr3LnsFhdQjTas0moJXqD7p4S/wSYLf6trHhHM6kDnU+iItThgw217rWx+OyW795t6j8Hdgsz13F2/VaT8OYiJudYit5+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=2XF8PS09; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="2XF8PS09"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1768548724;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=OaWVvZpftbp+J+XN/0wkh2dpu90pXSBFpTSkKrTXlx4=;
 b=2XF8PS09Ht2CPoloqUuGug8G+ARYNa87I8EXWgLMx8lBnV1CPEHn1fKhWcSyZg2k/arkLx
 RRwxi4YTX/zyk2bys7sefqMTdXmaFYLqqrjE2bCNPSqQenel1cltfMIn5uowIeRgEzazz8
 RUQ6q644IFhjQzuUWiC8b99hJ6k/bhVIku1L3AUCoYPj0rbPiYnkElqG7+nfTDNJjwXoTU
 FcGkcIbAR8tcY/FqYArPEcd/YQkiT9KZqtGPcAtpT4t3+p8dxx25aROTCBqHQmYGLQsz5y
 E6XMRypUwraPut1+j7BdYfJgGo5jKYdDijQGd1y9yNB94tmdHs4AZy24zNNC9A==
Message-Id: <1cf65d49-995a-462a-b355-cd28c093592c@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26969e972+cace28+vger.kernel.org+yukuai@fnnas.com>
To: "Chaohai Chen" <wdhh6@aliyun.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <20260116061927.1004411-1-wdhh6@aliyun.com>
Content-Language: en-US
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH] blk-mq-sched: Remove redundant code in blk_mq_sched_mark_restart_hctx().
Date: Fri, 16 Jan 2026 15:32:00 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Fri, 16 Jan 2026 15:32:01 +0800
References: <20260116061927.1004411-1-wdhh6@aliyun.com>
Reply-To: yukuai@fnnas.com

Hi,

=E5=9C=A8 2026/1/16 14:19, Chaohai Chen =E5=86=99=E9=81=93:
> The current purpose of the blk_mq_sched_mark_restart_hctx() function
> is to set the BLK_MQ_S_SCHED_RESTART flag in hctx->state. Just remove
> the redundant judgement.

I don't think this is just redundant. This function is called from IO hot p=
ath,
and test_bit() should have less performance overhead than set_bit() if the
state is already set.

>
> Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
> ---
>   block/blk-mq-sched.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index e26898128a7e..2f6c353cb6d0 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -21,9 +21,6 @@
>    */
>   void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
>   {
> -	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
> -		return;
> -
>   	set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_sched_mark_restart_hctx);

--=20
Thansk,
Kuai
