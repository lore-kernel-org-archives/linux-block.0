Received: from sg-3-27.ptr.tlmpb.com (sg-3-27.ptr.tlmpb.com [101.45.255.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043134B1B0
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355707; cv=none; b=ORcDpPm2sXI4aZ0uQulojgXj+PWfJ+j4A2w/kF9w3tOk5sjqScJU3SJGR/NAQReJ5q3Nk0P47/NkLlCI+gOdziEnVLf4L5030cAJDGoHOAT5+xH5sgIRegXRHYC9vHqENLyuKsvLuE1pJkQ+kC4u2Btb0F0vMbwns8mIUcHhaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355707; c=relaxed/simple;
	bh=TCuBdQxIaXMb5Kz93JXxvVM0Iz93kDNFn+gcxV2K+yE=;
	h=From:Content-Type:Subject:Message-Id:In-Reply-To:To:Cc:Date:
	 Mime-Version:References; b=unw2hPcJ7EJESK0RM+c8qOoOxezYAh8d7jF14zXRXkYA05J7Xi6xE3fCdj0YKmWmoILVPAqOQKZdNa4hCIqPppvvSKX2ijwBu2AcZrnyz19Br66ONrkCCDz8AG4H8yA/wCmfZDnl9+2/Q/qiSCDm72wR99tQq92Vhb9F3HfHVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=DBlRL4lg; arc=none smtp.client-ip=101.45.255.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="DBlRL4lg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1779355654;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=TdQD3dL9aPkcA57ZfHSNhc602yaNoCAEDzOYq2YRLOI=;
 b=DBlRL4lgCE7pdOW5fs+Hsl6Nzna/PF+1punKUrDc+HM1GC/tY4HEDc0G2WSI8Z1jzeiU3v
 VdwoH3ZTB+mlQGSanYIKBggrTZ9/aNtCMBqpVo+XcbKlW+jOzqh+runm37oGAvJEbFPf1a
 9zRgPtOl0iDBli+J7AUJWjkTq96mJnP7VSxpPGLLNKpHXVdZpEA7Xk5UMd8tcmPjv4G2vx
 2r7IklxTJ6ql80DkXFwmMmGWmHsPsJCyD2kZbID5zf0usR0ReBENBwztoH1PvXJmbPhU/s
 z32TsZSEIVVPRdmc6TDOONo0zMlg3mRUtBAW+3lKL7suTRHvbZYIGnSHSG2AnA==
From: "Yu Kuai" <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [PATCH] block, bfq: skip dispatch when selected queue has no next_rq
Message-Id: <f0c0ed75-0858-4464-b22f-d64a6e3048cd@fygo.io>
Received: from [192.168.1.104] ([39.182.0.188]) by smtp.feishu.cn with ESMTPS; Thu, 21 May 2026 17:27:30 +0800
In-Reply-To: <20260520095024.685338-1-dayou5941@163.com>
To: <dayou5941@163.com>, <linux-block@vger.kernel.org>
Cc: <axboe@kernel.dk>, <liyouhong@kylinos.cn>, <yukuai@fygo.io>
Date: Thu, 21 May 2026 17:27:28 +0800
X-Lms-Return-Path: <lba+26a0ed004+d6d62b+vger.kernel.org+yukuai@fnnas.com>
Reply-To: yukuai@fygo.io
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fygo.io>
References: <20260520095024.685338-1-dayou5941@163.com>

Hi,

=E5=9C=A8 2026/5/20 17:50, dayou5941@163.com =E5=86=99=E9=81=93:
> From: liyouhong <liyouhong@kylinos.cn>
>
> bfq_dispatch_rq_from_bfqq() dispatches bfqq->next_rq directly. Add a
> guard in __bfq_dispatch_request() so that dispatch is skipped if the
> selected queue unexpectedly has no next request.
>
> This keeps behavior unchanged in normal paths while avoiding entering
> the dispatch helper with a missing next_rq.

Can you explan in which case bfqq can be returned from bfq_select_queue
with next_rq set to NULL? I didn't find it with a quick review.

Take a look at bfq_dispatch_rq_from_bfqq(), bfqq->next_rq will be dereferen=
ced
unconditionally, which should lead to kernel crash before this patch if
next_rq can be NULL.

>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
>
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 141c602d5e85..c3d9d02064b7 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5226,7 +5226,7 @@ static struct request *__bfq_dispatch_request(struc=
t blk_mq_hw_ctx *hctx)
>   		goto exit;
>  =20
>   	bfqq =3D bfq_select_queue(bfqd);
> -	if (!bfqq)
> +	if (!bfqq || !bfqq->next_rq)
>   		goto exit;
>  =20
>   	rq =3D bfq_dispatch_rq_from_bfqq(bfqd, bfqq);

--=20
Thansk,
Kuai
