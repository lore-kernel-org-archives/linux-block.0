Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B42417E2;
	Thu,  6 Feb 2025 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738884492; cv=none; b=Sd2jZQFMmY4a1kPqgPtcVGGsfX/BKrX+u8UM3gcmyO2qDJKJ3pHuKKFOHojx4wpEDrgPJaAlLbMjYhITY1sJYyr6vaEvfANgOUY89MCWs+O58CtRwqZoj28PLJIzf8y5UcwjkLOEWdKNRCeMOm4BgE0vcbHaoTYklNrbA3+4chA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738884492; c=relaxed/simple;
	bh=KSrTdD2q1/iRSUnuHKvKqXc3DguW7HvzegyGN9n7OEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlLrpt0D3njkV5jg2L8ojm9E3dUJTt+hP3EVjH0dlgHcyvTSYAUhuBem9Bxlhkjnimknwvsu5osGQGcEoGCxTiIHOdEMQ/fcwRDt1kylpyABs6gnYexLJ8br5pe3YFajyDBde/Mc3hjwPiRLKh3S9KufTTk9oXFnd60nvLmE8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAiwA53J; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAiwA53J"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9dcc3f944so293042a91.2;
        Thu, 06 Feb 2025 15:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738884490; x=1739489290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vahpufTcIjyp7L/I5A5BpdbGccpLHp+/AyzrmQB1muE=;
        b=YAiwA53Jh/YShbZ5STR/rHrPRU0EHj2YFMCTGmNRqn0Ihgq5jG8R/mOyqJPiBCY/Oc
         saf+E/0Q5qMLdZe013meJCN9lTdghwrqfscvC/7+yPT6rieg25NSfwhrU/kW/e+AGX0c
         ZejNeeXoJTxxYLX6CHWYEuunD9WZ83mXx8IoOxme+ha6yV6L+NAjxLMBTz89kvwBwHcg
         Ywi9AftOC+FawsrPp0J/7Tx8+MSWtDke9sF1fNslBAVpiyj+gQ+KMtU7Okqa7hRSmu1v
         2DhJzcIVSQCn+itU4VAJAPWo75Gngy+GJDmJot27/JW4B/0HoJLkqv5zLF8ZCXzJX8Kh
         P3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738884490; x=1739489290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vahpufTcIjyp7L/I5A5BpdbGccpLHp+/AyzrmQB1muE=;
        b=pProGEEQzyo3Q1ZktXhcVfiKOQZpyLODeJ8pv5s5zI4VSLJD7/Z5QFBlHvUgNYREoL
         Ji4KaUASFseVlvj83fNoKcdddBqKwOX9QTsoNHBNq+1nH4QmldrKeYXikwQXB6DqqYcz
         TrJzjjxG8Q3gsK8W8uUA6c8pUxQtnWHPERXXOPI8k7WuuOO0RynCP89TmYjxXC4V2iM6
         gmZbLvWBtIAodti0+LXJnDv7JpQTwBh0KfyQafkLeFIwXfW6Da4hmnLCBfyTFca0iAee
         nfwN+mVPU8giv4pTcU/XGBM6jIBReYNai4I9B3ZKxPxj15qEJajx7SQg6YjYdrBc6C7P
         keJA==
X-Forwarded-Encrypted: i=1; AJvYcCVCc23Qc77WkhSvNyCyuXQSOx9UwqMeilvImTRn/NyysPwDGdtDo7czwNMk4iSFQYbEDVcVCL7ReZTXSQ==@vger.kernel.org, AJvYcCWHQB4xLZSBcx+5XB+hNWrsjuZcJPZjj3g1SPiCLavHBU3u4qZwDy5IxYJiiN3BjS2veadhCAdQ@vger.kernel.org, AJvYcCXMKQ4Q23YENRPmhsjGUVpx2ofP8FE7icVhdUUlGregv7B5+AJDNM+CYEumQCac6e9/tTPsQAYtJKCely3BDpo=@vger.kernel.org, AJvYcCXPpjq/szOxj/UMoF9f9txj+GfHxS4UPA/BXZcsuk6goKSwlrJIEEfd5x8bldJuunDdkvdDd/UcOqsBfwbr@vger.kernel.org
X-Gm-Message-State: AOJu0YymfS12UjVIFScgTVJ1+cM1PJzb8phkHqZF7wckPRBGzpoXoVIA
	MUCsMkeD2Z/MOkORaAGG2mcrphda1pxHOYRPxKgDSl8fwoxUB5anmZzBvLSPc4vBQu3wsm/KxlZ
	MHa06xH9MKA2cyU/YQSxszQiT0QE=
X-Gm-Gg: ASbGncuNi3eXKEIVSh87WNRtRUtj3P4P6S10YUqB0p70+2NNazmpGuS8lHvJ71PHGye
	ONm6sEpAXZQ4lSelvHYxg/oNPI79/55PmPid+p5GMmimod5oYBaFJkAAwgKkfliZgoQDQ/NbE
X-Google-Smtp-Source: AGHT+IEEf9G3PLj8opWDpR6zOMcUKIZebccrC89hlGizruTgXsuoaRkmztk5fszGe2TvnQRgpUrZPskGLRkJEmmscPU=
X-Received: by 2002:a17:90b:180d:b0:2fa:2011:c85d with SMTP id
 98e67ed59e1d1-2fa245281e0mr526844a91.7.1738884490208; Thu, 06 Feb 2025
 15:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com> <20250205-rust-lockdep-v3-1-5313e83a0bef@gmail.com>
In-Reply-To: <20250205-rust-lockdep-v3-1-5313e83a0bef@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Feb 2025 00:27:58 +0100
X-Gm-Features: AWEUYZkygZV0xj0r6oLcL-IQd16zbPQkZuG8xf-B8f0qeD2wzKEUXz0leZXwf2U
Message-ID: <CANiq72kawfy3YYyo7ANYrKVjkh0n53Jt_d0=bHqHfirHCxe6_Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:59=E2=80=AFPM Mitchell Levy <levymitchell0@gmail.c=
om> wrote:
>
> Currently, dynamically allocated LockCLassKeys can be used from the Rust
> side without having them registered. This is a soundness issue, so
> remove them.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi=
@metaspace.dk/
> Cc: stable@vger.kernel.org
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>

I imagine we should have:

    Fixes: 6ea5aa08857a ("rust: sync: introduce `LockClassKey`")

Is that right?

Thanks!

Cheers,
Miguel
