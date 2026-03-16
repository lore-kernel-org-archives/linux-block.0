Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CD3932E8
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662322; cv=pass; b=tuJ4p3JYTcNhcvmND/2wM6KswuPA6FgRlZuWTRUJrrUR9LnboUzSx6w1zCx8UI81OD0E1Ifudg9XSCfccv2xT1ynPq8QR095rDgr6ZjDLIMes5evaCkHGDJclvSwG3sYTiZYTcgNmMYDCpvaqnhXuItTg5ip0QaVoGivOmpAGLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662322; c=relaxed/simple;
	bh=WqzStTDme1iRCeMFGoEp8Qdz7FeziR1yr/cuI448uRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAD17wGGPX5PVgFNrTPO1c7FHAsVP/cy5PiaYkmtcYelJ3ISJEpRbxF+ii5ZdVKiCvnwqvba9Q+UHWAxNjKeVZ2xrOfKTT6rgBLPnMIPSCLFWL6L3b4HGgus1GkE2P/rOUXcraVXSLJBGHLfcGOHNXAsYZUzrYOnQCghmQKANXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGj8sgx6; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGj8sgx6"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439c6fc2910so3440319f8f.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 04:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773662320; cv=none;
        d=google.com; s=arc-20240605;
        b=hqcGgKrhZkrcF06zrqWCPpUBJklLkCBX9VjATAEZNM032hbzVJXdavMcCWuXjRg+7l
         hXR8JdDgq9QpRM77V26lg1oQQfRFt2Vn9tMEMOg2TZfsZc75GWUmkbeYyRXHa5oy5eZl
         UYnwLts/tL63O9LUT94raWvm4BFEczIm69aplJD9wBg6w9R/pbCBdvFkFyfUiNmj9vvc
         wlX1f0ARMwGrEthZz8RrxuXh6COUDu+yQTIDfpffuO1w4eOmg7RTQDz1EzArVHbLGWDr
         Gh7ewVU1veuS7572kvYg2lr8I67g9mLcZ+65Mykh9PjpvVBdM9zdO/9dPEn9HyW5/L6c
         lPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WqzStTDme1iRCeMFGoEp8Qdz7FeziR1yr/cuI448uRs=;
        fh=7ZDsBhRSSSEA6cbT0hdSbNKjKg7dMrLlInpHhkuE0F4=;
        b=TBeety12ZHc77Ge2fVESxFAJSdLXiVktVOHNXEoKb4x5hmbs7wDwcbaVu8QTmX5GKY
         GHjAbBZBOcVINsYbMikkVIGWdcS0+VivfdOoLOLWgZ0ZONOB3InOZjnZxFltAf8vVpXp
         IofcDxDjA/dRMrpa5/PJHDWPdJHd09ApWNJ7MSovvOn0aPIO9CusvZ6H3MBhQsW3TlE6
         1WqAbF1ZgVbfN3DHEkKq9mCSTlw/BRZX3CGwvkHWOwRNEmIkNUNmVje5XYmvb3hfdr8c
         nDdG/u+ymGRE+XM+925e9BJxwGkIwGB0lfD3jJTPZk9sS9EcnKMfj56GBnmXYBDBecji
         6zhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773662320; x=1774267120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqzStTDme1iRCeMFGoEp8Qdz7FeziR1yr/cuI448uRs=;
        b=rGj8sgx6svxA12DAS2Dn4FcLPc0lL4DDr3IMJDqSyYAGmjI91xp3o6NtVmzR1eiMx9
         ikLgdE4AyfHUGqnrn2kiDVkgm9e/YM5FfGsNlSUWEbeMGnfv1bsen/BHuuubzdoa/gqZ
         Vr7CIXLWF9I/X4iVkug/wNMcduL7+V85v99wLxIDJi0oGKxVQygXLSZuJBbjmdsHaojh
         FGys47NeXS0px/Bqgv5pVfXtkXW10jIs/CoxWMgRxx965iyzbDNFX+gmZAckFy+d1+oA
         8ThWMbc4QkJiBkjtSXAsnP7aOOkYiq1S3mgkbISkjq6hFnslB+7LRty4LtYqZLwwHkmW
         OvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773662320; x=1774267120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WqzStTDme1iRCeMFGoEp8Qdz7FeziR1yr/cuI448uRs=;
        b=qx+PgZssZo7lzdfu7zjiABZP1mWl/RPpHpwRP0o2fzU5pzlJN2z32SSxjbJMsItA4u
         jl7rb8T9HzxpwWPOKuj2vHOTillWkv5lypAIhiP0VNsF+YgsZ/QKCs8ESzkcchq6rD3I
         XIK0Hf/c1GHG7LP0rViIUuZ9CAN2wfEQp616daClmYoitf9cNUb7ot4Q42UoD2+BmZBg
         e4nJ9Zx5EXrWJlGwkwut2lzEH5qQgA0QMYvbVdWwjEU/mhHPHjrdRgoINXn5DQ/smu13
         ChVyKXGFkZXcnty+t2aaVDHoDZ/yUcsc23WZCw/V3YFem33lyfaOl2y5IS2VVIibahF1
         N6ew==
