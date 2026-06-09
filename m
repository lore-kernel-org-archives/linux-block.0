Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D136331EC5
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=169.235.156.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041533; cv=pass; b=LxCDrXeH8YuCiQWshxOWNWdvOQEBvZFv6m8wgQTuav3i94UkpRK3mHwVFMqAZOSi1+b9ZRd0gbrevZA23z4Q4RVS40GMW5iLWaZfw27LmAJYvC3+yIU3dIHRsaHydqG0EVRF2r3FCi36ETtd4uMuVJ4Gv8lZ1cXgzL34UN8xO8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041533; c=relaxed/simple;
	bh=sg3v6ccMS3XaIU2NZ7UniX1AbZwcjXhCTJATNCR3JM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfQMEp2+Pk4cN/ZJLmnIZPcbOnfiWdR51rylo04gWY0JyGLNpnz+FDlQllsGb4eejhT6rAn7DZEncI7FbC3Sz/Gew4qEueXaqiIdiQa+6Jht0my63WKZr3dn+VVsgXRzOlwd+HF9D3wQFqf0BpF6XB/HV3/7sviJ55X8x97NKJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=LWzf+9MO; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=fX0bZwqY; arc=pass smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="LWzf+9MO";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="fX0bZwqY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1781041532; x=1812577532;
  h=arc-seal:arc-message-signature:
   arc-authentication-results:dkim-signature:
   x-google-dkim-signature:x-forwarded-encrypted:
   x-gm-message-state:x-gm-gg:mime-version:references:
   in-reply-to:from:date:x-gm-features:message-id:subject:to:
   cc:content-type:content-transfer-encoding:
   x-cse-connectionguid:x-cse-msgguid;
  bh=sg3v6ccMS3XaIU2NZ7UniX1AbZwcjXhCTJATNCR3JM8=;
  b=LWzf+9MOUJEMr5cwtPDVPVqB4MlakdHX+6cAO1oCzPJy5iSng0EvPdra
   O0MklSiDvvi1/k8muva+PCOUGHE1tllsYJ0kdRJ760bHlMA7pYwImH5eP
   zuKYYkDxEwRjXyf8aTLoqOAXPfuKe721dqnUyElewmPxw4TaICRxzsKXd
   UIqgnvCRE78mwTF9gGnziTpDKXzi+zYhL1st9TP51YQcKEA9UvvCuajOL
   dY/mqvUgW0MuW5cMc1X58/Scx9ugQtM/NQV/hAbVX++0tjCd8xpOh4sUR
   ieqrPEIJfUzeoHmgiTDjfGfyRdGnE619YbY1GaOqTtUB0HKwXYLkHRIGJ
   g==;
