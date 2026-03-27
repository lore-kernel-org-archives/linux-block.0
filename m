Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272B43EB7F6
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621330; cv=pass; b=rRtlfLpHDlVNoaVLNBUFuss53xe3kUKI5l5I6/bojPSNr1/EVYbIoI3LsGs4vTecOEGiR799nvkR/3q3MZauBpJ1Gd+ZmqjuUEoo+E547tkPkdTB/MqLZhv74EKBniu47f6Iy6jgjCtFg2ncef3YoB5AgMvNJRSRqXv2O/rfedo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621330; c=relaxed/simple;
	bh=KTDK3vOxt1fIVdHhRs3HNHtD5rFi66H7oz+TrzUybAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTMBgq/lScUklGL6ex3mpQL9Ptt33CGqBXDsLIp5RXILeu7dz1W/isVSIbREPzQbbyuJXSlf4savevzTOAdZ+6rXBYTujs7HmUz20VsxEJWq1kSfSUaH06EzDRsNjMChBFLi1OYaZ7h/3fm7VXvu6UAVRZscryK7xPf5Xwd8P70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID41B3kO; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID41B3kO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso22600905e9.3
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 07:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621327; cv=none;
        d=google.com; s=arc-20240605;
        b=E0iuIQIzkVAKbHN9SmIlhBTvuwcddCVsovhmwAgdmjaWhnKWL6oOG8q+0oN2yTWxFW
         93s3T2nOlMrpOYxglmP50jqY0IFgP7uvL7agWlFLgIwVvBnFeJpASTXz7Ze27hNh6uw1
         JX9NMRUl5O6h0hYkbNqBvZMORPgHRjG3rYL0yYV5mrnNfjFYeazVWY3Qbxxl0AXAe3bV
         8D+FwnyDPkpskzRc1kyS5kWukzm3dgPqnY94dQ511KLZpUA3FrT46Vng/neHzcBDtHei
         HAIrwQd0MZ8zpn9uGdPX4JqBdsELKq85wRcd+FMiM4n1oeKwWbrN7jNZ0uj+e3vo9QtR
         JDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ms382mXmeMfyEZXo+JDpLmvuZwZ5tlyqI074nqlFpZI=;
        fh=EqVGw7aT/WG8pFSnNp0rpf1MDfY+h1IkZjWxJtveQxE=;
        b=dA3hhZoVrxGBuc5IU3mf99xfQsuij0aIRa9L242bhIchxiH8dKbL6pDp3LoEEN9wn+
         OtURcNl4wihsZ1OlzwAGRxqrWvzb92eP5QLg01/Si37d/Miptm85GiXR2Q3cdxTL/L0z
         Y3KIDF2Hr6Nbur4La9P9yuj0K5xCRKW0QeHy+HYWth4k52cZ+GgnBvUB+ck0BMV2rcVI
         Iwd7UBZxB+Zeoe+9Uk8AWhtMRWyuuopfwBGWhJuzO9mA7MdIJ8/+9+COOu3yFm7lr7Xn
         RPNffsH2i+0rvr6FgsxfCEk+rbcrUVhieRe4h5MfeKHF8A4sktpnUqFYkufO5AmtkuAZ
         mwAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774621327; x=1775226127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms382mXmeMfyEZXo+JDpLmvuZwZ5tlyqI074nqlFpZI=;
        b=ID41B3kOeFeMQf6qz/FF7kGQvO9qo9l1SDlO2Hs/teWIpjaa68X4pXuzQaSFe80yGy
         dZ5ZXKzqbZyFKx/32kPuei4PrzJ/xUqRAKHlezgiEfbEhZV7sbljVBNYafTUJ6U/jD/C
         KeyZNqycrLT0xHJYsQx+XDNPW1mytftFmTasne8vb9pC2/9sKj6Hur52fAn0ugDbTIOP
         MPajGDu/f8j+9wKwCT29dVsD8t7akE56tdEIPRqcIQSzS3B0zlZElbb4BUyuNxKYDPAT
         En6wgibJHr8IL8+CBWpiEBgV1WcYYklfOliek5xF0Hd7PNSjAMwn2UVDVqXZqbJoX7NV
         jhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621327; x=1775226127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ms382mXmeMfyEZXo+JDpLmvuZwZ5tlyqI074nqlFpZI=;
        b=HLd+fC17/xjTot/gwLio4QGEySgmHuBwEtyZnt2OUBBlNJK6o1YV4myYWie8VI40vd
         L3zczUuQ4VaBHdy1hgkblw2/kNR+V8dkIT6rhpmRjSXm6UEQRhzuXMI0DsC6E3NZur3e
         7ISpTI7YsZ7Nd6fudga4X4xAnPYdsU7s5iC36J8VaNWofuEd6oa+/V342aoCHkJ7ozLb
         4ZklvUH59O/D+cN0hYhynC2GBGLEwkxgLkNCvL2VTE9s3QsfAiQLU23ZS3PPljVgMMSl
         ggPS0PSHyvt3n/Rwr3s1ely+HUNkcD5JrtqmsYcAcSfpkea2bvH2IhWs90lVRaz/pr5O
         IgEw==
