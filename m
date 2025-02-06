Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B551E5B8A;
	Thu,  6 Feb 2025 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877310; cv=none; b=PUjqA8/iTtp1cfkAie4Ofdu15QSKvGWGzGGugBz0cx6ho47fc5EWT/nGvvplLX7QA3s4GBHMAXCNXuKYDVAANfz2N40zSvrVr/VxmxBo6UQA9xgYkvvZfFL1qtF9kTrBFs3R1uX6uNH0H3YpJAOGtMUlVTBhyNRkkyKoCPGJa3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877310; c=relaxed/simple;
	bh=NFGMxl1SbuKnFBdg29s4L4SmWMhiT5d/APkJO9nPDek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8DTVufeMHdIt5RZxfSht6TBFFnUW/jIrp/lELE8MebzEsH7T3Y4gsFpoOPCUM6GLxhBUFAlv1eUVaalHciG3qKmt47ZGgjthFh5+lelsYvAZu3c127vZKJniPGzhiPpm/SiiL9+FUFnO5w8JVGMZRz3bceGhxeFgLf/gOlcwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XITWFf2d; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XITWFf2d"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so13971856d6.3;
        Thu, 06 Feb 2025 13:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738877308; x=1739482108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtzujjqM7/NjPejAA9pfY2HcLOFh+EdK4tymo4UbpDM=;
        b=XITWFf2doyFNxUazr8sZyriBU8v05k63zHc5vDOMRK+RHJQotOX/y1GadwErKa2xrx
         WY195dtyhvXTE+BuxOPfK5SY+/2K/qwsXDCNVZBlyTOM1LLZW2tepcHuLkyEEctf0FWQ
         3m3PzfsMmQpq7vixlcwjRMIlmJVBTjxotdnr4Whgcrukw/KwzQAJ2RRc63lSi6Ng/fKW
         fMq4jikpIeDpk07JM+gsD/bXtR3WtUDpVFalB8x3tuCTZMZ8L3nD4MDePlqGOu60sgCf
         d1HfX/gZvSvhBeW552zxAFIt4ItCgFaCtX+uap/Ai0VJetGTypPjT/DmCpb/jLJEBJp5
         1xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738877308; x=1739482108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtzujjqM7/NjPejAA9pfY2HcLOFh+EdK4tymo4UbpDM=;
        b=hTKKUYR207zbtd7hweFZxKI7kwS1L7jwPqDzvPRidbQJ2oWieFsKwBc167fN5rHIaU
         mRhzqvw4EvnMMEz/CCfrVgBvblZTEWYAVDiKWsbZ6NQ7ymcMgSgwqiEjfUo03Fb12sI7
         t+N8xQn+rYEwozYwpGDLjpKp2sEaUXQXrz9yQvUbzXSb94I9ilGcI78T7ytcyxSTDOv6
         s/NmYbEEiENBoCBqGimrI5/uzXkN3BmJMVHz+Q5XAW67oIBRQEgbsWIOW79v5C5662Ds
         oYZZ6yfaR8AUcXsiEkmz8bP+bdHgVnTQtyWwZshI/pJTNcw+rJjoGg+bGweRjfF7KPo6
         Mzpg==
X-Forwarded-Encrypted: i=1; AJvYcCUnLzPyKLF0ecRuDqZjTiYD3R0feNizAKvu8OKL30r5IE5wtBzhkEI149YDQC35XOOimNZ/GZQHZM6RN3BupzY=@vger.kernel.org, AJvYcCWpj15niFhIzfQYXThi1C6np8hW2zonnnZ3X5W8HnLvcLGcWo66u1Ct2XMhV8f8L0FtHfelHnStUnzqpgN4@vger.kernel.org, AJvYcCXrdXOrUIsZK8tein45mnUKWmha87fWlsTX2irEougcFOyrRHO0T7lyUXfNZajTOOdJY2++d2QlvL9exg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTG0xqgnS7HI0hiTV52AqEyfrdotlHqaj2cuPHeQAVkWEXHUW/
	/LeUT53y6CmHhTZkr0K0rSmDC72y6J+YMpDCp7KdzG87dsEl62mPSn2bpw==
X-Gm-Gg: ASbGncv9ZLEhZBvs/hUaD1jPFbg6gt/wH5KYYeda6TZX3WCdImSrssyfwXH5kqkZLKU
	zTld07tGZN+jGcGKq/6XXiDjkPs7gtyxJkyQH4tVCuOeQsYk4kWqUvetcSuHQbdKh6N+53hM8iP
	BI5C0Q043DxEyl8oi/bMeCyB/+zP7qCQ6h3VzKexbmnSGMhmFgCQurUcnPQYMYkRZaFb3pNxnJ+
	oSAoOhF9p7gI4V1/JqOv0nRNU4O24wRtL21B4oWhHITRYW6nwyVBbt/H2FOfedxcMFU+UJBwtgZ
	+ur1KDTlDLNoyg08PiWIq+8ep2h6OdFLHKuNQXx9qlO8moAzkIzmZC17cWNCDETAr5F/Tj/7Dfv
	88KLa8g==
