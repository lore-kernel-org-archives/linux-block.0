Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531CE27FD64
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546311; cv=none; b=WWo8mVmvhWspF5iYCVVjlU2Hq9KQ7v5pJZcRHas0FwmlM8XfG2K08JnScRKAU1jHcSDa6uqmJnY2L8RqWcmOEo0gIGuqkoGPGyfoMaRsi9ZEowSTxtTIsBXokppguMNnlgtt7DdcVpbkXMmbWDffg4V+R/dmRFSE9BUYlxu14wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546311; c=relaxed/simple;
	bh=3GM1WRqVYQXAazSmtHqVXUifnN2sHGlrFP+6YGCoYhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJUBPKBWbAqGoMe43jgvzp76KYDhQ4AhM1M0pmjIU9TpzT7OiZjc8WMVUmxWrOi51tG+JcugkkWvAiF+Sja/biNMFvOBa4PaWFHgRHCNj1XOWi6vVD2Cc09KTnJ/1dWssyntEpdTFQt61pNp2zBN+MXSlp13/DkNTYhbo1NUiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WxskI7jB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxskI7jB"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso3753186a91.2
        for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 02:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749546309; x=1750151109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxpjoO2mYPkQZpQAdh6mmcVEOjQK1F3ewQIY1Y/f3Y4=;
        b=WxskI7jBlYVLJXQyulu04qcMectt4Trgg6Nk4LjbJt8g2h4vWZ2GRPeEbsmOrPi9JK
         YzpstdZ950QKrKYmEb6VAFH5/XcyWkq0D5hYAxGC+2N6UXouQqFZbh7exahs7xADUNo/
         H5AOZ/Uy+OtzFM/s3xyj3Wxj04nKze2tL5UyrltR1DgAmto64ZIIHYNOfqXQ1ayGthau
         VjO13WMzgd9v0SskStzsNi2JiKSzS0n0zBv+g0y9PnLNTM6M2yKDleYrtixyehpz6rFW
         vSCtNnVh7A2jdytMVmH/3xK44kzS7w52aPZpNi+4o40I+WhfQeeG0EyNZ0QyW+Ovdm0y
         vnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749546309; x=1750151109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxpjoO2mYPkQZpQAdh6mmcVEOjQK1F3ewQIY1Y/f3Y4=;
        b=EWklZkyebmjfvhWFP4dVLZw2/1zOtU3MIHgLkRDGkEcwN1VYejnvMXoPsNkzCgsoVG
         6qSbPsCGpZ2M2lq/cde9HTfyfEmTYxUFi1vgehCFKVwR0GGBERyOe7fFSlpxCu1qnrBY
         rvU4CqDfHRyoA4rBp0Y/E7ufI0zz6EJAffi4FN4UNZpYtEnBvdkPyPV9Mhdg+5u+81lr
         BwD8csoc2ribuwhgOblr7N5OvIrrESyk0ixUbcgR7vQyKdFTxBaUJAURwUEvonijPvYO
         m5KcRCT2KDQYdlvLR9KVEwhp81nOThhXjiMH1FKmRdQ3m4sLst6Kj+TtPAEJhFSsYcYg
         Ga3g==
X-Forwarded-Encrypted: i=1; AJvYcCXTArRdjw8DLrvNW2h5ZuEcVRtdaA/Z5lfuK/fvf/PDJKJ2FnJWPtbnlldpD3OfTMC1YnmQf5/PuIKSng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxChH218iM7asxinXU/lQCbMyOVF1Ky7aYYlmaWzQWrvKRXw/FC
	9yHD4tL0uYpeIk4U5SvxybBV5P6ZKm4gzRp+E7jyOhSFrMSPXJhePSnxrIS6gVIvpLQ=
X-Gm-Gg: ASbGncuO3yZ01j1a1XVn1EbZYhCz+gGd7z3j1Wcdp5UtVKi9BxrlXRzAs54DQ/LkY3f
	eikd/2Qf1/kFJkY4YAWtDXB8C/39j3wjyvwA0e/wRVyi9Gay//GuMaSaYLJ05JmRYOSPsl3Ix8B
	SLEZ5dxxbl7fte9LQNiOR+6DgjdTNuML2ubjzx5NNO2MO2IWkjuzcnVsJDw9zjxCZ8+5oKal6Fh
	4tAPSrBACG1iT3QDVrnq9TT9DTeqXg9R3VGDFfGbvgnh2gnvSGfvH1UwEmwgUTxhYUO4kFssdYW
	k+UoUliX1rtnZJ9DEd/n47bFa4DC0HyW73gaU0I4/FqHDR5ZA4LpHOqhf/FH76k=
X-Google-Smtp-Source: AGHT+IHHYZrKaT/gzmS9tsVK3hFeYuSn3Ec8BLsyZRN7hNdemDEI/1VCu0avcGXTkJj/JdBACM9Kxg==
X-Received: by 2002:a17:90b:53c8:b0:311:d3a5:572a with SMTP id 98e67ed59e1d1-313a15739ecmr2416667a91.8.1749546308712;
        Tue, 10 Jun 2025 02:05:08 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fc373esm6863637a91.32.2025.06.10.02.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:05:08 -0700 (PDT)
Date: Tue, 10 Jun 2025 14:35:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Nishanth Menon <nm@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: Use consistent "# Examples" heading style in
 rustdoc
Message-ID: <20250610090506.24lmdltnqldsra6a@vireshk-i7>
References: <70994d1b172b998aa83c9a87b81858806ddfa1bb.1749530212.git.viresh.kumar@linaro.org>
 <DAIQ4GUF8JGO.2EL4XVGRV06R0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAIQ4GUF8JGO.2EL4XVGRV06R0@kernel.org>

On 10-06-25, 10:51, Benno Lossin wrote:
> @Miguel, if you take this, then:
> 
> Acked-by: Benno Lossin <lossin@kernel.org>

Thanks Benno.

> For such a small change I don't mind upstreaming it myself, but if
> Viresh wants to have a merged GitHub PR in pin-init, then we can take it
> that route.

I am fine with anyone picking it up.

FWIW, I have sent a V2 now with your Ack.

-- 
viresh
