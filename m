Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9725389E17
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380032; cv=pass; b=NrsvDiLmdyUmFE2BTMqXTsUkFwaLtyq/eo7K7vZo0z/NdH8sdvZX97DFy4+LxdeecYfy5dZZL1wp4SvUMT80N4a1IexFjj1aJ5EhfV7dzwOVrKL+BucNY27/Nn6Fy+T9b5dYjBPHh/OTGuY1CEegOHsysGHpjTvk4qTUTERSVU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380032; c=relaxed/simple;
	bh=Q13rmc3Exq5RHoAPBndal8a5RvNBa06RBs7ArxiHsDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulAFSP6EMO9Gj7O5sjlQOZjS2NR202KJ7GW0YvkPJQ8LFPFwVqiNbz+JiG+kwhQTIx7x78Jf8GrnMFsBBHl/PBOwbt9b6sp/mVAuq4rifccX7JmBxH6g5MxNP8E87nh2+06v0eGD8A3NDwsk1eEiN+vzZugrQ4ITKKFxsl7VR/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DPnYUyY9; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DPnYUyY9"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59b717b0f80so533229e87.1
        for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 00:40:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768380025; cv=none;
        d=google.com; s=arc-20240605;
        b=aKPAclvQyaK8jEzI/+q6Zt3/tPgp/W9oGBAw6VD9hTV9oIYG2d9YPmqcTzle4w6m/J
         jfcbY5EWo3rfHjXTgg7LJL4B0Xea4MmLtBN/+q8kYC1HIZ0BitaOu70TicPHOKwju/me
         kzEJs51n/bgD8pAabMiuaRTlNeEcC6m9ASgRjqOcjR/Wx6QZgKYvYtf6qXa1GoVMHWhL
         VOgHmnQu2fzr9C++FvjGJ9Bo4/2jkV5MoeA1e7ioT6/BvOm++hAnc1L+ZZEQFwstr6H+
         o/LF23AdlrsgTds/G1yL4QPt+pOhKPSmPjB3IYdz7Ixss3Hx6ntz2V4Y9/JEHkNSMqJO
         a9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BXBfRD3BpdY1T0Mj9igZTFUY/CqNGXy7eOSQ9Da+Vuw=;
        fh=J6uKtQlgFLDLExj8m3JCjfakPAMwsK/KMvH72z2OiRM=;
        b=cAS8YKyUKtDJBzfGhavH4IfNUP20awW9cFav25XQn6811WQ6JbWGkQT4OGxiEXSwFd
         ON+hJlfyqkkbcoWsd6UAmrZWwpoei0sHT1HWLuPn0WS9P4wnZwK4LIa3WGPinqWk81mp
         4awrC12rXE+jeuyT397RVuAS5jAWTBV5OTWGPxYge1WKOsaDPBlViBQZJs1Z/PZxaCrc
         j89+YQL9FdC11T1Jmwd7aQ/LqzBMuCPL0xbPTDos85tojJinqS3dtvBff/ARB+DezqsK
         9FUHT6HiM8RxFrsuBL1iftPamE/RosdRE7UNgV96IXv1r+VAWytkV1vb2uEYPW0I2SfH
         JJPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1768380025; x=1768984825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXBfRD3BpdY1T0Mj9igZTFUY/CqNGXy7eOSQ9Da+Vuw=;
        b=DPnYUyY9z+Jvjwxwp65HhzFUDGE2p3+uN+dVGqKHoYc+I50aKMAkDUoAx2W5NiAO8m
         qX5050a1sKu2J5mdKtx/YuLcMCVO0RHS0fcxhAFV4v12Tvd7RKlv3nMUbuRlxNnnVXwH
         b9G5EMHgVVjTC2akr6yErQ0kYYFpNvKB+TeLF/J7GXtRw+MqXbzrQ10kzcAxsP/y8CdQ
         rc9D1GuFiP9rBM3CHxEQufdxk7WCFrAGDJhB3pnzGAtkIBsrp/1EHaOos8UhHlERCcJW
         6g6Le4aSlLeHKsXpNsUQZXPXhtw9CtaV0kLiX+twe0vUhgTr+xfIJ1MNso12ue9jpj3a
         K/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380025; x=1768984825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BXBfRD3BpdY1T0Mj9igZTFUY/CqNGXy7eOSQ9Da+Vuw=;
        b=QH6dsM/PO3gUaK+pHuUfkI3os8aMvENqqcXtbOaByuOVRlpyaoOLN1d9CJ724FnZ6A
         8pOJNGxAhE9Vud7QnFdM89auBqrmIVjfuQ1fHJDSltpxee5uFGjaZR4HZlixCHgRbr6r
         MHaY63nBLjcS1YoWHxgG6JyPpWU8lazvLp5Y2pjZwA2+OWKA2h7zU3KxOZkWfa+zMvm6
         Rno4PIv8xcGpsK5jW16UymKd9ioGTpNmJcWjxhFHiSvEVirU5L50Xv0TD1Vg1Emx7o9+
         /ETD5f6rvvSS20Icm2p7u5RYTUY13aa2AknbBGX9hIzzInoZqxJQ0tC5vUOFLMZ+oz53
         Mm3A==
