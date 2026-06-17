Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77743D668E
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688744; cv=pass; b=lBH6l9x6sJR+JUTcwZDI/X3OD+IrEtkYQl12GCSCaBcyG2JS/6vIJuayfAwVGNDTnxr/wC6vDLsQ0yiN4M+j2ieeLALuD6tDBaoQ4ME9x4YGaT63I3LPAqtgpBuCaLYI2ZSAvpagk3SOgcx6oEaWaSC2QeBkh1yFfUsJSSKDTck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688744; c=relaxed/simple;
	bh=CF2ikandtVIT1owgnKtwBk+vrwZcicDlI2rfdeet7vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSCQLOtCYTJbQctq5A8Br19nSl/C7p/O1tCytyHP4J6lXloNqort4FqC/Yq+n+nboQ9BNsyDx7XKWC3eo1Ck7HkuyecxF4Y+hgd/QSB9jt9SxqnnO7l/dB/9BxDRTX8+yrKmgEo9S8OYpd06fGYZFPDDZ0jSxKlDAeOymxL0T98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/8F5E0k; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/8F5E0k"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304d3d3d8f8so692981eec.2
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 02:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781688740; cv=none;
        d=google.com; s=arc-20240605;
        b=NaUr+twAhmY+Cc52jXL2a3EkEKOcTJIKyR8S7tf6X0mbuHUBDx9kwUu/4uJDWq3UCJ
         eKR4+TmxCW5Lcw84yRvvwUgtkhgSx7MLtlPKPzFwRbTL1fi0XereDc0gUEbynI4DmSGV
         95i5IRZwgEOPL65OAud+pIXGZyT3ejJhAGz4IvAdfckGByYYlz+zkW2RCgRy8geCuwt/
         U8c4tO/tQYRdWkrVa4WTWajl1ohogOV5CGEHRd0ogSfs1ZT28rRalFvA15VtJOMCe6zU
         +QZhO9sdcxqDqY2Bdt6v5AEiIWh6+PhrL8UIwEIc0JElljJT6CuQ3Iu9hlT/8njbJsTu
         Eypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+M2u0whYbtR605n6sG4R2CUdyrK3ztIkie7LjFmQ8N0=;
        fh=WxgW47aP/Ot+JfoEgZpsYUZLrcW8MNrjYJ7PyXL9ubM=;
        b=BR4rvSPOqRyf/ZwvurLmGQSG4q2WL1PCQk+UkxFUP6XMFi89idpKpGwQmcpt2cOyNU
         +UMLGzl04ouHVf65ClSS7dE6O29lBLyLqJM+zmrUBtxZIfm32sukNhBDesGd8N9c7X9N
         JwjabJasz4Lh+DtDj6keb7XQoqvZW9VJAQdccKOD6meJSLV895B0cTEo4PfZ+nZrg3u7
         fIBU6IKYJliGOrJxLZ5VI/phvLe75kpohDpRTBtQ/LO5NqLO/SJuPzgkxAhYYtLZ68TK
         uiOhD5zulF/E9wUUPo1VZp0x00OAeitVAS2ymZ+IPQW1H2fmQQp8QRvfLG/U2vfkeys4
         H21w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781688740; x=1782293540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M2u0whYbtR605n6sG4R2CUdyrK3ztIkie7LjFmQ8N0=;
        b=G/8F5E0kZfsdROR+CtlTQ2tv4rDzjWtyQN+AGYvPHtdr9XY9qy7UYwZE1hrPDkUVlk
         ATgkj26J9kqLtk56XA6FnHSy5L4k/dkUm5Ogh72X13Jzh1RHxgn2JXD65ndtA2rCz8d0
         puHq46jG+pIyQHrjzFiSizmniDMZKihAdr9cBWcU3w31jrTYmFyLqSOIOZVmEa3D9Yrz
         oy7Id0tibTmRPqxtOMp9lEFdq16zNzl/oZCWDJJck8B278PgjASTaFzbqH+qM5zNCwRO
         bce4fOM1lXvQj+PJRekDPQJFUJs6eT/2JuFqyf0tbhMswKLqMcAk75QDIf9QJhPOzNou
         qaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688740; x=1782293540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+M2u0whYbtR605n6sG4R2CUdyrK3ztIkie7LjFmQ8N0=;
        b=HaE7BXhQsjNWgax4i3NzQN6gqGm3QuS2wvnDf7gJlOVP16LJwbnmMF1dfZPqe/Fro6
         36Bb2R2uwVZe09ZAAwNxLL0pKEsDHWY/vJpUzXUDTo4mR3ozgK8fwknhR2uULbObyZjr
         2UDt1EVQwcwmxcbBqwXCD1Q9M357LzupCc2ize8wFKo74QuT7LP2YTqHDa2JzY0qMLH3
         3Azez+Et3qyT445llg8vsMrUt/ccUU5N0rH1vUZFO6VPYW+YI7VmeFFLYz1D+ReVnnka
         K59B/ViiQbYg+iAclBP/6hkPiqiqc47Mo4J8AVo56XfqqDXS9equ+dWRLrGff2aSADBr
         H4bA==
