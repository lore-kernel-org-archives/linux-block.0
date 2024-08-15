Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4DC15383B;
	Thu, 15 Aug 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757643; cv=none; b=ELdGTUo5MOfVR5blIryTNA6iXj9lDuI8+OogTXZdcrEJSUoxA9kVSqRwJ3zw5UTW+CInLEQpuDsGOBlN2dSWUHY1H9b7Gn5uoLZBW0xd4D5feiZYsTXX6rt02TG9dI9Co2AL+8uqK1hf/yfAolaH57nw8ZTkaxrqkwLauYgfCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757643; c=relaxed/simple;
	bh=RSrImnI26Mo0f9XuPAwK3HwRGo6HYNUAhl91ruFjRGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFF8yIJJLkLEqQJOqEzzdcuFIVq5+vJn6DbhWIMvNJ6oFMiVJL/HGfzGsp5epaKVnwPafEcftk951MHz8MtDfDZdPGUoq3609DA9en3LNkFZchntpt7VCJGtTrr+5RQSyjmlP8BdVwzDAzVs5ShEiRHenkff8MVs5XjXcxaE4bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrFIoTVy; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrFIoTVy"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b79293a858so6975446d6.3;
        Thu, 15 Aug 2024 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723757640; x=1724362440; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z2jIJr2MkBoBBw06sdkqmr4Bu0hhBeX1gGKR5UMrb0o=;
        b=hrFIoTVyNXfy7VC1Q+WhMAtdPhP1H/AD9/OJFwNyy0zyJkE1JloajS82McC65gKCKq
         W4YPSpYvafOA/LpghyyvTPNumJ6y4CCqZsMs8yhj9van0RZeaRDlfp3uhHjZurC1pT3v
         Wv8pmzt5Uk+Zc73u9rb4NKT/PgNvKNrIEEos/8oguPGNFG2opXSoBfQs51l/RMJUq1vH
         5lNtWkEWur+hlHnJwOAs1OyDvcfL6Ng5gXxKeTmSoSZO9MLufuNxqZiiBnUyJzamrcNt
         H2tKvy2uSYYOySMR64PWHQcI7SBsOD6z8AnsqNbd2Xfdle3f9NsHyTdOMwl02dyW+uF4
         t1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723757640; x=1724362440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2jIJr2MkBoBBw06sdkqmr4Bu0hhBeX1gGKR5UMrb0o=;
        b=Gh788yS/zwwCX6Utuffd+dl7wy2HCWvX2y5zq2QGYGM3fKTY3A2BBR5o/jAe2aZmpO
         tisgPJE4Bwvrcy5Uc1VIVBJxYq/XGwHCTjTBWkh4jbmRSBipoMaRaHFwYDt8au0XOqQm
         vLz/XmnlI18Z7J8URNEGfoifL3vP1TfVmc/pHlwow/Z5gRJfcD5E9Q3LXD5CG5qhnywn
         Cpfy9WcZ2LlrGiopX6mZdG5eImpgUSHUZrkPVU+qL6uYiP9c3I1dzhfdvSlZPP6vFC9y
         EXDHn6OJw1RgY5FB6SHLD36LEvTno+TGZlONX7rAw4rctwaDKHSDXM+Y4/+I+ruzhI4E
         BlnA==
X-Forwarded-Encrypted: i=1; AJvYcCXB/bEiMY91aZuCmA6022sWgwDumotyqfL2TgS6+xXH62fFDfhfbcZOJ3oqhoPsO5/QToyZMvbtwftJmCX+zPhQXgYb3rcyqSQyKZ5TtURzInlqHxMt+KUlwj7IIE1A4B2zPACY1BM7aVbcphfjj9QNtRw/p9NnGPlJ8xm2UPNXihNFkV0GoXMURw==
X-Gm-Message-State: AOJu0YwXhH9RpyQZ0QIWZQBM6UAsghKrpamsobJ3ZNdyCGiOOQ7WpPAO
	YeTx1P7cwswmmbTczerv1ymPwZcGAs1a0gi185S8MDC0ngIK7joLBVaxnQ==
X-Google-Smtp-Source: AGHT+IHyjaZebrZBLdl2QbomoWKhII/28c0GgEpouwSlQ+Oz3+e7o+jzgs4lXyImEasQd2Q0ltpZ5g==
X-Received: by 2002:a05:6214:311b:b0:6b5:e51d:441d with SMTP id 6a1803df08f44-6bf7ce81df7mr8712666d6.41.1723757640289;
        Thu, 15 Aug 2024 14:34:00 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec909dsm10004816d6.100.2024.08.15.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:34:00 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6F32B120006A;
	Thu, 15 Aug 2024 17:33:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 Aug 2024 17:33:59 -0400
X-ME-Sender: <xms:R3S-Zmtx8AtLrCuWhjcdz0WHaLAJYJZUhG74nO6eKFu9uElSS8aRzg>
    <xme:R3S-ZreI4LvldSiKftaUZc7iFTzc2G1GWgl8RRAZBxV7lfnkNI3zbpb8AKLngncjS
    iYmVBbdWpys5cgBIw>
