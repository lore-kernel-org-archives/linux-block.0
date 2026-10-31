Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793464679;
	b=x0jYAdM9lLErJ4G8sRWP+5SJyuoAVfmIy3OB4cmtGJsA1YVk9m/IxSxu4FSkhGCwIXVY
	 cHDscDS9/5ODB20Ek3yU+fRwJt9hj8gXEsMqDiKaBpajECYRhDzvItIggmofdLmiXschy
	 R8O0/K1KljvffbFQH58K+pIGM7c6QOdM0trIuT6/EN5eT0JQUKPyjcpxSR1Z/4pHXHagP
	 GKRAUFfDcVV7eqt7o01w/+UYw/7nlpRtSZaVOoOJ9nf0ljgxzbJHgIih/SJaMNuj0ykCV
	 JeaTS+E20DVwoKvDRBKDdHzd54TsAwmEP0NDyMoX+l54vzFUWQLqG0ZYEsXdGruu4xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793464679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vq4vRllAgK6PadituL46LOg4X2pEj6tW413DrF/8Lj4=;
	b=2fSZr0qRJubFcZcBUdwq/XK/fJZT3l84nbQSZEczZ6MefG3jCcEZkvkA2VvMooGEpB/j
	 ER4QcNL6XFykAXp0Sg0NF33Jy1c6DzHxv9RAtqzpiAxwlUtbT5CjkSkpJ2dtJ3lM/9Nsu
	 mwzcw6jcynxJM8EDbIJo+I+SQb5p7W/gBzDaoHE3fUFHoMw02NAhgiIXsb+mFFjOB8Ikc
	 j/dxXkpGjyN488aNBwCS2NSglOJsvAuWbi0L6nPiU0rPHmL4utaLgS8Kx88EdQG0ZuPHb
	 /leWLK16tL2+h/WIGcfS53fqWDNoLSdcoSneg95CzFBc8Aj+8XUZvNIeZvwmZt3rbGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aQ66LJVH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56797606A31D
	for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 16:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56797606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aQ66LJVH
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso11237095e9.1
        for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 09:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793464678; cv=none;
        d=google.com; s=arc-20260327;
        b=ksKARXqhHO6pBFs1HXqjjwF1bu9O3A2q0nr3T9vmuPSq+kFRSnnSs3wm5J0qw4Rowb
         tmjG3sawdG9G2n5Eb/K+jBPjnnW4AF/6ZIbjy10czgCRmCa0bK47siEvXCfw7LgaWQ5M
         wP3xbm5O4bgPITUtvVtCW/i96lbTESGZfGnzzYZIOTEp9/1Gzb4ZN67I058mDcbhpy2q
         0JgfBgA2N2aEYQs+4OOwP14F0zjnF5pXP26Y+awSGhUOLZXgcjYd17rFa7nvXtOyMere
         zg2XKD6tgnHeXFetMQG7DU3v9HAArCGBLfNhjozqY6HPhk/nxOl/nXKnEc3TZ1NOy7Vz
         11eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vq4vRllAgK6PadituL46LOg4X2pEj6tW413DrF/8Lj4=;
        fh=bjHf+2z2oC+bMN7uC08dBs1U1BbDpJx8k9Nn0fOy5RY=;
        b=JuU/jfAf65UwY/dArw/a+jksh11bkgYUNUcRVn69u/d/k4QbiUiCIAeCPaT9np0Ivz
         cd/Mu4UhmI3Ox+Yq0HMuDFAo37kLHQTC+3un7JivcEHq1KMhIi9mxXtSEEPdO5YInRlW
         FIFohgVW7qtSt0qZ8dC8V+60vYNPRZEfv2FuvZ1OpC6/sBdWYL07iq+u44kNKA3ohgUd
         cnJfOVwZgSv5LF69Vee4hN0aO02lOnSc78BLn5e+yL5pzl3kACfLkgPVuLu/V2xroFJr
         +e1RC3VL+AgrsNOU0tvQkes4F0/UopacDT1sTK4C0RZVojICNXfQnPDhzCt2HHQ+IJm0
         ePVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793464678; x=1794069478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vq4vRllAgK6PadituL46LOg4X2pEj6tW413DrF/8Lj4=;
        b=aQ66LJVHa45dKPfND15WpLhtZXSP12gQFKUFRmdpv04UfYxD5t4mm6VdojacX3Hdsc
         K3xS/9zxTc4kVjl/GEH6AxRamuHawPi2K0lLvuI7n8G6DXqMVteNa87oDeqgfU/I+qli
         BSRrus5eNIJgPMK1Jqp6aqBICcoeVNg080NS7sQw5I1tdob/d0ZU8SXalXfzYTJgHb7j
         x1hRdVLyWIQdHWJuWnUbGiksokchNqXDXb2DsK8+HIKAZJ4WqG/n72U7joGmKwfhBGxy
         vOexyE/+Ueb5ayaK/D+P2oG5vWGh+4ixhsoKvNpSbJaNiu39wWsaWfxaqzvbpJUb/845
         L27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793464678; x=1794069478;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vq4vRllAgK6PadituL46LOg4X2pEj6tW413DrF/8Lj4=;
        b=esWibtsEBSi7iw9TWx7LaHWju8ozpl/KV5uHBm84tPQHgJCJiDsXnlA3uKCFs7xPHR
         XuzFGMwHvIb/DS68c0Mb7lEAZtMfkeB6OvDbYedSYkEqxJj5dr7SB+4FDHsQDkEVKnCi
         Qo3RpdjcQvLgF448hhxuKA9xVa3ojpI7Tc0cUnaKDXvFXS7cF61FIog93vMHXXtoDJps
         anzu2Ogjdl/AZnuXJDIytr5+E6416Jdm2a0awry4I6d0WZY2z+o1WeBAEKILJg3twz1I
         IRjZ2YaYjAJCVtvTQBRmum4H28DEzT03KTyy+2t5PQgI+sDbZvwpIA35dnERonM9sOds
         /2Og==
