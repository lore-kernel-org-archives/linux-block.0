Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEF3909B5;
	Tue, 23 Jun 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237352; cv=none; b=JHwgJpBX/HIzOfs891u0J9ssmuoHZA3ewBvgryPR87jBKpFW6NEgJBP2IyldgvdZyE028K74RVfuHqtncfYM6hyp6E6cZ1LYW6FZz4SibVsfURCkG1l9DuzgX/hFtFda0bA9m5A2YuGfs+gjaP79BAfLDmRfBliS0Rn4+0DD/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237352; c=relaxed/simple;
	bh=eYxN666gKnAPBCU2NjephjWUZYLck5WtgeXf9R89MjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDTOoMC0KU2FSgeiSLIAmEkR3IaAGwS6GlpX3/pOmQcpGh2qc1VJz6aL9DtnQVKWYF/p4ZLG6kppyIsW3T5EuZS9lS68EDX5QVPmsBB0y/GOscWV5+PgWT0nO6NevlC9j/W3TzP7MWpo/WWO57h4DftL/HCBEVc+Y9H2KjzDi3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=SaENjC/C; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="SaENjC/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1782237341; x=1782496541;
	bh=3anUjfUqAfKXRz52ChpQC6zD/lO83bxGXry/MLwNSO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SaENjC/CMfJZ7aHHoNXuyYXWirhvR5ckMqH4I14+a2qrFUk93bDnMCqeErFBQUP0v
	 PxAWcf5MDaK/h1+PD7Xztk8DHBmAJYuQzUbbofQh31Vb4K0rPbNtP+Zj5Ti0PaEz8l
	 y7CEtR0ABhnvuBrjq3wJCkhsDkXd88Kz77ci8Kb9M/DzKOTlJnxdVVucC3zmG0+KJo
	 xF912ecuCseGcuSm2pLKB+3MqPL1t5fQg6fwfBm0AgiTbsz/L7KnDM+K/Mc8yoO1Cu
	 m/g4LsTaCYFIk2IHmf42GmBOu40VhyMkU9d5U+5iUSwTb8XcKR+78rOM4IGjygJn3N
	 vwMFoIeCYeWDQ==
X-Pm-Submission-Id: 4glCQr5V5Bz1DDKr
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <sergeh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v17 08/10] rust: aref: update formatting of use statements
Date: Tue, 23 Jun 2026 20:55:29 +0300
Message-ID: <20260623175531.85421-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org> <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Jun 2026 22:11:20 +0200=0D
Andreas Hindborg <a.hindborg@kernel.org> wrote:=0D
=0D
> Update formatting if use statements in preparation for next commit.=0D
=0D
I guess you meant "formatting use statements"? Also, why not doing this in=
=0D
the next commit directly?=0D
=0D
Onur=0D
=0D
> =0D
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>=0D
> ---=0D
>  rust/kernel/sync/aref.rs | 7 ++++++-=0D
>  1 file changed, 6 insertions(+), 1 deletion(-)=0D
> =0D
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs=0D
> index 7491382bcf29..818c84fa923a 100644=0D
> --- a/rust/kernel/sync/aref.rs=0D
> +++ b/rust/kernel/sync/aref.rs=0D
> @@ -17,7 +17,12 @@=0D
>  //! [`Arc`]: crate::sync::Arc=0D
>  //! [`Arc<T>`]: crate::sync::Arc=0D
>  =0D
> -use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonN=
ull};=0D
> +use core::{=0D
> +    marker::PhantomData,=0D
> +    mem::ManuallyDrop,=0D
> +    ops::Deref,=0D
> +    ptr::NonNull, //=0D
> +};=0D
>  =0D
>  /// Types that are internally reference counted.=0D
>  ///=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D
> =0D
