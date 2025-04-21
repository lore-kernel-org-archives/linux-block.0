Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647744C92
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745260540; cv=none; b=c4wc8E33ps7Uc2pmiJw4u9hXuS/cBFZqEvyyxz05YHbE5WZxot75VO7BfAYQi6ALXRd5P2KTywSWqpy1M5dFac66D/5GH4MbyfzNW6e2U1YehORtasvthmn4khWYm/H7PSYFZlOySxgdeJW80YLMegsGsjJkIO0ONLlcde9peqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745260540; c=relaxed/simple;
	bh=4FLRQyjA75esPKig7/y4NlRRSxQw8Np0LZk/qpjqZyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoIBsDiaqgkiQwMqnkOguClSKLiqEeUx0IBaZowf4jrsqAOnJfWY4EVBreuWxUaGOnvbYRtOS3Rq+QIAH2b5SGY94T91b8Eo91Ui0hAp7m0qrK0Um0Hr5r+yk/Jm3YBeTVeTeExdqvBLFrZOOWSQ50gtStn1mELYxAJg8jMAVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dFjkxmRc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dFjkxmRc"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acae7e7587dso579810566b.2
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1745260536; x=1745865336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4FLRQyjA75esPKig7/y4NlRRSxQw8Np0LZk/qpjqZyc=;
        b=dFjkxmRc7iL1ywzMhPKFH1f2oVbOtQj3f6Sxzn7OvZ/IdivrVdqISIWDeRTnuelob/
         3FyRxs9Zw3X/K4IsSW0xouU87CP00aI82AIdBhIwxOQyIO8l3Ak7pbI/Z2pEdickT01l
         q45veADOiw0HO1taF0AC0U2IUULMj/7Aie4TnHBWGrq8ksj7qS/HjaUIAVty5GSLJWmp
         FtU2SA6Joa1oHN16Pg+VRYiWpf58ghaqv+Ea18wg7TGe3AxXQYQBHFtD07DsMcu38b8W
         j5HqpL7pa8jVn6aPpD2ZzewH6r6lhkubKvRddtijxhA46rsNJKyMez9IiABZYs5f2lrs
         GLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745260536; x=1745865336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FLRQyjA75esPKig7/y4NlRRSxQw8Np0LZk/qpjqZyc=;
        b=ugvnzjA4HuAIX7/RzFy+2OYL8/r5wh0Lp4vpI4KkMuZQDU21RqBJ/NuDsU6rQTEsGr
         pFTPj/bZBTvQZWH9emSg8G+tkVAq88b461g3ikgqj4MZnpEIXce1BHJWOtdj5JJeApEm
         WVj3ngd4eob3OfdbI1IJRc4xG397tajQ2N3O5jzSsDLdpi6O8CTt+dqxDy/REa3YutY8
         SUaAC2E/ZzJ9wKDLVzZv7meFraJ82Ih1R8MkJjQeM59xCkbTZuAT6JlbdeZsP9Mpk8XK
         x9K9evq1CfHQuPBjOsT2oPTPhdahIwBAUVJB2eCV5RPCR6sqweCfqw04MDwigiPO4vN4
         BDxw==
X-Forwarded-Encrypted: i=1; AJvYcCV31JsxpLX2XYy/he2ImHH7+FYpN2PiOZt/uyks0lOwdhzz+fYA29eIH75s1tJcGaDF5H1ceydwFfiH3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2uozdpHdRun8Zi2rUmCWtfbXoCV2yUi/oNM7iP2rlpeWv2uV
	UEhPHSnX+fPsdcL+AJye6939IcyDC02fHFjcBP0QLAxyYRJJ51/XeruZuNYMImhd7Mipr2pDBz9
	5qZ5lSlCwgev8jtu/9Py3nFngY+B0drls0aXGVqvKvTyLuLoG
X-Gm-Gg: ASbGncsl9ZTa4Xg3wF2mzmeZBCHArauPFreSv3+Tn6yGqO5rb86puiBOoHEFpCZ9wYO
	79fqAtxNCT+J1rFyDwysZWL5trQCLd5a240lr0vfW7NK+4fbVLvfpzQ+qK0KwrnVyjHm9LScAAz
	nH+9dL+aqUqjn7ESgjRNlvKOFh9VKOl943kMwppg==
X-Google-Smtp-Source: AGHT+IE5NsNCI+kSyoHvC9OQcfQ6IA5pnZM66lb3T0Xl4ORadIa8suDDI9TihzbYKF8je2HDB9RwxpCTtXdUnDxvDpk=
X-Received: by 2002:a17:907:9484:b0:abf:c20d:501a with SMTP id
 a640c23a62f3a-acb74b0594cmr1252111766b.16.1745260536560; Mon, 21 Apr 2025
 11:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com>
From: Matt Fleming <mfleming@cloudflare.com>
Date: Mon, 21 Apr 2025 19:35:24 +0100
X-Gm-Features: ATxdqUGuIHx3xDv6mmbv-jEXqc2VauXMxiapduY7E4gkT7FUIdHRX2Vdm7bOYvQ
Message-ID: <CAGis_TXyPtFiE=pLrLRh1MV3meE4aETi6z36NWLrMkYKkcjGNQ@mail.gmail.com>
Subject: Re: 10x I/O await times in 6.12
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Apr 2025 at 16:22, Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Apr 21, 2025 at 09:53:10AM +0100, Matt Fleming wrote:
> > Hey there,
> >
> > We're moving to 6.12 at Cloudflare and noticed that write await times
> > in iostat are 10x what they were in 6.6. After a bit of bpftracing
> > (script to find all plug times above 10ms below), it seems like this
> > is an accounting error caused by the plug->cur_ktime optimisation
> > rather than anything more material.
> >
> > It appears as though a task can enter __submit_bio() with ->plug set
> > and a very stale cur_ktime value on the order of milliseconds. Is this
> > expected behaviour? It looks like it leads to inaccurate I/O times.
>
> There are places with a block plug that call cond_resched(), which
> doesn't invalidate the plug's cached ktime. You could end up with a
> stale ktime if your process is scheduled out.

Is that intentional? I know the cached time is invalidated when
calling schedule(). Does the invalidation need to get pushed down into
__schedule_loop()?
