Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAC3537CC
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296432; cv=pass; b=unEz9YuS5vnWl9vJQ+wz81GWxIm+gF7vkc+h21deSKYf18ItUf/7lPBF39RdyRacSBVFhaRBtk23awuNdiZ1LvYvvKtQ6e4V1nIQGk4rLQEApGX19+9nff8faiJdUW4ROqRs8cjYApuUbOywUQ3vO2DZcanKr5VefLNLQyCVU1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296432; c=relaxed/simple;
	bh=aYBnFYAI/Ks+R8p5tPvxD8ByPYcQIrCSQdHSp9AUQUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bU2zWEJtvhIM1XtNODmVXQGuGPnojRpwN6w7vrbSfBSYr/SQ6hlSM/kMWHxj3/pdwq7TXEHTtv7FaULquCT2f9TT1N8vTnAcnuEkEd21+Ra36t0XS1vxTdAQgBl7y3YKMIJX29imJmyZH3Hbzm7Z+yAOdMykiKTRXNmxE+YHBNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPkqGvNs; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPkqGvNs"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c1971f5efc3so32807466b.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 20:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785296426; cv=none;
        d=google.com; s=arc-20260327;
        b=EkS75FBYdPRRTPzn4o4Y/ECP1eM1/9o14TMljwCtkUVkC5afOu10FQo1bLR9XHL8eZ
         ug9EPh1ACc4iG7VqVhA9QRO/9GPrt7N2hveyAxm1vryR7W5iTqlGFFuVAXwtSVMHF6pG
         OljTMpEgK83kPVPvprRG4J6g0VRKFXOUnjrl1Rzgp8nvntcPLpWuf1Xou46BjSmfUeB9
         F56YMIYujEgcfX6a14d/Y2IH0nFAHH92mzx0MeSJWjKdPeY9SUZJTNpIbLib+FhSyngs
         tDvWNejdKh7VhNVeViyWbJHvTqDeRGiqxpyz7PN4LVymE9+qY2UrCrVdowIXP3HUczij
         88cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aYBnFYAI/Ks+R8p5tPvxD8ByPYcQIrCSQdHSp9AUQUk=;
        fh=tvRN/gLB9nhP6lBPcT0g+YpwVesIOGWjNufQSJ8aifk=;
        b=OgDfpp/Kjzr4PQTX9PhFbn+zF5ir1s6cxT4Gh/pIOoAX3FmXFK/wOgXMsHSzeYJRrr
         plP9OGrKnqYiROCWlnS72tWZY9g7NaxdtxDMqp0P+bPQnv8ZMQM9oB6EzeyY79QmjZEJ
         TPqpzjsoidqlZAbCSnHM1WKcD9/EbQh7xIRe2RGlqi/Fuy0oygF7VBl0rAKyo+nA7vDm
         FLD7NmB1oLRmYcqh94VQ2Pw2WgdsCAIxVqzeb81y+CTZN8yhw+jj5P0iD6HnDhwK7+Kb
         Zl9jLkCASjkGEoKa2e9kVjRTOEoeaeR7D6zbvXatnPwq/CcnymLqB8Bs690TB4PiSzNK
         biAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296426; x=1785901226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aYBnFYAI/Ks+R8p5tPvxD8ByPYcQIrCSQdHSp9AUQUk=;
        b=kPkqGvNsNXNfY6kTiTqA6EcWII4XlpvwR6uaECWNMZNP+/fQih8/H6WkWRJq86wp+B
         T0+gGtei6bC3eNo9zux+6s/VJkM7CRA7zpvlJHi5xzHpzD8hAoD8J8+SxPJUpuqvpfJz
         2BO0s2X9jQ8KucszJOVw8/kdAoIX6BzPZagOrz/Z4DHhDFsUyEF8mglqCnf27ScpiAwb
         b/J6AUEpowW5uoIeHOvLHuotjKyGh5U1gqNqdeKmiZZkuPupYqbJ3YfuGyhM3FE8+kyE
         Jehlmaws8+F/e7z//nxysfz+1VAWOMsqjlM4V5QEYxnln7afQr92VL/QZg8X1v3lRX2u
         jURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296426; x=1785901226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYBnFYAI/Ks+R8p5tPvxD8ByPYcQIrCSQdHSp9AUQUk=;
        b=mSa0e2GkqaOFYjSD8MA3K8qp8QigasFP2Nj6DTnyRui1qxDyz3ihGRzZx12EveRIEj
         1k7BNPFsLzK0zdKO1b/SZ0vdprM+7MjQhy6cUiSamtzco9NH297bK42aADrHPmBef73+
         leDQcwjNqy0bNdpQvF8e8Gfs2iyLtPG9MlBLggXMcll9ONgYxPP7LW9t3YSL1I8Bjq7S
         qqY8MriqZFpCS0AfMoYAdOnv37ALFMYlasIA4NihYgBrBV/glPk52aQrBUQCWtKXYFij
         DfXP/zQysvFpA0LZXaUoHHuM/YixKBH2zH9qLgu+RXAqdqt6oXd/M5ph2wdDyt5UaHAz
         yt1g==
