Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C703198E70;
	Tue, 22 Oct 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636309; cv=none; b=Q6blpuOxr2iRUrgvRzA+grFR7cuyha5pqOdvc75pzMqwGfRbvjkPS8sS8FmX3VqsIIEVPvTtL2UOtLSTuLIiIpAALF6ZfSIy6ZQmDUpwlBUdQ6Phr/muWZJ0uZia7ccbObxcLXAgq4GODP2oibblXx55T/Dp9edgoU1UINBwoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636309; c=relaxed/simple;
	bh=ocjuPZBQcm/gWoqJic+qab9ral+ThqVee195AQgsKkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0s9kgw4zIiFs/ieqIukrm3srVm3rWuO8PzkXfIJ5sHucYVx1WX8V6T5DGNM2RLnuI5rG4kBZZCBnCAXv2cgTGYnGX1y4dz7RtislWwk4Pw1Acp8fJ7uQvUV0Z09hiMYGQV3IMekFvZVZEHluiPQbUOpjNQPCrwQZNLI4VbSVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R34GQA+3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R34GQA+3"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2b71fd16fso997596a91.3;
        Tue, 22 Oct 2024 15:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729636307; x=1730241107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBpv4lygubL36e25IlDlHYVhQfEMD1LpJ9xSKfCH59o=;
        b=R34GQA+3L3iLgJl+SPKzLE5nuB/g6u250oBm+Y33x7MyP4FAfoePGRfGnNkY8bnBx6
         L0kEKBxYspnkWfQJcwMqDEYHDhNsncXhIHZCSTFj6TpbQLylsEgH41zb/WkfXgQydpGK
         x42BzqrIdMv+cKSaIIVwYIilLiibtsq/yAeKbeP+IxkO3Lb98642be7MfVyKrAUxCYK/
         8gNgoKHLhiCv1+oJbr6tIQODhDsDf3hKOJW6V+LpdgYARLAWeADQjpcsm4WxfBOmcc4b
         GiwmJiZnbxrfTho9gWROnZ4Olu+14FlF6G9lGEVMOfhi4V+Ocr26lwISuyFDbxRpGY0u
         8i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729636307; x=1730241107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBpv4lygubL36e25IlDlHYVhQfEMD1LpJ9xSKfCH59o=;
        b=Q6MtBAI6MjFCp/2N4mhyTyqJQsmaHXZ/b3t1gl9sHxohzhXg5mXCbnrmLD62qAiWDH
         RBbpnfkMl25TBlIOAr/NfPZe2jmQO5Wuu1kXiRPGQh9Ds4d5RjMVMmfP+6pNyCog9f/8
         Iw7meetMTPwe7tZtpdViKVxy0UFZzGzOIlozIGFO/qv/L/vyXjtnwlqKJ9QpqgfWWMpB
         3nrLPvI5+wp6xFjEJH3za5oGphx0Z+p9/zIIxNe24rCjaOIBaIPw5Yq0f+6JqqWiwslF
         Mmj9EYbI2VTKrxcfmSND6tcl5TONgOIolMRto3YfU+XQyegicessFSmzRCAIU/z85tzP
         MS+w==
X-Forwarded-Encrypted: i=1; AJvYcCUwYwpjccLiva7PIWlllXTos5rzo/FnihpSiTbqqQcA1M7gTRJj6fSzoA99wmUCA1mLDWm2KwGwPDPXCz8Xvgk=@vger.kernel.org, AJvYcCWwhQqNf4eo9sn5vL8QOl842QrreBTspUjFc/218moK06Cfk2K2yxlKBpxmHc5IIwVWEHq7Qc9VtRbsRg==@vger.kernel.org, AJvYcCXgdueFVHZMWHvPMFUYmqJQN2v+BzCSvIH92/DJXqsWMGby+xUgpRX8kGWAHVLzGAd7ei2ZBIkPRWlBAkW8@vger.kernel.org
X-Gm-Message-State: AOJu0YxIojq4TRL//3yHpfv+SktWbsTbp34FL8eZbT++ioJyg5Z0U030
	pU1jI1btzymfbsxHHFptS2b6DMPLjjY0HTFYknITQc6lkYbFQJ8MXSeUCwdYkaLwKUb9Cu+zr4q
	fZVwMeRVBqMAAR1QiWf6mliUBQJc=
X-Google-Smtp-Source: AGHT+IF0Wv7Vo0CTXqsPq9UXSA/5GUboFf7wua2ylNI/g94oPhAOc52VDUG52CbXVCp+BaDOVxFamTT3zwtxiXqa4No=
X-Received: by 2002:a17:90a:d80d:b0:2e2:abab:c456 with SMTP id
 98e67ed59e1d1-2e76b5b7e1emr221085a91.1.1729636306837; Tue, 22 Oct 2024
 15:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903173027.16732-3-frazar00@gmail.com>
In-Reply-To: <20240903173027.16732-3-frazar00@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Oct 2024 00:31:34 +0200
Message-ID: <CANiq72mXuDbT4aSH6DTiAK0AWZjSg+qgHH+L0fP8sZaYYSvFHg@mail.gmail.com>
Subject: Re: [PATCH v2] docs: rust: fix formatting for kernel::block::mq::Request
To: Francesco Zardi <frazar00@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:00=E2=80=AFPM Francesco Zardi <frazar00@gmail.com>=
 wrote:
>
> Fix several issues with rustdoc formatting for the
> `kernel::block::mq::Request` module, in particular:
>
> - An ordered list not rendering correctly, fixed by using numbers prefixe=
s
>   instead of letters
>
> - Code snippets formatted as regular text, fixed by wrapping the code wit=
h
>   `back-ticks`
>
> - References to types missing intra-doc links, fixed by wrapping the
>   types with [square brackets]
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1108
> Signed-off-by: Francesco Zardi <frazar00@gmail.com>

Applied to `rust-next` -- thanks everyone!

    [ Added an extra intra-doc link. Took the chance to add some periods
      for consistency. Reworded slightly. - Miguel ]

Cheers,
Miguel
