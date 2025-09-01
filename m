Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B8A2FAC0E
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715669; cv=none; b=jPjRMvuYZdpeVn/vIJHtFVVm+dCq4ilHwqpA1VS8wbOlIvEpABZfOY8nkxDK/zuYx8HMkJOXzwh3bs8Y1+y2TqLKYXVxjzb2l3F71WXF4+Fw1i7BUrbncNHHhftrzTzc2IKd5Eftg4L4HggNCjwdlD2ji9rxu28HYxwwCKPzDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715669; c=relaxed/simple;
	bh=vxf3frNnb2xUAvh4qiTlt/x1zHJJCkVQHi/Jb4XzkLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVRBSeL0hw5VYlyOW4cguD1vaYFW2w13C0ZjvzqGi25CEh/EPNmVQp9SSvhLZS3UVrBC7WhdM7mU6ClCVqJQdGUiCmQKVRcPl+W+IZmwlxZfXZb3x7Bgy6TdjrA+zgJE0Lt+HcAZ03SSNVfqAyjHS6rJkYf6CCFm6tqdJ2zWLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1MM2tS+T; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1MM2tS+T"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso935098f8f.0
        for <linux-block@vger.kernel.org>; Mon, 01 Sep 2025 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756715666; x=1757320466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJq1AsV0F4VVQPu0qkVK0I8t0NKOlj0yZgOhHKRTknE=;
        b=1MM2tS+Tl9lcIqjdUjaD/UMGFkL1wZRQSdH8k8psKyGvLLN0t3PcFCgr25htJKyGkx
         dkFmiGSzERO+Qpkv6lgSS0ChGJxo2GIM36CPaDmUEYDTCqtyy64Dbr182BDOr9ucIKus
         DAuYIdW7ht69ESIm3kI+NLwubmGbLBhOssEvARK5jId3mPyhPD++8OL96AL5OnYZW+ww
         W/gPKUXfL4fLn6lReGh0ZCrf0KiUD6HplKe03/GNNc+faiNzF5JHGVl/9EKRPr0M6pG2
         0fCKnP2by7rFpkvuwjVyew+3FyMikD6iAgUinORy40IlHB+CFDtOJKhvobxCjWU2Qlb0
         DxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715666; x=1757320466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJq1AsV0F4VVQPu0qkVK0I8t0NKOlj0yZgOhHKRTknE=;
        b=vz5+Ae2XB8eJXYdXA/QNyOrw3ktpRod5nnhOxRf8fuTQh9qd4jtfg1j5SXm0xSEK2U
         WBrE+FuCVayj6HOX/c2Z2fGowrAZ9J266uZmaO+fw3AawNkDsgyWgg1/Qs17QOvqgv51
         aZ2xmfmFeglXl2xLLvpxr+dXb3XMDB605QCjtUSMhg1lP3us3qcLXIBNJrXkX+Xnoa8J
         0SU68IyI7BB1DJ1LdFOS9NfH82wta4BpfUHSix7kAlNp2WmxJOmUWsBk72Cwa69NAKmX
         XdfqrRdDS2yVtkzPtcpXVPnFAItaSj66XphSLE+EhIxqYHSfEYP2bmiO1oq4NZhTvmbU
         ezxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6QjFhb9fbndDk7JUlm9djov9jVgYyWCN1blCBQTEQuAvjaSlqOZeT7ayiUzXEJwpdvqkFu2bkOVK5Lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0JlwzpmMld2UBeCL5JUzpenBVPmDP+QKGSJZ+ru+L1sE8b9Y
	bpPB/ZbSdAbYbysWzbvvhqw0UA5D/HR+p/KGeyieA+92KVWrYlB7HYG41gH1MWK0RwFJLKmM6TM
	KFVmjQbR/CB+B2oRc6dWrDj0KHjfCuHvF8stFEfnn
X-Gm-Gg: ASbGnctIB7+ifxRsA7gYn4TQWoeYcDoMaL8hq1F99ip8duvhxuDYrCrdwnuebL31hGZ
	j6fXP9nN0f/8D3mLwUipXtHlt4dtf1D9WuxZ4el979NZSTvGeZKO/tCDVpZuzmftA6w1/MeL3VG
	u+Tnd7w5uHWeVpAZlpteTlT0Vnf6w6fmaMcPwCPKu7nruxBw8FDp2m7szvgobFQbt5OYQthKfmB
	TMQ9t55Jbmz/205bH3BlcBr3yNE+/+Y40eTZr7lq0eRFLep9JKgrGOxWCXdYGaoRvNexfAkqsL+
	zpr4i58ZX18=
X-Google-Smtp-Source: AGHT+IEqychM0kd4Zsw2vuepz+apqlzQMNpjvyb9uiC43q/iOeK6qyzAvN4IB2lZ5WRji1lUoq2GIIj530u75dtTQ04=
X-Received: by 2002:a05:6000:2f87:b0:3d4:d572:b8e7 with SMTP id
 ffacd0b85a97d-3d4d5820341mr4043412f8f.13.1756715665708; Mon, 01 Sep 2025
 01:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org> <20250822-rnull-up-v6-16-v6-6-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-6-ec65006e2f07@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 1 Sep 2025 10:34:12 +0200
X-Gm-Features: Ac12FXxdTlByQ2-9hQCbGi5H1XEmMHIWRiWw8FW5DNBM2QeOGAEX-3c-DXqMpN8
Message-ID: <CAH5fLgiHVoOSMDwnXDZ5tH58iTPre_BAu0AE5=0a0_P6B4j_Kg@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] rust: str: add `bytes_to_bool` helper function
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:15=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Add a convenience function to convert byte slices to boolean values by
> wrapping them in a null-terminated C string and delegating to the
> existing `kstrtobool` function. Only considers the first two bytes of
> the input slice, following the kernel's boolean parsing semantics.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

One nit below, but generally looks good.
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +/// # Safety
> +///
> +/// - `string` must point to a null terminated string that is valid for =
read.
> +unsafe fn kstrtobool_raw(string: *const u8) -> Result<bool> {
> +    let mut result: bool =3D false;
> +
> +    // SAFETY:
> +    // - By function safety requirement, `string` is a valid null-termin=
ated string.
> +    // - `result` is a valid `bool` that we own.
> +    let ret =3D unsafe { bindings::kstrtobool(string, &mut result) };
> +
> +    kernel::error::to_result(ret).map(|()| result)

I think this is easier to read as:

to_result(unsafe { bindings::kstrtobool(string, &mut result) })?;
Ok(result)

Alice