X-Forwarded-Encrypted: i=1; AJvYcCXi6q4/c/wSKf+JKYvI/kFZDjWbkLLjSMwmU/POEBsXPBK6yfHs9nwjNu8Zqr5vAuY1M5fWx6uBgLrMDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAB6tzZlOnMReDXZ3rq/LWM9+FB/8RHtvwmCOR68x5TKWjPNiB
	g2hL7AtExPaReFOf8VEuUCtxj/bpuzIum2K59RtdIos667kc4JrmxPV2MyDwKzLzsVnTDTwan23
	gZSKj6RW/zDJ4xnlIuqfUIgSqI8YGdXUREqESPO9SRg==
X-Gm-Gg: AY/fxX5CAl8nlZpRQfii97qjG9ZWzvqM5tj0YwOJGSngcqpqKzSLuT6xZ+nGNt+yuRZ
	HLcW8e2aSQ1abE7srPSExQPk60WXdDpoMA4kGgbSke5LmTDp6kTlzAXYVkWY57sVP7OHRLnnCro
	Hxg2LKPlHYPM1pTkJb3uED2DP5KvL5f3iq8kH0HmmWMLQsTmzIA4dYiaeP5Etr1Men6xQEjFr5e
	34voomgfkbA7WGPpaj2T3VfVE91VOdsDzbzAzv3b5dxm7jIbF8y8IAkFhlja6wnvQXcTc4=
X-Received: by 2002:a05:6512:2352:b0:59a:10c1:8f27 with SMTP id
 2adb3069b0e04-59ba0f88c53mr327852e87.6.1768380024654; Wed, 14 Jan 2026
 00:40:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 14 Jan 2026 09:40:13 +0100
X-Gm-Features: AZwV_QgzOQlLI4XIlRejRLJFFfNv8FpAQpDBTwyCZ78qbYMq6St1A13f9wgGwRg
Message-ID: <CAMGffEmPCB4j-SfufLAdnBo=x-5HsM-vkzhu7o1ocHwnc0=jVg@mail.gmail.com>
Subject: Re: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: haris.iqbal@ionos.com, yanjun.zhu@linux.dev, grzegorz.prajsner@ionos.com, 
	axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 12:19=E2=80=AFAM Chaitanya Kulkarni
<ckulkarnilinux@gmail.com> wrote:
>
> During device unmapping (triggered by module unload or explicit unmap),
> a refcount underflow occurs causing a use-after-free warning:
>
>   [14747.574913] ------------[ cut here ]------------
>   [14747.574916] refcount_t: underflow; use-after-free.
>   [14747.574917] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x5=
5/0x90, CPU#9: kworker/9:1/378
>   [14747.574924] Modules linked in: rnbd_client(-) rtrs_client rnbd_serve=
r rtrs_server rtrs_core ...
>   [14747.574998] CPU: 9 UID: 0 PID: 378 Comm: kworker/9:1 Tainted: G     =
      O     N  6.19.0-rc3lblk-fnext+ #42 PREEMPT(voluntary)
