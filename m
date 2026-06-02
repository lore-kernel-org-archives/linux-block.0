Received: from va-2-27.ptr.blmpb.com (va-2-27.ptr.blmpb.com [209.127.231.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A671363C64
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416700; cv=none; b=LaUBvZg0JVXnr6TDZbyt273X2Kn7ojGX9g92URbXIEhdep6apraY6vKbIpiOwBj8OgPelNDM6H0CDssxRH4WGFMjAna/RfxdB6Cn8fXkPYDzGdHJJBAQXcaC3fQiYCz/AVPZNTK1tKkZ1NUd2buhRaCQoTZVQDqRS5uY2HmXetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416700; c=relaxed/simple;
	bh=c80t0o1kJPRZntupc1jdNE5dOc0Z2d1/1BsmgXPE3UQ=;
	h=Cc:From:To:Date:Subject:In-Reply-To:Message-Id:Mime-Version:
	 References:Content-Type; b=ULQif+fQslsBsCjmHpbhiUrdaRKochSxTB9U3gv+PIr8M5Pb/ydFdzdbrXKBGD3EJGBwXVKnDneGgRBpvlMamKOj64/w6g1P8307hrWYTRQCjQJzcjUAKbtqiDE7TZWdBhq8Wusn6IHBGRomhTqTP7ok9Gu1D/34CF0FHGdyIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=2QhchYjC; arc=none smtp.client-ip=209.127.231.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="2QhchYjC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1780416687;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=SKuq2GHBEHsxUocc/bAEeJkvYk7oXUWhFB6G1HPL1gw=;
 b=2QhchYjCBhGwEpY6TV529Q0/nrJXaxHjC45DUo28H69o5v0ZltTfUnnccfi2OKWfDoV9Nk
 Xo5+fLtaAqeqBWdwD/g/v/JaEt3V823G//LokJilDWuFMYUwWaaZ2gOViaOOG2PKYl1Dg3
 MdY6hVrFuNp9sRg665qD/S+DwsP/Zw32hMWS4HP9aZsF6+AOr6Nj0azgmiqamLOadeUlN4
 xMUw6btjxsQePuWhSqTMqh3fxSbYwh2sKw1Ou3sRx90fcRtpDLs/QK+luOPStxPNNcAP6a
 gWK/zqqtokVR42RgaDFUy1RlFawCF1JgsAc1flBUaP0tW0fIqfvRQhLKHLVQVQ==
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Yu Kuai" <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+26a1f00ad+516cf9+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
To: "Jens Axboe" <axboe@kernel.dk>, 
	"Bart Van Assche" <bart.vanassche@gmail.com>, <tj@kernel.org>, 
	<josef@toxicpanda.com>
Date: Wed, 3 Jun 2026 00:11:23 +0800
Received: from [192.168.1.104] ([39.182.0.134]) by smtp.feishu.cn with ESMTPS; Wed, 03 Jun 2026 00:11:24 +0800
Subject: Re: [PATCH] blk-iocost: use irq-safe locking in cgroup handlers
Content-Language: en-US
X-Original-From: Yu Kuai <yukuai@fnnas.com>
In-Reply-To: <2f20263e-c589-491d-9be8-c2e3d56a9229@fygo.io>
Reply-To: yukuai@fygo.io
Message-Id: <087488d3-cd88-4cbf-b38c-52efb2b75c1b@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061312.896801-1-yukuai@fygo.io> <8709b8e7-8328-47e8-950f-e5726bd70dbc@gmail.com> <ac87c25f-6708-4307-ad03-645f984dfb1c@kernel.dk> <2f20263e-c589-491d-9be8-c2e3d56a9229@fygo.io>
Content-Type: text/plain; charset=UTF-8

Hi,

=E5=9C=A8 2026/6/2 23:56, Yu Kuai =E5=86=99=E9=81=93:
> Hi,
>
> =E5=9C=A8 2026/6/2 21:25, Jens Axboe =E5=86=99=E9=81=93:
>> On 6/1/26 3:50 PM, Bart Van Assche wrote:
>>> On 5/31/26 11:13 PM, Yu Kuai wrote:
>>>> @@ -3378,14 +3378,14 @@ static u64 ioc_cost_model_prfill(struct seq_fi=
le *sf,
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dname)
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>   =C2=A0 -=C2=A0=C2=A0=C2=A0 spin_lock(&ioc->lock);
>>>> +=C2=A0=C2=A0=C2=A0 spin_lock_irq(&ioc->lock);
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(sf, "%s ctrl=3D%s model=3D=
linear "
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "rbps=3D%llu rseqiops=3D%llu rrandiops=3D%llu "
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "wbps=3D%llu wseqiops=3D%llu wrandiops=3D%llu\n",
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dname, ioc->user_cost_model ? "user" : "auto",
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
>>>> -=C2=A0=C2=A0=C2=A0 spin_unlock(&ioc->lock);
>>>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&ioc->lock);
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>   =C2=A0 }
>>> This change is wrong. ioc_cost_model_prfill() only has one caller,
>>> namely blkcg_print_blkgs(). blkcg_print_blkgs() calls the above functio=
n
>>> with interrupts disabled. The spin_unlock_irq(&ioc->lock) at the end of
>>> the above function enables interrupts while q->queue_lock is held. If a=
n
>>> interrupt happens on the same CPU core before q->queue_lock is unlocked=
,
>>> and that interrupt tries to lock q->queue_lock, a deadlock will occur.
>> Agree, it's broken. Which makes me suspect of the traces shown. Yu,
>> can you please shed some light on this?
> Looks like my reply is in your spam again :(
>
> The trace is from ioc_weight_write(), which do have the problem. And
> while reviewing related code, I'm wrong to think ioc_cost_model_prfill()
> have the same problem and changed it as well.
>
>> I've dropped it, thanks Bart.
> I'll send a v2, and only fix ioc_weight_write().

I just update the latest branch and try this patch, however I didn't repord=
uce
the problem. And turns out, blkg_conf_prep() already disable irq by
spin_lock_irq(&q->queue_lock). So there is no problem at all.

The trace I found is because there are some pending patches to convert
protecting blkcg from queue_lock to blkcg_mutex, and the
spin_lock_irq(&q->queue_lock) is removed.

Sorry for the noise, I should have checked if this problem was introduced
by myself first. And thanks Bart to catch it.

>
--=20
Thansk,
Kuai
