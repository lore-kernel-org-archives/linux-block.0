Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE6207A15;
	Fri, 10 Jan 2025 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518423; cv=none; b=g4GAqiY4KYt2ykEQJ4wTCrT6ipLyp5UTvMNkvv6mxrRyZiQXxXrEdt+JlOPBJ+kQsJceY0nK+GPkFY4boMcldj7qdf4AHXYWiUFqWvpSmG4+P7tQ0Mw79MReDMOS7bGvCTClrNrw1BoI2HDWm+R9B6LI9ecc4VCeF0bkW7gyI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518423; c=relaxed/simple;
	bh=cFP3bHfydKoOvJDX4q6qcRv+WfA9oo+5sIiUfxPlzr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okogJLwbhldres14ojlVGjH9QCxT9SBk9qvyMj9M+y6qqkuw81+7Yg4lVW6fYuTu6ksgP0WkuymZZfIQOHKBHw7dvSblDSn1NlHLeJR/ZKRrPOzUIUZTH9h7ELN2JbJN3yecTK/NKX1gjudtv24XKWQpCbyE1rlRtEODqCdZyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV8XkraW; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV8XkraW"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so161303985a.0;
        Fri, 10 Jan 2025 06:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736518421; x=1737123221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3xGxxcjkV1GQqHW+T0bZftfuqunVR2tHc64hAbzPOU=;
        b=GV8XkraW7eQJ67ECAJYRHAvX6Kb/HL1AQyseKrCA5GuNbRxLIiVnh5u+i2wXspIx5P
         U23YxA4EvhCx1KT99RKUpWFH/g6wjGTdn56rokjVLeA2Nc8oWwjO0ZngOjlIHdg+VSmv
         JaF5iiAbb0af8p5J5PDMe8EZbVfjSs1hJt3TiD/wbVLVHg1BdmF6xEJjdJK/zsg1tLlU
         nBn0UsrsjhyDXR68yPEdf+FKYr4PmPNyD0v+CJERuCDfZyrPc8bWJkze+Skynx83zb1f
         +vpqkHpALsTEJOklbPR+cJ7Z60mz5n7nQe0CC43/hVDXH5oUZP7to0vKyRa4z0CnjEmT
         5EAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736518421; x=1737123221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3xGxxcjkV1GQqHW+T0bZftfuqunVR2tHc64hAbzPOU=;
        b=v0HRGA/gabJOUVtVvgPIOMqvL1W0b5uEAclSTWjWHWjYU2PkBaoDXw3nc4KWHwCDyu
         EqQCnYihqJpiZfM6sk9sQEyYAIE1QG2OC2hPxNMFd1XlzLx5tihnk1ijVxkDBvE6NgcJ
         dXT3n9K3sZYpGQl/CLj8xjiYTmCO8TXsjBE78a38/ad5ngznqmDXiJUDExzv64SlVBjf
         N9Mb4frf1ba5enKRGNiaq+CbWnPUNbV8xMuXK6LHy9jf2imyVDW4g3pXmZeVfqywJPV3
         XlD7lOsV0IMkEIrBazdYmyOFI3itPoXM/mG9ocwyRhpT413YJ5/HkFuj/CvUbKMZn6HL
         e9jw==
X-Forwarded-Encrypted: i=1; AJvYcCUAfXjglFvimCGbm8VZNNfGCzRmJtgTKZ4Z8nlMl4Fkq4mIcjNgbDZ0tKJreZRFQFMxB+RxxdeR0lQ5NdFU@vger.kernel.org, AJvYcCVBn3UOIEDMwBnlkch/Cg3lk6znaz3v/isfNWkppQno5BXOfzlzfzz8HcjGRBlu/rBLBkEssd5C@vger.kernel.org, AJvYcCWE0N6df2Z0/pajGB9VwTPfpVgj7iP0g23n2KAtUE8JIdkDb3Pk/sI24Q//DUZAhbC3eAkNDSjdYVuTGQ==@vger.kernel.org, AJvYcCXWeuVIrU/VPSMdt+x/Bt+uGa1Hm8TbccurcJsbwpA3ZkZMQt/NZrl4guFAdOd4IbMZyovPV3iZAC346/RcFI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymln0cE88xojbA6oBlxntkz7fOEwF/um1hDB70gTg6VEnh2L9M
	h5QrHTCTrR24tDKKoE1hrYjrBXMBpVTB0FAAIaoFEZ4aE0zaMOvB
X-Gm-Gg: ASbGncs04rRX+zhQHuJrI+sMWWzKB7FtUocOfh3bPc7BneIuzFh6v/6+WzA2MunAf6E
	nq0q/hTBfqjCm16s7LLD2LJGqWN2duhFsRRJ2oC5TWq+PNWgeClhTaJVh+qHtNp0pi70klFYEsj
	8FlZIlvBxiFOeN1qpuqX5fw1tLhjLx4s2ILU0Eui2xZqX4moxWFwHuFAZ0LSSzTn8gJhBhZRyYe
	/0hlPShkZGdDJW5wIymfJkE2aDJxkiBZSRhvErp2qkzKImEKE3uBLDUU9vbW8NrBermBrVqm/pc
	hADju4q33YDmNYp6Wn2rqGWfsu+Ibgoz9Q/ekmUDqsdn2sg=
