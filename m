Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35336CDE7
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454758; cv=pass; b=Sjn+J68FIwD7OfnFEue5p81LUoqTcRUk7fzx92biPWRpNK7MapbUGkTnTBlvxW/GFofpbGH0IHSTD6+5H6Oz9tGPcSxtWQXVwQzRBXGTXr1Wg5ex5Fg2ayx7x2rm9vVab8XzEls7SozDOS7zBQs6XWvZ19lbNKkO1nckZ/vTTbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454758; c=relaxed/simple;
	bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWd+XDCSd2MP+WTvR0hWVcFQtNmsmWpG6Hf43wxoRBgx2cbPBbibltxEd5XYMZJPHlJe2rqHCb22ty6PxZotq6OjNUH8lQjfcGdQfWPUqqcAldaMWkZQvob6AYDcxLgc7s3zXxGIHnv13wRMyectLRDd5QJ2Z/oFXwMuz+glx/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtoUIMmv; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtoUIMmv"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdff6c15a5so57996eec.3
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 04:32:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772454757; cv=none;
        d=google.com; s=arc-20240605;
        b=kLC9kx5bqi9zWtubCta0wJR3Mtt6v1LMUuBHxlZM4KYXgrQ6jcuFCc+FgQJDWgyq/X
         wRbxo/nBZhvXdZ/rBHDjgnENaEIX2dveUTxtUWye3yTx0keEawvrvPOK9Ll+BLTraUrJ
         qgEx/SQxKqygZhsh8k68p8uc7c7ODNEyBblpGSx+Zp7feTThdyWVJgVN37jA5WiT4nh7
         So/gWlAuzRfP+axcTmUWYCNuX6ZJVUezu2Uicqok/DD1iF+uSKvNglxUuHdKWUDhdXpA
         nNDv4jGrYhALZMGg46RlRsWtHAsZLY4pUPfe/guiSNIjFJJU2TeLRCnxejkXLAxL463+
         3gWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        fh=+CWJke1OxTdpDqTlVfaCQG/HfnEeOVb2i02DL7MepDs=;
        b=QE01etLYAJ2pyhQbCjySUCnryinkR8QIhis5Zv77k4aLNud6z8buEH1RTDpUMqdSJ5
         tv6BfEYzUvdkjM7/5mYcw4jZv49h7ZqjfC5q7G4C01a0z41btdIns105I14CjBw5v6l2
         vkmGxSuD8Nh99sJFqxi16sqkTznCApgA+eQOOzoFXywXCtEiZT2O3ZJHZJcgrHpp/k79
         XVUsYVU2MyhpL/ouZ4aVi5mx1dCSNChCGzWTVSVfbCMg7WH+tFmHL1yltaxJKo3g6a8r
         IlH2lrQBLqZfSJM3O2LjGtoEAMZZyBNxVtExNSBkXJW1tcg5iJW4YNSKPitqIK0gVUk5
         6o6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454757; x=1773059557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        b=KtoUIMmvcT9a1/mJwfhsK4ojPgzcyjaxTFsEcYoZHNxa9cIO7JLI8+2vzY7sr6IXWs
         INDCyzwkjX7MYDdtmfTXbb5lNbJJyUd8EAH+GUZn1TLJlwfVj3XfqpdzLvewFUhWegbJ
         houyxh19vsOHE3ucUTuT46UASQcLmznDmqjYrOFDtNM4GdWzVpPFJaAnG+iJTZcL5I6+
         43i7B8ennRgMwdU1GhdIbMex7AT/IqbwGF5F6KAHYkjL+3inuUfXyYPZ2WU77m7wvmrV
         tX0DqNdR/hSNUqoZYQjeE3p3Usu63AK42R4NCObpWHhSI0UjKEhpWhjgROxcziVYmWdo
         5M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454757; x=1773059557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        b=GjboLBtLfY0aiDG8FKVKIa9TMR6bH1WUc5igrhdJ2LM8ENuhgPuzendEb4lYIBkJ2x
         EUy9uHRPAsplr2hRoN9OOTa1rjQAO8+sP3aqfkwD+8i9qdbi6HU0HZDPAsxdIJ0q6aT4
         6HX9gAkmJxyY4wTgeKDAlrT69NmEzdvVR/hjSWhvKn3D8NBbiCHfJO03lcNudIsDpbpd
         nX6aEKf03dEGegrfc01zwNQuav3nk3V9FvTqnw0binNwXEZxlecPpTf7rekFah8WqP+o
         exz8jhQWZzYg8Qnun4D4NxMB3jyp7Czj7Ir8b3xljab0tuPCPXutNeC5CJmUFNYXqGLl
         04Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUrw+Wn9f8Xc/JAC3uURoVMAvwzIZ4JgIvT+/VNEyrXExYiQsDltbCQ403RA9EytsycCkPtfGeVPbhraA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDjVX8MD9vo3V/cpkAAfFUc4VVYADDCxgMp25FH1u8jdLlTK8
	OUvRPBZa9vDkvXZBGLX4We4Zmv04jd7X9L2ZIUqaxAF2ZN9mlIvC4lk3wGBX6w3sbpkAjlfF7Ax
	fw2gNml+UlIElWLiGaiNeznDUIg3QQdo=
