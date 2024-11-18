Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28283199EBB;
	Mon, 18 Nov 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945918; cv=none; b=iDUg2ygqtHHzjywvKGCtzyFgmpwCROhXkQycGvcC5tGWN4BsVrcIVJgZPUK4e2XIZiv1iYiyWnB53QOlHSFeG5UghaZHGwmohm+pL0CvJEl7ydAeCgBoH2BHbvcx0kuDKSaG63t3QEOFU43FbbrN7QkU6gP3sIhHNZuDOr78Dc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945918; c=relaxed/simple;
	bh=hsAHXyza+Ekt0ZAhdLdC3ZCXUpqpsIDj+IhhvOf4uCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTXJxvjypv45VD/dTve0+u3pkccaSMfhbF7RVpjB5iMtyX4l4m99W/7NckpKhwXaj/czODTFKsmpUymW342YgnyN/b+X1TtDfVFY1p4qGNZcG3WdQsWe6E+87VApBP1QFSeQ5OrheUrUcy1hmQiLtts8Hb5bFwglAuBRyuJbo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgWUCbXz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgWUCbXz"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso728342a12.0;
        Mon, 18 Nov 2024 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731945916; x=1732550716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsAHXyza+Ekt0ZAhdLdC3ZCXUpqpsIDj+IhhvOf4uCs=;
        b=OgWUCbXzwCGHcdgI0bdUB2OmCwfgvnk45P2Zvp5E2on3HGCL2tYmXjDq6+A6MPUo+7
         h8SiKFzMJ35TSPIbKZ/UkYO4/j/yjodFZxFSlmuYTSIueXT7Z7GpBuqE3qqzwTdh306M
         h1QlIIskf1t5HY+cfR4bFuwJ5ACf5q57d2qLSUgdXo+D6HD6sAvtiDH7hluMUcPXizu2
         Yh6JP6Od3hDB1NNW8E7leMFylacfYpPqP4qN2oTUZu+Pd+ZrMWZD8ayoaTTUZFsPoQOX
         F4vgsM60UdmBMLFGwVfyHV3KsXOKtTNQBzLCAt/z5FAE+sSsqMaT5QyDqevfA1ak2Hg5
         Fw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945916; x=1732550716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsAHXyza+Ekt0ZAhdLdC3ZCXUpqpsIDj+IhhvOf4uCs=;
        b=BJAO11Y+El5Kvgv62ngRv40KXuQm1BS992VXsxpLC8XlLvRJ2rgEy62wTjMixKXxTf
         skwihyRqo5duoLF3uelH+UQx5rutKKZ9qn29PARJKmk7jD2kS4i1slF/sqwX92YsLZut
         VmBk5qUZFmjwQZ8vNz7QVddItkgtS0I9eg/UEZPvHo//gun/mYCLgvXKLYUMG0mRccrr
         UdSBsbC89zADuWD7bR2D06j4u/BfJFx++xDswRUmD5K9COlK5ZsSQLYikUyXxo2bRz21
         VrZpDd0WlDEKabWvEHk4xa1e6HZswDcZi3mEATdfZTgUpnOfAxJS7Oyxi0zVg4eO9PxR
         AojA==
X-Forwarded-Encrypted: i=1; AJvYcCU2SZD/utzJuJrgz6+IQyzcKBLK1g5dEEF6LIDrWZaCCQnVpPfaFsHWnswUHlHDdkfAmz85fw8Z@vger.kernel.org, AJvYcCVa/jaB0vuhMha0+47TxnpntBOYX3m84TE622RnbSnI9ugbkSmjHuOe5xohAkaVwAtcwaB4zBEpS4uW3RniSYw=@vger.kernel.org, AJvYcCW9AaGyng07JdGEC+7xUqyxGx8g1mGrwcmM8oPLG4X3YGKMu3e71I7XOIPp9DkBMDi+AkotRgdUI/yaVzmT@vger.kernel.org, AJvYcCWzWjkWFwEJp6F5Ss1Hws/XH7ET0cgndt6SO/zlkYllfhZ5b/aHdcrPaGEFPadecms58LRR7tt2hnE5uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP52GINNjLiLNiwCnf2rM0azf1/0t7jzABKgdMpHGjkMPLNemP
	yv2LPGOi1oplmxh62fedazwaoCzD9rtL+FzC2zvzcRqzVwrLpG+4BVvFAZTzk/L8g0hvx74GCP0
	wTYYZ+M5gVrzksXhH9BUjuCWwnkM=
X-Google-Smtp-Source: AGHT+IERvQCeacQ2iD8YKp4au7PeRxQi4qWpIrbnEyp+ndrdW3bosmw34d7KBAiPna10cFF4b4AOtgiB3VmeU4wRoy8=
X-Received: by 2002:a17:902:c945:b0:20c:6bff:fcbf with SMTP id
 d9443c01a7336-211d0ec63f6mr71034585ad.10.1731945916182; Mon, 18 Nov 2024
 08:05:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in> <20241118-simplify-result-v3-1-6b1566a77eab@iiitd.ac.in>
In-Reply-To: <20241118-simplify-result-v3-1-6b1566a77eab@iiitd.ac.in>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Nov 2024 17:05:03 +0100
Message-ID: <CANiq72mzCSmLG0_Vqu=sCO7TBPzXtea3HPw5TjT_gYKEh7_1NA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: block: simplify Result<()> in
 validate_block_size return
To: manas18244@iiitd.ac.in
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Anup Sharma <anupnewsmail@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 3:37=E2=80=AFPM Manas via B4 Relay
<devnull+manas18244.iiitd.ac.in@kernel.org> wrote:
>
> From: Manas <manas18244@iiitd.ac.in>
>
> `Result` is used in place of `Result<()>` because the default type
> parameters are unit `()` and `Error` types, which are automatically
> inferred. Thus keep the usage consistent throughout codebase.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1128
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

If block wants to pick this one up independently:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

(Note: normally you would carry the review/tested tags you were given
in a previous version, unless you made significant changes)

Thanks!

Cheers,
Miguel
