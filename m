Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92E979D2;
	Mon, 17 Mar 2025 04:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742184276; cv=none; b=DlObvQj97O6TC0zFl6S+CpJWjqo8dY/j+cLK2UVFTwCGD3aaGVCPJLhIawNZCNjtu1aB73HSl5FCLdzj2svFgFB/XkGDzCSOwE/dRR7dRfF7SalM9LJ16L9FjEhcIk2OoQ7ZSvOSrajUfBsLPKWTWUgh1YxlM1AcvRaB3CbJmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742184276; c=relaxed/simple;
	bh=Zqx1VgtwCX1Jxqme0dY01T8ETZuysrsyCc9RI14Ut68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/FJq6QmYawrEIBUP47+gcXakmHDjS8pu4XxF/BYQSfp4wnOCfyp3p3Kdx4ScTAsYy+6XkfWjf09e+QxLgrPr8ZGj6L2r1ZL+SwfjO8u2+GC9JwGgMSWwyModcggllc+SFUXkfcBRz4auU8NkkHBlM+Dk6KDfUTxSWkfM54fUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0g1w9sr; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0g1w9sr"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e90b1b20c6so22258266d6.3;
        Sun, 16 Mar 2025 21:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742184273; x=1742789073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdC2SWGkfGaYEex5fKxWwqou3YQPoCqtTCDGuK//30g=;
        b=X0g1w9sr12mVD/4tyUg/7hHM19gHNV/jZS+woWUKTVccrcgUkzWCZApmyeM6NqWGhI
         E9ckD4g9rvL4Rglna/VocwWRSH82AKl6H1ZUduvAEZUWCWUNKNDddU7NAwyi98s1kKX4
         da1YJ+8pTJMSQBHrHd2ZuUxsjFkBO88NaVKjnuVWuTTQ7sLP0IvT8SAldJAUopnigfXT
         KNlM2JO1CuA00FZX+m9NiUSJKo+AOteQ8hqKZ97ykWv69FtwKG0/aGE08nV+wnafNwn/
         A5+wCHdvTIPgGF9qh49rL1WCtGbMjrvVN6DKg3hSX5XHpezlRpB3+ogvUnnbUrFMZdhM
         +Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742184273; x=1742789073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdC2SWGkfGaYEex5fKxWwqou3YQPoCqtTCDGuK//30g=;
        b=i32xVVxcGupb2TrebSKZeFEzY3V0jGeXLFxsqW5LMl9H8/CKwa6WdZEhScUZxplr6g
         DrUr66sSy7kQgG7pQUdVq6wex2dI5lnWHnqEkFnm2v/IfHO6VN+jVNIWD/XA8sdu4n18
         efpQjDx+V0Tgetwfw+qqv0otVXXV8CzChXXVa8q7A0zkP9+c0yljCS8OfO1AM3Zqnsw5
         WO/+1imlv23bmUQvE8YmBNC/LgKUuLauFWW7qt/dDSvNZXbcyl3OC9H2wcHEQHxj+S/i
         T0G+/sON0MXEIzY0i0o4H1Ap47Qo04uhtxmjppBVlctamya2UyA10lPYqxvCNL1fFH3S
         1pCA==
X-Forwarded-Encrypted: i=1; AJvYcCUnIFWGYR7Ph/N8iNvMJkYGzrH75NfAl03FL589Bm9UPAS+uMeDzOkv7xEjngjgfnNRKizPdHvguTUKvkH8@vger.kernel.org, AJvYcCWLZ+y0uyuXq1o+Nj1ZK8fQsKZOieM2EsdgkJeiq/D+32VnYI/60mVoVsZJZe/cHXqzP1+mdVoYWO4eGA==@vger.kernel.org, AJvYcCWnh3w40J4m/RQr2vYO209IiBwZc5tmy/zm+ZGE9eQ7YaggBLXNC2I5+EipogTl696G9SFtWT0aa2aP9xX9GKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjI8DFLerFYaZLxdOLijqMGc4qrWAwsroyGD9c8SY7plQybrYB
	TsBZZdicb3JxBXs1j2e26rxlqO4tVh613tuQoPjB51RDA9tyvmCm
