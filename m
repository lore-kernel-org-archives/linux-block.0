Received: from va-2-38.ptr.blmpb.com (va-2-38.ptr.blmpb.com [209.127.231.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2138911F
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372841; cv=none; b=iWkg5U0sYv2B//0iZvLWRI3RFjZWfYGSkCAQ3fid8MXBpp9f2pMYtazs9XBEnHJQ1Z5ZvNWPs50kkDaetN3VGFLyek09flML+2VQIWNNz/P7efDFUqN983TAsbW7jPRnsIisw/UzBlsgdD8SLOygAiTnk8+9wxr2ob/7Ii3J7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372841; c=relaxed/simple;
	bh=SIG3S39IrTTtIod87Ka6s3XFr3Q9GCblkqDAkNbpSgI=;
	h=From:Date:Content-Type:To:References:Cc:Message-Id:In-Reply-To:
	 Subject:Mime-Version; b=buVRm/4jihuiQnSUN5QZ7RaYdfJqVOIUEppyg2CyQNhmPu6rTDBynxOd9o0+uSIDlFFxBsg2/er+1sZHUF5x3yn+VgMd0xDxXVxZgl8AgItTFu4C8GC5cvxumgP2vpXc5wA7q+4jS1XbJw8XkJhMnh7qaR31gOxwqXE9Vom8M5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=eatWS/NK; arc=none smtp.client-ip=209.127.231.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="eatWS/NK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1780372828;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=SIG3S39IrTTtIod87Ka6s3XFr3Q9GCblkqDAkNbpSgI=;
 b=eatWS/NKeZI+hiCrILGw/lBm2d6dKkM2ICMzYGv/v4d/wH99Eo6AnsLNV9l+Gz9D3Ilwqo
 +0whrE6C2cxyYl/T1NkN8ka3BMxfU0O8SaxWLqfHgUH36HN/fqvZIkdyfFhjSDtNOj5J/d
 mWicTONagUiiMU1fC67eeB6vNeQ5gs0u6b9Lu7LZuYtZfJCqcHZHQtA2VMDYQWc5NiBJfO
 NbbOnJeB2jDHDfpb39kXX0zsLcgstlmMsUPppbNYriPF9yKUhUGDYH3Wndb3oxG2dUjSZ0
 rpDN4qTBGLJqgwx8BdNbf6DvZxwFhvYKoKXNwhSONloO70wPhAKF75t3P88YQA==
User-Agent: Mozilla Thunderbird
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Tue, 2 Jun 2026 12:00:23 +0800
Content-Type: text/plain; charset=UTF-8
To: "Bart Van Assche" <bart.vanassche@gmail.com>, <tj@kernel.org>, 
	<josef@toxicpanda.com>
Content-Language: en-US
References: <20260601061312.896801-1-yukuai@fygo.io> <8709b8e7-8328-47e8-950f-e5726bd70dbc@gmail.com>
X-Original-From: Yu Kuai <yukuai@fygo.io>
X-Lms-Return-Path: <lba+26a1e555a+1ad458+vger.kernel.org+yukuai@fnnas.com>
Cc: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <yukuai@fygo.io>
Message-Id: <a9710059-8f38-4594-81a8-45eb7210a12c@fygo.io>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8709b8e7-8328-47e8-950f-e5726bd70dbc@gmail.com>
Received: from [192.168.1.104] ([39.182.0.134]) by smtp.feishu.cn with ESMTPS; Tue, 02 Jun 2026 12:00:25 +0800
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH] blk-iocost: use irq-safe locking in cgroup handlers
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Hi,

=E5=9C=A8 2026/6/2 5:50, Bart Van Assche =E5=86=99=E9=81=93:
> On 5/31/26 11:13 PM, Yu Kuai wrote:
>> @@ -3378,14 +3378,14 @@ static u64 ioc_cost_model_prfill(struct=20
>> seq_file *sf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dname)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 spin_lock(&ioc->lock);
>> +=C2=A0=C2=A0=C2=A0 spin_lock_irq(&ioc->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(sf, "%s ctrl=3D%s model=3Dline=
ar "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "rbps=3D%llu rseqiops=3D%llu rrandiops=3D%llu "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "wbps=3D%llu wseqiops=3D%llu wrandiops=3D%llu\n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 dname, ioc->user_cost_model ? "user" : "auto",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS],=20
>> u[I_LCOEF_WRANDIOPS]);
>> -=C2=A0=C2=A0=C2=A0 spin_unlock(&ioc->lock);
>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&ioc->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>
> This change is wrong. ioc_cost_model_prfill() only has one caller,
> namely blkcg_print_blkgs(). blkcg_print_blkgs() calls the above function
> with interrupts disabled. The spin_unlock_irq(&ioc->lock) at the end of
> the above function enables interrupts while q->queue_lock is held. If an
> interrupt happens on the same CPU core before q->queue_lock is unlocked,
> and that interrupt tries to lock q->queue_lock, a deadlock will occur.

Yes, this is correct. Sorry I just notice this is a sysfs api like other
places and didn't notice the problem. So ioc_weight_write() is the only
place that need the fix.

Jens, please let me not if you want me to send a v2 or a fix.

>
> Bart.

--=20
Thansk,
Kuai
