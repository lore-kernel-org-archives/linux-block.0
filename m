Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E652379A
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950167; cv=pass; b=noZ4T4hKKBnD0lGqZyyOX8i3E7F02sWQ2zSvaeq9IUYcvtSuXZeS1mz9hTSdk0jAFByIZwhmyzvWCtfxmHiwl4fMDQWuj6Ufz271XrmWsDeloC14f9ZT4uXXPGtI1hkFwSXQAf84fDIQI3CvtM+2Eq65K7bDedH3gmXJaaJwsi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950167; c=relaxed/simple;
	bh=jiUSKPWQHUb8wgWpAcCdYB6GZGkWirt+xiv0f1KbsrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbECcLnz0UnrvuyFZay6pv+Ma9OZP+I5FcXcOsJStoSc78APZhQXLvw8JPB+8bNlYY+NwiBJuAUdphfvmHeM/TGFzw+7v6ztyr2eEghH2jPV9ene/8c7DoKCNlrIkBeuTa+x4u1vo0/jhTlAs5RNE8EFwY1FlbrBaZEPY3WV02I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=K2aGm/dj; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="K2aGm/dj"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99c3904a1so20712a12.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788950160; cv=none;
        d=google.com; s=arc-20260327;
        b=cCGbN6s583TQr0MwqI2W5jOmZRmz0eLQvMVbgDKCDfsHStadFUQe+omqmGoIpWGJcv
         EDnbCwRLmgLraOiO/Oji633J8TcotDhC0gUySasoGk/xYv23U+K3pUsl5ohirikTLSfJ
         scEr+u3ql+jndduert93vv0GbbGuy9dw8pu2LYjXJx97CVOJFJwx5T+djSKdmc4pAIKi
         QZMiM/DkjeHZR77xR63wdJskVRhv2pFT60UUy7bVjZzz1830+EADbR8uaDFBFD92nPnA
         NLMlBEHKfSQQG0ScgUYpA3KGzyebNRlQOJsaJqzJU1/UWxARQAQvYK0itkcYWM5JtOeB
         ayTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PiYK9hlMysoO7QWt3It5QIF3PriSPcy84exsAliRPN0=;
        fh=zIp8GLB0st8dawbn6bVXgl+j/AMx05TFxUhSfkhpt4A=;
        b=CJBan3Cp9wwP3SC4R9vSrtxcRLvfJHw3VtN/UJfTy4pySMisLE05pJkjKgza3mnmeH
         OjjLi9Aq+pvoKy4WBkUBDG9OW2N6hybgEKUImDjkB4ULfhYJ9efbR5BDyVbfpEaMqCFs
         cc7/NLfeGuSNH6eyg9ds9uVd6AkOciDGw9ad9MuUhGwdk7zhXL+Tezg8526Z45l6jYEx
         R0SIbgkhRFRdOsJKrmcHPHsstT/I9Ez6bVhHS/0T3OYyXHcTd/AHOU5OUpyVdgsPeWis
         MxYj1ZODEYG6X552XeX49cEs8N+01EX9LSE9zvTn0EdIIDT83eGppDGTkOj7ETTlOX9g
         jo8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1788950160; x=1789554960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PiYK9hlMysoO7QWt3It5QIF3PriSPcy84exsAliRPN0=;
        b=K2aGm/djq+KyUsHQ4ltRqRnnwRxbM+WSPbrCCiChCKHH8CK9xQRr5L8zYzAx9MDth/
         eLdOWdXEEFTSl4XzBbPGRdg7h4rPEntreCLR8gABJ+LOjQL6XH94d2sAs7lNYaJVFNeI
         ar1yA8r69P80gdUrOcNhlpDxCirdhcPjrZF3ESbb0a30af1hw6C3/fWYm9RVcfZE2QYT
         QZe1WqC+jATZE5bICQ6sfIspkNlFJ31p3cn95IPSL9Ne3kx3mdFIWUJ5kXaN/eYouaIo
         hzqynPwTDpTcuJSaW9uSWpqvq6asfj/PuyNCsjfb3ghaALHcNa8C2JMbanUeJF2scucx
         poIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950160; x=1789554960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiYK9hlMysoO7QWt3It5QIF3PriSPcy84exsAliRPN0=;
        b=RxNR2y5OTb2ytpyKgWfpGHfDt6agyhnyAPNQSB7Mg1QgBJ0OGbJ/o90pfAnrx8lIbj
         KvdOp9yfeepFUBv07w6Q//aYiCvonaaM862ikeLOyj35oM3T077nkJnDc+htswzj5NOw
         4EwouC8qXano57OC1D0Sjfz5sqGczfUIxXA6U4SH3RD6qGU0aUxsFC+3+xPfz2DkLT3v
         sKZznTFJjmwF2XKbnN27QyedJLfi+MHobFtasGyUDUSy++Icy6eN3OGpKPI06LCdO07J
         jv+DaCA8oyq/JKvhYDO3T+gGjtfvuKX5hR4POLknktVCuUUD3crvnD3shaVdsboPxn2Z
         T1zA==
