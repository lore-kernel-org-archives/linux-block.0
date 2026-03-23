Received: from lf-2-49.ptr.blmpb.com (lf-2-49.ptr.blmpb.com [101.36.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EDD1A9B24
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243252; cv=none; b=FhQ0WHSBkZsYhrnk4tCezXik3kZDWMF8TSQtxNL6o39xzOhxnF74S7aHeuZ6ynOxe1j4AKNLbsmt0+JMt9gFB52Ls0Hz6ikE3/oZGs0f62LuGl6btvRUq2/886NAZRidNd9a/91O70R7YJh73SpJvLvrPK3d4zF82BZD3nd1jj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243252; c=relaxed/simple;
	bh=ke+5gVJihn0+oCRuYX7faBEMm16ZTZCeoEE08Uf5/20=;
	h=Subject:To:From:Message-Id:Mime-Version:Content-Type:In-Reply-To:
	 Cc:References:Date; b=aoy55IWtjzndNlC1frqe+b7HB/a6BiGKdtmj3VvVj3ydmbPQzOHQe92lcQFDPecaLkcteu6kp3Sx517bkJ/Zx20euScxPzRbbA/cycM/ArevlroxN405ubsUfvpgPZ6JVxq/scElLTP2FWz6TbSqTJxC2/rdYp0/pkSMykofMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=kXJfNMMd; arc=none smtp.client-ip=101.36.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="kXJfNMMd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1774240248;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ReDpdLnTZhjTObIFsSgT8bMFm0YiPdQZLFhX0r0LK7g=;
 b=kXJfNMMdvPisWxfDf0/1/a3FZsEm7A1J3SpQpb0uSiWJwIE+UxBqHNpI3CmQC7oJk70Yu3
 DDbBfwXEqUMqE4SwC+zior5O4mnv4/kc6bsCpQ+f/AjS19KmxRC053t5gZNMw5K7GSXAmS
 Fn17Aziku26AFbw/SvJnTZ9kwUjdcJnTyTLiqJCjbozpXDaV6RuEBzb+4wPg9Q6zOFYdd7
 T8jpxtcMcjvIJF7hqdBklxmgG8DsGfRbX9PQlNWYkv/DPeHC/luuKwbn2stVmiFwQdkdgf
 clwBjQzvNi2pYITDunq9Hdg/0yq3De+ot3zUYCtWdCphnXbBx+G2mwkluDbIuw==
X-Lms-Return-Path: <lba+269c0c1f6+f0fcb8+vger.kernel.org+yukuai@fnnas.com>
Subject: Re: [PATCH v2] blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()
To: "Yuto Ohnuki" <ytohnuki@amazon.com>, "Jens Axboe" <axboe@kernel.dk>, 
	<yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.158]) by smtp.feishu.cn with ESMTPS; Mon, 23 Mar 2026 12:30:45 +0800
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fnnas.com
Message-Id: <86a06a34-b287-4958-b6c0-c1892a110acd@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260316070358.65225-2-ytohnuki@amazon.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Cc: "Nilay Shroff" <nilay@linux.ibm.com>, "Ming Lei" <ming.lei@redhat.com>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com>
References: <20260316070358.65225-2-ytohnuki@amazon.com>
Content-Language: en-US
User-Agent: Mozilla Thunderbird
Date: Mon, 23 Mar 2026 12:30:43 +0800

=E5=9C=A8 2026/3/16 15:03, Yuto Ohnuki =E5=86=99=E9=81=93:

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
> wbt_set_lat() in the same file already handles these failures. Add a
> pr_warn() for the wbt_init() failure to retain diagnostic information
> without triggering a full stack trace.
>
> Reported-by:syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
> Closes:https://syzkaller.appspot.com/bug?extid=3D71fcf20f7c1e5043d78c
> Fixes: 41afaeeda509 ("blk-wbt: fix possible deadlock to nest pcpu_alloc_m=
utex under q_usage_counter")
> Signed-off-by: Yuto Ohnuki<ytohnuki@amazon.com>
> ---
> Changes in v2:
> - Add pr_warn() for wbt_init() failure as suggested by Yu Kuai
> - Link to v1:https://lore.kernel.org/all/20260315143137.13547-2-ytohnuki@=
amazon.com/
> ---
>   block/blk-wbt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
Reviewed-by: Yu Kuai <yukuai@fnnas.com>

--=20
Thansk,
Kuai
