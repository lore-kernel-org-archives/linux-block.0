Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EAD13049E;
	Sat,  5 Oct 2024 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728108626; cv=none; b=cRd+lsjFBMbK4zdWzjz/PvEUuE7HlCkF39lCPVq9pWqENYDQANbTWPIyCz876t6XCSrGKodmVt94SI6O8bGL/sLKIPNMxje+v7sNaUICBci9Ny1hbWK+k4FWWH8EcFL0CWXqmU18OFPxXo6kGKAoWHLWnI+FQ5Ekydf02VjYZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728108626; c=relaxed/simple;
	bh=635Bn6hYjmr2sxs/uq7ckrdJIQP1sayE7ylcDwObo6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4bGAMJbWQ0rFBz2goIHJla6DgBL8j/Ju/Kkw6pB1y7S5XA51gSKOcHVn031UDvBer5HI4TbYqfxiCmWxIqR9CSYEKMunvsFvQrhUplElaKT6T0F/NVeS2NFpFRPaBftUEBMc+ygAz1iejxwrR7KHB+TVU+FqYIDh5BkNNxjFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHdIRyUX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHdIRyUX"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso408880066b.0;
        Fri, 04 Oct 2024 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728108623; x=1728713423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAISPOWXGD8rHHheajjOUDZkVIJJBFpsvr2LQ0rtE7s=;
        b=NHdIRyUXT2MKyMWKm38cny0WxsD5kWjIU6ddw8bicbnlGByyF0Jx2x29Yzj+mA1npE
         6V9xfTlR37zuL8mbjPr+1WfUgp65EVLwSuHntGjdPNpCSoP01oWjFCd8Xxmt2+5p+mX7
         XIkN5JrOCoY33UGJTRyzieaBrTE+cN3es9mKYtcz3CD1BLoLEYlGyiTZjpbfU5ohAOE2
         sFUMGsfaV9FKmjDaPlWjOyvmsLJBq7DYs/6Sq7VE8iiMGqN7ybrtinn18nHBRHE8mHtD
         pGo3UGZ0QtDJ2WP91mAMGZMdOpfHBv9YlTpYd9DHZlT+8GA43q7ZDGRdkE9O/gWGUnr2
         G2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728108623; x=1728713423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAISPOWXGD8rHHheajjOUDZkVIJJBFpsvr2LQ0rtE7s=;
        b=lgnXVaBGiTvwHCf3bIAM9J4va4iVZmvW/OPmcSwxcP2QMQLzUb0bkcsb15Zq/hi8oT
         SeKE74V7r2WMDG7TiICWg+VMQwXwx9whzfADripOVj3ddBfd9DFW1dD3r95GpwjciiWa
         WpcGQJTxOAIpQJUS5Z/xE+b+hhuk/AfzA4iuzRlemSRpKMDwglHfJJs62MHpTtdRQizz
         SAKt4BH3QgRoZZsJffjtyH2lmTOf/lbmDFFsHkz307MLIUIK7z56gXmX4e4s+lqYmmUd
         m+YxJELxDXH1EMdOWktyLpr14FfPuUqZxoUCpamWguP6qJ3FksDjBXtCzA+S5XbhnEsC
         hRCw==
X-Forwarded-Encrypted: i=1; AJvYcCUsqydw10j5/AqB9bzOzVy5Dcm3whDDJ3HHfZq+l6eMxe33LwlnQrHoXouCBZJIVMi3T4jCORoOMs7BtJ4=@vger.kernel.org, AJvYcCWdvhp5fZt5hFLbt8MeAjap3UXJiPgOSUQavlFu8GrcTrCRUa3hPZCUi2rrEXFUjXZEY3NNHFaQ@vger.kernel.org, AJvYcCXI2fPCpvAuNXdsY8fj4SFWZ6VqoN09dqcBYPfRl4psabEeEOvjtM2U2z3B7lQy1WaU75IQuWs7gj5uoeexW9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+f08SSLIF1zACV9ztNwcrufQDsnmhgiJqNAOGCI32ORif1kBZ
	w9aZdVSPAPL0GlMWxInerVsan6GLZiLsOttdfVQE6N/0HDUU0f2T
X-Google-Smtp-Source: AGHT+IGqNUMAwPWClwPCdsq8h1fl8+wh1idmUH3kZ8Jaoe0npsvFj6GqQHbFe2PfbXsNj9t89Ru+nQ==
X-Received: by 2002:a17:906:6a20:b0:a86:80b7:4743 with SMTP id a640c23a62f3a-a991bd0a96cmr534148666b.24.1728108622737;
        Fri, 04 Oct 2024 23:10:22 -0700 (PDT)
Received: from ?IPV6:2003:df:bf2f:2200:42f9:1ced:dc84:a82d? (p200300dfbf2f220042f91ceddc84a82d.dip0.t-ipconnect.de. [2003:df:bf2f:2200:42f9:1ced:dc84:a82d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993ab8e75esm36451866b.222.2024.10.04.23.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 23:10:22 -0700 (PDT)
Message-ID: <14724ee5-9f8b-4370-a68d-2797fa9b4c53@gmail.com>
Date: Sat, 5 Oct 2024 08:10:21 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
To: levymitchell0@gmail.com, Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241004-rust-lockdep-v1-0-e9a5c45721fc@gmail.com>
 <20241004-rust-lockdep-v1-1-e9a5c45721fc@gmail.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241004-rust-lockdep-v1-1-e9a5c45721fc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 05.10.24 um 00:01 schrieb Mitchell Levy via B4 Relay:
> From: Mitchell Levy <levymitchell0@gmail.com>
> 
> Currently, dynamically allocated LockCLassKeys can be used from the Rust
> side without having them registered. This is a soundness issue, so
> remove them.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi@metaspace.dk/
> Cc: stable@vger.kernel.org
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>   rust/kernel/lib.rs  |  2 +-
>   rust/kernel/sync.rs | 14 ++------------
>   2 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 22a3bfa5a9e9..b5f4b3ce6b48 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -44,8 +44,8 @@
>   pub mod page;
>   pub mod prelude;
>   pub mod print;
> -pub mod sizes;
>   pub mod rbtree;
> +pub mod sizes;
>   mod static_assert;
>   #[doc(hidden)]
>   pub mod std_vendor;


This is fixed already

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/rust/kernel/lib.rs?id=ece207a83e464af710d641f29e32b7a144c48e79

and can be dropped here.


> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 0ab20975a3b5..d270db9b9894 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -27,28 +27,18 @@
>   unsafe impl Sync for LockClassKey {}
>   
>   impl LockClassKey {
> -    /// Creates a new lock class key.
> -    pub const fn new() -> Self {
> -        Self(Opaque::uninit())
> -    }
> -
>       pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
>           self.0.get()
>       }
>   }
>   
> -impl Default for LockClassKey {
> -    fn default() -> Self {
> -        Self::new()
> -    }
> -}
> -
>   /// Defines a new static lock class and returns a pointer to it.
>   #[doc(hidden)]
>   #[macro_export]
>   macro_rules! static_lock_class {
>       () => {{
> -        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();


Should the SAFETY comment added in the 2nd patch go to here?

+        // SAFETY: lockdep expects uninitialized memory when it's 
handed a statically allocated
+        // lock_class_key


> +        static CLASS: $crate::sync::LockClassKey =
> +            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
>           &CLASS
>       }};
>   }
> 

