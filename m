Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEF3911D5
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789450760; cv=pass; b=eAPn+PmBPwP5FyPAv1AynlRoNiUHKncfKwOFxxDkPxKNZqtOyy0uyc1EVeoPQAFZKrOJTofUuomyv7AiypoUOV6a/Hc6O3arcznojoh3zSx4/HbNtUUXyBZaQraeM3KJLgorRrtqtdC1VhaJimS/NyElrYceMtcgo1QTLhcnS/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789450760; c=relaxed/simple;
	bh=oZgPhjZZTU7Cih19Ba+ylw61wgq4bdvOE9HAW8ogZSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzNd1NJSwWlHZHfdCsskNDbUit3bWCVuu14067mLg0qtOS98VnqPlqwjiey3Fwv1A+EbKVtw0Rdwx9Ynf813a7b4MaqR/ruGRYL2AbshcJhRj2t3CaH90SUUf8O3DnLA6KHIjftF7h5J1LHcN4udaUD5jL7zrD1Nug9ipnCFM58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRHQyWib; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRHQyWib"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd4b8eb7f9so6008555ad.3
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 22:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789450758; cv=none;
        d=google.com; s=arc-20260327;
        b=lONevSH8c1DPyEesht4R5ZaSf7Mk5V+6f9eNwN/xztlyx3wZrYwNEJJzH7l6Mhe/mU
         WfA1Rj/EjhbF4C9TdEWLXCVwF8kROyarwK7mVNU9u1SHRRlC8ePdL6FobrvyB5HjNzI8
         zy6BKtpa2TOncU7Etd0AHjQULr0Ye7Xqoi2QVKzUg9TL5kFnYj/2O4VLIz7ynKaASMye
         5zeaZFSm7LgRqYyz5wxtU6MDuOg/y0yZ2noVC0syRxEr2zfTaWd/rk+rXEb6e4oxvkTL
         skAUXEHbxuJJA4FxZ6bK2fvZLvw03+iiX/EQsaEmW6W6k3kAmZ1pZ48p7lYpiFA2YvRM
         xSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=poCNEIaA6VGdI5KVygK3LN32EN3HdWB0bLyXipA7M98=;
        fh=eIo16/fXEpSsr8tjyqXW/PZmIZpKeQZgoFjir0JqPWg=;
        b=GXbuCGmllRaVSVZCeZVRVZpWklAOlMR33MOj7uqfp1XiRRLBToJABfSxuVrfDWyCUy
         4+cFLy1HnGygltvHeutvQ6mcghsqH7i64TZCXjlUH4jWUxBCffF2nU642fYX8V0gkQbx
         aMusUfhFBGS2SkG5DDunzFEiYO74HmRTuNTR9b0xmV0hjAANIO0rWWSdr/NoSxmXYggo
         pbPHHnGZicFIcvkOswxtb+VcNJrU6YMwH+8mKszp2g3Yt0z4f4ian5i3Yhj94h2nipGh
         V8nBAGX/+rvJ3Qs1Nr50b3WJglwixPCcrXEbuqk0/LWvvQtZulsw82c9wSS9TZsFhlTb
         uKxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789450758; x=1790055558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=poCNEIaA6VGdI5KVygK3LN32EN3HdWB0bLyXipA7M98=;
        b=hRHQyWibMLxCSmj5dub9G0ebI+pr/CwMvVFjX89BzqYUAkDOjp77cIWZJaRBBrCfYb
         WsvhlW/2wPU010IXeUYCxjTOhb+96I9ohdGX1l5Sj/HPpGnEJ+xff0jlXsUbFocQgHWn
         R/Ry09lZecc6IZ5T9fmEQIReO4k9RkXRTiUwU+9acAM87AYNhUTflSbjjYdzXnHrmsZo
         J5Ltv/WGdiW3048YJtbLRb9UFiEG8ax3zBQJLIKirtVF2/EuoDxOZOd1RNa6F10AswSm
         qqUp8Gc3FBxbtD1gbx9R8N3mT0pruVzwrZXUFV9ZN+ctMcJVsaOV2PywAQZNCRUNWVmF
         C1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789450758; x=1790055558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poCNEIaA6VGdI5KVygK3LN32EN3HdWB0bLyXipA7M98=;
        b=nl64Y/HYUSeswgSpu2pB3d7XtgEbCt7RpJGrM/nul5ftLOAeb1qZLbbEGJnAbq925J
         yFapPsRuePUMEZs1axuF3LdlbZDJ8qz3mNtPQbkLEi7qHqBbMNZTo2xW/Wx81WmPx1c0
         BwDtekSqM+AzNxNQJIVazGNPQ0s0TEFfsjd3u1nV6R9YWYXqs8EqfN1q0dX8TYP/jcGz
         3HzbMu6a4GqxDGoLk4cBbkIL9uIjbMM4ybxZA/kpZiMWmfKRENgjb81Yip96Y7fH48XP
         o/TjR6xyyDe7pRXvZnVN83D+wozKSMl63hd9ffo0Yfq4mqCKqzUDTHxLsOlQM/Rr+Sdc
         KHQw==
