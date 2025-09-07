Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3E2248BD;
	Sun,  7 Sep 2025 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757284208; cv=none; b=BSj0amRE6q5BoihSv7LT3T+uwW3d8WRe1tXHaqtgJJp/gstk/zHESwrVr3IORaJ5U0QXfRlpvjdiDu4r2ce6ynq+KvVtJgWGDVMPcq1whkEoGbtnhnfWkb9OYRAsjO7oQVGUFoa8GNx/DhKshE0LBN3JWii2taBwo+f0ckmQbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757284208; c=relaxed/simple;
	bh=YiYQFvOAi/L3rfcO0B8Dn3oJyiTeX8xkf4kbnG9dX4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXjjGAtnqoGt96g0g0Kx6t2XHndhG5i0qjv2jXBoTyPm5qqN9/uGaBiaDTlKrcmrQ5oi8JiSvK5AUwh3Ndop98TTsvdaeRijC/ZbmO+qhVyqanecd93k0kHEc3yxYs43HwLvRsb7abGEfN0wO/8G9w23QvQL1Mxhqk/MVihKsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLzOM805; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLzOM805"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24c95f20117so10478005ad.3;
        Sun, 07 Sep 2025 15:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757284207; x=1757889007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiYQFvOAi/L3rfcO0B8Dn3oJyiTeX8xkf4kbnG9dX4Q=;
        b=nLzOM805mrdxtkMBZHfjhD3mrqfoO9JY1fp4lWv0o3X/ppOt9IWf6LuCSfuJhiTL6o
         hgOCpy9qZ7J/313U2QdZh2Iuk6QMjXf/EXPwJf5kaMCyXG0MtjTiStD782ypWjAvEPTf
         0ZfZVusJ1Oi2pW21Bt+zyJwJZ8xNajq/dSDEbYcs/yJfbtUw+YRBJws5iK46CRASTcm6
         LyibQz5luK4WquJydcD+g9dUnHJce4WrbNjTk/Oj/hUega78ofSpfvx2xyzBZLEyeGsF
         VGv+39PhUsp2ihsWjrfpBk/Z0z5hKee9hboS43ZqyDEXilQyuLlJjXylYyVcF5oVr7VY
         +muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757284207; x=1757889007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiYQFvOAi/L3rfcO0B8Dn3oJyiTeX8xkf4kbnG9dX4Q=;
        b=KCO7XjoFCwtrzBuXnCmd+PiFV7YrNUJzWu/ZTN8YDaQ0D4oRmLB5mQC8+qy6ckab5X
         pBOImuMBsotkoDdnSDCnz8eLg8oZJzqLLuBxnQDDMnIaoLUzDIr4VMPcHDXssSKst168
         hgCFY6cipxZUuMh/KeSKAuA1o79esljpyZVfGMoOzudSMOmMqpbawLY1p5L9V/bJonjZ
         ADDDdbV1nnXg0Fd4hzjtgSbqQF8T18i9w844rYZGA35I2y5JVFrB6aThPOPH1fIrgmRe
         X2PZrpuPFYCtqqnx77qPIQ9WW4xzfKZEaSByKDWnTNSXHEvbLasUnBGTZrT1SuM3ot2/
         3XYg==
X-Forwarded-Encrypted: i=1; AJvYcCU8vQGKfRNcQqedZTOTQ7HCDKk5lVRhxPF5qNziIWDyAIXKe7EBT14xSmjhT0V4R6owNB1gMZ3zp6uZ2Q==@vger.kernel.org, AJvYcCUE6Xifau55j7geJFJP8K2KnOAqIg77oyPJdaUuVdyadY5EjS1ZdlO5dgxc1ipUI/QoMnzkM2mZGcBzzUYv@vger.kernel.org, AJvYcCXrvfiGg1B6+bbshoFUxeFX4ptwpvM7nddYrTHKmQGRGBcYCkuILKwfBkpkua9CW1e7uLxsrOwwekYL7gzXKHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDF9UzADJLAAUtvue+2DUgDLZGidRtiNNp4cXk6S4lDlJ2SAKi
	B3omXINAmy1kuTyPzM0Q1ZZW4PaZcHrFakjbdQ44NI6gYh/1UaHhnfUjIf+Rz2x0+6GXdF/ZLsg
	MDn+8WDYKTZa050kqn7ibbO0zsG0Z5Gs=
X-Gm-Gg: ASbGncvb3lsQDjAeYqW98Ax41cbSVRgAckTJY0HwCk48o5VXCoSYaHWe8xXXTKDE9Sk
	5zo1w0hD74QoZsDMRbODnXShATk+vmkkLRuI73F9PLxJB+1EBaIbmLOFCoNVXGbRsbafch0IUMM
	noAECKucLOgnpOSoQ5iwPzGZrL4mTL0u28MiWGxymDvCi6BAwWCIxn23Da3uyQzNEUbc5tHd3Xr
	FyHEd0LV1lEHSLgApUIiUu7trbFVtxMvE1W8sYq6HUFOKgYg2PZVqqnHxLjm8ma4MO56QFSVRx2
	qTu0jaebUWgxch1id2YXYEOa2g==
X-Google-Smtp-Source: AGHT+IEJXHXVeEXiUuxDDtDL+F2z+Li35l5mEMwus84iNqmeDyb9GLSYacR9e0Qf9AaGo8FSywEfNdNTn/METasbJfo=
X-Received: by 2002:a17:902:ce83:b0:24c:b881:201 with SMTP id
 d9443c01a7336-251757ba959mr44510665ad.9.1757284206873; Sun, 07 Sep 2025
 15:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730130716.3278285-1-ojeda@kernel.org>
In-Reply-To: <20250730130716.3278285-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 00:29:54 +0200
X-Gm-Features: AS18NWDiFBEztBvhh545-DHfsVGSBiVzynGVpEdm2_GOyJiuoW_17RumQHpRyQ4
Message-ID: <CANiq72=gYXqcXyVK1vq36Y6ofv4QQiLLgnAY=zhFVV8CGYuziw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix broken `srctree/` links and warn about them
To: Miguel Ojeda <ojeda@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 3:07=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This fixes a handful of broken links and introduces a warning to
> prevent them from happening in the future.

Applied to `rust-next` -- thanks everyone!

I added Cc: stable@vger.kernel.org on the fixes.

Andreas/Boqun: if you don't want the block fix, please shout!

Cheers,
Miguel
