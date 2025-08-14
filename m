Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557981F0E29
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 04:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144941; cv=none; b=SlyScQ2y3B0/MBaTfUoBgw75lAb98jqz6zbqpIJVrp9FJum3YkYEqE/8bwJg3INFVBNgqt+h0PtBnxNsrAUneEC5EKRBr78UaJ+BYdv91FYg3P3e5SvRZXoy1kGkcEQBIEg0wuHs3XGGCCv7b7Hm19nKFjQtb51oASE89cHw7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144941; c=relaxed/simple;
	bh=aINf4JQIOzGrbC8KNPOs49EQ27ER0B2fAmdlIOg6AJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uef6hdS3M2A2OqOCBO9aQlkAvthem7EHAAuMwov2EGGkUOyjGaYPvaMrxV3og/+n0PQ42Ieh3gV8B0tfb36booeges9wpYfgmC3zlCMrvsJJHj1FbjXTVLTMUBIj1gPOfz3Hr1sn15aF5pgrVMKyIydVdd/nF0LY+WaBTHI9weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFk8wODM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFk8wODM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2eb20a64so700776b3a.3
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 21:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755144938; x=1755749738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34KWmLyAieUzqtSrdM5jM6hi2YW8C3abPtgGolrQZzs=;
        b=VFk8wODMCPp4sykRcxFNrGPwYPG/tsAGsdvjgE8c//5GEJgXop+PzeRQ86GIEnq+Jt
         ASnKVOR4xGiZ4gw3PsRdnQIZmOaAliJXJMdIgmMpEIALEpSHT7cBRDzkwbzLoco5gInP
         2Abkeoobct2tyzQw6OD8fUL7uatVHX+mJDw5ev5SBRFATouJVPxFd3u2MWeryMAoCQRa
         OLz16rLSNbNZSh7wwfTHosg5H9wZjviaTXy8WCve6PISnwpN4KltPa/Polk9HYhhXvzH
         /Gf67SHkyWDytV3RVGaHCQm7l7DWx7B1HC3m87leSgUlALZeAiB1gChgw4j7cMuET9Dk
         xRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144938; x=1755749738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34KWmLyAieUzqtSrdM5jM6hi2YW8C3abPtgGolrQZzs=;
        b=q6N3peUnZyJk5GCzZGCufVkzFM/xucd9DlYIo6pay7K0NYm4o70CXg2JW8r7xyUEZg
         JvGZlwGBp+Do+Du+0HmJ3T+d8CKDXeHatSCkZeokUahOTzPik8uB2zvVvsqTZPZCE6ET
         6qNvvezyQ7XeHsKgktj1NJRR+phuvL6WRa+Ub8gmhP6s1B/hrE2xPaRUHJM9/FnbC4DP
         Kh+pL3JDLmGsY213epfSl6MGPUlfop9HYKam7mg1YgtY4ukT33vSl0iIaNN0esfrv6ji
         SPWOd5iIuUPWCOp0WlKLao9i40fBzjKi+uGVPDcClbuNH7PY4j/owH9PPRLFl8DUxrt4
         q3/A==
X-Forwarded-Encrypted: i=1; AJvYcCWJBuHN3VLvT6ORH58Yw2m5FJPzRPyTaTt2CXSWYMKCCWtI3gKmXPj4Otd9uouqJYImgiivPsOeTbsSYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJB7SNF3otmhxINAjxpGLARJd+KP2tC3e7zQOsB0bCJQvHa9sk
	BKPMYGxEIHp/Gu058yPuVO2Jz3ZSJq7ENc5sNCnJGmzH+Ho1JTuCm6i68jlvgeaauqU=
X-Gm-Gg: ASbGncvfYwutziTKflgNSk9OjTP/hLUjosJOe2KBhqDy8yEXfrx1s2tuC+J+dqlp7b7
	cROScrk3fNScpfC2pwODPJZ/j+QLujjg6P+wIKP6vpeH9wG0gmraPViyEOk3Vf6RYDSEEnNz/yT
	Y+pFdjqJZyEJoBajlabs1bjwgKzLw/Yc8Qr7h11ayVxDyTQSvEtl5NSKhFCE58LFR9bBhVnixVR
	8UhaHjOygHWsH7vCsk7lnhLb7fDIxNCC1dzstDUyRenkwpsxTjRC2xeid6Uhg2esB01G1NzumZf
	lulDdOncslXWRVerRDAEemDrIQBPR+I5KyCZeZZFBbCJVf8OGfbw0r4TtV8w7cOkXC5M1q9g3BS
	SeE92StJORRDm4G6PRrd6+9BzMiUQbzcrsrU=
X-Google-Smtp-Source: AGHT+IFKmQVKtrRTGaZ8hTWhd7nE8H1E8AgUXml21TmSiOXRMbfiiTxpX/j+26/xYc1Zfc3ne6Vv/g==
X-Received: by 2002:a05:6a20:7d8b:b0:240:1204:dd5 with SMTP id adf61e73a8af0-240bcfbba85mr2301691637.8.1755144938050;
        Wed, 13 Aug 2025 21:15:38 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd9795200sm31652911b3a.114.2025.08.13.21.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:15:37 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:45:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] rust: clk: replace `kernel::c_str!` with
 C-Strings
Message-ID: <20250814041535.l7yj2wm4ae3l4k7p@vireshk-i7>
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
 <20250813-core-cstr-cstrings-v2-4-00be80fc541b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-core-cstr-cstrings-v2-4-00be80fc541b@gmail.com>

On 13-08-25, 11:59, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  rust/kernel/clk.rs | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
