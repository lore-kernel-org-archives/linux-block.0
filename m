Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BD20E3;
	Tue,  3 Sep 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386227; cv=none; b=njBOQ2oO8Wx6EfyfPQbl8L9GFgXtFQlLtQ8P0R8aEX/1zava7yGI/jtYQv8KEExKqLypA1SnXT56bZTTgJFpmRGpybmzICFIvGw/LPAyG2KSYX5UQm85SWHJ5Ypq9QN5OPFlmXgcTRK1b88b3Dg8gdB3khFcxn3BwfRWBHPS4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386227; c=relaxed/simple;
	bh=t5Pvfhc9ofOfcldHQJ9u+ljAsffSZtYZTCoBxKuC0ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hqmh6VKbQA7rN0VEWknSYlTYdFFGZTUrri+zH656QfKeV3XnvI4PhPn97GRtU1LzqvGPCbyIMrSFuEM93ZgyF0n0YZ6lhKwYQrPzW2ex1wL9iCMl5W7TDxgCq8SqH/11lrLpGZOA4tKqHGmg5ERjMvxvuiihBWRztCBqjceRlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDtOvP3V; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDtOvP3V"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374b25263a3so2438213f8f.0;
        Tue, 03 Sep 2024 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725386224; x=1725991024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og7Qx78AsRkTiyheXWJhyRERbOVyeMXkKMDVEahcXL8=;
        b=RDtOvP3VbHzs/uLelgm2p/1albv/tLDn1LOq37dOMnCrkrLXAU2hDp8G00IMTNiJnv
         kSUvM7U93LX6mzZC6+Vux4y9f6J6AbNC+HyX1PZAiLwRDft/9USSAIUBOETwt8VQOjhW
         e5UDZMebEfJBLNehUTPvgZuhPQNP6xHfcMIarqQ5wMX8m7lWreqM5EJPClGibq0AmAUG
         YIk4Pwb/x46zq2CSzIr4FxgXqNv2W4And2QmnTU+9K/Y5pcDTkrLEEWimqeC/Zd6aav3
         ZIaeAveXvZjPmcdWURd63/Mv000/Fc+W8aW7biDLXSQlUhh4s7ULYT7BHJ96SOllgE6h
         c93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386224; x=1725991024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=og7Qx78AsRkTiyheXWJhyRERbOVyeMXkKMDVEahcXL8=;
        b=s4w6XYaDmCZJChfQriDQgzhjIW192F2TlSAGd+xtwDWXHC8PwRX+gzs761aQOwIfJj
         t7vstTKx1Pt31gmzF6DZyxiAeIetNsLTozWEnO3cipoZgVU7CwRxkIUNte/nqlKB4Z3/
         CHfSMsegjKFYMJ2z1F3hSIDk7uZrH+jZk+n2VYGNTNSCaxyAjH8A8N4P6XXvLlog6kaN
         R857dCAMQbe87iZ2dfT8iyc61x4GwWL9RdXHmipptFbpSxCpuTycxjTKyLObeylYRDyc
         U6eV0ktMQrO9qshFPZT/tdtOfvJGBw2ZXFxZ7QrSUDSnHEoj7KCSjBc1nJty3zDDC0RZ
         bf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOo8DNneInBOqsfl/7jE5RaB2EDOPSJtL3ZsBTVRvPJtwMEpG0Wj2LKcYF64yupG8YHRW7LHoAgrGY9g==@vger.kernel.org, AJvYcCXpETbYgzzxaE61e63Dkml+JkeC+V1MICVxr+4330GTPS0u6rGRYO0XMc+hRHiWIIC95V+eInOgPia/OkpG@vger.kernel.org, AJvYcCXxsD7DjE80QxMk2GfnHdBMWJjJuoOhnjpGetMdwFhv5VvaI08pxSob5GPzPGlsmPAH+vuRtoi7ZgENSXaiBkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytU4onQ5+0UKJomykCkuxuNTzM+w0C7QZBfMIRPuYvzjnFEibL
	uaElqbS1Xxhk8rdElYu9Mg+mFgiNIqjARSbsavyINJuXGPranojE9wgA0Jc0QzdcZ4+h0I0NL5n
	zF7AIH3x4+bX+216oKh77FRBBx3M=
X-Google-Smtp-Source: AGHT+IFFaAhnHajP0Mu1GUqtdTLzVqyC0SfkvkeA2JtuBR3rjDvsP/p5u50uEsrX+aF03C1Ksz8g5ZMS3FVGmFnjblk=
X-Received: by 2002:a05:6000:144e:b0:374:d2a3:9806 with SMTP id
 ffacd0b85a97d-374d2a3989cmr3996471f8f.2.1725386223195; Tue, 03 Sep 2024
 10:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902211553.103807-1-frazar00@gmail.com> <CANiq72naAHm81thntNdaEoq8rMVH0gVNAKB_Fd5dy2Eu1pk5mA@mail.gmail.com>
In-Reply-To: <CANiq72naAHm81thntNdaEoq8rMVH0gVNAKB_Fd5dy2Eu1pk5mA@mail.gmail.com>
From: Francesco Zardi <frazar00@gmail.com>
Date: Tue, 3 Sep 2024 19:56:51 +0200
Message-ID: <CABHx2S88vqMofg4sn=ybzxnKu9th-TSx3_iTVuVz6r=1rHuaXw@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: fix formatting for kernel::block::mq::Request
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:38=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Mon, Sep 2, 2024 at 11:16=E2=80=AFPM Francesco Zardi <frazar00@gmail.c=
om> wrote:
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1108
> >
> > Signed-off-by: Francesco Zardi <frazar00@gmail.com>
> > Suggested-by: Miguel Ojeda <ojeda@kernel.org>
>
> If we considered these a fix (I think at least for the first bullet
> point it makes sense to do so), these should probably be (in this
> order, and without blank newlines):
>
>     Reported-by:
>     Closes:
>     Signed-off-by:
>
> But depending on the maintainer they may do this without a v2 when
> picking it up -- it depends on what Andreas wants to do (it could go
> through Block or Rust).

Thank you very much Miguel for the very clear and quick feedback.

I will submit a v2 with the suggested fixes.

Regards,
Francesco
