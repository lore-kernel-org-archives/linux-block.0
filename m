Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB138E5F6
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508345; cv=pass; b=f/KkIA+5H02GjMZRmTFdKVHuirMWuuU3jDdZh3uUqF1rHCfoU4blcWi+E0VLSxBE0Q99eLyN+qQdQTUJn+k/lvxz9voRcT5O8MZs0dMkMgeWF/8G3XEcHEv9wkDI7lTWHnxzV3R6tepVqT36Zy7AReWsWy7nsBHxi8W7w3Zs3Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508345; c=relaxed/simple;
	bh=x+y5p6kbctWnERgNgUgu9T+qQ8dWB1UZlWknjPh3g8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbTGEiy+3mEWkKDdGHcXWwz5FAeGfr/h7xkVVqRrgfvBeFWUNEnmBd2liwwkN/j+JNyGmFsAT09+Vzvpf7JP5ytpwAa1RoiP8Hff+/Bp8q5U/8tOn9C5zhmt6HzshfXNnfe+fAkzM73Ja4Ym4TuqgZx6LCj13BVJq7dxnU+ixHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bFzo4d+K; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bFzo4d+K"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66a87f29614so129368a12.2
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 23:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774508342; cv=none;
        d=google.com; s=arc-20240605;
        b=B2icGYXAUkBBXyVkEX2pKJROaejtLhtjeTmlquyZmXSUcjAkg50zq9c5CmoCquWs33
         7Wsmrm9g1McOrHNJd7QMEF0YQbPBDjp82DTgDD6ncNvwMUwqghETCPuvAMM0PqWrdb9c
         sL+l/BvR+affPtWG5g6Zss9nNa4dP/4oWdq2vSsQzH21GWCS4RoKX/GKJtG/Ux6sAiCS
         hrjDUg0n8MShr+q5gm1rFDBhXVbIyDE+H+gMlJmicWcpt62Wdjy7avZHUBPLKCI+WISA
         zlXE5ZqE3w+XhEju+kJV+TkCAC+SNd5RHIEu2lW0Fb+3AXomslPmx2S42PVcGWPzwD9e
         rHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IdUcrKjMUfAdqWnWyjhXmvxYFjE633xWeZn2/aGTBeo=;
        fh=txKoBBwG0vrLwvd1t+yY9Rfe05QXbM903xRcOdsSmFs=;
        b=hokKpU+TpHu2roNzfkQFmOZDhT6ylnakTJIHtnrb3NMntsRlmteCJHm3ubkN4ctb9L
         Y8JNKOWPV0Mw0tqLIVHR3OP/3xpSqKOkqvkLCSXFEL49qvlAf4AMo6/d0kT9uZ5HTpyk
         GvdsmJBewVG2RzMAG1nW4vrv1LSkUSSMfWlRAmdGuEaZUSmHtXEq5Ddo1C0gm0rkQWfm
         4bEnqi0GkMnfFk/22xeZnLUy3oCC6NYpbw33i/9KtybvahnEvemxTia3jdvW5MWBIANc
         MbU8AIjyPg1MCcLE1mh8N/NlihjoJMKCcYf2TCwH6LVx4CFPpqM0qHpWVJu8fFEBn91P
         wjvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1774508342; x=1775113142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdUcrKjMUfAdqWnWyjhXmvxYFjE633xWeZn2/aGTBeo=;
        b=bFzo4d+KJcn59MB7pJTBz0+ncHmxWocYaJ5SMu96Z8UrZsDbhvs1g/wRvrSndDoQD4
         +y+4Ar/ZVxg73BwDN65J5CE5TyL1VYg2Mh7YKsApLYG64DLV62IUuyr5tAoHBcIZHqmG
         Ui5h4lyELubeB/LO4YQQmAH4ADx5BsKkhM7hiSo8ov3LU/NT9DJKfQkZ0/3ZgLtQntY2
         AU8+GjrcFVfsyxPyxd9TEmSkbWESC3JJapo1DkhKQyTXUeQykKXyJ6jjpAw0OqFIsLM3
         T/Oj0otfidg/bWB4msj2AQDG1jW7+rDPPr44xF8ocNd9hmnUlH0ao5RD4g+ZsgBpEi1b
         P/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774508342; x=1775113142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IdUcrKjMUfAdqWnWyjhXmvxYFjE633xWeZn2/aGTBeo=;
        b=YhAag2XfYZGjOzLFBUPyPIyBLuwQrw1WHKRuWmN40CakWDG+PLTPXMXWsF+yIjbpY5
         nIrmDEnJMDuiFagN9PjurTObU0vewyh2FnT5nT29Iq0cxlpBvqXGLiiSeFRUtU6BYNwr
         nPm9p9XsLSa7VCNdMr/3pQHDwhVvrt9ylB4T1eAV2pMDHC4X3XxVM/F9K/UnpydPy0MA
         Fd+Pfq45LiK7m9OEAx5W0hu91+TyfnuMeGUqkJrQB+mS0OzEk3Vp1Pv1Rc7mcSNrRAqS
         VFkn/uCa662o7on52KToJzZpiI16Wk11Flz8hI3TnKFQn5MeLV4ttxFvyfX2aW1NmmlX
         HAFg==
