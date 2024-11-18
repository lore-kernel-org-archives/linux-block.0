Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A2153836;
	Mon, 18 Nov 2024 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920958; cv=none; b=SuSiLriHRK/KW5xdvDsB8R4nON46U4DL2dRu2Sr6gCJRkyXE0x8TQ5odToXUE2wwTzwkBVtoDTaoCV4qSO141U2xOBd3HKoFV2p30/oHgEoDRLryeu7fRmQ/2toapSQf/FHOOYmmT3FwpPetB0pEuxby8R3NOro2SeWMi+pbd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920958; c=relaxed/simple;
	bh=YWLswSe7WZP9b/xSFZ5CYmi1IPuOZDQasiG6yEaMH7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPATJDQxnuDqq3HIird9NgfoYm62/XskzLCsn4tSnMO4OVudE8bHxyAoqhIkmBQHN/wSysTzBmPyu79ILaIpctipU+/Ipeq+HgwQ9xlsk3rCxvJmWXecPA1qCmgpBaWZzuDpiW/S7x9DnrG/gElmsY5c6VUY72o0XxfZRor7oYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrHKJxVR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrHKJxVR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-211f6e1c865so3390455ad.3;
        Mon, 18 Nov 2024 01:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731920956; x=1732525756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWLswSe7WZP9b/xSFZ5CYmi1IPuOZDQasiG6yEaMH7c=;
        b=SrHKJxVR7m3oU7mRrxp5tp8195/a4J6qbqwx0P9bQd7Knry67ARKGLZGc/ChpUs4J6
         qbYAKwJe+9+JZFRVNcFJ/S9ph2QAMq/XIf8m1GH44EqLZ9IpZ1m+FY4m8sqjT/TJiVih
         m4zIzrUnyDn3S5JK3/VfiltW7ATbAkEdTzOQhNNQl9g9+pRjckhBP2e3u/edPQTbx7Pm
         oeONCrxqOzYtmBj2ABTN8bCWRqFEKWOcj2qANX1O6CSz2HBCvCJ7gW4we0xqHCSDoWI9
         XB0WWn5e1VC+mblw1PtkIx4Hs0Uu7lulKxRKtkdkw2WmDnVcvOCKIYdJgjV/+FgLemR7
         TWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731920956; x=1732525756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWLswSe7WZP9b/xSFZ5CYmi1IPuOZDQasiG6yEaMH7c=;
        b=Y3h4G0aZ+M1822mX2CQnmJj6hrMKc3c+GkYktG5vi22ZmN1qlWwhO7iZhU2XvJaiOw
         MplHCo1w5DOvwUy1d6AJtRT86Oi8fnc4F/giGvOB1HPSgw9hhFtds5ZJX+Km/5Hyvs6o
         uLIs29bX95fquM5WwnrkJFoj8sxvotohmb4XRtEJyWk4mmt2K/noD/UdFDhV6dIi24pi
         o165Gcz96ImiNP87qAd7Ev+H30mA91fLfKgLibk+Mk9UJKLcCcqYXGivQfmcJ2IZp4ot
         5PXxhaVyxrTkhwUDN+Vid5QYDnDHeVB+yHSUOfqINjL9s4gtMFrjJezqf33njBTsC2wr
         jTBA==
X-Forwarded-Encrypted: i=1; AJvYcCU03h+yQ9j8YpWkmc8W/CafvKWk+WILvJJTyP9Ct2F7jMFVVjlBbNJMujOaiJPN9g+hHMuf0XjcVY3PzpoEfDw=@vger.kernel.org, AJvYcCVanOkH3CTEMcQgtBeinFSjgUD0dNL6pOwxSvXtVjaj1G9vanx+aBBQk02FkRyBPL0UTVSFU9/CWDyhsw==@vger.kernel.org, AJvYcCWlKh5mnQg1gyTrHyPTM/lF+rBEf0GIBcDWXfuyWUK+E0NsU71JpoVkwwvSYcZ54LdVXmZKSkN4@vger.kernel.org, AJvYcCXUk5TAd4YxOB+1GmpcWssfhQ7NDa7hbAnwfpNGVJWe22VyhqCSP+xbgHSS+UhhBFMY3+R5YugdmxcDJdCx@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0azNHph2gIIKIoqeTklXIexz+vGkdviQnAuJO8a9t/Q79ft4
	u36DAp9xjSJRcmz4185sMqRUcBBZ3s7SoWYbCvosccudJMdIa+EqGLR+8Rsd3Kr48xnwXWYVlCM
	UzB/4TYAEVGb8/xha6cfDprKAVzQ=
X-Google-Smtp-Source: AGHT+IFpWfv5PIcWHbtZu/kn7bRyyJbKbZRumMvg1pEzQh+tSLDv2nY2KMHanrDXfZai+jdjAHxB8cHLncAz8ePurYk=
X-Received: by 2002:a17:90b:1e50:b0:2ea:715b:72ba with SMTP id
 98e67ed59e1d1-2ea715b7581mr1460462a91.9.1731920955682; Mon, 18 Nov 2024
 01:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
 <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch> <CANiq72kk0gsC8gohDT9aqY6r4E+pxNC6=+v8hZqthbaqzrFhLg@mail.gmail.com>
 <q5xmd3g65jr4lmnio72pcpmkmvlha3u2q3fohe2wxlclw64adv@wjon44dqnn7e>
 <CANiq72kQJw4=qBEPwykrWBsqmycwS+mR27OE2dTPQd3tKjx-Tw@mail.gmail.com> <5qtqdzljvzly5onzhfdq63fzcqcj26ybktm2cgomijpnfnyrbj@ln2kbp73csf6>
In-Reply-To: <5qtqdzljvzly5onzhfdq63fzcqcj26ybktm2cgomijpnfnyrbj@ln2kbp73csf6>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Nov 2024 10:09:03 +0100
Message-ID: <CANiq72koO_gdhP_5hzNz5AH-JQNoAzpszpeVR_BV14Nw-OWhzw@mail.gmail.com>
Subject: Re: [PATCH] rust: simplify Result<()> uses
To: Manas <manas18244@iiitd.ac.in>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Heiner Kallweit <hkallweit1@gmail.com>, 
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

On Mon, Nov 18, 2024 at 2:12=E2=80=AFAM Manas <manas18244@iiitd.ac.in> wrot=
e:
>
> Yes.

I was asking because the kernel does not accept anonymous
contributions, so when someone uses a single (common, I think?) word
as their identity, it may not be enough to find the contributor again
in the future if the email changes.

Thanks!

Cheers,
Miguel
