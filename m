Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B34690;
	Sun, 13 Jul 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752441245; cv=none; b=boSDQVyg/K1FLxWkKTGvR14gXufCEFzKpV7DyOgAyo2wcZCk7kPExX8LYr8IurZGZDd8y/MT42k8IX5fDVmPdDbjmcM8pZOIBXDvEZp5/aWoaAtYJr8iVVIR9zKNlPTP6tp8cm/jTz5Aq3wMWXX939vXz7SmWLI0sxFxLH+cGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752441245; c=relaxed/simple;
	bh=YpjIq41OCYiF9UjeV3H3L2DUJ45H5ZCrwWjNbLBiS0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2W755zCoPahW/EAgSfsesofUORF2qVYitTmGo+sBg4SCNW7+jYlsL1eAii5SiPSb247ztuFTXSKgvJyh1ZQm9KiXzuaL0FkY6h/ty1QAfxSpOGyzbyQ4qvhwDy8HIjH7cVI++XRoeVGmiZMtpJDvLt8IVrvuut8ZYVuEILWY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTHMgLXg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTHMgLXg"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313336f8438so704962a91.0;
        Sun, 13 Jul 2025 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752441243; x=1753046043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGWesuVv5u7KHfAwqVYlVI6V4CR55/7okfmVa7+QiC4=;
        b=BTHMgLXgxO6oSR0UayluGsecb1G0jvUJMOtyotdRemhblZwB8la0fXc/ozMM1+S61Z
         faMmXnI3wE3v+byvSCLZFGSfc2Hnzvg511ujtTUQkm313sq9gW0DzBPr/XuOoQOmrM3p
         12hWOCQnYFroLkZb5togxJaz0nprdW/jVhsmJ3hKGsYJzJEswgbHTxLYT/5ZzXL/ONpv
         Zo5Wpaz86durA3C+KdkZvg5B3tTTUT1tccXSgNeiLi0WGfBTQj9cKISgQCvnAOPPDMRr
         3apkRZPYlpJYlFH4EX+Eoy/SWo37xPtWEXa4vZfoX/RetQe0DgeA3I0TLChDcxL25oW0
         +YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752441243; x=1753046043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGWesuVv5u7KHfAwqVYlVI6V4CR55/7okfmVa7+QiC4=;
        b=fnvi0okuUZ3Tp8jEtGQx5nrc/73Xrl99NRHAdaHgVecqJW0NfCGwU+VzxB4Rk2k3Tl
         yzd6MW6Ec7sm4IehQVnCjezMEsouMNUaAXgtjjrfTNE+Kz40hsYhb4Iw3tsRXUMfrBMt
         mZGCbKVq8hBPqdaUIgGUWb7l3MLNYXzoptSMo6HE+mm43ensyTCRNCJIMtcMU+bQeb4G
         q96m3+USqqyX2cBWMXKQ9D1OIpgxxxJ7rzIb3FfUIboheRNtRc2CQnO9DTt0fX4H8iAk
         kLvcwKKcEkn4TtSJTkcgRwANDh4X/IlEChNDEOmMmmel4ELT48jC7UzYtfz+acdLSsB6
         SFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGleaDyUsqGvZUZTm/QxlXiORGwa9/zrlZ0dJgdYtrG5G4iEZpd9na2KXUVlUEfEzIGVwx/LTLo1cTpcss@vger.kernel.org, AJvYcCWOsLynfq209bMbkNmDwkC+gXE6gSeK62QXWgGo29Z9Ajb3Vd6YA3PJYVtTBD7DZfM/FLWzg0XaMOdbcw==@vger.kernel.org, AJvYcCWg2rs/DBML24HrpxcnBKhF+J1vpxX85BiTbuZxZBjdOf7Ku8ZN/XeRyFiFhay13a52qijw7dN2IW263SgGkPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvTfnYvqvM+LpfBFgbjbpumT+6mxZxYgNYVQA61f8M8fSylZ/
	bBueyLfsG816eJphtEUo7/UuLOEOMClFqQzXkTwomh4c1DZS21YqrEkINk4DfjIiETwCayt38cK
	pkn1XpLgvrIr91y8fXU2wLtTD3bq5vaw=
X-Gm-Gg: ASbGncvFbGynAnIfFepZGQJNuis3GoaHOHc1pPXCFSf6g5CPHOFzO1C2B+PZBrYrfgn
	0AVllWKnDIgMeNGotolsc8BcwcDU+FCy3CVqqvnHI63xpUTqCVbhHRbgqPMg7MfV5oB2zfL9nRS
	VbGZFXZUBDA9sYpcmzUJbpOZt8CrazGrTU2KGiVhqrX51+REA8tADYgXiryMj2L07vZB2+Xm9uI
	wlK+W/2
X-Google-Smtp-Source: AGHT+IEGI9RZ0oyAnz4GZ1w7V+NM9uVh7YV4G5JHdJDwLv4SHxibYNJHOlRq/rD7kBS9A5+sODMX7YfXoqUPegPRcMM=
X-Received: by 2002:a17:90b:2e8b:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31c4f540066mr6414918a91.5.1752441242925; Sun, 13 Jul 2025
 14:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708141442.1339091-1-lossin@kernel.org>
In-Reply-To: <20250708141442.1339091-1-lossin@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 13 Jul 2025 23:13:49 +0200
X-Gm-Features: Ac12FXw79VYx8SsMbm9m8VzO4lQMLpYQrjt4HxD5ZNFn8jiSolsIzy25cevEXLU
Message-ID: <CANiq72=ADjJBmreY5Sm0U15tbXGCD+GSt2VWt0u7jXasvOL78Q@mail.gmail.com>
Subject: Re: [GIT PULL] Rust pin-init for v6.17
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Breno Leitao <leitao@debian.org>, Fiona Behrens <me@kloenk.dev>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, Alban Kurti <kurti@invicto.ai>, 
	Michael Vetter <jubalh@iodoru.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:15=E2=80=AFPM Benno Lossin <lossin@kernel.org> wro=
te:
>
> Please pull for v6.17 -- thanks!

Merged into `rust-next` -- thank you!

I added Andreas' Acked-by in the merge commit as discussed.

I noticed a missing space while inspecting the commits, so I sent a PR
to you upstream so that eventually it arrives back here:

    https://github.com/Rust-for-Linux/pin-init/pull/73

Cheers,
Miguel