>   [14747.575005] Workqueue: rnbd_clt_wq unmap_device_work [rnbd_client]
>   [14747.575010] RIP: 0010:refcount_warn_saturate+0x55/0x90
>   [14747.575037]  Call Trace:
>   [14747.575038]   <TASK>
>   [14747.575038]   rnbd_clt_unmap_device+0x170/0x1d0 [rnbd_client]
>   [14747.575044]   process_one_work+0x211/0x600
>   [14747.575052]   worker_thread+0x184/0x330
>   [14747.575055]   ? __pfx_worker_thread+0x10/0x10
>   [14747.575058]   kthread+0x10d/0x250
>   [14747.575062]   ? __pfx_kthread+0x10/0x10
>   [14747.575066]   ret_from_fork+0x319/0x390
>   [14747.575069]   ? __pfx_kthread+0x10/0x10
>   [14747.575072]   ret_from_fork_asm+0x1a/0x30
>   [14747.575083]   </TASK>
>   [14747.575096] ---[ end trace 0000000000000000 ]---
>
> Befor this patch :-
>
> The bug is a double kobject_put() on dev->kobj during device cleanup.
>
> Kobject Lifecycle:
>   kobject_init_and_add()  sets kobj.kref =3D 1  (initialization)
>   kobject_put()           sets kobj.kref =3D 0  (should be called once)
>
> * Before this patch:
>
> rnbd_clt_unmap_device()
>   rnbd_destroy_sysfs()
>     kobject_del(&dev->kobj)                   [remove from sysfs]
>     kobject_put(&dev->kobj)                   PUT #1 (WRONG!)
>       kref: 1 to 0
>       rnbd_dev_release()
>         kfree(dev)                            [DEVICE FREED!]
>
>   rnbd_destroy_gen_disk()                     [use-after-free!]
>
>   rnbd_clt_put_dev()
>     refcount_dec_and_test(&dev->refcount)
>     kobject_put(&dev->kobj)                   PUT #2 (UNDERFLOW!)
>       kref: 0 to -1                           [WARNING!]
>
> The first kobject_put() in rnbd_destroy_sysfs() prematurely frees the
> device via rnbd_dev_release(), then the second kobject_put() in
> rnbd_clt_put_dev() causes refcount underflow.
>
> * After this patch :-
>
> Remove kobject_put() from rnbd_destroy_sysfs(). This function should
> only remove sysfs visibility (kobject_del), not manage object lifetime.
>
> Call Graph (FIXED):
>
> rnbd_clt_unmap_device()
>   rnbd_destroy_sysfs()
>     kobject_del(&dev->kobj)                   [remove from sysfs only]
>                                               [kref unchanged: 1]
>
>   rnbd_destroy_gen_disk()                     [device still valid]
>
>   rnbd_clt_put_dev()
>     refcount_dec_and_test(&dev->refcount)
>     kobject_put(&dev->kobj)                   ONLY PUT (CORRECT!)
>       kref: 1 to 0                            [BALANCED]
>       rnbd_dev_release()
>         kfree(dev)                            [CLEAN DESTRUCTION]
>
> This follows the kernel pattern where sysfs removal (kobject_del) is
> separate from object destruction (kobject_put).
>
> Fixes: 581cf833cac4 ("block: rnbd: add .release to rnbd_dev_ktype")
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
lgtm, thx for the fix.
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index b781e8b99569..619b10f05a80 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1676,7 +1676,6 @@ static void rnbd_destroy_sysfs(struct rnbd_clt_dev =
*dev,
>                         /* To avoid deadlock firstly remove itself */
>                         sysfs_remove_file_self(&dev->kobj, sysfs_self);
>                 kobject_del(&dev->kobj);
> -               kobject_put(&dev->kobj);
>         }
>  }
>
> --
> 2.40.0
>
