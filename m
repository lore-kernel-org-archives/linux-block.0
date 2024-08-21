Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB41649C6;
	Wed, 21 Aug 2024 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237420; cv=none; b=dIkNnYQ0GkVk/fOuCC99gIHI1Iyiw4TF8nS9L75T2ly/gognMHPMzYNXDSgsJtkt9fcrfGa0n7jiwREbE+W1fJ+cARsqYn5uW67Zt/llsFdKePC6cptDF2006a3nYAsy3+fan2P2t1yRG59LIg04064GG1mQOC5+X/CdzCS8p3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237420; c=relaxed/simple;
	bh=JXDxYM3WmdtyuoT6cF8661y7zZfPtQ9LFgGpjPO8Te4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeF/CDiEULZHKqSsy6XW6FBio94H/Zi2SMuW2yOnQZvgAsI8YA1Uon07T4Oy6ssQbkDykz1yDxNRQy86dS9dPv4s4Q2gn7em8N2tFMF354AqEjiwzIwo0GZxtA/ZtYz3wSpa3shBpldyzq26PI+1c2G466qsY5h0zkD3ANwF60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsO1ABO5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsO1ABO5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d42c59df79so115367a91.1;
        Wed, 21 Aug 2024 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724237415; x=1724842215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmF4fnNQO06v6glKq1+P4ngcb0gtyYmsdANRi5vGz5E=;
        b=QsO1ABO5pnd9Sb+Kez7FE89ozgGDRxr1nJ1mRQeuqS+r0GHc1pRVZ0CGf/GG8a1b6l
         Ng9pYC/i35JFRAJflbKRo/B2RZq+NiPbQSibsgYU/BQ/jegk8sLki3bJU7ahqt+sGM4+
         1Zu+c+Q6Jn8Bj11Hec8eKAk9QoKlc5JppKqKjfDy1sWfhE6CgLf4qRtzmfyPh3eHzcAC
         f3t5ICbEFuL7IR4RPiAKwBIwtzwZRvTfUS0uoiFM4woDmbgHKq8dEjRHSFDhZnYk8Vmd
         aFR4GDk9xZjdLOixvzt5Pkd7MOMOVQy/6RyZ03ENB3uU0qcusanvvPjwkAXs1rCNtJVE
         v0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724237415; x=1724842215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmF4fnNQO06v6glKq1+P4ngcb0gtyYmsdANRi5vGz5E=;
        b=cnZD7TJ+zzJNgXosxb5vcjkuFcmOTdWZA+4mBkFkFfJc34WgkDvBH9Uk1eLOHly1vJ
         wBVkilEsPQLUEMVamb3ry/KlM/khzSPhDqOHrM69tPsSjnWNQp3UtIyw37RlT30asMN2
         OALEjYqWVHrX+nj1jbqwU+meq5PftPLVxy4d4hW69mHTX2seYwLDuYEiOYmJHQEh/YKG
         3dV/DdjxS5J8Y0aAIy0+vv4OlzNZJlAZdtXD8oMF8QN9BKPfP62uKHMhY2A1RKULKlv2
         yhXVTPhEv/pb/KYMLx7CLdW5cKX1ioMkyySVtqeSSYM/fm/CMwXqtje0hw/fMLga8C6T
         bhIA==
X-Forwarded-Encrypted: i=1; AJvYcCUIjbVOrA79i4BAefa6SaT8zbTO2ikxNLwLXchh/8SgFdW/gL+W/l/nkE6uHhVaLh5CQwius1lDI80FWhZ3@vger.kernel.org, AJvYcCUbdLHOcLYT9UNzyKrC1duNE5R9KfGSEiKUPOpA6ePC3vADrvFul/lO9dk9W6DPczCiKigc7E2OXmYPKUB+C3o=@vger.kernel.org, AJvYcCVoziu6ojXe14gwoOmEgPuHEwoi18FuT1X9/uWgkK3RbrmJIGl45VvkUAp3m6nZU4XFtPW0FzJMzVXOIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysnmVmdPkpj16Mgqyzu8Vz8pLUFLdjRw4y3yCAejwxFsSrQtHP
	c+1OattqxoLKgOScXIGvHb6mYuWFQjp4fanKN0FoZN3hijf5e/1PTg9912HD3vBZFvUiF9iBR9e
	/vx4i1nodeOZ0HACKABKpDEHL4F0n0A==
X-Google-Smtp-Source: AGHT+IFREzv1+qeMvAZLqHsdIGcPJkHZSWdtoUsO7gZARHtF1qJ77Zpp82brKZTWwq1l1xUs2ssU13KhcBvDg5Ho+fM=
X-Received: by 2002:a17:90b:4c04:b0:2c2:f501:20f8 with SMTP id
 98e67ed59e1d1-2d5e98bd64fmr1170817a91.0.1724237415444; Wed, 21 Aug 2024
 03:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815074519.2684107-2-nmi@metaspace.dk>
In-Reply-To: <20240815074519.2684107-2-nmi@metaspace.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Aug 2024 12:50:03 +0200
Message-ID: <CANiq72ncqgRU-DNYqGEZezkNQ-VGU4pYP7XZzKAHkLye_YWbUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: fix export of bss symbols
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

Applied to `rust-fixes` -- thanks everyone!

(I am sending the notice twice for this series, since somehow the
email threads got split into two in Lore, which also broke `b4`)

    [ Reworded slightly. - Miguel ]

Cheers,
Miguel