X-Gm-Gg: ASbGncu2qeL+Q8vSXzxEpbf6USgHfZuZpWdoncPIFzf3itnpueGAVP7L10x6C+YAKFO
	X85lI6cCQhFBBiQqAxxr6dJjJWrLNWjRi1ow0wrVDYSPlBZDXeDG8z5jd7E9sKd3El2pkoarajT
	nDizU+g+oGqBOInkoVvDDG+FaF4L/BJKI63WV5vzyAb/+wLdUG0LBac/+KXTR/V/X45c38HfiCF
	pGokg8Lvk1lNu4lKK1D0tHQrc0LlC1f3aHHqbWAl8uaKomBY6tR2bMO4jEo6LIyS+DfryDKUMFK
	JxAtL72iuGOczAmN5ifuHl7vAnroRObf8p0lcwtP+9X5NDVG3o1G9X0fVIshqZbC5QIiTcqhT3x
	CZhV3wY2AZRagaorbeMl/MTfIFdOnl8KAdOs=
X-Google-Smtp-Source: AGHT+IFBjKayl+RdbauHaxiuB08xXW4tWmQhml6RN5yk9hM6PR8a9pGbUs5bHQpeSWSWoGVm6b1QQw==
X-Received: by 2002:a05:6214:23cd:b0:6e6:630c:71e8 with SMTP id 6a1803df08f44-6eaea995137mr171140126d6.7.1742184273679;
        Sun, 16 Mar 2025 21:04:33 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade237957sm50558536d6.42.2025.03.16.21.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 21:04:33 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id B0B4F120007C;
	Mon, 17 Mar 2025 00:04:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 17 Mar 2025 00:04:32 -0400
X-ME-Sender: <xms:UJ_XZ6DDSwKCe5ZvCIEXH1KGlfQDsQKuZIX0e8WBS41-cWtXy72gug>
    <xme:UJ_XZ0gnemuLMsj4msD-PDLSwpMC5WaYioNwnJ6cQdUdnnvre7GEvpua-qd21PqRl
    9vGcNV9aVTwRKN9iw>
X-ME-Received: <xmr:UJ_XZ9nBDSDUjviwonxZviSa_l5-bAJtAa9kUuvEeAsd2Ce2EDaVIDIb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeekgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeej
    uefhhffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheptghonhhtrggtthessgihthgvqdhfohhrghgvrdhiohdprhgtphhtthhopegrrdhh
    ihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjh
    horhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhho
    rdhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:UJ_XZ4zr8yhGLZQx7SvvzOBbXveY6ewp8CsHMJ440O_E-YZJXcDH4A>
    <xmx:UJ_XZ_TWzl77m1yLkxNrUxP5tImmzP7inyLPm8SPUL3OTF4W2fuZLw>
    <xmx:UJ_XZzZaB3Xa2Z-v5ze5PZY0_tgvOqrL73nrCJX31l_IhbTfuDjtUg>
    <xmx:UJ_XZ4R-k99u7Jz4wDc3fYp2lcbb3CAKZCPzhdgZQ384oDS6LkhDRQ>
    <xmx:UJ_XZxBD2Nc4ayW3tgllwTe42yfoTsmXHxEBXh9qQ7cuxCKywKF6Cy1p>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 00:04:32 -0400 (EDT)
Date: Sun, 16 Mar 2025 21:04:31 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Antonio Hickey <contact@byte-forge.io>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Antonio Hickey <contact@antoniohickey.com>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/16] rust: block: refactor to use `&raw [const|mut]`
Message-ID: <Z9efT3ramQIwwRXG@Mac.home>
References: <20250316061429.817126-1-contact@antoniohickey.com>
 <20250316061429.817126-16-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316061429.817126-16-contact@antoniohickey.com>

On Sun, Mar 16, 2025 at 02:14:24AM -0400, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
> with `&raw const place` and `&raw mut place` respectively.
> 
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const`, `&raw mut` are similar
> to `&`, `&mut` making it fit more naturally with other existing code.
> 
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/block/mq/request.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index 7943f43b9575..4a5b7ec914ef 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -12,7 +12,7 @@
>  };
>  use core::{
>      marker::PhantomData,
> -    ptr::{addr_of_mut, NonNull},
> +    ptr::NonNull,
>      sync::atomic::{AtomicU64, Ordering},
>  };
>  
> @@ -187,7 +187,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
>      pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
>          // SAFETY: Because of the safety requirements of this function, the
>          // field projection is safe.
> -        unsafe { addr_of_mut!((*this).refcount) }
> +        unsafe { &raw mut (*this).refcount }
>      }
>  }
>  
> -- 
> 2.48.1
> 
