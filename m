Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8E29AB1A
	for <linux-block@vger.kernel.org>; Tue,  7 Jul 2026 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429471; cv=pass; b=n3/gGxCHc51+0cet0WrFxkGChXWIQd595g2hcKC/XvX5ZqoWkVXKEUc76lYgOEv4fIaEEnILCGQi0nQBl3tZENVWoUcPol10R4YfMR+GT2vbA/JpcE/7iRglEodYh0E3XKtNHNTmUirZeoRkyVDsq75iyORHnefC1xuYFk80Nqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429471; c=relaxed/simple;
	bh=TmPGIYAzJvC80RsuDMRwEJ1EsP9UZtxlgsFYi2qUwwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jacQAMXrDoHLK1nHZh2htTtAHYpwd6/vtn0MuKns95mRyX5F0NXHghSG6gBDkFJejXYkBFUMvYQuTkBD44YT0oIoHwA1hv+NZ1BCSJnGWt0bOaN6OVi9pturSbeQC2+ajWm8e91FHKKubucduM2kpCl94hFrYTSGseP5K56wpc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ms9sjocc; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ms9sjocc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c733f15aso40224685e9.0
        for <linux-block@vger.kernel.org>; Tue, 07 Jul 2026 06:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429468; cv=none;
        d=google.com; s=arc-20260327;
        b=Iy9bY0CIeoXKTT96jBgbruHPuqD9XN5PdZPTT/Kj3FYhPdi7Wb4GPRJo8fu7mATx2m
         Bx1Arzfri8L8/nwriX+GK4ZX6LzCaebo/t1BArXXIc4tRSHEDVdsVIjvENaH+H+o8aiA
         v1EPFILIhtIzQSgzzUh3j8QdoAXJAga7aHxWY4/FzJZbpmCvkh6SgjANU77edsku5aCQ
         J/IwsSIV8Zg8EGXl/eKNzdmBbMfPkxPwj4LkCTPu/cfDD5julIH+SZZT9aPQ6laUzOGY
         RC52zin67JoNZ3iAwWjrIQjUj3FgPvKHP3LcAJcBCEhcAHcq74+oVBlOy8Eo1uGVgvTr
         /6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        fh=xSgupEUIgXxNgPgnbvQLy3Nj8vitmkYCjgsewTT336A=;
        b=TO7w5Wn3zu4LzAyONrtTtWKHG8eRIGEv/XWDOfwfq7uXS4k2J9aW9sfqs2xsO/q0ib
         CxZ7jTZtbmlDu7sbh7kFRXtMtrCU0cAbBKc66GrSVRv1GL3AW0oXERuiLQqxCcUp11Wg
         X2I6Q14DzoUOSTYQEnmFFJvl9gKwaDsa/bZv+wZviN8pEeAuIeaBlcxbeYdUR//AuvRb
         38WETi3/g1ZoulCRSubykTFwGI9y+pglPJfcmJ8pY4yr9qxoRtE99XTqG0vzoLwBpjdT
         fKms7CvP7ztwhzMetRqBQFAv3DCuUfTHN7uIlKINzNv5UM/WA34EY2605wJNaAqCsYYD
         QXxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429468; x=1784034268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=ms9sjoccakeibCPPp58QE7ghda6Dlji46Cv4t/6lQ3UBQUs6sbFmf+Zk1frlYhpSjC
         smR4Ma6z+nWExHAKSVr2F59HCBLD8r4Ix4yD78NVtT9w6BaENGgVVyne3D85g0UkGFqZ
         7nq8JTsuFBzYHVRzdIpC6m9LTC42H8jgRwD660UBUky8L/8jN/v4iySlycu3QDWDQLm6
         SrTyG9J+3Ra9tn3qcOsu3QabfUOtvyTI/TaVYPV/dX7TgGGJJozWlrrZj8SxQWIJGN6U
         uCWxr25ek/UpzMB53FkCe9KripgVi+fFgz7aqpsAjLaQBXvWT4+VNwli4yWVtUJ/RlgU
         Ciaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429468; x=1784034268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=ijyoCfn1Q6T+mJI8kIohgl/3ZZSnaKSjNmbids5/gB0VlnDNyizgIfQ1p814pn8RpG
         hza8ZEf2nQY6UpNr/ypeWYKd6tX9schfcAMwX2GL6ubuwNX3NtWjL8Airt2KhIUjN7va
         SFjad3pEG3XG5zWzc+WwJhWrgvORZ+35iFfOQhKmSFjcfNBGhrf7rHcJ0Xf2SYH8hGFE
         1q9sJ0szoEix4DvlkuBAZN/2NcYUGMAnjizmv5OKlx3SWoe0XHWsEecglK4UeIyoUcYi
         xnyTvhYbi5f8ePNOA/iRW4mpAAtBP6DdoI8r/MxToqipnBH/FNhATCQc1tWEcQiC8WIA
         y5RA==
X-Forwarded-Encrypted: i=1; AHgh+RpziJp2aMd0QkovujOTwMYbZabT2Ydd0ROBGfuCZfA9SnHHsQy3YVVAWJod1yfCGOcCI6e5rDuoE9vwCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylyLu/wYcFTlpIAWNVucTe03MMmIOkEJZWWfd9WvMXwzVHeXwq
	zzvgmAU5wOFfW88Fq9mB89GEaTvnB7KT2L4ewXP+3hcbwvHUGkoxGlTQnGyCNu4gP8k5KCrWjpR
	s0WXtQf3sh6jDtSO8KhGUag2NH30iLmuiTrY6cmaG
X-Gm-Gg: AfdE7clS8zZvGZ5EGAs0lQ4MxHN1zb9UI4jrWrza05ZKrWoARuN22Ao+ijpaHJ/UOJP
	uf95CCZipne33JaHgIOa12BrT5hobP85EYyoRaJb69ZKeIxJpejRnCZlj5mtxL2hs3uqavNK4u+
	sYxsAEOTZKQW1pNkJJxCCZhkr5xhCaPw/blMk04UQhNpUC74c5Op4v0AKIM1NAP8tDFfSuD6+5j
	Pyd8PpzN87FiZOGOk7Jxr4rINtX5bMfruS9NbYMdIanNVa0EbX4VGWyD7pImadLN1e/25MzLOTL
	9ZIkowYoEqTt5r1Mkv8MEArtzUs=
X-Received: by 2002:a05:600c:3e14:b0:493:bc4a:e7d3 with SMTP id
 5b1f17b1804b1-493df0a08d1mr56240095e9.39.1783429465838; Tue, 07 Jul 2026
 06:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:13 +0200
X-Gm-Features: AVVi8CcTh9Rs6YX_7yLE2pYLhG0EOfuYJdmTfdwdI6hvKkhrcisIrByGWFuDPNk
Message-ID: <CAH5fLgguLAQG7mUwD1NPECYSsPdpPD_tLskU3NdwLZhKR1H=aQ@mail.gmail.com>
Subject: Re: [PATCH v19 4/8] rust: page: convert to `Ownable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:56=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>      /// Returns a raw pointer to the page.
>      pub fn as_ptr(&self) -> *mut bindings::page {
> -        self.page.as_ptr()
> +        Opaque::cast_into(&self.page)

cast_into() is mainly used when you have a raw pointer to opaque. When
you have a reference, you can just do self.page.get()

Alice