X-Forwarded-Encrypted: i=1; AJvYcCWzHMKRrG0lomdqJZQk/oEBuEkyKFhlifThV1cMEeltAyShj1GygQsO7GNBysywv4rT2S19D/q/CHq+fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpKLeYuFnX2nd6Xa0jWUaLoEe2/i0WjQNVHfxoL8l7t9POGAQ
	KvGFuy8Z4D523cKRdDxE1wwh5xbO7TORMxpx6Gv1pnm7Y+i+AsI9VomqSCMy+42VnFsuF1C8+ny
	f8fU//TTuTKILSDsWG9UxADg3AQYaHujHkjwV8to0
X-Gm-Gg: ATEYQzz9nEe6MG4HWyvOPln5dJKLhFou9UYgXMAvWlYiQYWFVneTeiR8fZUBMsSZMPi
	OG0tqyErcQCc1z9tbiOEotq/fPXwvJ+97MOr75eNLxm+sudxCxfKF9VpCdptCAsYH17wcaBfjjT
	etA31gIcN7FDNdCRNubFZi6Rf8tsCcwB95R+gi7s3twohqnKMK7S7VFF8ea5LJC5vypMx1vEShU
	3xIWw44RA13N9djakml3esUTGqfYahD1XUe52iPNJhfl+EfpmxjYX8PCG1LiFdRCWypvm6rF0am
	HYNCLvjW2QSDzmUdbzh/5yyFLqIuS7mePGHNp+ybcEd5ewv9oYKgGpbLw78yTRlMtspAOA==
X-Received: by 2002:a05:6000:288c:b0:439:ac8f:5db1 with SMTP id
 ffacd0b85a97d-43a04d79bdbmr23658023f8f.15.1773662319287; Mon, 16 Mar 2026
 04:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-4-de9a7af4b469@kernel.org> <abfNByL15D4s69Al@google.com>
In-Reply-To: <abfNByL15D4s69Al@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 16 Mar 2026 12:58:26 +0100
X-Gm-Features: AaiRm52S0Hs2FH4817i5Rr-RXaUi8EC4_IqQnN2448mAAelNGeUh-DsUEfywyig
Message-ID: <CAH5fLgi+K_5So-kLwyZGhaagEx-rRXPmk=zCOTqG3yh=bSe9Ww@mail.gmail.com>
Subject: Re: [PATCH 04/79] block: rust: fix generation of bindings to `BLK_STS_.*`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:27=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Mon, Feb 16, 2026 at 12:34:51AM +0100, Andreas Hindborg wrote:
> > Bindgen generates constants for CPP integer literals as u32. The
> > `blk_status_t` type is defined as `u8` but the variants of the type are
> > defined as integer literals via CPP macros. Thus the defined variants o=
f
> > the type are not of the same type as the type itself.
> >
> > Prevent bindgen from emitting generated bindings for the `BLK_STS_.*`
> > defines and instead define constants manually in `bindings_helper.h`
> >
> > Also remove casts that are no longer necessary.
> >
> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> It'd be ideal to change the C header to use an enum, but that may not
> work as I'm not sure you can specify the integer width you want for an
> enum.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Honestly, it might be better just to declare a Rust module somewhere
with each constant redeclared:

const BLK_STS_FOO: blk_status_t =3D bindings::BLK_STS_FOO as blk_status_t;

Alice
