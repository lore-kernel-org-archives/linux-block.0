Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A31B654C;
	Tue, 22 Oct 2024 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621092; cv=none; b=Jc223zextcD0e3OMjza6tc7ebIB2CpNKVOBI40jsIPWf/dfQa+KKmbhe8EH3wxrltVFD7apJrf9sXdB1Y36CdMIOeljVk4y+E1U2u5PzghrZBlZeXBfUDcpWGl81yZaRYkINRCdK/ZGhAYS4brpu4FGYPHCV0pPS3vXEcxjBB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621092; c=relaxed/simple;
	bh=I0ncawAsRIQf7yHcV9v6YkDdfdA0KSVBzsz9dvhzBRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grqiWYqEmYzAfWVNRx7Y3q7HxqKOCiMbGsGGO67uR2hPr74x/J6HyeaeDN7syWgL8BcRBcQfsQQoGiM1K5ctpt16EAd2KR9Ds7DN+VlaM8I9leEE2ONFVhizmJ9dVTZcK1AUuw/AUiQD0PdknQcXMCSgTYbRILvSlrqqrGvt36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/KSRryU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/KSRryU"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e5b1aaad96so461731a91.0;
        Tue, 22 Oct 2024 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729621091; x=1730225891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0ncawAsRIQf7yHcV9v6YkDdfdA0KSVBzsz9dvhzBRc=;
        b=V/KSRryUz+QQ13y64UnMMKiXElMxDpVNBD8cwclaFdV2ltDF7y7t9kr6wXmvbskK8F
         7NXpw9H43hcWyxXQfA2prt9RCBO7f8QnVOArmGebGQislwx79V6rm3PHwcqpNGSnLmW3
         /dhtf1FLy3kyPa4wLbSdHHn8LwAisC7wYaL+AfwmrFZsCzJs+gbmB90FmodCAbWGF4fp
         CSbMtupvgVyMOo5gjdxwdR3k+kP+aQuSPLIweV02k35wLwCIGJmu0+Dx6M24/sFt/6lI
         0L89hTlVnzq6+BDfLbiJA0HiuIDnJoNFpkzgtjOHJD2RR///V9cPCERuLVQlFlys+IuF
         kpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729621091; x=1730225891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0ncawAsRIQf7yHcV9v6YkDdfdA0KSVBzsz9dvhzBRc=;
        b=SjFqbrc/TfGFAYNE/EFgMl/7ceKny1hNhxzzGEARHBu8DM8Jst1hIORNSeL/kH5A1t
         ZZ/GtsaCQ2s7mXbDWS3ZV9b/AmX5ZlkuQghMjpd6+I84+HVG0kSmcHpLKXo0b0I/Ehag
         Wjw4SKJCP7t8OcaPicHm8zNeizHCX9WUKHAntaaSzfdBPVkcM0A6pidb8OeezFJ4AShk
         r7F8e7+mMhdwqQWXPjMKyFSk2HBWojqyHK6r1TC/yydvcFlpjUkhbrBW5O5DI3DVicpN
         xy16U+w2YprWmc+Q4m0PWcpN3cU1scHOL0ZSMqJDqCrFYd2+YY9wfAS2zcBUr9oZdPdv
         eQvw==
X-Forwarded-Encrypted: i=1; AJvYcCU0vv6nxWl9/7xqOO0CPOlo/96YVokLAVR/frYqI4CrNxW93x0Bieg/lFgCkK6X4mDdfpxn7UYCG6G7Ug==@vger.kernel.org, AJvYcCUH/xrbjgVOjgvL3nC024O8S6CmWG/8+yk6AvOYuOUtV7bBHs5HBJJYCLOH/3/hglbyOQGwN5adAAxpkbrF@vger.kernel.org, AJvYcCUPTEkcky2SgPZm98TGcC22LummB9Gdus35JtSIW+XjhSxvjfDaFiqpjxOrXCjwaFO9n18lUzItnD9vy0DfZJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOchta/qQeu1/SuwIR2rlTy2mC2oCszdtbsMeJYWVu6C756JL
	7JCeclB6YCOZ2zQIzbQbctQeXaw8jm8OH6IiruyL+WXvSIyEyUEX86lNuzMFAVNyGcMBLIDieG6
	gA6PaIdfMC9jZXxrE1wwJu+Vp+2w=
X-Google-Smtp-Source: AGHT+IFWENN2kUGUgFc+5VTacL6qecqwBecLkdOpuyUli3hT8G3Ji+Ak3iOAwSoM5rIIKv/sUolih9Es/vjGtBlCg08=
X-Received: by 2002:a17:90b:148f:b0:2e3:1af7:6ead with SMTP id
 98e67ed59e1d1-2e5616e9f15mr7829383a91.5.1729621090802; Tue, 22 Oct 2024
 11:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903173027.16732-3-frazar00@gmail.com> <87cyk8mhlq.fsf@kernel.org>
In-Reply-To: <87cyk8mhlq.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Oct 2024 20:17:57 +0200
Message-ID: <CANiq72nYKH+UCQQ8mHTc1Z7Spinp9v9hrjLzVyWHXaoeSShQTw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: rust: fix formatting for kernel::block::mq::Request
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Francesco Zardi <frazar00@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Thanks for the patch!

Andreas/Jens: do you want me to pick this through `rust-next`?

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")

Thanks!

Cheers,
Miguel