X-Forwarded-Encrypted: i=1; AFNElJ+I08oefoA846qsYDheP5VjVbk0Ps9k/ApJ68XBmMfUPW8U+34ochFCQmhoaYr/eZ88Fp5Mhdm+osbImA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxiJkIbGmGxlo40veFuWHmARgxHkZtlV26DT1Z8XRQAPsxqyaV
	Q2rAbMtLSFeu8wi/cVJjp1B3bPDMFD7ruIzXwZrysOmJEKyy8JytYSAzljqoNcmlA9GSARgYnEB
	y2mbxo3ziqHsmafoqiL7gVAd8lps3lwI=
X-Gm-Gg: AfdE7ckQMjkoCDP3jy2Pkcd4q/nvfHwmvCKEQTchHTWO151q4sr0VIPxfuqzRv6W0CV
	SYodBTI2IvUwe8LOvgToeQmcBRTRsqpz/eYXm9ti/Kfoeg2aAb7Td4/2RTZ+4UB5udqO1bcmnxd
	yBoK2LpDU8ttlFA0KYtjCL1N6mpIKc6j5UtABT8uz8qs5GGuvDWqEInFQr6vJjhjdv+P2KjWoOw
	XjpaHRUAUu1FEvii/YEPCJl0ftEKnKQDIGOfXFvOwMm3SsTW8LMj1WcoIGPR2eZX+hLZQfweafx
	0DYD0vW4faZeAZ1U5/zaiyQRclRf/JYTbIZVOf/oNy1EfF2TjK+xW/6umRNbcxyAzIHMT2tCtfy
	aQekNoZWS1/D+
X-Received: by 2002:a05:7301:100b:b0:304:c73b:79ea with SMTP id
 5a478bee46e88-30bc9f179cbmr752260eec.3.1781688739625; Wed, 17 Jun 2026
 02:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
 <CANiq72=RX5V6W+1tj0GHxZusrk5OqYbZ5-xV=wvSssrx_CWXAA@mail.gmail.com> <75552e2d-0bc8-40a0-b783-fba64482aea9@gmail.com>
In-Reply-To: <75552e2d-0bc8-40a0-b783-fba64482aea9@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 17 Jun 2026 11:32:04 +0200
X-Gm-Features: AVVi8Ce2KN7fJSDwAaIQQF6892I0cepUA61wd2hQu8bQ0ZSAIWDKWJ48saLTpEg
Message-ID: <CANiq72=fUuX7fF1=AQ12ahYHwW7k2i28Hkpo0TtUhwV7qeojQQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add procedural macro for declaring configfs attributes
To: Malte Wechter <maltewechter@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 11:13=E2=80=AFAM Malte Wechter <maltewechter@gmail.=
com> wrote:
>
> As of now doc strings are not generated for private items in the macros
> crate. I am moving the `parse_ordered_fields!` macro into
> macros/helpers.rs but this means the doc strings are not generated for
> the macro anymore. The `parse_ordered_fields!` macro is a larger helper
> function, and the doc strings are relevant and helpful for macro
> developers that wants to use it.

If it is private, then it is what it is, don't worry about it --
developers can still read the source code.

But, yes, having a render of the private items is something I have
wanted for a long time, but as a runtime toggle, so that it is easy to
go from one to the other (and without having to have 2 entire copies
of the docs).

Please the entry "Private documentation (perhaps as an extension of
the private items/fields toggle)" I have at:

  https://github.com/Rust-for-Linux/linux/issues/350

Upstream `rustdoc` implemented an MVP of the idea via CSS/JS in this draft =
PR:

  https://github.com/rust-lang/rust/pull/141299

If you want to help on that, then you could try it and leave some
feedback there! :)

Thanks!

Cheers,
Miguel