X-CSE-ConnectionGUID: w1HBd8l3TJOPabLeaotKZw==
X-CSE-MsgGUID: ic4ZSWxTRK2FU3cj2GvzBQ==
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 14:45:25 -0700
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5aa61a298a6so4111962e87.1
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 14:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781041524; cv=none;
        d=google.com; s=arc-20240605;
        b=db7LqqjSfx5otfIsrYaoKDZkk8oibKqnPaHziP6DZtkWj5vff5GP2FNi8dCwiMeLJV
         rve6SAiuNdclV/BUb7mpMxKFT5to7HoCZo8FN5NJjjfmOmmLa1cBkIlwsrNn1cYxLNoZ
         nIUbWrpaVdJHmU7mDT6AfiawUlyvQFcIhRabjdSN/NxNikQNk7kDqWLGuq639vRHh9Hp
         vAklpDAUinMIuOmP3dVwB09HNYOed63MwJnrJeAJyc3fIAB1GOIyUb7GwcH0g3EUjThs
         HGzyI5vqUuUmEgG0eYFfvka21kQ6+1bmGEAfLfnX+Z08qmWAxKJcmUAFHJ5jQqNxp5N7
         k2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cc2pubclTH5XFLkn1JbAg5pIqAsoToCze6/lWOdOZ14=;
        fh=x67JqA51tcmHC6lHQA2pQPqaUI/cYrzRvcRrVVEV5Go=;
        b=HiwVTt/QDTC6F5+S7TeENODiHIDBttzjjPkwe5W6E4O2WgTOpdikDA1jCpw9aopouL
         7Uauk6ZQt4v/kyE6JresukgRVF/UjfFySVMC/7wOZ0/CC1ABgsR9zHh+BjtoTR9HJVOy
         NMGnPdZWJYOp08jU/tvbQ5CMNB0lb1aBCOyQT+b2Z/ZxQC6noV2ni2h/qP0Ze2Ubfa1g
         vCq4iKE6w6nBfw1lFz5qj8lMQm84cTVTiuDxQOE4B2XcQnolvvT3V1I8kPBUovTfJazN
         +OMewejfYzC6pC/d5SrGkrKkue9BR+SigZfwlh4iwzyTuhTRZLoV3pSH6HxBkB1u0M8Q
         iphQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1781041524; x=1781646324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc2pubclTH5XFLkn1JbAg5pIqAsoToCze6/lWOdOZ14=;
        b=fX0bZwqYGOZ9gYRYPdUm7wo1epnPDAKNNiJOE+4WZceLWjeSmPC/l38kkh4Yb00jJx
         gV8WY783K8x7THteMbGSApenutW2DPAS9RvegL56FnbL8MKSzJrRJB2O2+wVildhPFJi
         l5zgpYIYv046ujwatc9RKpA4Wsz51Ewelb45E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041524; x=1781646324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cc2pubclTH5XFLkn1JbAg5pIqAsoToCze6/lWOdOZ14=;
        b=B5Q8cCDlxODxpMo0Ow7AlL90eG8AjZPNG6E8yCHctumN7pYZSj5akMQGuPBBz7ZqmV
         PVufebBWw7eoYSq0tjfkr8LAOXFeQO+pCTJEtr3jNyqTqO25HBRH1k6c/0uIBE9CSAlD
         CPnS7Dvtpdq2DtYZON5+iLXBPOLJlRbyZNmRVQK5QDkOAAty8YrT7CnkUPxf3qjSW2B3
         NyoDu9z2yZuRGn0bF2iVFoUgiaggoPvKRpv+OlF5M7KgZj2d22bxn/47vEeEHjkL8tHl
         XbenC7hAY3H9rmw0UOaxd5c+s74szRUNqKWZKwr6JSjJ3MGhefhrJrP4Bo/VhbObX2sT
         RDuA==
X-Forwarded-Encrypted: i=1; AFNElJ+nZ8TDKXzPxZokfH2BRBD03KzXwfM2HmbT1FUj+kQU393XU3EqshYm+LoFKPAi9m3Jq8B4BxTFsENovQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpRt/cA3tukn4v0uhWOY0i/9OQDnNkb1dV4R/XQM45d60DBNj
	usnrwi6yCabn2lgmI4Sciikglfsagmyc3kF+WExv6xGnD/Ufo/KqCebaO8u2W7kDZs9pg1kZQ5D
	PQHKV+YTRKX3PrTcVXs0DjrP6anfWrlNjBrhJGtoqC5ak7dErnUZQXJWuUrSmgTe/f+CXkrmYZf
	siaY2QRkExLnhur1zjbEtFo/X0+cUjd9mLJU+eqE8K
X-Gm-Gg: Acq92OEYXkYwB2VbBqvYe6oFFmOPWOhkt7YxDbF2sHoBEcLEvb7n+x3fb1YSAyZmrH4
	LATWgmcRW9ffA4FkWBe8ejk8tEMDEjxuCYb2NJgw/tJYAyVnZ9RS7GFv15SoTryPmN9OAdS82Iu
	qRNWZUs9md32Cc5C6siTIlMM3K2a90BePhaIDy6EOnhtsSJyknw+7GWUrkLuGq9TvpaR0fyjZwS
	OzUW5rrm8s+6kD3EylV3CqZ75lfuJKNxL0qve1VBf44eb0VvQ==
