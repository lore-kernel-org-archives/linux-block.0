Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7715098F
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526155; cv=none; b=G2SfDOiF6nACsqpf02oX7Jcf7xlafuCnKtFXwgfArGNasnkimHZcSBLXfNmSPH+cWikIPJ5r0TI9y1om1jfuhKFLsRlOVILSwaYPTqeR5TG2m7tVxbkO0q6WUZYb65/gsgEkr+XabT0MiqUl2GdUiXRM/S6322dIk6FqyC/cZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526155; c=relaxed/simple;
	bh=0ha3COx0DHOj8uxVj0+IXNOyCOzZMIKeCo7cSFiOZo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOjZ+biqMWfCtT5u2y5hygCAClvL23Bv2cqKc5kn24P1NyZbx+JA+LrYD2UXNBU87LTwvtz2mJT/agBa+wgMlA5O05smFZ/GblIzgpywUQq2gKX++YjOo/wyNJ0AwmYXFNYgRSnni0uU7nXfHq9/qLE66Tf02McACCDsHhGBy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8xcS+tT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8xcS+tT"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-382423e1f7aso2956900f8f.2
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 01:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732526152; x=1733130952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ha3COx0DHOj8uxVj0+IXNOyCOzZMIKeCo7cSFiOZo0=;
        b=Y8xcS+tTTWlf9/6R6RcIHXDyFyLx0NYP3v7Qp6LDlZunXveUB+nNcRMOOfqG46QacO
         ZJ1W6+WVTekrxD/lQNa11Zbi/JXVsDCXDKCK6yoyavqdXqXdsAUDl2VnEIzLD37Wj8Pt
         GEm22mlGlq8ivVDu0ituahMFRO063vyyqE0QWCo/RavTB3ELTaLIRAXvignghtCUiNh3
         3QSgcbiYVtmOQIyxm4zFXtCaX6H4BF5z12TbaxeLaeT0xeLV9u3ZJm8O/FXnNqBVqNwA
         Z3S7E6HBzLA9MD0Y18ePo5gKdixPMhbCQTqhQPAjYpdwFHyKaTRqQQj4uN5MmMiPYDGJ
         OszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526152; x=1733130952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ha3COx0DHOj8uxVj0+IXNOyCOzZMIKeCo7cSFiOZo0=;
        b=S41yeFaQXa8xLV14zfz+uKycTz1Fus1N8BbFyCaQ6t/7CSb+MMhWhjZupLU5kqDETE
         5+vc8zSL331NWERQMqJncDnGlJPOtIDwbcGUasIngLULM+9XjEx0ZVnZ+2Pg1pOudM1y
         VFPs8Zh4uoRhCrgWQjX0bskpuZKxVe6yU6I05Px5vEGcuJWZLsMNNogyW8Cmv5/kfLFi
         K6LxPv9wrBaGphsr0ek5eZK6qvWkqZKQX4NlPYGdB7eNIPiG+pHfwFDt+LvDHxhAoIBe
         jk+CYCQMrvhCuYKPEPRQnz//Ugmahm6V8KOp1tyeNIfXgChMn6nqTh2fhc9R/AQIZ5+o
         bOBA==
X-Forwarded-Encrypted: i=1; AJvYcCUM49szzHB7sz6JhGp6Z4C0KodsVcCmDyhZTr6mrTg5d5NZcF/BYvIgJivC3yr5Y7EfEzb/cC+qzhOdPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUuRT2zKTwB0qdIflVm4K+N1cQrCBBJ9DEnmhPQ6TbCKv7oljF
	NuuastFkOxKB3wya5uNi6M2g59ljcQP/qu2iuuCT9A50x71SICa2ZfGXGJs9/GW+ywbrns4DsVq
	FUJ7DRuAUBZPgXwTKsqiL9rFdaDfYw8EtyJHA
X-Gm-Gg: ASbGncuPLkt/32H+rGHX4tr3gcmi1jmr4Tomt2wd6OGRuJATKm7MWRQtJzY7JAfnEDm
	ICs7tVFSfXHoi/csxAqD9HXLTdHzjXdHypW8+4M4KKdfReCKf8jrPQCvJMHv13g==
X-Google-Smtp-Source: AGHT+IH8NglVha/cRO2EUsWas5pT6+KPbdrlOa1Qfc0/+y2Ov2H+tjMFSpQ12N28tn+7P/9GBO4emIZVFBM59ocV130=
X-Received: by 2002:a05:6000:1fab:b0:382:4a15:6928 with SMTP id
 ffacd0b85a97d-38260b5715fmr10344321f8f.14.1732526152020; Mon, 25 Nov 2024
 01:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org> <20241123222849.350287-3-ojeda@kernel.org>
In-Reply-To: <20241123222849.350287-3-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:15:39 +0100
Message-ID: <CAH5fLgjoC7=gBBnohf4GPLPrk+wpR7P5KMm25EAmTspdTjg=4g@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add `build_error!` to the prelude
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:29=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> The sibling `build_assert!` is already in the prelude, it makes sense
> that a "core"/"language" facility like this is part of the prelude and
> users should not be defining their own one (thus there should be no risk
> of future name collisions and we would want to be aware of them anyway).
>
> Thus add `build_error!` into the prelude.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