X-Forwarded-Encrypted: i=1; AHgh+Rp3ZRfxlzuS+AhG9GEPkLgMytsgW+/Uh+vcckabOmbsCClj4pCtLP79pKglwu4Z/Wqlutg7kVM0qF3Gfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6oPXxNq5XrgLcads/LqhjOXea7vCeW4RWLDIauhNTpTpqZ4My
	GwE0nJzcjyPT8KPO3CBn78sjw8kwxeCHLJD9+pYMd3PWEdxb7a2dRX81g0qv419q9ZKYVmYLIe0
	nzKqPRG18xVcWIL3suGoUS3tElHV6iNVEXfFoTaADLFbd8m4=
X-Gm-Gg: AR+sD11CWic29CyrdRG/Y+8bDs/p1rrHlPoG8+siE8d9TUaS+Qu7W0zeGY3Gcqb+MRW
	zzYUyFQ+Kch0R6Irgsft05zSeI0Dp2WLjCKWddO5N4XH3vMK45kLHUKPkTrOK/YtaESEqdm3kUj
	64Sj7Bplj4hIkWL9UAAQ0XltPZYKprMX6+RruD0/pd+Y1frkj+2rEvdDocuZnp4dy5qBYD3h2LP
	gX2Qup3mmBq2nQEl9FLbKdQuMlzdYq8QuKvkK+0kCpAT8U41GsfXJ41bnQQzRE2q654tlKDh4YW
	qlivK2OsDUfsy2HEIOgkdeo3f06pNVDaUbfXZGza4KzgHw==
X-Received: by 2002:a17:907:1c09:b0:c1c:257e:4888 with SMTP id
 a640c23a62f3a-c1f71df0976mr280872766b.27.1785296426566; Tue, 28 Jul 2026
 20:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com> <amljC3jQduwortXG@google.com>
In-Reply-To: <amljC3jQduwortXG@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Wed, 29 Jul 2026 11:40:15 +0800
X-Gm-Features: AUfX_myqjDyLuBXSLvBTHxAQ1A2jbm6Y05RlDnykCGzqigBNkth-Foe5CeOsJPs
Message-ID: <CAEjiKSn0hwW_1H9k=hdcZzOoxZTzZp4=sy044WTk5R4Kz=k+xQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] zram: fix early release of global cdict/ddict in
 per-CPU error path
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:20=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/28 17:29), Haoqin Huang wrote:
> > zstd_setup_params() creates global cdict and ddict stored in
> > params->drv_data, shared across all per-CPU contexts. The per-CPU
> > zstd_create() error path called zstd_release_params(), which freed
> > those globally-shared objects. While the drv_data=3DNULL guard in
> > zstd_release_params() prevents a double-free on the init failure
> > path, this is still a layering violation: a per-CPU callback should
> > only clean up its own context, not release resources owned by the
> > compression lifecycle (zcomp_init / zcomp_destroy).
> >
> > Fix by removing zstd_release_params() from the per-CPU error path
> > and replacing it with only zstd_destroy(), which properly cleans
> > up the per-CPU context without touching the global params->drv_data.
> >
> > Fixes: 6a559ecd6e7e ("zram: add dictionary support to zstd backend")
>
> As we agreed earlier, this patch doesn't fix any known issues per se.
> Let's not send a false signal to stable folks that this patch is
> fixing a bug, let's not add Fixes: where they don't belong.

Agreed, I'll drop the Fixes: tag and rename it to "zram: do not
release zstd params in per-CPU error path" in v3, which I'll send
out later.

Thanks.
