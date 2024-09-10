Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6F23A6;
	Tue, 10 Sep 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966664; cv=none; b=uf3m3L+Qrh52Tzh67WJI9V9zlaZLlW+GlRcV1DjUS5eP8urEyc76Ca4auSx933fBlJBgYus4Wf2hMfN/z7ULxcc3AWl8peQYQTRNXM0ROodECL+cGPR/t6KVweqzO67qsxXhrNnEx+kGotLG8EvPBUDNNt2sw9KNFi+kp3KCCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966664; c=relaxed/simple;
	bh=mfiXV5VkycZzLh5WzQn4rnkI9+MIwHzFuvfRTNj7tMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnyoY54eDSVHtK7iKGH0vEklYBx1o0lZNzM5Xak1guIxoaAwXYbdNqT4eCESatonbUjCvps00lagMo/nnPrNiGS0XgdAGA+Msnodce8JUInBPJODqLaX3iPDhO13XuAVNgxoWVMXGFE1dI08D+LAMt4JD+YcBjNyZtSL5haMfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWg0wCBk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWg0wCBk"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2da5acb95d2so592495a91.0;
        Tue, 10 Sep 2024 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725966662; x=1726571462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYKGK8TlpjrzAn8Qx07BmWTI1YCZDMMMQixpsjlqW1s=;
        b=GWg0wCBkMYEKntwGO6BlL9VZZtXPSY6b7ftZPMiGJA52uR20vIzBCmJF00hhB9amA1
         gkc86r0ThrtwrDlwI3KLr2WgVjDYOnwp9Az9aOrimLtSp0Po7WaLLjGG5P4mhqgGbgV0
         6tM2DlsfSr+fGLcQpl3YIS/SdNv1Pg4EwWI4wAW6mTrxRqMCLlgOHBT8BTnjuw3zS5H8
         R04KeRrS9fm+NlwzNPhfsy44YKCnPfptpDwpygoetdpSNFKvuzy9mhpBMb5nBM464SSB
         sLciQE6mO6UGFKTFDWNBZSl6J38aTogHbUoPjYxapiGSbVZu03RWzvT75cCzI5Pum/VB
         5MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725966662; x=1726571462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYKGK8TlpjrzAn8Qx07BmWTI1YCZDMMMQixpsjlqW1s=;
        b=niXX+5/r+7dpq1euPwb3i7IK3E0a7Wb9tvZ6hitvU2asKyUO6pperynDaQjCLil2YA
         U9G/u+87Ootk5WqLSPRoD2wUqAcUb12pyHg0JM2CScsSfgmatTNQ28NWnmf8Cfy/bQof
         7nkVz+ZWShfHEzB76F24wHsx+IO2YrlBNcsZBIVv8ySjMBc9JbD8QrAgK8EwsUntC3B3
         buY8kJmR1Or6rO1yrFa79XaqThdz0z5Vnoyd1MpTNnADUJHHxQymf3EhCUHzoCF/Uz/w
         LAtW69kDhmcI+k/uGn5z6TgDQ/D+aBCZi9r751lrcGZMgIlaUwQI/VMbsjN2Mip7JIFl
         XUmA==
X-Forwarded-Encrypted: i=1; AJvYcCX7QWdrGYOcE02TjkRX1GThLvSJT3OIE7D/SHUym+FSqw0H1f9qFJ+RP0UPC+JGK0iCu4EHbRfqgrqVGycK5xo=@vger.kernel.org, AJvYcCXak+goX9ue7oix5qPVPOH8U/r3OkAHQpbzgTk4fI0i+JRXqsNrmtOOX06QE7aJi5N3ROfraU0TCZQ5m8D6@vger.kernel.org, AJvYcCXtqa6qWx3XNRn/yVQL3rRLvNPny8pcCS/IJxemque8fc8jGb5BRg9sAiYUwc4Yxu5X8GLJLio9T6gJ+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCgRjbTkE7QgUZPpWXxKYK6mQGhqX+klp14UPBfaqLGOjUyyk
	2lJx2wdCcPwq9yBMuizOQ7f2ZspBgP0PysOZ58Xf81eeRc5XEWtVPjZyV0t8Z4n7TqeZ+mwia8Y
	OwuSFI3d4psGPqQWQV0LqUjo5ck8=
X-Google-Smtp-Source: AGHT+IGTP7qFuht9HhfJ+QlqfAYIP5x3WmnewAO7zBOyxe4uOgNrc2C1vsv8OIIU/CXsqoYzPBg7fdhdiHhG1MKL4Fo=
X-Received: by 2002:a17:90b:4d8c:b0:2db:60b:697f with SMTP id
 98e67ed59e1d1-2db060b69a2mr4561126a91.9.1725966662445; Tue, 10 Sep 2024
 04:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909161749.147076-1-hridesh699@gmail.com> <7b98dbcc-318d-49e7-b71a-f64cc611c2ad@proton.me>
In-Reply-To: <7b98dbcc-318d-49e7-b71a-f64cc611c2ad@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Sep 2024 13:10:50 +0200
Message-ID: <CANiq72mS6_PCqfhTtKvAgE=S8gSj44_v9kG3AK_txxdsMo0PdQ@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: clean up empty `\\\` lines and improve
 rustdoc formatting
To: Benno Lossin <benno.lossin@proton.me>
Cc: hridesh <hridesh699@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Matt Gilbride <mattgilbride@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 9:22=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> I don't know if the commit title should start with `docs`, maybe we want
> to do `rust: docs` when changing rustdocs? (This is a question to the
> other Rust reviewers)
>
> I think the title doesn't need to mention the exact cleanup, just
> something along the lines "clean up docs" should suffice.

Yeah, "docs" would be better for Documentation/ bits.

I think something like this would be ideal:

   rust: kernel: clean up empty `\\\` lines

> Instead of adding these backslashes, I personally would prefer if we

Yeah, we have another patch on the list for that, so I would remove it
from this one.

Thanks!

Cheers,
Miguel
