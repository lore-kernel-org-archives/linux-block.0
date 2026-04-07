Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6B14A4F0
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524523; cv=pass; b=mjhv/ORwLITPxgUJJy5GbfUCwSq8qWMZA9JowHnhJGWet5eS2Bkq8gXr3JaCwgxTKbbUbmNwsAr0lsV29SjY/sozA5yxdmppXVfXnxjom99Vs9yltqDmo2tuyTJl7g3hp5gz9ooXxWSKF4nK2gHtxUxMMYFPvywmAtUdlEslUo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524523; c=relaxed/simple;
	bh=C6sODPPjnlrZIOKdwziurbw8hAdqBwTpglq0vQMQ05A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIWbqUok76OdEh3d+RUcfxqaYxIf731uwoqACI8khm0y0InehNvsSnHFDKPGYd5JPD0ZDUhSYaA/D0FWE3q3B66rUWI/Y4U6o3jKUbDspB0dhEbvRZsRUvgdNeC6cr5T+7mil0cV4IVymBoRvJL0jAk6o2mIV8k45vw8PiMy37w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGQ703As; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGQ703As"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bd5658b901so266176eec.3
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2026 18:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775524521; cv=none;
        d=google.com; s=arc-20240605;
        b=b7fhaPR7HGA92pwKVfE/6tKRG1n5BnKAvouxHaUNQPVVq0d9gEeCZ+I+6lsQUoVzml
         C59e5DVvBL933vH+zvVUZZ4KnD6ySLvvyrxqxHdWV2+YtL1qRojzw98PNSWREtSHnPlH
         Zz1vQiQ+Tc8TgXXkE/ZFoFoIx1s/XT6PvKu2DfgfPhpgSQlw9twmJOD32TqpCufyAqRa
         +LLCVTzKevMo5dHBxBPFO4yCVj/cUeYLwyWMh94Hmzuh/nUJdpxvoav0XgbSZo18RWsJ
         8P3Q6XRxq+rfXxauVbfFuXWrmZFYJbl/XQLEDf5MESw1Ot77Aw7LBSCq317vvX8IMNTJ
         ks/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C6sODPPjnlrZIOKdwziurbw8hAdqBwTpglq0vQMQ05A=;
        fh=eLoV0AIlivJwz2pxQSRpofZdCw9FvztdEx4ZiKNO6po=;
        b=SsozZFrkE81Qia/fchzZ2/BL7mSvY75CTmm+JBJoALASCVXrSK6tZhHQ6F5odfDse7
         qAYDdaWyUNU/Q9p/s6+fAS/i0FzmazSa8h6ycgEA/BGJCSHto+admiNqUuuo/x4hObX3
         aVE49ODzrnfpZoSBOjjV7kDAGwrIS+Er+x49JwikBdeLr3w4HaMI8iBkehBAiQSNyTLo
         l0U7UR/ruvAl20LI4H1LOJb29ov8rtnP0PU3aW1W4MHHkW23CbF6AmYf6FbENtPPNQMx
         IXXHqLsWKsPwKnU9s9dF4JOJ64VPBxFqYbkPGVp0ad/jFB6BGz2ZnnxveWqY8TWivuGs
         PBRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775524521; x=1776129321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6sODPPjnlrZIOKdwziurbw8hAdqBwTpglq0vQMQ05A=;
        b=YGQ703AsCty0gWvo5XnlPxhjc5LCMeOjJ+5VaBNrHpu+0TsSyjrNcWEWd/m0xKLvux
         Fz5M7QK2bIoG18YbdIV5pRHLUt0VRJlRNL3J2rM62DhKJfRPvZiTpFS5LoAtuErROO2A
         i5cq6rZGi0/DoY6biOvoAPYi8iZftts1ZmtoQjeEvt3xZ+dK0jCer/1bDx9ZChZ+Zp0s
         7rRkWYB/dNzrdFZyyERvo07rZGCl1n5PabJoeFVP4Vr7eDLp+plO3A1tRXMKwwL0NCB4
         seVG8RH8bxEcUVp89x1xzYmOL6jQnuRQvt7t2bQgN7B7U8eQ6d27Ci+Z9zrMJMknNpl6
         Tbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775524521; x=1776129321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6sODPPjnlrZIOKdwziurbw8hAdqBwTpglq0vQMQ05A=;
        b=IX/q+zJfplHeoDzmU/QjTHl+87NX0tZduHz3wzoshjV+HoUt/CEp+fSCNssYUcdCQk
         Jr3m+v39+fX0+XE95mDj25ScofPzPSKKINJIHntQcmtROjYNskzExYMRpMp+vTeA5WSs
         LI7DFE/ep5LyUtf6Uim0Bc2OY4adLD8Vfem3GDYza6ci0fB8YLzRF9t/dxzJiMpnvcZJ
         JtvwjHQyNQO57uBMkNGX0Eh+N3uoSaFhldhg4WjDHinj9iri73Y1UVnQwwjL6I9+IKm+
         LDkMFnfu+BNEBVIV3vd3/3CT77mEx28NerXBSGFi50f+DrCWepenK8nvJfBuLFq7qe1a
         /TBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6tHRkU32Xf26IYl9naJvM2FbAjjmnMw/NDOYW/wTcsdzxy6eJm2za6gFv2DnuPOynfxETIj7s4LKBaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdqzrW5Vq4kQ4wzzQ4eOv6foglK14e0P8HmINT2nxgMaogLQM
	g9Kp7fUTyZBMa2qnwuu1zCWz+xd2IvUlQXVqZ+axm+PFrFO2mDZtT4yNSKbiXEAkm7QKoaOeB4F
	z1s2SJ/1rx2O5yFSEhoQgLrIDtLwnMl4=
