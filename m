Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3D19E82A
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 03:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766027904; cv=none; b=sHrxYOQKV3AvMp5QP1mvJLKrJ8sQ/U2NGvJHFmEPOChi41sidBYS5uw9jngsQE7tX5fgNoWe6yiv1O/uVCX4HY50BQgmPjOTdH5wzV39ickGG0Yd9cg/UNc6c35BVPXb4RsY06ryvcuIGDYrhNkovDUjkR5v8X9u2p+LHMimsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766027904; c=relaxed/simple;
	bh=GMqJG/Hj2OcwRhNGQWos5NnxAJs8HXMcng5Rs+sAAPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olcHa4EVw6X6E6S5ba8HQgM9bvUvQF8xozsaaCCd/hkwvhcADLCgHIcZK29cDPgSz3DrE9mo9Um0KyG2Vg5+0ZSoz7pvvd+yXjbXvbdRdLK1fWtgdGMLT8d8rFF9dl/+gB0q9G5hgVGDCM9kUfrfqx3qfsVaSazSSSwMOp62OYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjAAushd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8HwLnjJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjAAushd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8HwLnjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766027900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yeu5Fr/6tMv/xX9ZelFzXxgOzglbv0wgkFhHHNSk0/E=;
	b=WjAAushdJtkkNbTHT/JH2CH5rAlJTCWX/GfhTHs9ANLfC/mseWYVxzulsAQo3YdILEfjRO
	51+HzsL5lgVTeGr5eJ21NDWIIL1WDzHr5DvrzTmz1x4uLqRMPGwm3uQQjqG4ujDORF1Ibw
	XOgBwi6ubXEMYm4VYlAgRj74mRsJEGI=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-P8WV_GfMPUi6TxxBFfB3Ww-1; Wed, 17 Dec 2025 22:18:18 -0500
X-MC-Unique: P8WV_GfMPUi6TxxBFfB3Ww-1
X-Mimecast-MFC-AGG-ID: P8WV_GfMPUi6TxxBFfB3Ww_1766027898
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-93f5bfb23fbso472492241.0
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 19:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766027898; x=1766632698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yeu5Fr/6tMv/xX9ZelFzXxgOzglbv0wgkFhHHNSk0/E=;
        b=D8HwLnjJ0D3q/GrYuphUxXf2Iliw+x/iGhZBPmkLaG4j2S4kTTJp8TSy2A6nKG0PtL
         ihWQUbIxUR8NnjJGNrFIqmOqEZxV9LomLh0BV97nm0a+sOe1cihne/485RzI+KYZO8pN
         /1j3SVzqXV5UxL8BOHdZTUDoSRHYnzagBdFYsyTSxWJqGgC7sfECPFRyAgOzJVaVMnOS
         4e8p4E8V7348ZBN1UOI4XOQmSzZoMNGemEwSEyIPy7DbnmJHS9Z5TNkzUxZwHMtp+jcA
         L/LxpJzj15mRuHLQ3m6PzeBtPMbT/ty5W+QuIKlM1E9o/Qi4rG45Q3OmmLYoaPWP5SbV
         lTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766027898; x=1766632698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yeu5Fr/6tMv/xX9ZelFzXxgOzglbv0wgkFhHHNSk0/E=;
        b=vHFwCME+WcpiuNAB6xx8s8VEy2AABLRKJUAYiTraWAI6pqqpqHdRp8bNVWtsEJ/vyH
         N7LkcvlZGL/FLOiFg4oMfwWR+31tl0Q8An+D1ncc8fzOmw4+IfJyB9ObRhiejQvO959n
         PPVHKozHExTMNFnN2OM+ADjfMym3opkvm2O1T/MH074XmhN2ar3i3xZTeZNNi4iuvWHZ
         Pu0oIXxdnIFrrGRU/MpO0rrszrVmy6GzZqVx+PMFVXil/vROyGCdmfkMVo/1kCYgQ1O+
         PHh1fh+FK42QMyhjOxn6xk6//ra03cyFkTl1A6hm1mwztmR9ZfKd5qYCZfHkxHq1UjCA
         iF2A==
X-Forwarded-Encrypted: i=1; AJvYcCUdj/S/mPZJH0Azmvhnb2JIEFcPU1CrqPlZkvITWaHZBrfU8Am/NppbpXwk5jRC3p1QcCkp/f6UiDPU2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8c/M9mLoW2Dh4KEi8uMAOznSQiof/OAYZej7BNl5FImA78pNz
	UkzE+pYEUeb+rnrjZIW1/AeVFWzXN/a9orAdkEWq2tU+dka2CncKXH2THj0EG1Gk0QkApeE+1ce
	tEAfqSXM044s2WQqEfCuzh6m5ERz7WzzXXrFJen0sS1e2Be+thc3sDnGvtXYHPEyaoEaWf4tU5V
	SROEuxvk/6oGOiidHv207g3zezCGVadYuIyTHJ1jcpFZpCwB4=
