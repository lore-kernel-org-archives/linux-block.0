Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8DF2D8360
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764192658; cv=none; b=TXq8lqCySQZEl6ngFmr2FqNB6VAZEHbeyVqG7NcJNF241DDutMONig39QR9ErOnFm5vI+GbeyKUwZ3u4XwQp2tDqgR/f7ynr25npQB0xhlZAYFnBzynnjGXjb/VIHSxGRV5enYTCob6s1C3Ss/kKDKPKz7cLyXakMyWkMi+53z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764192658; c=relaxed/simple;
	bh=qb5ftFJ0Nl79KySb86CBhcQIlCVISgOMjmQy0gJs15c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCzUoPR5YNGO0HZrOG5Y/aQArT0H1+QcoxXpJWh3iX2AAn3eqWugeVmm550V9rHSRSQqvXXxuH3X0uMNOUseQAdMrw398KxEWDcI8ys6WD63Zqjm//XmMm2Vk7ywQwnSa+wb+Yn3Jto3O5o81OrvnWJksFVk15GJQCL6jZKQxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpVE7afV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpVE7afV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC71C4AF09
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 21:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764192658;
	bh=qb5ftFJ0Nl79KySb86CBhcQIlCVISgOMjmQy0gJs15c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lpVE7afV3AXbUKaE0KfjUXbt7S4qNqubX2MORyeC3H7pUUsKJM/A/Y4m1WbiMdVvF
	 U/y3ZaIWdKeaR0FUxpYYT5/FTtsO160Ce17ZYtcrvWhTy6Wd6KKQ+UeHDBL68fkpGS
	 LQwUagcUB0H7MEwbZcBwdYOi0KIUgWO2jBjBASImHViEbWSotFlodwY6tNkwwPa/oW
	 PKiUJmH2UOKSm4xJgiSJJmKWlOLwZ1fGP4lGp2jJgQf/KVrjbCT0VmENG0xxtpYziJ
	 4hiM4MaOZA49VuUqlm2gX6jnygMaPe4s4bcED7ghdD1J4j/euq8JKHnAeQOtGaCY0Z
	 zgnrUyb+7x36Q==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65748e230f9so97697eaf.1
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 13:30:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOXernA6IIetVx4tuaT/LWljA9HTwIuPQWq+NgsIJ2lUjgNiESfq56GSi4guJNArBweSV7V7VTjqdKRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Jlfcy1l6chuB2aKB5uS3UkzyyTCpeQ5LZUgR4+7WCLDV+c1O
	2O8iZ/QLeSoRSwVWzA1wmFGnX7l7/YwAW6KjfQKnnp1dZhBSpZqo20DSR7cqqWdIf7OcXI8kxjU
	EqJI8Dtcib6YFW6WYoSLAyJFEhopXC5c=
X-Google-Smtp-Source: AGHT+IGgDsz9fB5qGpX8vapXdGcjDYTkNbOpTHs5VhRLo5iGQ/2HEsT2/lK5UDMfEAvnuf9yFtuVfhbyXXUEjYHFepQ=
X-Received: by 2002:a05:6808:1906:b0:43d:2e06:4e84 with SMTP id
 5614622812f47-45101d20e45mr10600905b6e.13.1764192657157; Wed, 26 Nov 2025
 13:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
 <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
 <4697314.LvFx2qVVIh@rafael.j.wysocki> <dc4dba4f-8334-40ea-8c53-6e8d135f1d41@acm.org>
In-Reply-To: <dc4dba4f-8334-40ea-8c53-6e8d135f1d41@acm.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 22:30:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jV-80kfk-AY70b5pQtyXxUtU_ACBVP_TeTAnaY0Up8Lw@mail.gmail.com>
X-Gm-Features: AWmQ_bkBmIj-zJ9TMY9m_F7HbH_77kr49d3m5ANYRQhuc1KWC6bHz3Ba0_2gpRA
Message-ID: <CAJZ5v0jV-80kfk-AY70b5pQtyXxUtU_ACBVP_TeTAnaY0Up8Lw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 10:11=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 11/26/25 12:17 PM, Rafael J. Wysocki wrote:
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
> >               if (flags & BLK_MQ_REQ_NOWAIT)
> >                       return -EAGAIN;
> >
> > +             /* if necessary, resume .dev (assume success). */
> > +             blk_pm_resume_queue(pm, q);
> >               /*
> >                * read pair of barrier in blk_freeze_queue_start(), we n=
eed to
> >                * order reading __PERCPU_REF_DEAD flag of .q_usage_count=
er and
>
> blk_queue_enter() may be called from the suspend path so I don't think
> that the above change will work.

Why would the existing code work then?

Are you suggesting that q->rpm_status should still be checked before
calling pm_runtime_resume() or do you mean something else?

> As an example, the UFS driver submits a
> SCSI START STOP UNIT command from its runtime suspend callback. The call
> chain is as follows:
>
>    ufshcd_wl_runtime_suspend()
>      __ufshcd_wl_suspend()
>        ufshcd_set_dev_pwr_mode()
>          ufshcd_execute_start_stop()
>            scsi_execute_cmd()
>              scsi_alloc_request()
>                blk_queue_enter()
>              blk_execute_rq()
>              blk_mq_free_request()
>                blk_queue_exit()

In any case, calling pm_request_resume() from blk_pm_resume_queue() in
the !pm case is a mistake.
