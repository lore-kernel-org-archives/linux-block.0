Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129FA1DFDA5
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659736; cv=none; b=C2iHeirIPfIHrk1MbDY1GLq2q76NsKA5li445/CQnCX5XC6XBYr3KCiz7G9Qba7/ubF6bNyGq2Rl6Cp3PbPksFgyf68U7DuH1qKhvQwzPCrlD4KsAQmSM7fLBwsGDlqGbIHhKyZETLrvKwnWWpFV2jHa5DuQe0M7UNiHO18SFEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659736; c=relaxed/simple;
	bh=0GviJ4C43LDU6PSrh2071vRUi2rtBfBORn6lykbuEsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvFnMGl+dAca73KiAspENyWGpvH2TqK0T19ZbzUC025P7vnvxXKs/TUUmPBExaZCSsFZDR3ZzYjKSAIcp1kY3OMC5fsxYt/jvJa4cwEK1hxZDiLkYHusnYfn3/lcm/MHHkP9zo+DqQ3e+0Q/U959mytcm/CMAttyCFIN7B8DuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+oJqfox; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+oJqfox"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3137c20213cso3796486a91.3
        for <linux-block@vger.kernel.org>; Sun, 22 Jun 2025 23:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750659733; x=1751264533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjaVo7z5thcmzA/Idtk2W4NhEJVEWcJtCaNKpGwgS2c=;
        b=u+oJqfoxE1BDc1eJwUUis1/T12Yqa9kCGnmN2ISJ6NGL4Y90YTjNpLcrHWi2vC7sRN
         V7k7BJyQhMSUMtHnH7VwPrTi0ApD257hQSBDPWlbwRnnmV8VWzNUqcZH8U11ZKU+pE6D
         hW1qhi+Kr7GNBRRFQi35gamyh6WI7ysOV4gxCoI2xvX0CiY24IsIjPSklaXOQyTBaDYC
         knHRmrkvJebx7VBrgNq6a2PDzN/2Bx/t52idVdQU1St5ukmK1HArRMG54H3zBrnzHQV4
         QECnIgveaWKpT8qVfotGB5w3LBcIoVxWX+EHnrjCPB5r7gRk42Uw1BMb7mGARpZN5WKx
         mqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750659733; x=1751264533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjaVo7z5thcmzA/Idtk2W4NhEJVEWcJtCaNKpGwgS2c=;
        b=wzoqmmss2SQJjjbWIG6iiboMuScLJf4jecbyK5xGxjK6q5gz7v/qkH63xfFnK7vCCN
         JaLoUbln6j9L3Cb0qVq8Cl4ZfRUpQWXhXOl19dR96p+5cQipRKdIsJ5iPTqK5baDE5qU
         tOYT0HVpjORe7X3Hh2jufRVFOHRHoL+hude1dIbKkYgxpgRbI80Ed9y+tHzish7AXVf4
         9GxQtYzp7HGyrXTYagma13DtvcC1wd5X0zgAG3dIHmWwsV+mUZ6GVhSQxoLLZYS9e6WV
         2pjcyrNsf0ehknFI2VaEDAB9QEiGkhCux0kIS6np3sqVfSXHa56ngeWPBaHkYH9BoULD
         +ZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZg3U1YVUN3gRB4dCcc9QVei18u0pD3F6vr6AKF3Ht3mKxquseMEYVHRmXESwFjeXKeJbaU0bLJy/dYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqvPHpnuV1L2PN5biicelt6k0zeNZ/QgzLEVseDqYYnEcwIQe
	aT5N8o3hIV1axafLXpjr6QII1ems0te+Hl+hIoM+YHbrmamFcY0KcQ33PVmGvC5ojyw=
X-Gm-Gg: ASbGncsjn+FBZAvR5KFvp8cGuA5RhEdzksETEukFkslAlr+6LOICZ5s7RgOk+yzkNPX
	ETy9tyQFV4dRJ6pkTbXfGauajECgowqVTB/mlR1GnAlFuwJQx3ixnHdjyUWYxk//rNWdKPIzlmO
	mU+YDrh5mqAjhWd4D7/p2L0jyFwLiKDEM9zTAkzzmNPnoA9dt1UYmhejHNJPW2yYQFz3xu6IEeI
	YhwcBZDYeOimWHePV5VvFfxELIk0+51z7MmA0+QP31CVgPBfb1mGaIJQ+JZe1d2+83NKzgkwIrf
	EigkIp34gQuEH6i4s6AypYtBdbp0fompWdMnT1CjuDxiLYP2GJ/FU0F6dlh7cJg=
X-Google-Smtp-Source: AGHT+IHTC8DDc643Bby1AguMJbpjpU8RoaZSO7asfpNMZjv5HFpnG7zervZfVFZEkHAcEV/Plpb2eg==
X-Received: by 2002:a17:90b:1fcc:b0:311:b0ec:135b with SMTP id 98e67ed59e1d1-3159d8d6282mr19886141a91.24.1750659733212;
        Sun, 22 Jun 2025 23:22:13 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a3c9sm75875175ad.95.2025.06.22.23.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:22:12 -0700 (PDT)
Date: Mon, 23 Jun 2025 11:52:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	llvm@lists.linux.dev, linux-pci@vger.kernel.org,
	nouveau@lists.freedesktop.org, linux-block@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v12 4/5] rust: replace `kernel::c_str!` with C-Strings
Message-ID: <20250623062210.she33z5hfouu5jgj@vireshk-i7>
References: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com>
 <20250619-cstr-core-v12-4-80c9c7b45900@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-cstr-core-v12-4-80c9c7b45900@gmail.com>

On 19-06-25, 11:06, Tamir Duberstein wrote:
>  drivers/cpufreq/rcpufreq_dt.rs        |  5 ++---
>  rust/kernel/clk.rs                    |  6 ++----
>  rust/kernel/cpufreq.rs                |  3 +--

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
