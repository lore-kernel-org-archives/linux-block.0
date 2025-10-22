Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECCC2206B1
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100072; cv=none; b=RB8eM7U6x7A30GaSR3lSRibb0BrkVtYm/eSSaK6Uk8S8kr/rtYzE4rkvOV8UTwF8fYwuK0NL8Z5J16DyJwCXFdbsTh0JRwnKJK7ICqk1iOwq1u64dE067HRFF+D+2LqQfJukGjYqjAUrBLLhdHzTBpwfnDucLOVST483gNLeCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100072; c=relaxed/simple;
	bh=gtxXSsibCJLZR4eJo0X6XeizsPLCRJKnPsqSUiDcNsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UASISn+h7hEGY9Wy0pvbiIGvBW1jPnT/UB02iLuGhqzqBrNz771WOqk2h0D7NDfAZODMU0z5HRiwK62S9M/IG1uJ3FSp73qHQH4RsuvBJFbtipu/ZwJMAlYIdu6ZV+185f+meyZtVoBk0ShXodtCZacgq3nKVe82oCXe1xWXjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ns7datzf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ns7datzf"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-793021f348fso5643191b3a.1
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 19:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761100069; x=1761704869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqmP8PXFVjPtIGVNVJySqdODosEn/uc3qt8eNXsbPts=;
        b=ns7datzf8icGOKTONAAVfZEYX2gMWHAvcdFwbStWebO0Rl/Du5QVFmBnXqRSoiZU6F
         ptf5P7YAZ3aoE7s/Q6aHquXgljNMj4Z+TxXz/HRHggRHwGLOK6rVwuXlMjLRhzddmEyc
         /a6aU+en3DTez+1SXNrDFb3/tQ6sHTGk02umTReHZF43Y/BdECOHhJXF60IYCuXL+cJN
         NTZLYpFA7z5SJO5wFP7WkGsflKczPbG4jpAELRMI5vtL3D6j75XXzKArcmcPSy5dvNNL
         kPHckmZcRpjqHq1jtHBqc67JbXw2PwDBNFk0/Ma9yM29KWvHwFt4UmMzb3KAngK/Rsi7
         4FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761100069; x=1761704869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqmP8PXFVjPtIGVNVJySqdODosEn/uc3qt8eNXsbPts=;
        b=E14G4WUxX1PBYVNFqFwXzdrW7ElUFJYaIMwL+hl643PeqP3x2S0fKckkaAyfoSfJ6e
         3wcKFQsvMs6nqTh5siHhWSixM0B/exBYkQPGv6tAzw4XnCYNHxwt0qTzvwO846YccM24
         ixAKaKmRUldzyBtzgut/TyoshuGADgbodcR0j1sAi+iVasZeC+z54LnK60bQRn9IR2m0
         g0+QDO0UrDdTQlOsuL9S+DAxWa9I1QM6NZ8jLxLcDoFHVAEDS/B4UAd3RJKNVLw2O+yH
         ZgkM8jlSVuR/VFvkXdoaXSesVzuhuKCssnkNPr5hQXSxKKBzGwO7TUjy5uf9HM/Xp1U5
         h2tg==
X-Forwarded-Encrypted: i=1; AJvYcCWiQfxjAo8Jowxj6l6SOPL2FJzXTgxlhOklwj5D/I7VEG2Nt8xacq3dRN+fiEfzkgDK8R9vZQ2Mmh0IZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHL3Qqk11RHLPrfEUoJ8GlicYnhFPqrzB5AQlr0eRAUFVAemfg
	ExeK4NCNTbdmjPdRmHdPfJtcF2orJlrs0b1tKJUNFnHb6vB8YtUYj4InD+MFbk3+zLs=
X-Gm-Gg: ASbGncuJmIkOYguj3r4ETzhdzLZvoRFNfjDfX1K5AB/2sTQN7n9QCAqwik+n5JWGdUL
	AOv7IkSSejn6HTUIf8dtKmSMVmtuZ1oYkc82MmZfd3wMFIpA5SrgQ+0SgVEviH/R0/0NHTv/M4f
	kkjdxui/4ec+uvjxTuNvCWQD6bT2t3zLU4r5SspV2RnAxMMOrQjhC6HKT38KmOCzweT+OG7/Zrl
	tSZ9hpmcQjx0bDFTTnH5l/cEjlk0kOf/GhjIPpFLSnv9TpkWh2wiFfnFrLTIkyM+StXxTwAB7lF
	53RK+MsaJAMJ1X7uCclNJHS91SabEklBXj/MAEZyJkTyZRADkbA32/aI0ovvZuDVVSaZjOkN4BE
	5jbfFA+WwgNAfXRhWsk2f9EQ4Qnfaz4clQErYPTb1cIsHaOK4NsJnLeZmqbPL2lzX7Tp6Flu7i6
	uL5Q==
X-Google-Smtp-Source: AGHT+IEkOxWVQSWldQc/gAwbJEjuX6oOPBwr0g1WUs0jQjHOfnCn6OF8lZVM21AQiTMGEA1gGzxfjQ==
X-Received: by 2002:a05:6a20:9144:b0:334:3a1d:536 with SMTP id adf61e73a8af0-334a8536f36mr26023352637.17.1761100069036;
        Tue, 21 Oct 2025 19:27:49 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7cfsm940817a91.11.2025.10.21.19.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:27:48 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:57:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: tamird@gmail.com, Liam.Howlett@oracle.com, a.hindborg@kernel.org, 
	airlied@gmail.com, alex.gaynor@gmail.com, arve@android.com, axboe@kernel.dk, 
	bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	brauner@kernel.org, broonie@kernel.org, cmllamas@google.com, dakr@kernel.org, 
	dri-devel@lists.freedesktop.org, gary@garyguo.net, gregkh@linuxfoundation.org, jack@suse.cz, 
	joelagnelf@nvidia.com, justinstitt@google.com, kwilczynski@kernel.org, 
	leitao@debian.org, lgirdwood@gmail.com, linux-block@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, llvm@lists.linux.dev, 
	longman@redhat.com, lorenzo.stoakes@oracle.com, lossin@kernel.org, maco@android.com, 
	mcgrof@kernel.org, mingo@redhat.com, mmaurer@google.com, morbo@google.com, 
	mturquette@baylibre.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nm@ti.com, 
	ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, russ.weight@linux.dev, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, simona@ffwll.ch, surenb@google.com, 
	tkjos@android.com, tmgross@umich.edu, urezki@gmail.com, vbabka@suse.cz, 
	vireshk@kernel.org, viro@zeniv.linux.org.uk, will@kernel.org
Subject: Re: [PATCH v18 14/16] rust: clk: use `CStr::as_char_ptr`
Message-ID: <rd2jyc57e5p6zjhypnxkfnjwsnihs5tsr7r55qnuwbho5jmkxh@53grgiitw725>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018180319.3615829-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018180319.3615829-1-aliceryhl@google.com>

On 18-10-25, 18:03, Alice Ryhl wrote:
> From: Tamir Duberstein <tamird@gmail.com>
> 
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=&[u8]>`.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/clk.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
