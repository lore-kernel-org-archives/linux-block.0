Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C39244665;
	Mon, 11 Aug 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909055; cv=none; b=c+pJH07tKnZ3ziCEE6A5SlSY8YmNUZnd5B154EZCtVYRKfU6YbP1+HqzoBEr38oCNzk0w7f2IMf/wTOgFTAc/ZLPkeoHucc4Rd/fRF9lwCSoPY+iAIAsUCTJyW4dj9t6SsIQL4D55vNrRy2dXKsH5CRklZMIQVy6/12yODGFhro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909055; c=relaxed/simple;
	bh=gfZ7G0h1i+MM8nYnDnkCE3r/LrlXSMNQkNtx8jPmfrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HX2XSZqC8yXF4OzAxT/2ePaA9OQ1uAMyteDSHYQu4wx8zFzEs+mvPtpv63cOfJT130QNyWz7W4CU3R9O8e5oE5f5oFn6kmbD0RAP+jkCZibQew/Pvf8bpuJN3LDRelQSMz5zMzNJxhLT4tVVn8ImS50w73pGgWlPHd933JYW/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFEj9Oqg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFEj9Oqg"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2400145aa5aso4879585ad.2;
        Mon, 11 Aug 2025 03:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754909053; x=1755513853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfZ7G0h1i+MM8nYnDnkCE3r/LrlXSMNQkNtx8jPmfrg=;
        b=KFEj9Oqg4DDrC1xAZm6k8a+ZDg0y55BVLw7VcCYoSGTvY8+vUrjxuG0kXy/XiorO+J
         5Wlv0DcFNa+lAMMFs79Rjbu2tMdXBnUdcBz+0wyx7aC51WgTQqWF2iIT4c0frtl4/pIh
         yEWiSsB8eKdr6S+3wyj/4BY45hUXvLn2jrDw64FzBFUyRskB4Bjgmz3XIt4DrqF/1mIo
         +nPi7ghi5KeXuv7eY17Xqsusjck5ACAUCkY4JWj3Xofk2qK5iYgKScsd5xyPl3XqBmMf
         +t/uAu2Fxvmz2de0XqPU1pEecNgBOx/f6ixsej97mFhQwlqvaS1+LS7HKPG5OGhLWOXJ
         ehzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909053; x=1755513853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfZ7G0h1i+MM8nYnDnkCE3r/LrlXSMNQkNtx8jPmfrg=;
        b=cBHfZtea292c2Qa0M+xC+OGgOfkBdjsgmie9GrS5Xyc1hTzYndGubEwKggW6fqXlfS
         pA0X+yfPHpMrzFwFv20PeSm7Cg9Uxe8MKEAbqw3msQxJQAjys1IuMuAKhi1um3WwTgDf
         1dUFgMFtwTHxMr9IGoPx5lyFFE5J7Pnt4s/aaSXalpd929CfWZqOmIxCkQCs7Xp9FPzJ
         WXMXcJfgM2XSjwopDJsskbEoSyZnvIKBRTU6+AIt1Kn1DAoZ3er/l/OTwXnD8xLSVOR7
         Sy0MSQ2ei756zT5kJZXbAOY7d0n9S0CTj+9qlvgGoTfpwsf9i+uPzwPPQEaWC2orX3cd
         Zzgg==
X-Forwarded-Encrypted: i=1; AJvYcCUDrZawKEGdpjDYGc/bsv/XfW2Ly0nRnRnEGFr/BEJ3j6DuTAmvztR2BLkcKSEwC2D2M5h7KsfCOJJhea7S0Hs=@vger.kernel.org, AJvYcCUMoRTmNOpZIXocD9vKws3witu6KMRUcD71yMjO/l8dYQRB7hZ8AXAriEklG/eR3MLdMfr4kxsYkXegZA==@vger.kernel.org, AJvYcCUu5tcHNAdSyZPRWgfu8qYbO8uYrbVOJKS1Srf1ZoiPJEUhpXG5lIBS+dVA/gMz7mny4N3CHr/CiiZqUMp0@vger.kernel.org
X-Gm-Message-State: AOJu0YziOj4MzRcdNHAbBbhtCwgk33uEkFTOimHel+8t3zywhbsdiCsg
	G5QfpiiYE6DvVSXhXbeL3KG6fYDkvOq9g+6sFWqrdC800C8Yn6mYa2zvuGzbAVvy8GAKn4zpvxP
	9WULtUk+qzlLtCeKXEr/e65ppe2Xw64I=
X-Gm-Gg: ASbGnctKpwmfYRLY9fBuKCSkpqRZj9SG0Gc4O+jiBW5vV8oOl+DYrawlau1IZT8mI8c
	NWkxVAXmPKQ7o9lpf0gfXufu0g6zuqVXANz/Irx33v/4oWFZZyZyRiF5n9Fdg86eQ3cPkYHe6vv
	gl0XulJUfMD2vnKcfiLponuDzZ/65Bh5xwpUn9xC16bXal6n1J4Pal97O4GSbVbr1MWRm7sWmz8
	y/0gixe
X-Google-Smtp-Source: AGHT+IHBEayTjGLrQ28Nl6YgJMqiLAz/4X0Aw0J+moveKgZE67C9fl06ZhkzW+Q8uCam3lkMVIjhyTvvbD65hAoMIKA=
X-Received: by 2002:a17:903:11c6:b0:240:8717:e393 with SMTP id
 d9443c01a7336-242d6c0062emr38009075ad.5.1754909053302; Mon, 11 Aug 2025
 03:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <KnSfzGK6OiA0mL5BZ32IZgEYWCuETu6ggzSHiqnzsYBLsUHWR5GcVRzt-FSa8sCXmYXz_jOKWGZ6B_QyeTZS2w==@protonmail.internalid>
 <20250716090712.809750-1-shankari.ak0208@gmail.com> <87cy965edf.fsf@kernel.org>
 <iuNf4uKy1tAU76PDHMl0imyutwtKX6ih6M-JYDuYoQFmEx6VPeRH-YmY7Y76fWS6ORuhrquUVGELY7dj0r1MkA==@protonmail.internalid>
 <CANiq72=Yb=APVFiJbdveVD45=fwmAbXR3vUXLTBfqu_n-BpcOA@mail.gmail.com> <87bjomguwl.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87bjomguwl.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 11 Aug 2025 12:44:01 +0200
X-Gm-Features: Ac12FXwKnNS2Uil1IBymCFdkc9yuEKlRejX_BH56vg8mj4EEUhAy-C-uXdK0J_w
Message-ID: <CANiq72k_+eA259oEq1fBKCOVOK+2GCAwqF_JfweJ9A3ih_Px0A@mail.gmail.com>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports
 from sync::aref
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Shankari Anand <shankari.ak0208@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:49=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Jens is picking the block patches directly from list. I would prefer
> sending a PR, but that is not the way we agreed on doing it.
>
> @Jens, do you still prefer to pick the rust block patches directly?

That is fine, if Jens wants to pick it, that is nice. Otherwise, I can
pick it up, no worries.

Thanks!

Cheers,
Miguel