X-Gm-Gg: AeBDieuCOSSOib7Cw14ISeaGH2Lre7JgR0ykN7XSpCl3pp7uzJPCLKHY5ukrRLITiIH
	6gGxByLeI9vdepycn+m6pHQWaugw0kJuJfEMgWEvLQJ5P8R1ruganQ4gFMSfzbWRLa2OXfTHmlr
	ydjQXPxQq22sF41HJq+3cS8PB0FYYqOh5xI1JLgdmELm/mvXBe7hHs9awk19j30MyDUBEkqjjne
	FQrt8pierUb40FMY3eVXbXKt95c5RjlCriLse5Qw9wrnke2fC21Ifd/d6n+q5CDJAh5BEOxDoZs
	MYep07EBriuKUsn2FDTtyhMSyDwoVCA0VFVdtisGLgVQR6zQz35Ef4oPXTTmDWUUC6EwaLomeFE
	aK19LxGiqdFpUI85lvjxJfDo=
X-Received: by 2002:a05:7301:1007:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2cbfcf52a13mr3516734eec.3.1775524521173; Mon, 06 Apr 2026
 18:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org> <CANiq72mnGArtgAbe7xXZCYW1x7Zd5hozfnzoftaGy9rxoLO4ew@mail.gmail.com>
 <cf28afe0-ede5-4d1a-9824-65a1448f8161@nvidia.com> <CANiq72n4tmTzqbcHCnzUBFyLVmJzB-AJng_1FgELJCWr7hDg4A@mail.gmail.com>
 <efe61810-2b28-4acd-b69f-d577042c0b62@nvidia.com>
In-Reply-To: <efe61810-2b28-4acd-b69f-d577042c0b62@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Apr 2026 03:15:06 +0200
X-Gm-Features: AQROBzCpjGVGSHiqD6WWW0AkLWSnE3ic7jf8UnYoPnV_5tut3XVgaNfJWwQj0o4
Message-ID: <CANiq72n84On9UxQ9CNqyFb5wpJZKrBzb1Xej9ZRqhLim--ftAQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] rust: bump minimum Rust and `bindgen` versions
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Courbot <acourbot@nvidia.com>, Simona Vetter <simona@ffwll.ch>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:07=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> That's what I thought I recalled, too. Weird that it is not in rust-next
> already, though.

It is normal -- in the kernel back merges are generally to be avoided.

Cheers,
Miguel