X-Forwarded-Encrypted: i=1; AKwUvBwhI5hk/P78wnsgLJRV+CKF+EkRK9q04Erya5ZCRyMtP1dE3+Kz/gPOXeEXZKdxry7Q9QrNhRhPPnEUfg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIAAdrTwZ/LVhaoDK8M6hLFqRc+rv8Mv8JELIlneOb5khmpplb+
	IhcINp851hAdaL2VgvjmK2R9YFfgPTtW+LCSOwrGp5KF42fLj95P2NFR1E2P0CLqXp0IBZPs4lT
	CBEtd0pqyTtdx3BVU91163sa6oGNSXvkLA3cnKN7B
X-Gm-Gg: AYBFou1OanDsccpMamnbQ/Ev2EGPI+egZL51EcXH12bWf/CjHuaGG64fHxQ92+rtpqK
	Z2/bO1QU5Nu/Wgd7wok9t0zJOAAYOqmZjfb16eueXSjMOfjamfB7xmnRHkJy/liPx6PRJ0BDp/O
	Ger8KmIwgps2n2R2rE/gxT+kD4AEWD/DozlEIkJgh8WBLv1Uj9sFaDylSXSyJncP5UelK2VlZun
	Tm3wxyyF7C7CBE574d938tQsYZDeSrrlNUYXCbJvakxOfpVuwhBd4MddDkqOcVgcOrcSLFrx5AJ
	R+WRow3vfHrbIOaVppz3j6sjqzfYCpcfdjqqZysS47gn6pPL+26eCyCUP0M247HbC/3iHzoHhyL
	N7C1qLZ7RAia+a75UIMJsdctoeKe8tQS0q1EPGHQkaeNNT/0QqwvRsKHcmwLVtXri9NUN6M3Jy3
	EsuryqKU0UwVQBmz12Zw==
X-Received: by 2002:a05:600c:4e90:b0:4a2:526b:d410 with SMTP id
 5b1f17b1804b1-4ac17565fafmr135441625e9.13.1793464677281; Sat, 31 Oct 2026
 09:37:57 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk>
 <20261031152846.746656-1-sashal@kernel.org> <CAH5fLgiSOae48jr65rv6ynLWUhT7xVCjjCEK=9oKXvSxKpdq6g@mail.gmail.com>
 <20261031162931.792607-1-sashal@kernel.org>
In-Reply-To: <20261031162931.792607-1-sashal@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 31 Oct 2026 17:37:44 +0100
X-Gm-Features: AclHuK9n1IaeEszr_jQNYJo2v2No4a1cdwGVbESZzGLJe-RbL495VHIWXOSenUA
Message-ID: <CAH5fLgjpB1-hCkUhsFK7bEVYwz-N-obsoPoaCYA-BWMQ5MPTnQ@mail.gmail.com>
Subject: Re: [PATCH] rust: bindings: derive Zeroable for bindgen's opaque
 array wrappers
To: Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 5:29=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Sat, Oct 31, 2026 at 05:17:46PM +0100, Alice Ryhl wrote:
> >Is it possible to instead fix this by adding the impl of Zeroable in
> >rust/bindings/lib.rs, similar to this piece of code that we already
> >have:
> >
> >unsafe impl<Storage> Zeroable for __BindgenBitfieldUnit<Storage> where
> >Storage: Zeroable {}
>
> I looked at doing it that way, but the wrapper types don't always exist,
> so a fixed impl in lib.rs won't build everywhere:
>
>  - bindgen 0.71 and 0.72 (we still support 0.71.1) don't generate them
>    at all, the blob is a plain array there.
>
>  - 0.73 only emits the alignments a config actually needs. On x86_64,
>    allmodconfig gets __BindgenOpaqueArray, __BindgenOpaqueArray8,
>    __BindgenOpaqueArray64 and __BindgenOpaqueArray4096, but defconfig
>    with Rust enabled has no __BindgenOpaqueArray4096, so an impl for it
>    would break the build there.
>
> __BindgenBitfieldUnit works because it's always generated. We could do it
> in lib.rs with a Kconfig symbol for the bindgen version plus some way to
> know which alignments a config ends up with, but tagging the wrappers
> right after bindgen runs seemed simpler.

Fair enough!

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
