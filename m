Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D6D384CE1
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643581; cv=pass; b=qbQItIHNt/ardO0a1RTb3BsVbOqczmeAqGyrexpvdUKL9BoQ5iisEnuLy7xEDqWQ8ylPRG1piWUl6QQDZaBQN/M0/6NCXv95X17TZu3vFX6DUiUYuZEKTpkS/kA4QqJUvy3ffV9sIVRkVLdZkYTE5Bn+EdsM7ArviEAhQVtNztg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643581; c=relaxed/simple;
	bh=fefYiigP66hOxT3e2HqsrvW3PypwMJOrVqLdJW1W4zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQZwWwFgcTVhvBWYlw+ewRZXKyCza6CiLNQ5jAZAD4hlHECTr8luB98mR90EKqikzaBqt7KmYp0uoLkcl5r4lqFMtmB1mKFpYtoamiHxFW7su59J7SDl9FS8/eJYHorh5Md49EKTINtoSHWP5BP25niMe3JgJCuD+lOCHyGKSZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EqTJ4qnt; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EqTJ4qnt"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso7304905e87.1
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 07:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784643578; cv=none;
        d=google.com; s=arc-20260327;
        b=KT1c4HgmDIahCXuxRlS88A4wnKEMt5zU6eoCNjTLNbWpwYeqiHySEylEGyniFcV+vq
         EJc7nlEZRwVFgM32Ev7RAcsqwqcKBVRy4waCC+eZQDQw94VdM8K+TaTppI15xE1w27Sg
         2k5IzTQYCG3zVz+IsWUXo/QB3mbsZNMlP44uav8BWAdSbPFBUc7UXNOnp8atWdn7uvT/
         ttDcmxeZ5xo8B0yJarmahVkrEV+9VI5SvTRyOQG2/xWAZIqcnww8sHVU82XvQjLegVQb
         yO6jT1vo4xHvgXKLh+ALp+nUxcL0WpxL16EbT8dbjqAq7khrrH0GJjJxkHo7PBq5vaJJ
         kNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5hsRBYJ6NeVLz5bhRTH0PFL/4wzqsvQ0xpezK+EO66c=;
        fh=po3igxYtSaTvk5DHTzsXmQNV/46SohM+k5Pzm0eCOSI=;
        b=ZnT/skAFdedurE0JfuwAyj76jFJgRkaNunDDalrFZPzoXluPHnjKkshqIreGy3v5ZP
         odKPGFQVX/nfSG/4QXgXJOaAXtHYk0JRAI6atIYYjeUpC3dOo51bP6jdZBxxLxuAM6fO
         PJxVyVAEM5F77A2NKQJp774i/0ODwSPQUjTONll+I9WgHI3VeA9Pi+0nDG6GDg6RZ0/q
         4uRxov4ejyxCta75nlb/fwDbavd/ojC9OVPkkU/toA46ubhGR+nQ2BTUM4XuF7q/qTEP
         rLt/ig8dYgCE5PtflIlfvnE1ZRO2YOMZc46jiHW6pL2LN8jBiQsBMuL85B46KDPaUCBd
         mN/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784643578; x=1785248378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5hsRBYJ6NeVLz5bhRTH0PFL/4wzqsvQ0xpezK+EO66c=;
        b=EqTJ4qnt3URyqbG75bKQG/5xcWtM9p9I90YO4ySlMw3tseiALjVxY2ZiSfaRmIu4Q4
         d7DBlNsedMIW0irsjV2MqDMY+I4vgDyXNL10XKx6dpuQbe4OHrSVgbga/0tx1W+DpzJy
         iuvtR26IHc+RQKQ/w0SdJcAwhvjPVAV/g0SRju+i9EWoOmFhGUmhTkvxMZ+nOsKrNzjV
         Ouk0U5+e5XVcZme/Ltei/M9VFKGNGBHOQh3fq6UuqMk+S+DdNpeMgEhtj0OMzp85H5iO
         NaOlQuxJgaxF4camR7xBtzQ1qtTggvcUVexaXxjDNbZDRmAQTFJeIZjyLRPnMo1G/xvg
         esiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784643578; x=1785248378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5hsRBYJ6NeVLz5bhRTH0PFL/4wzqsvQ0xpezK+EO66c=;
        b=Xm3Alyeay2jJMiIw6j4P8EHTBl9gsmzlYyw9dZk74jQc4laxFR6RO7D9QMn0KQpEzL
         b0r50TaOSCu9lyyAwrMTfyA4675uaHI/QKUNkihR0ZZmQk4Li1PDiUmDKFdIGZot4I4C
         tDGl530qe+yswqNJHjpdjCytY9/QgXnYPnyaeio6mMqjlNr/YK2aRg4rajx8iCcDSGuh
         MwXxQMzoi/3BDTlsYvEAqevGspM3FQ7XCAs2QHLH+zXElLpfMgOhuqKlimoNaEJby00Z
         iisL0/Y5D4hPXAxeEEnU1VcdxsJtXKVEu7A7/2dCe0Bq/25nDYI7jybaFb9ynp1ty6uL
         4qLg==
