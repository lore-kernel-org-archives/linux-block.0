Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44236A021
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235350; cv=pass; b=TR4WGbymb0dQVqc+pKTSZBkiMfH/tMNXT8x0Z2Lc/NCVbLupPb8jmsxdF8mmsD4JiIt50BdrAR+ijQ0kNA+GbWQ1V2lF4aokaoXgGrhXJGEVuXsAUmLwufN7ghmO6Nf35fEaO3aT36TLaWLpCSIvhbPDD8xiBV7rsfWAdgO8a/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235350; c=relaxed/simple;
	bh=e8LyJVLhzeZhK+mnAOo5Z3iAUlAYWJ7rw1Zylm+hwnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u270GUSWITaWn9c+9W6x6yHcFYLcm/+QW0BsEnzjZnC666S9PsKF5TqgZd+35ukVz4wEKVIyf3FSv9WJQyWoz85D5ViVDmcrhLABT3ujs0WotaI96Aa0SdaDWjlJgLapwDn660w+Hls/Ee9heiqrBZlWlckxGeztNKvLDL7SAs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bjMod86K; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bjMod86K"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11b7bd9e6e5so475436c88.2
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 08:29:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768235348; cv=none;
        d=google.com; s=arc-20240605;
        b=XoI3PTtP2Pg6O9w3KZBeDaCFShH2j7n6qlRGlgRGx5iBw4gefLU6//bQvZRoA77Alz
         VOf4jJrGLYT6fP6JXvWFgpmH/FCfDtwki2nGRyIG9ldDnqKsVuUeCJdm/Yn+6oyzTl1A
         oDGjzYlJFJ6LAMr8Qf5Ya0QoeyItlyGmfQrfNcEXcgZf1uZ/B6DB46xe3UMZ3SwOuZKX
         ZPYlpYikQY1weJnDKLSi4dZVIQG3H3t1559BMjCXMHYUkGA7sCtceLXcoO3UVR/GYk7a
         JS39z0E6bHqKKaNerg/vE2FT9/CUvGBVqocu7m2LPg7JUSZCyc9J4J7iwSbsNf3t3ap0
         t3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qndg8xEyWxa1qQV2BnJkd2BntQ7n6zkB5fFElGhYtO4=;
        fh=HyvSaSun8GbNW1BeSZM9qAZQDCB0P/zURYVTWv9vktE=;
        b=GYyF8bfwwZ6JZKhrsz698ZK5ig3zl7hfZS5z5tsx0cepfVJhdJ6xTFCrkvBsv57pOp
         N5sPHzGA6RW6HU5Ruz/sMwLTTEPof2zYQlblI/3mbys2dD0M82esyKUn3F66pW5Wd90w
         7Fe6JCXcx8mvRuqRvLxexCF5G0DQZWaLbAkOU9Ur0iiUBejnrOJGMoQpV/4AM8ys5WU2
         Uy6q/GBPfC+ILPrKC+AXnIgN0SpP48OssX9b9THsFjBCXidk11lzUYQO8iY1mU5JNxiC
         eP+p+xI2/vfs2kgdQFm3FD+Qtf9YsiYZzMJX43GwHiS5/18k9X97FQHCdWy8MhEeTwjS
         mZwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768235348; x=1768840148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qndg8xEyWxa1qQV2BnJkd2BntQ7n6zkB5fFElGhYtO4=;
        b=bjMod86K0F6i6O8KKR3nqXEMMWUZUM/Kl5mgmGdTflixA2pwdFMl12UDyorbTibaML
         39YNhWVA5IzTMaR4gENTxmkC1KN5sED45WmkHQ7deCQJmHi9xQIuFfA+pIyekqwRfztX
         Fa1AUJNoBIN+FAH1hcQVsBQEs5Ey4qrksWKLVGdhLAxs2BGgsmWBIZkBa0culptTfiMN
         vFMtlRKz/lOaBcYQGH1aj9ooWivVBTSceVSAA8F+rIYp5SD7kDYQorJjrDkOdji/ZPyF
         0y0Y2mdh++GYznP4zlrAQm/rcB3ha2gn9gurXQFO894lc6J/TuY0KyWuf6+JdbqUWrAP
         NIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235348; x=1768840148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qndg8xEyWxa1qQV2BnJkd2BntQ7n6zkB5fFElGhYtO4=;
        b=fwSxsGpe5VbhwqA/W93AE2OD4a1+xwbJcphNdvCt65rvavqHvDAGzA0vtuh6AJEyDu
         Wp+XR64uWu3U5FBdgexPgnoxGA6dqq4yVzOrvCryV52wJTCwZ7nKLhE5kY6/l9WMALHC
         ncJZVGrgNnsSE4+KCsjAZYuWUrhhff+2aZtLKGJA1LD5oPg4uVwnpktuuL62mVq8NJIf
         VIdcIjR5vI54Cw/rxu2mhcNPTDW/YCnpvAxEzZKb2Rz0LfrGC63j3KPjbHPhfMxsVKVb
         0SLi3xf1hZMofIbcEWnzqlvsXW/s49+s4caLF53X4V3fGHqiI0l/vcD9R+Nr9VvAZ3Uy
         IDng==
