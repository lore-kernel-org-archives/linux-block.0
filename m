Received: from va-2-39.ptr.blmpb.com (va-2-39.ptr.blmpb.com [209.127.231.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDDB3750AB
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773594208; cv=none; b=ArTunr7UtweLDCT6VGY192PDjUTFaP5JlBBU1P9eWtKzFeiYEc41y5KbpFX9LD0jdgBNTaDBbwv/BBAqgcVE4+sm0fbdUMsG+q9AIFdEQy4fJmg0DoX+yOWgcNmfvMD9CGT/jw09IPoPINOaA3Zmvcd9QbnyrK23o1VTaK2xgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773594208; c=relaxed/simple;
	bh=FOwkdbxjuDWjUPC9aSs7RcU9T9sMuHNzEceCZipwD3o=;
	h=Content-Type:To:From:Message-Id:Mime-Version:Cc:In-Reply-To:
	 References:Subject:Date; b=T2+yu2dd0kn11LbQI4ub5ksClBMPUN/c8OLeb24vpENn80UZe2MM+SVCjj2xMWhWUmtlZKpqZnJyDGOM0d/GuxuHrrj1g7XYjZaTPsypb7xjGrlVkn/EWyxeVpdyrqIyZCH/B/gqhxWewykOpGCGBLIZzJxXWCa1WG/TxtB6/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=RuUojyWo; arc=none smtp.client-ip=209.127.231.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="RuUojyWo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1773594201;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=PfzYj9GWOQvGwd+Q/2M73dUO7pWjr9L6Sc8eoTb19UU=;
 b=RuUojyWosTCT6C43xkXT5BhjhQKegT1E/nkTnjWsBCAl1AcDAy6GXfRIhxbAwfRO2Lq3sw
 9ugFcYKozmrcmncT+ZHmAPiqsg7LClsO3Ai95eOAkyQ1O/+MDHjS+BDFrKisJ91YklFXbI
 wj2ui2ZIXJIVzmyuV1C6BaqG2+6Pw2v5HaTW9SBlA5hYTNPEKoMmid2aiJyaUPsGscz6gH
 SFZTWNRAt31hsQfNn70t29bsJ9cGMCzLrkqwnrKdrrgFFXY8wJJfdRTF0szOk1orblh9uP
 s0OZRbt10LDJuWDbd73GLhDJwEAfxNKOaFIr4V0DamFM2yc4O+c8LVHqWsw0vw==
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
To: "Yuto Ohnuki" <ytohnuki@amazon.com>, "Jens Axboe" <axboe@kernel.dk>, 
	<yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <cd42b95b-58de-4d47-9895-f1b5ac7d499e@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269b6e658+fe5da9+vger.kernel.org+yukuai@fnnas.com>
Content-Language: en-US
Cc: "Nilay Shroff" <nilay@linux.ibm.com>, "Ming Lei" <ming.lei@redhat.com>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com>
Received: from [192.168.1.104] ([39.182.0.175]) by smtp.feishu.cn with ESMTPS; Mon, 16 Mar 2026 01:03:19 +0800
In-Reply-To: <20260315143137.13547-2-ytohnuki@amazon.com>
References: <20260315143137.13547-2-ytohnuki@amazon.com>
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCH] blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()
Date: Mon, 16 Mar 2026 01:03:17 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2026/3/15 22:31, Yuto Ohnuki =E5=86=99=E9=81=93:
> wbt_init_enable_default() uses WARN_ON_ONCE to check for failures from
> wbt_alloc() and wbt_init(). However, both are expected failure paths:
>
> - wbt_alloc() can return NULL under memory pressure (-ENOMEM)
> - wbt_init() can fail with -EBUSY if wbt is already registered
>
> syzbot triggers this by injecting memory allocation failures during MTD
> partition creation via ioctl(BLKPG), causing a spurious warning.
>
> wbt_init_enable_default() is a best-effort initialization called from
> blk_register_queue() with a void return type. Failure simply means the
> disk operates without writeback throttling, which is harmless.
>
> Replace WARN_ON_ONCE with plain if-checks, consistent with how
> wbt_set_lat() in the same file already handles these failures.
>
> Reported-by: syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D71fcf20f7c1e5043d78c
> Fixes: 41afaeeda509 ("blk-wbt: fix possible deadlock to nest pcpu_alloc_m=
utex under q_usage_counter")
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---
>   block/blk-wbt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 33006edfccd4..4337cbb7380c 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -782,10 +782,10 @@ void wbt_init_enable_default(struct gendisk *disk)
>   		return;
>  =20
>   	rwb =3D wbt_alloc();
> -	if (WARN_ON_ONCE(!rwb))
> +	if (!rwb)
>   		return;
>  =20
> -	if (WARN_ON_ONCE(wbt_init(disk, rwb))) {
> +	if (wbt_init(disk, rwb)) {

Can you also add a warning message that disk failed to enable wbt?

Otherwise this patch looks good to me.

>   		wbt_free(rwb);
>   		return;
>   	}

--=20
Thansk,
Kuai
