Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743425F7A9
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134215; cv=pass; b=Cp4qDGdssXz+3R4DZ+2o8Z1AaLCBgZbdqZoaQpmyItFcKrxFkawIepzeqTCHjj6bkTZHJ4/lG2Nh91SDuKIkMOgAUcqCILqDQEZ975WeXPNsSFfKDYnll6ZmOgFUFljQeDB0j/UNdpgEMO3X+KpXcg5O3rFBxEp2cT5Sadjqoi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134215; c=relaxed/simple;
	bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eT2Qatt1D7xeOD1slILPIfxS6787A7vxjgDo9TdPQ9gS1fz5UzpDKPtw2G5J6SOXpyLshLAhajU78I1Kfl5i2BjwtwyDdoHT9189qRmiHfWDowaFRigjngLe7ropc6xmTAQED/AqgQLab+66hFV1Ct4+7CJk2S+bGqYuyvqP2is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehf9dS9K; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehf9dS9K"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b965570d7so11607535e9.0
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 06:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789134210; cv=none;
        d=google.com; s=arc-20260327;
        b=htTx/DuL28Lpt8hBfy5RzhekIdpKC4lSPXFMncKsWBpUCm/2coyZqGc/ytepY+wUGZ
         0VJYI7oj+uBBdztXWXIYXI2Qo8V0EyEG6JO2w6gIIh32f7BsMyuDySOOqjrYTaJXuaag
         jBoU7wsxiNgRQ/3VwfwEXGRyLWFLeRbWlXW4fjPwVhVcaPldFZB4Mut6Os1XoeHZDjfx
         V9ze7fHIUoW4d3hNTjVopZtvN24mpUzOF3RS3S0ENLreVUTchkuL22TXD70gIizoGVU/
         NM1CLyxdpR3K/mOdKZb3zF3hDAu694qktXklgAgnos9HOFgaDPvcKVVic7fA21EUgBSk
         b6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        fh=WYIFxoQMwBeTji9hrm+oNlc9zUe2ZH2+B3YpLONilos=;
        b=jq8kCW8IN17q+5Gtwo9app0zEzGwdEkl7uXHJ3LzzGp3kitLPgHz/EkX71143uW46z
         mN5eUoytnsriAaZV/O8bfKD6PTLyYbcgFe1inKzz5Bme/vfcLZmPUmVpyJyjFYIMnaCH
         CMA4R88jzHb4XXkZEKWuklA697Mbsh7NC1xcoZgzoT/LHdvt7lt/DQt3tXJLqX+DEd/o
         FU9g0gGrLQApH6bp9MJ+HdzpArqy/9xmRrA8OaaCGjCQz52xs2wdV0P8H8mxRPqRrH67
         IxZhqgtMJW0qqjbJpHyPItlGFB/hu9J5UE4TTQLh1RNcQ7j/rnykUZ2PzzCkGz0zX+Fj
         18UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789134210; x=1789739010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=ehf9dS9KBtz8dLPV1eOtxc8kmJv+fOyIVW2ZdO06596kBMMRx/tyUK2lDgVQgI5M/c
         SSpBMb7uUs4G1u34797nfCD7P+9zLvxXZxAHnuR56Buv7tbMHFhU+KXC31bwb8LxfuHW
         8rSFo0UCiOxET6/EGYFoQmdn13E7BSnpGDUmtBh5eTd4sQzXsa+4KMiX2L2pwFInQmBd
         XbtYZ8PflSCvO08pB5VAXZaYQ3wTj5HZ2Hp+yRGmtaYxRkpKM8QUHwvM09P+tJQDQK9v
         QG0xK00MrU/0875Gy+xMQiBhNe3qdsPJOLSKMbDDhT7ODGKOfLVFvcBzJ0WilrEwQq0E
         IdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134210; x=1789739010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=F2GmlrbPwtrsjBgDtt4iex6igfh3dhy6eenBs0b7k5ogLpErkZ9o6hK/kNw6bbeG5v
         RBacK58N0oWUMVHPONlksPrwkJWDU7/DuqMpR5ELAvZXr4inIYg3kHhy/GBkHCph/y0z
         MnfKe6/L/bCYiq8dzs5YjdarSRu1jhPLxNMLEb+SjdzusM0Uy1mfMaHGngpss9nFn25V
         Fkv4P8w9I3fjKSy91SCCHIqoDItvoFnxQjTTCtRNXMN+3PavieyqMIMInZnTNLx93X61
         H2zWRLNwSuN00KpYR/5nYkisvMX3BZngwGTbeF7F0rsSnF+FYXre6kLj2vViHHyZ3+Od
         OXVA==
