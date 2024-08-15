Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FF1A08CB
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708986; cv=none; b=exqFubWaL26Hj0CiM6XE8oeuM9lIcdGTFfG80XseLztIoRCT6oJ+2c1dvpBvQj/6YtIg7N8LD6cYIl1OCEz4ZP2iQiSkZ/xJj9VswrJ2v7MW40gGJE/bEPQTMSF/WiYuWvmgqHCzGxAUV6OO9WhaCFIYUab6Q1iDdv7ySRTW0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708986; c=relaxed/simple;
	bh=cw4HOzF9efUrQHUoHgeWaw9GKc7xDSDNuyZWlW0WFOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmHXqttR31guzb+MCGWOD+jqICfkybm5uR8MWNjo/tbV7etJhmYGhmri4VCIgVDBDmfO2CYVLc48677gxvPQuH0RX2uvLRUkf/ZU/wE/v2P5gGuRsO2tCPoOLi8j11oqi7xR7Wx4DsKsmZ61NZH8rWq8+PQ7isU2c4M1PcllV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyiBunrt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyiBunrt"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ed741fe46so705478e87.0
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723708983; x=1724313783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cw4HOzF9efUrQHUoHgeWaw9GKc7xDSDNuyZWlW0WFOo=;
        b=iyiBunrtdyRuXIyKPp9Pphr9t0fBQWgg3w9IDz5Q3C7HJMtvUYMru/udVzxV0ad1+6
         Ymd1KpO7346en3v9nr5QBBMiVGCflMJmBj/tSdD7AznPEFFtq2UH99D9u7MYe3pWvxwf
         iX+sWGbSFPYwsJuAyaKeYK3Pa0FdnevJydicpBRfjM683sVrmlnxvPFzhTnEH3t0WDno
         0NWjCuOYT859tfH4Ib44LpUAh0dsFK4b0NlY4bJlBmodwWsDsyTxHqCqLH7cY9Ozse6t
         F+UnZE8bYoKVpKgz9X1SL0zrOs8Iy+At7f4oh2XeyZ4TQu/zuIk8J2NaHb0fOl5k4Ax2
         Pz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723708983; x=1724313783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw4HOzF9efUrQHUoHgeWaw9GKc7xDSDNuyZWlW0WFOo=;
        b=BGOS53rIhvJg1cz+neUsYqHANGcmXoLAQhs7t3O3ysetMdSvRueytbiaVBA5PUUlgM
         sY/nkFeQUKiWUrEmpHt46GBnn6XE7mokm94cE4qfpBr8SVyYgAx0623EkWwRWWBPMl7N
         ggi6v0LdtPddQeyYyzBftB6PJHiu7vMXRxTT/zIY1/H0wW15TS5rTk0W2naSEenWXbGV
         hLacg6RkKyzKliyMTpcbpnX5mcMNHClx8AIWVgM03xTCJZ4dWhG4XBOczU0ZLgcLcECZ
         Cwi1WxcNkPgdsYWUnxycwD9Yz1u9KHbkGjbSVickDfmWmaY3Ex7jDmlcM/4MtPjpX5Ow
         7Tyw==
X-Forwarded-Encrypted: i=1; AJvYcCXLK6/Wuk5WcpC3mEHUUEdZ4AsSNSvh+JB0C26vELsoZ/S487kA6PdRvw44lSlyKETRa3NLP6dnWi1N2UpTllpSnp5ZMrgDYWAQoXA=
X-Gm-Message-State: AOJu0YyRFpZip871MpmBNrFlyWSIX5n3Vz+8Lphm0sGAViIr91R7qmJx
	/ZGf4fkB4vJsGx40I0tio3nYUUU4VKjsRccUZrgfMTZ9ui6qALQfLfD+lfeIzDOnUmM+Cv8U739
	U/uhHsxBLiy6el4ilec4P7/mGg4k47R/kdvc1
X-Google-Smtp-Source: AGHT+IFsQKTSHXbcYSYVRfO6L0p/unFzrhWsL62YkDkRkGxv+SKfw1LPGgC/R+8Wi49EsiT5RHmeVtUn2IL0tXEmOvk=
X-Received: by 2002:a05:6512:39cb:b0:530:e228:77ae with SMTP id
 2adb3069b0e04-532edbad7a7mr3564938e87.40.1723708982792; Thu, 15 Aug 2024
 01:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815074519.2684107-2-nmi@metaspace.dk>
In-Reply-To: <20240815074519.2684107-2-nmi@metaspace.dk>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 15 Aug 2024 10:02:51 +0200
Message-ID: <CAH5fLgiEcyGqV4USTvMGhaMBFrwY5winmGC7ymYT2Qr7R=OBug@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: fix export of bss symbols
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, 
	"Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:49=E2=80=AFAM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> Symbols in the bss segment are not currently exported. This is a problem
> for rust modules that link against statics, that are resident in the kern=
el
> image. This patch enables export of symbols in the bss segment.
>
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Looks good to me. I was using this change myself for some period of
time when looking into loading Rust Binder as a module, so I've
verified that the change works as intended in that context. I also
tried it again just now. Thanks for sending this upstream.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
