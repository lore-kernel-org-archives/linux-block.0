Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D13019D8
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961692; cv=none; b=JfDv/ELbEhpnDvfn3j0dEAW2oDM0v2mGd1xvLJLRAlONSa0QA7GE2OXFoR3Vv/Xq2GBBVRHbE05VvtkhqbbCigrIRxY5U3JWATtQ3rjappROS5gHc7ferDEwDNm/CHUIa91+g6Nyg79h/DuSp7HfZzBMl3E3EmZ8Vg+GbQYGCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961692; c=relaxed/simple;
	bh=nswVLSlbYyIVmMcPMj0v3iW0yfGwDL9+Y9cKMGs77Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vlzr7wMXt1/qdNg1B70Wz93mGryH2Xy5f30lIqgKd+l1C9YbdW1omLczsqGw2NqMFhu0cJomyKsvnQfNsVE/sAaucT6o5qadu+F610EnS1scvGQExXOxFUeto0zcDhlvLNRCtSpb6RaSZE/q6fY8kNpsAyikafdIszgvEyT43Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8fTq294; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8fTq294"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-371e4858f74so52027331fa.1
        for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760961688; x=1761566488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDBqBQPK3W845ufeKNd3TWXFM3Y5p/GSoX4pSkk8Wtg=;
        b=D8fTq294Dh24k4ynoJkyXE2IwNSfRPp5jH050rOR4/Lo9tgzRzr6MB9skBn3bowW2u
         +OCVJlVlqGJRVMvnSjDXeFRaLi5elmN+itRIdvdBP3VuIYQ+bcOwukMRd5OiM969Lvmk
         q31RYPpQL72wGMlGHn/kdBH8dKjQ8CrF4clNwVLlVXR7wLbTsOPIIJk1vJH16q+xMdhB
         btYIB8UHTYYCYTtkJ8MP92rzBT6jbXNIf+HtHFhqNt9Xy33ES7nGzmmVliUJYTAB/i2b
         QeiJl++hSCDft3MQ4/C6i4DATH2xp8IMhSyyKaGWHj6NTMvUyCnus4mAdPgEYuO3ZfJv
         HyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961688; x=1761566488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDBqBQPK3W845ufeKNd3TWXFM3Y5p/GSoX4pSkk8Wtg=;
        b=jQSVazQ8MD4NXu6JHshSeAXXv8oeXfeRovzepTGhe9QYvsAWNbjwwJIruglXW/hGZ7
         ItWPRz86SXaZcCAA6FeMZnkotGs5PLAAccwCsINH9vt5+muLbfsGpyRQqdKdm+FyVhgZ
         TkuWK6sKQy4/gdJdL6u6VwxWRiPInPAGGsfSfsp8541IiKr8CYEQFROTmsTHftWtTvZu
         Ucb/nsWbidNNi0uHl0HrLljoChb1aEMN2v/ZNNCST6EQlZOl0Rd28swMwipn35BZqxOO
         ylSfAsXRWP4yTvAkxRovNJVHbOGOVRAW6IuSjCcASbFxbf28xiLyptHgavWXXidn7e0b
         aGpw==
X-Forwarded-Encrypted: i=1; AJvYcCXZNr1M9MbCGmK6He5Vef8UFJU8ug5I0QinNeUKiNGi3xue9FKHutTzlKwypnKFn+RhZZ/hb8/ah8orxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRUu2cLnpmcmg63WUXzj6TeeyY6MZoixTKmFA282ViT2Kogk4
	XRtr5oPDLmbJ6hi6hN975RnTOPj04hKQ1BsF4W7zVYsEtESbegQvfOm+hBOlJNuSSjCJI49Q8nK
	i5ef8WC2jFZFM1H5nzk1nRWZvrRwDWPE=
X-Gm-Gg: ASbGncvuQ6ASI1i2IDmXo2FDuD3NrV9yoNgOp/V8E+oQhPMHygvL99tY03isqQh4yN8
	ujFAkv7HApkyL9GFaznIeu5WQ+aNBkSl6nF2FjAbNfpL/LkvsKAunJ9SEgMN6Un+/uJAzSrPEI+
	q/WHxiennizOEwZUnI29QK26g09hZAIerDbd/R2lOn+vkEIRd/Wa7jLaukJIOk+pv88LW8sDVBn
	Sow9ukU2hO4+cLCjjwgovQLrl7sxNSprzLgOZCuhnxcCLmGRz/Tsq4j3WinIpLOjwmPpQuzkLG/
	OSZGGx8LrlgPAP178BxXxk/6AAthCko5WXm++njlzKeLtNVzsKiY9K0XXd69OM4RhoV3ENmIF/r
	4A+GWHJNhWvyNDoqocw50Rdz0gpPjfyY=
X-Google-Smtp-Source: AGHT+IEhCuohkwKfudrL4ecEpqT4Pm0eEKlOvtKN3vUBgHr7QNfd5MrUBwC1sgCPBzz/Uy3S9ZB2EUGsXRcV/xV/m8c=
X-Received: by 2002:a2e:9a14:0:b0:36c:b120:37b6 with SMTP id
 38308e7fff4ca-377979418femr48975661fa.19.1760961688121; Mon, 20 Oct 2025
 05:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
 <aPPIL6dl8aYHZr8B@google.com> <aPPJ2qDhxXNh8360@google.com>
In-Reply-To: <aPPJ2qDhxXNh8360@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 20 Oct 2025 08:00:00 -0400
X-Gm-Features: AS18NWAW7Di7K5boBLr0jIlvVCdIJykxaOqzRMhRONzgEFu_niaDAXaU_M-718U
Message-ID: <CAJ-ks9=VJCwKxZRyDHOb7Lun-BJ3tPrvbscpo0XkykmnF_zfCg@mail.gmail.com>
Subject: Re: [PATCH v17 00/11] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 1:09=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Sat, Oct 18, 2025 at 05:02:39PM +0000, Alice Ryhl wrote:
> > On Wed, Oct 15, 2025 at 03:24:30PM -0400, Tamir Duberstein wrote:
> > > This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> > > have omitted Co-authored tags, as the end result is quite different.
> > >
> > > This series is intended to be taken through rust-next. The final patc=
h
> > > in the series requires some other subsystems' `Acked-by`s:
> > > - drivers/android/binder/stats.rs: rust_binder. Alice, could you take=
 a
> > >   look?
> > > - rust/kernel/device.rs: driver-core. Already acked by gregkh.
> > > - rust/kernel/firmware.rs: driver-core. Danilo, could you take a look=
?
> > > - rust/kernel/seq_file.rs: vfs. Christian, could you take a look?
> > > - rust/kernel/sync/*: locking-core. Boqun, could you take a look?
> > >
> > > Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-v=
adorovsky@protonmail.com/t/#u [0]
> > > Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> > >
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >
> > You need a few more changes:
>
> One more:
>
> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index 69efbdb4c85a..5489961a62ca 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
> @@ -156,7 +156,7 @@ macro_rules! declare_drm_ioctls {
>                          Some($cmd)
>                      },
>                      flags: $flags,
> -                    name: $crate::c_str!(::core::stringify!($cmd)).as_ch=
ar_ptr(),
> +                    name: $crate::str::as_char_ptr_in_const_context($cra=
te::c_str!(::core::stringify!($cmd))),
>                  }
>              ),*];
>              ioctls

Thanks! Sent v18 on Saturday. Those `as_ptr()` -> `as_char_ptr()` were tric=
ky
because they relied on deref to `&[u8]`.