X-Forwarded-Encrypted: i=1; AJvYcCUPGj+lk8hsjgGEtAxBfD5NkZPs0KGAQdR+PoymexlnR5x62GtU6lGGxrUFSr+pBHwizhzHd1BcvT/O+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZaUMj3ZLjRWwsMcOv52xXHXXGfAE1is+19dvGTTM2qGIVm7c
	lTsm2gPQTEWW6GBbmXCB4+Pw/BzvJReDevuXc+1nDMIR9Zzra1lp30l+80L+043EWKyiU+Qr7aL
	TgklpW/uvo6OZZQ2jkrSo5pVKcit62dw=
X-Gm-Gg: ATEYQzzxLQeeST5Gwu/YxAQBdMZa1Hv+4OaoMVXMYaXktZuc4LJ2kmiu+TOuW1K905G
	y0pc2dg1H9tT/XgNN4SC0Uzig4tJlE53pYDygLjVlWAAvpx8SAxnQHZKfKkvaXDJe6iY6qO78HR
	0F3MRkzxd9DDqLqnEX8j/Asf2b0SHEyKkD5GkY6bLIsQzJ2sbsQrafQSn5EoOQ5uiMVEMM5nifM
	xT7wl090Je2Lm2KuJkl0ylcvexFdvTfQwiIw8HTW15qtFwqO5kJ0OZRNpdtY4jimayXzjM2WN+s
	ldFAPdKQJZh2ZeJ+UBjIKN+Dq5A4+jp/f8OkMuTv3yEB5IGUvG+adFTICteeQMC06Yv1FTv3qKz
	Mmz9BewWBdrxsEXMK0rfkDmKegw==
X-Received: by 2002:a05:600c:4f91:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-48727eda549mr46648885e9.17.1774621327165; Fri, 27 Mar 2026
 07:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327114741.91500-1-pilgrimtao@gmail.com> <20260327114741.91500-2-pilgrimtao@gmail.com>
In-Reply-To: <20260327114741.91500-2-pilgrimtao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 07:21:56 -0700
X-Gm-Features: AQROBzBIPfZAUsMrDB7LBzUtbbmaH79IMxVvd9bzKdqKC91ZGulsOHpJpWVa3Bc
Message-ID: <CAADnVQJizm+Y8_AE0rjJnBCrvNc+ThiWdbc-ZuUZqYTLtf=MOA@mail.gmail.com>
Subject: Re: [RFC 1/2] block: Introduce the UFQ I/O scheduler
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, pjw@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alex Ghiti <alex@ghiti.fr>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	tmgross@umich.edu, Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-block@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Kaitao Cheng <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 4:49=E2=80=AFAM Chengkaitao <pilgrimtao@gmail.com> =
wrote:
>
> +
> +__bpf_kfunc bool bpf_request_put(struct request *rq)
> +{
> +       if (req_ref_put_and_test(rq))
> +               return false;
> +
> +       return true;
> +}

...

> +BTF_ID_FLAGS(func, bpf_request_put)

I bet you knew this is not safe and despite that you still
decided to hack it this way.
This corner cutting is a red flag for this patchset and
your link list patches.
Since you got caught doing this you need to prove much harder
that you know what you're doing and there are no other safety issues.
