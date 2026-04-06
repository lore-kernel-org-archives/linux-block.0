Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04D18AE2
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775481690; cv=pass; b=A+VKzxExEPVDHEppoizqxZQWlWQiotMmWSHa7lgY6JUWZYo5DqIzqo/2Amy+Dy8ZLdtx2ARlpdvIus4Ur8sx0D19I5fuyjm9L3IlVO7qrZjVeCLn2T8Rrz0wAdnrZUlXYkk4INRJPdiDithZlrwNYrbpri9O/AN2ZRQH01+fHfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775481690; c=relaxed/simple;
	bh=Xy7FALhcYqLgXu4fKO0MtrrfIdEU0qZJHPfoz//MdsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Od3Sl8y+EfuNZoKTasErAdkBA/FOiV3IxSZoya0HTYw0UtPDhFDnDOJ/KMSK5JO+qpeDC4G0zbRwLySXQIMPO4HNAJwUT1tkms9skAd8MNOZrbclNPVueDTd60sVUEm0ZefSgaGN8IM/gP55sNB/RUKKgjDdgbkngFkawaXWY0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q3tAGxOy; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3tAGxOy"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12736a0147cso216404c88.1
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2026 06:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775481689; cv=none;
        d=google.com; s=arc-20240605;
        b=JYFcdIy5AaGorCk+NUIJQ9uH/bh34c3wTod/2wY6xZvJZLIRPSnDEK5CPyfIQBhz/m
         s4S166eFndfWTIve02fDeCUkic/B2bouYKMtKOpzFeRs0GSyjvsth7zS/dH5w4PwFd1N
         /4IBql37R66X7L/iQEUBQhwBA4rvb9TFuDwIwdqEGcRSC90+ZE07SUJ6DHTVblyIAsfo
         fF7sCBP0J+8l2f5pIVH5TX5sb66F9nOuUZzPlw8moWVJ71ATSwzpPhetZkgKEkrvlAzV
         mP/XTXgEzWBPUc0BGa27yll3m0HxlICDpbE57ZrEQtOOJvAGFGGoAtyHpkBIADs5F1hP
         kGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xy7FALhcYqLgXu4fKO0MtrrfIdEU0qZJHPfoz//MdsY=;
        fh=TQxQY/OIebHrdKOuBeeRs78PW6wHVFBKSzUkFxHZJK0=;
        b=lh8X926n3WWqTC/9mjMIqfFm6W4JrdAKbGnSgaVd8ub7GQT5FovUK3eX+QP/T2B5mC
         fC1vOCV/2owBydIDc1iOdvM/lEA+EwZRNlLfkTeLOONRx5R4gW5tafpjSyZK1KDhucFQ
         CH5CSZjkbIfVYHVPTJ4WY4natlNNmgPMhk6hne86QbYRsegREIkkGQ5v+Ie8SyhQNHVr
         VNzBB0BZ/J1CYZlLJAOTR2onZYMqMBUqjcYGnkmtZp/B5X1ckKtocQy4kEyE10SW79PM
         kpVV7DUvgXD3qd7OUyauv7Q2Fkt7P/D2RLGRwh1FIvvJE/kle0tUzkhDGi7FTZvFu+P9
         XcYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775481689; x=1776086489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy7FALhcYqLgXu4fKO0MtrrfIdEU0qZJHPfoz//MdsY=;
        b=q3tAGxOyAaMZ92oiBATu8FQ/6qRm0r9euxaNK8TPoIYKXv+sip60zW3/mf/067CojG
         I91sgXn7EWKEojoel0sfV0c2x47kc1MhplILMewUkwkZaBCCr0pwNk93ApwnYy0wO6yk
         wzk4NsK4gNw4WQ5HLxHU+akS5jt/VzZUPL7mw5Z8fzT8N/hLAXQzM5TXL+PsqtJbutvi
         8uYoJs3WHDvwOVOtXEYQeWWHvCxe1gwgZnfpVYwrKTEHNlI01LkDdq0Wvn9M2UetAjbD
         lUoBO1OKkgxrsLb7uoE6JiAt9LFTPTHQt2L5Jm/D7L6biFMlveXZMrm6ibprSlWxXpbe
         +9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775481689; x=1776086489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xy7FALhcYqLgXu4fKO0MtrrfIdEU0qZJHPfoz//MdsY=;
        b=CQBrfiuW7kkq7wk/PMtk1bigDgrS+VOzGBVR+g5wGEf+vS8uZw31+nTvQ2oqpW2Ty3
         GqG50YNC9nFBgZm6YmB9fo74Is7hlGRJ6DME6jbfH+DSRyM0EWz8Nlz5hD+P6K0jdtcc
         LltNB1yMqfMWRUeijODub2yn38pwEpZczAL4BGCYLD2/phElky4dKwLoXAgSDvNSt5IF
         WXlZyzVjDxpiJQ8D1usnrJkNI8CcCHoJOXmMW2kT0rYOHe+rJdnQSXdGgpQ9A3PqkRTZ
         1RQPAmeuW7h/YHrW/TiG3Ee4wVusKXOBLROMBfAOkGzTK6fJF8bGnhldgrHM/rajNYGi
         JXWg==