X-Received: by 2002:a05:6512:1285:b0:5aa:5e22:5add with SMTP id 2adb3069b0e04-5aa879ed345mr6613381e87.0.1781041523842;
        Tue, 09 Jun 2026 14:45:23 -0700 (PDT)
X-Received: by 2002:a05:6512:1285:b0:5aa:5e22:5add with SMTP id
 2adb3069b0e04-5aa879ed345mr6613371e87.0.1781041523427; Tue, 09 Jun 2026
 14:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org> <20260609-rnull-v6-19-rc5-send-v2-1-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-1-82c7404542e2@kernel.org>
From: Yuan Tan <ytan089@ucr.edu>
Date: Tue, 9 Jun 2026 14:45:00 -0700
X-Gm-Features: AVVi8Cc7l3HzAy2Yt2xtgg6-CDVD_domuZQHBShLKIw1SGPTFaAMN-OeImdTFrE
Message-ID: <CABrc2FU9HuRp4tVEU_R1RdMMRkkS=tM4Uv70WG3UBTeho_C42Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/83] block: rust: fix `Send` bound for `GenDisk`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Priya Bala Govindasamy <pgovind2@uci.edu>, 
	Dylan Zueck <dzueck@uci.edu>, Yuan Tan <ytan089@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 12:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> The `Send` implementation for `GenDisk<T>` was conditioned on `T: Send`.
> This constrains the wrong type. `T` is the `Operations` implementation,
> which is typically a zero-sized marker type that carries no data, so `T:
> Send` says nothing about whether the data a `GenDisk` actually owns can b=
e
> moved to another thread.
>
> A `GenDisk<T>` owns the queue data `T::QueueData` (stored as the
> `gendisk`'s `queuedata` and dropped when the `GenDisk` is dropped) and an
> `Arc<TagSet<T>>`. These are the values transferred when a `GenDisk` is se=
nt
> across a thread boundary, so the `Send` bound must constrain exactly them=
.
> Bound `T::QueueData: Send` and `Arc<TagSet<T>>: Send` instead.
>
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> Suggested-by: Yuan Tan <ytan089@ucr.edu>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>
> Please take patch from Yuan instead of this one, if they send a fixed
> version [1].
>
> [1] https://lore.kernel.org/r/8839ddc5ff54bf454d508cde91d27d00fc3e2dd8.17=
80633578.git.ytan089@ucr.edu

My last email mistakenly enabled html. So I am here to resend it. Hope
it doesn't disturb anyone.

Sorry, I've been busy with other things and haven't had the chance to
send the fixed version.

Thank you very much for reviewing the patch and for preparing the v2 versio=
n.

Could you please add the following when applying this patch?
Reported-by: Priya Bala Govindasamy <pgovind2@uci.edu>
Reported-by: Dylan Zueck <dzueck@uci.edu>

I didn't discover this issue myself. I just helped write the patch and
I don't want them to lose their credit for it.

Please let me know if you would prefer that I send a v3 instead.


> ---
>  rust/kernel/block/mq/gen_disk.rs | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_=
disk.rs
> index 912cb805caf5..b36d24382cc3 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -199,8 +199,14 @@ pub struct GenDisk<T: Operations> {
>  }
>
>  // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `A=
rc` to a
> -// `TagSet` It is safe to send this to other threads as long as T is Sen=
d.
> -unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
> +// `TagSet`. It is safe to send this to other threads as long as these t=
wo are `Send`.
> +unsafe impl<T> Send for GenDisk<T>
> +where
> +    T: Operations,
> +    T::QueueData: Send,
> +    Arc<TagSet<T>>: Send,
> +{
> +}
>
>  impl<T: Operations> Drop for GenDisk<T> {
>      fn drop(&mut self) {
>
> --
> 2.51.2
>
>
