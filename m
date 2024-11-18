Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EEA1D0DFC;
	Mon, 18 Nov 2024 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961701; cv=none; b=G4wlgQ4rRtw/zHomj1H/243FBz0waHzbNn4uKtDpyf8wZ5cSuPbbZw/orIawA51zGnhOqAXpUA4+8w0Du+blgz8Y4+FEdlT9goCoM2lcTmoHza4mRJPhdpG5/wxB5EGYOLco/6OlcsLOn4LZhcWQFzRnlfseNDy3csKmcy0448c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961701; c=relaxed/simple;
	bh=O3HSD73dd2STWTmBwHmLsB7H5lxT4RPcf/Bga/vpFwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DylBKy19TouzCqRpH1HExXxVrGNnpRyyUVD9wx6m9H+lRmaDGSOG7aB8iHszjM5jBEdioQQcE2T5qzXK0FKXGXdaoMmHsPAJh/SFglYZVOPKEgLMaChTM4ZT7Xrs+eJFCDCp4z/ybW9AH1EcXSuNaOD4UVp9aSWNyN0Ax7eHex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkrjFlzd; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkrjFlzd"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b1601e853eso168068885a.2;
        Mon, 18 Nov 2024 12:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731961698; x=1732566498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut+d7DL7uqoI2pnr1wfCbwOzEdaLXHwjRahrl9zmYH8=;
        b=fkrjFlzd/ACmg0DWmvFbLMD2mey5vydSxaOulDQYsDxTXVrnlTJYLpUZc8C23krc3W
         RWCWLYuaszX57VS6Zx2LS7f/puyS/R2WVj7zhahzWGP/P//DTTuljafRY3I9J0qxmXJh
         eHzUII9+5OCuZlSfAtYRoE4qdIiTx4kmIy5jL0VGVQv224nKQt0v69CqyJrLa3P/W8kX
         +c6KNW8Ep7FCkun2cQqswTAAacQKfeOCwD4/FoT8y7vpBqdW07eYMqZ8YntHsAq9rf8P
         4H1SPo4mxbSvBo0YctqCt+ENqNXco4ci98QMtT4gwIH4biFUmt+FGTEiuYVDGJ1T2WYq
         G8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731961698; x=1732566498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut+d7DL7uqoI2pnr1wfCbwOzEdaLXHwjRahrl9zmYH8=;
        b=bYmRY4WlU3ONsv5doV2M89G0CJCPDWryhD1kgZQJLidA4x7BGZjb7jRABuQ9eb0Vu4
         G1hrwev28pplTiprNaaUvUqG5e1oHmqP/RdEYfy6doBgnlUrDeGOK2h7PaPrac/BDUxh
         9MjCbB3pfo7xOTaDm8f7nnfFZTD/pWZAuGDnkp+2Rsds+8nUb9XETJGU2GH/ov2ywDbo
         0QpbcfgclfV1dnp9oYFpevzD8L/6wMmzTYjLggSH3z7ZDyfJ6x81rpr0Mtgg0vt0R/CX
         SHTA+p9c25f2igADOmUstjSlpaRDKxgN8XWZ6rp1HzbSXCq8StWWVRMg+E+k23GVJ4eX
         joKA==
X-Forwarded-Encrypted: i=1; AJvYcCU+zXot3Gc0BHBaOoaks/7A8Jqvw067aT0+0ZK4JFUG6AZDJYwabZtvicy5CFwHawsxuAGr9mg42KDBlw==@vger.kernel.org, AJvYcCUNuMcrR97ln1nB5zQmqYAeSYPa9ISHeZB+EbrI/u6dw1JDU7rUbmGEkPfU6hNJzRnrOHhV0o4Y@vger.kernel.org, AJvYcCVtqP9xeW6tD6j3QyiPFobc69lP7u6jw1Hxq3qTA5pGbq2Je4Awt9W3nJgavLpiN6/XtZb5W0xirzIirafIEHs=@vger.kernel.org, AJvYcCWA708bnG7Jph9o5wTmOKpXzarEZQXQgeGzbUTW1/eyLMx0FjGJ5zWaQU6cyC6CCXoKKES6Sa4hVAAXKWxd@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHCXIi51y0uvXPjfhy1zVWCi7yQfwRoYihGuis1y0QTyQBDt7
	/KYxw7dbZBlIWvwdC5H1EUxAs8vKzEuJdXPnTL3/KA88CbC51kpV