X-Forwarded-Encrypted: i=1; AJvYcCU08zh9rzxtImollJ5jS6vZ+tFQgQyja2InR1EnECKY8zuYj3tqrkfFXJNStKEIOgvPft1PoTi/Lmh0Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKB3YCSR8Gj8CLnYQ6ivi+1QEkhVfZZQFcS6DdOKapqSb0vbX
	CHbPJ3eZstXSHcNFlO2ejAlc53kWY6OBKIEcJa6YIWDflPiorBnYSeFQcfS9lXHtOI4mHLaX7lA
	7pVN65rcobMu4ucIqShxk/QYJrhzFfNDxSpyLVTjD8w==
X-Gm-Gg: AY/fxX473Q4mGOPKBUvtDzoofqy80kKKdYt8WOdW5Bt1tJq2T50nZigTgy02AkJbFdN
	qmLO3A5LiD++ppVfZWCPL3UktUKOtl0AWZiMGdszbKpSI//HrUUI9ct7Db6JSuaRAydIM9FN6T8
	jNt9Zixnzcp9BmY5jzdcP6Hg2koXd/krRLMGcJsrreLP2lX5Wv5zLB31nYaa70ndrdVYMcCFNxo
	VW16RKPC9bcG9tvUkjde7zXAr07B4WqQnEeFLCIaFGhwk55aLvFkCcVowNgxfbBctqTKQoKax0y
	SpkgGHvJ1gZcnWMUcINygXQnLLGI8w==
X-Google-Smtp-Source: AGHT+IEHO5EH2u2daGnFChfAwuSAGtTRCjrVQMLHLBBXRffhqA6KUZdgxJVym4lpALUsFqCMVCvKCqMFs40Z8+IiDgQ=
X-Received: by 2002:a05:7022:622:b0:11a:5cb2:24a0 with SMTP id
 a92af1059eb24-121f8ab7afdmr9855842c88.1.1768235348234; Mon, 12 Jan 2026
 08:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112133648.51722-1-yoav@nvidia.com> <b784bf25-78aa-42cf-bf3b-0687d9138139@kernel.dk>
In-Reply-To: <b784bf25-78aa-42cf-bf3b-0687d9138139@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 12 Jan 2026 08:28:57 -0800
X-Gm-Features: AZwV_Qhz6D4jHdME0mbU8QMb2lIjicAilrPF9_oVi0_d_AioMLKcTk6ZbBxmaDQ
Message-ID: <CADUfDZrzAdjf3PT0M7Gh0jQshKKRdAmb8Ce39dNUfj378vvDTQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] ublk: introduce UBLK_CMD_TRY_STOP_DEV
To: Jens Axboe <axboe@kernel.dk>
Cc: Yoav Cohen <yoav@nvidia.com>, Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	alex@zazolabs.com, jholzman@nvidia.com, omril@nvidia.com, 
	Yoav Cohen <yoav@example.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 8:22=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> Please rebase this on the current for-7.0/block tree. It doesn't
> apply at all, and hunks like:
>
> @@ -311,6 +312,12 @@
>   */
>  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
>
> +/*
> + * The device supports the UBLK_CMD_TRY_STOP_DEV command, which
> + * allows stopping the device only if there are no openers.
> + */
> +#define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
>
> is a clear sign that your way off base at this point. Why else would
> STOP_DEV be 1 << 17, with the previous one at 1 << 14?

This is due to being developed in parallel with other ublk patch sets
which are using feature flags 15 (UBLK_F_BATCH_IO) and 16
(UBLK_F_INTEGRITY). UBLK_F_BATCH_IO is still in development and
UBLK_F_INTEGRITY was just applied. So I don't think it's fair to blame
Yoav for not having rebased on commits that didn't exist yet when this
version of the patch series was sent out :) Should be a trivial
rebase, though, since the value of 17 was already chosen to avoid
conflicting with the other patch sets.

Best,
Caleb