X-Google-Smtp-Source: AGHT+IEpnMeIff/CeoH5Hth0vqekNOrrYi6jTy5OKYjsKCFhAhq1kgrlI7gd/IfvtN10zpRDehDLzw==
X-Received: by 2002:ad4:5f85:0:b0:6e4:3de7:d90b with SMTP id 6a1803df08f44-6e44566e6e4mr10196896d6.25.1738877308041;
        Thu, 06 Feb 2025 13:28:28 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacb22sm9624586d6.86.2025.02.06.13.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:28:27 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 45EC5120007A;
	Thu,  6 Feb 2025 16:28:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Feb 2025 16:28:27 -0500
X-ME-Sender: <xms:eymlZ3UkGnrbl3lpkqaaIuWlUhMguJi6lajCKkBKQSPLNAcf87CgSw>
    <xme:eymlZ_m_tNOnLmZfvVY_28bA_LxTA6xNVvsKiCu129vaf8GvgBzLIBb0dXAWjYfK4
    _8UsvQLi9kLhIIbRA>
X-ME-Received: <xmr:eymlZzbLW2cLZzNW6Hb7ltbfBiRk7DNYXWEliR-pT8A_tAPvKRNvjV9fnkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepjeeihfdtuedvgedvtddufffggeefhefgtdei
    vdevveelvefhkeehffdtkeeihedvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohep
    lhgvvhihmhhithgthhgvlhhltdesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvug
    grsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpth
    htohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohep
    rghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhssh
    esuhhmihgthhdrvgguuhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:eymlZyV2U-kKbGgxNDQrD2cuXFbV9Xk_41wMe2F16CB84koK9RC82Q>
    <xmx:eymlZxlQDpGB51je_jfT68mdVEXDqPRzsXGL6PTHzFrzfM_5XVpzfA>
    <xmx:eymlZ_csAaUzgr6d1TVVX-faNIIzC_bY9OZIZ2augSuPCIwZx4Osdg>
    <xmx:eymlZ7GgN2j0DaVmCm0Y0lDe76P1UWTRFiKl9c9GgPk7BPqQG51NKg>
    <xmx:eymlZzk-6wPIPruZVtrbu_e026oPFXK2Qweo_hmZimpyFNSycaOwrBbw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 16:28:26 -0500 (EST)
Date: Thu, 6 Feb 2025 13:27:18 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Mitchell Levy <levymitchell0@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: lockdep: Use Pin for all LockClassKey usages
Message-ID: <Z6UpNpefdxyvYBPe@boqun-archlinux>
References: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com>
 <20250205-rust-lockdep-v3-2-5313e83a0bef@gmail.com>
 <19dfbe36-237c-4da8-acfb-1d14069a8d1c@proton.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19dfbe36-237c-4da8-acfb-1d14069a8d1c@proton.me>

On Wed, Feb 05, 2025 at 08:30:50PM +0000, Benno Lossin wrote:
> On 05.02.25 20:59, Mitchell Levy wrote:
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index 41dcddac69e2..119e5f569bdb 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -7,12 +7,9 @@
> > 
> >  use super::LockClassKey;
> >  use crate::{
> > -    init::PinInit,
> > -    pin_init,
> > -    str::CStr,
> > -    types::{NotThreadSafe, Opaque, ScopeGuard},
> > +    init::PinInit, pin_init, str::CStr, types::NotThreadSafe, types::Opaque, types::ScopeGuard,
> >  };
> > -use core::{cell::UnsafeCell, marker::PhantomPinned};
> > +use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
> >  use macros::pin_data;
> > 
> >  pub mod mutex;
> > @@ -121,7 +118,7 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
> > 
> >  impl<T, B: Backend> Lock<T, B> {
> >      /// Constructs a new lock initialiser.
> > -    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> > +    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
> 
> Static references do not need `Pin`, since `Pin::static_ref` [1] exists,
> so you can just as well not add the `Pin` here and the other places
> where you have `Pin<&'static T>`.
> 

You're right about `Pin` not needed for 'static. However, the
`Pin<&'static LockClassKey>` signature is the intermediate state, and
eventually we will need to support initializing a lock (and others) with
a dynamically allocated `LockClassKey`, and when that is available, the
type of `key` will become `Pin<&'a LockClassKey>`, so `Pin` is needed.

So I would like to keep this patch as it is. Works for you?

Regards,
Boqun

> The reasoning is that since the data lives for `'static` at that
> location, it will never move (since it is borrowed for `'static` after
> all).
> 
> [1]: https://doc.rust-lang.org/std/pin/struct.Pin.html#method.static_ref
> 
> ---
> Cheers,
> Benno
> 
> >          pin_init!(Self {
> >              data: UnsafeCell::new(t),
> >              _pin: PhantomPinned,
> > diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
> > index 480ee724e3cc..d65f94b5caf2 100644
> > --- a/rust/kernel/sync/lock/global.rs
> > +++ b/rust/kernel/sync/lock/global.rs
> > @@ -13,6 +13,7 @@
> >  use core::{
> >      cell::UnsafeCell,
> >      marker::{PhantomData, PhantomPinned},
> > +    pin::Pin,
> >  };
> > 
> >  /// Trait implemented for marker types for global locks.
> 
> 