X-Forwarded-Encrypted: i=1; AKwUvBxsZtG10MqdmSyH3v3KO7t9Thly4TIHmJO3esCPL8l/8/R5AbvAt2sdE2/MyF3OyocVlJaO0VFe0scgCQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m1xEkUMu3gnSVwlUTWKmeE446Y0feu+9KLzazQHbAMeJDp1Uzw
	uZuH1Zc16a0hMHxBn/tYAkmTgT5XRNO3+QJa7nWdKqgMUzjbrw+2Q1DUAjCePvGdiNon6nnowgu
	5tbtUuVbBr2RjaWGa6MYaG6XvUIxizmA=
X-Gm-Gg: AYBFou087n68a8lq/etxtqIlz1xs76yHtSx+q+6d/80DuYVL/W475MpWXrK+PuHRtM2
	VjcDpTslwMARX3BE1VUIpCEEt6WYJPg6P2Dz8XwT7t2wopqpNUheUl0x6TSQW5/QeltIACQQL3C
	n3ihUQIBvHuXHJNav6KAAEKIauSaBbFSMpVaz2k621bz7CE6TLFR6cAgCqDw2EN88UJG8qKjk2C
	Hm2mOEsiqA/u0bVr/H+FeNRWm/wz7/K3xtvAi87RyQtYyu2+4WJqh/BuhisKQhQ5gzJvOUmvMzv
	7MqwawBfPwOwAbIHL5AfDlJYwqBlAlowPvix2G9sunW6vlwMfVS6LwjMoIN4SgbVgeKkmaNK45b
	BbSdZM8Ulawx4cJknVs9x1LCfe/ii83BaFhKymdrzU5Fh404QBoe7lR1qkks7C/eQ99FF+t+qAx
	9VM/yojsRYl1M7YoLdguCqyehMYMCApja29qNdM5cD22XsIV8v2Q==
X-Received: by 2002:a17:90b:440c:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-39dec137c0emr7955486a91.3.1789450757965; Mon, 14 Sep 2026
 22:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789420324.git.pgovind2@uci.edu> <f515b62bb05e7b6bf0bb06c8fdb362486fea25a8.1789420324.git.pgovind2@uci.edu>
In-Reply-To: <f515b62bb05e7b6bf0bb06c8fdb362486fea25a8.1789420324.git.pgovind2@uci.edu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Sep 2026 07:39:05 +0200
X-Gm-Features: AcwNN1VLEVsnNcc7MgH6GABS_6vDgssPHdlXmRPoVWKppjYFE36L4oSTNOtsqVY
Message-ID: <CANiq72=jRupLtnQSnAewyZZC7q4-oeAVmA=SfBGN+z_nefsnvQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: block: Fix unsoundness in `Operations::queue_rq`
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: a.hindborg@kernel.org, boqun@kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu, 
	dzueck@uci.edu, 
	"linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:47=E2=80=AFPM Priya Bala Govindasamy
<pgovind2@uci.edu> wrote:
>
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")

Should this have Cc: stable?

> Assisted-by: ChatGPT:gpt-5.6-sol

Nowadays, it is enough to say "Assisted-by: LLM" (the rules recently change=
d).

> Signed-off-by: Priya Bala Govindasamy<pgovind2@uci.edu>

The tags seem to be missing a space before `<`.

Cc'ing the linux-block list too (please see the `MAINTAINERS` file).

Finally, it is usually nice to provide a simple example when possible
of the safe code that triggers the issue.

> +    /// # Safety
> +    ///
> +    /// The implementor of this method must ensure that if Err is return=
ed:
> +    /// - The request has not already been completed.
> +    /// - No ARef derived from the request remains anywhere.
> +    /// - No reference was converted to raw or transferred to another th=
read.
> +    unsafe fn queue_rq(

The `# Safety` section is about the preconditions for callers, not for
implementers of the trait -- this should likely be on the trait.
Should this method be `unsafe fn` then? Did you build with `CLIPPY=3D1`?

Also, please add intra-doc links where possible, and please see
Sashiko's output too.

Thanks!

Cheers,
Miguel
