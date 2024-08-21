Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6A192D66;
	Wed, 21 Aug 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241291; cv=none; b=H2DDxmM8xbzu6v8EQ8MfmPVq0o5tJa8ZllC5zDn3J2ZFmw/DATPCiM+SFzWp41eMSuG9XEEI0uBGNO1TRqYNfAevBs6q2o9sRUrnM1v1F+BL/HKodRVfgHR1lzHXjhG/Ie5OQWkxFwRgxX5QsFgOh9bJ3Xsuz0aO3ngTA5Lbl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241291; c=relaxed/simple;
	bh=JBtWbazJKUA6/dJ6r9f034nEMDUsTMqHc2oC7nYIFtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYKHS3v8TQKa4llle4mm5014r7VBJmHyxYCFYqO+qwj0JzpSA5jf5t4eoC8a363J1TQ03MUAk+N6oWOMa02GbQCPpMNUPCAfYplMtMFyFRsdaz2d7mGU2flUC/yafCegeLrL7fFw31jUTXAu6RgZ9kt2AwwLJNovitmrpXHfO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpeJivBb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpeJivBb"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3ba497224so88682a91.0;
        Wed, 21 Aug 2024 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724241289; x=1724846089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1YX2miHAUi0+/dGV7pb1+2w+ezV83KYwxdEEwMmR18=;
        b=BpeJivBbt9W7dcFlaHjEGwOzJnLBRz9HI2ZQMS0fwWAlo4ZyzUvAvDXXOjjH4YQNtU
         ug9tNWmRm7qp7QICQG/NNESfmJPEI9J+Mna/36wxmoadc8fP7syCjvlBARGfvvi/T53g
         vhwv3xGUOhr3wDBqlLN+LxQGGN4s6uB+BT84R0gTFM2bOkkutowrwAqjIY+WckFeWfQY
         jdJG7aefb98GaXOIbPlUFGDQtTBHx0BWwjnYWGClsoVCiRV38OROTNVjyM0lAosWQa2Q
         T9Yfge9QVQiIP5ZwjOS2fozkKrjMO7hzBWZGZ0KwvcNtnm0sala7qCeODRkM6AisC2dF
         oUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724241289; x=1724846089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1YX2miHAUi0+/dGV7pb1+2w+ezV83KYwxdEEwMmR18=;
        b=i8peSddl1E4an0b3BmhuNF/iRq9DOgdbRJbzMQ7bhNYE4RiBUVhyGolPKw7KT1uI8J
         lgE4Z8yJkrx3C26F11gWa5HDCVhuM4fAFNJRfCEyYHcelbtTpnsu4aZv+fVOKcVF3kzo
         4u3HhUVdikB0Kn894yFz4Jym23FkYnaL/G8JFwnrGgQDX7kV8HB3RF5pQD7tq3Fg0uxe
         mOodArpvUer+RWWtzgkym4+SARhfvTCiW/WLXGvszkrTxBQpSWMrfUWCv/BeKYg+AUKo
         yb3leMoB2dGwCVu9AgQ6Wz2sqyAVq8jstODpJuG5dvPSCUieLxwzmCFmnZZlJd2C+zYc
         5UGA==
X-Forwarded-Encrypted: i=1; AJvYcCUNL3FaDyYRxRIEYnhMzU21EeeUdr+kbsUfoS4UILZDgjHQlRn0yjn12lRRVmC6iyXrIQv9inqgvFafxTgQ@vger.kernel.org, AJvYcCWxh8imdEBhkidyyojED98PzhdNHjzq0kYegL6si3DL09A8TyLS8UTKm1f0XXsMAAzWnAEpBkNai1RMgQ==@vger.kernel.org, AJvYcCXs2GYqD8ZLGHAYMq9WP9s4Ki0s0HwCPQdUsugADX8OOWGK5W+mGQZPtWEqihxauYrA5Ba02DlHnteLjbOuJ8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaV+9hrmuqeMRdGWljL3ks//VeTcZ0qCByv6OHBYFy15C5tjhw
	Ggf8gTOAxA/3h54FXc5iHWvw7sjgijYYDQV/IhP5imm3lBo8XO50Jt8y1nNOQS9klG3EF71PHg+
	8qFPp5tkrXaibmVkiwjkIaQbgLFk=
X-Google-Smtp-Source: AGHT+IFHrNgx7Mk0k6i86ljxev3co52Px3UGqMq0OFJcxXsGwjnWhDqw7fIp0dTObjIm3aRC6xk0+3wBT5j4CIvDW70=
X-Received: by 2002:a17:90b:2d4f:b0:2c2:d11b:14dd with SMTP id
 98e67ed59e1d1-2d5e98c2845mr1267711a91.0.1724241289195; Wed, 21 Aug 2024
 04:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815074519.2684107-1-nmi@metaspace.dk> <CANiq72mCsBO01FHbf4D0h0yvTV=TbpgO-jeTHLL39ae-JpMLZg@mail.gmail.com>
 <CANiq72mrwBs_YTcBvge4ME5bwSLKbNaoFU+KZw3EfCTyGjiJ9w@mail.gmail.com>
In-Reply-To: <CANiq72mrwBs_YTcBvge4ME5bwSLKbNaoFU+KZw3EfCTyGjiJ9w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Aug 2024 13:54:36 +0200
Message-ID: <CANiq72mBonwX43d4y5VpZH+1ZWTnJxMfX889Aa3HHmY0_m5Mvg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: fix erranous use of lock class key in rust
 block device bindings
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	"Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:36=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Dirk noticed the Zulip link was broken due to a rename of the topic.
> Normally I try to remember to convert them into message links (which
> are permalinks) and to shorten them when they are too long too -- done
> now.
>
> For context, Zulip is gaining the ability to get topic permalinks (see
> https://github.com/zulip/zulip/issues/21505 -- we gave them feedback a
> year ago that it would be useful for kernel commits), though I think
> it is not exposed through the UI yet.

It could be a good idea to warn about non-permalinks to Zulip in
`checkpatch.pl` -- Cc'ing Andy and Joe and created an issue:

    https://github.com/Rust-for-Linux/linux/issues/1104

Cheers,
Miguel