X-Gm-Gg: ATEYQzxrogswPD3py/kZi0CI6yW5YKVqcM1/vdR4vJCZgGjnLrskuOo7m8GZACEQ0yG
	BgJTGSMrdpC0G5ag8UqYCNwveNVVgWPpDzDE8dDQNBUl/pQ4D7o/AjZoYK08X1Z1t/Dd3nPSBOr
	mCVul7FWcFrnLHnXETGgpKQKQP47ep3U4Lvacc39Zoo/wIYemY+kKXMo2GZga4FVhN62l/vsLvU
	vGkYbe7jloTU9XxzLcIW7ieVHhHSeFaUTbl8qNUMNinm5lNSDeyU5udfnnXLB8KDqEVUahdK09n
	bPRDe6o9D7PEqKouDjnuDG6qdhSh2o4yw5c6mty1tRgK+iqmokeUSANomvqDq70kiyKOYjfV5Be
	8QnKrO+qxDqYXmMptBsKh/416440b
X-Received: by 2002:a05:7301:128f:b0:2be:1946:8576 with SMTP id
 5a478bee46e88-2be19468a7cmr221836eec.4.1772454756603; Mon, 02 Mar 2026
 04:32:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
 <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org> <eeDADnWQGSX9PG7jNOEyh9Z-iXlTEy6eK8CZ-KE7UWlWo-TJy15t_R1SkLj-Zway00qMRKkb0xBdxADLH766dA==@protonmail.internalid>
 <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net> <87ldgbbjal.fsf@t14s.mail-host-address-is-not-set>
 <DGROXQD756OU.T2CRAPKA2HCB@garyguo.net> <DGRPNLWTEQJG.27A17T7HREAF4@kernel.org>
 <p7rsBPaYxHKSMFCYVUFY5hdI1H6jxHK0s7lxLQkqH4rylM6yS03Yt52SCjiTO5qBVUmc41ZHZ7XZ0_3w_U-O0g==@protonmail.internalid>
 <DGRQNTVD3N23.33347CYLKMKEH@garyguo.net> <87ikbebsx4.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87ikbebsx4.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Mar 2026 13:32:24 +0100
X-Gm-Features: AaiRm52T7cw5MIQan-WghpnUecgDLtb8HLJUgWIjNNPX7ugGbu9wZy-93BfirNw
Message-ID: <CANiq72k_c06P4_JVDCNmwu8SwCUP3UjofLCAsovBVzQi=fb6CA@mail.gmail.com>
Subject: Re: [PATCH v16 01/10] rust: alloc: add `KBox::into_nonnull`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 8:19=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> I was thinking something similar, in clippy or checkpatch.pl. If we
> should always have this attribute for small functions, we need to have a
> check.

No, as Gary said, we do not always want to have it.

So something trivial in `checkpatch.pl` or something like the existing
Clippy lint would have quite bad false positives (and even false
negatives, in the case of `checkpatch.pl`, depending on what logic you
are thinking about).

We would need cross-TU heuristics for this, because at the end of the
day what you are trying to say is "this function will end up being
trivial even if it may look like it doesn't before inlining
everything".

Cheers,
Miguel
