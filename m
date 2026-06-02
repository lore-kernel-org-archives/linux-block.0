Received: from va-2-40.ptr.blmpb.com (va-2-40.ptr.blmpb.com [209.127.231.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB233E34E
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415796; cv=none; b=Y5V408ESLg5+yx1zUJrh+t2xI9Tfv2eNKPTDkKfpcXDKGwWKNIFkVqQb3y9Kzp93UTokOoyO8MbDBhRheR2NWJFgn9OVdFGHZZObIhRxbTMbaM2LR9iThQgXPKV1V4tft3Lxuff1nHqtcyA1gr0X/XtR+UgqmPCNcaOv39nQsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415796; c=relaxed/simple;
	bh=xc5RFHh85VaFWMhTbWHtBv1oZ8P0ahLqFBCs5djBKRA=;
	h=Cc:Mime-Version:References:To:In-Reply-To:Content-Type:From:
	 Subject:Date:Message-Id; b=EanfWzebmV0EmNUxzywsR+bNy+54CPkRz4T21h5ezauK6d/WWj3VATjm/zlIo77wMwNQEKmBwIm/NzQT5/jM0JgvOPq7rmyADb9eu/T4sBx9VAUnIWvP+1zHj1M12GA+SdIWaU9L/CbE1JHIEpcG4nBZzdSZppM40J7kYH02Ysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=GWp1IWrV; arc=none smtp.client-ip=209.127.231.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="GWp1IWrV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1780415784;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=r2Pp9YXJ9ZTzLm94EO/ONd8UqABk1GQg0Yxcb67VDsI=;
 b=GWp1IWrVFL7KmMP/U3WFtL+TmFwliP4/MEUx+jkANILkm6B1pAImqJXZumjT5g3k06E108
 xdX7hJ6n2+9goY4NvkX5weGTPCIfY//Nu0camphJtsHTkTEpi7NbVdTeLGWOyoh50ZH8c0
 P3F+uQBqqNiUe0ObovTrXj+8GdIgOnHOha/uxUu1HJam7aKrGBGBsni28c6WTlHfhQr8jF
 BB4dGP8LirNTdSoSTEbdrIkG2Q2U60fL/8Tmpom1FQZ2mtH/few3A2tLDXF/XxpX9M26fn
 TxYBKJskhn1Vt+Cr0f2DjM7KVA/mfTFxfuD9ePpdr+EVoa9uSyYBM/t0FnPZMQ==
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260601061312.896801-1-yukuai@fygo.io> <8709b8e7-8328-47e8-950f-e5726bd70dbc@gmail.com> <ac87c25f-6708-4307-ad03-645f984dfb1c@kernel.dk>
Reply-To: yukuai@fygo.io
To: "Jens Axboe" <axboe@kernel.dk>, 
	"Bart Van Assche" <bart.vanassche@gmail.com>, <tj@kernel.org>, 
	<josef@toxicpanda.com>
In-Reply-To: <ac87c25f-6708-4307-ad03-645f984dfb1c@kernel.dk>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.134]) by smtp.feishu.cn with ESMTPS; Tue, 02 Jun 2026 23:56:21 +0800
X-Lms-Return-Path: <lba+26a1efd26+e445aa+vger.kernel.org+yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH] blk-iocost: use irq-safe locking in cgroup handlers
Date: Tue, 2 Jun 2026 23:56:19 +0800
Message-Id: <2f20263e-c589-491d-9be8-c2e3d56a9229@fygo.io>
X-Original-From: Yu Kuai <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2026/6/2 21:25, Jens Axboe =E5=86=99=E9=81=93:
> On 6/1/26 3:50 PM, Bart Van Assche wrote:
>> On 5/31/26 11:13 PM, Yu Kuai wrote:
>>> @@ -3378,14 +3378,14 @@ static u64 ioc_cost_model_prfill(struct seq_fil=
e *sf,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dname)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 spin_lock(&ioc->lock);
>>> +=C2=A0=C2=A0=C2=A0 spin_lock_irq(&ioc->lock);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(sf, "%s ctrl=3D%s model=3Dli=
near "
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "rbps=3D%llu rseqiops=3D%llu rrandiops=3D%llu "
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "wbps=3D%llu wseqiops=3D%llu wrandiops=3D%llu\n",
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dname, ioc->user_cost_model ? "user" : "auto",
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
>>> -=C2=A0=C2=A0=C2=A0 spin_unlock(&ioc->lock);
>>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&ioc->lock);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0 }
>> This change is wrong. ioc_cost_model_prfill() only has one caller,
>> namely blkcg_print_blkgs(). blkcg_print_blkgs() calls the above function
>> with interrupts disabled. The spin_unlock_irq(&ioc->lock) at the end of
>> the above function enables interrupts while q->queue_lock is held. If an
>> interrupt happens on the same CPU core before q->queue_lock is unlocked,
>> and that interrupt tries to lock q->queue_lock, a deadlock will occur.
> Agree, it's broken. Which makes me suspect of the traces shown. Yu,
> can you please shed some light on this?

Looks like my reply is in your spam again :(

The trace is from ioc_weight_write(), which do have the problem. And
while reviewing related code, I'm wrong to think ioc_cost_model_prfill()
have the same problem and changed it as well.

>
> I've dropped it, thanks Bart.

I'll send a v2, and only fix ioc_weight_write().

>
--=20
Thansk,
Kuai