X-Google-Smtp-Source: AGHT+IH/AJg7VLbxKgbG7Pi1UJDN7P0zRvx3nd32SpuhQVy2b3XtRSRC0CSWf3XE+/PwJfIXOKH9Xg==
X-Received: by 2002:a05:620a:4142:b0:7b7:106a:19b7 with SMTP id af79cd13be357-7bcd970d4b8mr1646495685a.18.1736518420710;
        Fri, 10 Jan 2025 06:13:40 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce350e155sm174951085a.97.2025.01.10.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:13:39 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E0BA9120007B;
	Fri, 10 Jan 2025 09:13:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jan 2025 09:13:38 -0500
X-ME-Sender: <xms:EiuBZw2XQQGXKzRHxWCP5ZF9TIiw4_yfFbzF5PpcvD904wijbN3RBg>
    <xme:EiuBZ7EalUTYjQmmBEOk6I15iNHW0owqLn69HToj8kifbz6htdxAAbLGTSqwMPwwT
    TuVcZeFTFOEiKO-YA>
X-ME-Received: <xmr:EiuBZ467AzrqEeHIO2ZyLK6bVyTR8C9LNMM1IUbTxbcbbeaKGEvmmoZXecc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgieduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:EiuBZ53b410hiT_tH4zrdIbdQ3KT21JRawsgjLL3lwYM8rfXq6D0SQ>
    <xmx:EiuBZzFUU4il_pl5RCBYIR6nNcPSBzD5S_TNk3jt3TQlUEvs08_Tew>
    <xmx:EiuBZy97MYXYWQYsFzwiWOFYBkB4XT7HzpaPXRvdv5RIZ-nvaMIFkw>
    <xmx:EiuBZ4k-r-7GEXVxvXRJ0LWav4iFtDaRUQmwoSaQFY9BgmTO8VPZRg>
    <xmx:EiuBZzGDyY8n9cek9T8To5f1RW1QUS8t03fiDW9L9Esmpmd24aazS_-F>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 09:13:38 -0500 (EST)
Date: Fri, 10 Jan 2025 06:12:34 -0800
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
Subject: Re: [PATCH v2 0/2] rust: lockdep: Fix soundness issue affecting
 LockClassKeys
Message-ID: <Z4Eq0qoZaIt7j9zW@boqun-archlinux>
References: <20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com>

On Thu, Dec 19, 2024 at 12:58:54PM -0800, Mitchell Levy wrote:
> This series is aimed at fixing a soundness issue with how dynamically
> allocated LockClassKeys are handled. Currently, LockClassKeys can be
> used without being Pin'd, which can break lockdep since it relies on
> address stability. Similarly, these keys are not automatically
> (de)registered with lockdep.
> 
> At the suggestion of Alice Ryhl, this series includes a patch for
> -stable kernels that disables dynamically allocated keys. This prevents
> backported patches from using the unsound implementation.
> 
> Currently, this series requires that all dynamically allocated
> LockClassKeys have a lifetime of 'static (i.e., they must be leaked
> after allocation). This is because Lock does not currently keep a
> reference to the LockClassKey, instead passing it to C via FFI. This
> causes a problem because the rust compiler would allow creating a
> 'static Lock with a 'a LockClassKey (with 'a < 'static) while C would
> expect the LockClassKey to live as long as the lock. This problem
> represents an avenue for future work.
> 

Thanks for doing this! I found some clippy warnings with the current
version, but overall it looks good to me. That said, appreciate it if
patch #2 gets more reviews on the interface changes, thanks!

Regards,
Boqun

> ---
> Changes from RFC:
> - Split into two commits so that dynamically allocated LockClassKeys are
> removed from stable kernels. (Thanks Alice Ryhl)
> - Extract calls to C lockdep functions into helpers so things build
> properly when LOCKDEP=n. (Thanks Benno Lossin)
> - Remove extraneous `get_ref()` calls. (Thanks Benno Lossin)
> - Provide better documentation for `new_dynamic()`. (Thanks Benno
> Lossin)
> - Ran rustfmt to fix formatting and some extraneous changes. (Thanks
> Alice Ryhl and Benno Lossin)
> - Link to RFC: https://lore.kernel.org/r/20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com
> 
> ---
> Changes in v2:
> - Dropped formatting change that's already fixed upstream (Thanks Dirk
>   Behme).
> - Moved safety comment to the right point in the patch series (Thanks
>   Dirk Behme and Boqun Feng).
> - Added an example of dynamic LockClassKey usage (Thanks Boqun Feng).
> - Link to v1: https://lore.kernel.org/r/20241004-rust-lockdep-v1-0-e9a5c45721fc@gmail.com
> 
> ---
> Mitchell Levy (2):
>       rust: lockdep: Remove support for dynamically allocated LockClassKeys
>       rust: lockdep: Use Pin for all LockClassKey usages
> 
>  rust/helpers/helpers.c          |  1 +
>  rust/helpers/sync.c             | 13 +++++++++
>  rust/kernel/sync.rs             | 63 ++++++++++++++++++++++++++++++++++-------
>  rust/kernel/sync/condvar.rs     |  5 ++--
>  rust/kernel/sync/lock.rs        |  9 ++----
>  rust/kernel/sync/lock/global.rs |  5 ++--
>  rust/kernel/sync/poll.rs        |  2 +-
>  rust/kernel/workqueue.rs        |  3 +-
>  8 files changed, 78 insertions(+), 23 deletions(-)
> ---
> base-commit: 0c5928deada15a8d075516e6e0d9ee19011bb000
> change-id: 20240905-rust-lockdep-d3e30521c8ba
> 
> Best regards,
> -- 
> Mitchell Levy <levymitchell0@gmail.com>
> 