X-Gm-Gg: AY/fxX7yp1RHpxYiKlj/S4Isjl190habqQ5QATv44JkHzabeoQSyUqPYhe5zuBGWEsF
	sP5ymR5HFU2CD+b+gwun5WAt203u32u7GPPFSlqz9AjFTvbAHANXQtSDPJhWRb43uzK3A2a+2zT
	L8BNFLQRRHg0fq+trJ2b2IWtChLaVrFAwl8lFKUm4db3JGKTlwOzCNqebTENP1cnBlb+c=
X-Received: by 2002:a05:6102:f0c:b0:5db:2828:c133 with SMTP id ada2fe7eead31-5e82768a142mr7643148137.10.1766027897797;
        Wed, 17 Dec 2025 19:18:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYBjHjOHdwxuf9OHp2WuxdASwHH8L/53RqEzdmSQCUmZbV8hxKrg8rNOX8FFf9cyA1WYWF9FRrVuAltI2hn5E=
X-Received: by 2002:a05:6102:f0c:b0:5db:2828:c133 with SMTP id
 ada2fe7eead31-5e82768a142mr7643142137.10.1766027897443; Wed, 17 Dec 2025
 19:18:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212143500.485521-1-ming.lei@redhat.com>
In-Reply-To: <20251212143500.485521-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 18 Dec 2025 11:18:06 +0800
X-Gm-Features: AQt7F2qeFwL24lyRKTzkZEeHpQrTuhCZVn2PlhNtUTkh5X9pyWKY9Zw2P1papP8
Message-ID: <CAFj5m9KVcKzEqpXt0J_28L+bHojeAv4+cu8hTyfdfA_c-q4nWw@mail.gmail.com>
Subject: Re: [PATCH V2] block: fix race between wbt_enable_default and IO submission
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai@fnnas.com>, 
	Guangwu Zhang <guazhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 10:35=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> When wbt_enable_default() is moved out of queue freezing in elevator_chan=
ge(),
> it can cause the wbt inflight counter to become negative (-1), leading to=
 hung
> tasks in the writeback path. Tasks get stuck in wbt_wait() because the co=
unter
> is in an inconsistent state.
>
> The issue occurs because wbt_enable_default() could race with IO submissi=
on,
> allowing the counter to be decremented before proper initialization. This=
 manifests
> as:
>
>   rq_wait[0]:
>     inflight:             -1
>     has_waiters:        True
>
> rwb_enabled() checks the state, which can be updated exactly between wbt_=
wait()
> (rq_qos_throttle()) and wbt_track()(rq_qos_track()), then the inflight co=
unter
> will become negative.
>
> And results in hung task warnings like:
>   task:kworker/u24:39 state:D stack:0 pid:14767
>   Call Trace:
>     rq_qos_wait+0xb4/0x150
>     wbt_wait+0xa9/0x100
>     __rq_qos_throttle+0x24/0x40
>     blk_mq_submit_bio+0x672/0x7b0
>     ...
>
> Fix this by:
>
> 1. Splitting wbt_enable_default() into:
>    - __wbt_enable_default(): Returns true if wbt_init() should be called
>    - wbt_enable_default(): Wrapper for existing callers (no init)
>    - wbt_init_enable_default(): New function that checks and inits WBT
>
> 2. Using wbt_init_enable_default() in blk_register_queue() to ensure
>    proper initialization during queue registration
>
> 3. Move wbt_init() out of wbt_enable_default() which is only for enabling
>    disabled wbt from bfq and iocost, and wbt_init() isn't needed. Then th=
e
>    original lock warning can be avoided.
>
> 4. Removing the ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT flag and its handling
>    code since it's no longer needed
>
> This ensures WBT is properly initialized before any IO can be submitted,
> preventing the counter from going negative.
>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Cc: Yu Kuai <yukuai@fnnas.com>
> Cc: Guangwu Zhang <guazhang@redhat.com>
> Fixes: 78c271344b6f ("block: move wbt_enable_default() out of queue freez=
ing from sched ->exit()")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
>         - explain the race in commit log(Nilay, YuKuai)

Hi Jens,

Can you consider this fix for v6.19 if you are fine? Yu Kuai has one
patchset which depends
on this fix.

Thanks,
Ming

