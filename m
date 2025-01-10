Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673420C00C;
	Fri, 10 Jan 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517752; cv=none; b=o+JZCidbB1e3rWlpI4C5AJwQ+mfGuc0GzHG/+yVCQPCycw7g4ybISp9qer9OBx7MQAw8R0iZ4d5m6VrWjGE9VGy+7cjCw1sG4ZOVtTIpV4nXqgYXC9u9rUCscaz+XgFS1EGTJBJjv0zBfAGq4uX9RZtqpzztN8pxBG5HB1Kmfew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517752; c=relaxed/simple;
	bh=Cxst0aa6ReMgh66Nd/eWKjoASmGfmLGj8yDlxl+xQTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIp05kpxcQk55ynqASN5wX2Td8zTYOaPwSkdyCkro4yJpvYHqw84Bw6VMdnV8yOK/guFRWwO/VgBYgnKMQcpT5uCOtUxE5CrlEXIheiewmlfL2AtlhOEHzDIqWQslGaItpbAsKx8/Blr7unkvtvwG2L1X03Jy7PiXJ5Q7n4fhic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk+/wfiX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk+/wfiX"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6e5c74cb7so144496185a.2;
        Fri, 10 Jan 2025 06:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736517750; x=1737122550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5JHAi+bkLaJ3IR5TG8T45pfb/4tOZVpznIqDyIgJGQ=;
        b=Mk+/wfiXo6ui67rj/ukeDgaePGJRpj0z4oLcmL+fVIBn568CCDTyNRPg7JrmSPcauJ
         s9c5VZkq6y3YrRB7lIJr38uthl0PghYaV+Ekflvnad0OIJowCtb6mo+QrMdy6AZ4SnfN
         Xp1i0v4Dt1KBoXNPo9vp6U134ggYLhTATWBXJsp4IOsLzwQxhIT/3JALjiqFy6O50+VR
         GBS4sr3eNgp2Krj3ODq3oRM+rGYpguvUyUYalJ86N5w5yNLgFZHHcCyIckEVGw0NyfIq
         F1yjjZoz7GNL2e4hcHbO4AoJ8NxZ9vJEDihwvLym2Fl4supx2UrnuwL8SX4d4gQDcMAG
         4R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736517750; x=1737122550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5JHAi+bkLaJ3IR5TG8T45pfb/4tOZVpznIqDyIgJGQ=;
        b=WuetF7uJm6evVvKmzUebchCeuEeAA11GiMYFu/pp8HE+Xg48KjcxKUnJZm0Hu06lwn
         G6VvdOlR7AV5gMooAbtoxCxCtdlvxhyHHNyff8838a7exH3ScXgJmcDamFNN3Spst21n
         gQ8d+SaYRDQKBqS8oA1hPmnxXFPASXFCMHgfMi2cV41wZLJVGqViiloYEwMM3spJWtGU
         UxctOv0ccVW7bx8wt645kF/JdjRTYzGRorbmZVFJZpEjgtSIBXVSW4HjxNs/XT6uKejk
         MwDf46IXNN3CbpeRQ1FYozpMqoh4HO6OUMaVc2RUS+jpnJgz2PD1Jcf4lg6vn8JYYk11
         9V0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUH/+SjTzX8B1YZiLGXuNgD3iJKElxVRL/iK+1E9umsNk3TiPM50X66jzEZqFM0iCehvj3kv8P8Yzm0URMD6Cc=@vger.kernel.org, AJvYcCUTpN0Qz+RpK/NJ/YnuXWKfCAgtGZAhoSr0Pnd1cOXuagdeUxHHgcUOH8rCSK4v+gQKnj4tCJCc@vger.kernel.org, AJvYcCVvHHHeyiWid/B5DfR3bRf886EqMz+pYWCvOGRlVZRu5jIdIvGCCE2KEv9isdj1Z2QeFSUEy9JfrvdgUA==@vger.kernel.org, AJvYcCWj404eqfuZGZ/AExU8caW0aqRho+UHPyhGRNp82Ejz0N3oneF7cX1cSC4+cpUu77FHHzBaEgpa5odb6GPx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tpyIxLFzBLhNAdpFcnxJONe78tXx/sDk0bjbJ8x0uOY5dC/7
	KKXujbCI13YYBT4Kq7xgDq6tl46SO34iuFm+UPiqEReL8/NRCQTe
