Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582C329C6D
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014276; cv=pass; b=pAYJkzv8rncaw9avB/+ewYiVcCNqqRKLXJaP3tcO4MskGCwvVcgwix9I+DXYIOPH6OnZ7KF5TJB1N787dLZ9/X9pgNo0aCc6GgQxFF7HNmJMUETdPPE2nHMZiw4QwbVnYDIXNR2pjd9LCQ6OthqmVBP/+ksDsUlf1jdKyFFD6yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014276; c=relaxed/simple;
	bh=O7/vXOHmBuDEN6iYoEcXZX9SQVUOxuFM9K3LUsWI6j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIcn2G9x/RP+cJTydHerC33qcXMZPz583ccjkspcxoe7wOAtyN3kFg1/Mw2yRM/CKZHMVMz1hlPZIlI67E7Z5hc+yOsAgNGPNedA+gXc4rDtvk0ZXhpbGgkLLgHAliRiHzB0eZZEbyUYuTiG2gcX1gZTVixq5qUf4YtOFahV4Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pO6mb/Mj; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO6mb/Mj"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304f8e80b7eso400004eec.3
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 07:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781014274; cv=none;
        d=google.com; s=arc-20240605;
        b=MWvOKLenUhHfa51znlvTHs7+ZmBj+vpiNKG9w2KqdyYa5fM/eJCZv8P1PaOTDEjKdk
         M+LHDeXmw1CWbyiRXelC9+ZIa8kibEPs5svV20s8fuT6tGmrZMkuCntgvK+D+Q50U2gZ
         s3EG1n9IJHJphvDNgLWzc/7mcXzDHiQA9vdAsGOf7dJYYH+VEAO61e/0IVmcAIcrq28q
         pjAiCBX8bd7ZNzciSEMHpN9Ohxy1SDM4ddMuIWcnlqEq6b6tASGuWZDvVr2pAuhI7FpC
         rtihb+9ujkJw0eP5gLE4qhoTP56TtzWPpAW+0LDW+R9l8V8UhreplBJbCGjUwEArAkTw
         cOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        fh=b/RLv8vacvjExskgYy35CLpW/8Gl/C77XlAJeSIPuN4=;
        b=YGX3utZXDp9apf26cWfzCeARHF2CHpsKXtBri3nK7vVgCUEC0ayvrJwFkHV0VcbEBM
         zpfSO8lfvCO2WnXx60JAjmHZVnwBgmYBkquCome3Vi9eN4gHiykVzWI6UA0Vaz1LsTvQ
         ufQbECpLnJZYtRm9jE9xGWLNKDYnba5Yjf17TLdNJ8o8kgpsPXtj5HceYh04p2aJq4LW
         lz5w9Tz3h+o04NARNGHNz1lkn7633fX33ugfA/vMb5gmJ3umKrDYHuxRYm3mq9tam4l4
         g6332x6+Mw1JBnMbyiNgeAgT0Pbhth0TzCIuEtSk/w/7xRkCooPT5gHxeySZT2E72ZV4
         R8/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781014274; x=1781619074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        b=pO6mb/MjV7+9Lyoy7qKEe8jyrmAVmp1sVk9ZAQekGJY/qcYqRSPwEAedKazW1YDjAo
         daWkJzVnMyQBtO7fmggjHQ1cPEQGXHlt3VIr6I1Kj1CO/2HtnymY1aGpvzlRB8OH+ilA
         890WtpQyksZUJj37x9K37O3XCrrKWsg/O8Y8q+MGEolHuY3O9nF+Mz46OcSl6XEeAyYn
         PpKFuaWCdq+j/LCZ8xHOrMCCjyi8dyUYIO1ZCC3Qs9hwAGz+a0asgrLpY7oQ6QrXmnr+
         SzEi2Ndcvrsr6lg0pp6Uccf0k7gE8QI2hRsXCNfmZx5mer8km0ZAI5cl8BunKE5GWZwg
         VvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014274; x=1781619074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        b=gzTEx4tPGjx3BmtIRTZJ5IlumtE+RYXZPT0KtDZHe+9h6Zm5gIQS8tRqKz6acFYOsO
         3H9IhSVaJZ5leKR1BhIbZahrckLf3O4xdaIKhgFXJ95AxJWNjehKcS/8Z7BzKhhuEbN6
         JQjVYG2Ic368+ivpA48LNTgNx9o0PfurNEk8se4XpKUiUt9MJdUfP4IUFC6QT09zY24b
         m1XAXBqt1Co9VmhySpH2qGQtzxsmJGOLOsd/rZyx3uZj0fN2huh40sG+y0UB12YEXV8L
         iHU/wcSY0Vs6v1UKDyH/BP0zgnn6zcG73QkN4eT1cJMW8/DrTVOKkxrN5jJTzwHNuwum
         +VOw==
X-Forwarded-Encrypted: i=1; AFNElJ9t5mizuuaC0SOgs4Ipx5NQVIN2qhORJlh4RjfhIRlmWnwIKqjfbbFEYff10+H93XsXlzslnnQCxmzX3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOXCB+fbdOr0irY1AtgtOZRjOdNHaRluDmnRP647QmqZR+WbB
	5drgm3AsYCsXx/zSQVB3+/gFwUcDW1o3vyAOQz62VbHe8o0RFBt5I58jww1yW4CMLn3Fcn7+LzN
	BOM4h3iilygezQ8MKjuTXHvLg17P6cxI=
X-Gm-Gg: Acq92OGgb39bbWxJy6tf3jOtCZ9eiJoXaGk6+VKdb9Xt/iUEphkKjHEIgoZJz92Jm0R
	aIzRs4e6F3nAGDcXJZ+GI1QClj0wFJ+w5aWGs/zE+d/JVyNe1RpOvmQke8PgG3fsGr8sOUr+oeW
	2TFeVApwOV2n8vEsWhkcyItS4+GzUU2vYesgEG6J/0wffD8ADiplOCGcljIy9Nr6DBXkjWfy1tG
	+q23bAnh1M8SzEcpqNKtxvbyhP787rIvc/Bgs8MnsAMCtMaEWwGsY5M2Aau2zM2Kz/5UZMwk0Ax
	/mlcAS5GX6MchkSGxE3XEkl/qq/EcpR/5cEexp9KitMKMrXcBdNJftgD2DvYWQraGhd6KOQU5A9
	nKucMPzOmar5cUCMnseE0sik69QoHgiHcdQ==
X-Received: by 2002:a05:693c:3749:b0:304:8860:74d6 with SMTP id
 5a478bee46e88-3077b21ea10mr6213247eec.1.1781014274135; Tue, 09 Jun 2026
 07:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 16:11:01 +0200
X-Gm-Features: AVVi8CfNPwpEZxw0N5nqXBfBlOCze0ATuinL6YIsUVP51KJlhLB9xVsEvEDqHhw
Message-ID: <CANiq72nkYJnztntLzB5jNwi_oRY+V7UMpf6AuKM07aGH9FwPdg@mail.gmail.com>
Subject: Re: [PATCH v17 00/10] rust: add `Ownable` trait and `Owned` type
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
>       rust: page: update formatting of `use` statements
>       rust: aref: update formatting of use statements

Applied these to `rust-next` to get them out of the way already since
I have another similar one for `str` I am applying too -- thanks!

    [ Picked from larger series and reworded. - Miguel ]

Cheers,
Miguel