X-ME-Received: <xmr:R3S-Zhz4gmsnCom0A1kchwZEwM1aGTo1q0BPVnUTe5ldDVDm4-G2qqa2OrfwHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfdvveevkeektefhheejgfefhedtkeetieeh
    tdeufeduheffteeffeejheetfefhnecuffhomhgrihhnpeiiuhhlihhptghhrghtrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoheprghlihgtvghr
    hihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhhmihesmhgvthgrshhprggtvg
    drughkpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopeho
    jhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprgdrhhhinhgusghorhhgsehsrghmshhunhhgrdgtohhmpdhrtghpth
    htohepughirhhkrdgsvghhmhgvseguvgdrsghoshgthhdrtghomh
X-ME-Proxy: <xmx:R3S-ZhM4YLjHI78r4CyfKqn3lIhQvygtXm_VRCIzoefGFxw0P273cQ>
    <xmx:R3S-Zm-2IFvQJX9Y6li0ow_HJ0IETduUQHw3CAl-szxy-SsdkP4CTw>
    <xmx:R3S-ZpUDECKxhGqQXvs9tSCbcPSkxpIakpwYicQ-kA7YIAEvMnxpnA>
    <xmx:R3S-Zvf1AtqWRnSzpo1m9WaFsnTDm_EqJI9DRJG6yIpE2YtfXUHoEA>
    <xmx:R3S-Zgdxo3bHZbm78QcLFWWXfECPyJSnPk5UNTyeMuxZs4YdXuq5PjvE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 17:33:58 -0400 (EDT)
Date: Thu, 15 Aug 2024 14:32:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <nmi@metaspace.dk>,
	Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	"Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
Message-ID: <Zr5z7N2JCMBbQ_YK@boqun-archlinux>
References: <20240815074519.2684107-1-nmi@metaspace.dk>
 <20240815074519.2684107-3-nmi@metaspace.dk>
 <CAH5fLgih1QtO-ACyoifNsgqd=VtJimoGV+aD=3iHG0wb+iDGyw@mail.gmail.com>
 <20240815200738.096dca4a.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815200738.096dca4a.gary@garyguo.net>

On Thu, Aug 15, 2024 at 08:07:38PM +0100, Gary Guo wrote:
> On Thu, 15 Aug 2024 10:04:56 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > On Thu, Aug 15, 2024 at 9:49 AM Andreas Hindborg <nmi@metaspace.dk> wrote:
> > >
> > > From: Andreas Hindborg <a.hindborg@samsung.com>
> > >
> > > When allocating `struct gendisk`, `GenDiskBuilder` is using a dynamic lock
> > > class key without registering the key. This is incorrect use of the API,
> > > which causes a `WARN` trace. This patch fixes the issue by using a static
> > > lock class key, which is more appropriate for the situation anyway.
> > >
> > > Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> > > Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
> > > Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctest.20lock.20warning
> > > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>  
> > 
> > LGTM. This makes me wonder if there's some design mistake in how we
> > handle lock classes in Rust.
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> I agree. The API that we current have is designed without much
> consideration into dynamically allocated keys, and we use `&'static
> LockClassKey` in a lot of kernel crate APIs.
> 
> This arguably is wrong, because presence of `&'static LockClassKey`
> doesn't mean the key is static. If we do a
> `Box::leak(Box::new(LockClassKey::new()))`, then this is a `&'static
> LockClassKey`, but lockdep wouldn't consider this as a static object.
> 
> Maybe we should make the `new` function unsafe.
> 

I think a more proper fix is to make LockClassKey pin-init, for
dynamically allocated LockClassKey, we just use lockdep_register_key()
as the initializer and lockdep_unregister_key() as the desconstructor.
And instead of a `&'static LockClassKey`, we should use `Pin<&'static
LockClassKey>` to pass a lock class key. Of course we will need some
special treatment on static allocated keys (e.g. assume they are
initialized since lockdep doesn't require initialization for them).


Pin initializer:

	impl LockClassKey {
	    pub fn new() -> impl PinInit<Self> {
		pin_init!(Self {
		    inner <- Opaque::ffi_init(|slot| { lockdep_register_key(slot) })
		})
	    }
	}

LockClassKey::new_uninit() for `static_lock_class!`:


	impl LockClassKey {
	    pub const fn new_uninit() -> MaybeUninit<Self> {
	        ....
	    }
	}

and the new `static_lock_class!`:

	macro_rules! static_lock_class {
	    () => {{
		static CLASS: MaybeUninit<$crate::sync::LockClassKey> = $crate::sync::LockClassKey::new_uninit();

	        // SAFETY: `CLASS` is pinned because it's static
		// allocated. And it's OK to assume it's initialized
		// because lockdep support uninitialized static
		// allocated key.
		unsafe { Pin::new_unchecked(CLASS.assume_init_ref()) }
	    }};
	}

Thoughts?

Regards,
Boqun

> For the patch itself:
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>