X-Forwarded-Encrypted: i=1; AKwUvBwpkRJb5mUjlVrEbORYfm4H6C8bS4d8nNY2jKBr2flHTTzXSSq1bqC+u7gIytS+lqOUvlbI0MxiFqFnzA==@vger.kernel.org
X-Gm-Message-State: AFuF++lTtXbn2QC4paoo44Kklu6ZQu2PLk4KQ515rMCb39ZyySRukalz
	Zh91x5o0Kfj4IeulpdsvCFyEQ1DC+Hh+ONaVANZXgbKJPAra7Idu4INibMtD5yBnw2ZPS1oHMzy
	PaZ2JTPUIFGkbzPGvsBwII8kctF36DClCQwUjYGOi
X-Gm-Gg: AYBFou2PzonUZlSFxn4/izdq3rfSf0pUyzhj553EbvOhdcYAae2QAgDJFaoqXTWCDEF
	aE1g5N8uUktpf0+bV1weQC8HiqoyUwh0PeisSSLCrySfAPDRjiYWDaZ+Y/bnJNZn8B46EckQlYw
	8MMxixsQNxGR6/7WGRCSLsXMAaaFxS6bKClj1tiOCC0Jz7oQfqYEM+wuf4HPoav41gisvP5SEI/
	UzjhbDo86WHl6+Y1ovau6NtzWL6F9+VNnvHbI8lgBsOJMezTcyYX11xMMAyC37WQ9OK0tbVlQZL
	SnXzeOEIxvsgpkthz475cj9OygY+fpSICVUmL6h7bv7DH4bVw0b8r0sq09umSKaX9sgdNFfneZG
	t8MDaHx6x7WlXV9Gd4iQ0uqfPKfl+u1my9AQh8XNHgUsQBy4/9DUS
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49e6198a3b2mr36939915e9.12.1789134209249; Fri, 11 Sep 2026
 06:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-7-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-7-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 15:43:16 +0200
X-Gm-Features: AcwNN1UlYe5vy_4Ph8n7W5xph6nzuuUOW4o-tvYKznIiNAx0UgbfO_rFNfVUhuY
Message-ID: <CAH5fLghC2qRh8qNmMHMWQXiWW9FAPdd-O4z-O-17FFDB3hy=+A@mail.gmail.com>
Subject: Re: [PATCH v21 7/9] rust: page: convert to `AlwaysRefCounted`
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
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> `struct page` is managed by a native reference count, and kernel C
> code routinely takes its own references to pages, for example when a
> page is inserted into a VMA with `vm_insert_page()`.
>
> Thus, implement `RefCounted` for `Page`, backed by `get_page()` and
> `put_page()`, mark it `AlwaysRefCounted`, and return `ARef<Page>` from
> `Page::alloc_page()`. The page is freed when the last reference to it is
> dropped; for the order-0 pages allocated here, this is equivalent to
> `__free_pages()`.
>
> This also allows `Page` references to be returned as borrowed
> references without owning the `struct page`. Remove `BorrowedPage`
> and update users to use `&Page` and `ARef<Page>`.
>
> Assisted-by: LLM
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