X-Forwarded-Encrypted: i=1; AKwUvBx/vZ6RFhV0jGKh5LZCxU7Il3TIjj2jSpVVuOg1hb9O8Z8Dx1seJVtbLxfgxYeawKrKIUMkd8Ue+dLBBg==@vger.kernel.org
X-Gm-Message-State: AFuF++na51On529Sy8vHoYZhgfXm5p/XVbCwG5zOGIUDjl8zffyUYRK5
	lloGIHLx3rKnRpmtyoKB7q1GCHVO61nZUNeWUlM4XWBQuj2hyaGr1sOQ3kAh3Dos37tpwKmWAjf
	VI9m82xmUI+y19SYuLTHaaAkCp6JMcwoFRDWE/o2Y6Q==
X-Gm-Gg: AYBFou06Y+OWQV10PgGpoJ7NEG0KALV1U5PiavfFOgPHHmCWGJlp08lg3EOvxAaxVo7
	K8Jc50SdN26kOnFYLjnH8Nyn0vGb/TzkAi6i+WRF4dvYQdH38u8PpJuu6tAzhGsgVIughGY/E+J
	ADMMjnWthldc+37QeGpeUYwWvShng06azs7LbwaNnCmpSdcOTHecHjktvfu524JMyiq3yncMbzJ
	yv8hxncxZh+nBT4Opv2L/tLhn4VyTgeqVvbJbErHP78HFYLeV8gF98+LwzgsA9CtCJ0EtIuUPmS
	8YBAaaF8JWwCaQXXKYwnMiNuLq+aBOJC4yibok/Ui4CBwuSUM1Rsg/E=
X-Received: by 2002:a17:907:940d:b0:c25:3ccf:bd87 with SMTP id
 a640c23a62f3a-c2624d27f76mr997745066b.0.1788950160219; Wed, 09 Sep 2026
 03:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907133929.1081540-1-jinpu.wang@ionos.com>
 <20260907133929.1081540-2-jinpu.wang@ionos.com> <20260909062923.GB29874@lst.de>
In-Reply-To: <20260909062923.GB29874@lst.de>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 9 Sep 2026 12:35:49 +0200
X-Gm-Features: AcwNN1X-2oF0MYpARsjLKHXLdD4JaJtQpG0Ei6Y9Q2CxFNEsVa4yPYfrtiGyUCo
Message-ID: <CAMGffEngy4GGR0ScFYRAUwsGrnO17gL2HRJE3wBX8tHBaq5SNg@mail.gmail.com>
Subject: Re: [PATCH 1/6] block: add queue_limits_start_update_trylock()
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, abd.masalkhi@gmail.com, 
	linux-raid <linux-raid@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	Song Liu <song@kernel.org>, Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:29=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, Sep 07, 2026 at 03:39:24PM +0200, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > Some callers must not wait for q->limits_lock, because they hold
> > something the current holder waits for.  md is one: its
> > check_sb_changes() runs with reconfig_mutex held, while a
> > queue_attr_store() holding limits_lock waits in blk_mq_freeze_queue()
> > for I/O that can be waiting for a superblock update needing that mutex.
> >
> > Add a trylock variant of queue_limits_start_update() for them.
>
> I don't think this is a good idea, please fix the lock ordering
> instead.
Fair enough, I will drop the trylock.

The ordering fix is the rest of the series: the callers that add a new
leg take q->limits_lock before reconfig_mutex and the suspend.
>
> > Assisted-by: Claude:claude-opus-5
>
> But if not please try to come up with helpers like this based on
> your own.  We don't really need this amount of AI slop.

Noted.

Thanks!
>
> > + * Like queue_limits_start_update(), but fails instead of waiting when=
 another
> > + * update is in flight.  For callers that must not block on q->limits_=
lock
> > + * because they hold something its current owner is waiting for.
> > + *
> > + * Context: process context.
> > + */
> > +static inline bool
> > +queue_limits_start_update_trylock(struct request_queue *q,
> > +                               struct queue_limits *lim)
> > +     __cond_acquires(true, &q->limits_lock)
> > +{
> > +     if (!mutex_trylock(&q->limits_lock))
> > +             return false;
> > +
> > +     *lim =3D q->limits;
> > +
> > +     return true;
> > +}
> > +
> >  int queue_limits_commit_update_frozen(struct request_queue *q,
> >               struct queue_limits *lim) __releases(&q->limits_lock);
> >  int queue_limits_commit_update(struct request_queue *q,
> > --
> > 2.43.0
> ---end quoted text---
