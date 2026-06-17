Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA2E2BE656
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781668021; cv=none; b=KncYY8HOqqi9+ZrDAPfn1OarbziQr1CEZQxxDHhcqKDM+If8eFq3YFg35IHHInCbOHBwwkO/UmfjdWwGB+s03/r3VrtiaZDLgl/5La71gYcBkAXtzpRaNMBLN2IOv0owyX2GsanUroqAwpxLSljuRRNZX4I9740vqB4Etgyqihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781668021; c=relaxed/simple;
	bh=MlLmcMBEpf5VC/HPStHpAv6eNdh0B2xImW6HcxFKVZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSAfIs0OIUUDaBWgRyigsGeP79dq9RAfWmyWgAilR3N+K46+qFzTi9GsdzpQatcK46hBNfrQOkKA2LNq6ceInbbYWB9HJgWp4KPLegQ0ADeNWTyRqyKF2xXs7QCIdCCfgM03SFvBNgsBZGE2G6jhiEluOnvgTgE8bHHgcHEfGdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nGOeQ5oz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nGOeQ5oz"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so407134a91.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 20:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781668019; x=1782272819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pK4PQ1902R80gheBMlvl0pQHw4MWAl4a6tgY9EExy9w=;
        b=nGOeQ5ozKMqgwTKS+VuZ6H8mJ67TnC6ajNByl+jFoaylGo9IHJwbzAhER3HKigDG5+
         a/QQlxzfpD+cGpmzuOzJ7LUqosaQo/PXTLpuUmySKzUbEZ9ke9xBmOFs4s3x+L+ZBvkD
         S1ByYnU1K+EdlNwDufopeih7p+5Gwq4UMnuBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781668019; x=1782272819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pK4PQ1902R80gheBMlvl0pQHw4MWAl4a6tgY9EExy9w=;
        b=c5roBbJ4T+MpewUwwpFc7WjPo5jTDf0CQhAJZ1066euFrKcSBCO+F3n7epCHgk4K5F
         Xh5uutspt5gx17rk9pWjTZBJMruSB4QtbT9ITKIeol521c3PEjwM8T4UhGLkws6NfqGN
         dXY/T/9C4buCvAFxkqJkUQwkJCp/BAVWHFJu72zkhjxEmVfipNg8K51RynJT9MeHrsKq
         m+8wkASx4/RTvK13u66O5heC8tUeOVlwc2lF4MfpN88VTJtZrtOGus20M8//focRM25u
         PwSHRmNkthtu+CXVGCfo0vwIlFlxtTHmLhmlaK/e8ecADfpqtAzFeMUJFPUh9mKTxM+x
         K6iw==
X-Forwarded-Encrypted: i=1; AFNElJ/kOX6ByexvrAvnC53ASYK8FPSp2rdj70tY+IiLuG7QInnuFzEFZ+bI799hJ6lvuctXbe2DIYelGlrJ/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8GTKN3oGI5n8nB/L6bwixPwCC40yUgzEnAX26Y1Ps9p4zGrI
	D/Wi7svOGsNLAAvDluBnwiDvbBlNhX4tj7O22NsygRDwOJsNJvZmAuAzwerFswjewQ==
X-Gm-Gg: AfdE7cnRn/aP108jwLTm4RItV7seIU/ek3lw0XqQV75txM9A7rhTOwzisMhLOhPZ3GR
	7H9auV+BtsJ89M1A3JZiGI0X15QWutiq3mnKVXGLLxQ2hGctga8rlDO8VvlnyIqvNxZp5miJoWI
	fo2gu7xu17rYbonl/zu3u1DBTcJLuMXVH7W9c23KRnmCm/X+hmniI+tyK0LyJU5Tkiw3N4+0aTD
	awIMwBc5LPkA33HAvqNKa9F8EO1f34imVm3fAUcChkSG66ifttK5VfUUhcvu5FwoRDjM3sy9FhD
	OGdOzWNWVTKa+7ACIwRSmWbnvGK+XgTy3Iuv3HvLLS1PSL2QD8aGC+9dE0zNu7uGVn30OsclR/b
	TWnZKXG5VNzKgobldzSpk8YKSylh1LjEybRo7vBoVH0aNbZcmEGXNsaZtZ8wMKcpY25oJomM1Fk
	HchqlmNbSqmg/KCk7gGRlxOrtqu/jonnrX/LdVL+PylKWrymUGnIY=
X-Received: by 2002:a17:90b:350b:b0:369:9469:aeba with SMTP id 98e67ed59e1d1-37ca6843e76mr1031173a91.1.1781668019333;
        Tue, 16 Jun 2026 20:46:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a0b:fabb:5b62:b85b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521cac5bsm4446256a91.5.2026.06.16.20.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 20:46:58 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:46:53 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Youngjun Park <youngjun.park@lge.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, Brian Geffon <bgeffon@google.com>
Subject: Re: [PATCH 0/3] mm/zram: route block swap I/O through swap_ops
Message-ID: <ajIYFtADxQDq8q1P@google.com>
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
 <20260616123646.GB21024@lst.de>
 <CAJxJ_jhK+zkpjhs3YsQ9RoasKYh+E0NweQci0sPAEY1ne5LmBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJxJ_jhK+zkpjhs3YsQ9RoasKYh+E0NweQci0sPAEY1ne5LmBA@mail.gmail.com>

Cc-ing Brian

On (26/06/17 11:38), Jianyue Wu wrote:
> > I fear this is going entirely in the wrong direction.
> OK. I was trying to build on your swap_iocb / swap_ops rework
> for the zram swap path, but I take your point that compressed swap can
> be handled more nicely.
> 
> > Yes, we have to keep zram around as a legacy interface for now,
> > but the right place to deal with compressed swap is in the core.
> I agree compressed swap belongs in the core is better, so not only ram,
> but also the block layer can use it.
> 
> Before I rework or drop the RFC, could you outline how you see that
> core-side model working? In particular:
>   - How should a compressed backend like zram or future block device
>     plug into swap_iocb / swap_ops?
>   - What role do you expect zram to keep while the legacy block interface
>     remains: current block swap only, or something else?

Those are fantastic questions, thank you for asking them.
Can we elaborate on zram being a "legacy interface"?
