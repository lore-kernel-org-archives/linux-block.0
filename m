Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370CB217723
	for <linux-block@vger.kernel.org>; Sun, 19 Oct 2025 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909135; cv=none; b=tSjAEK/DaeUBFsucWXM03tkE30uN90y5bF3ovwFz33AWsYxCyFvuDS2JBa88VboSLrWqR1G2upANViwFRStczcnye/9hP2Rk8nKmfAWOduku1ngmIczZe6H/lnOUQVGkIE7vb4YDhM4iWhfeh8ac7OAOt6iIJY9CF9WR1YkmniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909135; c=relaxed/simple;
	bh=ycAfcyNNCDvL8r+cj6EK2T80BYm3/AHXV1y+txWFqzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0CCCZRyuVBNSOqS4YReqpcjTGNYpQFgalKX5xpjOEX0qvTC+tLS/wPCdeE2pVQfRQBf0FjaSHuGLzSFAffmw76cxW2V1bNS0R0hkF0+nr2x+ZM1K+IJxGoURGHlPYzY5zo4/xX8jG8sBcPUrkePYvzgNsJFMtmiYjDCk5rDXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQpBR7TD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQpBR7TD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26816246a0aso6697705ad.2
        for <linux-block@vger.kernel.org>; Sun, 19 Oct 2025 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909132; x=1761513932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycAfcyNNCDvL8r+cj6EK2T80BYm3/AHXV1y+txWFqzI=;
        b=DQpBR7TDwXQXpp+mLTN7vd+6pDnwCn94aRLrW2xwzkgw2/+WaWr58QDfXIvSUuAqDH
         QI5muLpHKfPn+kWy8wAqnTy2Hz31tHhGBgTx+c5edPcT4CdtCPp6IAaL9QhohOyWsJqV
         F0gc8tvOd5VhlugYbumG8RlBw6JFDuLefCoaGv4PkXl6L1O5K7kQC6tfeJqUTJwSBWKS
         TXT4b8Y6ZacsUC4ZRQ9TuhBoQZlu7GnpToYI9ONvaFVFevnO97oqkMcfK6zLeIOeSy9m
         dYb3QfBD3pHg4Ub8DkC9J9ULr4Dw8dOOSDOrVKhzGpL/7+sjm7ZWulyEvcPboG9mvKaz
         rMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909132; x=1761513932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycAfcyNNCDvL8r+cj6EK2T80BYm3/AHXV1y+txWFqzI=;
        b=nRstsvvC5h81n9ib2huYlhC1GO5vCtD+LVb3Ba2zv3ll75E/IG1HC5NMK/rtx/h4sv
         cFdrtZnKeNhFgvFdLUtFUSS2Z35+dRFzBdsPVPlsG+hh3bqwK3zaNJYsLkHXI/p1otn7
         TEytMao8HfE6Fv5o8cR0Zwq8zdMuNtYQdlGPjUDXjN8uGnBcHItkQYSPZddgXQqbzhwE
         yY/SrMHencSq6uBUyp6Ry59TfSBtYbJpRS9jkfqLHQSa65VbFacOVIk1gAhcAOT/Izut
         TY2QEwHEwBQvJqvjGEeE4FuJIQPMAGsZP4zBWRMoM078ho5JdlFSRr3LChueOsMq3Bi9
         nXmw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ72sQffkSqWF7BuOSnj2xlId7FYxNzXhBAzzIrZjI9K3h6PRK7soRS2FXuk0OPCI/Mw/my6K1r+fj7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3mLmiJ5ByJEkxle+Wc2v56V4PaD/T3ORAXVbMwpmLIObpXwXS
	z1wzR9s7MBlns2ZNcGXo2ZeWwrdOZk7HGhZEZEJQkE34PH189ug0NPD+Z/uAUxdohnzk1/0+APy
	S7raGFHlkMVl2t2hQiiJoJ78c/nSvQMM=
X-Gm-Gg: ASbGncuqTSojBJkNeWNCQEHIAbixqlRhEzWXx/6DezYzmqn7fJLe8r3h8K5WNb111q0
	/59ZpEhe5GusX4BF1OhZPMqs4YP7zWgi7YeZT972PeAsfK6x4zvh+JKBNVeMou8SBiY8nn0R3jX
	eM39rN7q8sKMyUJ/zw+18tTv8DWI/SkJOfToWTxYtyp6XVhHZdMnJqOwcQRoOhLqoKANDR1zslw
	W7pV8WrQsnAQ4Ihm5k+vyKubQRgsSB2F0CRm/GYpJmnmWlSWxQbYDvGAoicxyKm6Rkrp5H7nX7W
	hIq+AlMGJK6GPEdfSag9iGlC9jGYSbdM/dQIx8W/bJarPeJqdUQZYKrN9WDpK5PE8OqmwtJbwfm
	0C7n77xchHwIClQ==
X-Google-Smtp-Source: AGHT+IEqij5v9mJs5/CWA1m9c2NrE8PMDKfGOLkkgvIBrH2S+dVqx6DMlKfweKNo3iNjtFuT7Y5fW/l69CjJHY+CKa4=
X-Received: by 2002:a17:903:b8f:b0:290:c5c5:57e6 with SMTP id
 d9443c01a7336-290c9cff139mr74090165ad.3.1760909132458; Sun, 19 Oct 2025
 14:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-14-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-14-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:18 +0200
X-Gm-Features: AS18NWAMycluR5p3NBfaTwCbAsRiC2-Lwc15QqFISNzvPKOcYBFx7NoYnd__ov0
Message-ID: <CANiq72md2Gt-UUpPdnoOimUW8d+M8Wp=9jDTZ47NzvruhfP6+A@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 14/16] rust: clk: use `CStr::as_char_ptr`
To: Tamir Duberstein <tamird@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Breno Leitao <leitao@debian.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev, 
	Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 9:17=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=3D&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=3D&[u8]>`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Michael, Stephen: I will apply this since it would be nice to try to
get the flag day patch in this series finally done -- please shout if
you have a problem with this.

An Acked-by would be very appreciated, thanks!

Cheers,
Miguel