X-Forwarded-Encrypted: i=1; AHgh+Rqby6RLarItbAke/SgcMf4njk+pq74MilMzBO3bPQcniPTLuV1OyH3yUsGaW0A46/pExG2LRkGRTxXGEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/RCDsJmLU94uX3zcvo667sA5ITaV0L2UplqUn4gwmL51+XCS
	4A3cLl+hiUl9RHlkLjjRR1DP+aTCeaIpeI9J0782sqGiR6le9lyKpwJ2RUfCTacwBcFU6gui6C5
	0twG12mj4tdNlUxh4EMPFYwhDHliTyYkqRvVSqBccTw==
X-Gm-Gg: AR+sD13KxMh1hqqbLuR4KLeweuhobc8qeYleudtJ1iaj4cU9oiwm8zmqSik5mTu58Wr
	rGEhcOFfkRzCUH1xUXHT0wSc0+XN5tkrj/UZaQPCpQgnKADHWh69akD9JTeJ+tkEgYRaSG4Efb5
	WYU7ApV0s7b3By1EQUs5tTefeoYldLzV+d7w2DnnBrGHHqD1shAN1wia+haIkOHcHifbwJKMv4a
	+pZ6llUalpitfdF7cttb1Ff0L2zU0Hwq1pluYUH+wuVquDOoFXiH7HwMG0EEotNgLN17NfOMVPC
	Rj1oslpDufeJBYTB1tM=
X-Received: by 2002:a05:6512:12cc:b0:5b2:a21a:10fc with SMTP id
 2adb3069b0e04-5b2a21a1358mr1690621e87.63.1784643578023; Tue, 21 Jul 2026
 07:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521232956.553287-1-atomlin@atomlin.com> <20260521232956.553287-7-atomlin@atomlin.com>
In-Reply-To: <20260521232956.553287-7-atomlin@atomlin.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 21 Jul 2026 16:19:26 +0200
X-Gm-Features: AUfX_my6LhVqDArLqDi_kNG90-hCGS8NtlfpTwmaoMYxk7cfngrk94P0fzOImBc
Message-ID: <CAAofZF6z-m9oikO6CEd_VUeBmgEq08E5RW0ED9C9m+xanOsdSg@mail.gmail.com>
Subject: Re: [PATCH v15 6/8] blk-mq: prevent offlining hk CPUs with associated
 online isolated CPUs
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com, aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, 
	sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, 
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com, hare@suse.de, 
	kch@nvidia.com, ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co, 
	sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com, 
	nick.lange@gmail.com, rishil1999@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 22, 2026 at 1:30=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
> [...]
>  static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
>                 unsigned int this_cpu)
>  {
> @@ -3771,6 +3821,11 @@ static int blk_mq_hctx_notify_offline(unsigned int=
 cpu, struct hlist_node *node)
>                         struct blk_mq_hw_ctx, cpuhp_online);
>         int ret =3D 0;
>
> +       if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
> +               if (!blk_mq_hctx_can_offline_hk_cpu(hctx, cpu))
> +                       return -EINVAL;
> +       }
> +
>         if (!hctx->nr_ctx || blk_mq_hctx_has_online_cpu(hctx, cpu))
>                 return 0;

I noticed the existing `if` returns 0, while the added code returns
-EINVAL. I'm wondering if this will prevent the system from suspending
because of the -EINVAL error.
Should ` !cpuhp_tasks_frozen` be added to the if statement?

eg.

if (housekeeping_enabled(HK_TYPE_IO_QUEUE) && !cpuhp_tasks_frozen) {
    if (!blk_mq_hctx_can_offline_hk_cpu(hctx, cpu))
        return -EINVAL;
}

Or maybe just handling this inside blk_mq_hctx_can_offline_hk_cpu()
returning true.

Does it make sense?

Thanks!

--=20

Marco Crivellari

SUSE Labs