X-Gm-Gg: ASbGnct2l3kEb3xwiEzqgcEJk23qT2qS0+8suweeeyh0Zr3kL52YhaaQCBLPnJMyKdV
	Htmn9/VImt/I9L9/blawu5HI17r8xGw1vD5tw1ZcurbQXfb519TCaJ7u/MO0Rb8cXF+ea2g3oxr
	5+AiOhjToOPDvoUYUHZvx666+MvOVYS/N9QNLQBhP4bjD9p1JztIwXqzDs5/+Yp0A3nOsTp5KWj
	l+XIuIFrlcumhJAK7nQASja3aXGgov/Yv142NikgbFPHru2nXHpMZ9tNA5qT7sjdI8TUzCitiL5
	528r+emu2QQ9VNxdoyznMuVtVu/LUR53N/bP/UZJD9I/AAg=
X-Google-Smtp-Source: AGHT+IHtIs/faPVHAGcCbc7Ihzq9UGpfgPp9GARTDz++pFx/lKHO5GMuFyobtVxZ/+1lwvXo9VCfAg==
X-Received: by 2002:a05:620a:4614:b0:7b6:dfcf:3352 with SMTP id af79cd13be357-7bcd97b1c89mr1480177085a.38.1736517749557;
        Fri, 10 Jan 2025 06:02:29 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3515fbasm173147885a.102.2025.01.10.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:02:29 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 858D71200070;
	Fri, 10 Jan 2025 09:02:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jan 2025 09:02:28 -0500
X-ME-Sender: <xms:dCiBZyCGtyoKpZpbF_uN92uOeDPpp0pvRSQdY0YgQr2uhI1h1ewyKA>
    <xme:dCiBZ8j3GsAdogGh7NCCdgfIOIMcU_8NNMqmngm3Rflb1EyUWoAlNBQ_rY3haaERN
    hOde-9VZUA-VwABQw>
X-ME-Received: <xmr:dCiBZ1mI2dmAtL2YhlBd-s_z_UvBXTonJ8pTv1z4zFPjhsYZCqpI_cLdHCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhgvvhihmhhithgthhgvlhhltdesghhmrghilhdrtghomhdprhgtphhtthhopehojhgv
    uggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnh
    efpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhho
    shhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprghlihgtvghrhihhlhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:dCiBZwxwDleOoHiUK--cnv-a1H-mcgiinlho6pnyHRMsABJ41PNrjQ>
    <xmx:dCiBZ3RBJPmOibEzHAcyKO6_hmCIetOGXi7UWkrY3uWP-7VNTmRWhg>
    <xmx:dCiBZ7ayFBcIsN73gIGLnSvzVy6ZxdJtMbD5GKBncsHkHXH1OHRXsA>
    <xmx:dCiBZwQtxXIqL834oWlawgtnJhD5cMZof1NVuhGVL8aoGtIDCU5VTQ>
    <xmx:dCiBZ5CPxgQGIUImQKx1pWkSMB1hwgTg7FsxuvOURWK_T6fkAxq0vrKn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 09:02:27 -0500 (EST)
Date: Fri, 10 Jan 2025 06:01:24 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
Message-ID: <Z4EoNF8XLrGdTh4N@boqun-archlinux>
References: <20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com>
 <20241219-rust-lockdep-v2-1-f65308fbc5ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-rust-lockdep-v2-1-f65308fbc5ca@gmail.com>

On Thu, Dec 19, 2024 at 12:58:55PM -0800, Mitchell Levy wrote:
> Currently, dynamically allocated LockCLassKeys can be used from the Rust
> side without having them registered. This is a soundness issue, so
> remove them.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi@metaspace.dk/
> Cc: stable@vger.kernel.org
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  rust/kernel/sync.rs | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 1eab7ebf25fd..ae16bfd98de2 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -29,28 +29,20 @@
>  unsafe impl Sync for LockClassKey {}
>  
>  impl LockClassKey {
> -    /// Creates a new lock class key.
> -    pub const fn new() -> Self {
> -        Self(Opaque::uninit())
> -    }
> -
>      pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
>          self.0.get()
>      }
>  }
>  
> -impl Default for LockClassKey {
> -    fn default() -> Self {
> -        Self::new()
> -    }
> -}
> -
>  /// Defines a new static lock class and returns a pointer to it.
>  #[doc(hidden)]
>  #[macro_export]
>  macro_rules! static_lock_class {
>      () => {{
> -        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
> +        // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
> +        // lock_class_key
> +        static CLASS: $crate::sync::LockClassKey =

About the clippy warning reported by 0day, I think you could resolve
that by moving the above safety comment here.

Regards,
Boqun

> +            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
>          &CLASS
>      }};
>  }
> 
> -- 
> 2.34.1
> 
