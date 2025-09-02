Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEC2E4241
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811129; cv=none; b=OC1jodmEn99dC9dTtarPkds2eyymWlWIdq3vkbZn16DlTCU3zsmbLNw/Adk6xn/b4Y1hEMOSUptc94Nb/jkiGkGjWKCwDhBp1aP8XaUz7n8hMvETkaK8ilTzjNdQStQtXSuLSynKzSRKFmrUn+SiFXIIvGhhcD8s7p2j44rsSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811129; c=relaxed/simple;
	bh=JNhLbkrTSSYl1O0oaQX9iodNALQo/R7RSOEwFYkJ1XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBCcH8oXKqsfu5tHaptzS8CXkFzuFLE2u3OH/eYt4mUrs1VfdG1F0jhJNO2ST5t5qz9A23+swBYO5V4eim8mbRuXeI+uipIWinNpVpip0UHwh3LAW+zCH7NAUXZPUC5iWs+X0rr8sLNI42V+EsRBKdQXYriEqMPIdfqc1C3waKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wIz+/tyL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIz+/tyL"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3cf991e8c82so2745901f8f.3
        for <linux-block@vger.kernel.org>; Tue, 02 Sep 2025 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756811127; x=1757415927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNhLbkrTSSYl1O0oaQX9iodNALQo/R7RSOEwFYkJ1XE=;
        b=wIz+/tyLynWinX07cShV7AOfQnG8aytx5+sMI58P1ASrqbRxI+mFfY24XkTovyYHA2
         6YN/vwkUVbwqU9RS/EQf5eNtsGct8grrdxMWIdJHvnxrhqpBbRwgWaZB7hn0+Rma7MnW
         CNnlGtrp1daRKOVvD88Ea668GdTjchMSslmoX0ZK/upxEu3Fmno4CvRoYXVNByJpOIxg
         5UA689tnYpt1rMJ/BV+tUrHaCnKS0da9ogrD1CMXWHm2x517kQu5rRjyaZyvjWcnU2R7
         grOM1lZNC1NadSCu2V7zQNWWUF8k27YP8e3VVvyHFuS2g4uP8i/So2q8B/lXgGIFs62a
         lyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756811127; x=1757415927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNhLbkrTSSYl1O0oaQX9iodNALQo/R7RSOEwFYkJ1XE=;
        b=in7DlAz5n8xKA2wBnnb+gxNxMDie+/4jc9K7uL7AmoffBUC8UfbF+wav4WVGoVydYl
         zoAL/r0Z6FcSYIs7Ox2uDZZMzyOxJIhzZ71LrN4+TLdBV84qUQLfOlXIqPCdBlZilWdD
         z+JzUvFwUPYtsc/smlh21f+bZtEAjBxGzsnZ3iRbDvFLZv/eJAPcAMYclFAGzcCD90rP
         9ymbjkHtGtCChTgPYVEzd4zO0H+ranfPXED9DXGWq4weEyV2fyd1f7YsVnV5O+H4GHBe
         UWMzAxrHBX8D5mT5IF6p0PCbuOlPPmCrv3v8D1SvphO9++/sndzIJjpw6L5zFeOj28aX
         uWlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWUXRK6OP90Y5ORguQU74OwITiYmA8L4H5uqYDzTDIs9bmj9LY6C7k1QarigUpX0NJNta1VIjUTcLI7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyelVMgksJXLGwBmvVYOX7yp/EMRIvZY+nCa71QPIf6iKSrCXTx
	3BBTMNihGD+MoiBRWGUJdPU3PbTPTwYbrvTUpIDen8u21SP8ldv+VXpB4P/VFbXCcN1aW+iWmFn
	ZI0uBrVdgh6/7fPrceznVF+RW2k6ZlNlAl3ZJ8VyJ
X-Gm-Gg: ASbGncuNizlgqebwPeC0vjFF330V48evCfOqQGF3xpPmxFbL1htVgo2tF3t9YJRpBId
	uO9yMoYi9LchardIFmA51Z/fJMVAAIaBn33aEYfMFC/9Hp/L7Wlc80I6ZBAZtZG46aSaZQbIg0S
	6wG/8jCEdNSyuCPGic6AbB5GKyzZv4BRKKcWmO+A6j3d2KIqGB6Zszv8dbC3VF1qu2uR0kNR78r
	VaAml6Cn43fZYwbc9m0ZHkByDRUqbj++h4z2EMHTCU+97PtAHijyhZC+HJd1CrhjAKzJJLMi621
	j10OUh8T12U=
X-Google-Smtp-Source: AGHT+IEir5U2skpXGJOKBLRo8SShEmmKbmwKkr6fi+yT+rQfVyO6HXi3h1QxrXMkv1T7lG1XS1yx0dP3rkpZMldBUX4=
X-Received: by 2002:a05:6000:268a:b0:3d4:2f8c:1d37 with SMTP id
 ffacd0b85a97d-3d42f8c2014mr7963608f8f.26.1756811126368; Tue, 02 Sep 2025
 04:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org> <20250902-rnull-up-v6-16-v7-5-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-5-b5212cc89b98@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 2 Sep 2025 13:05:14 +0200
X-Gm-Features: Ac12FXy-xKi1uby6tg12v55n-9aLUomtRzJeW72bbKsP_0DXTmIVIHyqBwAX6YA
Message-ID: <CAH5fLghbUMBqFEEe+xMyucBuwVg_N=fWjCiG+5+wzUzGFHQEYw@mail.gmail.com>
Subject: Re: [PATCH v7 05/17] rust: str: introduce `kstrtobool` function
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:56=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Add a Rust wrapper for the kernel's `kstrtobool` function that converts
> common user inputs into boolean values.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
