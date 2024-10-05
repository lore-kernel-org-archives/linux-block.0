Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2D036B0D;
	Sat,  5 Oct 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728126320; cv=none; b=pCRIqOYMEDazmRwag3FH0D+oakoO6nlGXB/edXStNJ4JUHiQlmFMdz6Lz0ADybz7ip2DjPQHKpzv8uSV91iBc4eRyZfrIN63/jaRMW7LjfYbxUf/q4LTf2N45WxAYWilbsZ/PT3eMGuCn1sQHCRiwPVCUQV4TgyHS/9Oq8CdsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728126320; c=relaxed/simple;
	bh=N2wG5xTsEGW6tckm4+g8420EIFSgiKjK8p7h/dH6u6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn0ziOuxDIPotq+XVsZyHOS+obyKVPjezHhRzfTv4CN0SdqDUUEXfYaMF06VES2ecXvGgywS/wViyRdX+AqYAI2tC5gPJzOJp2o/Q0LIUjuG/sKbeKCxSB6IMmTdjl00yXKKSG/GO6LL6szDBTRMX41IRdosvQcTunHci919jRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsLYGzZY; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsLYGzZY"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cd85502a34so462355a12.2;
        Sat, 05 Oct 2024 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728126318; x=1728731118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfqw5r1czL4EVfquTUOiF9Q1Mwkb+cRBvrS24YvH9JM=;
        b=JsLYGzZYZ866gVtttPxZGp2jEXlLdgf7S8aA5Tsu2gKhgPgtEOJsT6LM9y/rUX2A9n
         QIpub/F3BepHI2HaGt5nGlt+AZIlvPbYT9AtiGJHlslzxl1q926eY7OMFF73il/yXh7S
         P+MTGTjg0LgzLOYtM6nC3YJcCH23vtp/kQ/jSnONFbyjxngnGE0ekpDuEMpfLadD0DUR
         5zcifgqZCdahtMebFDSugCLBUUewvVk4s+l/aGg/2olL9/lNXwfzBUCdLE7r6efm5zCl
         7ueiM3qUjSeGpTzA7llaidvPrI1+S0hCMZXKajfb8qverROjQmNKQzgTCt93QLsKnGBm
         770A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728126318; x=1728731118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfqw5r1czL4EVfquTUOiF9Q1Mwkb+cRBvrS24YvH9JM=;
        b=f1J03QaKm+qez+4b2ZAFLUlaripBKzzMxhZ3YAX+jL1r7DIv4hpxHQfLhSSPjy2lNM
         RjlRxF21jFdtAyjZ2izqjFhMwKE3t/zV5M3KSrMR1w9zX0Gz1md7B1yF6B2PFvBWS02K
         XO4Fgfx3ZuQbwouqH4WeRHKK4styRX7egbDVmfkw8KOSHGX2cozJtEp63dNlLOGV4nAO
         /a37Ax/cB88sxHd2EXspm+dAo8KH12P8BqBbi6QzgwrqSeYkP3tAkF3P7kjNK/J8FLx1
         5843N1I2e5jSe1cXssT/DIkpkdxwEU4lZjKhCqhP9kWCfuni4BFbW0hsL7B3kSuycbQp
         M9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs5fi2E2MOEZBSFIVYdHfVHaiNEzgcTI2q7nH+IeDdyb+AbxFa7fQ7NKsYCSLHVOBbs5R+C2mCrNx6AeRo@vger.kernel.org, AJvYcCUxKp4rdhj767a5zv2J06xL4Fk1wCt4s3BnUQUzJaVlxKLKa115hVtfVdCiMz9U/hvKEHi9oPhLMFBLYA==@vger.kernel.org, AJvYcCWX4rgXbbdSuMjHAWOvrTuYD3xqoRH/zN7sLVfTWsoU25zvOCuNcpEOb0zb6Q1oMmN+Fc1+6rZCYr65KtNbCDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLdBMHvGrZdHPhHVzO9qlaY/UH8h+6hXz+Bgn+hO76IJinCpR
	ycht2ULqtdYLYJ0PDS2vQxTJwFLzkKAgyTrFKIBrBTDIr2uOHixL5vaQNvx98VVu6YbpcDevd91
	8WhQAtJYua/EpLgdn5MIh/5Dk3eU=
X-Google-Smtp-Source: AGHT+IFbKeP5SGhdaf0Oz6Qew6k7OcfWrmiRG3qMT6fK6lKT1FG4DTdWLJ88Xq6uA25mxsX5Cz12A8etCLIeQr3U1Ak=
X-Received: by 2002:a05:6a00:2401:b0:710:5243:4161 with SMTP id
 d2e1a72fcca58-71de2472ac2mr3759730b3a.5.1728126318131; Sat, 05 Oct 2024
 04:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004155247.2210469-1-gary@garyguo.net> <20241004155247.2210469-4-gary@garyguo.net>
 <OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
 <2024100507-percolate-kinship-fc9a@gregkh> <87zfniop6i.fsf@kernel.org> <20241005101039.GZ18071@noisy.programming.kicks-ass.net>
In-Reply-To: <20241005101039.GZ18071@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Oct 2024 13:05:05 +0200
Message-ID: <CANiq72m=V0tYvwYpA3ciPa_tsf3kkaxL97gc8qL8rBj6hF5c_g@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:10=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> So I clicked on the link for shits and giggles, and OMG that's
> unreadable garbage :/ Is there a plain text form that a normal person
> can read?
>
> There's just too much 'layout' and fonts and colours and URGH.

If fonts and colors are the only issue, then it can easily be fixed
with a bit of CSS client-side or we can perhaps add it to a new theme.

Otherwise, people have implemented other renderers and viewers in the
past, including text / terminal-based ones. Nowadays there is unstable
JSON output support that can be used for that without dealing with
HTML:

    https://rust-lang.github.io/rfcs/2963-rustdoc-json.html

If you want to use rust.docs.kernel.org, you can also use the "source"
view at the top-right. It is still syntax highlighted a bit -- not
sure if you like that, but you may find it "less busy".

Having said that, there is some logic in the layout (in the non-source
view, I mean) being the way it is in the HTML view -- it may take time
to get used to, but it is quite useful when you know where to look /
click.

Cheers,
Miguel
