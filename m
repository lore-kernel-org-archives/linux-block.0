Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE072637
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749692537; cv=none; b=DJ3dhErpg+HZepl/DGNd9p4Gjsf8ZOHXiU7yYGWrqVU6EbV3CjsXMNeDON5Cm3MPnia67iqeZ0Wy/Cqa7QmVF+kLf/vJeK0SIbOpn6xxCc9UFTQcWr+dgLEKnaLOX+kwBQqrJXSfqqOlksPNq6y2VHXQhb4ySdgIG5bYqgS1mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749692537; c=relaxed/simple;
	bh=yekqGRUYYLfu4rmZNRUCu0QzvWyE3YgMNmc+9ucJ2S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2k0xuqNo5BSvuhDOuZZUD70yPFTf/ZZNKrZkvvTowj6oEBqCW5zijuHbiga8L0NeXNODWdfPrPZiMCyjZU7lpTRDcSvq1AlFODgFNvfx8H1WfoWVWfCVIbMGJZa59wg9x8axKWJ7hlmhgyzWYFVXYEc3A24eVvSNNlGqc7scOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aS8zANfF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aS8zANfF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23636167b30so4246715ad.1
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 18:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749692535; x=1750297335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GMTYoO/hH1xieNN1bEgiAsAF7Z3yvr8fWaDaLPOgs0=;
        b=aS8zANfFOoewlnHoxS75gB9a2NKvfc3aVwtpEuYLvBRkUgLVdbajvUugYuQnlpiNgX
         O1vKvdtO31ytv5O8Mpv6Revr0jOt5r0H3cQboSyBx5UpHSu2FM7rNHau145oNwt24JgM
         SuPLRI3E8lOxkoeS5jsYVmwIEgpwgtHa1VWEqgKk7D5ZtMSX3gB4Cqk71BJhAsNiyXN7
         dX0Z3h29YqnKsTl0q3Gv+PLrMWZF6BXjyYldCXIP9LmhSs6CdjrHtCVjTwZqVrkYp5S5
         W+ktguZtboDEG+3XOVE7id4b+mzh+bJz//xjj3N8qzHy7CnlD4GLKsYG5jWbJ4wm3aZo
         dfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749692535; x=1750297335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GMTYoO/hH1xieNN1bEgiAsAF7Z3yvr8fWaDaLPOgs0=;
        b=U1/A76+ANH0L9qSKoknn5AYLCVsDuxNIddKuREiIT+z7m79vfoW6dJfQuRW30WAkiP
         i4clIMaDS6MsfqSZkr+YbwO1n+p98hE70CttdtLJ/awo7LEaksJvfPRC8B/25216rhcJ
         F04nuh2FPNYQ6hHq5YjpSw8vRNLgp4tqab1NUmBTNBxxxo5eyfl7b5Wok31XiPYK+oRg
         xJ/oL18Wf+mB9WQlMLIAjaaj54eCCnp5WTIWhhKVUWAh9y/gsP/N2J4VEr6xk5lmdxeA
         7CsnhDB1HQiqz28GzVS5ktK+d3JuwpBzZQnUE8HxvNKsjP/87tcm8W1PLZAXAJ9QzNg3
         nZiA==
X-Forwarded-Encrypted: i=1; AJvYcCXTTOIV8rEq684oaZE1QsBSdihDtva1JzPcaSTW7HmerPjuxaX7IZeTmAdPfiBBCS7PgPnErqKc95FSgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj78yn8mh+/epJyrTIiJbtbeSOn+EQg/OSJfhkvUNGHnCSh/rI
	Hj4HtxfXPummLHYjw2GK7jRQ7fqeXoCK2JMWg6Ls9unzBb2bvjg5rw6gYucpQJX3d+c=
X-Gm-Gg: ASbGncsfR1TmecUE/0U5fTU6r7aoVUMkxWT3HzVs8zNOiDZ69AcOnhQijJ/dOFEARWM
	VrUcGewFzcQleF4WLQbVLEuKr7c8/TZCJqAksrKo7grvfpFitzvcPElwOOIhWvi7QFyz2tUYQ3N
	7jP0FIO4PgAn+/bGZ5wCO1PblPwT+sFi5oviju1CXZClhQggR90OWZYz2x9hUP+U+HYEMR9wkeX
	rUwlqx9dOzeBCQZZijP4Hjc4L7dbvUdXWOaGa3I1GKBtpEbWT5Ote0O5ZjCbe2MaBCPD6fpZINa
	Oh+yEMDzN7KRaso2QKY1mI9S+to1G5ky9c5mtijcrRFAPs4gqlhgR4CNnSv/4ho=
X-Google-Smtp-Source: AGHT+IEYQuQrQ9pSkTkNr1pxDJTIIU0K6qyK009mvjKSvoQj1EO38HYFTD6dT0wcT093olcResSw9Q==
X-Received: by 2002:a17:903:2346:b0:234:d2fb:2d13 with SMTP id d9443c01a7336-2364c8d1932mr20654285ad.18.1749692535270;
        Wed, 11 Jun 2025 18:42:15 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e7195c0sm2365445ad.209.2025.06.11.18.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 18:42:14 -0700 (PDT)
Date: Thu, 12 Jun 2025 07:12:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Nishanth Menon <nm@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2] rust: Use consistent "# Examples" heading style in
 rustdoc
Message-ID: <20250612014210.bcp2p6ww5ofvy6zh@vireshk-i7>
References: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>

On 10-06-25, 14:33, Viresh Kumar wrote:
> Use a consistent `# Examples` heading in rustdoc across the codebase.
> 
> Some modules previously used `## Examples` (even when they should be
> available as top-level headers), while others used `# Example`, which
> deviates from the preferred `# Examples` style.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Benno Lossin <lossin@kernel.org>
> ---
> V1->V2:
> - Don't change the header level for the example in workqueue.rs.
> - Update the commit log accordingly.
> - Add Ack from Benno.
> 
>  rust/kernel/block/mq.rs  |  2 +-
>  rust/kernel/clk.rs       |  6 +++---
>  rust/kernel/configfs.rs  |  2 +-
>  rust/kernel/cpufreq.rs   |  8 ++++----
>  rust/kernel/cpumask.rs   |  4 ++--
>  rust/kernel/devres.rs    |  4 ++--
>  rust/kernel/firmware.rs  |  4 ++--
>  rust/kernel/opp.rs       | 16 ++++++++--------
>  rust/kernel/pci.rs       |  4 ++--
>  rust/kernel/platform.rs  |  2 +-
>  rust/kernel/sync.rs      |  2 +-
>  rust/kernel/workqueue.rs |  2 +-
>  rust/pin-init/src/lib.rs |  2 +-
>  13 files changed, 29 insertions(+), 29 deletions(-)

Miguel,

If you are okay, I can also take this via the PM tree along with my other rust
fixes for next rc.

-- 
viresh