X-Forwarded-Encrypted: i=1; AJvYcCVLq2BE6tpdjO5ePxDhxDPHB9qTMwsgyvRoHYdFCWTcx4oqLKheSLMfLBIQ3SAXCuVnQWddl1LiZErHEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YydAZk+4cfP6w92U5jssb09TGcCRWdjTEy3Anb+byY39hanlDzq
	bL8ObbCVnxpSIKtRCPqzWWtByby1HEBqvRnWZ3vQ1OWiSWHSplBdEamfTi028g7cwQPebq+vOgc
	bCSXjOn0sFqSUIMWG0YZeQG7L44HPgNXCnEDPzGY02g==
X-Gm-Gg: ATEYQzzC5zmWz+VQeQa7YjpKyCRO4+t/JXLOrjGvMfZQb/5bR1/QgL+J9Gb6ZRhXl0h
	HNJ77uqD8JppEcs8uHS4AqnT5r8DszsmCiwrqFfGWxFvRPPdl6g+j8/zcYIj2A7OwnmpLX39wVR
	b89rnOdUD3a94qxf8fdQuQKqQ40lJF9moVMQqc78vj+zg0HKcGS4rhEGLhBfn40dufkE9soAvnK
	aa6Uy3wm+OSdrNc5aG6LeeVpSOmyRK0Rweat9Q8xkc4Y2QlwCGWQHtmbwGhNOf5gFkap4DkFjUG
	6AFIFfo7j76jw5s78vSvyny6IXvNBZo+nvKRoC8=
X-Received: by 2002:a17:907:7b9f:b0:b97:4e42:23cb with SMTP id
 a640c23a62f3a-b9a3f138b21mr184509566b.2.1774508341817; Wed, 25 Mar 2026
 23:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-26-bvanassche@acm.org>
In-Reply-To: <20260325214518.2854494-26-bvanassche@acm.org>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 26 Mar 2026 07:58:50 +0100
X-Gm-Features: AQROBzBNzk2rmHUtL8EMWIZJNKe8fCzo6ukNZnc-FnUqxjEw1aORywM90l5OoTg
Message-ID: <CAMGffEmo7fGBkyFFZyPf+7-Fkd5vmOxLC_WYzGfbQu30f1JaCA@mail.gmail.com>
Subject: Re: [PATCH v2 25/26] rnbd: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:46=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> Let Clang verify lock and unlock calls. Enable lock context analysis in t=
he
> Makefile.
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Jack Wang <jinpu.wang@ionos.com>


>
> ---
>  drivers/block/rnbd/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
> index 208e5f865497..42c2cccdb53d 100644
> --- a/drivers/block/rnbd/Makefile
> +++ b/drivers/block/rnbd/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>
> +CONTEXT_ANALYSIS :=3D y
> +
>  ccflags-y :=3D -I$(srctree)/drivers/infiniband/ulp/rtrs
>
>  rnbd-client-y :=3D rnbd-clt.o \