X-Forwarded-Encrypted: i=1; AJvYcCVLHQeoufZDfLOx9s8yvo0fy/q70hjhyOTIUXlglnS95yyXlXkpCvJLyHP6gq3HOx50cx61X6KX1L3Upg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzgQ/+1CGEDnVO80rNJAD4adbiFWApv2BvQi5LB6oYyzQu9YC4
	t8xPmh1C4X1QZXU/dPXpnbe5px6uQvEwn7z227Zovp80+fS1XDwIG/88LdUrKt+9kF19KcFGoF+
	QNlF07vK7Etyq5f1Wuice/UsgmaoERzQ=
X-Gm-Gg: AeBDiet4I5BepTAOYrnPjPAXc+J9LXWinMCEv1RTatrDfYnVGolh213I3fhHHBIll9i
	GXEUDg4/XrtU75+rJhmZVpotaIkq6hUR38baVKt6OCTpz2hhaFtfNYAphNt5PwYW+pkMUPbx01/
	VEOnWYkgzj9jojgxL5r82tO1frfDU0IF1tf6A/5brXMpWpxJaH9jFZJJRe+joGDof884D59lsxz
	dN5wrTEZORInaRE/S7jzyxuSni1cU9UXfdvvpt22ARUCjQCnACrEWKDwKKvkYZPpyTba4hezmfm
	XBV8QFlNrkZZJvKqx4ldUvBx/3WTlkpjJCThnpUQBIu6Uyxy7CYvw50JNzVHUX+VsT+4kvYWnnU
	Fo9PGpg0Z9BykDO6D9T71quQ=
X-Received: by 2002:a05:7301:1007:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2cbfcf52a13mr2965052eec.3.1775481688630; Mon, 06 Apr 2026
 06:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-34-ojeda@kernel.org>
 <177508434476.73816.11744805605122440072.b4-review@b4>
In-Reply-To: <177508434476.73816.11744805605122440072.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 15:21:15 +0200
X-Gm-Features: AQROBzA0LUfPYuEZWH9uKj1KexaW3DTNKfQ_If4tWD7xnq1YUXDcYUMRbV47V4E
Message-ID: <CANiq72=25GRao7NciojymdbZN_=f-U3hp2+2qBMjb4VCaOgR2w@mail.gmail.com>
Subject: Re: [PATCH 33/33] rust: kbuild: allow `clippy::precedence` for Rust < 1.86.0
To: Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:02=E2=80=AFAM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> Might be good to retain some of this in a code comment.

Bah, I missed this note among the rest, sorry (I didn't reply to the
ones where the commit went away due to the changes in v2) -- I agree
it wouldn't hurt to remember why it is there, even if it is already in
the Git log.

I will probably add it for tomorrow, especially if I have to rebase.

Thanks!

Cheers,
Miguel