X-Google-Smtp-Source: AGHT+IGcYiGJ+3lwBm589yH3iVd/ZN43viURBfqeOA4ouRBzJLMwUclDkj0RDkFm0gEdkdLWT6yw1A==
X-Received: by 2002:a05:620a:44d1:b0:7b1:1cf6:cfd0 with SMTP id af79cd13be357-7b3622db90fmr2044601785a.33.1731961698332;
        Mon, 18 Nov 2024 12:28:18 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a85e290sm23620385a.42.2024.11.18.12.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 12:28:17 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 41DD31200076;
	Mon, 18 Nov 2024 15:28:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 18 Nov 2024 15:28:17 -0500
X-ME-Sender: <xms:YaM7ZzgWVoZwHG7SqmII3Bqy51ecraXB_YwGq68JUlintFgAHicTwQ>
    <xme:YaM7ZwDiM95fVLUh7feFrICS-BQniCJznPOVL0WYiITJWM6MbQM29OCHKIQREEHSn
    RpvHYTzXKosAaNjqw>
X-ME-Received: <xmr:YaM7ZzGSg4gGr9ebzj-xTWioQ0Sk6v4rx8hbS3xbHndSicbhS-GNSbMmldi1CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefh
    hffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhgrnhgrshdukedvgeegsehiihhithgurdgrtgdrihhnpdhrtghpthhtohepfhhujhhi
    thgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehtmhhgrhhosh
    hssehumhhitghhrdgvughupdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhr
    tghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplh
    hinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegu
    rghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YaM7ZwSxbN0x5IyVrZ0R9eO62WJsQFvptIh35o3zeOBGMiYh7firJQ>
    <xmx:YaM7Zwy7RNJlcXupukflmz20zByMfc8iOZq8_csqgcnfTvsRU2H6sg>
    <xmx:YaM7Z24IR5-Zqr1VKjYhMYWuR5Hz5VqW5yoe5MWYnoIXVuUG_xiIgg>
    <xmx:YaM7Z1z81j7Vcyk37ze46yxTPG33_n7WYdB41GdxvOD4BzEqIX6IfQ>
    <xmx:YaM7ZwjoxF3zuufjHCBpx2QLgqscjiJ9H3KtNi5bay7lqtz5sTjIk_vz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 15:28:16 -0500 (EST)
Date: Mon, 18 Nov 2024 12:28:15 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: manas18244@iiitd.ac.in
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v3 3/3] rust: macros: simplify Result<()> in function
 returns
Message-ID: <ZzujX5dXpUxwBFSU@tardis.local>
References: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in>
 <20241118-simplify-result-v3-3-6b1566a77eab@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-simplify-result-v3-3-6b1566a77eab@iiitd.ac.in>

On Mon, Nov 18, 2024 at 08:07:00PM +0530, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> Functions foo and bar in doctests return `Result<()>` type. This type

Same nits here.

> can be simply written as `Result` as default type parameters are unit
> `()` and `Error` types. Thus keep the usage of `Result` consistent.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1128
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/macros/lib.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 4ab94e44adfe3206faad159e81417ea41a35815b..463920353ca9c408f5d69e2626c13a173bae98d7 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -144,11 +144,11 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// // Declares a `#[vtable]` trait
>  /// #[vtable]
>  /// pub trait Operations: Send + Sync + Sized {
> -///     fn foo(&self) -> Result<()> {
> +///     fn foo(&self) -> Result {
>  ///         kernel::build_error(VTABLE_DEFAULT_ERROR)
>  ///     }
>  ///
> -///     fn bar(&self) -> Result<()> {
> +///     fn bar(&self) -> Result {
>  ///         kernel::build_error(VTABLE_DEFAULT_ERROR)
>  ///     }
>  /// }
> @@ -158,7 +158,7 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// // Implements the `#[vtable]` trait
>  /// #[vtable]
>  /// impl Operations for Foo {
> -///     fn foo(&self) -> Result<()> {
> +///     fn foo(&self) -> Result {
>  /// #        Err(EINVAL)
>  ///         // ...
>  ///     }
> 
> -- 
> 2.47.0
> 
> 
