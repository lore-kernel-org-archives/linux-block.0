Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7637BB14;
	Wed, 21 Aug 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240221; cv=none; b=F4hZFR3cTR0DzqbfeSARMyeNy0w9fYljU3DLpmdYHgi92eX3GbNjDQnrpPzgs+2SxJqBU+9efeQvAMTR4fbN/RczDlCDadjO3NGbcWunZIvcZtk+HVb4ix0A/QVt3DSY3bK7pFpS3YMsMDM/Q/nz03iXwW3K0ji0K4ZLaorb6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240221; c=relaxed/simple;
	bh=qz/41yb84IS/NQmP5e9j31YI+HYD1At47sZcVsuSfMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNI/4u0GjnCRHyFeB0+n2RSjR6zv5MtdBfpYqIj9yuViOAn3+Mr+PyQVHfyJC/C0DElhSIDfW1YwXQcFxpns8RVegS6+8eXeZbcCDVWAgWTqPv0UN8S9xi6yfa+BqfxhMrOA84K5LJTYDxCi5ZT+8cCi9HE37TGRggG89ALwdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z59kUrZg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z59kUrZg"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3f39e7155so849430a91.0;
        Wed, 21 Aug 2024 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724240220; x=1724845020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxUwp1iKVSClM93G0xcaURGAG6siOme4n3w9Tmgm8BQ=;
        b=Z59kUrZgZRBJ9UrQT4t+JrfzfR+anfuTZ3T1B1P4PuS8+Wju3DGk3rTK5zegZj37ny
         9bt3R/7Ju4YnRz1N0Etmqoxm5XuTlLym3Z61k72h5ccE208twKdJogxV+gXYUWRaUj8t
         I2SgG1/5xT4lYMtMiLi4+vsCjOMg9vkBg4LjAYHFxfl2RB6+t5aAMQE2YM2xSSeHjtFJ
         ITW5RzTO0DWJjgF6UiU7Zo3xeAvj1KIsCGu65ybg06VwygiRGwkwHb70nwlX2hqh1RPb
         4ENh4Qu81f4BMnKu1lrvVDaU/6ZH3V/JXlyN+KbaWkq2ZekA3hsL3NanA50snWqDytMz
         lUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724240220; x=1724845020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxUwp1iKVSClM93G0xcaURGAG6siOme4n3w9Tmgm8BQ=;
        b=KcxdCjesOqK0/T5PIv5sd/rPBG6ihM4faOkmrZVyrCPYf0eOUBt/Rwcct4RghGDQ6H
         OXNaC1MZNLVh2iQv7kiMPo5HTt7I4aF/fLQF3rjfgVCZYEKA+F2pxV+nZtjbVaEYezsj
         GtyPCoQywFsoJ+jGvRI1lZd9EXhlQ4No5ePZOrY274kVutpPutbHRff7j+dBifva90KV
         p5Ok6fg2kwxTmiArhFoOqwogvptzUWZcBQrVVZmb812ISobK/ZxX+QZsxIS+M+RzBflG
         Ohp6mLE3mi3LyHpCFHjC0Cwx7xlUKhau/XaXkS6dRwyuFbAzxLc5mYMS/gEfFv/O7qpf
         xwng==
X-Forwarded-Encrypted: i=1; AJvYcCURRtBr89GULxXCF4uwFJJieDkQvoaanToiGzfR2zofE72GirGQmJKM/cF8yL0TvmifyJ07nPt0pk9gXA==@vger.kernel.org, AJvYcCVctDcx5tSJoMZt90oUuKEsnYVuREbHaXntHtiKgt6qOwgdvxOWMnHbwOLVl4eaPHyhoSf5LVGplSzuN5tL@vger.kernel.org, AJvYcCXwPvyLCDd15txIkCIjOdAkpwOp+X15mAYd0vnk56/GvmKuYyQfSyNWfLNUY9mcv17i/ClVLpfqZiQLxscdjXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwVeiVquAD2ZZxToExJySfNoCX7wiSdRK05pdIEJ+x+sNva8C
	kgu4MzC7H+Fla6jqwdfRJolq4d2+X/EoDTGf1055FYrsy/ftCr6SJvJ9hO2FQsgyNHcxicSXzwq
	6AGzK9uv5yTBerxPjODW8ZUboYIE=
X-Google-Smtp-Source: AGHT+IHUvMZPMuS0dwTCPpV1fb4vk103aZV7zFoBUaL2JHMvrqUOUd2VWnTQR2iaAbvoynvg4bHauO1y420NjlcMJ5I=
X-Received: by 2002:a17:90b:3ccd:b0:2cb:4382:99f1 with SMTP id
 98e67ed59e1d1-2d5eacea29amr1221233a91.6.1724240219567; Wed, 21 Aug 2024
 04:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815074519.2684107-1-nmi@metaspace.dk> <CANiq72mCsBO01FHbf4D0h0yvTV=TbpgO-jeTHLL39ae-JpMLZg@mail.gmail.com>
In-Reply-To: <CANiq72mCsBO01FHbf4D0h0yvTV=TbpgO-jeTHLL39ae-JpMLZg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Aug 2024 13:36:47 +0200
Message-ID: <CANiq72mrwBs_YTcBvge4ME5bwSLKbNaoFU+KZw3EfCTyGjiJ9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: fix erranous use of lock class key in rust
 block device bindings
To: Andreas Hindborg <nmi@metaspace.dk>
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

On Wed, Aug 21, 2024 at 12:50=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
>     [ Applied `rustfmt` and reworded slightly. - Miguel ]

Dirk noticed the Zulip link was broken due to a rename of the topic.
Normally I try to remember to convert them into message links (which
are permalinks) and to shorten them when they are too long too -- done
now.

For context, Zulip is gaining the ability to get topic permalinks (see
https://github.com/zulip/zulip/issues/21505 -- we gave them feedback a
year ago that it would be useful for kernel commits), though I think
it is not exposed through the UI yet.

Thanks Dirk!

Cheers,
Miguel
